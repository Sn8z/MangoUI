local addonName, mUI = ...

function mUI:CreateTotOptions(category)
	-- Target of target subsection
	local totCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Target of target")
	Settings.RegisterAddOnCategory(totCategory)

	-- Enable Target of target
	do
		local variable = "toggle target of target unitframe"
		local name = "Target of target frame enabled"
		local tooltip = "Enable target of target unitframe."
		local defaultValue = mUI.db.targettarget.enabled

		local setting = Settings.RegisterAddOnSetting(totCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(totCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.targettarget.enabled = v
		end)
	end

	-- Target of target width
	do
		local variable = "target of target width slider"
		local name = "Target of target width"
		local tooltip = "Set the width of the target of target frame."
		local defaultValue = mUI.db.targettarget.width
		local minValue = 20
		local maxValue = 500
		local step = 1

		local setting = Settings.RegisterAddOnSetting(totCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(totCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.targettarget.width = v
			_G["oUF_MangoSecondaryTargetTarget"]:SetWidth(v)
		end)
	end

	-- Target of target height
	do
		local variable = "target of target height slider"
		local name = "Target of target height"
		local tooltip = "Set the height of the target of target frame."
		local defaultValue = mUI.db.targettarget.height
		local minValue = 1
		local maxValue = 200
		local step = 1

		local setting = Settings.RegisterAddOnSetting(totCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(totCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.targettarget.height = v
			_G["oUF_MangoSecondaryTargetTarget"]:SetHeight(v)
		end)
	end
end
