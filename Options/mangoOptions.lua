local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local _, class = UnitClass("player")
local playerColor = RAID_CLASS_COLORS[class]

-- Overall frames
local settingsFrame, generalFrame, unitsFrame, colorsFrame, profilesFrame
-- Nested frames for configuring unitframes
local playerFrame, targetFrame, focusFrame, partyFrame, raidFrame, bossFrame

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

	local testModeButton = CreateFrame("Button", nil, settingsFrame, "UIPanelButtonTemplate")
	testModeButton:SetPoint("TOPRIGHT", reloadButton, "TOPLEFT", -10, 0)
	testModeButton:SetSize(80, 26)
	testModeButton:SetText("Test frames")
	testModeButton:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	testModeButton:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	testModeButton:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	testModeButton:GetNormalTexture():SetVertexColor(0.1, 0.1, 0.6)
	testModeButton:GetPushedTexture():SetVertexColor(0.2, 0.2, 0.7)
	testModeButton:GetHighlightTexture():SetVertexColor(0.3, 0.3, 1)
	testModeButton:SetScript("OnClick", function()
		mUI:ToggleFrames()
	end)

	local movableButton = CreateFrame("Button", nil, settingsFrame, "UIPanelButtonTemplate")
	movableButton:SetPoint("TOPRIGHT", testModeButton, "TOPLEFT", -10, 0)
	movableButton:SetSize(80, 26)
	movableButton:SetText("Move frames")
	movableButton:SetNormalTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	movableButton:SetPushedTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	movableButton:SetHighlightTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	movableButton:GetNormalTexture():SetVertexColor(0.1, 0.4, 0.6)
	movableButton:GetPushedTexture():SetVertexColor(0.2, 0.4, 0.7)
	movableButton:GetHighlightTexture():SetVertexColor(0.3, 0.5, 1)
	movableButton:SetScript("OnClick", function()
		mUI:ToggleMovable()
	end)

	local function HideUnitFrames()
		playerFrame:Hide()
		targetFrame:Hide()
		focusFrame:Hide()
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

	local generalTab = mUI:CreateButton(140, 20, "General", settingsFrame, function()
		HideFrames()
		generalFrame:Show()
	end)
	generalTab:SetPoint("TOPLEFT", settingsFrame, "BOTTOMLEFT", 2, 0)

	local unitsTab = mUI:CreateButton(140, 20, "Units", settingsFrame, function()
		HideFrames()
		unitsFrame:Show()
		playerFrame:Show()
	end)
	unitsTab:SetPoint("TOPLEFT", generalTab, "TOPRIGHT", 2, 0)

	local colorsTab = mUI:CreateButton(140, 20, "Colors", settingsFrame, function()
		HideFrames()
		colorsFrame:Show()
	end)
	colorsTab:SetPoint("TOPLEFT", unitsTab, "TOPRIGHT", 2, 0)

	local profilesTab = mUI:CreateButton(140, 20, "Profiles", settingsFrame, function()
		HideFrames()
		profilesFrame:Show()
	end)
	profilesTab:SetPoint("TOPRIGHT", settingsFrame, "BOTTOMRIGHT", -2, 0)

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
	end)

	local borderSlider = mUI:CreateSlider(0, 10, 1, "Border Size", mUI.profile.settings.borderSize, generalFrame,
		function(value)
			mUI.profile.settings.borderSize = value
		end)
	borderSlider:SetPoint("TOPLEFT", smoothCheck, "BOTTOMLEFT", 0, -20)

	local healthTextureDropdown = CreateFrame("FRAME", "MangoTextureDropdown", generalFrame, "UIDropDownMenuTemplate")
	healthTextureDropdown:SetPoint("TOPLEFT", borderSlider, "BOTTOMLEFT", 0, -20)
	UIDropDownMenu_SetWidth(healthTextureDropdown, 200)
	UIDropDownMenu_SetText(healthTextureDropdown, mUI.profile.settings.healthTexture)

	local function healthTextureDropdownClick(self, arg1, arg2, checked)
		mUI.profile.settings.healthTexture = arg1
		UIDropDownMenu_SetText(healthTextureDropdown, arg1)
	end

	UIDropDownMenu_Initialize(healthTextureDropdown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		for _, v in pairs(LSM:List("statusbar")) do
			info.text, info.arg1, info.checked = v, v, v == mUI.profile.settings.healthTexture
			info.func = healthTextureDropdownClick
			UIDropDownMenu_AddButton(info, level)
		end
	end)

	local powerTextureDropdown = CreateFrame("FRAME", "MangoTextureDropdown", generalFrame, "UIDropDownMenuTemplate")
	powerTextureDropdown:SetPoint("TOPLEFT", healthTextureDropdown, "BOTTOMLEFT", 0, -20)
	UIDropDownMenu_SetWidth(powerTextureDropdown, 200)
	UIDropDownMenu_SetText(powerTextureDropdown, mUI.profile.settings.powerTexture)

	local function powerTextureDropdownClick(self, arg1, arg2, checked)
		mUI.profile.settings.powerTexture = arg1
		UIDropDownMenu_SetText(powerTextureDropdown, arg1)
	end

	UIDropDownMenu_Initialize(powerTextureDropdown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		for _, v in pairs(LSM:List("statusbar")) do
			info.text, info.arg1, info.checked = v, v, v == mUI.profile.settings.powerTexture
			info.func = powerTextureDropdownClick
			UIDropDownMenu_AddButton(info, level)
		end
	end)

	local castbarTextureDropdown = CreateFrame("FRAME", "MangoTextureDropdown", generalFrame, "UIDropDownMenuTemplate")
	castbarTextureDropdown:SetPoint("TOPLEFT", powerTextureDropdown, "BOTTOMLEFT", 0, -20)
	UIDropDownMenu_SetWidth(castbarTextureDropdown, 200)
	UIDropDownMenu_SetText(castbarTextureDropdown, mUI.profile.settings.castbarTexture)

	local function castbarTextureDropdownClick(self, arg1, arg2, checked)
		mUI.profile.settings.castbarTexture = arg1
		UIDropDownMenu_SetText(castbarTextureDropdown, arg1)
	end

	UIDropDownMenu_Initialize(castbarTextureDropdown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		for _, v in pairs(LSM:List("statusbar")) do
			info.text, info.arg1, info.checked = v, v, v == mUI.profile.settings.castbarTexture
			info.func = castbarTextureDropdownClick
			UIDropDownMenu_AddButton(info, level)
		end
	end)

	local fontDropdown = CreateFrame("FRAME", "MangoFontDropdown", generalFrame, "UIDropDownMenuTemplate")
	fontDropdown:SetPoint("TOPLEFT", castbarTextureDropdown, "BOTTOMLEFT", 0, -20)
	UIDropDownMenu_SetWidth(fontDropdown, 200)
	UIDropDownMenu_SetText(fontDropdown, mUI.profile.settings.font)

	local function fontDropdownClick(self, arg1, arg2, checked)
		mUI.profile.settings.font = arg1
		UIDropDownMenu_SetText(fontDropdown, arg1)
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

	local playerTab = mUI:CreateButton(100, 20, "Player", unitsFrame, function()
		HideUnitFrames()
		playerFrame:Show()
	end)
	playerTab:SetPoint("BOTTOMLEFT", unitsFrame, "TOPLEFT", 2, 0)

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

	local playerPortCheck = CreateFrame("CheckButton", nil, playerFrame, "UICheckButtonTemplate")
	playerPortCheck:SetPoint("TOPLEFT", playerCheck, "BOTTOMLEFT", 0, -20)
	playerPortCheck.text:SetText("Enable portrait")
	playerPortCheck:SetChecked(mUI.profile.player.portrait.enabled)
	playerPortCheck:SetScript("OnClick", function(self)
		mUI.profile.player.portrait.enabled = self:GetChecked()
	end)

	local petCheck = CreateFrame("CheckButton", nil, playerFrame, "UICheckButtonTemplate")
	petCheck:SetPoint("TOPLEFT", playerPortCheck, "BOTTOMLEFT", 0, -20)
	petCheck.text:SetText("Enable pet frame")
	petCheck:SetChecked(mUI.profile.pet.enabled)
	petCheck:SetScript("OnClick", function(self)
		mUI.profile.pet.enabled = self:GetChecked()
	end)

	local petPortCheck = CreateFrame("CheckButton", nil, playerFrame, "UICheckButtonTemplate")
	petPortCheck:SetPoint("TOPLEFT", petCheck, "BOTTOMLEFT", 0, -20)
	petPortCheck.text:SetText("Enable pet portrait")
	petPortCheck:SetChecked(mUI.profile.pet.portrait.enabled)
	petPortCheck:SetScript("OnClick", function(self)
		mUI.profile.pet.portrait.enabled = self:GetChecked()
	end)

	local targetTab = mUI:CreateButton(100, 20, "Target", unitsFrame, function()
		HideUnitFrames()
		targetFrame:Show()
	end)
	targetTab:SetPoint("LEFT", playerTab, "RIGHT", 2, 0)

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

	local targetPortCheck = CreateFrame("CheckButton", nil, targetFrame, "UICheckButtonTemplate")
	targetPortCheck:SetPoint("TOPLEFT", targetCheck, "BOTTOMLEFT", 0, -20)
	targetPortCheck.text:SetText("Enable portrait")
	targetPortCheck:SetChecked(mUI.profile.target.portrait.enabled)
	targetPortCheck:SetScript("OnClick", function(self)
		mUI.profile.target.portrait.enabled = self:GetChecked()
	end)

	local targettargetCheck = CreateFrame("CheckButton", nil, targetFrame, "UICheckButtonTemplate")
	targettargetCheck:SetPoint("TOPLEFT", targetPortCheck, "BOTTOMLEFT", 0, -20)
	targettargetCheck.text:SetText("Enable totframe")
	targettargetCheck:SetChecked(mUI.profile.targettarget.enabled)
	targettargetCheck:SetScript("OnClick", function(self)
		mUI.profile.targettarget.enabled = self:GetChecked()
	end)

	local targettargetPortCheck = CreateFrame("CheckButton", nil, targetFrame, "UICheckButtonTemplate")
	targettargetPortCheck:SetPoint("TOPLEFT", targettargetCheck, "BOTTOMLEFT", 0, -20)
	targettargetPortCheck.text:SetText("Enable target of target portrait")
	targettargetPortCheck:SetChecked(mUI.profile.targettarget.portrait.enabled)
	targettargetPortCheck:SetScript("OnClick", function(self)
		mUI.profile.targettarget.portrait.enabled = self:GetChecked()
	end)

	local focusTab = mUI:CreateButton(100, 20, "Focus", unitsFrame, function()
		HideUnitFrames()
		focusFrame:Show()
	end)
	focusTab:SetPoint("LEFT", targetTab, "RIGHT", 2, 0)

	focusFrame = CreateFrame("Frame", nil, unitsFrame)
	focusFrame:SetAllPoints()
	focusFrame:Hide()

	local titleText = focusFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("TOP", focusFrame, "TOP", 0, -10)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 20, "THINOUTLINE")
	titleText:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleText:SetText("Focus")

	local focusCheck = CreateFrame("CheckButton", nil, focusFrame, "UICheckButtonTemplate")
	focusCheck:SetPoint("TOPLEFT", 20, -20)
	focusCheck.text:SetText("Enable focus frame")
	focusCheck:SetChecked(mUI.profile.focus.enabled)
	focusCheck:SetScript("OnClick", function(self)
		mUI.profile.focus.enabled = self:GetChecked()
	end)

	local focusPortCheck = CreateFrame("CheckButton", nil, focusFrame, "UICheckButtonTemplate")
	focusPortCheck:SetPoint("TOPLEFT", focusCheck, "BOTTOMLEFT", 0, -20)
	focusPortCheck.text:SetText("Enable portrait")
	focusPortCheck:SetChecked(mUI.profile.focus.portrait.enabled)
	focusPortCheck:SetScript("OnClick", function(self)
		mUI.profile.focus.portrait.enabled = self:GetChecked()
	end)

	local partyTab = mUI:CreateButton(100, 20, "Party", unitsFrame, function()
		HideUnitFrames()
		partyFrame:Show()
	end)
	partyTab:SetPoint("LEFT", focusTab, "RIGHT", 2, 0)

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

	local partyPortCheck = CreateFrame("CheckButton", nil, partyFrame, "UICheckButtonTemplate")
	partyPortCheck:SetPoint("TOPLEFT", partyCheck, "BOTTOMLEFT", 0, -20)
	partyPortCheck.text:SetText("Enable portrait")
	partyPortCheck:SetChecked(mUI.profile.party.portrait.enabled)
	partyPortCheck:SetScript("OnClick", function(self)
		mUI.profile.party.portrait.enabled = self:GetChecked()
	end)

	local raidTab = mUI:CreateButton(100, 20, "Raid", unitsFrame, function()
		HideUnitFrames()
		raidFrame:Show()
	end)
	raidTab:SetPoint("LEFT", partyTab, "RIGHT", 2, 0)

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

	local raidPortCheck = CreateFrame("CheckButton", nil, raidFrame, "UICheckButtonTemplate")
	raidPortCheck:SetPoint("TOPLEFT", raidCheck, "BOTTOMLEFT", 0, -20)
	raidPortCheck.text:SetText("Enable portrait")
	raidPortCheck:SetChecked(mUI.profile.raid.portrait.enabled)
	raidPortCheck:SetScript("OnClick", function(self)
		mUI.profile.raid.portrait.enabled = self:GetChecked()
	end)

	local bossTab = mUI:CreateButton(100, 20, "Boss", unitsFrame, function()
		HideUnitFrames()
		bossFrame:Show()
	end)
	bossTab:SetPoint("LEFT", raidTab, "RIGHT", 2, 0)

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

	local bossPortCheck = CreateFrame("CheckButton", nil, bossFrame, "UICheckButtonTemplate")
	bossPortCheck:SetPoint("TOPLEFT", bossCheck, "BOTTOMLEFT", 0, -20)
	bossPortCheck.text:SetText("Enable portrait")
	bossPortCheck:SetChecked(mUI.profile.boss.portrait.enabled)
	bossPortCheck:SetScript("OnClick", function(self)
		mUI.profile.boss.portrait.enabled = self:GetChecked()
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

	local profileDropdown = CreateFrame("Frame", "MangoFontDropdown", profilesFrame, "UIDropDownMenuTemplate")
	profileDropdown:SetPoint("TOP", profilesFrame, "TOP", 0, -10)
	UIDropDownMenu_SetWidth(profileDropdown, 200)
	UIDropDownMenu_SetText(profileDropdown, "Current profile:" .. " " .. mUI:GetCurrentProfile())

	local function profileDropdownClick(self, arg1, arg2, checked)
		mUI:SetProfile(arg1)
		UIDropDownMenu_SetText(profileDropdown, arg1)
	end

	UIDropDownMenu_Initialize(profileDropdown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()

		for k, _ in next, mUI.profiles do
			info.text, info.arg1, info.checked = k, k, k == mUI:GetCurrentProfile()
			info.func = profileDropdownClick
			UIDropDownMenu_AddButton(info, level)
		end
	end)

	-- Create new profile
	StaticPopupDialogs.CreateProfilePopup = {
		text = "Enter name",
		button1 = OKAY,
		button2 = CANCEL,
		OnAccept = function(self)
			if self.table then
				mUI:CreateProfile(self.editBox:GetText(), self.table)
			else
				mUI:CreateProfile(self.editBox:GetText())
			end
		end,
		hasEditBox = 1,
		whileDead = true,
		hideOnEscape = true
	}

	local createProfileBtn = mUI:CreateButton(200, 40, "Create new profile", profilesFrame, function()
		StaticPopup_Show("CreateProfilePopup")
	end)
	createProfileBtn:SetPoint("TOP", profileDropdown, "BOTTOM", 0, -10)

	-- Import profile
	StaticPopupDialogs.ImportProfilePopup = {
		text = "Enter import string",
		button1 = OKAY,
		button2 = CANCEL,
		OnAccept = function(self)
			local dialog = StaticPopup_Show("CreateProfilePopup")
			dialog.table = self.editBox:GetText()
		end,
		hasEditBox = 1,
		whileDead = true,
		hideOnEscape = true
	}

	local importProfileBtn = mUI:CreateButton(200, 40, "Import new profile", profilesFrame, function()
		StaticPopup_Show("ImportProfilePopup")
	end)
	importProfileBtn:SetPoint("TOP", createProfileBtn, "BOTTOM", 0, -10)

	-- Export profile
	StaticPopupDialogs.ExportProfilePopup = {
		text = "Copy the export string",
		button1 = OKAY,
		OnShow = function(self)
			self.editBox:SetText(mUI:GetProfileExportString())
			self.editBox:HighlightText()
		end,
		hasEditBox = 1,
		whileDead = true,
		hideOnEscape = true
	}

	local exportProfileBtn = mUI:CreateButton(200, 40, "Export profile", profilesFrame, function()
		StaticPopup_Show("ExportProfilePopup")
	end)
	exportProfileBtn:SetPoint("TOP", importProfileBtn, "BOTTOM", 0, -10)

	-- Delete profile
	StaticPopupDialogs.DeleteProfilePopup = {
		text = "Are you sure? (Type DELETE to confirm)",
		button1 = OKAY,
		button2 = CANCEL,
		OnShow = function(self)
			self.button1:Disable()
		end,
		OnAccept = function(self)
			if self.editBox:GetText() ~= "DELETE" then return end
			print("ACCEPT PROFILE: " .. self.profile)
			mUI:DeleteProfile(self.profile)
		end,
		EditBoxOnTextChanged = function(self)
			if self:GetText() == "DELETE" then
				self:GetParent().button1:Enable()
			else
				self:GetParent().button1:Disable()
			end
		end,
		hasEditBox = 1,
		whileDead = true,
		hideOnEscape = true
	}

	local deleteProfileDropdown = CreateFrame("Frame", "MangoFontDropdown", profilesFrame, "UIDropDownMenuTemplate")
	deleteProfileDropdown:SetPoint("BOTTOM", profilesFrame, "BOTTOM", 0, 10)
	UIDropDownMenu_SetWidth(deleteProfileDropdown, 200)
	UIDropDownMenu_SetText(deleteProfileDropdown, "Delete profile")

	local function deleteProfileDropdownClick(self, arg1, arg2, checked)
		local dialog = StaticPopup_Show("DeleteProfilePopup")
		if dialog then
			dialog.profile = arg1
		end
		UIDropDownMenu_SetText(deleteProfileDropdown, arg1)
	end

	UIDropDownMenu_Initialize(deleteProfileDropdown, function(self, level, menuList)
		local info = UIDropDownMenu_CreateInfo()
		for k, _ in next, mUI.profiles do
			info.text, info.arg1 = k, k
			info.func = deleteProfileDropdownClick
			UIDropDownMenu_AddButton(info, level)
		end
	end)
end

SettingsRegistrar:AddRegistrant(RegisterSettings)

function mUI:ToggleOptions()
	if settingsFrame:IsShown() then
		settingsFrame:Hide()
	else
		settingsFrame:Show()
	end
end

SLASH_MANGOUI1, SLASH_MANGOUI2, SLASH_MANGOUI3 = '/mui', '/mango', '/mangoui'

SlashCmdList["MANGOUI"] = mUI.ToggleOptions