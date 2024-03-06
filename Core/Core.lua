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

-- Ubuntu
LSM:Register(LSM.MediaType.FONT, "Ubuntu Light",
	[[Interface\Addons\MangoUI\Media\Fonts\Ubuntu\Ubuntu-Light.ttf]])
LSM:Register(LSM.MediaType.FONT, "Ubuntu",
	[[Interface\Addons\MangoUI\Media\Fonts\Ubuntu\Ubuntu-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Ubuntu Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Ubuntu\Ubuntu-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Ubuntu Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Ubuntu\Ubuntu-Bold.ttf]])

-- Overpass
LSM:Register(LSM.MediaType.FONT, "Overpass Light",
	[[Interface\Addons\MangoUI\Media\Fonts\Overpass\Overpass-Light.ttf]])
LSM:Register(LSM.MediaType.FONT, "Overpass",
	[[Interface\Addons\MangoUI\Media\Fonts\Overpass\Overpass-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Overpass Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Overpass\Overpass-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Overpass Semi Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Overpass\Overpass-SemiBold.ttf]])
LSM:Register(LSM.MediaType.FONT, "Overpass Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Overpass\Overpass-Bold.ttf]])

-- Onest
LSM:Register(LSM.MediaType.FONT, "Onest Light",
	[[Interface\Addons\MangoUI\Media\Fonts\Onest\Onest-Light.ttf]])
LSM:Register(LSM.MediaType.FONT, "Onest",
	[[Interface\Addons\MangoUI\Media\Fonts\Onest\Onest-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Onest Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Onest\Onest-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Onest Semi Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Onest\Onest-SemiBold.ttf]])
LSM:Register(LSM.MediaType.FONT, "Onest Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Onest\Onest-Bold.ttf]])

-- Mulish
LSM:Register(LSM.MediaType.FONT, "Mulish Light",
	[[Interface\Addons\MangoUI\Media\Fonts\Mulish\Mulish-Light.ttf]])
LSM:Register(LSM.MediaType.FONT, "Mulish",
	[[Interface\Addons\MangoUI\Media\Fonts\Mulish\Mulish-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Mulish Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Mulish\Mulish-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Mulish Semi Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Mulish\Mulish-SemiBold.ttf]])
LSM:Register(LSM.MediaType.FONT, "Mulish Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Mulish\Mulish-Bold.ttf]])

-- Nunito
LSM:Register(LSM.MediaType.FONT, "Nunito Light",
	[[Interface\Addons\MangoUI\Media\Fonts\Nunito\Nunito-Light.ttf]])
LSM:Register(LSM.MediaType.FONT, "Nunito",
	[[Interface\Addons\MangoUI\Media\Fonts\Nunito\Nunito-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Nunito Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Nunito\Nunito-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Nunito Semi Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Nunito\Nunito-SemiBold.ttf]])
LSM:Register(LSM.MediaType.FONT, "Nunito Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Nunito\Nunito-Bold.ttf]])

-- Inter
LSM:Register(LSM.MediaType.FONT, "Inter Light",
	[[Interface\Addons\MangoUI\Media\Fonts\Inter\Inter-Light.ttf]])
LSM:Register(LSM.MediaType.FONT, "Inter",
	[[Interface\Addons\MangoUI\Media\Fonts\Inter\Inter-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Inter Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Inter\Inter-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Inter Semi Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Inter\Inter-SemiBold.ttf]])
LSM:Register(LSM.MediaType.FONT, "Inter Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Inter\Inter-Bold.ttf]])

-- Tektur
LSM:Register(LSM.MediaType.FONT, "Tektur",
	[[Interface\Addons\MangoUI\Media\Fonts\Tektur\Tektur-Regular.ttf]])
LSM:Register(LSM.MediaType.FONT, "Tektur Medium",
	[[Interface\Addons\MangoUI\Media\Fonts\Tektur\Tektur-Medium.ttf]])
LSM:Register(LSM.MediaType.FONT, "Tektur Semi Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Tektur\Tektur-SemiBold.ttf]])
LSM:Register(LSM.MediaType.FONT, "Tektur Bold",
	[[Interface\Addons\MangoUI\Media\Fonts\Tektur\Tektur-Bold.ttf]])

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
