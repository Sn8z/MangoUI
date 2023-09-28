local addonName, mUI = ...

function mUI:CreateTotOptions(category)
	-- Target of target subsection
	local totCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Target of target");
	Settings.RegisterAddOnCategory(totCategory);
end
