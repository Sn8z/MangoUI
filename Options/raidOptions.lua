local addonName, mUI = ...

function mUI:CreateRaidOptions(category)
	-- Raid subsection
	local raidCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Raid");
	Settings.RegisterAddOnCategory(raidCategory);
end