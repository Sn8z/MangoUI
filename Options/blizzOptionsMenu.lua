local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local CreateFrame, GetAddOnMetadata = CreateFrame, C_AddOns.GetAddOnMetadata

-- local function RegisterSettings()
-- 	local frame = CreateFrame("Frame")
-- 	local background = frame:CreateTexture()
-- 	background:SetAllPoints(frame)

-- 	local titleText = frame:CreateFontString(nil, "OVERLAY")
-- 	titleText:SetPoint("TOP", frame, "TOP", 0, -10)
-- 	titleText:SetFont(LSM:Fetch("font", "Onest Semi Bold"), 20, "THINOUTLINE")
-- 	titleText:SetTextColor(1, 1, 1, 1)
-- 	titleText:SetText("Mango|cff00aa00U|r|cffaa0000I|r")

-- 	local versionText = frame:CreateFontString(nil, "OVERLAY")
-- 	versionText:SetPoint("TOP", titleText, "BOTTOM", 0, -10)
-- 	versionText:SetFont(LSM:Fetch("font", "Onest Semi Bold"), 12, "THINOUTLINE")
-- 	versionText:SetTextColor(0.8, 0.8, 0.8, 1)
-- 	versionText:SetText(GetAddOnMetadata(addonName, "version"))

-- 	local button = mUI:CreateButton(120, 30, "Settings", frame, function()
-- 		mUI:ToggleOptions()
-- 	end)
-- 	button:SetPoint("TOP", versionText, "BOTTOM", 0, -50)

-- 	local infoText = frame:CreateFontString(nil, "OVERLAY")
-- 	infoText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 10, 10)
-- 	infoText:SetFont(LSM:Fetch("font", "Onest Semi Bold"), 12, "THINOUTLINE")
-- 	infoText:SetTextColor(0.7, 0.7, 0.7, 1)
-- 	infoText:SetText(
-- 		"You can also type |cff00aa00/mango|r, |cffffa500/mui|r or |cffaa00aa/mangoui|r to open the settings menu.")

-- 	local category, layout = Settings.RegisterCanvasLayoutCategory(frame, addonName)
-- 	Settings.MUI_CATEGORY_ID = category:GetID()
-- 	Settings.RegisterAddOnCategory(category)
-- end

-- local function RegisterSettings()
-- 	local panel = CreateFrame("Frame", "MangoUISettings")
-- 	panel.name = "MangoUI";

-- 	-- panel.okay = function(self)
-- 	-- 	Settings.Save()
-- 	-- 	mUI:ToggleOptions()
-- 	-- end

-- 	-- panel.cancel = function(self)
-- 	-- 	mUI:ToggleOptions()
-- 	-- end

-- 	local category, layout = Settings.RegisterVerticalLayoutCategory(panel, addonName)
-- 	Settings.MUI_CATEGORY_ID = category:GetID()
-- 	Settings.RegisterAddOnCategory(category)
-- end

-- SettingsRegistrar:AddRegistrant(RegisterSettings)

local function createSubCategory(category, name)
	return Settings.RegisterVerticalLayoutSubcategory(category, name)
end

local function onSettingChanged(setting, value)
	print("Setting changed:", setting:GetVariable(), value)
end

local function createSetting(category, variable, db, default, title)
	local uniqueKey = tostring(db) .. "-" .. variable -- Create unique key for settings
	return Settings.RegisterAddOnSetting(category, uniqueKey, variable, db, type(default), title, default)
end

local function createButton(layout, title, buttonText, buttonClick, tooltip)
	local data = { name = title, buttonText = buttonText, buttonClick = buttonClick, tooltip = tooltip }
	local initializer = Settings.CreateElementInitializer("SettingButtonControlTemplate", data)
	layout:AddInitializer(initializer)
end

local function createCheckbox(category, options)
	local setting = createSetting(category, options.variable, options.db, options.default, options.title)
	setting:SetValueChangedCallback(options.func or onSettingChanged)
	Settings.CreateCheckbox(category, setting, options.title)
