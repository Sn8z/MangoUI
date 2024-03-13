local _, mUI = ...
local oUF = mUI.oUF

function mUI:GetClassColor(unit)
	local _, class = UnitClass(unit)
	return oUF.colors.class[class]
end
