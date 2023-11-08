local addonName, mUI = ...

local function ToggleTestFrames()
	print("Not yet implemented")
end

local f = CreateFrame("frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addon)
	if addon == addonName or addon == "OmniCD" then
		local func = OmniCD and OmniCD.AddUnitFrameData
		if func then
			func("MangoUI", "oUF_MangoPartyUnitButton", "unit", 1, ToggleTestFrames, 5)
		end
	end
end)
