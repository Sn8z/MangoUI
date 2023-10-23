local _, mUI = ...

local locked = true

local function updatePoint(frame)
	local point, _, relativePoint, offsetX, offsetY = frame:GetPoint(1)
	offsetX = Round(offsetX)
	offsetY = Round(offsetY)
	frame:SetPoint(point, UIParent, relativePoint, offsetX, offsetY)
end

local function OnMouseDown(self)
	self:StartMoving()
end

local function OnMouseUp(self)
	self:StopMovingOrSizing()
	updatePoint(self)
end

local function frameUnlock(frame)
	frame:SetMovable(true)
	frame:SetScript("OnMouseDown", OnMouseDown)
	frame:SetScript("OnMouseUp", OnMouseUp)
end

local function frameLock(frame)
	frame:SetMovable(false)
	frame:SetScript("OnMouseDown", nil)
	frame:SetScript("OnMouseUp", nil)
end

function mUI:ToggleMovable()
	local frames = {
		"oUF_MangoBoss1",
		"oUF_MangoPrimaryPlayer",
		"oUF_MangoPrimaryTarget",
		"oUF_MangoPrimaryFocus"
	}

	for i = 1, #frames do
		local frame = _G[frames[i]]
		if locked then
			frameUnlock(frame)
		else
			frameLock(frame)
		end
	end

	locked = not locked
end

SLASH_MANGOMOVE1, SLASH_MANGOMOVE2 = "/mangomove", "/mmove"
SlashCmdList["MANGOMOVE"] = mUI.ToggleMovable
