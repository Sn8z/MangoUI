local addonName, mUI = ...

function mUI:CreatePartyOptions(category)
	-- Party subsection
	local partyCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Party")
	Settings.RegisterAddOnCategory(partyCategory)

	-- Enable party
	do
		local variable = "toggle party unitframe"
		local name = "party frame enabled"
		local tooltip = "Enable party unitframe"
		local defaultValue = mUI.db.party.enabled

		local setting = Settings.RegisterAddOnSetting(partyCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateCheckBox(partyCategory, setting, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, s, v)
			mUI.db.party.enabled = v
		end)
	end
end
