local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local tooltips = {
	'GameTooltip',
	'ItemRefTooltip',
	'ItemRefShoppingTooltip1',
	'ItemRefShoppingTooltip2',
	'ShoppingTooltip1',
	'ShoppingTooltip2',
	'DropDownList1MenuBackdrop',
	'DropDownList2MenuBackdrop',
}

function mUI:CustomizeTooltip()
	for i = 1, #tooltips do
		local frame = _G[tooltips[i]]
		frame.NineSlice:SetCenterColor(0, 0, 0, 1)
		frame.NineSlice:SetVertexColor(0.25, 0.25, 0.25, 1)
	end

	GameTooltipStatusBar:ClearAllPoints()
	GameTooltipStatusBar:SetHeight(8)
	GameTooltipStatusBar:SetPoint("LEFT", 20, 0)
	GameTooltipStatusBar:SetPoint("RIGHT", -20, 0)
	GameTooltipStatusBar:SetPoint("BOTTOM", 0, 0)
	GameTooltipStatusBar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.config.defaultTexture))

	mUI:CreateBackdrop(GameTooltipStatusBar)
end

local f = CreateFrame("frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event)
	if event == "ADDON_LOADED" then
		mUI:CustomizeTooltip()
	end
end)
