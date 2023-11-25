local _, mUI = ...
local oUF = mUI.oUF
local LSM = LibStub('LibSharedMedia-3.0')

assert(oUF, 'MangoUI was unable to find oUF')
assert(LSM, 'MangoUI was unable to find LibShareMedia')

local function SetupFrame(self)
	self:ClearAllPoints()
	self:RegisterForClicks('AnyDown')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)

	mUI:CreateHealth(self)
	mUI:CreateHealthPrediction(self)
	mUI:CreateUnitName(self)
	mUI:CreateRaidTarget(self)
	mUI:CreateBorder(self, true)
	mUI:CreatePowerBar(self)
	mUI:CreatePortrait(self)

	if mUI.profile.settings.mangoColors then
		self.colors = mUI:GetMangoColors()
	end

	self.Range = {
		insideAlpha = 1,
		outsideAlpha = 1 / 4,
	}
end

local function Primary(self, unit)
	SetupFrame(self)

	if unit == "target" then
		self:SetSize(mUI.profile.target.width, mUI.profile.target.height)
	elseif unit == "player" then
		self:SetSize(mUI.profile.player.width, mUI.profile.player.height)
	else
		self:SetSize(mUI.profile.focus.width, mUI.profile.focus.height)
	end

	mUI:CreateCastbar(self)
	mUI:CreateLeaderIndicator(self)
	mUI:CreateThreatGlow(self)
	mUI:CreateCombatIndicator(self)
	mUI:CreateReadyCheck(self)
	mUI:CreateResurrectionIndicator(self)
	mUI:CreateSummonIndicator(self)
	mUI:CreateHealthValue(self)
	mUI:CreateAltPowerBar(self)

	mUI:CreateBuffs(self)
	mUI:CreateDebuffs(self)

	if unit == 'player' then
		mUI:CreateGroupNumber(self)
		mUI:CreateAbsorbsNumber(self)
		mUI:CreateClassPower(self)
		mUI:CreateStaggerBar(self)
		mUI:CreateRunes(self)
		mUI:CreateSecondaryPowerBar(self)
		mUI:CreateTotems(self)

		if mUI.profile.player.castbar.enabled then -- change db setting
			local GCD = CreateFrame("StatusBar", nil, self)
			GCD:SetSize(self.Castbar:GetWidth(), 2)
			GCD:SetPoint("BOTTOMLEFT", self.Castbar, "TOPLEFT", 0, 2)
			GCD:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.castbarTexture))
			local gBackground = GCD:CreateTexture(nil, "BACKGROUND")
			gBackground:SetAllPoints(GCD)
			gBackground:SetColorTexture(0.15, 0.15, 0.15, 1)
			GCD.bg = gBackground
			mUI:CreateBorder(GCD)
			self.GCD = GCD
		end

		self.DispelHighlight = true
	end
end
oUF:RegisterStyle("MangoPrimary", Primary)

local function Secondary(self, unit)
	SetupFrame(self)
	mUI:CreateCastbar(self)
	if unit == "pet" then
		self:SetSize(mUI.profile.pet.width, mUI.profile.pet.height)
	else
		self:SetSize(mUI.profile.targettarget.width, mUI.profile.targettarget.height)
	end
end
oUF:RegisterStyle("MangoSecondary", Secondary)

local function mBoss(self, unit)
	SetupFrame(self)
	self:SetSize(mUI.profile.boss.width, mUI.profile.boss.height)
	mUI:CreateBuffs(self)
	mUI:CreateDebuffs(self)
	mUI:CreateCastbar(self)
	mUI:CreateHealthValue(self)
end
oUF:RegisterStyle("MangoBoss", mBoss)

local function mParty(self, unit)
	SetupFrame(self)
	mUI:CreateRoleIndicator(self)
	mUI:CreateThreatGlow(self)
	mUI:CreateLeaderIndicator(self)
	mUI:CreateReadyCheck(self)
	mUI:CreateResurrectionIndicator(self)
	mUI:CreateSummonIndicator(self)
	mUI:CreateBuffs(self)
	mUI:CreateDebuffs(self)
	mUI:CreateStatusText(self)
	self.DispelHighlight = true
end
oUF:RegisterStyle("MangoParty", mParty)

