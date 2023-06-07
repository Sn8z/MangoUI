local _, mUI = ...

local function OpenOptions(msg, editbox)
	-- pattern matching that skips leading whitespace and whitespace between cmd and args
	-- any whitespace at end of args is retained
	local _, _, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")

	if cmd == "add" and args ~= "" then
		print("adding " .. args)
		-- Handle adding of the contents of rest... to something.
	elseif cmd == "remove" and args ~= "" then
		print("removing " .. args)
		-- Handle removing of the contents of rest... to something.
	else
		InterfaceOptionsFrame_OpenToCategory("MangoUI")
	end
end

SLASH_MANGOUI1, SLASH_MANGOUI2, SLASH_MANGOUI3 = '/mui', '/mango', '/mangoui'

SlashCmdList["MANGOUI"] = OpenOptions
