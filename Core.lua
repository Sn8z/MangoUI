local AddonName, mUI = ...

-- Register addon to the AddonCompartmentFrame
if AddonCompartmentFrame then
	AddonCompartmentFrame:RegisterAddon({
		text = AddonName,
		icon = "Interface\\AddOns\\MangoUI\\Media\\minimangologo",
		notCheckable = true,
		func = function()
			InterfaceOptionsFrame_OpenToCategory("MangoUI")
		end,
	})
end