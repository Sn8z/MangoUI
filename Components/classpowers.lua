local _, mUI = ...
local oUF = mUI.oUF
local LSM = LibStub("LibSharedMedia-3.0")

local UnitClass, UnitExists = UnitClass, UnitExists

local function PostVisibility(element, isVisible)
	for i = 1, #element.Backgrounds do
		if isVisible then
			element.Backgrounds[i]:Show()
		else
			element.Backgrounds[i]:Hide()
		end
	end
end

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
			element[i]:ClearAllPoints()
			local totalSpacing = (max - 1) * spacing
			PixelUtil.SetWidth(element[i], (element[i]:GetParent():GetWidth() - totalSpacing) / max)
			PixelUtil.SetHeight(element[i], mUI.db.player.classpower.height)
			if i == 1 then
				PixelUtil.SetPoint(
					element[i],
					"LEFT",
					element[i]:GetParent(),
					"LEFT",
					0,
					0
				)
			elseif i == max then
				PixelUtil.SetPoint(element[i], "LEFT", element[i - 1], "RIGHT", spacing, 0)
				PixelUtil.SetPoint(element[i], "RIGHT", element[i]:GetParent(), "RIGHT", 0, 0)
			else
				PixelUtil.SetPoint(element[i], "LEFT", element[i - 1], "RIGHT", spacing, 0)
			end
			element.Backgrounds[i]:Show()
		end

		for i = max + 1, #element.Backgrounds do
			element.Backgrounds[i]:Hide()
		end
	end

	if max and max == 5 then
		element[max - 1]:SetStatusBarColor(1, 0.5, 0, 1)
		element[max]:SetStatusBarColor(1, 0, 0, 1)
	elseif max and max >= 6 then
		element[max - 2]:SetStatusBarColor(1, 0.5, 0, 1)
		element[max - 1]:SetStatusBarColor(1, 0.3, 0, 1)
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

function mUI:CreateClassPowers(self)
	if not UnitExists(self.unit) then return end
	local _, _, classIndex = UnitClass(self.unit)
	local settings = mUI.profile["player"]
	if settings == nil then return end
	if settings.classpower.enabled == false then return end

	-- Placeholder
	local classPowerPlaceholder = CreateFrame("Frame", "ClassPowerPlaceholder", self)
	if settings.classpower.detach then
		PixelUtil.SetSize(classPowerPlaceholder, settings.classpower.width, settings.classpower.height)
		PixelUtil.SetPoint(
			classPowerPlaceholder,
			"CENTER",
			UIParent,
			"CENTER",
			settings.classpower.x,
			settings.classpower.y
		)

		-- Mover
		mUI:AddMover(classPowerPlaceholder, "Player Classpower", function(x, y)
			settings.classpower.x = x
			settings.classpower.y = y
		end)
	else
		PixelUtil.SetSize(classPowerPlaceholder, classPowerPlaceholder:GetParent():GetWidth(), settings.classpower.height)
		PixelUtil.SetPoint(classPowerPlaceholder, "BOTTOMLEFT", self, "TOPLEFT", 0, 0)
		PixelUtil.SetPoint(classPowerPlaceholder, "BOTTOMRIGHT", self, "TOPRIGHT", 0, 0)
	end

	-- Classpower
	local ClassPower = {}
	ClassPower.Backgrounds = {}
	for i = 1, 10 do
		local Bar = CreateFrame("StatusBar", "MangoClassPower" .. i, classPowerPlaceholder)
		PixelUtil.SetHeight(Bar, settings.classpower.height)
		Bar:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
		ClassPower[i] = Bar
		mUI:CreateBorder(Bar)

		local bg = CreateFrame("Frame", "MangoClassPowerBg" .. i, classPowerPlaceholder, "BackdropTemplate")
		local borderSize = mUI.profile.settings.borderSize or 1
		bg:SetBackdrop({
			bgFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
			edgeFile = [[Interface\AddOns\MangoUI\Media\border.tga]],
			edgeSize = borderSize,
		})
		bg:SetAllPoints(Bar)
		bg:SetBackdropColor(0.15, 0.15, 0.15, 1)
		bg:SetBackdropBorderColor(0, 0, 0, 1)
		ClassPower.Backgrounds[i] = bg
	end
	ClassPower.PostUpdate = PostUpdate
	ClassPower.PostVisibility = PostVisibility
	self.ClassPower = ClassPower

	-- Stagger
	if classIndex == 10 then
		local Stagger = CreateFrame("StatusBar", "MangoStagger", classPowerPlaceholder)
		Stagger:SetAllPoints()
		Stagger:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
		mUI:CreateBorder(Stagger)
		local bg = Stagger:CreateTexture(nil, "BACKGROUND")
		bg:SetTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
		bg:SetAllPoints()
		bg.multiplier = 1 / 6
		Stagger.bg = bg
		self.Stagger = Stagger
	end

	-- Runes
	if classIndex == 6 then
		local Runes = {}
		local numberOfRunes = 6
		local totalSpacing = settings.classpower.spacing * (numberOfRunes - 1)
		for i = 1, 6 do
			local Rune = CreateFrame("StatusBar", "MangoRune" .. i, classPowerPlaceholder)
			PixelUtil.SetHeight(Rune, settings.classpower.height)
			PixelUtil.SetWidth(Rune, (Rune:GetParent():GetWidth() - totalSpacing) / numberOfRunes)
			PixelUtil.SetPoint(
				Rune,
				"LEFT",
				Rune:GetParent(),
				"LEFT",
				((i - 1) * (Rune:GetWidth() + settings.classpower.spacing)),
				0
			)
			if i == numberOfRunes then
				PixelUtil.SetPoint(Rune, "RIGHT", Rune:GetParent(), "RIGHT", 0, 0)
			end
			Rune:SetStatusBarTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
			local bg = Rune:CreateTexture(nil, "BACKGROUND")
			bg:SetTexture(LSM:Fetch("statusbar", mUI.profile.settings.powerTexture))
			bg:SetAllPoints()
			bg.multiplier = 1 / 6
			Rune.bg = bg
			mUI:CreateBorder(Rune)
			Runes.colorSpec = true
			Runes.sortOrder = "asc"
			Runes[i] = Rune
		end
		self.Runes = Runes
	end
end
