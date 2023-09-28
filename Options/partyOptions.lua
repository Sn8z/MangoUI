local addonName, mUI = ...

function mUI:CreatePartyOptions(category)
	-- Party subsection
	local partyCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Party");
	Settings.RegisterAddOnCategory(partyCategory);
end