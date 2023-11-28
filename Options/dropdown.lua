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
	local ddBtn, ddFrame, ddParent, ddChild

	ddBtn = CreateFrame("Button", nil, frame, "BackdropTemplate")
	ddBtn:SetSize(200, 24)
	ddBtn:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 2
	})
	ddBtn:SetBackdropColor(0.1, 0.1, 0.1, 1)
	ddBtn:SetBackdropBorderColor(0, 0, 0, 1)
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
	label:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 12, "THINOUTLINE")
	label:SetText(text)
	label:SetTextColor(0.8, 0.8, 0.8, 1)
	ddBtn.label = label

	ddFrame = CreateFrame("Frame", nil, ddBtn, "BackdropTemplate")
	ddFrame:SetPoint("TOPLEFT", ddBtn, "BOTTOMLEFT", 0, -5)
	ddFrame:SetSize(240, 400)
	ddFrame:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 2,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	})
	ddFrame:SetBackdropColor(0.1, 0.1, 0.1, 1)
	ddFrame:SetBackdropBorderColor(0, 0, 0, 1)
	ddFrame:SetFrameStrata("FULLSCREEN_DIALOG")
	ddFrame:SetClampedToScreen(true)
	ddFrame:Hide()

	ddParent = CreateFrame("ScrollFrame", "dropdownParent", ddFrame, "UIPanelScrollFrameTemplate")
	ddParent:SetPoint("TOPLEFT", 4, -4)
	ddParent:SetPoint("BOTTOMRIGHT", -27, 4)

	ddChild = CreateFrame("Frame", nil, ddParent)
	ddParent:SetScrollChild(ddChild)
	ddChild:SetHeight(1)
	ddChild:SetWidth(1)

	ddParent.items = {}
	local function CreateDropdownItem(text, func)
		local item = CreateFrame("Button", nil, ddChild)
		item:SetSize(200, 20)
		item:SetText(text)
		item:SetNormalFontObject("GameFontNormal")
		item:SetHighlightFontObject("GameFontHighlight")
		item:SetPoint("TOPLEFT", 0, -((#ddParent.items * 20)))
		item:SetScript("OnClick", func)

		if isTexture == true then
			item:SetNormalTexture(LSM:Fetch("statusbar", text))
		end

		ddParent.items[#ddParent.items + 1] = item
	end

	for _, v in pairs(values) do
		CreateDropdownItem(v, function()
			print(v)
			callback(v)
			ddBtn.label:SetText(v)
			ddFrame:Hide()
		end)
	end

	local label = ddBtn:CreateFontString(nil, "ARTWORK")
	label:SetPoint("BOTTOMLEFT", ddBtn, "TOPLEFT", 0, 5)
	label:SetJustifyH("LEFT")
	label:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 10, "THINOUTLINE")
	label:SetText(labelText)
	label:SetTextColor(1, 1, 1, 1)

	return ddBtn
end

--function mUI:CreateDropdown(labelText, text, values, frame, callback)
--	local dropdown = CreateFrame("Frame", nil, frame, "UIDropDownMenuTemplate")
--	UIDropDownMenu_SetWidth(dropdown, 200)
--	UIDropDownMenu_SetText(dropdown, text)
--	UIDropDownMenu_Initialize(dropdown, function(self, level, _)
--		local info = UIDropDownMenu_CreateInfo()
--		for _, v in pairs(values) do
--			info.text, info.arg1 = v, v
--			info.func = function(self, arg1, arg2, checked)
--				UIDropDownMenu_SetText(dropdown, arg1)
--				callback(arg1)
--				CloseDropDownMenus()
--			end
--			UIDropDownMenu_AddButton(info, level)
--		end
--	end)
--
--	local label = dropdown:CreateFontString(nil, "OVERLAY")
--	label:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 20, 5)
--	label:SetJustifyH("LEFT")
--	label:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 10, "THINOUTLINE")
--	label:SetText(labelText)
--	label:SetTextColor(1, 1, 1, 1)
--
--	return dropdown
--end
