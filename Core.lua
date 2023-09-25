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

local LSM = LibStub("LibSharedMedia-3.0")

-- Inject Media
-- Fonts (.ttf/.otf)
-- Manrope
LSM:Register(LSM.MediaType.FONT, "Manrope Regular",
	[[Interface\Addons\MangoUI\Media\Fonts\Manrope\Manrope-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Manrope Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Manrope\Manrope-Bold.ttf]])
LSM:Register(LSM.MediaType.FONT, "Manrope Light",
	[[Interface\Addons\MangoUI\Media\Fonts\Manrope\Manrope-Light.ttf]])

-- Poppins
LSM:Register(LSM.MediaType.FONT, "Poppins Regular",
	[[Interface\Addons\MangoUI\Media\Fonts\Poppins\Poppins-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Poppins Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Poppins\Poppins-Bold.ttf]])
LSM:Register(LSM.MediaType.FONT, "Poppins Light",
	[[Interface\Addons\MangoUI\Media\Fonts\Poppins\Poppins-Light.ttf]])

-- Cabin
LSM:Register(LSM.MediaType.FONT, "Cabin",
	[[Interface\Addons\MangoUI\Media\Fonts\Cabin\Cabin-Regular.ttf]])

-- Rubik
LSM:Register(LSM.MediaType.FONT, "Rubik Regular",
	[[Interface\Addons\MangoUI\Media\Fonts\Rubik\Rubik-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Rubik Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Rubik\Rubik-Bold.ttf]])
LSM:Register(LSM.MediaType.FONT, "Rubik Light",
	[[Interface\Addons\MangoUI\Media\Fonts\Rubik\Rubik-Light.ttf]])

-- Statusbars (.tga/.blp)
LSM:Register(LSM.MediaType.STATUSBAR, "Xulnif", [[Interface\Addons\MangoUI\Media\Statusbars\xulnif.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Sn8z", [[Interface\Addons\MangoUI\Media\Statusbars\sn8z.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Tim", [[Interface\Addons\MangoUI\Media\Statusbars\tim.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "True", [[Interface\Addons\MangoUI\Media\Statusbars\true.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Patchouli", [[Interface\Addons\MangoUI\Media\Statusbars\patchouli.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Mango", [[Interface\Addons\MangoUI\Media\Statusbars\mango.tga]])

-- Borders

-- Sounds
