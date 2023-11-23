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
local playerTab, targetTab, focusTab, partyTab, raidTab, bossTab

local function RegisterSettings()
	settingsFrame = CreateFrame("Frame", "MangoSettingsFrame", UIParent, "BackdropTemplate")
	settingsFrame:SetSize(900, 800)
	settingsFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	settingsFrame:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\carbon.tga]],
		edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		tile = true,
		tileSize = 32,
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
	settingsFrame:Hide()

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

	local closeButton = mUI:CreateButton(28, 28, "X", settingsFrame, function(self)
		settingsFrame:Hide()
	end)
	closeButton:SetPoint("TOPRIGHT", -3, -3)

	local reloadButton = mUI:CreateButton(100, 28, "Reload", settingsFrame, function()
		ReloadUI()
	end)
	reloadButton:SetPoint("TOPRIGHT", closeButton, "TOPLEFT", -60, 0)

	local testModeButton = mUI:CreateButton(100, 28, "Test Frames", settingsFrame, function()
		mUI:ToggleFrames()
	end)
	testModeButton:SetPoint("TOPRIGHT", reloadButton, "TOPLEFT", -10, 0)

	local movableButton = mUI:CreateButton(100, 28, "Move Frames", settingsFrame, function()
		mUI:ToggleMovable()
	end)
	movableButton:SetPoint("TOPRIGHT", testModeButton, "TOPLEFT", -10, 0)

	local function HideUnitFrames()
		playerFrame:Hide()
		playerTab.label:SetTextColor(1, 1, 1, 1)
		targetFrame:Hide()
		targetTab.label:SetTextColor(1, 1, 1, 1)
		focusFrame:Hide()
		focusTab.label:SetTextColor(1, 1, 1, 1)
		partyFrame:Hide()
		partyTab.label:SetTextColor(1, 1, 1, 1)
		raidFrame:Hide()
		raidTab.label:SetTextColor(1, 1, 1, 1)
		bossFrame:Hide()
		bossTab.label:SetTextColor(1, 1, 1, 1)
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
		playerTab.label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
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
	generalTab.label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)

	local generalArea = mUI:CreateArea("", generalFrame)
	generalArea:SetPoint("TOPLEFT", generalFrame, "TOPLEFT", 10, -10)
	generalArea:SetPoint("TOPRIGHT", generalFrame, "TOPRIGHT", -10, -10)
	generalArea:SetHeight(60)

	local smoothCheck = mUI:CreateCheckBox("|cff00ff00Enable|r Smooth Bars", mUI.profile.settings.smooth, generalArea,
		function(isChecked)
			mUI.profile.settings.smooth = isChecked
		end)
	smoothCheck:SetPoint("LEFT", 20, 0)

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
	borderSlider:SetPoint("RIGHT", -20, 0)

	local actionbarArea = mUI:CreateArea("Actionbars |cffffaa00(Experimental)|r", generalFrame)
	actionbarArea:SetPoint("TOPLEFT", generalArea, "BOTTOMLEFT", 0, -10)
	actionbarArea:SetPoint("TOPRIGHT", generalArea, "BOTTOMRIGHT", 0, -10)
	actionbarArea:SetHeight(60)

	local actionbarCheck = mUI:CreateCheckBox("|cff00ff00Enable|r Mango actionbars", mUI.profile.settings.actionbars.enabled, actionbarArea,
		function(isChecked)
			mUI.profile.settings.actionbars.enabled = isChecked
		end)
	actionbarCheck:SetPoint("LEFT", 20, 0)

	local actionbarAnimCheck = mUI:CreateCheckBox("|cff00ff00Enable|r Blizzard actionbar animations",
		mUI.profile.settings.actionbars.animations, actionbarArea,
		function(isChecked)
			mUI.profile.settings.actionbars.animations = isChecked
		end)
	actionbarAnimCheck:SetPoint("CENTER", -60, 0)

	local textureArea = mUI:CreateArea("Textures", generalFrame)
	textureArea:SetPoint("TOPLEFT", actionbarArea, "BOTTOMLEFT", 0, -20)
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
	fontArea:SetPoint("TOPRIGHT", actionbarArea, "BOTTOMRIGHT", 0, -20)
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

	playerTab = mUI:CreateButton(100, 20, "Player", unitsFrame, function(self)
		HideUnitFrames()
		playerFrame:Show()
		self.label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	end)
	playerTab:SetPoint("BOTTOMLEFT", unitsFrame, "TOPLEFT", 2, 0)

	playerFrame = CreateFrame("Frame", nil, unitsFrame)
	playerFrame:SetAllPoints()

	local playerArea = mUI:CreateArea("", playerFrame)
	playerArea:SetPoint("TOPLEFT", playerFrame, "TOPLEFT", 10, -10)
	playerArea:SetPoint("TOPRIGHT", playerFrame, "TOPRIGHT", -10, -10)
	playerArea:SetHeight(140)

	local playerCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.player.enabled, playerArea,
		function(isChecked)
			mUI.profile.player.enabled = isChecked
		end)
	playerCheck:SetPoint("LEFT", 20, 0)

	local playerPortraitCheck = mUI:CreateCheckBox("|cff00ff00Enable|r portrait", mUI.profile.player.portrait.enabled,
		playerArea,
		function(isChecked)
			mUI.profile.player.portrait.enabled = isChecked
		end)
	playerPortraitCheck:SetPoint("LEFT", playerCheck, "RIGHT", 80, 0)

	local playerWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.player.width, playerArea,
		function(value)
			mUI.profile.player.width = value
		end)
	playerWidthSlider:SetPoint("TOPRIGHT", -20, -30)

	local playerHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.player.height, playerArea,
		function(value)
			mUI.profile.player.height = value
		end)
	playerHeightSlider:SetPoint("RIGHT", playerWidthSlider, "LEFT", -20, 0)

	local playerXSlider = mUI:CreateSlider(-1000, 1000, 1, "X pos", mUI.profile.player.x, playerArea,
		function(value)
			mUI.profile.player.x = value
		end)
	playerXSlider:SetPoint("TOP", playerHeightSlider, "BOTTOM", 0, -40)

	local playerYSlider = mUI:CreateSlider(-1000, 1000, 1, "Y pos", mUI.profile.player.y, playerArea,
		function(value)
			mUI.profile.player.y = value
		end)
	playerYSlider:SetPoint("TOP", playerWidthSlider, "BOTTOM", 0, -40)

	local playerPowerArea = mUI:CreateArea("Power", playerFrame)
	playerPowerArea:SetPoint("TOPLEFT", playerArea, "BOTTOMLEFT", 0, -10)
	playerPowerArea:SetPoint("TOPRIGHT", playerArea, "BOTTOMRIGHT", 0, -10)
	playerPowerArea:SetHeight(140)

	local playerPowerCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.player.power.enabled,
		playerPowerArea,
		function(isChecked)
			mUI.profile.player.power.enabled = isChecked
		end)
	playerPowerCheck:SetPoint("LEFT", 20, 0)

	local playerPowerDetachCheck = mUI:CreateCheckBox("Detach", mUI.profile.player.power.detach,
		playerPowerArea,
		function(isChecked)
			mUI.profile.player.power.detach = isChecked
		end)
	playerPowerDetachCheck:SetPoint("LEFT", playerPowerCheck, "RIGHT", 80, 0)

	local powerWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.player.power.width, playerPowerArea,
		function(value)
			mUI.profile.player.power.width = value
		end)
	powerWidthSlider:SetPoint("RIGHT", -20, 0)

	local powerHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.player.power.height, playerPowerArea,
		function(value)
			mUI.profile.player.power.height = value
		end)
	powerHeightSlider:SetPoint("RIGHT", powerWidthSlider, "LEFT", -20, 0)

	local playerClasspowerArea = mUI:CreateArea("Classpower", playerFrame)
	playerClasspowerArea:SetPoint("TOPLEFT", playerPowerArea, "BOTTOMLEFT", 0, -10)
	playerClasspowerArea:SetPoint("TOPRIGHT", playerPowerArea, "BOTTOMRIGHT", 0, -10)
	playerClasspowerArea:SetHeight(140)

	local playerClasspowerCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.player.classpower.enabled,
		playerClasspowerArea,
		function(isChecked)
			mUI.profile.player.classpower.enabled = isChecked
		end)
	playerClasspowerCheck:SetPoint("LEFT", 20, 0)

	local playerClasspowerDetachCheck = mUI:CreateCheckBox("Detach", mUI.profile.player.classpower
		.detach,
		playerClasspowerArea,
		function(isChecked)
			mUI.profile.player.classpower.detach = isChecked
		end)
	playerClasspowerDetachCheck:SetPoint("LEFT", playerClasspowerCheck, "RIGHT", 80, 0)

	local classpowerWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.player.classpower.width,
		playerClasspowerArea,
		function(value)
			mUI.profile.player.classpower.width = value
		end)
	classpowerWidthSlider:SetPoint("RIGHT", -20, 0)

	local classpowerHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.player.classpower.height,
		playerClasspowerArea,
		function(value)
			mUI.profile.player.classpower.height = value
		end)
	classpowerHeightSlider:SetPoint("RIGHT", classpowerWidthSlider, "LEFT", -20, 0)

	local playerCastbarArea = mUI:CreateArea("Castbar", playerFrame)
	playerCastbarArea:SetPoint("TOPLEFT", playerClasspowerArea, "BOTTOMLEFT", 0, -10)
	playerCastbarArea:SetPoint("TOPRIGHT", playerClasspowerArea, "BOTTOMRIGHT", 0, -10)
	playerCastbarArea:SetHeight(140)

	local playerCastbarCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.player.castbar.enabled,
		playerCastbarArea,
		function(isChecked)
			mUI.profile.player.castbar.enabled = isChecked
		end)
	playerCastbarCheck:SetPoint("LEFT", 20, 0)

	local playerCastbarDetachCheck = mUI:CreateCheckBox("Detach", mUI.profile.player.castbar.detach,
		playerCastbarArea,
		function(isChecked)
			mUI.profile.player.castbar.detach = isChecked
		end)
	playerCastbarDetachCheck:SetPoint("LEFT", playerCastbarCheck, "RIGHT", 80, 0)

	local castbarWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.player.castbar.width, playerCastbarArea,
		function(value)
			mUI.profile.player.castbar.width = value
		end)
	castbarWidthSlider:SetPoint("RIGHT", -20, 0)

	local castbarHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.player.castbar.height,
		playerCastbarArea,
		function(value)
			mUI.profile.player.castbar.height = value
		end)
	castbarHeightSlider:SetPoint("RIGHT", castbarWidthSlider, "LEFT", -20, 0)

	local playerPetArea = mUI:CreateArea("Pet", playerFrame)
	playerPetArea:SetPoint("TOPLEFT", playerCastbarArea, "BOTTOMLEFT", 0, -10)
	playerPetArea:SetPoint("BOTTOMRIGHT", playerFrame, "BOTTOMRIGHT", -10, 10)

	local petCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.pet.enabled, playerPetArea,
		function(isChecked)
			mUI.profile.pet.enabled = isChecked
		end)
	petCheck:SetPoint("LEFT", 20, 0)

	local petPortraitCheck = mUI:CreateCheckBox("|cff00ff00Enable|r portrait", mUI.profile.pet.portrait.enabled,
		playerPetArea,
		function(isChecked)
			mUI.profile.pet.portrait.enabled = isChecked
		end)
	petPortraitCheck:SetPoint("LEFT", petCheck, "RIGHT", 80, 0)

	local petWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.pet.width, playerPetArea,
		function(value)
			mUI.profile.pet.width = value
		end)
	petWidthSlider:SetPoint("RIGHT", -20, 0)

	local petHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.pet.height, playerPetArea,
		function(value)
			mUI.profile.pet.height = value
		end)
	petHeightSlider:SetPoint("RIGHT", petWidthSlider, "LEFT", -20, 0)

	targetTab = mUI:CreateButton(100, 20, "Target", unitsFrame, function(self)
		HideUnitFrames()
		targetFrame:Show()
		self.label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	end)
	targetTab:SetPoint("LEFT", playerTab, "RIGHT", 2, 0)

	targetFrame = CreateFrame("Frame", nil, unitsFrame)
	targetFrame:SetAllPoints()
	targetFrame:Hide()

	local targetArea = mUI:CreateArea("", targetFrame)
	targetArea:SetPoint("TOPLEFT", targetFrame, "TOPLEFT", 10, -10)
	targetArea:SetPoint("TOPRIGHT", targetFrame, "TOPRIGHT", -10, -10)
	targetArea:SetHeight(80)

	local targetCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.target.enabled, targetArea,
		function(isChecked)
			mUI.profile.target.enabled = isChecked
		end)
	targetCheck:SetPoint("LEFT", 20, 0)

	local targetPortraitCheck = mUI:CreateCheckBox("|cff00ff00Enable|r portrait", mUI.profile.target.portrait.enabled,
		targetArea,
		function(isChecked)
			mUI.profile.target.portrait.enabled = isChecked
		end)
	targetPortraitCheck:SetPoint("LEFT", targetCheck, "RIGHT", 80, 0)

	local targetWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.target.width, targetArea,
		function(value)
			mUI.profile.target.width = value
		end)
	targetWidthSlider:SetPoint("RIGHT", -20, 0)

	local targetHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.target.height, targetArea,
		function(value)
			mUI.profile.target.height = value
		end)
	targetHeightSlider:SetPoint("RIGHT", targetWidthSlider, "LEFT", -20, 0)

	local targetPowerArea = mUI:CreateArea("Power", targetFrame)
	targetPowerArea:SetPoint("TOPLEFT", targetArea, "BOTTOMLEFT", 0, -10)
	targetPowerArea:SetPoint("TOPRIGHT", targetArea, "BOTTOMRIGHT", 0, -10)
	targetPowerArea:SetHeight(80)

	local targetPowerCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.target.power.enabled,
		targetPowerArea,
		function(isChecked)
			mUI.profile.target.power.enabled = isChecked
		end)
	targetPowerCheck:SetPoint("LEFT", 20, 0)

	local targetPowerDetachCheck = mUI:CreateCheckBox("Detach", mUI.profile.target.power.detach,
		targetPowerArea,
		function(isChecked)
			mUI.profile.target.power.detach = isChecked
		end)
	targetPowerDetachCheck:SetPoint("LEFT", targetPowerCheck, "RIGHT", 80, 0)

	local targetPowerWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.target.power.width, targetPowerArea,
		function(value)
			mUI.profile.target.power.width = value
		end)
	targetPowerWidthSlider:SetPoint("RIGHT", -20, 0)

	local targetPowerHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.target.power.height, targetPowerArea,
		function(value)
			mUI.profile.target.power.height = value
		end)
	targetPowerHeightSlider:SetPoint("RIGHT", targetPowerWidthSlider, "LEFT", -20, 0)

	local targetCastbarArea = mUI:CreateArea("Castbar", targetFrame)
	targetCastbarArea:SetPoint("TOPLEFT", targetPowerArea, "BOTTOMLEFT", 0, -10)
	targetCastbarArea:SetPoint("TOPRIGHT", targetPowerArea, "BOTTOMRIGHT", 0, -10)
	targetCastbarArea:SetHeight(80)

	local targetCastbarCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.target.castbar.enabled,
		targetCastbarArea,
		function(isChecked)
			mUI.profile.target.castbar.enabled = isChecked
		end)
	targetCastbarCheck:SetPoint("LEFT", 20, 0)

	local targetCastbarDetachCheck = mUI:CreateCheckBox("Detach", mUI.profile.target.castbar.detach,
		targetCastbarArea,
		function(isChecked)
			mUI.profile.target.castbar.detach = isChecked
		end)
	targetCastbarDetachCheck:SetPoint("LEFT", targetCastbarCheck, "RIGHT", 80, 0)

	local targetCastbarWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.target.castbar.width,
		targetCastbarArea,
		function(value)
			mUI.profile.target.castbar.width = value
		end)
	targetCastbarWidthSlider:SetPoint("RIGHT", -20, 0)

	local targetCastbarHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.target.castbar.height,
		targetCastbarArea,
		function(value)
			mUI.profile.target.castbar.height = value
		end)
	targetCastbarHeightSlider:SetPoint("RIGHT", targetCastbarWidthSlider, "LEFT", -20, 0)

	local totArea = mUI:CreateArea("Target of target", targetFrame)
	totArea:SetPoint("TOPLEFT", targetCastbarArea, "BOTTOMLEFT", 0, -10)
	totArea:SetPoint("TOPRIGHT", targetCastbarArea, "BOTTOMRIGHT", 0, -10)
	totArea:SetHeight(80)

	local totCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.targettarget.enabled,
		totArea,
		function(isChecked)
			mUI.profile.targettarget.enabled = isChecked
		end)
	totCheck:SetPoint("LEFT", 20, 0)

	local totPortraitCheck = mUI:CreateCheckBox("|cff00ff00Enable|r portrait",
		mUI.profile.targettarget.portrait.enabled,
		totArea,
		function(isChecked)
			mUI.profile.targettarget.portrait.enabled = isChecked
		end)
	totPortraitCheck:SetPoint("LEFT", totCheck, "RIGHT", 80, 0)

	local totWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.targettarget.width, totArea,
		function(value)
			mUI.profile.targettarget.width = value
		end)
	totWidthSlider:SetPoint("RIGHT", -20, 0)

	local totHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.targettarget.height, totArea,
		function(value)
			mUI.profile.targettarget.height = value
		end)
	totHeightSlider:SetPoint("RIGHT", totWidthSlider, "LEFT", -20, 0)

	focusTab = mUI:CreateButton(100, 20, "Focus", unitsFrame, function(self)
		HideUnitFrames()
		focusFrame:Show()
		self.label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	end)
	focusTab:SetPoint("LEFT", targetTab, "RIGHT", 2, 0)

	focusFrame = CreateFrame("Frame", nil, unitsFrame)
	focusFrame:SetAllPoints()
	focusFrame:Hide()

	local focusArea = mUI:CreateArea("", focusFrame)
	focusArea:SetPoint("TOPLEFT", focusFrame, "TOPLEFT", 10, -10)
	focusArea:SetPoint("TOPRIGHT", focusFrame, "TOPRIGHT", -10, -10)
	focusArea:SetHeight(80)

	local focusCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.focus.enabled, focusArea,
		function(isChecked)
			mUI.profile.focus.enabled = isChecked
		end)
	focusCheck:SetPoint("LEFT", 20, 0)

	local focusPortraitCheck = mUI:CreateCheckBox("|cff00ff00Enable|r portrait", mUI.profile.focus.portrait.enabled,
		focusArea,
		function(isChecked)
			mUI.profile.focus.portrait.enabled = isChecked
		end)
	focusPortraitCheck:SetPoint("LEFT", focusCheck, "RIGHT", 80, 0)

	local focusWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.focus.width, focusArea,
		function(value)
			mUI.profile.focus.width = value
		end)
	focusWidthSlider:SetPoint("RIGHT", -20, 0)

	local focusHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.focus.height, focusArea,
		function(value)
			mUI.profile.focus.height = value
		end)
	focusHeightSlider:SetPoint("RIGHT", focusWidthSlider, "LEFT", -20, 0)

	local focusPowerArea = mUI:CreateArea("Power", focusFrame)
	focusPowerArea:SetPoint("TOPLEFT", focusArea, "BOTTOMLEFT", 0, -10)
	focusPowerArea:SetPoint("TOPRIGHT", focusArea, "BOTTOMRIGHT", 0, -10)
	focusPowerArea:SetHeight(80)

	local focusPowerCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.focus.power.enabled,
		focusPowerArea,
		function(isChecked)
			mUI.profile.focus.power.enabled = isChecked
		end)
	focusPowerCheck:SetPoint("LEFT", 20, 0)

	local focusPowerDetachCheck = mUI:CreateCheckBox("Detach", mUI.profile.focus.power.detach,
		focusPowerArea,
		function(isChecked)
			mUI.profile.focus.power.detach = isChecked
		end)
	focusPowerDetachCheck:SetPoint("LEFT", focusPowerCheck, "RIGHT", 80, 0)

	local focusPowerWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.focus.power.width, focusPowerArea,
		function(value)
			mUI.profile.focus.power.width = value
		end)
	focusPowerWidthSlider:SetPoint("RIGHT", -20, 0)

	local focusPowerHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.focus.power.height, focusPowerArea,
		function(value)
			mUI.profile.focus.power.height = value
		end)
	focusPowerHeightSlider:SetPoint("RIGHT", focusPowerWidthSlider, "LEFT", -20, 0)

	local focusCastbarArea = mUI:CreateArea("Castbar", focusFrame)
	focusCastbarArea:SetPoint("TOPLEFT", focusPowerArea, "BOTTOMLEFT", 0, -10)
	focusCastbarArea:SetPoint("TOPRIGHT", focusPowerArea, "BOTTOMRIGHT", 0, -10)
	focusCastbarArea:SetHeight(80)

	local focusCastbarCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.focus.castbar.enabled,
		focusCastbarArea,
		function(isChecked)
			mUI.profile.focus.castbar.enabled = isChecked
		end)
	focusCastbarCheck:SetPoint("LEFT", 20, 0)

	local focusCastbarDetachCheck = mUI:CreateCheckBox("Detach", mUI.profile.focus.castbar.detach,
		focusCastbarArea,
		function(isChecked)
			mUI.profile.focus.castbar.detach = isChecked
		end)
	focusCastbarDetachCheck:SetPoint("LEFT", focusCastbarCheck, "RIGHT", 80, 0)

	local focusCastbarWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.focus.castbar.width,
		focusCastbarArea,
		function(value)
			mUI.profile.focus.castbar.width = value
		end)
	focusCastbarWidthSlider:SetPoint("RIGHT", -20, 0)

	local focusCastbarHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.focus.castbar.height,
		focusCastbarArea,
		function(value)
			mUI.profile.focus.castbar.height = value
		end)
	focusCastbarHeightSlider:SetPoint("RIGHT", focusCastbarWidthSlider, "LEFT", -20, 0)

	partyTab = mUI:CreateButton(100, 20, "Party", unitsFrame, function(self)
		HideUnitFrames()
		partyFrame:Show()
		self.label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	end)
	partyTab:SetPoint("LEFT", focusTab, "RIGHT", 2, 0)

	partyFrame = CreateFrame("Frame", nil, unitsFrame)
	partyFrame:SetAllPoints()
	partyFrame:Hide()

	local partyArea = mUI:CreateArea("", partyFrame)
	partyArea:SetPoint("TOPLEFT", partyFrame, "TOPLEFT", 10, -10)
	partyArea:SetPoint("TOPRIGHT", partyFrame, "TOPRIGHT", -10, -10)
	partyArea:SetHeight(80)

	local partyCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.party.enabled, partyArea,
		function(isChecked)
			mUI.profile.party.enabled = isChecked
		end)
	partyCheck:SetPoint("LEFT", 20, 0)

	local partyPortraitCheck = mUI:CreateCheckBox("|cff00ff00Enable|r portrait", mUI.profile.party.portrait.enabled,
		partyArea,
		function(isChecked)
			mUI.profile.party.portrait.enabled = isChecked
		end)
	partyPortraitCheck:SetPoint("LEFT", partyCheck, "RIGHT", 80, 0)

	local partyWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.party.width, partyArea,
		function(value)
			mUI.profile.party.width = value
		end)
	partyWidthSlider:SetPoint("RIGHT", -20, 0)

	local partyHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.party.height, partyArea,
		function(value)
			mUI.profile.party.height = value
		end)
	partyHeightSlider:SetPoint("RIGHT", partyWidthSlider, "LEFT", -20, 0)

	raidTab = mUI:CreateButton(100, 20, "Raid", unitsFrame, function(self)
		HideUnitFrames()
		raidFrame:Show()
		self.label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	end)
	raidTab:SetPoint("LEFT", partyTab, "RIGHT", 2, 0)

	raidFrame = CreateFrame("Frame", nil, unitsFrame)
	raidFrame:SetAllPoints()
	raidFrame:Hide()

	local raidArea = mUI:CreateArea("", raidFrame)
	raidArea:SetPoint("TOPLEFT", raidFrame, "TOPLEFT", 10, -10)
	raidArea:SetPoint("TOPRIGHT", raidFrame, "TOPRIGHT", -10, -10)
	raidArea:SetHeight(80)

	local raidCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.raid.enabled, raidArea,
		function(isChecked)
			mUI.profile.raid.enabled = isChecked
		end)
	raidCheck:SetPoint("LEFT", 20, 0)

	local raidWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.raid.width, raidArea,
		function(value)
			mUI.profile.raid.width = value
		end)
	raidWidthSlider:SetPoint("RIGHT", -20, 0)

	local raidHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.raid.height, raidArea,
		function(value)
			mUI.profile.raid.height = value
		end)
	raidHeightSlider:SetPoint("RIGHT", raidWidthSlider, "LEFT", -20, 0)

	local raidPowerArea = mUI:CreateArea("Power", raidFrame)
	raidPowerArea:SetPoint("TOPLEFT", raidArea, "BOTTOMLEFT", 0, -10)
	raidPowerArea:SetPoint("TOPRIGHT", raidArea, "BOTTOMRIGHT", 0, -10)
	raidPowerArea:SetHeight(80)

	local raidPowerCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.raid.power.enabled,
		raidPowerArea,
		function(isChecked)
			mUI.profile.raid.power.enabled = isChecked
		end)
	raidPowerCheck:SetPoint("LEFT", 20, 0)

	bossTab = mUI:CreateButton(100, 20, "Boss", unitsFrame, function(self)
		HideUnitFrames()
		bossFrame:Show()
		self.label:SetTextColor(playerColor.r, playerColor.g, playerColor.b, 1)
	end)
	bossTab:SetPoint("LEFT", raidTab, "RIGHT", 2, 0)

	bossFrame = CreateFrame("Frame", nil, unitsFrame)
	bossFrame:SetAllPoints()
	bossFrame:Hide()

	local bossArea = mUI:CreateArea("", bossFrame)
	bossArea:SetPoint("TOPLEFT", bossFrame, "TOPLEFT", 10, -10)
	bossArea:SetPoint("TOPRIGHT", bossFrame, "TOPRIGHT", -10, -10)
	bossArea:SetHeight(80)

	local bossCheck = mUI:CreateCheckBox("|cff00ff00Enable|r", mUI.profile.boss.enabled, bossArea,
		function(isChecked)
			mUI.profile.boss.enabled = isChecked
		end)
	bossCheck:SetPoint("LEFT", 20, 0)

	local bossPortraitCheck = mUI:CreateCheckBox("|cff00ff00Enable|r portrait", mUI.profile.boss.portrait.enabled,
		bossArea,
		function(isChecked)
			mUI.profile.boss.portrait.enabled = isChecked
		end)
	bossPortraitCheck:SetPoint("LEFT", bossCheck, "RIGHT", 80, 0)

	local bossWidthSlider = mUI:CreateSlider(20, 400, 1, "Width", mUI.profile.boss.width, bossArea,
		function(value)
			mUI.profile.boss.width = value
		end)
	bossWidthSlider:SetPoint("RIGHT", -20, 0)

	local bossHeightSlider = mUI:CreateSlider(6, 200, 1, "Height", mUI.profile.boss.height, bossArea,
		function(value)
			mUI.profile.boss.height = value
		end)
	bossHeightSlider:SetPoint("RIGHT", bossWidthSlider, "LEFT", -20, 0)

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
