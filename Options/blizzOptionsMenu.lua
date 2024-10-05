local _, mUI = ...
local oUF = mUI.oUF
local LSM = LibStub("LibSharedMedia-3.0")

local function createSubCategory(category, name)
	return Settings.RegisterVerticalLayoutSubcategory(category, name)
end

local function onSettingChanged(setting, value)
	print("Setting changed:", setting:GetVariable(), value)

	-- Update all oUF elements
	for _, obj in next, oUF.objects do
		obj:UpdateAllElements("MANGO_UPDATE")
	end
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
		return string.format("%.0f", value)
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
		["title"] = "Skin Minimap"
	})

	createCheckbox(category, {
		["variable"] = "auras",
		["db"] = mUI.profile.settings,
		["default"] = false,
		["title"] = "Skin Blizzard auras"
	})

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Textures"));

	createDropdown(category, {
		["variable"] = "healthTexture",
		["db"] = mUI.profile.settings,
		["default"] = "Tim",
		["title"] = "Health",
		["options"] = LSM:List("statusbar"),
	})

	createDropdown(category, {
		["variable"] = "powerTexture",
		["db"] = mUI.profile.settings,
		["default"] = "Tim",
		["title"] = "Power",
		["options"] = LSM:List("statusbar"),
	})

	createDropdown(category, {
		["variable"] = "castbarTexture",
		["db"] = mUI.profile.settings,
		["default"] = "Tim",
		["title"] = "Castbar",
		["options"] = LSM:List("statusbar"),
	})

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Font"));

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
		["title"] = "|cff00ff00Enable|r"
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
		["default"] = 10,
		["title"] = "Height"
	})

	createSlider(playerCategory, {
		["variable"] = "offsetL",
		["db"] = mUI.profile.player.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Left"
	})

	createSlider(playerCategory, {
		["variable"] = "offsetR",
		["db"] = mUI.profile.player.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Right"
	})

	createSlider(playerCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.player.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	createSlider(playerCategory, {
		["variable"] = "size",
		["db"] = mUI.profile.player.power.text,
		["min"] = 4,
		["max"] = 100,
		["step"] = 1,
		["default"] = 14,
		["title"] = "Font Size"
	})

	playerLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Classpower"));

	createCheckbox(playerCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.player.classpower,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
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
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(playerCategory, {
		["variable"] = "detach",
		["db"] = mUI.profile.player.castbar,
		["default"] = false,
		["title"] = "Detach"
	})

	createCheckbox(playerCategory, {
		["variable"] = "icon",
		["db"] = mUI.profile.player.castbar,
		["default"] = true,
		["title"] = "Show icon"
	})

	createCheckbox(playerCategory, {
		["variable"] = "shield",
		["db"] = mUI.profile.player.castbar,
		["default"] = true,
		["title"] = "Show shield"
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

	createSlider(playerCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.player.castbar,
		["min"] = -100,
		["max"] = 100,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	playerLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Portrait"));

	createCheckbox(playerCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.player.portrait,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(playerCategory, {
		["variable"] = "alpha",
		["db"] = mUI.profile.player.portrait,
		["min"] = 0,
		["max"] = 1,
		["step"] = 0.1,
		["default"] = 0.2,
		["title"] = "Alpha"
	})

	playerLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Totems"));

	createCheckbox(playerCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.totems,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(playerCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.totems,
		["min"] = 1,
		["max"] = 100,
		["step"] = 1,
		["default"] = 20,
		["title"] = "Width"
	})

	createSlider(playerCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.totems,
		["min"] = 1,
		["max"] = 100,
		["step"] = 1,
		["default"] = 20,
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
		["default"] = 10,
		["title"] = "Height"
	})

	createSlider(targetCategory, {
		["variable"] = "offsetL",
		["db"] = mUI.profile.target.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Left"
	})

	createSlider(targetCategory, {
		["variable"] = "offsetR",
		["db"] = mUI.profile.target.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Right"
	})

	createSlider(targetCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.target.power,
		["min"] = -100,
		["max"] = 100,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	createSlider(targetCategory, {
		["variable"] = "size",
		["db"] = mUI.profile.target.power.text,
		["min"] = 4,
		["max"] = 100,
		["step"] = 1,
		["default"] = 14,
		["title"] = "Font Size"
	})

	targetLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Castbar"));

	createCheckbox(targetCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.target.castbar,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(targetCategory, {
		["variable"] = "icon",
		["db"] = mUI.profile.target.castbar,
		["default"] = false,
		["title"] = "Show icon"
	})

	createCheckbox(targetCategory, {
		["variable"] = "shield",
		["db"] = mUI.profile.target.castbar,
		["default"] = false,
		["title"] = "Show shield"
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

	createSlider(targetCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.target.castbar,
		["min"] = -100,
		["max"] = 100,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	targetLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Portrait"));

	createCheckbox(targetCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.target.portrait,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(targetCategory, {
		["variable"] = "alpha",
		["db"] = mUI.profile.target.portrait,
		["min"] = 0,
		["max"] = 1,
		["step"] = 0.1,
		["default"] = 0.2,
		["title"] = "Alpha"
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

	totLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Power"));

	createCheckbox(totCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.targettarget.power,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(totCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.targettarget.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(totCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.targettarget.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 10,
		["title"] = "Height"
	})

	createSlider(totCategory, {
		["variable"] = "offsetL",
		["db"] = mUI.profile.targettarget.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Left"
	})

	createSlider(totCategory, {
		["variable"] = "offsetR",
		["db"] = mUI.profile.targettarget.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Right"
	})

	createSlider(totCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.targettarget.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	createSlider(totCategory, {
		["variable"] = "size",
		["db"] = mUI.profile.targettarget.power.text,
		["min"] = 4,
		["max"] = 100,
		["step"] = 1,
		["default"] = 14,
		["title"] = "Font Size"
	})

	totLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Portrait"));

	createCheckbox(totCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.targettarget.portrait,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(totCategory, {
		["variable"] = "alpha",
		["db"] = mUI.profile.targettarget.portrait,
		["min"] = 0,
		["max"] = 1,
		["step"] = 0.1,
		["default"] = 0.2,
		["title"] = "Alpha"
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

	focusLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Power"));

	createCheckbox(focusCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.focus.power,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(focusCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.focus.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(focusCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.focus.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 10,
		["title"] = "Height"
	})

	createSlider(focusCategory, {
		["variable"] = "offsetL",
		["db"] = mUI.profile.focus.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Left"
	})

	createSlider(focusCategory, {
		["variable"] = "offsetR",
		["db"] = mUI.profile.focus.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Right"
	})

	createSlider(focusCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.focus.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	createSlider(focusCategory, {
		["variable"] = "size",
		["db"] = mUI.profile.focus.power.text,
		["min"] = 4,
		["max"] = 100,
		["step"] = 1,
		["default"] = 14,
		["title"] = "Font Size"
	})

	focusLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Castbar"));

	createCheckbox(focusCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.focus.castbar,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(focusCategory, {
		["variable"] = "detach",
		["db"] = mUI.profile.focus.castbar,
		["default"] = false,
		["title"] = "Detach"
	})

	createCheckbox(focusCategory, {
		["variable"] = "icon",
		["db"] = mUI.profile.focus.castbar,
		["default"] = true,
		["title"] = "Show icon"
	})

	createCheckbox(focusCategory, {
		["variable"] = "shield",
		["db"] = mUI.profile.focus.castbar,
		["default"] = true,
		["title"] = "Show shield"
	})

	createSlider(focusCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.focus.castbar,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(focusCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.focus.castbar,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})

	createSlider(focusCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.focus.castbar,
		["min"] = -100,
		["max"] = 100,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	focusLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Portrait"));

	createCheckbox(focusCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.focus.portrait,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(focusCategory, {
		["variable"] = "alpha",
		["db"] = mUI.profile.focus.portrait,
		["min"] = 0,
		["max"] = 1,
		["step"] = 0.1,
		["default"] = 0.2,
		["title"] = "Alpha"
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

	bossLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Power"));

	createCheckbox(bossCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.boss.power,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(bossCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.boss.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(bossCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.boss.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 10,
		["title"] = "Height"
	})

	createSlider(bossCategory, {
		["variable"] = "offsetL",
		["db"] = mUI.profile.boss.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Left"
	})

	createSlider(bossCategory, {
		["variable"] = "offsetR",
		["db"] = mUI.profile.boss.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Right"
	})

	createSlider(bossCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.boss.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	createSlider(bossCategory, {
		["variable"] = "size",
		["db"] = mUI.profile.boss.power.text,
		["min"] = 4,
		["max"] = 100,
		["step"] = 1,
		["default"] = 14,
		["title"] = "Font Size"
	})

	bossLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Castbar"));

	createCheckbox(bossCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.boss.castbar,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(bossCategory, {
		["variable"] = "icon",
		["db"] = mUI.profile.boss.castbar,
		["default"] = true,
		["title"] = "Show icon"
	})

	createCheckbox(bossCategory, {
		["variable"] = "shield",
		["db"] = mUI.profile.boss.castbar,
		["default"] = true,
		["title"] = "Show shield"
	})

	createSlider(bossCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.boss.castbar,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})

	createSlider(bossCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.boss.castbar,
		["min"] = -100,
		["max"] = 100,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	bossLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Portrait"));

	createCheckbox(bossCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.boss.portrait,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(bossCategory, {
		["variable"] = "alpha",
		["db"] = mUI.profile.boss.portrait,
		["min"] = 0,
		["max"] = 1,
		["step"] = 0.1,
		["default"] = 0.2,
		["title"] = "Alpha"
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

	partyLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Power"));

	createCheckbox(partyCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.party.power,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(partyCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.party.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(partyCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.party.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 10,
		["title"] = "Height"
	})

	createSlider(partyCategory, {
		["variable"] = "offsetL",
		["db"] = mUI.profile.party.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Left"
	})

	createSlider(partyCategory, {
		["variable"] = "offsetR",
		["db"] = mUI.profile.party.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Right"
	})

	createSlider(partyCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.party.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	createSlider(partyCategory, {
		["variable"] = "size",
		["db"] = mUI.profile.party.power.text,
		["min"] = 4,
		["max"] = 100,
		["step"] = 1,
		["default"] = 14,
		["title"] = "Font Size"
	})

	partyLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Portrait"));

	createCheckbox(partyCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.party.portrait,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(partyCategory, {
		["variable"] = "alpha",
		["db"] = mUI.profile.party.portrait,
		["min"] = 0,
		["max"] = 1,
		["step"] = 0.1,
		["default"] = 0.2,
		["title"] = "Alpha"
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

	raidLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Power"));

	createCheckbox(raidCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.raid.power,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(raidCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.raid.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(raidCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.raid.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 10,
		["title"] = "Height"
	})

	createSlider(raidCategory, {
		["variable"] = "offsetL",
		["db"] = mUI.profile.raid.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Left"
	})

	createSlider(raidCategory, {
		["variable"] = "offsetR",
		["db"] = mUI.profile.raid.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Right"
	})

	createSlider(raidCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.raid.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	createSlider(raidCategory, {
		["variable"] = "size",
		["db"] = mUI.profile.raid.power.text,
		["min"] = 4,
		["max"] = 100,
		["step"] = 1,
		["default"] = 14,
		["title"] = "Font Size"
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

	petLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Power"));

	createCheckbox(petCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.pet.power,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(petCategory, {
		["variable"] = "width",
		["db"] = mUI.profile.pet.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Width"
	})

	createSlider(petCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.pet.power,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 10,
		["title"] = "Height"
	})

	createSlider(petCategory, {
		["variable"] = "offsetL",
		["db"] = mUI.profile.pet.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Left"
	})

	createSlider(petCategory, {
		["variable"] = "offsetR",
		["db"] = mUI.profile.pet.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Right"
	})

	createSlider(petCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.pet.power,
		["min"] = -200,
		["max"] = 200,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	createSlider(petCategory, {
		["variable"] = "size",
		["db"] = mUI.profile.pet.power.text,
		["min"] = 4,
		["max"] = 100,
		["step"] = 1,
		["default"] = 14,
		["title"] = "Font Size"
	})

	petLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Castbar"));

	createCheckbox(petCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.pet.castbar,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createCheckbox(petCategory, {
		["variable"] = "icon",
		["db"] = mUI.profile.pet.castbar,
		["default"] = true,
		["title"] = "Show icon"
	})

	createCheckbox(petCategory, {
		["variable"] = "shield",
		["db"] = mUI.profile.pet.castbar,
		["default"] = true,
		["title"] = "Show shield"
	})

	createSlider(petCategory, {
		["variable"] = "height",
		["db"] = mUI.profile.pet.castbar,
		["min"] = 1,
		["max"] = 1000,
		["step"] = 1,
		["default"] = 200,
		["title"] = "Height"
	})

	createSlider(petCategory, {
		["variable"] = "offsetY",
		["db"] = mUI.profile.pet.castbar,
		["min"] = -100,
		["max"] = 100,
		["step"] = 1,
		["default"] = 0,
		["title"] = "Offset Y"
	})

	petLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Portrait"));

	createCheckbox(petCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.pet.portrait,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r"
	})

	createSlider(petCategory, {
		["variable"] = "alpha",
		["db"] = mUI.profile.pet.portrait,
		["min"] = 0,
		["max"] = 1,
		["step"] = 0.1,
		["default"] = 0.2,
		["title"] = "Alpha"
	})
end

local function createAuraSettings()
	local auraCategory, auraLayout = createSubCategory(mUI.category, "Auras")

	auraLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Player"));

	createCheckbox(auraCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.player.buffs,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r Buffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "blizzard",
		["db"] = mUI.profile.player.buffs,
		["default"] = true,
		["title"] = "Show Blizzard Buffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.player.debuffs,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r Debuffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "blizzard",
		["db"] = mUI.profile.player.debuffs,
		["default"] = true,
		["title"] = "Show Blizzard Debuffs"
	})

	auraLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Target"));

	createCheckbox(auraCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.target.buffs,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r Buffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "blizzard",
		["db"] = mUI.profile.target.buffs,
		["default"] = true,
		["title"] = "Show Blizzard Buffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.target.debuffs,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r Debuffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "blizzard",
		["db"] = mUI.profile.target.debuffs,
		["default"] = true,
		["title"] = "Show Blizzard Debuffs"
	})

	auraLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Party"));

	createCheckbox(auraCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.party.buffs,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r Buffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "blizzard",
		["db"] = mUI.profile.party.buffs,
		["default"] = true,
		["title"] = "Show Blizzard Buffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.party.debuffs,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r Debuffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "blizzard",
		["db"] = mUI.profile.party.debuffs,
		["default"] = true,
		["title"] = "Show Blizzard Debuffs"
	})

	auraLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Raid"));

	createCheckbox(auraCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.raid.buffs,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r Buffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "blizzard",
		["db"] = mUI.profile.raid.buffs,
		["default"] = true,
		["title"] = "Show Blizzard Buffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.raid.debuffs,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r Debuffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "blizzard",
		["db"] = mUI.profile.raid.debuffs,
		["default"] = true,
		["title"] = "Show Blizzard Debuffs"
	})

	auraLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Focus"));

	createCheckbox(auraCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.focus.buffs,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r Buffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "blizzard",
		["db"] = mUI.profile.focus.buffs,
		["default"] = true,
		["title"] = "Show Blizzard Buffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "enabled",
		["db"] = mUI.profile.focus.debuffs,
		["default"] = true,
		["title"] = "|cff00ff00Enable|r Debuffs"
	})

	createCheckbox(auraCategory, {
		["variable"] = "blizzard",
		["db"] = mUI.profile.focus.debuffs,
		["default"] = true,
		["title"] = "Show Blizzard Debuffs"
	})
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
	createAuraSettings()
	mUI:createAuraFilterSettings()
	createProfileSettings()
end)

function mUI:ToggleOptions()
	Settings.OpenToCategory(Settings.MUI_CATEGORY_ID)
end

SLASH_MANGOUI1, SLASH_MANGOUI2, SLASH_MANGOUI3 = '/mui', '/mango', '/mangoui'

SlashCmdList["MANGOUI"] = mUI.ToggleOptions
