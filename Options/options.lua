local addonName, mUI = ...
local LSM = LibStub('LibSharedMedia-3.0')

local function RegisterSettings()
	-- Main MangoUI section
	local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)
	Settings.MUI_CATEGORY_ID = category:GetID()
	Settings.RegisterAddOnCategory(category)

	-- General settings
	-- Smooth bars
	do
		local variable = "toggle smooth bars"
		local name = "Enable smooth bars"
		local tooltip = "Enable a smoother animation for statusbars."
		local defaultValue = mUI.db.settings.smooth

		local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(category, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.settings.smooth = v
			ReloadUI()
		end)
	end

	mUI:CreateCheckBox(mUI.db.settings.smooth, category, "toggle smooth", "Toogle smooth bars", "Give all bars a smoother transition.")

	-- LSM statusbars
	do
		local variable = "mango texture"
		local defaultValue = mUI.db.settings.texture
		local name = "Texture"
		local tooltip = "Set the texture for all unit frames."

		local function GetOptions()
			local container = Settings.CreateControlTextContainer()
			for _, v in pairs(LSM:List("statusbar")) do
				container:Add(v, v)
			end
			return container:GetData()
		end

		local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaultValue), defaultValue)
		Settings.CreateDropDown(category, setting, GetOptions, tooltip)
		Settings.SetOnValueChangedCallback(setting:GetVariable(), function(_, setting, value)
			mUI.db.settings.texture = value
		end)
	end

	-- LSM fonts
	do
		local variable = "mango font"
		local defaultValue = mUI.db.settings.font
		local name = "Font"
		local tooltip = "Set the font for all text."

		local function GetOptions()
			local container = Settings.CreateControlTextContainer()
			for _, v in pairs(LSM:List("font")) do
				container:Add(v, v)
			end
			return container:GetData()
		end

		local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaultValue), defaultValue)
		Settings.CreateDropDown(category, setting, GetOptions, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, setting, value)
			mUI.db.settings.font = value
		end)
	end

	-- LSM borders
	do
		local variable = "mango border"
		local defaultValue = mUI.db.settings.border.edgeFile
		local name = "Border"
		local tooltip = "Set the border for all unit frames."

		local function GetOptions()
			local container = Settings.CreateControlTextContainer()
			for _, v in pairs(LSM:List("border")) do
				container:Add(v, v)
			end
			return container:GetData()
		end

		local setting = Settings.RegisterAddOnSetting(category, name, variable, type(defaultValue), defaultValue)
		Settings.CreateDropDown(category, setting, GetOptions, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, setting, value)
			mUI.db.settings.border.edgeFile = value
		end)
	end

	do
		local title = "Test"
		local buttonText = "Test 2"
		local buttonClick = function()
			print("TEST")
		end
		local tooltip = "TEST TOOLTIP"
		local addSearchTags = "Test"

		local initializer = CreateSettingsButtonInitializer(title, buttonText, buttonClick, tooltip, addSearchTags)
		layout:AddInitializer(initializer)
	end

	mUI:CreatePlayerOptions(category)
	mUI:CreatePetOptions(category)
	mUI:CreateTargetOptions(category)
	mUI:CreateTotOptions(category)
	mUI:CreateFocusOptions(category)
	mUI:CreatePartyOptions(category)
	mUI:CreateRaidOptions(category)
	mUI:CreateBossOptions(category)
	mUI:CreateProfilesOptions(category)
end

SettingsRegistrar:AddRegistrant(RegisterSettings)
