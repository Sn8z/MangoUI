local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local function btnEnter(self)
	self:SetBackdropColor(0.2, 0.2, 0.2, 1)
	self:SetBackdropBorderColor(0.3, 0.3, 0.3, 1)
end

local function btnMouseDown(self)
	self:SetBackdropColor(0.4, 0.4, 0.4, 1)
	self:SetBackdropBorderColor(0.5, 0.5, 0.5, 1)
end

local function btnReset(self)
	self:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
	self:SetBackdropBorderColor(0, 0, 0, 1)
end

function mUI:CreateDropdown(labelText, text, values, frame, callback, isTexture)
	local ddBtn, ddFrame

	ddBtn = CreateFrame("Button", nil, frame, "BackdropTemplate")
	ddBtn:SetSize(220, 24)
	ddBtn:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1
	})
	ddBtn:SetBackdropColor(0.1, 0.1, 0.1, 1)
	ddBtn:SetBackdropBorderColor(0, 0, 0, 1)
	if isTexture then
		ddBtn:SetNormalTexture(LSM:Fetch("statusbar", text))
	end
	ddBtn:SetScript("OnEnter", btnEnter)
	ddBtn:SetScript("OnLeave", btnReset)
	ddBtn:SetScript("OnMouseDown", btnMouseDown)
	ddBtn:SetScript("OnMouseUp", btnReset)
	ddBtn:SetScript("OnClick", function()
		if ddFrame:IsShown() then
			ddFrame:Hide()
		else
			ddFrame:Show()
		end
	end)

	local label = ddBtn:CreateFontString(nil, "ARTWORK")
	label:SetPoint("LEFT", 5, 0)
	label:SetJustifyH("LEFT")
	label:SetFont(LSM:Fetch("font", "Onest Semi Bold"), 12, "THINOUTLINE")
	label:SetText(text)
	label:SetTextColor(0.8, 0.8, 0.8, 1)
	ddBtn.label = label

	ddFrame = CreateFrame("Frame", nil, ddBtn, "BackdropTemplate")
	ddFrame:SetPoint("TOPLEFT", ddBtn, "BOTTOMLEFT", 0, 0)
	ddFrame:SetSize(220, 200)
	ddFrame:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1,
		insets = { left = 1, right = 1, top = 1, bottom = 1 }
	})
	ddFrame:SetBackdropColor(0.1, 0.1, 0.1, 1)
	ddFrame:SetBackdropBorderColor(0, 0, 0, 1)
	ddFrame:SetFrameStrata("FULLSCREEN_DIALOG")
	ddFrame:SetClampedToScreen(true)
	ddFrame:Hide()

	local scroll = mUI:CreateScrollbox(ddFrame)

	scroll.items = {}
	local function CreateDropdownItem(text, func)
		local item = mUI:CreateButton(216, 20, text, scroll, func)
		item:SetPoint("TOPLEFT", 0, -(#scroll.items * 23))

		if isTexture then
			item:SetNormalTexture(LSM:Fetch("statusbar", text))
		end

		scroll.items[#scroll.items + 1] = item
	end

	for _, v in pairs(values) do
		CreateDropdownItem(v, function()
			callback(v)
			ddBtn.label:SetText(v)
			if isTexture then
				ddBtn:SetNormalTexture(LSM:Fetch("statusbar", v))
			end
			ddFrame:Hide()
		end)
	end

	local label = ddBtn:CreateFontString(nil, "ARTWORK")
	label:SetPoint("BOTTOMLEFT", ddBtn, "TOPLEFT", 0, 5)
	label:SetJustifyH("LEFT")
	label:SetFont(LSM:Fetch("font", "Onest Semi Bold"), 12, "THINOUTLINE")
	label:SetText(labelText)
	label:SetTextColor(1, 1, 1, 1)

	return ddBtn
end
