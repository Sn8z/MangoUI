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

-- Inter
LSM:Register(LSM.MediaType.FONT, "Inter",
	[[Interface\Addons\MangoUI\Media\Fonts\Inter\Inter-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Inter Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Inter\Inter-Bold.ttf]])

-- Mulish
LSM:Register(LSM.MediaType.FONT, "Mulish",
	[[Interface\Addons\MangoUI\Media\Fonts\Mulish\Mulish-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Mulish Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Mulish\Mulish-Bold.ttf]])

-- Nunito
LSM:Register(LSM.MediaType.FONT, "Nunito",
	[[Interface\Addons\MangoUI\Media\Fonts\Nunito\Nunito-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Nunito Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Nunito\Nunito-Bold.ttf]])

-- Onest
LSM:Register(LSM.MediaType.FONT, "Onest",
	[[Interface\Addons\MangoUI\Media\Fonts\Onest\Onest-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Onest Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Onest\Onest-Bold.ttf]])

-- Outfit
LSM:Register(LSM.MediaType.FONT, "Outfit",
	[[Interface\Addons\MangoUI\Media\Fonts\Outfit\Outfit-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Outfit Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Outfit\Outfit-Bold.ttf]])

-- Overpass
LSM:Register(LSM.MediaType.FONT, "Overpass",
	[[Interface\Addons\MangoUI\Media\Fonts\Overpass\Overpass-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Overpass Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Overpass\Overpass-Bold.ttf]])

-- Poppins
LSM:Register(LSM.MediaType.FONT, "Poppins",
	[[Interface\Addons\MangoUI\Media\Fonts\Poppins\Poppins-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Poppins Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Poppins\Poppins-Bold.ttf]])

-- SUSE
LSM:Register(LSM.MediaType.FONT, "SUSE",
	[[Interface\Addons\MangoUI\Media\Fonts\SUSE\SUSE-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "SUSE Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\SUSE\SUSE-Bold.ttf]])

-- Tektur
LSM:Register(LSM.MediaType.FONT, "Tektur",
	[[Interface\Addons\MangoUI\Media\Fonts\Tektur\Tektur-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Tektur Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Tektur\Tektur-Bold.ttf]])

-- Ubuntu
LSM:Register(LSM.MediaType.FONT, "Ubuntu",
	[[Interface\Addons\MangoUI\Media\Fonts\Ubuntu\Ubuntu-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Ubuntu Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Ubuntu\Ubuntu-Bold.ttf]])

-- Statusbars (.tga/.blp)
LSM:Register(LSM.MediaType.STATUSBAR, "Sn8z", [[Interface\Addons\MangoUI\Media\Statusbars\sn8z.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Erik", [[Interface\Addons\MangoUI\Media\Statusbars\erik.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Tim", [[Interface\Addons\MangoUI\Media\Statusbars\tim.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Maukie", [[Interface\Addons\MangoUI\Media\Statusbars\maukie.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Brink", [[Interface\Addons\MangoUI\Media\Statusbars\brink.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "MangoFocus", [[Interface\Addons\MangoUI\Media\Statusbars\mangofocus.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Nucks", [[Interface\Addons\MangoUI\Media\Statusbars\nucks.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Liv", [[Interface\Addons\MangoUI\Media\Statusbars\liv.tga]])
LSM:Register(LSM.MediaType.STATUSBAR, "Vesper", [[Interface\Addons\MangoUI\Media\Statusbars\vesper.tga]])

-- Borders
LSM:Register(LSM.MediaType.BORDER, "MangoRound", [[Interface\AddOns\MangoUI\Media\Borders\mangoround.tga]])
LSM:Register(LSM.MediaType.BORDER, "MangoSquare", [[Interface\AddOns\MangoUI\Media\Borders\mangobasic.tga]])
LSM:Register(LSM.MediaType.BORDER, "MangoGlow", [[Interface\AddOns\MangoUI\Media\Borders\mangoglow.tga]])

-- Sounds
