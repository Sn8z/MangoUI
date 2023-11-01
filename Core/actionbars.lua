local _, mUI = ...
local oUF = mUI.oUF
local LSM = LibStub("LibSharedMedia-3.0")

local GetActionCooldown, IsUsableAction = GetActionCooldown, IsUsableAction

local _, class = UnitClass("player")
local playerColor = oUF.colors.class[class]

function mUI:BlockActionbarAnimations()
	local ActionBarAnimationEvents = {
		"UNIT_SPELLCAST_INTERRUPTED",
		"UNIT_SPELLCAST_SUCCEEDED",
		"UNIT_SPELLCAST_FAILED",
		"UNIT_SPELLCAST_START",
		"UNIT_SPELLCAST_STOP",
		"UNIT_SPELLCAST_CHANNEL_START",
		"UNIT_SPELLCAST_CHANNEL_STOP",
		"UNIT_SPELLCAST_RETICLE_TARGET",
		"UNIT_SPELLCAST_RETICLE_CLEAR",
		"UNIT_SPELLCAST_EMPOWER_START",
		"UNIT_SPELLCAST_EMPOWER_STOP",
	}

	for _, events in ipairs(ActionBarAnimationEvents) do
		ActionBarActionEventsFrame:UnregisterEvent(events)
	end
