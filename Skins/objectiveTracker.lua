local _, mUI = ...
local oUF = mUI.oUF

local _, class = UnitClass("player")
local playerColor = oUF.colors.class[class]

local function styleHeader(header)
	header.Background:Hide()

	local headerUnderline = CreateFrame("Frame", nil, header)
	headerUnderline:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, 0)
	headerUnderline:SetPoint("BOTTOMRIGHT", header, "BOTTOMRIGHT", 0, -2)

	local texture = headerUnderline:CreateTexture(nil, "BACKGROUND")
	texture:SetTexture([[Interface\AddOns\MangoUI\Media\border.tga]])
	texture:SetAllPoints()
	texture:SetVertexColor(playerColor.r, playerColor.g, playerColor.b, 1)
end

local headers = {
	ObjectiveTrackerBlocksFrame.QuestHeader,
	ObjectiveTrackerBlocksFrame.AchievementHeader,
	ObjectiveTrackerBlocksFrame.ScenarioHeader,
	ObjectiveTrackerBlocksFrame.CampaignQuestHeader,
	ObjectiveTrackerBlocksFrame.ProfessionHeader,
	ObjectiveTrackerBlocksFrame.MonthlyActivitiesHeader,
	ObjectiveTrackerBlocksFrame.AdventureHeader,
	BONUS_OBJECTIVE_TRACKER_MODULE.Header,
	WORLD_QUEST_TRACKER_MODULE.Header,
	ObjectiveTrackerFrame.BlocksFrame.UIWidgetsHeader,
}

local function styleScenarioBlock()
	ScenarioStageBlock.NormalBG:SetAlpha(0)
	ScenarioStageBlock.FinalBG:SetAlpha(0)
	Mixin(ScenarioStageBlock, BackdropTemplateMixin)
	ScenarioStageBlock:SetBackdrop({
		bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		--edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
		edgeSize = 2,
		insets = { left = 4, right = 4, top = 4, bottom = 4 }
	})
	ScenarioStageBlock:SetBackdropColor(0.07, 0.07, 0.07, 0.8)
	--ScenarioStageBlock:SetBackdropBorderColor(0, 0, 0, 1)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
	for _, h in pairs(headers) do
		styleHeader(h)
	end
	styleScenarioBlock()
end)
