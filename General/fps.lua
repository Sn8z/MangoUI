local AddonName, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:ShowFPS()
	StatsFrame = CreateFrame("Frame", "StatsFrame", UIParent)
	StatsFrame:ClearAllPoints()
	StatsFrame:SetPoint("CENTER", UIParent, "BOTTOM", -400, 15)
	StatsFrame:SetWidth(120)
	StatsFrame:SetHeight(60)

	StatsFrame.text = StatsFrame:CreateFontString(nil, "BACKGROUND")
	StatsFrame.text:SetPoint("CENTER", StatsFrame)
	StatsFrame.text:SetFont(LSM:Fetch("font", mUI.db.settings.font), 14, "THINOUTLINE")
	StatsFrame.text:SetTextColor(1, 1, 1)
	local lastUpdate = 0
	local function update(self, elapsed)
		lastUpdate = lastUpdate + elapsed
		if lastUpdate > 1 then
			lastUpdate = 0
			StatsFrame.text:SetText(floor(GetFramerate()).." fps "..select(4, GetNetStats()).." ms")
			self:SetWidth(StatsFrame.text:GetStringWidth())
			self:SetHeight(StatsFrame.text:GetStringHeight())
		end
	end
	StatsFrame:SetScript("OnUpdate", update)
end

local f = CreateFrame("Frame")

function f:OnEvent(event, ...)
	self[event](self, event, ...)
end

function f:ADDON_LOADED(event, addOnName)
	if addOnName == AddonName then
		mUI:ShowFPS()
	end
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", f.OnEvent)
