local addon, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local function fixFonts()
	-- TODO: Make this a setting
	local FONT                         = LSM:Fetch("font", mUI.profile.settings.font)
	--local FONT                         = [[Interface\AddOns\MangoUI\Media\Fonts\Poppins\Poppins-Medium.ttf]]

	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12
	CHAT_FONT_HEIGHTS                  = { 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 }

	STANDARD_TEXT_FONT                 = FONT
	UNIT_NAME_FONT                     = FONT
	DAMAGE_TEXT_FONT                   = FONT
	NAMEPLATE_FONT                     = FONT
	NAMEPLATE_SPELLCAST_FONT           = FONT
	UNIT_NAME_FONT_ROMAN               = FONT

	-- Sourced from /SharedXML/SharedFonts.xml etc.
	local FontObjects                  = {
		FriendsFont_Normal,
		FriendsFont_Small,
		WhiteNormalNumberFont,
		SystemFont_Tiny2,
		SystemFont_Tiny,
		SystemFont_Shadow_Small,
		Game10Font_o1,
		Game13Font_o1,
		Game13Font,
		Game12Font_o1,
		Game11Font_o1,
		SystemFont_Small,
		SystemFont_Small2,
		SystemFont_Shadow_Small2,
		SystemFont_Shadow_Small_Outline,
		SystemFont_Shadow_Small2_Outline,
		SystemFont_Shadow_Med1_Outline,
		SystemFont_Shadow_Med1,
		SystemFont_Med2,
		SystemFont_Med3,
		SystemFont_Shadow_Med3,
		SystemFont_Shadow_Med3_Outline,
		QuestFont_Large,
		QuestFont_Huge,
		QuestFont_30,
		QuestFont_39,
		SystemFont_Large,
		SystemFont_Shadow_Large_Outline,
		SystemFont_Shadow_Med2,
		SystemFont_Shadow_Med2_Outline,
		SystemFont_Shadow_Large,
		SystemFont_Shadow_Large2,
		Game17Font_Shadow,
		SystemFont_Shadow_Huge1,
		SystemFont_Shadow_Huge1_Outline,
		SystemFont_Huge2,
		SystemFont_Shadow_Huge2,
		SystemFont_Shadow_Huge2_Outline,
		SystemFont_Shadow_Huge3,
		SystemFont_Shadow_Outline_Huge3,
		SystemFont_Huge4,
		SystemFont_Shadow_Huge4,
		SystemFont_Shadow_Huge4_Outline,
		SystemFont_World,
		SystemFont_World_ThickOutline,
		SystemFont22_Outline,
		SystemFont22_Shadow_Outline,
		SystemFont16_Shadow_ThickOutline,
		SystemFont18_Shadow_ThickOutline,
		SystemFont22_Shadow_ThickOutline,
		SystemFont_Med1,
		SystemFont_WTF2,
		SystemFont_Outline_WTF2,
		GameTooltipHeader,
		System_IME,
		NumberFont_Shadow_Tiny,
		NumberFont_Shadow_Small,
		NumberFont_Shadow_Med,
		NumberFont_Shadow_Large,
		ChatFontNormal,
		ConsoleFontNormal,
		ConsoleFontSmall,
		Tooltip_Med,
		Tooltip_Small,
		System15Font,
		Game16Font,
		Game30Font,
		Game32Font_Shadow2,
		Game36Font_Shadow2,
		Game40Font_Shadow2,
		Game46Font_Shadow2,
		Game52Font_Shadow2,
		Game58Font_Shadow2,
		Game69Font_Shadow2,
		Game72Font,
		Game72Font_Shadow,
		GameFontNormal,
		GameFontNormal_NoShadow,
		GameFontNormalCenter,
		GameFontDisable,
		GameFontHighlight,
		GameFontHighlight_NoShadow,
		GameFontHighlightLeft,
		GameFontHighlightCenter,
		GameFontHighlightRight,
		GameFontNormalHuge,
		GameFontHighlightHuge,
		GameFontDisableHuge,
		GameFontNormalSmall,
		GameFontNormalTiny,
		GameFontWhiteTiny,
		GameFontDisableTiny,
		GameFontBlackTiny,
		GameFontNormalTiny2,
		GameFontWhiteTiny2,
		GameFontDisableTiny2,
		GameFontBlackTiny2,
		GameFontNormalMed1,
		GameFontNormalMed2,
		GameFontNormalLarge,
		GameFontNormalMed2Outline,
		GameFontNormalLargeOutline,
		GameFontDisableSmall,
		GameFontDisableSmall2,
		GameFontNormalShadowOutline22,
		GameFontHighlightShadowOutline22,
		GameFontNormalOutline,
		GameFontHighlightOutline,
		QuestFontNormalLarge,
		QuestFontNormalHuge,
		QuestFontHighlightHuge,
		GameFontHighlightMedium,
		GameFontBlackMedium,
		GameFontBlackSmall,
		GameFontRed,
		GameFontRedLarge,
		GameFontGreen,
		GameFontBlack,
		GameFontWhite,
		GameFontHighlightMed2,
		GameFontHighlightLarge,
		GameFontNormalMed3,
		GameFontNormalMed3Outline,
		GameFontDisableMed3,
		GameFontDisableLarge,
		GameFontDisableMed2,
		GameFontHighlightSmall,
		GameFontNormalSmallLeft,
		GameFontHighlightSmallLeft,
		GameFontDisableSmallLeft,
		GameFontHighlightSmall2,
		GameFontBlackSmall2,
		GameFontNormalSmall2,
		GameFontNormalLarge2,
		GameFontHighlightLarge2,
		GameFontNormalWTF2,
		GameFontNormalWTF2Outline,
		GameFontNormalHuge2,
		GameFontHighlightHuge2,
		GameFontNormalShadowHuge2,
		GameFontHighlightShadowHuge2,
		GameFontNormalOutline22,
		GameFontHighlightOutline22,
		GameFontDisableOutline22,
		GameFontNormalHugeOutline,
		GameFontNormalHuge3,
		GameFontNormalHuge3Outline,
		GameFontNormalHuge4,
		GameFontNormalHuge4Outline,
		GameFont72Normal,
		GameFont72Highlight,
		GameFont72NormalShadow,
		GameFont72HighlightShadow,
		GameTooltipHeaderText,
		GameTooltipText,
		GameTooltipTextSmall,
		IMENormal,
		IMEHighlight,
		MovieSubtitleFont,
		SystemFont_Huge1_Outline,
		WorldMapFrameHomeButtonText,
		ContainerFrameCombinedBagsGoldButtonText,
		ContainerFrameCombinedBagsSilverButtonText,
		ContainerFrameCombinedBagsCopperButtonText,
		Game15Font_o1,
		CombatTextFont,
		CombatTextTemplate,
		CombatText1,
		CombatText2,
		CombatText3,
		CombatText4,
		CombatText5,
		CombatText6,
		CombatText7,
		CombatText8,
		CombatText9,
		CombatText10,
		CombatText11,
		CombatText12,
		CombatText13,
		CombatText14,
		CombatText15,
		CombatText16,
		CombatText17,
		CombatText18,
		CombatText19,
		CombatText20,
		Game18Font,
		ChatBubbleFont,
		ZoneTextFont,
		SubZoneTextFont,
		PVPInfoTextFont,
		GameFontNormalLarge,
		GameFont_Gigantic,
		Fancy30Font,
		DestinyFontHuge,
		NumberFontNormal,
		PriceFont,
		Number13FontWhite,
		Number14FontWhite,
		Number15FontWhite,
		NumberFontNormalRightRed,
		NumberFont_Normal_Med,
	}

	for i, FontObject in pairs(FontObjects) do
		local _, size, style = FontObject:GetFont()
		FontObject:SetFont(FONT, size or 12, style)
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
--f:RegisterEvent("VARIABLES_LOADED")
f:SetScript("OnEvent", function()
	fixFonts()
end)
