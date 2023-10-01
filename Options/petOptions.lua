local addonName, mUI = ...

function mUI:CreatePetOptions(category)
	-- Pet subsection
	local petCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Pet")
	Settings.RegisterAddOnCategory(petCategory)

	-- Enable Pet
	do
		local variable = "toggle pet unitframe"
		local name = "Pet frame enabled"
		local tooltip = "Enable pet unitframe."
		local defaultValue = mUI.db.pet.enabled

		local setting = Settings.RegisterAddOnSetting(petCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(petCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.pet.enabled = v
		end)
	end

	-- Pet width
	do
		local variable = "pet width slider"
		local name = "Pet width"
		local tooltip = "Set the width of the pet frame."
		local defaultValue = mUI.db.pet.width
		local minValue = 20
		local maxValue = 500
		local step = 1

		local setting = Settings.RegisterAddOnSetting(petCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(petCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.pet.width = v
			_G["oUF_MangoSecondaryPet"]:SetWidth(v)
		end)
	end

	-- Pet height
	do
		local variable = "pet height slider"
		local name = "Pet height"
		local tooltip = "Set the height of the pet frame."
		local defaultValue = mUI.db.pet.height
		local minValue = 1
		local maxValue = 200
		local step = 1

		local setting = Settings.RegisterAddOnSetting(petCategory, name, variable, type(defaultValue), defaultValue)
		local options = Settings.CreateSliderOptions(minValue, maxValue, step)
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right);
		Settings.CreateSlider(petCategory, setting, options, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.pet.height = v
			_G["oUF_MangoSecondaryPet"]:SetHeight(v)
		end)
	end
end