end

local function createSlider(category, options)
	local setting = createSetting(category, options.variable, options.db, options.default, options.title)
	setting:SetValueChangedCallback(options.func or onSettingChanged)
	local sliderOptions = Settings.CreateSliderOptions(options.min, options.max, options.step)
	sliderOptions:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value)
		return string.format("%.1f", value)
	end)
	Settings.CreateSlider(category, setting, sliderOptions, options.title)
end

local function createDropdown(category, options)
	local setting = createSetting(category, options.variable, options.db, options.default, options.title)
	setting:SetValueChangedCallback(options.func or onSettingChanged)
	local dropdownOptions = function()
		local container = Settings.CreateControlTextContainer()
		local dropdownOptions = options.options
		for _, v in next, dropdownOptions do
			container:Add(v, v)
		end
		return container:GetData()
	end
	Settings.CreateDropdown(category, setting, dropdownOptions, options.title)
end

local function RegisterSettings()
	local category, layout = Settings.RegisterVerticalLayoutCategory("Mango UI")
	category.name = "Mango UI"
	mUI.category = category -- Save for later use
	Settings.RegisterAddOnCategory(category)
	Settings.MUI_CATEGORY_ID = category:GetID()


	-- TODO: Get defaults from correct place
	createCheckbox(category, {
		["variable"] = "smooth",
		["db"] = mUI.profile.settings,
		["default"] = false,
		["title"] = "Smooth Bars"
	})

	createCheckbox(category, {
		["variable"] = "dark",
		["db"] = mUI.profile.settings,
		["default"] = true,
		["title"] = "Dark mode"
	})

	createCheckbox(category, {
		["variable"] = "minimap",
		["db"] = mUI.profile.settings,
		["default"] = false,
		["title"] = "Minimap skin"
	})

	createCheckbox(category, {
		["variable"] = "auras",
		["db"] = mUI.profile.settings,
		["default"] = false,
		["title"] = "Aura skin"
	})

	createDropdown(category, {
		["variable"] = "healthTexture",
		["db"] = mUI.profile.settings,
		["default"] = "Tim",
		["title"] = "Health texture",
		["options"] = LSM:List("statusbar"),
	})

	createDropdown(category, {
		["variable"] = "powerTexture",
		["db"] = mUI.profile.settings,
		["default"] = "Tim",
		["title"] = "Power texture",
		["options"] = LSM:List("statusbar"),
	})

	createDropdown(category, {
		["variable"] = "castbarTexture",
		["db"] = mUI.profile.settings,
		["default"] = "Tim",
		["title"] = "Castbar texture",
		["options"] = LSM:List("statusbar"),
	})

	createDropdown(category, {
		["variable"] = "font",
		["db"] = mUI.profile.settings,
		["default"] = "Onest",
		["title"] = "Font",
		["options"] = LSM:List("font"),
	})

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Border"));

	createDropdown(category, {
		["variable"] = "borderTexture",
		["db"] = mUI.profile.settings,
		["default"] = "Mango Border",
		["title"] = "Border",
		["options"] = LSM:List("border"),
	})

	createSlider(category, {
		["variable"] = "borderSize",
		["db"] = mUI.profile.settings,
		["default"] = 1,
		["title"] = "Border size",
		["min"] = 0,
		["max"] = 10,
		["step"] = 1
	})

	createSlider(category, {
		["variable"] = "borderOffset",
		["db"] = mUI.profile.settings,
		["default"] = 1,
		["title"] = "Border offset",
		["min"] = 0,
		["max"] = 10,
		["step"] = 1
	})

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Hide"));

	createCheckbox(category, {
		["variable"] = "social",
		["db"] = mUI.profile.settings.hide,
		["default"] = false,
		["title"] = "Hide social button"
	})

	createCheckbox(category, {
		["variable"] = "menu",
		["db"] = mUI.profile.settings.hide,
		["default"] = false,
		["title"] = "Hide micromenu"
	})

	createCheckbox(category, {
		["variable"] = "bags",
		["db"] = mUI.profile.settings.hide,
		["default"] = false,
		["title"] = "Hide bags"
	})

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Other"));

	createButton(layout, "Apply settings", "Apply", function()
		ReloadUI()
	end, "Apply all settings and reload UI")

	createButton(layout, "Test frames", "Test", function()
		mUI:ToggleFrames()
	end, "Toggle all frames for testing purposes")

	createButton(layout, "Move frames", "Toggle", function()
		mUI:ToggleMovable()
	end, "Toggle movable frames")
