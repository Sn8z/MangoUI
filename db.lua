local AddonName, mUI = ...

local frame = CreateFrame("Frame")

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
		mUI.db = MangoDB

		--print(UnitName("player") .. "-" .. GetRealmName())

		-- RESET, BE CAREFUL!
		-- MangoDB = {}

		-- Check if there are new fields in the defaults and if so add them to the DB
		mergeTables(mUI.db, mUI.defaults)
	end
end

frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", frame.OnEvent)
