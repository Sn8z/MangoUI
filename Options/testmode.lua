local _, mUI = ...
-- Thanks to Phanx for this solution

local frames = {
	"oUF_MangoBoss1",
	"oUF_MangoBoss2",
	"oUF_MangoBoss3",
	"oUF_MangoBoss4",
	"oUF_MangoBoss5",
	"oUF_MangoPrimaryPlayer",
	"oUF_MangoPrimaryTarget",
	"oUF_MangoPrimaryFocus",
	"oUF_MangoSecondaryPet",
	"oUF_MangoSecondaryTargetTarget"
}

local function toggle(f)
	if f.__realunit then
		f:SetAttribute("unit", f.__realunit)
		f.unit = f.__realunit
		f.__realunit = nil
		f:Hide()
	else
		f.__realunit = f:GetAttribute("unit") or f.unit
		f:SetAttribute("unit", "player")
		f.unit = "player"
		f:Show()
	end
end

function mUI:ToggleFrames()
	if InCombatLockdown() then
		print("Can't toggle frames in combat.")
	else
		for i = 1, #frames do
			toggle(_G[frames[i]])
		end
	end
end

SLASH_MANGOTEST1, SLASH_MANGOTEST2 = "/mtest", "/mangotest"
SlashCmdList["MANGOTEST"] = mUI.ToggleFrames
