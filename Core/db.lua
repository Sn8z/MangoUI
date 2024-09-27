local AddonName, mUI = ...

local frame = CreateFrame("Frame")

-- Check the logged in character
local currentCharacter = UnitName("player") .. "-" .. GetRealmName()

-- Set the active profile
function mUI:SetProfile(profile)
	MangoDB.MangoCharacters[currentCharacter] = profile
	ReloadUI()
end

-- Returns the currently active profile
function mUI:GetCurrentProfile()
	return MangoDB.MangoCharacters[currentCharacter]
end

-- Delete a profile
function mUI:DeleteProfile(name)
	print("Removing: " .. name)
	if mUI:GetCurrentProfile() == name then -- switch profile before we delete it
		mUI:SetProfile("default")
	end
	MangoDB.MangoProfiles[name] = nil
	ReloadUI()
end

-- Deserialize a string into a LUA table
local function DeserializeTable(str)
	local func, err = loadstring("return " .. str)
	if not func then
		error("Error in deserialization: " .. err)
		return nil
	end

	local success, result = pcall(func)
	if not success then
		error("Error in deserialization: " .. result)
		return nil
	end

	return result
end

-- Create a profile
function mUI:CreateProfile(name, table)
	if name == nil then return end
	if type(table) == "string" then
		table = DeserializeTable(table)
	end
	MangoDB.MangoProfiles[name] = table or mUI.defaults.MangoProfiles["default"]
	MangoDB.MangoCharacters[currentCharacter] = name
	ReloadUI()
end

-- Serialize a LUA table to a string
local function SerializeTable(table)
	local str = "{"

	for key, value in pairs(table) do
		if type(key) == "number" then
			str = str .. "[" .. key .. "]"
		elseif type(key) == "string" then
			str = str .. '["' .. key .. '"]'
		else
			error("Unsupported key type: " .. type(key))
		end

		if type(value) == "number" or type(value) == "boolean" then
			str = str .. "=" .. tostring(value)
		elseif type(value) == "string" then
			str = str .. '="' .. value .. '"'
		elseif type(value) == "table" then
			str = str .. "=" .. SerializeTable(value)
		else
			error("Unsupported value type: " .. type(value))
		end

		str = str .. ","
	end

	str = str .. "}"
	return str
end

function mUI:GetProfileExportString()
	local profile = mUI:GetCurrentProfile()
	return SerializeTable(MangoDB.MangoProfiles[profile])
end

function frame:OnEvent(event, ...)
	self[event](self, event, ...)
end

local function mergeTables(table1, table2)
	for key, value in pairs(table2) do
		if type(value) == "table" and next(value) then
			if table1[key] == nil or type(table1[key]) ~= "table" then
				table1[key] = {}
			end
			mergeTables(table1[key], value)
		else
			if table1[key] == nil then
				table1[key] = value
			end
		end
	end

	-- Check if DB contains old keys and remove them
	for key, _ in pairs(table1) do
		if table2[key] == nil then
			table1[key] = nil
		end
	end
end

function frame:ADDON_LOADED(event, addOnName)
	if addOnName == AddonName then
		MangoDB = MangoDB or {}
		MangoDB.MangoCharacters = MangoDB.MangoCharacters or {}
		MangoDB.MangoProfiles = MangoDB.MangoProfiles or {}

		-- Load default profiles
		for k, v in next, mUI.defaults.MangoProfiles do
			if MangoDB.MangoProfiles[k] == nil then
				MangoDB.MangoProfiles[k] = v
			end
		end

		if not MangoDB.MangoCharacters[currentCharacter] then
			MangoDB.MangoCharacters[currentCharacter] = "default"
		end

		local mangoProfile = MangoDB.MangoCharacters[currentCharacter] or "default"
		mUI.profile = MangoDB.MangoProfiles[mangoProfile] or mUI.defaults.MangoProfiles["default"]
		mUI.profiles = MangoDB.MangoProfiles

		-- Check if there are new fields in the defaults and if so add them to the DB
		mergeTables(mUI.profile, mUI.defaults.MangoProfiles["default"])
	end
end

frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", frame.OnEvent)
