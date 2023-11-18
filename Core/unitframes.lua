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
		self:SetSize(mUI.db.target.width, mUI.db.target.height)
	elseif unit == "player" then
		self:SetSize(mUI.db.player.width, mUI.db.player.height)
	else
		self:SetSize(mUI.db.focus.width, mUI.db.focus.height)
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
		self:SetSize(mUI.db.pet.width, mUI.db.pet.height)
	else
		self:SetSize(mUI.db.targettarget.width, mUI.db.targettarget.height)
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
	self:SetSize(mUI.profile.party.width, mUI.profile.party.height)

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
	self:SetSize(mUI.profile.raid.width, mUI.profile.raid.height)
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

oUF:Factory(function(self)
	-- Player, Target & Focus frames
	self:SetActiveStyle("MangoPrimary")

	-- Check if unitframe is enabled or not
	local player, target, focus, tot, pet
	if mUI.db.player.enabled then
		player = self:Spawn("player")
		player:SetPoint(mUI.db.player.anchor, UIParent, mUI.db.player.parentAnchor, mUI.db.player.x, mUI.db.player.y)
	end

	if mUI.db.target.enabled then
		target = self:Spawn("target")
		target:SetPoint(mUI.db.target.anchor, UIParent, mUI.db.target.parentAnchor, mUI.db.target.x, mUI.db.target.y)
	end

	if mUI.db.focus.enabled then
		focus = self:Spawn("focus")
		focus:SetPoint(mUI.db.focus.anchor, UIParent, mUI.db.focus.parentAnchor, mUI.db.focus.x, mUI.db.focus.y)
	end

	-- Pet & ToT frames
	self:SetActiveStyle("MangoSecondary")

	if mUI.db.targettarget.enabled then
		tot = self:Spawn("targettarget")
		tot:SetPoint('TOPLEFT', target or UIParent, 'TOPRIGHT', 8, 0)
	end

	if mUI.db.pet.enabled then
		pet = self:Spawn("pet")
		pet:SetPoint('TOPRIGHT', player or UIParent, 'TOPLEFT', -8, 0)
	end

	if mUI.db.boss.enabled then
		-- Boss frames
		self:SetActiveStyle("MangoBoss")
		local boss = {}
		for i = 1, _G.MAX_BOSS_FRAMES do
			boss[i] = self:Spawn('boss' .. i)

			if i == 1 then
				boss[i]:SetPoint('BOTTOM', UIParent, 'BOTTOM', 550, 400)
			else
				boss[i]:SetPoint('BOTTOM', boss[i - 1], 'TOP', 0, 50)
			end
		end
	end

	if mUI.db.party.enabled then
		-- Party frames
		self:SetActiveStyle("MangoParty")
		local party = self:SpawnHeader(nil, nil, 'party',
			'showParty', true,
			'showRaid', false,
			'showPlayer', false,
			'yOffset', -16,
			'groupBy', 'ASSIGNEDROLE',
			'groupingOrder', 'DAMAGER,HEALER,TANK')
		party:SetPoint('BOTTOM', UIParent, 'LEFT', 380, -160)
	end

	if mUI.db.raid.enabled then
		-- Raid frames
		local HiddenFrame = CreateFrame("Frame")
		HiddenFrame:Hide()

		if CompactRaidFrameManager_SetSetting then
			CompactRaidFrameManager_SetSetting("IsShown", "0")
			UIParent:UnregisterEvent("GROUP_ROSTER_UPDATE")
			CompactRaidFrameManager:UnregisterAllEvents()
			CompactRaidFrameManager:SetParent(HiddenFrame)
		end

		self:SetActiveStyle("MangoRaid")
		local raid = {}
		for group = 1, _G.NUM_RAID_GROUPS do
			raid[group] = self:SpawnHeader(
				nil, nil, 'raid',
				'showRaid', true,
				'maxColumns', 5,
				'unitsPerColumn', 1,
				'columnAnchorPoint', 'LEFT',
				'columnSpacing', 5,
				'groupBy', 'ASSIGNEDROLE',
				'groupingOrder', 'DAMAGER,HEALER,TANK',
				'groupFilter', group
			)

			if group == 1 then
				raid[group]:SetPoint('TOPLEFT', UIParent, 'LEFT', 15, -15)
			else
				raid[group]:SetPoint('TOPLEFT', raid[group - 1], 'BOTTOMLEFT', 0, -5)
			end
		end
	end
end)