local function mRaid(self, unit)
	SetupFrame(self)
	mUI:CreateRoleIndicator(self)
	mUI:CreateLeaderIndicator(self)
	mUI:CreateReadyCheck(self)
	mUI:CreateResurrectionIndicator(self)
	mUI:CreateSummonIndicator(self)
	mUI:CreateBuffs(self)
	mUI:CreateDebuffs(self)
	mUI:CreateStatusText(self, 14)
	self.DispelHighlight = true
end
oUF:RegisterStyle("MangoRaid", mRaid)

local function mFavourites(self, unit)
	SetupFrame(self)
	mUI:CreateReadyCheck(self)
	mUI:CreateResurrectionIndicator(self)
	mUI:CreateBuffs(self)
	mUI:CreateDebuffs(self)
	mUI:CreateStatusText(self, 14)
	self.DispelHighlight = true
end
oUF:RegisterStyle("MangoFavourites", mFavourites)

oUF:Factory(function(self)
	-- Player, Target & Focus frames
	self:SetActiveStyle("MangoPrimary")

	-- Check if unitframe is enabled or not
	local player, target, focus, tot, pet
	if mUI.profile.player.enabled then
		player = self:Spawn("player")
		player:SetPoint(mUI.profile.player.anchor, UIParent, mUI.profile.player.parentAnchor, mUI.profile.player.x, mUI.profile.player.y)
		mUI:AddMover(player, "Player", function(x, y)
			mUI.profile.player.x = x
			mUI.profile.player.y = y
			mUI.profile.player.anchor = "CENTER"
			mUI.profile.player.parentAnchor = "CENTER"
		end)
	end

	if mUI.profile.target.enabled then
		target = self:Spawn("target")
		target:SetPoint(mUI.profile.target.anchor, UIParent, mUI.profile.target.parentAnchor, mUI.profile.target.x, mUI.profile.target.y)
		mUI:AddMover(target, "Target", function(x, y)
			mUI.profile.target.x = x
			mUI.profile.target.y = y
			mUI.profile.target.anchor = "CENTER"
			mUI.profile.target.parentAnchor = "CENTER"
		end)
	end

	if mUI.profile.focus.enabled then
		focus = self:Spawn("focus")
		focus:SetPoint(mUI.profile.focus.anchor, UIParent, mUI.profile.focus.parentAnchor, mUI.profile.focus.x, mUI.profile.focus.y)
		mUI:AddMover(focus, "Focus", function(x, y)
			mUI.profile.focus.x = x
			mUI.profile.focus.y = y
			mUI.profile.focus.anchor = "CENTER"
			mUI.profile.focus.parentAnchor = "CENTER"
		end)
	end

	-- Pet & ToT frames
	if mUI.profile.targettarget.enabled then
		self:SetActiveStyle("MangoSecondary")
		tot = self:Spawn("targettarget")
		tot:SetPoint('TOPLEFT', target or UIParent, 'TOPRIGHT', 8, 0)
		mUI:AddMover(tot, "Target of target")
	end

	if mUI.profile.pet.enabled then
		self:SetActiveStyle("MangoSecondary")
		pet = self:Spawn("pet")
		pet:SetPoint('TOPRIGHT', player or UIParent, 'TOPLEFT', -8, 0)
		mUI:AddMover(pet, "Pet")
	end

	if mUI.profile.boss.enabled then
		self:SetActiveStyle("MangoBoss")
		local boss = {}
		for i = 1, MAX_BOSS_FRAMES or 5 do
			boss[i] = self:Spawn('boss' .. i)

			if i == 1 then
				boss[i]:SetPoint('BOTTOM', UIParent, 'BOTTOM', 550, 400)
			else
				boss[i]:SetPoint('BOTTOM', boss[i - 1], 'TOP', 0, 50)
			end
			mUI:AddMover(boss[i], "Boss" .. i)
		end
	end

	if mUI.profile.party.enabled then
		self:SetActiveStyle("MangoParty")
		local party = self:SpawnHeader("MangoParty", nil, 'party',
			'showParty', true,
			'showRaid', false,
			'showSolo', false,
			'showPlayer', true,
			'yOffset', -16,
			'groupBy', 'ASSIGNEDROLE',
			'groupingOrder', 'DAMAGER,HEALER,TANK',
			"oUF-initialConfigFunction", ([[
        	self:SetWidth(%d)
        	self:SetHeight(%d)
      ]]):format(mUI.profile.party.width, mUI.profile.party.height)
		)
		party:SetPoint('BOTTOM', UIParent, 'LEFT', 380, -160)
	end

	if mUI.profile.favourites.enabled then
		self:SetActiveStyle("MangoFavourites")
		local favourites = self:SpawnHeader("MangoFavourites", nil, "solo,party,raid",
			"showRaid", true,
			"showParty", true,
			"showSolo", true,
			"showPlayer", true,
			"columnAnchorPoint", "BOTTOM",
			"columnSpacing", 5,
			"point", "TOP",
			"columnAnchorPoint", "TOP",
			"groupingOrder", "1,2,3,4,5,6,7,8",
			"groupBy", "GROUP",
			"sortMethod", "GROUP",
			"maxColumns", 8,
			"unitsPerColumn", 5,
			"columnSpacing", 4,
			"xOffset", 10,
			"yOffset", -20,
			"nameList", table.concat(mUI.profile.favourites.units, ","),
			"oUF-initialConfigFunction", ([[
        	self:SetWidth(%d)
        	self:SetHeight(%d)
      ]]):format(100, 80)
		)
		favourites:SetPoint("CENTER", UIParent, "CENTER", 200, 60)

		local function updateFavourites()
			local favs = table.concat(mUI.profile.favourites.units, ",")
			favourites:SetAttribute("nameList", favs)
			print("FAVS: " .. favs)
		end

		local function addFavourite()
			if (UnitExists("target") and (UnitInParty("target") or UnitInRaid("target"))) or UnitIsUnit("player", "target") then
				table.insert(mUI.profile.favourites.units, GetUnitName("target", true))
				updateFavourites()
			else
				if UIErrorsFrame then
					UIErrorsFrame:AddExternalErrorMessage("Can't add that unit")
				else
					print("Can't add that unit")
				end
			end
		end

		local resetBtn = CreateFrame("Button", "MangoFavouriteResetButton", favourites, "UIPanelButtonTemplate")
		resetBtn:SetSize(80, 22)
		resetBtn:SetText("Reset")
		resetBtn:SetPoint("TOP", UIParent, "TOP", 0, -5)
		resetBtn:SetScript("OnClick", function()
			table.wipe(mUI.profile.favourites.units)
			updateFavourites()
		end)

		local addTargetBtn = CreateFrame("Button", "MangoFavouriteAddButton", favourites, "UIPanelButtonTemplate")
		addTargetBtn:SetSize(160, 22)
		addTargetBtn:SetText("Track current target")
		addTargetBtn:SetPoint("LEFT", resetBtn, "RIGHT", 5, 0)
		addTargetBtn:SetScript("OnClick", addFavourite)

		SLASH_MANGOFAV1 = "/mfav"
		SlashCmdList["MANGOFAV"] = addFavourite
	end

	if mUI.profile.raid.enabled then
		local HiddenFrame = CreateFrame("Frame")
		HiddenFrame:Hide()

		if CompactRaidFrameManager_SetSetting then
			CompactRaidFrameManager_SetSetting("IsShown", "0")
			CompactRaidFrameManager:UnregisterAllEvents()
			CompactRaidFrameManager:SetParent(HiddenFrame)
			CompactRaidFrameContainer:UnregisterAllEvents()
			CompactRaidFrameContainer:SetParent(HiddenFrame)
		end

		self:SetActiveStyle("MangoRaid")
		local raid = {}
		for group = 1, NUM_RAID_GROUPS or 8 do
			raid[group] = self:SpawnHeader(
				"MangoRaid" .. group, nil, "raid",
				"showRaid", true,
				"showParty", false,
				"showSolo", false,
				"showPlayer", true,
				"maxColumns", 5,
				"unitsPerColumn", 1,
				"columnAnchorPoint", 'LEFT',
				"columnSpacing", 5,
				"groupBy", "ASSIGNEDROLE",
				"groupingOrder", "DAMAGER,HEALER,TANK",
				"groupFilter", group,
				"oUF-initialConfigFunction", ([[
        	self:SetWidth(%d)
        	self:SetHeight(%d)
      ]]):format(mUI.profile.raid.width, mUI.profile.raid.height)
			)

			if group == 1 then
				raid[group]:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 15, -15)
			else
				raid[group]:SetPoint("TOPLEFT", raid[group - 1], "BOTTOMLEFT", 0, -5)
			end
		end
	end
end)
