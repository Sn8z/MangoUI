local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local function skinTooltip(self)
	if not self then return end
	Mixin(self, BackdropTemplateMixin)
	self:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 2
	})
	self:SetBackdropColor(0, 0, 0, 0.8)
	self:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)

	-- Hide original background and border
	if self.NineSlice then
		self.NineSlice:SetBorderColor(0, 0, 0, 0)
		self.NineSlice:SetVertexColor(0, 0, 0, 0)
	end
end

function mUI:SkinTooltips()
	local tooltips = {
		ItemRefTooltip,
		ItemRefShoppingTooltip1,
		ItemRefShoppingTooltip2,
		FriendsTooltip,
		WarCampaignTooltip,
		EmbeddedItemTooltip,
		ReputationParagonTooltip,
		GameTooltip,
		ShoppingTooltip1,
		ShoppingTooltip2,
		QuickKeybindTooltip,
		GameSmallHeaderTooltip,
		QuestScrollFrame.StoryTooltip,
		QuestScrollFrame.CampaignTooltip,
		SettingsTooltip,
		ChatMenu
	}
	for _, tooltip in next, tooltips do
		skinTooltip(tooltip)
	end

	-- Skin Statusbar of tooltip
	GameTooltipStatusBar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.healthTexture))
	GameTooltipStatusBar:ClearAllPoints()
	GameTooltipStatusBar:SetPoint("LEFT", GameTooltip, "BOTTOMLEFT", 12, 0)
	GameTooltipStatusBar:SetPoint("RIGHT", GameTooltip, "BOTTOMRIGHT", -12, 0)
	mUI:CreateBorder(GameTooltipStatusBar)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
	if mUI.profile.settings.tooltip.enabled then
		mUI:SkinTooltips()
	end
end)