end

-- Player settings
local function createPlayerSettings()
	local playerCategory, playerLayout = createSubCategory(mUI.category, "Player")

	createCheckbox(playerCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.player,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(playerCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.player.portrait,
		["default"] = true,
		["title"] = "Portrait"
	})

	createSlider(playerCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.player,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(playerCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.player,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})

	playerLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Power"));

	createCheckbox(playerCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.player.power,
		["default"] = true,
		["title"] = "Enable"
	})

	createCheckbox(playerCategory, {
		["variable"] = "detach",
		["db"] = mUI.profile.player.power,
		["default"] = false,
		["title"] = "Detach"
	})

	createSlider(playerCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.player.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(playerCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.player.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})

	createSlider(playerCategory, {
		["variable"] = "offsetL",
		["db"] = mUI.profile.player.power,
		["min"] = -2000,
		["max"] = 2000,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Left"
	})

	createSlider(playerCategory, {
		["variable"] = "offsetR",
		["db"] = mUI.profile.player.power,
		["min"] = -2000,
		["max"] = 2000,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Right"
	})

	createSlider(playerCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.player.power,
		["min"] = -2000,
		["max"] = 2000,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	createSlider(playerCategory, {
		["variable"] = "size",
		["db"] = mUI.profile.player.power.text,
		["min"] = 4,
		["max"] = 200,
		["step"] = 1,
		["default"] = 14,
		["title"] = "Font Size"
	})

	playerLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Classpower"));

	createCheckbox(playerCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.player.classpower,
		["default"] = true,
		["title"] = "Enable"
	})

	createCheckbox(playerCategory, {
		["variable"] = "detach",
		["db"] = mUI.profile.player.classpower,
		["default"] = false,
		["title"] = "Detach"
	})

	createSlider(playerCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.player.classpower,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(playerCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.player.classpower,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})

	createSlider(playerCategory, {
		["variable"] = "spacing",
		["db"] = mUI.profile.player.classpower,
		["min"] = 0,
		["max"] = 50,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Spacing"
	})

	playerLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Castbar"));

	createCheckbox(playerCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.player.castbar,
		["default"] = true,
		["title"] = "Enable"
	})

	createCheckbox(playerCategory, {
		["variable"] = "icon",
		["db"] = mUI.profile.player.castbar,
		["default"] = true,
		["title"] = "Show icon"
	})

	createCheckbox(playerCategory, {
		["variable"] = "detach",
		["db"] = mUI.profile.player.castbar,
		["default"] = false,
		["title"] = "Detach"
	})

	createSlider(playerCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.player.castbar,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})
	createSlider(playerCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.player.castbar,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})
end

