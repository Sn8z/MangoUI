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

-- Defaults
local defaultProfile = {
	settings = {
		smooth = true,
		healthTexture = "Sn8z",
		powerTexture = "Tim",
		castbarTexture = "Tim",
		font = "Ubuntu Medium",
		borderSize = 2,
		mangoColors = true,
		actionbars = {
			enabled = true,
			animations = false
		},
		tooltip = {
			enabled = true,
		},
		bags = {
			enabled = true,
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
			spacing = 3,
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
	favourites = {
		enabled = true,
		anchor = "CENTER",
		parentAnchor = "CENTER",
		width = 120,
		height = 40,
		classColor = true,
		units = {},
		power = {
			enabled = true,
			style = "INSET",
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
	party = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 180,
		height = 40,
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
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 70,
		height = 50,
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
