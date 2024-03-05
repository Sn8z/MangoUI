local addonName, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local CreateFrame, GetAddOnMetadata = CreateFrame, GetAddOnMetadata

local function RegisterSettings()
	local frame = CreateFrame("Frame")
	local background = frame:CreateTexture()
	background:SetAllPoints(frame)

	local titleText = frame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("TOP", frame, "TOP", 0, -10)
	titleText:SetFont(LSM:Fetch("font", "Onest Semi Bold"), 20, "THINOUTLINE")
	titleText:SetTextColor(1, 1, 1, 1)
	titleText:SetText("Mango|cff00aa00U|r|cffaa0000I|r")

	local versionText = frame:CreateFontString(nil, "OVERLAY")
	versionText:SetPoint("TOP", titleText, "BOTTOM", 0, -10)
	versionText:SetFont(LSM:Fetch("font", "Onest Semi Bold"), 12, "THINOUTLINE")
	versionText:SetTextColor(0.8, 0.8, 0.8, 1)
	versionText:SetText(GetAddOnMetadata(addonName, "version"))

	local button = mUI:CreateButton(120, 30, "Settings", frame, function()
		mUI:ToggleOptions()
	end)
	button:SetPoint("TOP", versionText, "BOTTOM", 0, -50)

	local infoText = frame:CreateFontString(nil, "OVERLAY")
	infoText:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 10, 10)
	infoText:SetFont(LSM:Fetch("font", "Onest Semi Bold"), 12, "THINOUTLINE")
	infoText:SetTextColor(0.7, 0.7, 0.7, 1)
	infoText:SetText(
		"You can also type |cff00aa00/mango|r, |cffaa0000/mui|r or |cff0000aa/mangoui|r to open the settings menu.")

	local category, layout = Settings.RegisterCanvasLayoutCategory(frame, addonName)
	Settings.MUI_CATEGORY_ID = category:GetID()
	Settings.RegisterAddOnCategory(category)
end

SettingsRegistrar:AddRegistrant(RegisterSettings)
