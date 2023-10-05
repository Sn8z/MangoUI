local _, mUI = ...

function mUI:CreatePortrait(self)
	local unit = self.unit
	if string.match(unit, "^boss[123456789]$") then
		unit = "boss"
	end
	print("CREATING PORTRAIT FOR: " .. unit)
	local settings = mUI.profile[unit]
	if settings == nil or settings.portrait == nil then return end
	if settings.portrait.enabled == false or settings.portrait.enabled == nil then return end

	local Portrait = CreateFrame('PlayerModel', nil, self)
	Portrait:SetAllPoints(self.Health)
	Portrait:SetAlpha(settings.portrait.alpha or 0.4)

	self.Portrait = Portrait
end
