local AddonName, mUI = ...

local frame = CreateFrame("Frame")

-- Check the logged in character
local currentCharacter = UnitName("player") .. "-" .. GetRealmName()

function mUI:SetProfile(profile)
	MangoDB.MangoCharacters[currentCharacter] = profile
	ReloadUI()
end

function mUI:GetCurrentProfile()
	return MangoDB.MangoCharacters[currentCharacter]
end

function mUI:CreateProfile(name)
	MangoDB.MangoProfiles[name] = mUI.defaults.MangoProfiles["default"]
	MangoDB.MangoCharacters[currentCharacter] = name
end

function frame:OnEvent(event, ...)
	self[event](self, event, ...)
end

local function mergeTables(table1, table2)
	for key, value in pairs(table2) do
		if type(value) == "table" then
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

		--mUI.db = MangoDB

		-- print("Fetching profile for: " .. currentCharacter)
		if not MangoDB.MangoCharacters[currentCharacter] then
			MangoDB.MangoCharacters[currentCharacter] = "default"
		end

		local mangoProfile = MangoDB.MangoCharacters[currentCharacter] or "default"
		-- print("Current profile: " .. mangoProfile)
		mUI.profile = MangoDB.MangoProfiles[mangoProfile] or mUI.defaults.MangoProfiles["default"]
		mUI.profiles = MangoDB.MangoProfiles

		-- Check if there are new fields in the defaults and if so add them to the DB
		mergeTables(mUI.profile, mUI.defaults.MangoProfiles["default"])

		mUI.db = mUI.profile --temporary until name is changed everywhere
	end
end

frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", frame.OnEvent)
