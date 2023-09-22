local _, mUI = ...

function mUI:HideStuff()
	QuickJoinToastButton:Hide()
	--BagsBar:Hide()
end

function mUI:HideTalkingHead()
	-- TODO: Check db for setting
	if true then
		hooksecurefunc(TalkingHeadFrame, "PlayCurrent", function()
			TalkingHeadFrame:Hide()
		end)
	end
end

mUI:HideTalkingHead()

mUI:HideStuff()