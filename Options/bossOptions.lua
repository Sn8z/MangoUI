local addonName, mUI = ...

function mUI:CreateBossOptions(category)
	-- Boss subsection
	local bossCategory, bossLayout = Settings.RegisterVerticalLayoutSubcategory(category, "Boss");
	Settings.RegisterAddOnCategory(bossCategory);
	
	do
		local title = "Test"
		local buttonText = "Test 2"
		local buttonClick = function()
			StaticPopup_Show({
				text = "DO YOU REALLY WANNA DO THAT?",
				button1 = "YES",
				button2 = "CANCEL",
				whileDead = true,
				hideOnEscape = true,
				exclusive = true,
				OnAccept = function()
					ReloadUI()
				end,
			})
		end
		local tooltip = "TEST TOOLTIP"
		local addSearchTags = "Test"

		local initializer = CreateSettingsButtonInitializer(title, buttonText, buttonClick, tooltip, addSearchTags)
		bossLayout:AddInitializer(initializer)
	end
end
