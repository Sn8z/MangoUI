local _, mUI = ...

function mUI:HideTalkingHead()
	-- TODO: Check db for setting
	if true then
		hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function()
			TalkingHeadFrame:Hide()
		end)
	end
end

mUI:HideTalkingHead()
