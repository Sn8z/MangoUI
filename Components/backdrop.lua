local _, mUI = ...

function mUI:CreateBackdrop(frame)
	Mixin(frame, BackdropTemplateMixin)
	frame:SetBackdrop(mUI.config.defaultBackdrop)
	frame:SetBackdropColor(0.1, 0.1, 0.1, 1)
	frame:SetBackdropBorderColor(0.15, 0.15, 0.15, 1)
end

function mUI:CreateBorder(parent)
	local size = 2
	local border = CreateFrame("Frame", nil, parent, "BackdropTemplate")
	local framelvl = parent:GetFrameLevel()
	border:ClearAllPoints()
	border:SetPoint("TOPLEFT", parent, "TOPLEFT", -size, size)
	border:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", size, -size)
	border:SetFrameLevel(framelvl)
	border:SetBackdrop(mUI.config.backdrop)
	border:SetBackdropColor(0, 0, 0, 0)
	border:SetBackdropBorderColor(0, 0, 0, 1)
	parent.border = border
end

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