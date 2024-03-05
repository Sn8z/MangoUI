local _, mUI = ...

function mUI:CreateScrollbox(parent)
	local scrollBarWidth = 12

	local scrollFrame = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", 5, -5)
	scrollFrame:SetPoint("BOTTOMRIGHT", -(scrollBarWidth + 15), 5)

	local scroll = scrollFrame.ScrollBar
	Mixin(scroll, BackdropTemplateMixin)
	scroll:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1
	})
	scroll:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
	scroll:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
	scroll:SetWidth(scrollBarWidth)
	scroll:SetThumbTexture([[Interface\AddOns\MangoUI\Media\white.tga]])
	scroll.ThumbTexture:SetSize(scrollBarWidth, 2 * scrollBarWidth)
	scroll.ThumbTexture:SetVertexColor(0.75, 0.75, 0.75, 0.8)

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
