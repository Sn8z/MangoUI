local _, mUI = ...

function mUI:CreateScrollbox(parent)
	local scrollBarWidth = 12

	local scrollFrame = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", 5, -5)
	scrollFrame:SetPoint("BOTTOMRIGHT", -(scrollBarWidth + 15), 5)

	local scroll = scrollFrame.ScrollBar
	scroll:SetWidth(scrollBarWidth)
	scroll:SetThumbTexture([[Interface\AddOns\MangoUI\Media\white.tga]])
	scroll.ThumbTexture:SetSize(scrollBarWidth, 2 * scrollBarWidth)

	local scrollUp = scroll.ScrollUpButton
	scrollUp:SetNormalTexture([[Interface\AddOns\MangoUI\Media\white.tga]])
	scrollUp:SetPushedTexture([[Interface\AddOns\MangoUI\Media\red.tga]])
	scrollUp:SetDisabledTexture([[Interface\AddOns\MangoUI\Media\green.tga]])
	scrollUp:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\yellow.tga]])
	scrollUp:SetSize(scrollBarWidth, scrollBarWidth)

	local scrollDown = scroll.ScrollDownButton
	scrollDown:SetNormalTexture([[Interface\AddOns\MangoUI\Media\white.tga]])
	scrollDown:SetPushedTexture([[Interface\AddOns\MangoUI\Media\red.tga]])
	scrollDown:SetDisabledTexture([[Interface\AddOns\MangoUI\Media\green.tga]])
	scrollDown:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\yellow.tga]])
	scrollDown:SetSize(scrollBarWidth, scrollBarWidth)

	local scrollChild = CreateFrame("Frame")
	scrollFrame:SetScrollChild(scrollChild)
	scrollChild:SetWidth(scrollFrame:GetWidth() - scrollBarWidth)
	scrollChild:SetHeight(1)

	return scrollChild
end
