local _, mUI = ...
local oUF = mUI.oUF

local function GetUnitStatus(unit)
	if not UnitIsConnected(unit) then
		return "OFFLINE"
	elseif UnitIsGhost(unit) then
		return "GHOST"
	elseif UnitIsAFK(unit) then
		return "AFK"
	elseif UnitIsDead(unit) then
		return "DEAD"
	end
end

oUF.Tags.Methods['mango:status'] = function(unit)
	local status = GetUnitStatus(unit)
	if status then
		return status
	end
end

oUF.Tags.Events['mango:status'] = 'UNIT_CONNECTION PLAYER_FLAGS_CHANGED UNIT_HEALTH'

oUF.Tags.Methods['mango:name'] = function(unit)
	local color = { 1, 1, 1 }
	if UnitIsPlayer(unit) and mUI.profile.settings.dark then
		color = mUI:GetClassColor(unit)
	end

	return format('|cff%02x%02x%02x%s|r', (color[1] or 1) * 255, (color[2] or 1) * 255, (color[3] or 1) * 255,
		UnitName(unit))
end

oUF.Tags.Events['mango:name'] = 'UNIT_NAME_UPDATE UNIT_FACTION UNIT_CLASSIFICATION_CHANGED'

local function PrettifyValue(value)
	local suffixes = { "", "K", "M", "B", "T" }
	local suffix_idx = 1
	while value >= 1000 and suffix_idx < #suffixes do
		value = value / 1000
		suffix_idx = suffix_idx + 1
	end

	local formattedValue = ""
	if math.floor(value) == value then
		formattedValue = string.format("%d", value)
	else
		formattedValue = string.format("%.1f", value)
	end
	return formattedValue .. suffixes[suffix_idx]
end

oUF.Tags.Methods['mango:hp'] = function(unit)
	local number = tonumber(UnitHealth(unit))
	if not number then return tostring(UnitHealth(unit)) end
	return PrettifyValue(number) .. " | " .. math.floor(UnitHealth(unit) / UnitHealthMax(unit) * 100 + .5) .. "%"
end

oUF.Tags.Events['mango:hp'] = 'UNIT_HEALTH UNIT_MAXHEALTH'

oUF.Tags.Methods['mango:power'] = function(unit)
	local cur = UnitPower(unit)
	local max = UnitPowerMax(unit)
	if (UnitPowerType(unit) == 0) then
		return floor(cur / max * 100) .. "%"
	else
		return cur
	end
end

oUF.Tags.Events['mango:power'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER UNIT_DISPLAYPOWER'

oUF.Tags.Methods['mango:absorbs'] = function(unit)
	local absorbs = UnitGetTotalAbsorbs(unit)
	if absorbs > 0 then
		return PrettifyValue(absorbs)
	end
end

oUF.Tags.Events['mango:absorbs'] = 'UNIT_ABSORB_AMOUNT_CHANGED'

oUF.Tags.Methods['mango:group'] = function(unit)
	if not UnitInRaid(unit) then return end
	for i = 1, GetNumGroupMembers() do
		local name, _, subGroup = GetRaidRosterInfo(i)
		if (name == UnitName(unit)) then
			return subGroup
		end
	end
end

oUF.Tags.Events['mango:group'] = 'GROUP_ROSTER_UPDATE'
