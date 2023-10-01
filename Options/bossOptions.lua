local addonName, mUI = ...

function mUI:CreateBossOptions(category)
	-- Boss subsection
	local bossCategory, bossLayout = Settings.RegisterVerticalLayoutSubcategory(category, "Boss")
	Settings.RegisterAddOnCategory(bossCategory)

	-- Enable Boss
	do
		local variable = "toggle boss unitframe"
		local name = "Boss frame enabled"
		local tooltip = "Enable boss unitframe"
		local defaultValue = mUI.db.boss.enabled

		local setting = Settings.RegisterAddOnSetting(bossCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(bossCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.boss.enabled = v
		end)
	end
end
