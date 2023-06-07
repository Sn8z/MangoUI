local _, mUI = ...
local oUF = mUI.oUF

local function PrettifyValue(value)
	local suffixes = { "", "K", "M", "B", "T" }
	local suffix_idx = 1
	while value >= 1000 and suffix_idx < #suffixes do
		value = value / 1000
		suffix_idx = suffix_idx + 1
	end
	return string.format("%.1f%s", value, suffixes[suffix_idx])
end

local function GetUnitStatus(unit)
	if not UnitIsConnected(unit) then
		return "Offline"
	elseif UnitIsGhost(unit) then
		return "Ghost"
	elseif UnitIsAFK(unit) then
		return "Away"
	elseif UnitIsDead(unit) then
		return "Dead"
	end
end

oUF.Tags.Methods['mango:hp'] = function(unit)
	local status = GetUnitStatus(unit)
	if status then
		return status
	else
		local number = tonumber(UnitHealth(unit))
		if not number then return tostring(UnitHealth(unit)) end
		return PrettifyValue(number).." | "..math.floor(UnitHealth(unit) / UnitHealthMax(unit) * 100 + .5).."%"
	end
end

oUF.Tags.Events['mango:hp'] = 'UNIT_CONNECTION PLAYER_UPDATE_RESTING UNIT_HEALTH UNIT_MAXHEALTH PLAYER_FLAGS_CHANGED'

oUF.Tags.Methods['mango:pp'] = function(unit)
	local cur = UnitPower(unit)
	local max = UnitPowerMax(unit)
	if (UnitPowerType(unit) == 0) then
		return floor(cur / max * 100)
	else
		return cur
	end
end

oUF.Tags.Events['mango:pp'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER UNIT_DISPLAYPOWER'

oUF.Tags.Methods['mango:absorbs'] = function(unit)
	local absorbs = UnitGetTotalAbsorbs(unit)
	if absorbs > 0 then
		return PrettifyValue(absorbs)
	end
end

oUF.Tags.Events['mango:absorbs'] = 'UNIT_ABSORB_AMOUNT_CHANGED'