local function createTargetSettings()
	local targetCategory, targetLayout = createSubCategory(mUI.category, "Target")

	createCheckbox(targetCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.target,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(targetCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.target.portrait,
		["default"] = true,
		["title"] = "Portrait"
	})

	createSlider(targetCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.target,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(targetCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.target,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})

	targetLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Power"));

	createCheckbox(targetCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.target.power,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(targetCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.target.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(targetCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.target.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})

	targetLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Castbar"));

	createCheckbox(targetCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.target.castbar,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(targetCategory, {
		["variable"] = "detach",
		["db"] = mUI.profile.target.castbar,
		["default"] = false,
		["title"] = "Detach"
	})

	createSlider(targetCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.target.castbar,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(targetCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.target.castbar,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})
end

local function createTargetTargetSettings()
	local totCategory, totLayout = createSubCategory(mUI.category, "Target of target")

	createCheckbox(totCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.targettarget,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(totCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.targettarget.portrait,
		["default"] = true,
		["title"] = "Portrait"
	})

	createSlider(totCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.targettarget,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(totCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.targettarget,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})
end

local function createFocusSettings()
	local focusCategory, focusLayout = createSubCategory(mUI.category, "Focus")

	createCheckbox(focusCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.focus,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(focusCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.focus.portrait,
		["default"] = true,
		["title"] = "Portrait"
	})

	createSlider(focusCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.focus,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(focusCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.focus,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})
end

local function createBossSettings()
	local bossCategory, bossLayout = createSubCategory(mUI.category, "Boss")

	createCheckbox(bossCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.boss,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(bossCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.boss.portrait,
		["default"] = true,
		["title"] = "Portrait"
	})

	createSlider(bossCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.boss,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(bossCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.boss,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})
end

local function createPartySettings()
	local partyCategory, partyLayout = createSubCategory(mUI.category, "Party")

	createCheckbox(partyCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.party,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(partyCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.party.portrait,
		["default"] = true,
		["title"] = "Portrait"
	})

	createSlider(partyCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.party,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(partyCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.party,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})
end

local function createRaidSettings()
	local raidCategory, raidLayout = createSubCategory(mUI.category, "Raid")

	createCheckbox(raidCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.raid,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(raidCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.raid.portrait,
		["default"] = true,
		["title"] = "Portrait"
	})

	createSlider(raidCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.raid,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(raidCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.raid,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})
end

local function createPetSettings()
	local petCategory, petLayout = createSubCategory(mUI.category, "Pet")

	createCheckbox(petCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.pet,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(petCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.pet.portrait,
		["default"] = true,
		["title"] = "Portrait"
	})
	createSlider(petCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.pet,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(petCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.pet,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})
end

local function createAurasSettings()
	local f = CreateFrame("Frame")
	local aurasCategory, aurasLayout = Settings.RegisterCanvasLayoutSubcategory(mUI.category, f, "Auras")

	local ScrollBox = CreateFrame("Frame", nil, f, "WowScrollBoxList")
	ScrollBox:SetPoint("TOPLEFT")
	ScrollBox:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, -23)
	--ScrollBox:SetSize(300, 300)

	local ScrollBar = CreateFrame("EventFrame", nil, f, "MinimalScrollBar")
	ScrollBar:SetPoint("TOPLEFT", ScrollBox, "TOPRIGHT")
	ScrollBar:SetPoint("BOTTOMLEFT", ScrollBox, "BOTTOMRIGHT")

	local DataProvider = CreateDataProvider()
	local ScrollView = CreateScrollBoxListLinearView()
	ScrollView:SetDataProvider(DataProvider)

	ScrollUtil.InitScrollBoxListWithScrollBar(ScrollBox, ScrollBar, ScrollView)

	-- The 'button' argument is the frame that our data will inhabit in our list
	-- The 'data' argument will be the data table mentioned above
	local function Initializer(button, data)
		local playerName = data.PlayerName
		local playerClass = data.PlayerClass
		button:SetScript("OnClick", function()
			print(playerName .. ": " .. playerClass)
			DataProvider:Insert({
				PlayerName = "Ghost",
				PlayerClass = "Priest"
			})
		end)
		button:SetText(playerName)
	end

	-- The first argument here can either be a frame type or frame template. We're just passing the "UIPanelButtonTemplate" template here
	ScrollView:SetElementInitializer("UIPanelButtonTemplate", Initializer)

	local myData = {
		PlayerName = "Ghost",
		PlayerClass = "Priest"
	}

	DataProvider:Insert(myData)
end

local function createProfileSettings()
	local profilesCategory, profilesLayout = createSubCategory(mUI.category, "Profiles")

	local profiles = {}
	for k, _ in next, mUI.profiles do
		table.insert(profiles, k)
	end

	createDropdown(profilesCategory, {
		["variable"] = "current_profile_dd",
		["db"] = {},
		["default"] = mUI:GetCurrentProfile(),
		["title"] = "Select profile",
		["options"] = profiles,
		["func"] = function(setting, value)
			mUI:SetProfile(value)
		end
	})

	-- Create new profile
	StaticPopupDialogs.CreateProfilePopup = {
		text = "Enter name",
		button1 = OKAY,
		button2 = CANCEL,
		OnAccept = function(self)
			if self.table then
				mUI:CreateProfile(self.editBox:GetText(), self.table)
			else
				mUI:CreateProfile(self.editBox:GetText())
			end
		end,
		hasEditBox = 1,
		whileDead = true,
		hideOnEscape = true
	}

	local function createProfile()
		StaticPopup_Show("CreateProfilePopup")
	end
	createButton(profilesLayout, "Create new profile", "Create new profile", createProfile,
		"Create new profile")

	-- Import profile
	StaticPopupDialogs.ImportProfilePopup = {
		text = "Enter import string",
		button1 = OKAY,
		button2 = CANCEL,
		OnAccept = function(self)
			local dialog = StaticPopup_Show("CreateProfilePopup")
			dialog.table = self.editBox:GetText()
		end,
		hasEditBox = 1,
		whileDead = true,
		hideOnEscape = true
	}
	local function importProfile()
		StaticPopup_Show("ImportProfilePopup")
	end
	createButton(profilesLayout, "Import profile", "Import profile", importProfile, "Import profile")

	-- Export profile
	StaticPopupDialogs.ExportProfilePopup = {
		text = "Copy the export string",
		button1 = OKAY,
		OnShow = function(self)
			self.editBox:SetText(mUI:GetProfileExportString())
			self.editBox:HighlightText()
		end,
		hasEditBox = 1,
		whileDead = true,
		hideOnEscape = true
	}
	local function exportProfile()
		StaticPopup_Show("ExportProfilePopup")
	end
	createButton(profilesLayout, "Export profile", "Export profile", exportProfile, "Export profile")

	-- Delete profile
	StaticPopupDialogs.DeleteProfilePopup = {
		text = "Are you sure? (Type DELETE to confirm)",
		button1 = OKAY,
		button2 = CANCEL,
		OnShow = function(self)
			self.button1:Disable()
		end,
		OnAccept = function(self)
			if self.editBox:GetText() ~= "DELETE" then return end
			mUI:DeleteProfile(self.profile)
		end,
		EditBoxOnTextChanged = function(self)
			if self:GetText() == "DELETE" then
				self:GetParent().button1:Enable()
			else
				self:GetParent().button1:Disable()
			end
		end,
		hasEditBox = 1,
		whileDead = true,
		hideOnEscape = true
	}

	createDropdown(profilesCategory, {
		["variable"] = "delete_profile_dd",
		["db"] = {},
		["default"] = "default",
		["title"] = "Delete profile",
		["options"] = profiles,
		["func"] = function(setting, value)
			local dialog = StaticPopup_Show("DeleteProfilePopup")
			if dialog then
				dialog.profile = value
			end
		end
	})
end

SettingsRegistrar:AddRegistrant(function()
	RegisterSettings()
	createPlayerSettings()
	createTargetSettings()
	createTargetTargetSettings()
	createFocusSettings()
	createBossSettings()
	createPartySettings()
	createRaidSettings()
	createPetSettings()
	createAurasSettings()
	createProfileSettings()
end)

function mUI:ToggleOptions()
	Settings.OpenToCategory(Settings.MUI_CATEGORY_ID)
end

SLASH_MANGOUI1, SLASH_MANGOUI2, SLASH_MANGOUI3 = '/mui', '/mango', '/mangoui'

SlashCmdList["MANGOUI"] = mUI.ToggleOptions
