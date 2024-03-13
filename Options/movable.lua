local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local playerColor = mUI:GetClassColor("player")

local movers = {}
local locked = true

-- Returns x & y pos of a frame relative to its parent
local function GetPos(frame)
	if not frame or not frame:GetParent() then
		return 0, 0
	end
	local frameX, frameY = frame:GetCenter()
	local parentX, parentY = frame:GetParent():GetCenter()
	local oX = Round((frameX or 0) - (parentX or 0))
	local oY = Round((frameY or 0) - (parentY or 0))

	return oX, oY
end

local function updateInfo(self)
	if self.info then
		local x, y = GetPos(self)
		self.info:SetText("X: " .. x .. " Y: " .. y)
	end
end

local function savePoint(mover)
	mover:ClearAllPoints()
	local x, y = GetPos(mover)
	mover:SetPoint("CENTER", UIParent, "CENTER", x, y)

	mover.frame:ClearAllPoints()
	mover.frame:SetPoint("CENTER", UIParent, "CENTER", x, y)
	mover.callback(x, y)
end

local function OnEnter(self)
	self:SetBackdropBorderColor(playerColor.r, playerColor.g, playerColor.b, 1)
end

local function OnLeave(self)
	self:SetBackdropBorderColor(0, 0, 0, 1)
end

local function OnMouseDown(self)
	self:StartMoving()
end

local function OnMouseUp(self)
	self:StopMovingOrSizing()
	savePoint(self)
end

function mUI:AddMover(frame, name, callback)
	local mover = CreateFrame("Frame", nil, UIParent, "BackdropTemplate")
	mover:SetAllPoints(frame)
	mover:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 2
	})
	mover:SetBackdropColor(0, 0, 0, 0.8)
	mover:SetBackdropBorderColor(0, 0, 0, 1)
	mover:SetFrameLevel(frame:GetFrameLevel() + 1)
	mover:SetMovable(true)
	mover:SetClampedToScreen(true)
	mover:SetScript("OnMouseDown", OnMouseDown)
	mover:SetScript("OnMouseUp", OnMouseUp)
	mover:SetScript("OnEnter", OnEnter)
	mover:SetScript("OnLeave", OnLeave)
	mover:SetScript("OnUpdate", updateInfo)

	local label = mover:CreateFontString(nil, "OVERLAY")
	label:SetPoint("LEFT", mover, "TOPLEFT", 6, 0)
	label:SetJustifyH("LEFT")
	label:SetFont(LSM:Fetch("font", "Onest Semi Bold"), 14, "THINOUTLINE")
	label:SetText(name)
	label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	mover.label = label

	local info = mover:CreateFontString(nil, "OVERLAY")
	info:SetPoint("CENTER")
	info:SetJustifyH("CENTER")
	info:SetFont(LSM:Fetch("font", "Onest Semi Bold"), 12, "THINOUTLINE")
	local x, y = GetPos(mover)
	info:SetText("X: " .. x .. " Y: " .. y)
	info:SetTextColor(1, 1, 1, 1)
	mover.info = info

	mover.frame = frame
	mover.callback = callback or function() return end

	mover:Hide()
	movers[name] = mover
end

local function frameUnlock(frame)
	frame:Show()
end

local function frameLock(frame)
	frame:Hide()
end

function mUI:ToggleMovable()
	for _, frame in pairs(movers) do
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
