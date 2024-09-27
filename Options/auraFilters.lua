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
	local pBuffs, pBuffsDataProvider = createScrollBox(scrollChild, "Player Buffs |cff00ff00(include)|r",
		mUI.profile.player.buffs.include)
	pBuffs:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 60, -80)

	-- Player buffs exclude
	local pBuffsExclude, pBuffsExcludeDataProvider = createScrollBox(scrollChild, "Player Buffs |cffff0000(exclude)|r",
		mUI.profile.player.buffs.exclude)
	pBuffsExclude:SetPoint("TOPLEFT", pBuffs, "BOTTOMLEFT", 0, -80)

	-- Player debuffs include
	-- Player debuffs exclude

	-- Target buffs include
	-- Target buffs exclude

	-- Target Debuffs include
	-- Target Debuffs exclude

	-- Group buffs include
	-- Group buffs exclude

	-- Group Debuffs include
	-- Group Debuffs exclude

	-- Group Prio buffs

	-- Focus buffs include
	-- Focus buffs exclude

	-- Focus Debuffs include
	-- Focus Debuffs exclude
end
