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
		button2 = CANCEL,
		OnAccept = function(self)
			if self.table then
				mUI:CreateProfile(self.editBox:GetText(), self.table)
			else
				mUI:CreateProfile(self.editBox:GetText())
			end
		end,
		hasEditBox = 1,
		whileDead = true,
		hideOnEscape = true
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

	-- Import profile
	StaticPopupDialogs.ImportProfilePopup = {
		text = "Enter import string",
		button1 = OKAY,
		button2 = CANCEL,
		OnAccept = function(self)
			local dialog = StaticPopup_Show("CreateProfilePopup")
			dialog.table = self.editBox:GetText()
		end,
		hasEditBox = 1,
		whileDead = true,
		hideOnEscape = true
	}

	do
		local title = "Import new profile"
		local buttonText = "Import"
		local buttonClick = function()
			StaticPopup_Show("ImportProfilePopup")
		end
		local tooltip = "Import a new profile"
		local addSearchTags = "Import profile"

		local initializer = CreateSettingsButtonInitializer(title, buttonText, buttonClick, tooltip, addSearchTags)
		profilesLayout:AddInitializer(initializer)
	end

	-- Export profile
	StaticPopupDialogs.ExportProfilePopup = {
		text = "Copy the export string",
		button1 = OKAY,
		OnShow = function(self)
			self.editBox:SetText(mUI:GetProfileExportString())
			self.editBox:HighlightText()
		end,
		hasEditBox = 1,
		whileDead = true,
		hideOnEscape = true
	}

	do
		local title = "Export profile"
		local buttonText = "Export"
		local buttonClick = function()
			StaticPopup_Show("ExportProfilePopup")
		end
		local tooltip = "Export a profile"
		local addSearchTags = "Export profile"

		local initializer = CreateSettingsButtonInitializer(title, buttonText, buttonClick, tooltip, addSearchTags)
		profilesLayout:AddInitializer(initializer)
	end

	-- Delete profile
	StaticPopupDialogs.DeleteProfilePopup = {
		text = "Are you sure? (Type DELETE to confirm)",
		button1 = OKAY,
		button2 = CANCEL,
		OnShow = function(self)
			self.button1:Disable()
		end,
		OnAccept = function(self)
			if self.editBox:GetText() ~= "DELETE" then return end
			print("ACCEPT PROFILE: " .. self.profile)
			mUI:DeleteProfile(self.profile)
		end,
		EditBoxOnTextChanged = function(self)
			if self:GetText() == "DELETE" then
				self:GetParent().button1:Enable()
			else
				self:GetParent().button1:Disable()
			end
		end,
		hasEditBox = 1,
		whileDead = true,
		hideOnEscape = true
	}

	-- Profile deletion dropdown
	do
		local variable = "mango delete profile"
		local defaultValue = ""
		local name = "Delete Profile"
		local tooltip = "Choose a profile to delete."

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
			local dialog = StaticPopup_Show("DeleteProfilePopup")
			if dialog then
				dialog.profile = value
			end
		end)
	end
end
