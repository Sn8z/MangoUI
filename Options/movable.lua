local _, mUI = ...

local locked = true

local function updatePoint(frame)
	local point, _, relativePoint, offsetX, offsetY = frame:GetPoint(1)
	offsetX = Round(offsetX)
	offsetY = Round(offsetY)
	--offsetX = math.floor(offsetX / 10 + 0.5) * 10
	--offsetY = math.floor(offsetY / 10 + 0.5) * 10
	frame:SetPoint(point, UIParent, relativePoint, offsetX, offsetY)


	local frameX, frameY = frame:GetCenter()
	local parentX, parentY = frame:GetParent():GetCenter()

	local oX = frameX - parentX
	local oY = frameY - parentY

	print("Frame X: " .. frameX)
	print("Frame Y: " .. frameY)

	print("Parent X: " .. parentX)
	print("Parent Y: " .. parentY)

	print("Pos X: " .. oX)
	print("Pos Y: " .. oY)
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
