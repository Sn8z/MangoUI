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
	local color = element.__owner.colors.power[powerType] or {0, 0, 0}
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

local function PostUpdateClassPower(element, cur, max, hasMaxChanged, powerType, chargedPoints)
	UpdateColor(element, powerType)

	if (hasMaxChanged) then
		ClearBackground()
		local spacing = 5
		for index = 1, max do
			local Bar = element[index]
			local totalSpacing = (max - 1) * spacing

			if true then
				Bar:SetWidth((380 - totalSpacing) / max)
			else 
				Bar:SetWidth((element.__owner:GetWidth() - totalSpacing) / max)
			end

			if (index > 1) then
				Bar:ClearAllPoints()
				Bar:SetPoint('LEFT', element[index - 1], 'RIGHT', spacing, 0)
			end

			local bg = ClassPowerBgFrame:CreateTexture('ClassPowerBG_'..index, 'BACKGROUND')
			bg:SetAllPoints(Bar)
			bg:SetColorTexture(0.15, 0.15, 0.15, 1)

			local border = ClassPowerBgFrame:CreateTexture('ClassPowerBorder_'..index, 'BACKGROUND')
			border:SetPoint("TOPLEFT", Bar, "TOPLEFT", -2, 2)
			border:SetPoint("BOTTOMRIGHT", Bar, "BOTTOMRIGHT", 2, -2)
			border:SetColorTexture(0, 0, 0, 1)
			bg.border = border
			ClassPowerBg[index] = bg
		end
	end

	if chargedPoints then
		chargedPoints = GetUnitChargedPowerPoints('player') -- Look into this...
		for i = 1, #chargedPoints do
			element[chargedPoints[i]]:SetStatusBarColor(0.5, 0.5, 1, 1)
			ClassPowerBg[chargedPoints[i]]:SetColorTexture(0.5, 0.5, 1, 0.4)
		end
	end
end

function mUI:CreateClassPower(self)
	ClassPowerBgFrame = CreateFrame('Frame', 'ClassPowerBackground', self)
	local ClassPower = {}

	for index = 1, 10 do
		local Bar = CreateFrame('StatusBar', 'ClassPower_'..index, self)
		Bar:SetHeight(6)
		if true then
			Bar:SetPoint('LEFT', UIParent, 'CENTER', -190, -158)
		else
			Bar:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', (index - 1) * (Bar:GetWidth() + 5), 5)
		end
		Bar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.config.defaultTexture))
		Bar:GetStatusBarTexture():SetHorizTile(false)
		Bar:SetMinMaxValues(0, 1)
		ClassPower[index] = Bar
	end
	ClassPower.UpdateColor = UpdateColor
	ClassPower.PostUpdate = PostUpdateClassPower
	ClassPower.PostVisibility = PostVisibility

	self.ClassPower = ClassPower
end