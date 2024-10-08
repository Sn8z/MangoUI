local addonName, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local function fixFonts()
	local FONT                         = LSM:Fetch("font", mUI.profile.settings.font)

	UIDROPDOWNMENU_DEFAULT_TEXT_HEIGHT = 12
	CHAT_FONT_HEIGHTS                  = { 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 }

	STANDARD_TEXT_FONT                 = FONT
	UNIT_NAME_FONT                     = FONT
	DAMAGE_TEXT_FONT                   = FONT
	NAMEPLATE_FONT                     = FONT
	NAMEPLATE_SPELLCAST_FONT           = FONT
	UNIT_NAME_FONT_ROMAN               = FONT

	local fonts                        = {
		-- /Interface/FrameXML/Fonts.xml
		SystemFont_Outline_Small,
		SystemFont_Outline,
		SystemFont_InverseShadow_Small,
		SystemFont_Huge1,
		SystemFont_Huge1_Outline,
		SystemFont_OutlineThick_Huge2,
		SystemFont_OutlineThick_Huge4,
		SystemFont_OutlineThick_WTF,
		NumberFont_GameNormal,
		NumberFont_OutlineThick_Mono_Small,
		Number12Font_o1,
		NumberFont_Small,
		Number11Font,
		Number12Font,
		Number12FontOutline,
		Number13Font,
		PriceFont,
		Number15Font,
		Number16Font,
		Number18Font,
		NumberFont_Normal_Med,
		NumberFont_Outline_Med,
		NumberFont_Outline_Large,
		NumberFont_Outline_Huge,
		Fancy22Font,
		QuestFont_Outline_Huge,
		QuestFont_Super_Huge,
		QuestFont_Super_Huge_Outline,
		SplashHeaderFont,
		Game11Font_Shadow,
		Game11Font,
		Game12Font,
		Game13Font,
		Game13FontShadow,
		Game15Font,
		Game18Font,
		Game20Font,
		Game24Font,
		Game27Font,
		Game32Font,
		Game36Font,
		Game40Font,
		Game42Font,
		Game46Font,
		Game48Font,
		Game48FontShadow,
		Game60Font,
		Game120Font,
		Game11Font_o1,
		Game12Font_o1,
		Game13Font_o1,
		Game15Font_o1,
		QuestFont_Enormous,
		DestinyFontMed,
		DestinyFontLarge,
		CoreAbilityFont,
		OrderHallTalentRowFont,
		DestinyFontHuge,
		QuestFont_Shadow_Small,
		MailFont_Large,
		SpellFont_Small,
		InvoiceFont_Med,
		InvoiceFont_Small,
		AchievementFont_Small,
		ReputationDetailFont,
		FriendsFont_Normal,
		FriendsFont_11,
		FriendsFont_Small,
		FriendsFont_Large,
		FriendsFont_UserText,
		GameFont_Gigantic,
		ChatBubbleFont,
		Fancy12Font,
		Fancy14Font,
		Fancy16Font,
		Fancy18Font,
		Fancy20Font,
		Fancy24Font,
		Fancy27Font,
		Fancy30Font,
		Fancy32Font,
		Fancy36Font,
		Fancy40Font,
		Fancy48Font,
		SystemFont_NamePlateFixed,
		SystemFont_LargeNamePlateFixed,
		SystemFont_NamePlate,
		SystemFont_LargeNamePlate,
		SystemFont_NamePlateCastBar,
		-- /SharedXML/SharedFonts.xml
		SystemFont_Tiny2,
		SystemFont_Tiny,
		SystemFont_Shadow_Small,
		Game10Font_o1,
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
		SystemFont_Large2,
		SystemFont_Shadow_Large2,
		SystemFont_Shadow_Large2_Outline,
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
		-- /Interface/GlueXML/GlueFonts.xml
		SystemFont_Shadow_Outline_Small,
		SystemFont_Outline_Med1,
		SystemFont_Outline_Med2,
		SystemFont_Shadow_Outline_Large,
		SystemFont_Shadow_Outline_Gigantor,
		EditBoxFont_Large,
		NumberFont_OutlineThick_Med1,
		NumberFont_OutlineThick_Med2,
		OptionsFont,
		OptionsFontSmall,
		OptionsFontLarge,
		OptionsFontHighlight,
		OptionsFontHighlightSmall,
		FactionName_Shadow_Medium,
		FactionName_Shadow_Large,
		FactionName_Shadow_Huge,
		ObjectiveTrackerLineFont,
		ObjectiveTrackerHeaderFont,
	}

	for _, font in pairs(fonts) do
		local _, size, style = font:GetFont()
		font:SetFont(FONT, size or 12, style)
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(_, _, loadedAddon)
	if addonName == loadedAddon then
		fixFonts()
	end
end)
