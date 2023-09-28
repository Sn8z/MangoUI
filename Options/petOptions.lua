local addonName, mUI = ...

function mUI:CreatePetOptions(category)
	-- Pet subsection
	local petCategory = Settings.RegisterVerticalLayoutSubcategory(category, "Pet");
	Settings.RegisterAddOnCategory(petCategory);
end