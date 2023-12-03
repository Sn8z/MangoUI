local _, mUI = ...
local oUF = mUI.oUF
-- Thanks to Phanx for the initial inspiration to this solution

local originalEnv, configEnv
local frames = oUF.objects

local powerTypes = {
	Enum.PowerType.Mana,
	Enum.PowerType.Rage,
	Enum.PowerType.Focus,
	Enum.PowerType.Energy
}

local function createConfigEnv()
	if configEnv then return end
	local customEnv = {
		UnitPower = function(unit, displayType)
			local maxPower = UnitPowerMax(unit, displayType) or 0
			return random(1, (maxPower > 0 and maxPower) or 100)
		end,
		UnitPowerType = function(arg1)
			return powerTypes[random(1, #powerTypes)]
		end,
		UnitHealth = function(unit)
			local maxHealth = UnitHealthMax(unit)
			return maxHealth and math.random(1, maxHealth) or 1
		end,
		UnitGetTotalHealAbsorbs = function(unit)
			return random(10000, 250000)
		end,
		UnitGetIncomingHeals = function(unit)
			return random(10000, 250000)
		end,
		UnitGetTotalAbsorbs = function(unit)
			return random(10000, 250000)
		end,
		UnitStagger = function(unit)
			return random(0, UnitHealthMax("player"))
		end,
		UnitAffectingCombat = function()
			return true
		end,
		UnitIsGroupLeader = function()
			return true
		end,
		UnitHasIncomingResurrection = function()
			return true
		end,
		UnitIsPVP = function(unit)
			return true
		end,
		UnitIsDND = function(unit)
			return true
		end,
		UnitIsAFK = function(unit)
			return true
		end,
		GetReadyCheckStatus = function(unit)
			return random(1, 3)
		end,
		GetRaidTargetIndex = function(unit)
			return random(1, 8)
		end,
	}

	configEnv = setmetatable(customEnv, {
		__index = customEnv,
		__newindex = function(tbl, key, value) customEnv[key] = value end,
	})
end

local function enableConfigEnv()
	originalEnv = {}
	for func, env in pairs(configEnv) do
		originalEnv[func] = _G[func]
		_G[func] = function(...) return env(...) end
	end
end

local function disableConfigEnv()
	for func, env in pairs(originalEnv) do
		_G[func] = env
	end
	originalEnv = nil
end

local function toggle(frame)
	if frame._realUnit then
		frame:SetAttribute("unit", frame._realUnit)
		frame._realUnit = nil
	else
		frame._realUnit = frame:GetAttribute("unit") or frame.unit
		frame:SetAttribute("unit", "player")
	end
end

function mUI:ToggleFrames()
	if InCombatLockdown() then
		print("Can't toggle frames in combat.")
	else
		createConfigEnv()

		if originalEnv then
			disableConfigEnv()
		else
			enableConfigEnv()
		end

		for _, frame in pairs(frames) do
			toggle(frame)
		end
	end
end

SLASH_MANGOTEST1, SLASH_MANGOTEST2 = "/mtest", "/mangotest"
SlashCmdList["MANGOTEST"] = mUI.ToggleFrames
