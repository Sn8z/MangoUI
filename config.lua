local addonName, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

mUI.config = {}

--mUI.player.class = select(2, UnitClass("player"))
--mUI.player.class.color = RAID_CLASS_COLORS[mUI.player.class]

-- Media
mUI.config.defaultTexture = "True"
mUI.config.defaultFont = "TeX Gyre Adventor Bold"
mUI.config.defaultBackdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	edgeSize = 4,
	insets = {left = 4, right = 4, top = 4, bottom = 4},
}

mUI.config.backdrop = {
  bgFile = "Interface\\Buttons\\WHITE8x8",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Background",
  tile = true, tileSize = 8, edgeSize = 2,
  insets = { left = -2, right = -2, top = -2, bottom = -2 },
}

-- Defaults
mUI.defaults = {
	settings = {
		texture = "TEXTURE"
	},
	hide = {
		bags = true,
		socialButton = true
	},
	player = {
		enabled = true,
		anchor = "RIGHT",
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

-- Interface Options Frame
local muiPanel = CreateFrame("Frame")
muiPanel.name = "MangoUI"
InterfaceOptions_AddCategory(muiPanel)

local logo = muiPanel:CreateTexture(nil, "BACKGROUND")
logo:SetTexture("Interface\\AddOns\\MangoUI\\Media\\mangologo.tga")
logo:SetSize(70, 70)
logo:SetPoint("TOP", 0, -5)

local title = muiPanel:CreateFontString(nil, "OVERLAY")
title:SetPoint("TOP", logo, "BOTTOM", 0, -5)
title:SetFont(LSM:Fetch("font", mUI.config.defaultFont), 36, "THINOUTLINE")
title:SetText(select(2, GetAddOnInfo(addonName)))

local versionText = muiPanel:CreateFontString("ARTWORK", nil, "GameFontNormal")
versionText:SetPoint("TOP", title, "BOTTOM", 0, -5)
versionText:SetFont(LSM:Fetch("font", mUI.config.defaultFont), 20, "THINOUTLINE")
versionText:SetText(GetAddOnMetadata("MangoUI", "Version"))

-- General Options
-- Actionbars
-- bnettoast
-- Framerate
-- Hide Random Blizz Stuff
-- Tooltip 

local tooltipCheck = CreateFrame("CheckButton", "MangoCheck", muiPanel, "InterfaceOptionsCheckButtonTemplate")
tooltipCheck:SetPoint("TOP", versionText, 'BOTTOM', 0, -5)
tooltipCheck.Text:SetText("Enable tooltips")
tooltipCheck:SetScript("OnClick", function(self)
	if self:GetChecked() then
		print("CHECKED")
	else
		print("NOT CHECKED")
	end
end)

-- Create a dropdown menu
local dropdown = CreateFrame("Frame", "MyAddonDropdown", muiPanel, "UIDropDownMenuTemplate")
dropdown:SetPoint("TOPLEFT", tooltipCheck, 'BOTTOM', 0, -16)

-- Define the dropdown options
local options = {
	{ text = "Option 1", value = 1 },
	{ text = "Option 2", value = 2 },
	{ text = "Option 3", value = 3 },
}

-- Define the dropdown initialization function
local function Dropdown_Initialize(self, level)
	for _, option in ipairs(options) do
		local info = UIDropDownMenu_CreateInfo()
		info.text = option.text
		info.value = option.value
		info.func = function()
			UIDropDownMenu_SetSelectedValue(dropdown, option.value)
			mUI.db.settings.texture = option.value
		end
		UIDropDownMenu_AddButton(info, level)
	end
end

-- Initialize the dropdown
UIDropDownMenu_Initialize(dropdown, Dropdown_Initialize)
UIDropDownMenu_SetWidth(dropdown, 200)
UIDropDownMenu_SetButtonWidth(dropdown, 200)
UIDropDownMenu_SetText(dropdown, "Select an option")

-- Player settings
local playerPanel = CreateFrame("FRAME")
playerPanel.name = "Player"
playerPanel.parent = "MangoUI"
InterfaceOptions_AddCategory(playerPanel)

local playerEnableCheck = CreateFrame("CheckButton", "MangoCheck", playerPanel, "InterfaceOptionsCheckButtonTemplate")
playerEnableCheck:SetPoint("TOP", 0, 0)
playerEnableCheck:SetScript("OnClick", function(self)

end)

local checkbox = CreateFrame("CheckButton", "MyAddonCheckbox", playerPanel, "InterfaceOptionsCheckButtonTemplate")
checkbox:SetPoint("TOPLEFT", playerEnableCheck, "BOTTOMLEFT", 0, -16)
checkbox.Text:SetText("Enable Feature X")
checkbox:SetScript("OnClick", function(self)
	mUI.db.player.enabled = self:GetChecked()
	if self:GetChecked() then
		print("Enabled playerframe")
	else
		print("Disabled playerframe")
	end
end)

local sliderText1 = playerPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")

local pWidthSlider = CreateFrame("Slider", "MyAddonSlider", playerPanel, "OptionsSliderTemplate")
pWidthSlider:SetPoint("TOPLEFT", checkbox, "BOTTOMLEFT", 0, -16)
pWidthSlider:SetMinMaxValues(0, 500)
pWidthSlider:SetValueStep(1)
pWidthSlider:SetObeyStepOnDrag(true)
pWidthSlider:SetWidth(200)
pWidthSlider:SetScript("OnValueChanged", function(self, value)
	mUI.db.player.width = value
	sliderText1:SetText("Slider Value: " .. mUI.db.player.width)
end)

sliderText1:SetPoint("LEFT", pWidthSlider, "RIGHT", 5, 0)

local sliderText2 = playerPanel:CreateFontString(nil, "ARTWORK", "GameFontHighlight")

local slider = CreateFrame("Slider", "MyAddonSlider", playerPanel, "OptionsSliderTemplate")
slider:SetPoint("TOPLEFT", pWidthSlider, "BOTTOMLEFT", 0, -16)
slider:SetMinMaxValues(0, 500)
slider:SetValueStep(1)
slider:SetObeyStepOnDrag(true)
slider:SetWidth(200)
slider:SetScript("OnValueChanged", function(self, value)
	mUI.db.player.height = value
	sliderText2:SetText("Slider Value: " .. mUI.db.player.height)
end)

sliderText2:SetPoint("LEFT", slider, "RIGHT", 5, 0)


-- Pet settings
local petPanel = CreateFrame("FRAME")
petPanel.name = "Pet"
petPanel.parent = "MangoUI"
InterfaceOptions_AddCategory(petPanel)

-- Target settings
local targetPanel = CreateFrame("FRAME")
targetPanel.name = "Target"
targetPanel.parent = "MangoUI"
InterfaceOptions_AddCategory(targetPanel)

-- Target of target settings
local targetTargetPanel = CreateFrame("FRAME")
targetTargetPanel.name = "TargetTarget"
targetTargetPanel.parent = "MangoUI"
InterfaceOptions_AddCategory(targetTargetPanel)

-- Focus settings
local focusPanel = CreateFrame("FRAME")
focusPanel.name = "Focus"
focusPanel.parent = "MangoUI"
InterfaceOptions_AddCategory(focusPanel)

-- Party settings
local partyPanel = CreateFrame("FRAME")
partyPanel.name = "Party"
partyPanel.parent = "MangoUI"
InterfaceOptions_AddCategory(partyPanel)

-- Raid settings
local raidPanel = CreateFrame("FRAME")
raidPanel.name = "Raid"
raidPanel.parent = "MangoUI"
InterfaceOptions_AddCategory(raidPanel)

-- Boss settings
local bossPanel = CreateFrame("FRAME")
bossPanel.name = "Boss"
bossPanel.parent = "MangoUI"
InterfaceOptions_AddCategory(bossPanel)

