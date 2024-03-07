local _, mUI = ...
local oUF = mUI.oUF
local LSM = LibStub("LibSharedMedia-3.0")

assert(oUF, "MangoUI was unable to find oUF")
assert(LSM, "MangoUI was unable to find LibShareMedia")

local function SetupFrame(self)
	self:ClearAllPoints()
	self:RegisterForClicks("AnyDown")
	self:SetScript("OnEnter", UnitFrame_OnEnter)
	self:SetScript("OnLeave", UnitFrame_OnLeave)

	local textLayer = CreateFrame("Frame", nil, self)
	textLayer:SetAllPoints()
	textLayer:SetFrameLevel(5)
	self.Texts = textLayer

	local indicatorLayer = CreateFrame("Frame", nil, self)
	indicatorLayer:SetAllPoints()
	indicatorLayer:SetFrameLevel(5)
	self.Indicators = indicatorLayer

	mUI:CreateHealth(self)
	mUI:CreateHealthPrediction(self)
	mUI:CreateUnitName(self)
	mUI:CreateRaidTarget(self)
	mUI:CreatePowerBar(self)
	mUI:CreatePortrait(self)

	self.Range = {
		insideAlpha = 1,
		outsideAlpha = 1 / 4,
	}
end

local function Primary(self, unit)
	SetupFrame(self)

	if unit == "player" then
		PixelUtil.SetSize(self, mUI.profile.player.width, mUI.profile.player.height)
	elseif unit == "target" then
		PixelUtil.SetSize(self, mUI.profile.target.width, mUI.profile.target.height)
	elseif unit == "focus" then
		PixelUtil.SetSize(self, mUI.profile.focus.width, mUI.profile.focus.height)
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

	if unit == "player" then
		mUI:CreateGroupNumber(self)
		mUI:CreateAbsorbsNumber(self)
		mUI:CreateClassPower(self)
		mUI:CreateStaggerBar(self)
		mUI:CreateRunes(self)
		mUI:CreateSecondaryPowerBar(self)
		mUI:CreateTotems(self)
		mUI:CreatePrioBuffs(self)

		if mUI.profile.player.castbar.enabled then
			local GCD = CreateFrame("StatusBar", "MangoGCD", self)
			PixelUtil.SetSize(GCD, self.Castbar:GetWidth(), 2)
			PixelUtil.SetPoint(GCD, "BOTTOMLEFT", self.Castbar, "TOPLEFT", 0, 2)
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
		PixelUtil.SetSize(self, mUI.profile.pet.width, mUI.profile.pet.height)
	else
		PixelUtil.SetSize(self, mUI.profile.targettarget.width, mUI.profile.targettarget.height)
	end
end
oUF:RegisterStyle("MangoSecondary", Secondary)

local function mBoss(self, unit)
	SetupFrame(self)
	PixelUtil.SetSize(self, mUI.profile.boss.width, mUI.profile.boss.height)
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
	mUI:CreatePrioBuffs(self)
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
	mUI:CreatePrioBuffs(self)
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
	if mUI.profile.player.enabled then
		player = self:Spawn("player")
		PixelUtil.SetPoint(
			player,
			mUI.profile.player.anchor,
			UIParent, mUI.profile.player.parentAnchor,
			mUI.profile.player.x,
			mUI.profile.player.y
		)
		mUI:AddMover(player, "Player", function(x, y)
			mUI.profile.player.x = x
			mUI.profile.player.y = y
			mUI.profile.player.anchor = "CENTER"
			mUI.profile.player.parentAnchor = "CENTER"
		end)
	end

	if mUI.profile.target.enabled then
		target = self:Spawn("target")
		PixelUtil.SetPoint(
			target,
			mUI.profile.target.anchor,
			UIParent,
			mUI.profile.target.parentAnchor,
			mUI.profile.target.x,
			mUI.profile.target.y
		)
		mUI:AddMover(target, "Target", function(x, y)
			mUI.profile.target.x = x
			mUI.profile.target.y = y
			mUI.profile.target.anchor = "CENTER"
			mUI.profile.target.parentAnchor = "CENTER"
		end)
	end

	if mUI.profile.focus.enabled then
		focus = self:Spawn("focus")
		PixelUtil.SetPoint(
			focus,
			mUI.profile.focus.anchor,
			UIParent,
			mUI.profile.focus.parentAnchor,
			mUI.profile.focus.x,
			mUI.profile.focus.y
		)
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
		PixelUtil.SetPoint(tot, "TOPLEFT", target or UIParent, "TOPRIGHT", 8, 0)
		mUI:AddMover(tot, "Target of target")
	end

	if mUI.profile.pet.enabled then
		self:SetActiveStyle("MangoSecondary")
		pet = self:Spawn("pet")
		PixelUtil.SetPoint(pet, "TOPRIGHT", player or UIParent, "TOPLEFT", -8, 0)
		mUI:AddMover(pet, "Pet")
	end

	if mUI.profile.boss.enabled then
		self:SetActiveStyle("MangoBoss")
		local boss = {}
		for i = 1, MAX_BOSS_FRAMES or 5 do
			boss[i] = self:Spawn("boss" .. i)

			if i == 1 then
				PixelUtil.SetPoint(boss[i], "BOTTOM", UIParent, "BOTTOM", 550, 400)
				mUI:AddMover(boss[i], "Boss")
			else
				PixelUtil.SetPoint(boss[i], "BOTTOM", boss[i - 1], "TOP", 0, 50)
			end
		end
	end

	if mUI.profile.party.enabled then
		self:SetActiveStyle("MangoParty")
		local party = self:SpawnHeader("MangoParty", nil, "party",
			"showParty", true,
			"showRaid", false,
			"showSolo", false,
			"showPlayer", true,
			"yOffset", -12,
			"groupBy", "ASSIGNEDROLE",
			"groupingOrder", "DAMAGER,HEALER,TANK",
			"oUF-initialConfigFunction", ([[
        	self:SetWidth(%d)
        	self:SetHeight(%d)
      ]]):format(mUI.profile.party.width, mUI.profile.party.height)
		)
		PixelUtil.SetPoint(party, "CENTER", UIParent, "CENTER", mUI.profile.party.x, mUI.profile.party.y)
	end

	if mUI.profile.raid.enabled then
		if CompactRaidFrameManager_SetSetting then
			UIParent:UnregisterEvent("GROUP_ROSTER_UPDATE")
			CompactRaidFrameManager_SetSetting("IsShown", "0")
			CompactRaidFrameManager_SetSetting("IsShown", "0")
			CompactRaidFrameManager:UnregisterAllEvents()
			CompactRaidFrameManager:Hide()
			CompactRaidFrameContainer:UnregisterAllEvents()
			CompactRaidFrameContainer:Hide()
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
				"columnAnchorPoint", "LEFT",
				"columnSpacing", 3,
				"groupBy", "ASSIGNEDROLE",
				"groupingOrder", "DAMAGER,HEALER,TANK",
				"groupFilter", group,
				"oUF-initialConfigFunction", ([[
        	self:SetWidth(%d)
        	self:SetHeight(%d)
      ]]):format(mUI.profile.raid.width, mUI.profile.raid.height)
			)

			if group == 1 then
				PixelUtil.SetPoint(raid[group], "TOPLEFT", UIParent, "TOPLEFT", 15, -15)
			else
				PixelUtil.SetPoint(raid[group], "TOPLEFT", raid[group - 1], "BOTTOMLEFT", 0, -3)
			end
		end
	end
end)
