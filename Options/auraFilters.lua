local _, mUI = ...

local function removeSpellId(db, spellId)
	db[spellId] = nil
end

local function addSpellId(db, spellId)
	db[spellId] = true
end

local function createScrollBox(parentFrame, title, db)
	local ScrollBox = CreateFrame("Frame", nil, parentFrame, "WowScrollBoxList")
	ScrollBox:SetSize(320, 160)

	local Header = parentFrame:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
	Header:SetPoint("BOTTOMLEFT", ScrollBox, "TOPLEFT", 8, 8)
	Header:SetText(title)

	local ScrollBar = CreateFrame("EventFrame", nil, parentFrame, "MinimalScrollBar")
	ScrollBar:SetPoint("TOPLEFT", ScrollBox, "TOPRIGHT", 8, 0)
	ScrollBar:SetPoint("BOTTOMLEFT", ScrollBox, "BOTTOMRIGHT", 8, 0)

	local DataProvider = CreateDataProvider()
	local ScrollView = CreateScrollBoxListLinearView()
	ScrollView:SetDataProvider(DataProvider)

	ScrollUtil.InitScrollBoxListWithScrollBar(ScrollBox, ScrollBar, ScrollView)

	local function Initializer(button, data)
		local spellName = C_Spell.GetSpellName(data.spellId) or "Unknown"
		button:SetText(spellName .. ": " .. tostring(data.spellId))
		button:SetScript("OnClick", function()
			DataProvider:Remove(data)
			removeSpellId(data.db, data.spellId)
		end)
	end

	ScrollView:SetElementInitializer("UIPanelButtonTemplate", Initializer)

	for spellId, _ in pairs(db) do
		DataProvider:Insert({ db = db, spellId = spellId })
	end

	local addButton = CreateFrame("Button", nil, parentFrame, "UIPanelButtonTemplate")
	addButton:SetSize(100, 30)
	addButton:SetText("Add Spell ID")
	addButton:SetPoint("BOTTOMRIGHT", ScrollBox, "TOPRIGHT", 0, 8)
	addButton:SetScript("OnClick", function()
		StaticPopup_Show("ADD_SPELL_ID", nil, nil, { db = db, callback = addSpellId, dataProvider = DataProvider })
	end)

	return ScrollBox, DataProvider
end

StaticPopupDialogs["ADD_SPELL_ID"] = {
	text = "Enter the Spell ID to add:",
	button1 = "Add",
	button2 = "Cancel",
	hasEditBox = true,
	OnAccept = function(self, data)
		local spellId = tonumber(self.editBox:GetText())
		if spellId then
			data.callback(data.db, spellId)
			data.dataProvider:Insert({ spellId = spellId })
		else
			print("Invalid Spell ID. Please enter a number.") -- TODO: Show error message
		end
	end,
	OnShow = function(self)
		self.editBox:SetFocus()
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3,
}

