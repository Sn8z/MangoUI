local _, mUI = ...

local function UpdateLeaderIndicator(self)
	local leader = self.LeaderIndicator
	if UnitIsGroupLeader(self.unit) then
		leader:SetTexture([[Interface\AddOns\MangoUI\Media\Icons\leader.tga]])
		leader:Show()
	else
		leader:Hide()
	end
end

function mUI:CreateLeaderIndicator(self)
	local LeaderIndicator = self.Indicators:CreateTexture(nil, "OVERLAY")
	PixelUtil.SetSize(LeaderIndicator, 20, 20)
	PixelUtil.SetPoint(LeaderIndicator, "BOTTOMRIGHT", self.Indicators, "TOPRIGHT", -3, -10)
	LeaderIndicator.Override = UpdateLeaderIndicator
	self.LeaderIndicator = LeaderIndicator
end
