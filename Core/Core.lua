local addonName, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

-- Register addon to the AddonCompartmentFrame
if AddonCompartmentFrame then
	AddonCompartmentFrame:RegisterAddon({
		text = addonName,
		icon = "Interface\\AddOns\\MangoUI\\Media\\minimangologo",
		notCheckable = true,
		func = function()
			mUI:ToggleOptions()
		end,
	})
end

-- MangoUI button for GameMenu
GameMenuFrame.Header:Hide()
local gameMenuButton = CreateFrame("Button", "MangoGameMenuButton", GameMenuFrame, "UIPanelButtonTemplate")
gameMenuButton:SetHeight(30)
gameMenuButton:SetWidth(130)
gameMenuButton:SetText("MangoUI")
gameMenuButton:ClearAllPoints()
gameMenuButton:SetPoint("CENTER", GameMenuFrame, "TOP", 0, 0)
gameMenuButton:SetScript("OnClick", function()
	mUI:ToggleOptions()
	ToggleGameMenu()
end)

-- Inject Media
-- Fonts (.ttf/.otf)
-- Poppins
LSM:Register(LSM.MediaType.FONT, "Poppins",
	[[Interface\Addons\MangoUI\Media\Fonts\Poppins\Poppins-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Poppins Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Poppins\Poppins-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Poppins Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Poppins\Poppins-Bold.ttf]])

-- Cabin
LSM:Register(LSM.MediaType.FONT, "Cabin",
	[[Interface\Addons\MangoUI\Media\Fonts\Cabin\Cabin-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Cabin Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Cabin\Cabin-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Cabin Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Cabin\Cabin-Bold.ttf]])

-- Rubik
LSM:Register(LSM.MediaType.FONT, "Rubik",
	[[Interface\Addons\MangoUI\Media\Fonts\Rubik\Rubik-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Rubik Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Rubik\Rubik-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Rubik Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Rubik\Rubik-Bold.ttf]])

-- Ubuntu
LSM:Register(LSM.MediaType.FONT, "Ubuntu",
	[[Interface\Addons\MangoUI\Media\Fonts\Ubuntu\Ubuntu-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Ubuntu Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Ubuntu\Ubuntu-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Ubuntu Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Ubuntu\Ubuntu-Bold.ttf]])

-- Gantari
LSM:Register(LSM.MediaType.FONT, "Gantari",
	[[Interface\Addons\MangoUI\Media\Fonts\Gantari\Gantari-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Gantari Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Gantari\Gantari-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Gantari Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Gantari\Gantari-Bold.ttf]])

-- Statusbars (.tga/.blp)
LSM:Register(LSM.MediaType.STATUSBAR, "Sn8z", [[Interface\Addons\MangoUI\Media\Statusbars\sn8z.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Erik", [[Interface\Addons\MangoUI\Media\Statusbars\erik.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Tim", [[Interface\Addons\MangoUI\Media\Statusbars\tim.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Mauk", [[Interface\Addons\MangoUI\Media\Statusbars\mauk.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Brink", [[Interface\Addons\MangoUI\Media\Statusbars\brink.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Mango", [[Interface\Addons\MangoUI\Media\Statusbars\mango.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Nucks", [[Interface\Addons\MangoUI\Media\Statusbars\nucks.tga]])

-- Borders

-- Sounds
