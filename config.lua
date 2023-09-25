local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

mUI.config = {}

--mUI.player.class = select(2, UnitClass("player"))
--mUI.player.class.color = RAID_CLASS_COLORS[mUI.player.class]

-- Media
mUI.config.defaultBackdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	edgeSize = 4,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },
}

mUI.config.backdrop = {
	bgFile = "Interface\\Buttons\\WHITE8x8",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	tile = true,
	tileSize = 8,
	edgeSize = 2,
	insets = { left = -2, right = -2, top = -2, bottom = -2 },
}

-- Defaults
mUI.defaults = {
	settings = {
		smooth = true,
		texture = "True",
		font = "Rubik Bold",
		border = {
			offset = 2,
			edgeFile = "Blizzard Chat Bubble",
			edgeSize = 2
		},
		fps = {
			enabled = true,
			font = "Rubik Bold",
			size = 14,
			x = 0,
			y = 0
		}
	},
	player = {
		enabled = false,
		anchor = "RIGHT",
		parentAnchor = "CENTER",
		width = 220,
		height = 50,
		x = -200,
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
			classColor = true
		},
		classpower = {
			enabled = true,
			detach = true,
			classColor = false
		}
	},
	target = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 220,
		height = 50,
		classColor = true,
		power = {
			enabled = true,
			detach = true,
			classColor = true
		},
		castbar = {
			enabled = true,
			detach = true,
			classColor = true
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
			detach = true,
			classColor = true
		},
		castbar = {
			enabled = true,
			detach = true,
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
			detach = true,
			classColor = true
		},
		castbar = {
			enabled = true,
			detach = true,
			classColor = true
		}
	},
	focus = {
		enabled = true,
		anchor = "LEFT",
		parentAnchor = "CENTER",
		width = 220,
		height = 50,
		classColor = true,
		power = {
			enabled = true,
			detach = true,
			classColor = true
		},
		castbar = {
			enabled = true,
			detach = true,
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
			detach = true,
			classColor = true
		},
		castbar = {
			enabled = true,
			detach = true,
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
			detach = true,
			classColor = true
		},
		castbar = {
			enabled = true,
			detach = true,
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
			detach = true,
			classColor = true
		}
	}
}

local anchors = {
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
