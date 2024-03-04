local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateArea(labelText, parent)
	local area = CreateFrame("Frame", nil, parent, "BackdropTemplate")
	area:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1,
	})
	area:SetBackdropColor(0.08, 0.08, 0.08, 1)
	area:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)

	local label = area:CreateFontString(nil, "OVERLAY")
	label:SetPoint("LEFT", area, "TOPLEFT", 10, 0)
	label:SetJustifyH("LEFT")
	label:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 14, "THINOUTLINE")
	label:SetText(labelText)
	label:SetTextColor(0.8, 0.8, 0.8, 1)
	return area
end
