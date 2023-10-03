local addonName, mUI = ...

function mUI:CreatePlayerOptions(category)
	-- Player frame subsection
	local playerCategory, playerLayout = Settings.RegisterVerticalLayoutSubcategory(category, "Player")
	Settings.RegisterAddOnCategory(playerCategory)

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
			ReloadUI()
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
			_G["oUF_MangoPrimaryPlayer"]:SetPoint(mUI.db.player.anchor, UIParent, mUI.db.player.parentAnchor, mUI.db.player.x,
				mUI.db.player.y)
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
			ReloadUI()
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
			ReloadUI()
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
			if mUI.db.player.castbar.detach then
				_G["oUF_MangoPrimaryPlayer"].Castbar:SetWidth(v)
				if _G["oUF_MangoPrimaryPlayer"].GCD then
					_G["oUF_MangoPrimaryPlayer"].GCD:SetWidth(v)
				end 
			end
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
			_G["oUF_MangoPrimaryPlayer"].Castbar:SetHeight(v)
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
			if mUI.db.player.castbar.detach then
				_G["oUF_MangoPrimaryPlayer"].Castbar:ClearAllPoints()
				_G["oUF_MangoPrimaryPlayer"].Castbar:SetPoint('CENTER', UIParent, 'CENTER', mUI.db.player.castbar.x,
					mUI.db.player.castbar.y)
			end
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
			if mUI.db.player.castbar.detach then
				_G["oUF_MangoPrimaryPlayer"].Castbar:ClearAllPoints()
				_G["oUF_MangoPrimaryPlayer"].Castbar:SetPoint('CENTER', UIParent, 'CENTER', mUI.db.player.castbar.x,
					mUI.db.player.castbar.y)
			end
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
			ReloadUI()
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
			ReloadUI()
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
			if mUI.db.player.power.detach then
				_G["oUF_MangoPrimaryPlayer"].Power:SetWidth(v)
			end
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
			_G["oUF_MangoPrimaryPlayer"].Power:SetHeight(v)
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
			if mUI.db.player.power.detach then
				_G["oUF_MangoPrimaryPlayer"].Power:ClearAllPoints()
				_G["oUF_MangoPrimaryPlayer"].Power:SetPoint('CENTER', UIParent, 'CENTER', mUI.db.player.power.x,
					mUI.db.player.power.y)
			end
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
			if mUI.db.player.power.detach then
				_G["oUF_MangoPrimaryPlayer"].Power:ClearAllPoints()
				_G["oUF_MangoPrimaryPlayer"].Power:SetPoint('CENTER', UIParent, 'CENTER', mUI.db.player.power.x,
					mUI.db.player.power.y)
			end
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
			ReloadUI()
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
			ReloadUI()
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
			-- TODO: Live Update
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
			-- TODO: Live update
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
			-- TODO: Live update
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
			-- TODO: Live update
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
			-- TODO: Live update
		end)
	end
end
