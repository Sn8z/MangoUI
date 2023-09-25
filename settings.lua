local addonName, mUI = ...
local LSM = LibStub('LibSharedMedia-3.0')

function RegisterSettings()
	-- Main MangoUI section
	local category, layout = Settings.RegisterVerticalLayoutCategory(addonName)
	Settings.RegisterAddOnCategory(category)
	Settings.MUI_CATEGORY_ID = category:GetID()

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
		end)
	end

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

	-- Player frame subsection
	local playerCategory, playerLayout = Settings.RegisterVerticalLayoutSubcategory(category, "Player");
	Settings.RegisterAddOnCategory(playerCategory);

	-- Enable Player
	do
		local variable = "toggle player unitframe"
		local name = "Player frame enabled"
		local tooltip = "Enable player unitframe"
		local defaultValue = mUI.db.player.enabled

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(playerCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.enabled = v
		end)
	end

	-- Player width
	do
		local variable = "player width slider"
		local name = "Player width"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.width
		local minValue = 20
		local maxValue = 500
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.width = v
		end)
	end

	-- Player height
	do
		local variable = "player height slider"
		local name = "Player height"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.height
		local minValue = 1
		local maxValue = 200
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.height = v
		end)
	end

	-- Player xpos
	do
		local variable = "player xpos slider"
		local name = "Player xpos"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.x
		local screenWidth = math.floor(GetScreenWidth())
		local minValue = -screenWidth / 2
		local maxValue = screenWidth / 2
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.x = v
			_G["oUF_MangoPrimaryPlayer"]:ClearAllPoints()
			_G["oUF_MangoPrimaryPlayer"]:SetPoint(mUI.db.player.anchor, UIParent, mUI.db.player.parentAnchor, mUI.db.player.x,
				mUI.db.player.y)
		end)
	end

	playerLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Power"));
	playerLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("ClassPower"));
	playerLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Castbar"));

	-- Player ypos
	do
		local variable = "player ypos slider"
		local name = "Player ypos"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.y
		local screenHeight = math.floor(GetScreenHeight())
		local minValue = -screenHeight / 2
		local maxValue = screenHeight / 2
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.y = v
			_G["oUF_MangoPrimaryPlayer"]:SetPoint(mUI.db.player.parentAnchor, mUI.db.player.x, mUI.db.player.y)
		end)
	end

	-- enabled
	-- anchor
	-- parentAnchor
	-- width
	-- height
	-- classColor Health
	-- power
	-- enabled
	-- detach
	-- classColor
	-- castbar
	-- enabled
	-- detach
	-- classColor
	-- classPower
	-- enabled
	-- detach
	-- classColor

	-- Pet subsection
	local petCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Pet");
	Settings.RegisterAddOnCategory(petCategory);

	-- Target subsection
	local targetCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Target");
	Settings.RegisterAddOnCategory(targetCategory);

	-- Target of target subsection
	local totCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Target of target");
	Settings.RegisterAddOnCategory(totCategory);

	-- Party subsection
	local partyCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Party");
	Settings.RegisterAddOnCategory(partyCategory);

	-- Raid subsection
	local raidCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Raid");
	Settings.RegisterAddOnCategory(raidCategory);

	-- Boss subsection
	local bossCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Boss");
	Settings.RegisterAddOnCategory(bossCategory);
end

SettingsRegistrar:AddRegistrant(RegisterSettings)
