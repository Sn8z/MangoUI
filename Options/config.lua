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
		texture = "Erik",
		font = "Ubuntu Medium",
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
			classColor = true
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
			classColor = true
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
		}
	}
}

local darkProfile = {
	settings = {
		smooth = true,
		texture = "Brink",
		font = "Rubik",
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
			classColor = true
		},
		castbar = {
			enabled = true,
			detach = true,
			classColor = true,
			width = 200,
			height = 20,
			x = 0,
			y = 0
		},
		classpower = {
			enabled = true,
			detach = true,
			classColor = false
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
			classColor = true
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
			classColor = true
		},
		castbar = {
			enabled = true,
			detach = false,
			classColor = true
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
			classColor = true
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
