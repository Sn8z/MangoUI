local _, mUI = ...

-- TODO: create helper functions to minimize bloat & repetition

function mUI:CreateButton()
end

function mUI:CreateCheckBox(db, category, variable, label, tooltip)
	local variable = variable or ""
	local label = label or ""
	local tooltip = tooltip or ""
	local defaultValue = db or true

	local setting = Settings.RegisterAddOnSetting(category, label, variable, type(defaultValue), defaultValue)
	Settings.CreateCheckBox(category, setting, tooltip)
	Settings.SetOnValueChangedCallback(variable, function(_, s, v)
		db = v
	end)
end

function mUI:CreateSlider()
end

function mUI:CreateDropdown()
end

-- LSM textures
function mUI:CreateDropdownTextures()
end

-- LSM fonts
function mUI:CreateDropdownFonts()
end

-- LSM borders
function mUI:CreateDropdownBorders()
end
