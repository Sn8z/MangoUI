local _, mUI = ...
local oUF = mUI.oUF
local LSM = LibStub("LibSharedMedia-3.0")

local function PostUpdate(element, cur, max, hasMaxChanged, powerType, ccp1, ccp2, ccp3)
	local color = oUF.colors.power[powerType] or { 0, 0, 0 }
	local r, g, b = color[1], color[2], color[3]
	for i = 1, #element do
		element[i]:SetStatusBarColor(r, g, b)
		element.Backgrounds[i]:SetBackdropColor(0.15, 0.15, 0.15, 1)
	end

	if (hasMaxChanged) then
		local spacing = mUI.db.player.classpower.spacing
		for i = 1, max do
			local Bar = element[i]
			local totalSpacing = (max - 1) * spacing

			if mUI.db.player.classpower.detach then
				Bar:SetWidth((mUI.db.player.classpower.width - totalSpacing) / max)
			else
				Bar:SetWidth((element.__owner:GetWidth() - totalSpacing) / max)
			end

			if (i > 1) then
				Bar:ClearAllPoints()
				Bar:SetPoint('LEFT', element[i - 1], 'RIGHT', spacing, 0)
			end
			element.Backgrounds[i]:Show()
		end

		for i = max + 1, #element.Backgrounds do
			element.Backgrounds[i]:Hide()
		end
	end

	-- TODO: add settings
	if max and max > 5 then
		element[max - 1]:SetStatusBarColor(1, 0.5, 0, 1)
		element[max]:SetStatusBarColor(1, 0, 0, 1)
	end

	-- Charged Combo Points
	if ccp1 then
		element[ccp1]:SetStatusBarColor(0, 0.5, 1, 1)
		element.Backgrounds[ccp1]:SetBackdropColor(0, 0.2, 0.3, 1)
	end

	if ccp2 then
		element[ccp2]:SetStatusBarColor(0, 0.5, 1, 1)
		element.Backgrounds[ccp2]:SetBackdropColor(0, 0.2, 0.3, 1)
	end

	if ccp3 then
		element[ccp3]:SetStatusBarColor(0, 0.5, 1, 1)
		element.Backgrounds[ccp3]:SetBackdropColor(0, 0.2, 0.3, 1)
	end
end

function mUI:CreateClassPower(self)
	local settings = mUI.profile["player"]
	if settings == nil then return end
	if settings.classpower.enabled == false then return end

	local ClassPower = {}
	ClassPower.Backgrounds = {}

	for i = 1, 10 do
		local Bar = CreateFrame("StatusBar", "ClassPower" .. i, self)
		Bar:SetHeight(mUI.db.player.classpower.height)
		if mUI.db.player.classpower.detach then
			Bar:SetPoint('LEFT', UIParent, 'CENTER', mUI.db.player.classpower.x, mUI.db.player.classpower.y)
		else
			Bar:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', (i - 1) * (Bar:GetWidth() + mUI.db.player.classpower.spacing),
				mUI.db.player.classpower.spacing)
		end
		Bar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
		ClassPower[i] = Bar

		local bg = CreateFrame("Frame", "ClassPowerBg" .. i, self, "BackdropTemplate")
		local borderSize = mUI.profile.settings.borderSize or 1
		bg:SetBackdrop({
			bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
			edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
			edgeSize = borderSize,
		})
		bg:SetPoint("TOPLEFT", Bar, -borderSize, borderSize)
		bg:SetPoint("BOTTOMRIGHT", Bar, borderSize, -borderSize)
		bg:SetBackdropColor(0.15, 0.15, 0.15, 1)
		bg:SetBackdropBorderColor(0, 0, 0, 1)

		ClassPower.Backgrounds[i] = bg
	end
	ClassPower.PostUpdate = PostUpdate
	self.ClassPower = ClassPower
end
