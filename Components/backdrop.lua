local _, mUI = ...
local LSM = LibStub("LibSharedMedia-3.0")

function mUI:CreateBackdrop(frame)
	Mixin(frame, BackdropTemplateMixin)
	frame:SetBackdrop(mUI.config.defaultBackdrop)
	frame:SetBackdropColor(0.1, 0.1, 0.1, 1)
	frame:SetBackdropBorderColor(0.15, 0.15, 0.15, 1)
end

function mUI:CreateBorder(self)
	local size = mUI.db.settings.border.edgeSize
	local Border = CreateFrame('Frame', nil, self, 'BackdropTemplate')
	Border:SetPoint("TOPLEFT", self, "TOPLEFT", -size, size)
	Border:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", size, -size)
	Border:SetBackdrop({
		edgeFile = LSM:Fetch("border", mUI.db.settings.border.edgeFile),
		edgeSize = size,
		bgFile = nil
	})
	Border:SetFrameLevel(self:GetFrameLevel())
	Border:SetBackdropBorderColor(0, 0, 0, 1)
	Border:SetBackdropColor(0, 0, 0, 0)
	self.border = Border
end

--[[ TESTING STUFF HERE, MIGHT BE COOL
function mUI:CreateBorder(self)
	local size = 6 or mUI.db.settings.border.edgeSize
	local Border = CreateFrame('Frame', nil, self, 'BackdropTemplate')
	Border:SetPoint("TOPLEFT", self, "TOPLEFT", -size, -size)
	Border:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -size, -size)
	Border:SetBackdrop({
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Background"
				or LSM:Fetch("border", mUI.db.settings.border.edgeFile),
		edgeSize = size,
		bgFile = nil
	})
	Border:SetFrameLevel(self:GetFrameLevel())
	Border:SetBackdropBorderColor(0, 0, 0, 1)
	Border:SetBackdropColor(0, 0, 0, 0)
	self.border = Border
end
]]

function mUI:CreateBorderAlt(self)
	if not self.border then
		self.border = {}
		for i = 1, 4 do
			self.border[i] = self:CreateLine(nil, "BACKGROUND", nil, 0)
			local l = self.border[i]
			l:SetThickness(1)
			l:SetColorTexture(1, 1, 0, 1)
			if i == 1 then
				l:SetStartPoint("TOPLEFT")
				l:SetEndPoint("TOPRIGHT")
			elseif i == 2 then
				l:SetStartPoint("TOPRIGHT")
				l:SetEndPoint("BOTTOMRIGHT")
			elseif i == 3 then
				l:SetStartPoint("BOTTOMRIGHT")
				l:SetEndPoint("BOTTOMLEFT")
			else
				l:SetStartPoint("BOTTOMLEFT")
				l:SetEndPoint("TOPLEFT")
			end
		end
	end
end

--function mUI:CreateBackdrop(frame)
--	Mixin(frame, BackdropTemplateMixin)
--	frame:SetBackdrop(mUI.config.backdrop)
--	frame:SetBackdropColor(0.1, 0.1, 0.1, 1)
--	frame:SetBackdropBorderColor(0.15, 0.15, 0.15, 1)
--end
