local _, mUI    = ...
local data      = {}
local enabled   = false

local dataFrame = CreateFrame("Frame", "MangoDataFrame", UIParent, "BackdropTemplate")
dataFrame:SetPoint("CENTER")
dataFrame:SetSize(450, 450)
dataFrame:SetBackdrop({
	bgFile = [[Interface\AddOns\MangoUI\Media\Borders\mangobasic.tga]],
	edgeFile = [[Interface\AddOns\MangoUI\Media\Borders\mangobasic.tga]],
	edgeSize = 1,
})
dataFrame:SetBackdropColor(0.08, 0.08, 0.08, 0.8)
dataFrame:SetBackdropBorderColor(0.4, 0.4, 0.4, 1)
dataFrame:SetFrameStrata("DIALOG")
dataFrame:SetMovable(true)
dataFrame:SetClampedToScreen(true)
dataFrame:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" then
		self:StartMoving()
	end
end)
dataFrame:SetScript("OnMouseUp", function(self)
	self:StopMovingOrSizing()
end)
dataFrame:SetShown(enabled)
dataFrame:SetResizable(true)
local resizeBtn = CreateFrame("Button", "MangoDataResizeButton", dataFrame)
resizeBtn:SetPoint("BOTTOMRIGHT")
resizeBtn:SetSize(18, 18)
resizeBtn:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
resizeBtn:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")
resizeBtn:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
resizeBtn:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" then
		dataFrame:StartSizing("BOTTOMRIGHT")
	end
end)
resizeBtn:SetScript("OnMouseUp", function(self)
	dataFrame:StopMovingOrSizing()
end)

local closeBtn = CreateFrame("Button", "MangoDataCloseButton", dataFrame)
closeBtn:SetPoint("TOPRIGHT", -3, -3)
closeBtn:SetSize(18, 18)
closeBtn:SetNormalTexture([[Interface\AddOns\MangoUI\Media\Icons\cross.tga]])
closeBtn:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" then
		dataFrame:Hide()
	end
end)

local dataHeader = dataFrame:CreateFontString("MangoDataHeader", "OVERLAY", "ChatFontNormal")
dataHeader:SetPoint("LEFT", dataFrame, "TOPLEFT", 6, 0)
dataHeader:SetJustifyH("LEFT")
dataHeader:SetFormattedText("Profiling")

local dataText = dataFrame:CreateFontString("MangoDataText", "OVERLAY", "ChatFontNormal")
dataText:SetPoint("TOPLEFT", 16, -16)
dataText:SetJustifyH("LEFT")

local function updateData()
	local output = ""
	for func, totalTime in pairs(data) do
		output = output .. func .. ': ' .. format("%.2f", totalTime) .. 'ms\n'
	end
	dataText:SetFormattedText(output)
end

local updateBtn = CreateFrame("Button", "MangoDataUpdateButton", dataFrame)
updateBtn:SetPoint("RIGHT", closeBtn, "LEFT", -3, 0)
updateBtn:SetSize(18, 18)
updateBtn:SetNormalTexture([[Interface\AddOns\MangoUI\Media\Icons\cross.tga]])
updateBtn:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" then
		updateData()
	end
end)

local profilingStatus = dataFrame:CreateFontString("MangoProfilingHeader", "OVERLAY", "ChatFontNormal")
profilingStatus:SetPoint("LEFT", dataHeader, "RIGHT", 6, 0)
profilingStatus:SetJustifyH("LEFT")
if enabled then
	profilingStatus:SetFormattedText("Enabled")
else
	profilingStatus:SetFormattedText("Disabled")
end

local function enableProfiling()
	enabled = true
end

local function disableProfiling()
	enabled = false
end

local function showResults()
	if not dataFrame:IsShown() then
		dataFrame:Show()
	else
		dataFrame:Hide()
	end
	updateData()
end

function mUI:StartMeasure(func)
	if not enabled then return end
	data[func] = data[func] or 0
	data[func .. "_startTime"] = debugprofilestop()
end

function mUI:StopMeasure(func)
	if not enabled then return end
	local startTimeKey = func .. "_startTime"
	if data[startTimeKey] then
		data[func] = data[func] + (debugprofilestop() - data[startTimeKey])
		data[startTimeKey] = nil
	end
end

local function PerformanceCommands(message, _)
	if message == "on" then
		enableProfiling()
	elseif message == "off" then
		disableProfiling()
	else
		showResults()
	end
end

-- Add slash commands to enable/show profiling
SLASH_MANGOPERFORMANCE1, SLASH_MANGOPERFORMANCE2 = "/mperformance", "/mperf"
SlashCmdList["MANGOPERFORMANCE"] = PerformanceCommands
