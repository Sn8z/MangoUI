local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local function btnEnter(self)
	self:SetBackdropColor(0.2, 0.2, 0.2, 1)
	self:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
end

local function btnMouseDown(self)
	self:SetBackdropColor(0.4, 0.4, 0.4, 1)
	self:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
	self.label:AdjustPointsOffset(0, -1)
end

local function btnReset(self)
	self:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
	self:SetBackdropBorderColor(0, 0, 0, 1)
	self.label:SetPoint("CENTER")
end

function mUI:CreateButton(width, height, text, frame, callback)
	local button = CreateFrame("Button", nil, frame, "BackdropTemplate")
	button:SetSize(width, height)
	button:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1
	})
	button:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
	button:SetBackdropBorderColor(0, 0, 0, 1)
	button:SetScript("OnEnter", btnEnter)
	button:SetScript("OnLeave", btnReset)
	button:SetScript("OnMouseDown", btnMouseDown)
	button:SetScript("OnMouseUp", btnReset)
	button:SetScript("OnClick", callback)

	local label = button:CreateFontString(nil, "OVERLAY")
	label:SetPoint("CENTER")
	label:SetJustifyH("CENTER")
	label:SetFont(LSM:Fetch("font", "Onest Bold"), 14, "THINOUTLINE")
	label:SetText(text)
	label:SetTextColor(0.8, 0.8, 0.8, 1)
	button.label = label

	return button
end
