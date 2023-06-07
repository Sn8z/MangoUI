local AddonName, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

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

-- Inject Media
-- Fonts (.ttf/.otf)
LSM:Register(LSM.MediaType.FONT, "Manrope Regular",	[[Interface\Addons\MangoUI\Media\Fonts\Manrope\Manrope-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Manrope Bold", [[Interface\Addons\MangoUI\Media\Fonts\Manrope\Manrope-Bold.ttf]])
LSM:Register(LSM.MediaType.FONT, "Manrope Light", [[Interface\Addons\MangoUI\Media\Fonts\Manrope\Manrope-Light.ttf]])
LSM:Register(LSM.MediaType.FONT, "TeX Gyre Adventor Bold", [[Interface\Addons\MangoUI\Media\Fonts\TeX-Gyre-Adventor\texgyreadventor-bold.otf]])
LSM:Register(LSM.MediaType.FONT, "TeX Gyre Adventor Regular",	[[Interface\Addons\MangoUI\Media\Fonts\TeX-Gyre-Adventor\texgyreadventor-regular.otf]])

-- Statusbars (.tga/.blp)
LSM:Register(LSM.MediaType.STATUSBAR, "Xulnif", [[Interface\Addons\MangoUI\Media\Statusbars\xulnif.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Sn8z", [[Interface\Addons\MangoUI\Media\Statusbars\sn8z.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Tim", [[Interface\Addons\MangoUI\Media\Statusbars\tim.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "True", [[Interface\Addons\MangoUI\Media\Statusbars\true.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Patchouli", [[Interface\Addons\MangoUI\Media\Statusbars\patchouli.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Mango", [[Interface\Addons\MangoUI\Media\Statusbars\mango.tga]])
