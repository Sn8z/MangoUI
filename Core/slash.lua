local _, mUI = ...

local function OpenOptions(msg, editbox)
	-- pattern matching that skips leading whitespace and whitespace between cmd and args
	-- any whitespace at end of args is retained
	local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")

	if cmd == "test" and args ~= "" then
		print("Test: " ..args)
	else
		Settings.OpenToCategory(Settings.MUI_CATEGORY_ID)
	end
end

SLASH_MANGOUI1, SLASH_MANGOUI2, SLASH_MANGOUI3 = '/mui', '/mango', '/mangoui'

SlashCmdList["MANGOUI"] = OpenOptions
