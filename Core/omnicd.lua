local _, mUI = ...

mUI:StartMeasure("OMNICD_SETUP")
-- Thanks to Trinca for this solution (https://github.com/trincasidra/TrincaUI/blob/0eee1e909274169a25d51727e4ed0a535bd0da00/modules/omnicd.lua)
if OmniCD and OmniCD[1] and OmniCD[1].unitFrameData then
	OmniCD[1].unitFrameData[#OmniCD[1].unitFrameData + 1] = {
		[1] = "MangoUI-Party",
		[2] = "MangoPartyUnitButton",
		[3] = "unit",
		[4] = 1,
		[5] = 5,
	}

	OmniCD[1].unitFrameData[#OmniCD[1].unitFrameData + 1] = {
		[1] = "MangoUI-Favourites",
		[2] = "MangoFavouritesUnitButton",
		[3] = "unit",
		[4] = 1,
		[5] = 20,
	}

	OmniCD[1].unitFrameData[#OmniCD[1].unitFrameData + 1] = {
		[1] = "MangoUI-Raid",
		[2] = "MangoRaid%dUnitButton",
		[3] = "unit",
		[4] = 1,
		[5] = 40,
	}
	OmniCD[1].addOnTestMode["MangoUI"] = function()
		mUI.ToggleFrames()
	end
end

mUI:StopMeasure("OMNICD_SETUP")