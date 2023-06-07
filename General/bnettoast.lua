local _, mUI = ...

function mUI:MoveBnetToast()
	-- Get a reference to the Battle.net notification frame
	local bnetFrame = BNToastFrame

	-- Move the frame to the desired position
	bnetFrame:ClearAllPoints()
	bnetFrame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 300, 50)

	bnetFrame.CloseButton:Hide()
	bnetFrame.CloseButton:Disable()
end

local function EnteringWorld()
	mUI:MoveBnetToast()
end

local eFrame = CreateFrame("Frame")
eFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
eFrame:SetScript("OnEvent", EnteringWorld)