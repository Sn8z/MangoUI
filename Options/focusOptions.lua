local addonName, mUI = ...

function mUI:CreateFocusOptions(category)
	-- Focus subsection
	local focusCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Focus")
	Settings.RegisterAddOnCategory(focusCategory)

	-- Enable Focus
	do
		local variable = "toggle focus unitframe"
		local name = "Focus frame enabled"
		local tooltip = "Enable focus unitframe"
		local defaultValue = mUI.db.focus.enabled

		local setting = Settings.RegisterAddOnSetting(focusCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(focusCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.focus.enabled = v
		end)
	end

	-- Focus width
	do
		local variable = "focus width slider"
		local name = "Focus width"
		local tooltip = "Set the width of the focus frame."
		local defaultValue = mUI.db.focus.width
		local minValue = 20
		local maxValue = 500
		local step = 1

		local setting = Settings.RegisterAddOnSetting(focusCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right)
		Settings.CreateSlider(focusCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.focus.width = v
			_G["oUF_MangoPrimaryFocus"]:SetWidth(v)
		end)
	end

	-- Focus height
	do
		local variable = "focus height slider"
		local name = "Focus height"
		local tooltip = "Set the height of the focus frame."
		local defaultValue = mUI.db.focus.height
		local minValue = 1
		local maxValue = 200
		local step = 1

		local setting = Settings.RegisterAddOnSetting(focusCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(focusCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.focus.height = v
			_G["oUF_MangoPrimaryFocus"]:SetHeight(v)
		end)
	end

	-- Focus xpos
	do
		local variable = "focus xpos slider"
		local name = "Focus xpos"
		local tooltip = "Set the xpos for the focus frame."
		local defaultValue = mUI.db.focus.x
		local screenWidth = math.floor(GetScreenWidth())
		local minValue = -screenWidth / 2
		local maxValue = screenWidth / 2
		local step = 1

		local setting = Settings.RegisterAddOnSetting(focusCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(focusCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.focus.x = v
			_G["oUF_MangoPrimaryFocus"]:ClearAllPoints()
			_G["oUF_MangoPrimaryFocus"]:SetPoint(mUI.db.focus.anchor, UIParent, mUI.db.focus.parentAnchor, mUI.db.focus.x,
				mUI.db.focus.y)
		end)
	end

	-- Focus ypos
	do
		local variable = "focus ypos slider"
		local name = "Focus ypos"
		local tooltip = "Set the ypos for the focus frame."
		local defaultValue = mUI.db.focus.y
		local screenHeight = math.floor(GetScreenHeight())
		local minValue = -screenHeight / 2
		local maxValue = screenHeight / 2
		local step = 1

		local setting = Settings.RegisterAddOnSetting(focusCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(focusCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.focus.y = v
			_G["oUF_MangoPrimaryFocus"]:ClearAllPoints()
			_G["oUF_MangoPrimaryFocus"]:SetPoint(mUI.db.focus.anchor, UIParent, mUI.db.focus.parentAnchor, mUI.db.focus.x,
				mUI.db.focus.y)
		end)
	end
end