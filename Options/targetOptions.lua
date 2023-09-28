local addonName, mUI = ...

function mUI:CreateTargetOptions(category)
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
			_G["oUF_MangoPrimaryTarget"]:SetPoint(mUI.db.target.anchor, UIParent, mUI.db.target.parentAnchor, mUI.db.target.x,
				mUI.db.target.y)
		end)
	end
end