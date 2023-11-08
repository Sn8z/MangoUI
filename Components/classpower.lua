local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

local GetUnitChargedPowerPoints = GetUnitChargedPowerPoints

local ClassPowerBg = {}
local ClassPowerBgFrame

local function PostVisibility(element, isVisible)
	if isVisible then
		ClassPowerBgFrame:Show()
	else
		ClassPowerBgFrame:Hide()
	end
end

local function UpdateColor(element, powerType)
	local color = element.__owner.colors.power[powerType] or { 0, 0, 0 }
	local r, g, b = color[1], color[2], color[3]
	for i = 1, #element do
		element[i]:SetStatusBarColor(r, g, b)
		if ClassPowerBg[i] then
			ClassPowerBg[i]:SetColorTexture(0.15, 0.15, 0.15, 1)
		end
	end
end

local function ClearBackground()
	for i = 1, #ClassPowerBg do
		ClassPowerBg[i]:SetTexture(nil)
		ClassPowerBg[i].border:SetTexture(nil)
	end
end

local function PostUpdateClassPower(element, cur, max, hasMaxChanged, powerType, ccp1, ccp2, ccp3)
	UpdateColor(element, powerType)

	if (hasMaxChanged) then
		ClearBackground()
		local spacing = mUI.db.player.classpower.spacing
		for index = 1, max do
			local Bar = element[index]
			local totalSpacing = (max - 1) * spacing

			if mUI.db.player.classpower.detach then
				Bar:SetWidth((mUI.db.player.classpower.width - totalSpacing) / max)
			else
				Bar:SetWidth((element.__owner:GetWidth() - totalSpacing) / max)
			end

			if (index > 1) then
				Bar:ClearAllPoints()
				Bar:SetPoint('LEFT', element[index - 1], 'RIGHT', spacing, 0)
			end

			local bg = ClassPowerBgFrame:CreateTexture('ClassPowerBG_' .. index, 'BACKGROUND')
			bg:SetAllPoints(Bar)
			bg:SetColorTexture(0.15, 0.15, 0.15, 1)

			local border = ClassPowerBgFrame:CreateTexture('ClassPowerBorder_' .. index, 'BACKGROUND')
			border:SetPoint("TOPLEFT", Bar, "TOPLEFT", -mUI.profile.settings.borderSize, mUI.profile.settings.borderSize)
			border:SetPoint("BOTTOMRIGHT", Bar, "BOTTOMRIGHT", mUI.profile.settings.borderSize,
				-mUI.profile.settings.borderSize)
			border:SetColorTexture(0, 0, 0, 1)
			bg.border = border
			ClassPowerBg[index] = bg
		end
	end

	-- Charged Combo Points
	if ccp1 then
		element[ccp1]:SetStatusBarColor(0.5, 0.5, 1, 1)
		ClassPowerBg[ccp1]:SetColorTexture(0.6, 0.6, 1, 0.45)
	end

	if ccp2 then
		element[ccp2]:SetStatusBarColor(0.5, 0.5, 1, 1)
		ClassPowerBg[ccp2]:SetColorTexture(0.6, 0.6, 1, 0.45)
	end

	if ccp3 then
		element[ccp3]:SetStatusBarColor(0.5, 0.5, 1, 1)
		ClassPowerBg[ccp3]:SetColorTexture(0.6, 0.6, 1, 0.45)
	end
end

function mUI:CreateClassPower(self)
	local settings = mUI.profile['player']
	if settings == nil then return end
	if settings.classpower.enabled == false then return end

	ClassPowerBgFrame = CreateFrame('Frame', 'ClassPowerBackground', self)
	local ClassPower = {}

	for index = 1, 10 do
		local Bar = CreateFrame('StatusBar', 'ClassPower_' .. index, self)
		Bar:SetHeight(mUI.db.player.classpower.height)
		if mUI.db.player.classpower.detach then
			Bar:SetPoint('LEFT', UIParent, 'CENTER', mUI.db.player.classpower.x, mUI.db.player.classpower.y)
		else
			Bar:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', (index - 1) * (Bar:GetWidth() + mUI.db.player.classpower.spacing),
				mUI.db.player.classpower.spacing)
		end
		Bar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
		Bar:SetMinMaxValues(0, 1)
		ClassPower[index] = Bar
	end
	ClassPower.UpdateColor = UpdateColor
	ClassPower.PostUpdate = PostUpdateClassPower
	ClassPower.PostVisibility = PostVisibility

	self.ClassPower = ClassPower
end
