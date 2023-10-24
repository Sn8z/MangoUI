local _, mUI = ...

local slider, editBox, label

local function ebEscape(self)
	self:ClearFocus()
end

local function ebEnter(self)
	local value = self:GetText()
	value = tonumber(value)

	if value then
		slider:SetValue(value)
	end
end

function mUI:CreateSlider(min, max, step, labelText, value, frame, callback)
	slider = CreateFrame("Slider", nil, frame, "BackdropTemplate")
	slider:SetOrientation("HORIZONTAL")
	slider:SetHeight(14)
	slider:SetWidth(200)
	slider:SetValueStep(step)
	slider:SetObeyStepOnDrag(true)
	slider:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1
	})
	slider:SetBackdropColor(0, 0, 0, 1)
	slider:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
	slider:SetThumbTexture([[Interface\AddOns\MangoUI\Media\yellow.tga]])
	slider:GetThumbTexture():SetSize(8,18)
	slider:SetMinMaxValues(min, max)
	slider:SetValue(value)
	slider:SetScript("OnValueChanged", function(self, value, userInput)
		editBox:SetText(value)
		callback(value)
	end)

	local lowtext = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	lowtext:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 5, -5)
	lowtext:SetText(min)

	local hightext = slider:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmall")
	hightext:SetPoint("TOPRIGHT", slider, "BOTTOMRIGHT", -5, -5)
	hightext:SetText(max)

	label = slider:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	label:SetPoint("BOTTOM", slider, "TOP", 0, 5)
	label:SetJustifyH("CENTER")
	label:SetHeight(15)
	label:SetText(labelText)

	editBox = CreateFrame("EditBox", nil, frame, "BackdropTemplate")
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(GameFontHighlightSmall)
	editBox:SetPoint("TOP", slider, "BOTTOM")
	editBox:SetHeight(14)
	editBox:SetWidth(70)
	editBox:SetJustifyH("CENTER")
	editBox:SetText(value)
	editBox:EnableMouse(true)
	editBox:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1
	})
	editBox:SetBackdropColor(0, 0, 0, 0.5)
	editBox:SetBackdropBorderColor(0.3, 0.3, 0.30, 0.80)
	editBox:SetScript("OnEnterPressed", ebEnter)
	editBox:SetScript("OnEscapePressed", ebEscape)
	return slider
end
