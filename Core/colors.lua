local _, mUI = ...
local oUF = mUI.oUF

oUF.colors.health = oUF:CreateColor(40, 40, 40)
oUF.colors.disconnected = oUF:CreateColor(10, 10, 10)
oUF.colors.tapped = oUF:CreateColor(50, 50, 50)

oUF.colors.runes = {
	oUF:CreateColor(180, 0, 0),    -- BLOOD
	oUF:CreateColor(70, 200, 255), -- FROST
	oUF:CreateColor(180, 220, 130), -- UNHOLY
}

oUF.colors.smooth = {
	0.6, 0, 0,
	0.8, 0.7, 0,
	0.2, 0.8, 0.2,
}

oUF.colors.debuff = {
	["Curse"] = oUF:CreateColor(140, 0, 200),
	["Disease"] = oUF:CreateColor(210, 160, 120),
	["Magic"] = oUF:CreateColor(0, 120, 255),
	["Poison"] = oUF:CreateColor(255, 40, 40),
	["none"] = oUF:CreateColor(230, 0, 0),
}

oUF.colors.threat = {
	[0] = oUF:CreateColor(60, 60, 60),
	[1] = oUF:CreateColor(255, 255, 120),
	[2] = oUF:CreateColor(255, 140, 0),
	[3] = oUF:CreateColor(255, 40, 40),
}

oUF.colors.class['DEATHKNIGHT'] = oUF:CreateColor(180, 20, 40)
oUF.colors.class['DEMONHUNTER'] = oUF:CreateColor(140, 0, 180)
oUF.colors.class['DRUID'] = oUF:CreateColor(255, 150, 40)
oUF.colors.class['EVOKER'] = oUF:CreateColor(40, 140, 110)
oUF.colors.class['HUNTER'] = oUF:CreateColor(140, 180, 90)
oUF.colors.class['MAGE'] = oUF:CreateColor(30, 150, 200)
oUF.colors.class['MONK'] = oUF:CreateColor(0, 235, 120)
oUF.colors.class['PALADIN'] = oUF:CreateColor(230, 120, 170)
oUF.colors.class['PRIEST'] = oUF:CreateColor(255, 255, 255)
oUF.colors.class['ROGUE'] = oUF:CreateColor(250, 250, 40)
oUF.colors.class['SHAMAN'] = oUF:CreateColor(0, 80, 210)
oUF.colors.class['WARLOCK'] = oUF:CreateColor(120, 90, 180)
oUF.colors.class['WARRIOR'] = oUF:CreateColor(180, 120, 80)

oUF.colors.power.MANA = oUF:CreateColor(0, 120, 255)
oUF.colors.power[0] = oUF.colors.power.MANA
oUF.colors.power.RAGE = oUF:CreateColor(255, 60, 60)
oUF.colors.power[1] = oUF.colors.power.RAGE
oUF.colors.power.FOCUS = oUF:CreateColor(255, 140, 60)
oUF.colors.power[2] = oUF.colors.power.FOCUS
oUF.colors.power.ENERGY = oUF:CreateColor(250, 250, 40)
oUF.colors.power[3] = oUF.colors.power.ENERGY
oUF.colors.power.COMBO_POINTS = oUF:CreateColor(250, 250, 40)
oUF.colors.power[4] = oUF.colors.power.COMBO_POINTS
oUF.colors.power.RUNES = oUF:CreateColor(80, 80, 80)
oUF.colors.power[5] = oUF.colors.power.RUNES
oUF.colors.power.RUNIC_POWER = oUF:CreateColor(80, 80, 200)
oUF.colors.power[6] = oUF.colors.power.RUNIC_POWER
oUF.colors.power.SOUL_SHARDS = oUF:CreateColor(180, 120, 180)
oUF.colors.power[7] = oUF.colors.power.SOUL_SHARDS
oUF.colors.power.LUNAR_POWER = oUF:CreateColor(70, 140, 255)
oUF.colors.power[8] = oUF.colors.power.LUNAR_POWER
oUF.colors.power.HOLY_POWER = oUF:CreateColor(250, 250, 40)
oUF.colors.power[9] = oUF.colors.power.HOLY_POWER
oUF.colors.power.MAELSTROM = oUF:CreateColor(0, 130, 255)
oUF.colors.power[11] = oUF.colors.power.MAELSTROM
oUF.colors.power.CHI = oUF:CreateColor(180, 255, 240)
oUF.colors.power[12] = oUF.colors.power.CHI
oUF.colors.power.INSANITY = oUF:CreateColor(100, 0, 220)
oUF.colors.power[13] = oUF.colors.power.INSANITY
oUF.colors.power.ARCANE_CHARGES = oUF:CreateColor(40, 40, 255)
oUF.colors.power[16] = oUF.colors.power.ARCANE_CHARGES
oUF.colors.power.FURY = oUF:CreateColor(200, 80, 240)
oUF.colors.power[17] = oUF.colors.power.FURY
oUF.colors.power.PAIN = oUF:CreateColor(255, 150, 0)
oUF.colors.power[18] = oUF.colors.power.PAIN
oUF.colors.power.ESSENCE = oUF:CreateColor(50, 168, 82)
oUF.colors.power[19] = oUF.colors.power.ESSENCE
oUF.colors.power.ALTERNATE = oUF:CreateColor(100, 100, 255)
oUF.colors.power[10] = oUF.colors.power.ALTERNATE
