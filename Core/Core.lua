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

-- Add vault slash command
local function showVault()
	if not WeeklyRewardsFrame then
		C_AddOns.LoadAddOn("Blizzard_WeeklyRewards")
	end

	if WeeklyRewardsFrame:IsVisible() then
		WeeklyRewardsFrame:Hide()
	else
		WeeklyRewardsFrame:Show()
	end
end

SLASH_MANGOVAULT1 = "/vault"
SlashCmdList["MANGOVAULT"] = showVault

-- Add reload command
SLASH_MANGORELOAD1 = "/rl"
SlashCmdList["MANGORELOAD"] = ReloadUI

-- Autofill delete prompts
local function fillDeletePrompt(popup)
	if not popup then return end
	popup.editBox:SetText(DELETE_ITEM_CONFIRM_STRING)
end

hooksecurefunc(StaticPopupDialogs["DELETE_GOOD_ITEM"], "OnShow", fillDeletePrompt)
hooksecurefunc(StaticPopupDialogs["DELETE_GOOD_QUEST_ITEM"], "OnShow", fillDeletePrompt)

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

-- Overpass
LSM:Register(LSM.MediaType.FONT, "Overpass",
	[[Interface\Addons\MangoUI\Media\Fonts\Overpass\Overpass-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Overpass Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Overpass\Overpass-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Overpass Semi Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Overpass\Overpass-SemiBold.ttf]])
LSM:Register(LSM.MediaType.FONT, "Overpass Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Overpass\Overpass-Bold.ttf]])

-- Statusbars (.tga/.blp)
LSM:Register(LSM.MediaType.STATUSBAR, "Sn8z", [[Interface\Addons\MangoUI\Media\Statusbars\sn8z.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Erik", [[Interface\Addons\MangoUI\Media\Statusbars\erik.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Tim", [[Interface\Addons\MangoUI\Media\Statusbars\tim.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Mauk", [[Interface\Addons\MangoUI\Media\Statusbars\mauk.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Brink", [[Interface\Addons\MangoUI\Media\Statusbars\brink.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Mango", [[Interface\Addons\MangoUI\Media\Statusbars\mango.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Nucks", [[Interface\Addons\MangoUI\Media\Statusbars\nucks.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Liv", [[Interface\Addons\MangoUI\Media\Statusbars\liv.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Vvik", [[Interface\Addons\MangoUI\Media\Statusbars\vvik.tga]])

-- Borders

-- Sounds
