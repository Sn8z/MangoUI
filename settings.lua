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
			_G["oUF_MangoPrimaryPlayer"]:SetWidth(v)
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
			_G["oUF_MangoPrimaryPlayer"]:SetHeight(v)
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
			_G["oUF_MangoPrimaryPlayer"]:ClearAllPoints()
			_G["oUF_MangoPrimaryPlayer"]:SetPoint(mUI.db.player.parentAnchor, mUI.db.player.x, mUI.db.player.y)
		end)
	end

	-- Player castbar
	playerLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Castbar"));

	-- Toggle player castbar
	do
		local variable = "toggle player castbar"
		local name = "Player castbar enabled"
		local tooltip = "Enable player castbar"
		local defaultValue = mUI.db.player.castbar.enabled

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(playerCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.castbar.enabled = v
		end)
	end

	-- Detach player castbar
	do
		local variable = "detach player castbar"
		local name = "Player castbar detached"
		local tooltip = "Detach player castbar"
		local defaultValue = mUI.db.player.castbar.detach

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(playerCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.castbar.detach = v
		end)
	end

	-- Player castbar width
	do
		local variable = "player castbar width slider"
		local name = "Player castbar width"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.castbar.width
		local minValue = 20
		local maxValue = 500
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.castbar.width = v
		end)
	end

	-- Player castbar height
	do
		local variable = "player castbar height slider"
		local name = "Player castbar height"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.castbar.height
		local minValue = 1
		local maxValue = 200
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.castbar.height = v
		end)
	end

	-- Player castbar xpos
	do
		local variable = "player castbar xpos slider"
		local name = "Player castbar xpos"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.castbar.x
		local screenWidth = math.floor(GetScreenWidth())
		local minValue = -screenWidth / 2
		local maxValue = screenWidth / 2
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.castbar.x = v
		end)
	end

	-- Player castbar ypos
	do
		local variable = "player castbar ypos slider"
		local name = "Player castbar ypos"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.castbar.y
		local screenHeight = math.floor(GetScreenHeight())
		local minValue = -screenHeight / 2
		local maxValue = screenHeight / 2
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.castbar.y = v
		end)
	end

	playerLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("Power"));

	-- Toggle player power
	do
		local variable = "toggle player power"
		local name = "Player power enabled"
		local tooltip = "Enable player power"
		local defaultValue = mUI.db.player.power.enabled

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(playerCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.power.enabled = v
		end)
	end

	-- Detach player power
	do
		local variable = "detach player power"
		local name = "Player power detached"
		local tooltip = "Detach player power."
		local defaultValue = mUI.db.player.power.detach

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(playerCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.power.detach = v
		end)
	end

	-- Player power width
	do
		local variable = "player power width slider"
		local name = "Player power width"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.power.width
		local minValue = 20
		local maxValue = 500
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.power.width = v
		end)
	end

	-- Player power height
	do
		local variable = "player power height slider"
		local name = "Player power height"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.power.height
		local minValue = 1
		local maxValue = 200
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.power.height = v
		end)
	end

	-- Player power xpos
	do
		local variable = "player power xpos slider"
		local name = "Player power xpos"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.power.x
		local screenWidth = math.floor(GetScreenWidth())
		local minValue = -screenWidth / 2
		local maxValue = screenWidth / 2
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.power.x = v
		end)
	end

	-- Player power ypos
	do
		local variable = "player power ypos slider"
		local name = "Player power ypos"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.power.y
		local screenHeight = math.floor(GetScreenHeight())
		local minValue = -screenHeight / 2
		local maxValue = screenHeight / 2
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.power.y = v
		end)
	end

	playerLayout:AddInitializer(CreateSettingsListSectionHeaderInitializer("ClassPower"));

	-- Toggle player classpower
	do
		local variable = "toggle player classpower"
		local name = "Player classpower enabled"
		local tooltip = "Enable player classpower"
		local defaultValue = mUI.db.player.classpower.enabled

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(playerCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.classpower.enabled = v
		end)
	end

	-- Detach player classpower
	do
		local variable = "detach player classpower"
		local name = "Player classpower detached"
		local tooltip = "Detach player classpower."
		local defaultValue = mUI.db.player.classpower.detach

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(playerCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.classpower.detach = v
		end)
	end

	-- Player classpower width
	do
		local variable = "player classpower width slider"
		local name = "Player classpower width"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.classpower.width
		local minValue = 20
		local maxValue = 500
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.classpower.width = v
		end)
	end

	-- Player classpower height
	do
		local variable = "player classpower height slider"
		local name = "Player classpower height"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.classpower.height
		local minValue = 1
		local maxValue = 200
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.classpower.height = v
		end)
	end

	-- Player classpower spacing
	do
		local variable = "player classpower spacing slider"
		local name = "Player classpower spacing"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.classpower.spacing
		local minValue = -20
		local maxValue = 20
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.classpower.spacing = v
		end)
	end

	-- Player classpower xpos
	do
		local variable = "player classpower xpos slider"
		local name = "Player classpower xpos"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.classpower.x
		local screenWidth = math.floor(GetScreenWidth())
		local minValue = -screenWidth / 2
		local maxValue = screenWidth / 2
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.classpower.x = v
		end)
	end

	-- Player classpower ypos
	do
		local variable = "player classpower ypos slider"
		local name = "Player classpower ypos"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.player.classpower.y
		local screenHeight = math.floor(GetScreenHeight())
		local minValue = -screenHeight / 2
		local maxValue = screenHeight / 2
		local step = 1

		local setting = Settings.RegisterAddOnSetting(playerCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(playerCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.player.classpower.y = v
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

	-- Enable Target
	do
		local variable = "toggle target unitframe"
		local name = "Target frame enabled"
		local tooltip = "Enable target unitframe"
		local defaultValue = mUI.db.target.enabled

		local setting = Settings.RegisterAddOnSetting(targetCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(targetCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.target.enabled = v
		end)
	end

	-- Target width
	do
		local variable = "target width slider"
		local name = "Target width"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.target.width
		local minValue = 20
		local maxValue = 500
		local step = 1

		local setting = Settings.RegisterAddOnSetting(targetCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(targetCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.target.width = v
			_G["oUF_MangoPrimaryTarget"]:SetWidth(v)
		end)
	end

	-- Target height
	do
		local variable = "target height slider"
		local name = "Target height"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.target.height
		local minValue = 1
		local maxValue = 200
		local step = 1

		local setting = Settings.RegisterAddOnSetting(targetCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(targetCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.target.height = v
			_G["oUF_MangoPrimaryTarget"]:SetHeight(v)
		end)
	end

	-- Target xpos
	do
		local variable = "target xpos slider"
		local name = "Target xpos"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.target.x
		local screenWidth = math.floor(GetScreenWidth())
		local minValue = -screenWidth / 2
		local maxValue = screenWidth / 2
		local step = 1

		local setting = Settings.RegisterAddOnSetting(targetCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(targetCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.target.x = v
			_G["oUF_MangoPrimaryTarget"]:ClearAllPoints()
			_G["oUF_MangoPrimaryTarget"]:SetPoint(mUI.db.target.anchor, UIParent, mUI.db.target.parentAnchor, mUI.db.target.x,
				mUI.db.target.y)
		end)
	end

	-- Target ypos
	do
		local variable = "target ypos slider"
		local name = "Target ypos"
		local tooltip = "This is a tooltip for the slider."
		local defaultValue = mUI.db.target.y
		local screenHeight = math.floor(GetScreenHeight())
		local minValue = -screenHeight / 2
		local maxValue = screenHeight / 2
		local step = 1

		local setting = Settings.RegisterAddOnSetting(targetCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(targetCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.target.y = v
			_G["oUF_MangoPrimaryTarget"]:ClearAllPoints()
			_G["oUF_MangoPrimaryTarget"]:SetPoint(mUI.db.target.parentAnchor, mUI.db.target.x, mUI.db.target.y)
		end)
	end

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