end

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
		SpellFlyout.Background:SetAlpha(0)
		local flyoutBtnIndex = 1
		local function checkForFlyoutButtons()
			local button = _G['SpellFlyoutButton' .. flyoutBtnIndex]
			while button do
				StyleButton(button)
				flyoutBtnIndex = flyoutBtnIndex + 1
				button = _G['SpellFlyoutButton' .. flyoutBtnIndex]
			end
		end

		SpellFlyout:HookScript('OnShow', checkForFlyoutButtons)
		SpellFlyout:HookScript('OnHide', checkForFlyoutButtons)

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
		local PushedTexture = Button.PushedTexture
		local Highlight = Button.HighlightTexture
		local CheckedTexture = Button.CheckedTexture
		local Background = Button.SlotBackground
		local Border = Button.Border
		local NewActionTexture = Button.NewActionTexture
		local SpellHighlightTexture = Button.SpellHighlightTexture
		local QuickKeybindHighlightTexture = Button.QuickKeybindHighlightTexture
		local Icon = Button.icon
		local Cooldown = Button.cooldown

		local borderSize = 2

		Mixin(Button, BackdropTemplateMixin)
		Button:SetBackdrop({
			bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
			edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
			edgeSize = borderSize
		})
		Button:SetBackdropColor(0, 0, 0, 0.7)
		Button:SetBackdropBorderColor(0, 0, 0, 1)

		-- Background
		if Background then
			Background:SetTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
			Background:SetVertexColor(0, 0, 0, 0)
			Background:SetDrawLayer("BACKGROUND", 0)
		end

		-- Normal border texture
		if NormalTexture then
			NormalTexture:SetTexture([[Interface\AddOns\MangoUI\Media\debuffoverlay.tga]])
			NormalTexture:SetVertexColor(0, 0, 0, 0)
			NormalTexture:SetSize(Button:GetWidth(), Button:GetHeight())
		end

		-- Pushed border texture
		if PushedTexture then
			PushedTexture:SetTexture([[Interface\AddOns\MangoUI\Media\highlight.tga]])
			PushedTexture:SetVertexColor(0.6, 0.6, 0.6, 1)
			PushedTexture:SetPoint("TOPLEFT", borderSize, -borderSize)
			PushedTexture:SetPoint("BOTTOMRIGHT", -borderSize, borderSize)
		end

		-- Checked border texture
		if CheckedTexture then
			CheckedTexture:SetTexture([[Interface\AddOns\MangoUI\Media\debuffoverlay.tga]])
			CheckedTexture:SetVertexColor(0.1, 0.8, 0.1, 0.8)
			CheckedTexture:SetPoint("TOPLEFT", borderSize, -borderSize)
			CheckedTexture:SetPoint("BOTTOMRIGHT", -borderSize, borderSize)
		end

		-- Highlight texture
		if Highlight then
			Highlight:SetTexture([[Interface\AddOns\MangoUI\Media\highlight.tga]])
			Highlight:SetVertexColor(0.8, 0.8, 0.8, 0.8)
			Highlight:SetPoint("TOPLEFT", borderSize, -borderSize)
			Highlight:SetPoint("BOTTOMRIGHT", -borderSize, borderSize)
		end

		-- Border texture
		if Border then
			Border:SetTexture([[Interface\AddOns\MangoUI\Media\highlight.tga]])
			Border:SetPoint("TOPLEFT", borderSize, -borderSize)
			Border:SetPoint("BOTTOMRIGHT", -borderSize, borderSize)
		end

		-- New action texture
		if NewActionTexture then
			NewActionTexture:SetTexture([[Interface\AddOns\MangoUI\Media\highlight.tga]])
			NewActionTexture:SetPoint("TOPLEFT", borderSize, -borderSize)
			NewActionTexture:SetPoint("BOTTOMRIGHT", -borderSize, borderSize)
		end

		-- Spell highlight texture
		if SpellHighlightTexture then
			SpellHighlightTexture:SetTexture([[Interface\AddOns\MangoUI\Media\highlight.tga]])
			SpellHighlightTexture:SetPoint("TOPLEFT", borderSize, -borderSize)
			SpellHighlightTexture:SetPoint("BOTTOMRIGHT", -borderSize, borderSize)
		end

		-- Quick keybind highlight texture
		if QuickKeybindHighlightTexture then
			QuickKeybindHighlightTexture:SetTexture([[Interface\AddOns\MangoUI\Media\highlight.tga]])
			QuickKeybindHighlightTexture:SetPoint("TOPLEFT", borderSize, -borderSize)
			QuickKeybindHighlightTexture:SetPoint("BOTTOMRIGHT", -borderSize, borderSize)
		end

		-- Hide the icon mask
		Button.IconMask:SetShown(false)

		-- Reposition the cooldown frame
		Cooldown:ClearAllPoints()
		Cooldown:SetPoint("TOPLEFT", borderSize, -borderSize)
		Cooldown:SetPoint("BOTTOMRIGHT", -borderSize, borderSize)

		-- Zoom the spell icon to remove default borders
		Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		Icon:SetDrawLayer("BACKGROUND", 1)
	end

	function UpdateHotkeys(Button)
		local HotKey = Button.HotKey
		local Macro = Button.Name
		local Count = Button.Count
		HotKey:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 16, "OUTLINE")
		HotKey:SetAlpha(1)
		Macro:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 12, "OUTLINE")
		Macro:SetAlpha(0)
		Count:SetFont(LSM:Fetch("font", mUI.profile.settings.font), 18, "OUTLINE")
		Count:SetAlpha(1)
		Count:SetTextColor(playerColor.r, playerColor.g, playerColor.b)
	end

	local actionbarEventFrame = CreateFrame("Frame")
	actionbarEventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	actionbarEventFrame:RegisterEvent("UPDATE_BINDINGS")
	actionbarEventFrame:SetScript("OnEvent", Init)
	EditModeManagerFrame:HookScript('OnHide', Init)

	-- Desaturate cooldowns
	local function darken(Button)
		local Icon = Button.icon
		local Action = Button.action

		if not Action then return end
		local _, duration, _ = GetActionCooldown(Action)

		if duration >= 1.5 then
			Icon:SetDesaturated(true)
			Icon:SetVertexColor(0.8, 0.8, 0.8)
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
		if self.timer >= 0.2 then
			for i = 1, #Buttons do
				darken(Buttons[i])
			end
		end
	end

	local darkenCooldownEventFrame = CreateFrame('Frame')
	darkenCooldownEventFrame.timer = 0
	darkenCooldownEventFrame:HookScript("OnUpdate", updateCooldowns)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
	if mUI.profile.settings.actionbars.enabled then
		mUI:EnableActionbars()
	end

	if not mUI.profile.settings.actionbars.animations then
		mUI:BlockActionbarAnimations()
	end
end)
