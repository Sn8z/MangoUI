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
		healthTexture = "Erik",
		powerTexture = "Erik",
		castbarTexture = "Erik",
		font = "Ubuntu Medium",
		borderSize = 1,
		mangoColors = true,
		actionbars = {
			enabled = true,
			animations = false
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
			detach = false,
			powerColor = true,
			width = 200,
			height = 20,
			x = 0,
			y = 0
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
		classpower = {
			enabled = true,
			detach = false,
			classColor = false,
			width = 200,
			height = 20,
			spacing = 5,
			x = 0,
			y = -200
		},
		portrait = {
			enabled = true,
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
			detach = true,
			classColor = true,
			width = 200,
			height = 8
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
			enabled = true,
			alpha = 0.2,
		}
	},
	pet = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 220,
		height = 50,
		classColor = true,
		power = {
			enabled = true,
			classColor = true
		},
		castbar = {
			enabled = true,
			classColor = true,
			shield = false,
			icon = true,
			height = 12
		},
		portrait = {
			enabled = true,
			alpha = 0.2,
		}
	},
	targettarget = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 220,
		height = 50,
		classColor = true,
		power = {
			enabled = true,
			classColor = true
		},
		portrait = {
			enabled = true,
			alpha = 0.2,
		}
	},
	focus = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 220,
		height = 50,
		x = 20,
		y = 400,
		classColor = true,
		power = {
			enabled = true,
			classColor = true,
			width = 200,
			height = 8
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
			enabled = true,
			alpha = 0.2,
		}
	},
	boss = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 220,
		height = 50,
		classColor = true,
		power = {
			enabled = true,
			classColor = true
		},
		castbar = {
			enabled = true,
			classColor = true,
			shield = false,
			icon = true,
			height = 16
		},
		portrait = {
			enabled = true,
			alpha = 0.2,
		}
	},
	party = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 220,
		height = 50,
		classColor = true,
		power = {
			enabled = true,
			classColor = true
		},
		portrait = {
			enabled = true,
			alpha = 0.2,
		}
	},
	raid = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 220,
		height = 50,
		classColor = true,
		power = {
			enabled = true,
			classColor = true
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
		["dark"] = darkProfile,
	},
}
