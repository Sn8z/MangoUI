local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local _, class = UnitClass("player")
local playerColor = RAID_CLASS_COLORS[class]

-- Overall frames
local settingsFrame, generalFrame, unitsFrame, colorsFrame, profilesFrame
-- Nested frames for configuring unitframes
local playerFrame, targetFrame, partyFrame, raidFrame, bossFrame

local function RegisterSettings()
	settingsFrame = CreateFrame("Frame", "MangoSettingsFrame", UIParent, "BackdropTemplate")
	settingsFrame:SetSize(900, 600)
	settingsFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	settingsFrame:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 2,
	})
	settingsFrame:SetBackdropColor(0.1, 0.1, 0.1, 0.9)
	settingsFrame:SetBackdropBorderColor(0, 0, 0, 1)
	settingsFrame:EnableMouse(true)
	settingsFrame:SetMovable(true)
	settingsFrame:SetFrameStrata("DIALOG")
	settingsFrame:RegisterForDrag("LeftButton")
	settingsFrame:SetScript("OnDragStart", settingsFrame.StartMoving)
	settingsFrame:SetScript("OnDragStop", settingsFrame.StopMovingOrSizing)
	--settingsFrame:Hide()

	-- Title Text
	local titleText = settingsFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("TOP", settingsFrame, "TOP", 0, -10)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 20, "THINOUTLINE")
	titleText:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleText:SetText("MangoUI")

	local logo = settingsFrame:CreateTexture(nil, "ARTWORK")
	logo:SetTexture([[Interface\AddOns\MangoUI\Media\mangologo.tga]])
	logo:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT", -30, 30)
	logo:SetSize(100, 100)

	local closeButton = CreateFrame("Button", nil, settingsFrame, "UIPanelButtonTemplate")
	closeButton:SetPoint("TOPRIGHT", -10, -10)
	closeButton:SetSize(26, 26)
	closeButton:SetText("X")
	closeButton:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	closeButton:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	closeButton:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	closeButton:GetNormalTexture():SetVertexColor(0.6, 0.1, 0.1)
	closeButton:GetPushedTexture():SetVertexColor(0.7, 0.2, 0.2)
	closeButton:GetHighlightTexture():SetVertexColor(1, 0.3, 0.3)
	closeButton:SetScript("OnClick", function()
		settingsFrame:Hide()
	end)

	local reloadButton = CreateFrame("Button", nil, settingsFrame, "UIPanelButtonTemplate")
	reloadButton:SetPoint("TOPRIGHT", closeButton, "TOPLEFT", -10, 0)
	reloadButton:SetSize(80, 26)
	reloadButton:SetText("Reload")
	reloadButton:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	reloadButton:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	reloadButton:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	reloadButton:GetNormalTexture():SetVertexColor(0.1, 0.6, 0.1)
	reloadButton:GetPushedTexture():SetVertexColor(0.2, 0.7, 0.2)
	reloadButton:GetHighlightTexture():SetVertexColor(0.3, 1, 0.3)
	reloadButton:SetScript("OnClick", function()
		ReloadUI()
	end)

	local function HideUnitFrames()
		playerFrame:Hide()
		targetFrame:Hide()
		partyFrame:Hide()
		raidFrame:Hide()
		bossFrame:Hide()
	end

	local function HideFrames()
		generalFrame:Hide()
		unitsFrame:Hide()
		colorsFrame:Hide()
		profilesFrame:Hide()
		HideUnitFrames()
	end

	local generalTab = CreateFrame("Button", nil, settingsFrame, "UIPanelButtonTemplate")
	generalTab:SetText("General")
	generalTab:SetPoint("TOPLEFT", settingsFrame, "BOTTOMLEFT", 2, 0)
	generalTab:SetSize(140, 20)
	generalTab:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	generalTab:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	generalTab:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	generalTab:GetNormalTexture():SetVertexColor(0.1, 0.1, 0.1)
	generalTab:GetPushedTexture():SetVertexColor(0.2, 0.2, 0.2)
	generalTab:GetHighlightTexture():SetVertexColor(0.3, 0.3, 0.3)
	generalTab:SetScript("OnClick", function()
		HideFrames()
		generalFrame:Show()
	end)

	local unitsTab = CreateFrame("Button", nil, settingsFrame, "UIPanelButtonTemplate")
	unitsTab:SetText("Units")
	unitsTab:SetPoint("TOPLEFT", generalTab, "TOPRIGHT", 2, 0)
	unitsTab:SetSize(140, 20)
	unitsTab:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	unitsTab:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	unitsTab:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	unitsTab:GetNormalTexture():SetVertexColor(0.1, 0.1, 0.1)
	unitsTab:GetPushedTexture():SetVertexColor(0.2, 0.2, 0.2)
	unitsTab:GetHighlightTexture():SetVertexColor(0.3, 0.3, 0.3)
	unitsTab:SetScript("OnClick", function()
		HideFrames()
		unitsFrame:Show()
		playerFrame:Show()
	end)

	local colorsTab = CreateFrame("Button", nil, settingsFrame, "UIPanelButtonTemplate")
	colorsTab:SetText("Colors")
	colorsTab:SetPoint("TOPLEFT", unitsTab, "TOPRIGHT", 2, 0)
	colorsTab:SetSize(140, 20)
	colorsTab:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	colorsTab:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	colorsTab:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	colorsTab:GetNormalTexture():SetVertexColor(0.1, 0.1, 0.1)
	colorsTab:GetPushedTexture():SetVertexColor(0.2, 0.2, 0.2)
	colorsTab:GetHighlightTexture():SetVertexColor(0.3, 0.3, 0.3)
	colorsTab:SetScript("OnClick", function()
		HideFrames()
		colorsFrame:Show()
	end)

	local profilesTab = CreateFrame("Button", nil, settingsFrame, "UIPanelButtonTemplate")
	profilesTab:SetText("Profiles")
	profilesTab:SetPoint("TOPRIGHT", settingsFrame, "BOTTOMRIGHT", -2, 0)
	profilesTab:SetSize(140, 20)
	profilesTab:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	profilesTab:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	profilesTab:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	profilesTab:GetNormalTexture():SetVertexColor(0.1, 0.1, 0.1)
	profilesTab:GetPushedTexture():SetVertexColor(0.2, 0.2, 0.2)
	profilesTab:GetHighlightTexture():SetVertexColor(0.3, 0.3, 0.3)
	profilesTab:SetScript("OnClick", function()
		HideFrames()
		profilesFrame:Show()
	end)

	generalFrame = CreateFrame("Frame", nil, settingsFrame, "BackdropTemplate")
	generalFrame:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT", 10, -100)
	generalFrame:SetPoint("BOTTOMRIGHT", settingsFrame, "BOTTOMRIGHT", -10, 10)
	generalFrame:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1,
	})
	generalFrame:SetBackdropColor(0.1, 0.1, 0.1, 1)
	generalFrame:SetBackdropBorderColor(0, 0, 0, 1)

	local titleText = generalFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("BOTTOM", generalFrame, "TOP", 0, 5)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 20, "THINOUTLINE")
	titleText:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleText:SetText("General")

	local smoothCheck = CreateFrame("CheckButton", nil, generalFrame, "UICheckButtonTemplate")
	smoothCheck:SetPoint("TOPLEFT", 20, -20)
	smoothCheck.text:SetText("Enable smoothbars")
	smoothCheck:SetChecked(mUI.profile.settings.smooth)
	smoothCheck:SetScript("OnClick", function(self)
		mUI.profile.settings.smooth = self:GetChecked()
		ReloadUI()
	end)

	-- https://wowpedia.fandom.com/wiki/Using_UIDropDownMenu
	-- https://www.townlong-yak.com/framexml/live/UIDropDownMenu.lua
	local textureDropdown = CreateFrame("FRAME", "MangoTextureDropdown", generalFrame, "UIDropDownMenuTemplate")
	textureDropdown:SetPoint("TOPLEFT", smoothCheck, "BOTTOMLEFT", 0, -10)
	UIDropDownMenu_SetWidth(textureDropdown, 200)
	UIDropDownMenu_SetText(textureDropdown, mUI.profile.settings.texture)

	local function textureDropdownClick(self, arg1, arg2, checked)
		mUI.profile.settings.texture = arg1
	end

	UIDropDownMenu_Initialize(textureDropdown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		for _, v in pairs(LSM:List("statusbar")) do
			info.text, info.arg1, info.checked = v, v, v == mUI.profile.settings.texture
			info.func = textureDropdownClick
			UIDropDownMenu_AddButton(info, level)
		end
	end)

	local fontDropdown = CreateFrame("FRAME", "MangoFontDropdown", generalFrame, "UIDropDownMenuTemplate")
	fontDropdown:SetPoint("TOPLEFT", textureDropdown, "BOTTOMLEFT", 0, -10)
	UIDropDownMenu_SetWidth(fontDropdown, 200)
	UIDropDownMenu_SetText(fontDropdown, mUI.profile.settings.font)

	local function fontDropdownClick(self, arg1, arg2, checked)
		mUI.profile.settings.font = arg1
	end

	UIDropDownMenu_Initialize(fontDropdown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		for _, v in pairs(LSM:List("font")) do
			info.text, info.arg1, info.checked = v, v, v == mUI.profile.settings.font
			info.func = fontDropdownClick
			UIDropDownMenu_AddButton(info, level)
		end
	end)

	unitsFrame = CreateFrame("Frame", nil, settingsFrame, "BackdropTemplate")
	unitsFrame:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT", 10, -100)
	unitsFrame:SetPoint("BOTTOMRIGHT", settingsFrame, "BOTTOMRIGHT", -10, 10)
	unitsFrame:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1,
	})
	unitsFrame:SetBackdropColor(0.1, 0.1, 0.1, 1)
	unitsFrame:SetBackdropBorderColor(0, 0, 0, 1)
	unitsFrame:Hide()

	local playerTab = CreateFrame("Button", nil, unitsFrame, "UIPanelButtonTemplate")
	playerTab:SetText("Player")
	playerTab:SetPoint("BOTTOMLEFT", unitsFrame, "TOPLEFT", 2, 0)
	playerTab:SetSize(100, 20)
	playerTab:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	playerTab:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	playerTab:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	playerTab:GetNormalTexture():SetVertexColor(0.1, 0.1, 0.1)
	playerTab:GetPushedTexture():SetVertexColor(0.2, 0.2, 0.2)
	playerTab:GetHighlightTexture():SetVertexColor(0.3, 0.3, 0.3)
	playerTab:SetScript("OnClick", function()
		HideUnitFrames()
		playerFrame:Show()
	end)

	playerFrame = CreateFrame("Frame", nil, unitsFrame)
	playerFrame:SetAllPoints()

	local titleText = playerFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("TOP", playerFrame, "TOP", 0, -10)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 20, "THINOUTLINE")
	titleText:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleText:SetText("Player")

	local playerCheck = CreateFrame("CheckButton", nil, playerFrame, "UICheckButtonTemplate")
	playerCheck:SetPoint("TOPLEFT", 20, -20)
	playerCheck.text:SetText("Enable playerframe")
	playerCheck:SetChecked(mUI.profile.player.enabled)
	playerCheck:SetScript("OnClick", function(self)
		mUI.profile.player.enabled = self:GetChecked()
	end)

	local petCheck = CreateFrame("CheckButton", nil, playerFrame, "UICheckButtonTemplate")
	petCheck:SetPoint("TOPLEFT", playerCheck, "BOTTOMLEFT", 0, -20)
	petCheck.text:SetText("Enable petframe")
	petCheck:SetChecked(mUI.profile.pet.enabled)
	petCheck:SetScript("OnClick", function(self)
		mUI.profile.pet.enabled = self:GetChecked()
	end)

	local targetTab = CreateFrame("Button", nil, unitsFrame, "UIPanelButtonTemplate")
	targetTab:SetText("Target")
	targetTab:SetPoint("LEFT", playerTab, "RIGHT", 2, 0)
	targetTab:SetSize(100, 20)
	targetTab:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	targetTab:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	targetTab:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	targetTab:GetNormalTexture():SetVertexColor(0.1, 0.1, 0.1)
	targetTab:GetPushedTexture():SetVertexColor(0.2, 0.2, 0.2)
	targetTab:GetHighlightTexture():SetVertexColor(0.3, 0.3, 0.3)
	targetTab:SetScript("OnClick", function()
		HideUnitFrames()
		targetFrame:Show()
	end)

	targetFrame = CreateFrame("Frame", nil, unitsFrame)
	targetFrame:SetAllPoints()
	targetFrame:Hide()

	local titleText = targetFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("TOP", targetFrame, "TOP", 0, -10)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 20, "THINOUTLINE")
	titleText:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleText:SetText("Target")

	local targetCheck = CreateFrame("CheckButton", nil, targetFrame, "UICheckButtonTemplate")
	targetCheck:SetPoint("TOPLEFT", 20, -20)
	targetCheck.text:SetText("Enable targetframe")
	targetCheck:SetChecked(mUI.profile.target.enabled)
	targetCheck:SetScript("OnClick", function(self)
		mUI.profile.target.enabled = self:GetChecked()
	end)

	local targettargetCheck = CreateFrame("CheckButton", nil, targetFrame, "UICheckButtonTemplate")
	targettargetCheck:SetPoint("TOPLEFT", targetCheck, "BOTTOMLEFT", 0, -20)
	targettargetCheck.text:SetText("Enable totframe")
	targettargetCheck:SetChecked(mUI.profile.targettarget.enabled)
	targettargetCheck:SetScript("OnClick", function(self)
		mUI.profile.targettarget.enabled = self:GetChecked()
	end)

	local partyTab = CreateFrame("Button", nil, unitsFrame, "UIPanelButtonTemplate")
	partyTab:SetText("Party")
	partyTab:SetPoint("LEFT", targetTab, "RIGHT", 2, 0)
	partyTab:SetSize(100, 20)
	partyTab:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	partyTab:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	partyTab:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	partyTab:GetNormalTexture():SetVertexColor(0.1, 0.1, 0.1)
	partyTab:GetPushedTexture():SetVertexColor(0.2, 0.2, 0.2)
	partyTab:GetHighlightTexture():SetVertexColor(0.3, 0.3, 0.3)
	partyTab:SetScript("OnClick", function()
		HideUnitFrames()
		partyFrame:Show()
	end)

	partyFrame = CreateFrame("Frame", nil, unitsFrame)
	partyFrame:SetAllPoints()
	partyFrame:Hide()

	local titleText = partyFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("TOP", partyFrame, "TOP", 0, -10)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 20, "THINOUTLINE")
	titleText:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleText:SetText("Party")

	local partyCheck = CreateFrame("CheckButton", nil, partyFrame, "UICheckButtonTemplate")
	partyCheck:SetPoint("TOPLEFT", 20, -20)
	partyCheck.text:SetText("Enable partyframes")
	partyCheck:SetChecked(mUI.profile.party.enabled)
	partyCheck:SetScript("OnClick", function(self)
		mUI.profile.party.enabled = self:GetChecked()
	end)

	local raidTab = CreateFrame("Button", nil, unitsFrame, "UIPanelButtonTemplate")
	raidTab:SetText("Raid")
	raidTab:SetPoint("LEFT", partyTab, "Right", 2, 0)
	raidTab:SetSize(100, 20)
	raidTab:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	raidTab:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	raidTab:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	raidTab:GetNormalTexture():SetVertexColor(0.1, 0.1, 0.1)
	raidTab:GetPushedTexture():SetVertexColor(0.2, 0.2, 0.2)
	raidTab:GetHighlightTexture():SetVertexColor(0.3, 0.3, 0.3)
	raidTab:SetScript("OnClick", function()
		HideUnitFrames()
		raidFrame:Show()
	end)

	raidFrame = CreateFrame("Frame", nil, unitsFrame)
	raidFrame:SetAllPoints()
	raidFrame:Hide()

	local titleText = raidFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("TOP", raidFrame, "TOP", 0, -10)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 20, "THINOUTLINE")
	titleText:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleText:SetText("Raid")

	local raidCheck = CreateFrame("CheckButton", nil, raidFrame, "UICheckButtonTemplate")
	raidCheck:SetPoint("TOPLEFT", 20, -20)
	raidCheck.text:SetText("Enable raidframes")
	raidCheck:SetChecked(mUI.profile.raid.enabled)
	raidCheck:SetScript("OnClick", function(self)
		mUI.profile.raid.enabled = self:GetChecked()
	end)

	local bossTab = CreateFrame("Button", nil, unitsFrame, "UIPanelButtonTemplate")
	bossTab:SetText("Boss")
	bossTab:SetPoint("LEFT", raidTab, "RIGHT", 2, 0)
	bossTab:SetSize(100, 20)
	bossTab:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	bossTab:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	bossTab:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	bossTab:GetNormalTexture():SetVertexColor(0.1, 0.1, 0.1)
	bossTab:GetPushedTexture():SetVertexColor(0.2, 0.2, 0.2)
	bossTab:GetHighlightTexture():SetVertexColor(0.3, 0.3, 0.3)
	bossTab:SetScript("OnClick", function()
		HideUnitFrames()
		bossFrame:Show()
	end)

	bossFrame = CreateFrame("Frame", nil, unitsFrame)
	bossFrame:SetAllPoints()
	bossFrame:Hide()

	local titleText = bossFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("TOP", bossFrame, "TOP", 0, -10)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 20, "THINOUTLINE")
	titleText:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleText:SetText("Boss")

	local bossCheck = CreateFrame("CheckButton", nil, bossFrame, "UICheckButtonTemplate")
	bossCheck:SetPoint("TOPLEFT", 20, -20)
	bossCheck.text:SetText("Enable bossframes")
	bossCheck:SetChecked(mUI.profile.boss.enabled)
	bossCheck:SetScript("OnClick", function(self)
		mUI.profile.boss.enabled = self:GetChecked()
	end)

	colorsFrame = CreateFrame("Frame", nil, settingsFrame, "BackdropTemplate")
	colorsFrame:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT", 10, -100)
	colorsFrame:SetPoint("BOTTOMRIGHT", settingsFrame, "BOTTOMRIGHT", -10, 10)
	colorsFrame:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1,
	})
	colorsFrame:SetBackdropColor(0.1, 0.1, 0.1, 1)
	colorsFrame:SetBackdropBorderColor(0, 0, 0, 1)
	colorsFrame:Hide()

	local titleText = colorsFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("BOTTOM", colorsFrame, "TOP", 0, 5)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 20, "THINOUTLINE")
	titleText:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleText:SetText("Coming soon...")

	--local function OpenColorPicker()
	--	ColorPickerFrame.func = function()
	--		local r, g, b = ColorPickerFrame:GetColorRGB()
	--		local hexColor = string.format("%02x%02x%02x", r * 255, g * 255, b * 255)
	--		print("Selected color: #" .. hexColor)
	--	end
	--
	--	ColorPickerFrame:SetColorRGB(1, 0, 0)
	--	ColorPickerFrame.hasOpacity = false
	--	ColorPickerFrame.previousValues = { 1, 0, 0 }
	--	ColorPickerFrame:Show()
	--end
	--
	--local colorPickerButton = CreateFrame("Button", "MyAddonColorPickerButton", colorsFrame, "UIPanelButtonTemplate")
	--colorPickerButton:SetPoint("TOPLEFT", 20, -20)
	--colorPickerButton:SetSize(30, 30)
	--colorPickerButton:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	--colorPickerButton:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	--colorPickerButton:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	--colorPickerButton:GetNormalTexture():SetVertexColor(playerColor.r, playerColor.g, playerColor.b)
	--colorPickerButton:GetPushedTexture():SetVertexColor(playerColor.r, playerColor.g, playerColor.b)
	--colorPickerButton:GetHighlightTexture():SetVertexColor(playerColor.r, playerColor.g, playerColor.b)
	--colorPickerButton:SetScript("OnClick", OpenColorPicker)

	profilesFrame = CreateFrame("Frame", nil, settingsFrame, "BackdropTemplate")
	profilesFrame:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT", 10, -100)
	profilesFrame:SetPoint("BOTTOMRIGHT", settingsFrame, "BOTTOMRIGHT", -10, 10)
	profilesFrame:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1,
	})
	profilesFrame:SetBackdropColor(0.1, 0.1, 0.1, 1)
	profilesFrame:SetBackdropBorderColor(0, 0, 0, 1)
	profilesFrame:Hide()

	local titleText = profilesFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("BOTTOM", profilesFrame, "TOP", 0, 5)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 20, "THINOUTLINE")
	titleText:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleText:SetText("Profiles")

	local scrollFrame = CreateFrame("ScrollFrame", nil, profilesFrame, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", 3, -4)
	scrollFrame:SetPoint("BOTTOMRIGHT", -27, 4)

	local scrollChild = CreateFrame("Frame")
	scrollFrame:SetScrollChild(scrollChild)
	scrollChild:SetWidth(scrollFrame:GetWidth() - 18)
	scrollChild:SetHeight(1)

	local title = scrollChild:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
	title:SetPoint("TOP")
	title:SetText("MyAddOn")

	local footer = scrollChild:CreateFontString("ARTWORK", nil, "GameFontNormal")
	footer:SetPoint("TOP", 0, -5000)
	footer:SetText("This is 5000 below the top, so the scrollChild automatically expanded.")
end

SettingsRegistrar:AddRegistrant(RegisterSettings)

SLASH_MYADDONSETTINGS1 = "/myaddonsettings"
SlashCmdList["MYADDONSETTINGS"] = function()
	if settingsFrame:IsShown() then
		settingsFrame:Hide()
	else
		settingsFrame:Show()
	end
end
