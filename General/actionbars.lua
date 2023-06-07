local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local GetActionCooldown = GetActionCooldown
local IsUsableAction = IsUsableAction

function mUI:EnableActionbars()

	local Bars = {
		_G["MultiBarBottomLeft"],
		_G["MultiBarBottomRight"],
		_G["MultiBarRight"],
		_G["MultiBarLeft"],
		_G["MultiBarRight"],
		_G["MultiBar5"],
		_G["MultiBar6"],
		_G["MultiBar7"],
	}

	local Buttons = {}

	function Init()
		for j = 1, #Bars do
			local Bar = Bars[j]
			if Bar then
				for i = 1, Bar.numButtonsShowable do
					local Name = Bar:GetName()
					local Button = _G[Name .. "Button" .. i]
					StyleButton(Button)
					UpdateHotkeys(Button)
					table.insert(Buttons, Button)
				end
			end
		end

		for i = 1, _G["MainMenuBar"].numButtonsShowable do
			local Button = _G["ActionButton" .. i]
			StyleButton(Button)
			UpdateHotkeys(Button)
			table.insert(Buttons, Button)
		end

		for i = 1, 10 do
			local StanceButton = _G["StanceButton" .. i]
			local PetButton = _G["PetActionButton" .. i]
			StyleButton(StanceButton)
			StyleButton(PetButton)
			UpdateHotkeys(StanceButton)
			UpdateHotkeys(PetButton)
			table.insert(Buttons, StanceButton)
			table.insert(Buttons, PetButton)
		end
	end

	function StyleButton(Button)
		local NormalTexture = Button.NormalTexture
		local Icon = Button.icon
		local Cooldown = Button.cooldown
		NormalTexture:SetDesaturated(true)
		NormalTexture:SetVertexColor(0.35, 0.35, 0.35, 0.9)
		Cooldown:ClearAllPoints()
		Cooldown:SetPoint("TOPLEFT", Button, "TOPLEFT", 1, -2)
		Cooldown:SetPoint("BOTTOMRIGHT", Button, "BOTTOMRIGHT", -2, 2)
		Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	function UpdateHotkeys(Button)
		local HotKey = Button.HotKey
		local Macro = Button.Name
		local Count = Button.Count
		HotKey:SetFont(LSM:Fetch("font", mUI.config.defaultFont), 16, "OUTLINE")
		Macro:SetFont(LSM:Fetch("font", mUI.config.defaultFont), 12, "OUTLINE")
		Count:SetFont(LSM:Fetch("font", mUI.config.defaultFont), 12, "OUTLINE")
		HotKey:SetAlpha(1)
		Macro:SetAlpha(0)
	end

	local EventFrame = CreateFrame("Frame")
	EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	EventFrame:RegisterEvent("UPDATE_BINDINGS")
	EventFrame:SetScript("OnEvent", Init)

	-- Desaturate cooldowns
	local function darken(Button)
		local Icon = Button.icon
		local Action = Button.action

		if not Action then return end
		local _, duration, _ = GetActionCooldown(Action)

		if duration >= 1.5 then
			Icon:SetDesaturated(true)
			Icon:SetVertexColor(0.6, 0.6, 0.6)
		elseif IsUsableAction(Action) then
			Icon:SetDesaturated(false)
			Icon:SetVertexColor(1, 1, 1)
		else
			Icon:SetDesaturated(false)
			Icon:SetVertexColor(0.4, 0.4, 0.4)
		end
	end

	local function updateCooldowns(self, elapsed)
		self.timer = self.timer + elapsed
		if self.timer >= 0.1 then
			for i = 1, #Buttons do
				darken(Buttons[i])
			end
		end
	end

	local GreyEventFrame = CreateFrame('Frame')
	GreyEventFrame.timer = 0
	GreyEventFrame:HookScript("OnUpdate", updateCooldowns)
end

--mUI:EnableActionbars()