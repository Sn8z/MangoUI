local _, mUI = ...
local oUF = mUI.oUF

function mUI:GetMangoColors()
	local colors = {
		power = {},
		class = {},
	}

	colors.health = oUF:CreateColor(40, 240, 40)
	colors.disconnected = oUF:CreateColor(30, 30, 30)
	colors.tapped = oUF:CreateColor(50, 50, 50)

	colors.runes = {
		oUF:CreateColor(180, 0, 0), -- BLOOD
		oUF:CreateColor(70, 200, 255), -- FROST
		oUF:CreateColor(180, 220, 130), -- UNHOLY
	}

	colors.smooth = {
		0.6, 0, 0,
		0.8, 0.7, 0,
		0.2, 0.8, 0.2,
	}

	colors.selection = oUF.colors.selection

	colors.debuff = {
		["Curse"] = oUF:CreateColor(140, 0, 200),
		["Disease"] = oUF:CreateColor(210, 160, 120),
		["Magic"] = oUF:CreateColor(0, 120, 255),
		["Poison"] = oUF:CreateColor(255, 40, 40),
		["none"] = oUF:CreateColor(50, 50, 50),
	}

	colors.reaction = oUF.colors.reaction

	colors.threat = {
		[0] = oUF:CreateColor(60, 60, 60),
		[1] = oUF:CreateColor(255, 255, 120),
		[2] = oUF:CreateColor(255, 140, 0),
		[3] = oUF:CreateColor(255, 40, 40),
	}

	colors.class['DEATHKNIGHT'] = oUF:CreateColor(180, 0, 0)
	colors.class['DEMONHUNTER'] = oUF:CreateColor(140, 0, 180)
	colors.class['DRUID'] = oUF:CreateColor(255, 150, 40)
	colors.class['EVOKER'] = oUF:CreateColor(40, 140, 110)
	colors.class['HUNTER'] = oUF:CreateColor(140, 180, 90)
	colors.class['MAGE'] = oUF:CreateColor(30, 150, 200)
	colors.class['MONK'] = oUF:CreateColor(0, 235, 120)
	colors.class['PALADIN'] = oUF:CreateColor(230, 120, 170)
	colors.class['PRIEST'] = oUF:CreateColor(255, 255, 255)
	colors.class['ROGUE'] = oUF:CreateColor(250, 250, 40)
	colors.class['SHAMAN'] = oUF:CreateColor(0, 80, 210)
	colors.class['WARLOCK'] = oUF:CreateColor(120, 90, 180)
	colors.class['WARRIOR'] = oUF:CreateColor(180, 120, 80)

	colors.power.MANA = oUF:CreateColor(0, 120, 255)
	colors.power[0] = colors.power.MANA
	colors.power.RAGE = oUF:CreateColor(255, 60, 60)
	colors.power[1] = colors.power.RAGE
	colors.power.FOCUS = oUF:CreateColor(255, 140, 60)
	colors.power[2] = colors.power.FOCUS
	colors.power.ENERGY = oUF:CreateColor(250, 250, 40)
	colors.power[3] = colors.power.ENERGY
	colors.power.COMBO_POINTS = oUF:CreateColor(250, 250, 40)
	colors.power[4] = colors.power.COMBO_POINTS
	colors.power.RUNES = oUF:CreateColor(80, 80, 80)
	colors.power[5] = colors.power.RUNES
	colors.power.RUNIC_POWER = oUF:CreateColor(80, 80, 200)
	colors.power[6] = colors.power.RUNIC_POWER
	colors.power.SOUL_SHARDS = oUF:CreateColor(180, 120, 180)
	colors.power[7] = colors.power.SOUL_SHARDS
	colors.power.LUNAR_POWER = oUF:CreateColor(70, 140, 255)
	colors.power[8] = colors.power.LUNAR_POWER
	colors.power.HOLY_POWER = oUF:CreateColor(250, 250, 40)
	colors.power[9] = colors.power.HOLY_POWER
	colors.power.MAELSTROM = oUF:CreateColor(0, 130, 255)
	colors.power[11] = colors.power.MAELSTROM
	colors.power.CHI = oUF:CreateColor(180, 255, 240)
	colors.power[12] = colors.power.CHI
	colors.power.INSANITY = oUF:CreateColor(100, 0, 220)
	colors.power[13] = colors.power.INSANITY
	colors.power.ARCANE_CHARGES = oUF:CreateColor(40, 40, 255)
	colors.power[16] = colors.power.ARCANE_CHARGES
	colors.power.FURY = oUF:CreateColor(200, 80, 240)
	colors.power[17] = colors.power.FURY
	colors.power.PAIN = oUF:CreateColor(255, 150, 0)
	colors.power[18] = colors.power.PAIN
	colors.power.ESSENCE = oUF:CreateColor(50, 168, 82)
	colors.power[19] = colors.power.ESSENCE
	colors.power.ALTERNATE = oUF:CreateColor(100, 100, 255)
	colors.power[10] = colors.power.ALTERNATE

	return colors
end
