local _, mUI = ...

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
	local frames = {
		QuickJoinToastButton = mUI.profile.settings.hide.social,
		MicroMenu = mUI.profile.settings.hide.menu and false,
		BagsBar = mUI.profile.settings.hide.bags
	}

	local function hide(frameName)
		local frame = _G[frameName]
		if frame and frame.Hide then
			frame:Hide()
			if frame.UnregisterAllEvents then
				frame:UnregisterAllEvents()
			end
		end
	end

	for frame, var in pairs(frames) do
		if var then
			hide(frame)
		end
	end
end)
