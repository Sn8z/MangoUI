local _, mUI = ...

mUI.config = {}

mUI.config.anchors = {
	"CENTER",
	"TOP",
	"RIGHT",
	"BOTTOM",
	"LEFT",
	"TOPRIGHT",
	"BOTTOMRIGHT",
	"TOPLEFT",
	"BOTTOMLEFT"
}

mUI.config.powerstyles = {
	"NORMAL",
	"DETACH",
	"LEFT",
	"RIGHT",
	"INSET",
}

-- Defaults
local defaultProfile = {
	settings = {
		smooth = true,
		healthTexture = "Tim",
		powerTexture = "Tim",
		castbarTexture = "Tim",
		font = "Onest Semi Bold",
		borderSize = 1,
		actionbars = {
			enabled = true,
			animations = false
		},
		hide = {
			bags = true,
			social = true,
			menu = true
		},
		tooltip = {
			enabled = true,
		},
		minimap = {
			enabled = true,
		},
		auras = {
			enabled = true
		},
	},
	player = {
		enabled = true,
		anchor = "RIGHT",
		parentAnchor = "CENTER",
		width = 220,
		height = 50,
		x = -200,
		y = -210,
		classColor = true,
		power = {
			enabled = true,
			style = "RIGHT",
			powerColor = true,
			width = 160,
			height = 10,
			x = 0,
			y = 0,
			showText = true,
			fontSize = 14
		},
		castbar = {
			enabled = true,
			detach = false,
			classColor = true,
			shield = false,
			icon = false,
			width = 200,
			height = 20,
			x = 0,
			y = 0
		},
		classpower = {
			enabled = true,
			detach = false,
			classColor = false,
			width = 200,
			height = 8,
			spacing = 4,
			x = 0,
			y = -200
		},
		portrait = {
			enabled = false,
			alpha = 0.2,
		}
	},
	target = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 220,
		height = 50,
		x = 200,
		y = -210,
		classColor = true,
		power = {
			enabled = true,
			style = "LEFT",
			powerColor = true,
			width = 160,
			height = 10,
			showText = true,
			fontSize = 14
		},
		castbar = {
			enabled = true,
			detach = false,
			classColor = true,
			shield = false,
			icon = true,
			width = 200,
			height = 20,
			x = 0,
			y = 0
		},
		portrait = {
			enabled = false,
			alpha = 0.2,
		}
	},
	pet = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 110,
		height = 30,
		x = -480,
		y = -180,
		classColor = true,
		power = {
			enabled = true,
			style = "INSET",
			powerColor = true,
			width = 90,
			height = 8,
			showText = false,
			fontSize = 8
		},
		castbar = {
			enabled = true,
			classColor = true,
			shield = false,
			icon = true,
			height = 12
		},
		portrait = {
			enabled = false,
			alpha = 0.2,
		}
	},
	targettarget = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 110,
		height = 30,
		x = 480,
		y = -180,
		classColor = true,
		power = {
			enabled = true,
			style = "INSET",
			powerColor = true,
			width = 90,
			height = 8,
			showText = false,
			fontSize = 8
		},
		portrait = {
			enabled = false,
			alpha = 0.2,
		}
	},
	focus = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 200,
		height = 40,
		x = 20,
		y = 400,
		classColor = true,
		power = {
			enabled = true,
			style = "INSET",
			powerColor = true,
			width = 200,
			height = 8,
			showText = true,
			fontSize = 12
		},
		castbar = {
			enabled = true,
			detach = false,
			classColor = true,
			shield = false,
			icon = true,
			width = 200,
			height = 20,
			x = 0,
			y = 0
		},
		portrait = {
			enabled = false,
			alpha = 0.2,
		}
	},
	boss = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 180,
		height = 40,
		classColor = true,
		x = 350,
		y = -350,
		power = {
			enabled = true,
			style = "LEFT",
			powerColor = true,
			width = 120,
			height = 8,
			showText = true,
			fontSize = 12
		},
		castbar = {
			enabled = true,
			classColor = true,
			shield = false,
			icon = true,
			height = 16
		},
		portrait = {
			enabled = false,
			alpha = 0.2,
		}
	},
	party = {
		enabled = true,
		anchor = "CENTER",
		parentAnchor = "CENTER",
		width = 180,
		height = 40,
		x = -600,
		y = 40,
		classColor = true,
		power = {
			enabled = true,
			style = "RIGHT",
			powerColor = true,
			width = 120,
			height = 8,
			showText = false,
			fontSize = 8
		},
		portrait = {
			enabled = false,
			alpha = 0.2,
		}
	},
	raid = {
		enabled = true,
		anchor = "TOPLEFT",
		parentAnchor = "CENTER",
		width = 70,
		height = 50,
		x = 0,
		y = 0,
		classColor = true,
		power = {
			enabled = true,
			style = "NORMAL",
			powerColor = true,
			width = 200,
			height = 8,
			showText = false,
			fontSize = 8
		},
		portrait = {
			enabled = true,
			alpha = 0.2,
		}
	}
}

mUI.defaults = {
	MangoCharacters = {},
	MangoProfiles = {
		["default"] = defaultProfile,
	},
}