function mUI:createAuraFilterSettings()
	local frame = CreateFrame("Frame")
	local aurasCategory, aurasLayout = Settings.RegisterCanvasLayoutSubcategory(mUI.category, frame, "Aura Filters")

	local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", 0, -16)
	scrollFrame:SetPoint("BOTTOMRIGHT", -32, 16)

	local scrollChild = CreateFrame("Frame")
	scrollFrame:SetScrollChild(scrollChild)
	scrollChild:SetWidth(frame:GetWidth() - 40)
	scrollChild:SetHeight(10000)

	-- Player buffs include
	local playerBuffsInclude, pBuffsDataProvider = createScrollBox(scrollChild, "Player Buffs |cff00ff00(include)|r",
		mUI.profile.player.buffs.include)
	playerBuffsInclude:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 60, -80)

	-- Player buffs exclude
	local playerBuffsExclude, pBuffsExcludeDataProvider = createScrollBox(scrollChild, "Player Buffs |cffff0000(exclude)|r",
		mUI.profile.player.buffs.exclude)
	playerBuffsExclude:SetPoint("TOPLEFT", playerBuffsInclude, "BOTTOMLEFT", 0, -80)

	-- Player debuffs include
	local playerDebuffsInclude, pDebuffsDataProvider = createScrollBox(scrollChild, "Player Debuffs |cff00ff00(include)|r",
		mUI.profile.player.debuffs.include)
	playerDebuffsInclude:SetPoint("TOPLEFT", playerBuffsExclude, "BOTTOMLEFT", 0, -80)

	-- Player debuffs exclude
	local playerDebuffsExclude, pDebuffsExcludeDataProvider = createScrollBox(scrollChild,
		"Player Debuffs |cffff0000(exclude)|r",
		mUI.profile.player.debuffs.exclude)
	playerDebuffsExclude:SetPoint("TOPLEFT", playerDebuffsInclude, "BOTTOMLEFT", 0, -80)

	-- Target buffs include
	local targetBuffsInclude, tBuffsDataProvider = createScrollBox(scrollChild, "Target Buffs |cff00ff00(include)|r",
		mUI.profile.target.buffs.include)
	targetBuffsInclude:SetPoint("TOPLEFT", playerDebuffsExclude, "BOTTOMLEFT", 0, -80)

	-- Target buffs exclude
	local targetBuffsExclude, tBuffsExcludeDataProvider = createScrollBox(scrollChild, "Target Buffs |cffff0000(exclude)|r",
		mUI.profile.target.buffs.exclude)
	targetBuffsExclude:SetPoint("TOPLEFT", targetBuffsInclude, "BOTTOMLEFT", 0, -80)

	-- Target Debuffs include
	local targetDebuffsInclude, tDebuffsDataProvider = createScrollBox(scrollChild, "Target Debuffs |cff00ff00(include)|r",
		mUI.profile.target.debuffs.include)
	targetDebuffsInclude:SetPoint("TOPLEFT", targetBuffsExclude, "BOTTOMLEFT", 0, -80)

	-- Target Debuffs exclude
	local targetDebuffsExclude, tDebuffsExcludeDataProvider = createScrollBox(scrollChild,
		"Target Debuffs |cffff0000(exclude)|r",
		mUI.profile.target.debuffs.exclude)
	targetDebuffsExclude:SetPoint("TOPLEFT", targetDebuffsInclude, "BOTTOMLEFT", 0, -80)

	-- Party buffs include
	local partyBuffsInclude, pBuffsDataProvider = createScrollBox(scrollChild, "Party Buffs |cff00ff00(include)|r",
		mUI.profile.party.buffs.include)
	partyBuffsInclude:SetPoint("TOPLEFT", targetDebuffsExclude, "BOTTOMLEFT", 0, -80)

	-- Party buffs exclude
	local partyBuffsExclude, pBuffsExcludeDataProvider = createScrollBox(scrollChild, "Party Buffs |cffff0000(exclude)|r",
		mUI.profile.party.buffs.exclude)
	partyBuffsExclude:SetPoint("TOPLEFT", partyBuffsInclude, "BOTTOMLEFT", 0, -80)

	-- Party Debuffs include
	local partyDebuffsInclude, pDebuffsDataProvider = createScrollBox(scrollChild, "Party Debuffs |cff00ff00(include)|r",
		mUI.profile.party.debuffs.include)
	partyDebuffsInclude:SetPoint("TOPLEFT", partyBuffsExclude, "BOTTOMLEFT", 0, -80)

	-- Party Debuffs exclude
	local partyDebuffsExclude, pDebuffsExcludeDataProvider = createScrollBox(scrollChild,
		"Party Debuffs |cffff0000(exclude)|r",
		mUI.profile.party.debuffs.exclude)
	partyDebuffsExclude:SetPoint("TOPLEFT", partyDebuffsInclude, "BOTTOMLEFT", 0, -80)

	-- Raid buffs include
	local raidBuffsInclude, rBuffsDataProvider = createScrollBox(scrollChild, "Raid Buffs |cff00ff00(include)|r",
		mUI.profile.raid.buffs.include)
	raidBuffsInclude:SetPoint("TOPLEFT", partyDebuffsExclude, "BOTTOMLEFT", 0, -80)

	-- Raid buffs exclude
	local raidBuffsExclude, rBuffsExcludeDataProvider = createScrollBox(scrollChild, "Raid Buffs |cffff0000(exclude)|r",
		mUI.profile.raid.buffs.exclude)
	raidBuffsExclude:SetPoint("TOPLEFT", raidBuffsInclude, "BOTTOMLEFT", 0, -80)

	-- Raid Debuffs include
	local raidDebuffsInclude, rDebuffsDataProvider = createScrollBox(scrollChild, "Raid Debuffs |cff00ff00(include)|r",
		mUI.profile.raid.debuffs.include)
	raidDebuffsInclude:SetPoint("TOPLEFT", raidBuffsExclude, "BOTTOMLEFT", 0, -80)

	-- Raid Debuffs exclude
	local raidDebuffsExclude, rDebuffsExcludeDataProvider = createScrollBox(scrollChild,
		"Raid Debuffs |cffff0000(exclude)|r",
		mUI.profile.raid.debuffs.exclude)
	raidDebuffsExclude:SetPoint("TOPLEFT", raidDebuffsInclude, "BOTTOMLEFT", 0, -80)

	-- Focus buffs include
	local focusBuffsInclude, fBuffsDataProvider = createScrollBox(scrollChild, "Focus Buffs |cff00ff00(include)|r",
		mUI.profile.focus.buffs.include)
	focusBuffsInclude:SetPoint("TOPLEFT", raidDebuffsExclude, "BOTTOMLEFT", 0, -80)

	-- Focus buffs exclude
	local focusBuffsExclude, fBuffsExcludeDataProvider = createScrollBox(scrollChild, "Focus Buffs |cffff0000(exclude)|r",
		mUI.profile.focus.buffs.exclude)
	focusBuffsExclude:SetPoint("TOPLEFT", focusBuffsInclude, "BOTTOMLEFT", 0, -80)

	-- Focus Debuffs include
	local focusDebuffsInclude, fDebuffsDataProvider = createScrollBox(scrollChild, "Focus Debuffs |cff00ff00(include)|r",
		mUI.profile.focus.debuffs.include)
	focusDebuffsInclude:SetPoint("TOPLEFT", focusBuffsExclude, "BOTTOMLEFT", 0, -80)

	-- Focus Debuffs exclude
	local focusDebuffsExclude, fDebuffsExcludeDataProvider = createScrollBox(scrollChild,
		"Focus Debuffs |cffff0000(exclude)|r",
		mUI.profile.focus.debuffs.exclude)
	focusDebuffsExclude:SetPoint("TOPLEFT", focusDebuffsInclude, "BOTTOMLEFT", 0, -80)

	-- Group Prio buffs
	local groupPrioBuffsInclude, groupPrioBuffsDataProvider = createScrollBox(scrollChild,
		"Group Prio Buffs |cff00ff00(include)|r",
		mUI.profile.prio.include)
	groupPrioBuffsInclude:SetPoint("TOPLEFT", focusDebuffsExclude, "BOTTOMLEFT", 0, -80)

	-- Group Prio Buffs exclude
	local groupPrioBuffsExclude, groupPrioBuffsExcludeDataProvider = createScrollBox(scrollChild,
		"Group Prio Buffs |cffff0000(exclude)|r",
		mUI.profile.prio.exclude)
	groupPrioBuffsExclude:SetPoint("TOPLEFT", groupPrioBuffsInclude, "BOTTOMLEFT", 0, -80)
end
