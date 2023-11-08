local _, mUI = ...

local function ToggleFrames()
	print("Not yet implemented")
end

local f = CreateFrame("frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addon)
	if addon == "MangoUI" or addon == "OmniCD" then
		local func = OmniCD and OmniCD.AddUnitFrameData
		if func then
			func("MangoUI", "oUF_MangoPartyUnitButton", "unit", 1, ToggleFrames, 5)
		end
	end
end)
