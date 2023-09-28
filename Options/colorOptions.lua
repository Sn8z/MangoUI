local addonName, mUI = ...

function mUI:CreateColorOptions(category)
	-- Colors frame
	local colorFrame = CreateFrame("Frame")
	local colorBg = colorFrame:CreateTexture()
	colorBg:SetAllPoints(colorFrame)
	colorBg:SetColorTexture(0.3, 0.3, 0.3, 0.5)
	local colorCategory, colorLayout = Settings.RegisterCanvasLayoutSubcategory(category, colorFrame, "Colors")
	Settings.RegisterAddOnCategory(colorCategory)

	do
		local title = "Test"
		local buttonText = "Test 2"
		local buttonClick = function()
			print("TEST")
		end
		local tooltip = "TEST TOOLTIP"
		local addSearchTags = "Test"

		local initializer = CreateSettingsButtonInitializer(title, buttonText, buttonClick, tooltip, addSearchTags)
		colorLayout:AddInitializer(initializer)
	end
end