local addonName, mUI = ...

function mUI:CreateRaidOptions(category)
	-- Raid subsection
	local raidCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Raid")
	Settings.RegisterAddOnCategory(raidCategory)

	-- Enable Raid
	do
		local variable = "toggle raid unitframe"
		local name = "Raid frame enabled"
		local tooltip = "Enable raid unitframe"
		local defaultValue = mUI.db.raid.enabled

		local setting = Settings.RegisterAddOnSetting(raidCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(raidCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.raid.enabled = v
		end)
	end
end