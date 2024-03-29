local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local playerColor = mUI:GetClassColor("player")

function mUI:CreateCheckBox(labelText, value, frame, callback)
	local checkbox = CreateFrame("CheckButton", nil, frame, "BackdropTemplate")
	checkbox:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1
	})
	checkbox:SetBackdropColor(0, 0, 0, 1)
	checkbox:SetBackdropBorderColor(0.25, 0.25, 0.25, 1)
	checkbox:SetSize(18, 18)
	checkbox:SetChecked(value)
	checkbox:SetCheckedTexture([[Interface\AddOns\MangoUI\Media\white.tga]])
	local checkedTexture = checkbox:GetCheckedTexture()
	checkedTexture:SetVertexColor(playerColor.r, playerColor.g, playerColor.b, 1)
	checkedTexture:SetPoint("TOPLEFT", 1, -1)
	checkedTexture:SetPoint("BOTTOMRIGHT", -1, 1)
	checkbox:SetDisabledCheckedTexture([[Interface\AddOns\MangoUI\Media\white.tga]])
	checkbox:HookScript("OnClick", function(self)
		callback(self:GetChecked())
	end)

	local label = checkbox:CreateFontString(nil, "OVERLAY")
	label:SetPoint("LEFT", checkbox, "RIGHT", 5, 0)
	label:SetJustifyH("LEFT")
	label:SetFont(LSM:Fetch("font", "Onest Semi Bold"), 10, "THINOUTLINE")
	label:SetText(labelText)
	label:SetTextColor(1, 1, 1, 1)

	return checkbox
end
