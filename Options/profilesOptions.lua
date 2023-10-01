local addonName, mUI = ...

function mUI:CreateProfilesOptions(category)
	-- Profiles subsection
	local profilesCategory, profilesLayout = Settings.RegisterVerticalLayoutSubcategory(category, "Profiles")
	Settings.RegisterAddOnCategory(profilesCategory)

	-- Profile dropdown
	do
		local variable = "mango profile"
		local defaultValue = mUI:GetCurrentProfile()
		local name = "Profile"
		local tooltip = "Choose profile."

		local function GetOptions()
			local container = Settings.CreateControlTextContainer()
			for k, v in next, mUI.profiles do
				container:Add(k, k)
			end
			return container:GetData()
		end

		local setting = Settings.RegisterAddOnSetting(profilesCategory, name, variable, type(defaultValue), defaultValue)
		Settings.CreateDropDown(profilesCategory, setting, GetOptions, tooltip)
		Settings.SetOnValueChangedCallback(variable, function(_, setting, value)
			mUI:SetProfile(value)
		end)
	end

	-- Create new profile
	StaticPopupDialogs.CreateProfilePopup = {
		text = "Enter name",
		button1 = OKAY,
		OnAccept = function(self)
			mUI:CreateProfile(self.editBox:GetText())
		end,
		hasEditBox = 1,
	}

	do
		local title = "Create new profile"
		local buttonText = "Create"
		local buttonClick = function()
			StaticPopup_Show("CreateProfilePopup")
		end
		local tooltip = "Create a new profile"
		local addSearchTags = "Create profile"

		local initializer = CreateSettingsButtonInitializer(title, buttonText, buttonClick, tooltip, addSearchTags)
		profilesLayout:AddInitializer(initializer)
	end
end
