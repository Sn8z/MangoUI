local addonName, mUI = ...

-- Register addon to the AddonCompartmentFrame
if AddonCompartmentFrame then
	AddonCompartmentFrame:RegisterAddon({
		text = addonName,
		icon = "Interface\\AddOns\\MangoUI\\Media\\minimangologo",
		notCheckable = true,
		func = function()
			Settings.OpenToCategory(Settings.MUI_CATEGORY_ID)
		end,
	})
end