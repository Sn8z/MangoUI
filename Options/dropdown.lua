local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateDropdown(labelText, text, values, frame, callback)
	local dropdown = CreateFrame("Frame", nil, frame, "UIDropDownMenuTemplate")
	UIDropDownMenu_SetWidth(dropdown, 200)
	UIDropDownMenu_SetText(dropdown, text)
	UIDropDownMenu_Initialize(dropdown, function(self, level, _)
		local info = UIDropDownMenu_CreateInfo()
		for _, v in pairs(values) do
			info.text, info.arg1 = v, v
			info.func = function(self, arg1, arg2, checked)
				UIDropDownMenu_SetText(dropdown, arg1)
				callback(arg1)
				CloseDropDownMenus()
			end
			UIDropDownMenu_AddButton(info, level)
		end
	end)

	local label = dropdown:CreateFontString(nil, "OVERLAY")
	label:SetPoint("BOTTOMLEFT", dropdown, "TOPLEFT", 20, 5)
	label:SetJustifyH("LEFT")
	label:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 10, "THINOUTLINE")
	label:SetText(labelText)
	label:SetTextColor(1, 1, 1, 1)

	return dropdown
end
