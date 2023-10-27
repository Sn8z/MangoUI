local _, mUI = ...
local oUF = mUI.oUF
local LSM = LibStub("LibSharedMedia-3.0")

local _, class = UnitClass("player")
local playerColor = oUF.colors.class[class]

-- Overall frames
local settingsFrame, generalFrame, unitsFrame, aurasFrame, profilesFrame
local generalTab, unitsTab, aurasTab, profilesTab
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
	settingsFrame:SetBackdropColor(0.12, 0.12, 0.12, 1)
	settingsFrame:SetBackdropBorderColor(0, 0, 0, 1)
	settingsFrame:EnableMouse(true)
	settingsFrame:SetMovable(true)
	settingsFrame:SetFrameStrata("DIALOG")
	settingsFrame:RegisterForDrag("LeftButton")
	settingsFrame:SetScript("OnDragStart", settingsFrame.StartMoving)
	settingsFrame:SetScript("OnDragStop", settingsFrame.StopMovingOrSizing)
	--settingsFrame:Hide()

	-- Logo
	local logo = settingsFrame:CreateTexture(nil, "ARTWORK")
	logo:SetTexture([[Interface\AddOns\MangoUI\Media\mangologo.tga]])
	logo:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT", -30, 30)
	logo:SetSize(100, 100)

	-- Title Text
	local titleText = settingsFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("LEFT", logo, "RIGHT", 10, 0)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 32, "THINOUTLINE")
	titleText:SetTextColor(1, 1, 1, 1)
	titleText:SetText("Mango")
	local titleTextAddon = settingsFrame:CreateFontString(nil, "OVERLAY")
	titleTextAddon:SetPoint("LEFT", titleText, "RIGHT", 0, 0)
	titleTextAddon:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 32, "THINOUTLINE")
	titleTextAddon:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleTextAddon:SetText("UI")

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
		generalTab.label:SetTextColor(1, 1, 1, 1)
		unitsFrame:Hide()
		unitsTab.label:SetTextColor(1, 1, 1, 1)
		aurasFrame:Hide()
		aurasTab.label:SetTextColor(1, 1, 1, 1)
		profilesFrame:Hide()
		profilesTab.label:SetTextColor(1, 1, 1, 1)
		HideUnitFrames()
	end

	generalTab = mUI:CreateButton(140, 20, "General", settingsFrame, function(self)
		HideFrames()
		generalFrame:Show()
		self.label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	end)
	generalTab:SetPoint("TOPLEFT", settingsFrame, "BOTTOMLEFT", 2, 0)

	unitsTab = mUI:CreateButton(140, 20, "Units", settingsFrame, function(self)
		HideFrames()
		unitsFrame:Show()
		playerFrame:Show()
		self.label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	end)
	unitsTab:SetPoint("TOPLEFT", generalTab, "TOPRIGHT", 2, 0)

	aurasTab = mUI:CreateButton(140, 20, "Auras", settingsFrame, function(self)
		HideFrames()
		aurasFrame:Show()
		self.label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	end)
	aurasTab:SetPoint("TOPLEFT", unitsTab, "TOPRIGHT", 2, 0)

	profilesTab = mUI:CreateButton(140, 20, "Profiles", settingsFrame, function(self)
		HideFrames()
		profilesFrame:Show()
		self.label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
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
	generalFrame:SetBackdropBorderColor(0.2, 0.2, 0.2, 1)

	local titleText = generalFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("BOTTOM", generalFrame, "TOP", 0, 5)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 20, "THINOUTLINE")
	titleText:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleText:SetText("General")

	local generalArea = mUI:CreateArea("", generalFrame)
	generalArea:SetPoint("TOPLEFT", generalFrame, "TOPLEFT", 10, -10)
	generalArea:SetPoint("TOPRIGHT", generalFrame, "TOPRIGHT", -10, -10)
	generalArea:SetHeight(60)

	local smoothCheck = mUI:CreateCheckBox("|cff00ff00Enable|r Smooth Bars", mUI.profile.settings.smooth, generalArea,
		function(isChecked)
			mUI.profile.settings.smooth = isChecked
		end)
	smoothCheck:SetPoint("LEFT", 10, 0)

	local colorCheck = mUI:CreateCheckBox("|cff00ff00Enable|r MangoUI colors", mUI.profile.settings.mangoColors,
		generalArea,
		function(isChecked)
			mUI.profile.settings.mangoColors = isChecked
		end)
	colorCheck:SetPoint("CENTER", -60, 0)

	local borderSlider = mUI:CreateSlider(0, 10, 1, "Border Size", mUI.profile.settings.borderSize, generalArea,
		function(value)
			mUI.profile.settings.borderSize = value
		end)
	borderSlider:SetPoint("RIGHT", -10, 0)

	local textureArea = mUI:CreateArea("Textures", generalFrame)
	textureArea:SetPoint("TOPLEFT", generalArea, "BOTTOMLEFT", 0, -20)
	textureArea:SetPoint("BOTTOMRIGHT", generalFrame, "BOTTOM", -5, 10)

	local healthTextureDropdown = mUI:CreateDropdown("Health:", mUI.profile.settings.healthTexture,
		LSM:List("statusbar"),
		textureArea, function(value)
			mUI.profile.settings.healthTexture = value
		end)
	healthTextureDropdown:SetPoint("TOPLEFT", 10, -40)

	local powerTextureDropdown = mUI:CreateDropdown("Power:", mUI.profile.settings.powerTexture,
		LSM:List("statusbar"), textureArea,
		function(value)
			mUI.profile.settings.powerTexture = value
		end)
	powerTextureDropdown:SetPoint("TOPLEFT", healthTextureDropdown, "BOTTOMLEFT", 0, -20)

	local castbarTextureDropdown = mUI:CreateDropdown("Castbar:", mUI.profile.settings.castbarTexture,
		LSM:List("statusbar"),
		textureArea, function(value)
			mUI.profile.settings.castbarTexture = value
		end)
	castbarTextureDropdown:SetPoint("TOPLEFT", powerTextureDropdown, "BOTTOMLEFT", 0, -20)

	local fontArea = mUI:CreateArea("Fonts", generalFrame)
	fontArea:SetPoint("TOPRIGHT", generalArea, "BOTTOMRIGHT", 0, -20)
	fontArea:SetPoint("BOTTOMLEFT", generalFrame, "BOTTOM", 5, 10)

	local fontDropdown = mUI:CreateDropdown("Font:", mUI.profile.settings.font, LSM:List("font"), fontArea,
		function(value)
			mUI.profile.settings.font = value
		end)
	fontDropdown:SetPoint("TOPLEFT", 10, -40)

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

	local playerCheck = mUI:CreateCheckBox("Enable Player frame", mUI.profile.player.enabled, playerFrame,
		function(isChecked)
			mUI.profile.player.enabled = isChecked
		end)
	playerCheck:SetPoint("TOPLEFT", 20, -20)

	local playerPortraitCheck = mUI:CreateCheckBox("Enable Player portrait", mUI.profile.player.portrait.enabled,
		playerFrame,
		function(isChecked)
			mUI.profile.player.portrait.enabled = isChecked
		end)
	playerPortraitCheck:SetPoint("TOPLEFT", playerCheck, "BOTTOMLEFT", 0, -20)

	local playerPowerCheck = mUI:CreateCheckBox("Enable Player power", mUI.profile.player.power.enabled,
		playerFrame,
		function(isChecked)
			mUI.profile.player.power.enabled = isChecked
		end)
	playerPowerCheck:SetPoint("TOPLEFT", playerPortraitCheck, "BOTTOMLEFT", 0, -20)

	local playerPowerDetachCheck = mUI:CreateCheckBox("Detach Player power", mUI.profile.player.power.detach,
		playerFrame,
		function(isChecked)
			mUI.profile.player.power.detach = isChecked
		end)
	playerPowerDetachCheck:SetPoint("TOPLEFT", playerPowerCheck, "BOTTOMLEFT", 0, -20)

	local playerCastbarCheck = mUI:CreateCheckBox("Enable Player castbar", mUI.profile.player.castbar.enabled,
		playerFrame,
		function(isChecked)
			mUI.profile.player.castbar.enabled = isChecked
		end)
	playerCastbarCheck:SetPoint("TOPLEFT", playerPowerDetachCheck, "BOTTOMLEFT", 0, -20)

	local playerCastbarDetachCheck = mUI:CreateCheckBox("Detach Player castbar", mUI.profile.player.castbar.detach,
		playerFrame,
		function(isChecked)
			mUI.profile.player.castbar.detach = isChecked
		end)
	playerCastbarDetachCheck:SetPoint("TOPLEFT", playerCastbarCheck, "BOTTOMLEFT", 0, -20)

	local playerClasspowerCheck = mUI:CreateCheckBox("Enable Player classpower", mUI.profile.player.classpower.enabled,
		playerFrame,
		function(isChecked)
			mUI.profile.player.classpower.enabled = isChecked
		end)
	playerClasspowerCheck:SetPoint("TOPLEFT", playerCastbarDetachCheck, "BOTTOMLEFT", 0, -20)

	local playerClasspowerDetachCheck = mUI:CreateCheckBox("Detach Player classpower", mUI.profile.player.classpower
		.detach,
		playerFrame,
		function(isChecked)
			mUI.profile.player.classpower.detach = isChecked
		end)
	playerClasspowerDetachCheck:SetPoint("TOPLEFT", playerClasspowerCheck, "BOTTOMLEFT", 0, -20)

	local petCheck = mUI:CreateCheckBox("Enable Pet frame", mUI.profile.pet.enabled, playerFrame,
		function(isChecked)
			mUI.profile.pet.enabled = isChecked
		end)
	petCheck:SetPoint("TOPLEFT", playerClasspowerDetachCheck, "BOTTOMLEFT", 0, -50)

	local petPortraitCheck = mUI:CreateCheckBox("Enable Pet portrait", mUI.profile.pet.portrait.enabled, playerFrame,
		function(isChecked)
			mUI.profile.pet.portrait.enabled = isChecked
		end)
	petPortraitCheck:SetPoint("TOPLEFT", petCheck, "BOTTOMLEFT", 0, -20)

	local playerWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.player.width, playerFrame,
		function(value)
			mUI.profile.player.width = value
		end)
	playerWidthSlider:SetPoint("TOPRIGHT", playerFrame, "TOPRIGHT", -10, -30)

	local playerHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.player.height, playerFrame,
		function(value)
			mUI.profile.player.height = value
		end)
	playerHeightSlider:SetPoint("TOP", playerWidthSlider, "BOTTOM", 0, -30)

	local petWidthSlider = mUI:CreateSlider(20, 400, 1, "Pet Width", mUI.profile.pet.width, playerFrame,
		function(value)
			mUI.profile.pet.width = value
		end)
	petWidthSlider:SetPoint("TOP", playerHeightSlider, "BOTTOM", 0, -50)

	local petHeightSlider = mUI:CreateSlider(6, 200, 1, "Pet Height", mUI.profile.pet.height, playerFrame,
		function(value)
			mUI.profile.pet.height = value
		end)
	petHeightSlider:SetPoint("TOP", petWidthSlider, "BOTTOM", 0, -30)

	local powerWidthSlider = mUI:CreateSlider(20, 400, 1, "Power Width", mUI.profile.player.power.width, playerFrame,
		function(value)
			mUI.profile.player.power.width = value
		end)
	powerWidthSlider:SetPoint("TOP", petHeightSlider, "BOTTOM", 0, -50)

	local powerHeightSlider = mUI:CreateSlider(6, 200, 1, "Power Height", mUI.profile.player.power.height, playerFrame,
		function(value)
			mUI.profile.player.power.height = value
		end)
	powerHeightSlider:SetPoint("TOP", powerWidthSlider, "BOTTOM", 0, -30)

	local castbarWidthSlider = mUI:CreateSlider(20, 400, 1, "Castbar Width", mUI.profile.player.castbar.width, playerFrame,
		function(value)
			mUI.profile.player.castbar.width = value
		end)
	castbarWidthSlider:SetPoint("TOP", powerHeightSlider, "BOTTOM", 0, -50)

	local castbarHeightSlider = mUI:CreateSlider(6, 200, 1, "Castbar Height", mUI.profile.player.castbar.height,
		playerFrame,
		function(value)
			mUI.profile.player.castbar.height = value
			print(value)
		end)
	castbarHeightSlider:SetPoint("TOP", castbarWidthSlider, "BOTTOM", 0, -30)

	local classpowerWidthSlider = mUI:CreateSlider(20, 400, 1, "Classpower Width", mUI.profile.player.classpower.width,
		playerFrame,
		function(value)
			mUI.profile.player.classpower.width = value
		end)
	classpowerWidthSlider:SetPoint("TOP", playerFrame, "TOP", 0, -100)

	local classpowerHeightSlider = mUI:CreateSlider(6, 200, 1, "Classpower Height", mUI.profile.player.classpower.height,
		playerFrame,
		function(value)
			mUI.profile.player.classpower.height = value
		end)
	classpowerHeightSlider:SetPoint("TOP", classpowerWidthSlider, "BOTTOM", 0, -30)

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

	local targetCheck = mUI:CreateCheckBox("Enable Target frame", mUI.profile.target.enabled, targetFrame,
		function(isChecked)
			mUI.profile.target.enabled = isChecked
		end)
	targetCheck:SetPoint("TOPLEFT", 20, -20)

	local targetPortraitCheck = mUI:CreateCheckBox("Enable Target portrait", mUI.profile.target.portrait.enabled,
		targetFrame,
		function(isChecked)
			mUI.profile.target.portrait.enabled = isChecked
		end)
	targetPortraitCheck:SetPoint("TOPLEFT", targetCheck, "BOTTOMLEFT", 0, -20)

	local totCheck = mUI:CreateCheckBox("Enable Target of Target frame", mUI.profile.targettarget.enabled, targetFrame,
		function(isChecked)
			mUI.profile.targettarget.enabled = isChecked
		end)
	totCheck:SetPoint("TOPLEFT", targetPortraitCheck, "BOTTOMLEFT", 0, -20)

	local totPortraitCheck = mUI:CreateCheckBox("Enable Target of Target portrait",
		mUI.profile.targettarget.portrait.enabled,
		targetFrame,
		function(isChecked)
			mUI.profile.targettarget.portrait.enabled = isChecked
		end)
	totPortraitCheck:SetPoint("TOPLEFT", totCheck, "BOTTOMLEFT", 0, -20)

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

	local focusCheck = mUI:CreateCheckBox("Enable Focus frame", mUI.profile.focus.enabled, focusFrame,
		function(isChecked)
			mUI.profile.focus.enabled = isChecked
		end)
	focusCheck:SetPoint("TOPLEFT", 20, -20)

	local focusPortraitCheck = mUI:CreateCheckBox("Enable Focus portrait", mUI.profile.focus.portrait.enabled, focusFrame,
		function(isChecked)
			mUI.profile.focus.portrait.enabled = isChecked
		end)
	focusPortraitCheck:SetPoint("TOPLEFT", focusCheck, "BOTTOMLEFT", 0, -20)

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


	local partyCheck = mUI:CreateCheckBox("Enable Party frames", mUI.profile.party.enabled, partyFrame,
		function(isChecked)
			mUI.profile.party.enabled = isChecked
		end)
	partyCheck:SetPoint("TOPLEFT", 20, -20)

	local partyPortraitCheck = mUI:CreateCheckBox("Enable Party portraits", mUI.profile.party.portrait.enabled, partyFrame,
		function(isChecked)
			mUI.profile.party.portrait.enabled = isChecked
		end)
	partyPortraitCheck:SetPoint("TOPLEFT", partyCheck, "BOTTOMLEFT", 0, -20)

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

	local raidCheck = mUI:CreateCheckBox("Enable Raid frames", mUI.profile.raid.enabled, raidFrame,
		function(isChecked)
			mUI.profile.raid.enabled = isChecked
		end)
	raidCheck:SetPoint("TOPLEFT", 20, -20)

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

	local bossCheck = mUI:CreateCheckBox("Enable Boss frames", mUI.profile.boss.enabled, bossFrame,
		function(isChecked)
			mUI.profile.boss.enabled = isChecked
		end)
	bossCheck:SetPoint("TOPLEFT", 20, -20)

	local bossPortraitCheck = mUI:CreateCheckBox("Enable Boss portraits", mUI.profile.boss.portrait.enabled, bossFrame,
		function(isChecked)
			mUI.profile.boss.portrait.enabled = isChecked
		end)
	bossPortraitCheck:SetPoint("TOPLEFT", bossCheck, "BOTTOMLEFT", 0, -20)

	aurasFrame = CreateFrame("Frame", nil, settingsFrame, "BackdropTemplate")
	aurasFrame:SetPoint("TOPLEFT", settingsFrame, "TOPLEFT", 10, -100)
	aurasFrame:SetPoint("BOTTOMRIGHT", settingsFrame, "BOTTOMRIGHT", -10, 10)
	aurasFrame:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 1,
	})
	aurasFrame:SetBackdropColor(0.1, 0.1, 0.1, 1)
	aurasFrame:SetBackdropBorderColor(0, 0, 0, 1)
	aurasFrame:Hide()

	local titleText = aurasFrame:CreateFontString(nil, "OVERLAY")
	titleText:SetPoint("BOTTOM", aurasFrame, "TOP", 0, 5)
	titleText:SetFont(LSM:Fetch("font", "Ubuntu Medium"), 20, "THINOUTLINE")
	titleText:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	titleText:SetText("Coming soon...")

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
