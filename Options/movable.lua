local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local playerColor = mUI:GetClassColor("player")
local font = LSM:Fetch("font", "Outfit Bold")

local movers = {}
local locked = true

local grid = CreateFrame("Frame", "MangoGrid", UIParent, "BackdropTemplate")
grid:SetAllPoints()
grid:SetBackdrop({
	bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
})
grid:SetBackdropColor(0, 0, 0, 0.3)
grid:SetFrameStrata("BACKGROUND")
grid:Hide()

local w, h = GetPhysicalScreenSize()

for i = 0, w do
	if i == w / 2 then
		local l = grid:CreateTexture(nil, "BACKGROUND")
		l:SetColorTexture(playerColor.r, playerColor.g, playerColor.b, 1)
		l:SetPoint("TOPLEFT", i, 0)
		l:SetPoint("BOTTOMLEFT", i, 0)
	elseif i % 20 == 0 then
		local l = grid:CreateTexture(nil, "BACKGROUND")
		l:SetColorTexture(0.8, 0.8, 0.8, 0.3)
		l:SetPoint("TOPLEFT", i, 0)
		l:SetPoint("BOTTOMLEFT", i, 0)
	end
end

for i = 0, h do
	if i == h / 2 then
		local l = grid:CreateTexture(nil, "BACKGROUND")
		l:SetColorTexture(playerColor.r, playerColor.g, playerColor.b, 1)
		l:SetPoint("BOTTOMLEFT", 0, i)
		l:SetPoint("BOTTOMRIGHT", 0, i)
	elseif i % 20 == 0 then
		local l = grid:CreateTexture(nil, "BACKGROUND")
		l:SetColorTexture(0.8, 0.8, 0.8, 0.3)
		l:SetPoint("BOTTOMLEFT", 0, i)
		l:SetPoint("BOTTOMRIGHT", 0, i)
	end
end

local moveManager = CreateFrame("Frame", "MangoMoveManager", grid, "BackdropTemplate")
moveManager:SetSize(250, 60)
moveManager:SetPoint("TOPLEFT", 30, -30)
moveManager:SetBackdrop({
	bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
	edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
	edgeSize = 2
})
moveManager:SetBackdropColor(0, 0, 0, 0.65)
moveManager:SetBackdropBorderColor(0.33, 0.33, 0.33, 1)
moveManager:SetFrameStrata("DIALOG")
moveManager:SetClampedToScreen(true)

local hideBtn = CreateFrame("Button", "MangoHideMovable", moveManager, "BackdropTemplate")
hideBtn:SetSize(80, 25)
hideBtn:SetPoint("CENTER", moveManager, "CENTER")
hideBtn:SetBackdrop({
	bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
	edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
	edgeSize = 2
})
hideBtn:SetBackdropColor(0, 0, 0, 1)
hideBtn:SetBackdropBorderColor(0.33, 0.33, 0.33, 1)
hideBtn:SetScript("OnClick", function()
	mUI:ToggleMovable()
end)

local label = hideBtn:CreateFontString(nil, "OVERLAY")
label:SetPoint("CENTER")
label:SetJustifyH("CENTER")
label:SetFont(font, 14, "OUTLINE")
label:SetText("Hide")
label:SetTextColor(0.8, 0.8, 0.8, 1)
hideBtn.label = label

local function PrettifyName(name)
	name = name:gsub("_", " ")
	name = name:lower()
	name = name:gsub("^%l", string.upper)
	return name
end

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
	local x, y = GetPos(mover)
	mover.callback(x, y)
end

local function OnEnter(self)
	self:SetBackdropBorderColor(playerColor.r, playerColor.g, playerColor.b, 1)
	self:EnableKeyboard(true)
	self:SetPropagateKeyboardInput(false)
	self:SetScript("OnKeyDown", function(self, key)
		self:StartMoving()
		self.frame:ClearAllPoints()
		self.frame:SetAllPoints(self)
		if key == "UP" then
			self:AdjustPointsOffset(0, 1)
			savePoint(self)
		elseif key == "DOWN" then
			self:AdjustPointsOffset(0, -1)
			savePoint(self)
		elseif key == "LEFT" then
			self:AdjustPointsOffset(-1, 0)
			savePoint(self)
		elseif key == "RIGHT" then
			self:AdjustPointsOffset(1, 0)
			savePoint(self)
		end
		self:StopMovingOrSizing()
	end)
end

local function OnLeave(self)
	self:SetBackdropBorderColor(0, 0, 0, 1)
	self:EnableKeyboard(false)
	self:SetPropagateKeyboardInput(true)
	self:SetScript("OnKeyDown", nil)
end

local function OnMouseDown(self)
	self:StartMoving()
	self.frame:ClearAllPoints()
	self.frame:SetAllPoints(self)
end

local function OnMouseUp(self)
	self:StopMovingOrSizing()
	savePoint(self)
end

function mUI:AddMover(frame, name, callback)
	local mover = CreateFrame("Frame", nil, grid, "BackdropTemplate")
	mover:SetAllPoints(frame)
	mover:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1
	})
	mover:SetBackdropColor(0, 0, 0, 0.8)
	mover:SetBackdropBorderColor(0, 0, 0, 1)
	mover:SetFrameStrata("DIALOG")
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
	label:SetFont(font, 14, "OUTLINE")
	label:SetText(PrettifyName(name))
	label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	mover.label = label

	local info = mover:CreateFontString(nil, "OVERLAY")
	info:SetPoint("CENTER")
	info:SetJustifyH("CENTER")
	info:SetFont(font, 12, "OUTLINE")
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
			grid:Show()
		else
			frameLock(frame)
			grid:Hide()
		end
	end
	locked = not locked
end

SLASH_MANGOMOVE1, SLASH_MANGOMOVE2 = "/mangomove", "/mmove"
SlashCmdList["MANGOMOVE"] = mUI.ToggleMovable
