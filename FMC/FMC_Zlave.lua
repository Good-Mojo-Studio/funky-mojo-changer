-- some variables --
VDW.FMC = VDW.FMC or {}
local G = VDW.Local.Override
local C = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
local prefixChat = VDW.PrefixChat("FMC")
local function CreateGlobalVariables()
-- function for opening the options --
	local function ShowMenu()
		if not InCombatLockdown() then
			local _, loaded = C_AddOns.IsAddOnLoaded("FMC_Options")
			local loadable, reason = C_AddOns.IsAddOnLoadable("FMC_Options" , nil , true)
			if reason == "MISSING" then
				C_Sound.PlayVocalErrorSound(48)
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..string.format(G.WRN_ADDON_IS_STATE, C.High:WrapTextInColorCode("Funky Mojo Changer Options"), reason)))
				UIErrorsFrame:AddExternalWarningMessage(string.format(G.WRN_ADDON_IS_STATE, C.High:WrapTextInColorCode("Funky Mojo Changer Options"), reason))
			elseif loadable and not loaded then
				C_AddOns.LoadAddOn("FMC_Options")
				if not fmcOptions00:IsShown() then
					fmcOptions00:Show()
				else
					fmcOptions00:Hide()
				end
			elseif loadable and loaded then
				if not fmcOptions00:IsShown() then
					fmcOptions00:Show()
				else
					fmcOptions00:Hide()
				end
			else
				C_Sound.PlayVocalErrorSound(48)
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..string.format(G.WRN_ADDON_IS_STATE, C_AddOns.GetAddOnMetadata("FMC_Options", "Title"), reason)))
				UIErrorsFrame:AddExternalWarningMessage(string.format(G.WRN_ADDON_IS_STATE, C_AddOns.GetAddOnMetadata("FMC_Options", "Title"), reason))
			end
		else
			C_Sound.PlayVocalErrorSound(48)
			DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..G.WRN_COMBAT_LOCKDOWN))
			UIErrorsFrame:AddExternalWarningMessage(G.WRN_COMBAT_LOCKDOWN)
		end
	end
-- slash command --
	RegisterNewSlashCommand(ShowMenu, "fmc", "funkymojochanger")
-- mini map button functions --
	AddonCompartmentFrame:RegisterAddon({
		text = C.Main:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("FMC", "Title")),
		icon = C_AddOns.GetAddOnMetadata("FMC", "IconAtlas"),
		notCheckable = true,
		func = function(button, menuInputData, menu)
			local buttonName = menuInputData.buttonName
			if buttonName == "LeftButton" then
				ShowMenu()
			end
		end,
		funcOnEnter = function(button)
			VDW.Tooltip_Show(button, prefixTip, G.BUTTON_L_CLICK..": "..G.TIP_OPEN_SETTINGS_MAIN, C.Main)
		end,
		funcOnLeave = function(button)
			VDW.Tooltip_Hide()
		end,
	})
-- global for buttons --
	for i = 1, GetNumSpecializations(), 1 do
		 local specId, name, _, icon, role = C_SpecializationInfo.GetSpecializationInfo(i)
		VDW.FMC["specId"..i] = specId
		VDW.FMC["specName"..i] = name
		VDW.FMC["specIcon"..i] = icon
		VDW.FMC["specRole"..i] = role
	end
end
-- loading first time the variables --
local function FirstTimeSavedVariables()
	if FMCprofiles == nil then FMCprofiles = {} end
	if FMCsettings == nil then
		FMCsettings = {
			SpecButtons = {
				Size = 64,
				Visible = true,
				Button1 = {
					Position = {X = 0, Y = 540,},
				},
				Button2 = {
					Position = {X = 80, Y = 540,},
				},
				Button3 = {
					Position = {X = 160, Y = 540,},
				},
			},
			LootButtons = {
				Size = 64,
				Visible = true,
				Button1 = {
					Position = {X = 0, Y = 440,},
				},
				Button2 = {
					Position = {X = 80, Y = 440,},
				},
				Button3 = {
					Position = {X = 160, Y = 440,},
				},
				Button4 = {
					Position = {X = 240, Y = 440,},
				},
				Button5 = {
					Position = {X = 320, Y = 440,},
				},
			},
			TalentButtons = {
				Visible = true,
				Position = {X = 160, Y = 340},
				Direction = G.OPTIONS_D_UPWARD,
			},
			Animation = {
				Visible = true,
				Style = G.OPTIONS_S_BANNER,
				Background = G.OPTIONS_C_CLASS,
				AttachedToCastbar = false,
				Position = {X = 160, Y = 240},
				Size = {W = 400, H = 400},
			},
		}
	end
	if FMCprofilesLayout ~= nil then FMCprofilesLayout = nil end
	if FMCsettings.LastLocation == nil then FMCsettings.LastLocation = GetLocale() end
	if FMCspecialSettings == nil then FMCspecialSettings = {} end
	if FMCspecialSettings.FirstLogin == nil then FMCspecialSettings.FirstLogin = true end
	if FMCspecialSettings.FirstSpec == nil then FMCspecialSettings.FirstSpec = true end
	if FMCspecialSettings.TalentButtons == nil then
		FMCspecialSettings.TalentButtons = {
			LastConfig = {
				spec1 = {specID = 0, talentID = 0,},
				spec2 = {specID = 0, talentID = 0,},
				spec3 = {specID = 0, talentID = 0,},
				spec4 = {specID = 0, talentID = 0,},
			},
		}
	end
	if FMCspecialSettings.EquipmentSets == nil then FMCspecialSettings.EquipmentSets = {} end
	if FMCspecialSettings.TalentLayouts == nil then FMCspecialSettings.TalentLayouts = {} end
	if FMCspecialSettings.TalentBindEquipment == nil then FMCspecialSettings.TalentBindEquipment = {}
		for i = 1, GetNumSpecializations(), 1 do
			FMCspecialSettings.TalentBindEquipment[VDW.FMC["specId"..i]] = {}
		end
	end
end
CharacterMicroButton:HookScript("OnEnter", function(self)
	if MicroMenuContainer and MicroMenuContainer:IsShown() then
		local function word()
			local w = "Can't find..."
			local equip = "Can't find..."
			local loot = "Can't find..."
			local hero = C_ClassTalents.GetActiveHeroTalentSpec()
			for i = 0, C_EquipmentSet.GetNumEquipmentSets() - 1, 1 do
				local name, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(i)
				if isEquipped then equip = C.High:WrapTextInColorCode(name) end
			end
			if GetLootSpecialization() == 0 then
				loot = C.High:WrapTextInColorCode("Current Specialization")
			elseif GetLootSpecialization() == VDW.FMC.specId1 then
				loot = C.High:WrapTextInColorCode(VDW.FMC.specName1)
			elseif GetLootSpecialization() == VDW.FMC.specId2 then
				loot = C.High:WrapTextInColorCode(VDW.FMC.specName2)
			elseif GetLootSpecialization() == VDW.FMC.specId3 then
				loot = C.High:WrapTextInColorCode(VDW.FMC.specName3)
			elseif GetLootSpecialization() == VDW.FMC.specId4 then
				loot = C.High:WrapTextInColorCode(VDW.FMC.specName4)
			end
			if GetSpecialization() == 1 then
				local configInfo = C_Traits.GetConfigInfo(FMCspecialSettings.TalentButtons.LastConfig.spec1.talentID)
				local subTreeInfo = C_Traits.GetSubTreeInfo(FMCspecialSettings.TalentButtons.LastConfig.spec1.talentID, hero)
				w = "Spec: "..C.High:WrapTextInColorCode(VDW.FMC.specName1).."|nTalents: "..C.High:WrapTextInColorCode(configInfo.name).."|nHero: "..C.High:WrapTextInColorCode(subTreeInfo.name).."|nEquipment: "..equip.."|nLoot Spec: "..loot
			elseif GetSpecialization() == 2 then
				local configInfo = C_Traits.GetConfigInfo(FMCspecialSettings.TalentButtons.LastConfig.spec2.talentID)
				local subTreeInfo = C_Traits.GetSubTreeInfo(FMCspecialSettings.TalentButtons.LastConfig.spec2.talentID, hero)
				w = "Spec: "..C.High:WrapTextInColorCode(VDW.FMC.specName2).."|nTalents: "..C.High:WrapTextInColorCode(configInfo.name).."|nHero: "..C.High:WrapTextInColorCode(subTreeInfo.name).."|nEquipment: "..equip.."|nLoot Spec: "..loot
			elseif GetSpecialization() == 3 then
				local configInfo = C_Traits.GetConfigInfo(FMCspecialSettings.TalentButtons.LastConfig.spec3.talentID)
				local subTreeInfo = C_Traits.GetSubTreeInfo(FMCspecialSettings.TalentButtons.LastConfig.spec3.talentID, hero)
				w = "Spec: "..C.High:WrapTextInColorCode(VDW.FMC.specName3).."|nTalents: "..C.High:WrapTextInColorCode(configInfo.name).."|nHero: "..C.High:WrapTextInColorCode(subTreeInfo.name).."|nEquipment: "..equip.."|nLoot Spec: "..loot
			elseif GetSpecialization() == 4 then
				local configInfo = C_Traits.GetConfigInfo(FMCspecialSettings.TalentButtons.LastConfig.spec4.talentID)
				local subTreeInfo = C_Traits.GetSubTreeInfo(FMCspecialSettings.TalentButtons.LastConfig.spec4.talentID, hero)
				w = "Spec: "..C.High:WrapTextInColorCode(VDW.FMC.specName4).."|nTalents: "..C.High:WrapTextInColorCode(configInfo.name).."|nHero: "..C.High:WrapTextInColorCode(subTreeInfo.name).."|nEquipment: "..equip.."|nLoot Spec: "..loot
			end
			return w
		end
		VDW.Tooltip_Show(MicroMenuContainer, prefixTip, word(), C.Main)
	end
end)
CharacterMicroButton:HookScript("OnLeave", function(self)
	VDW.Tooltip_Hide()
end)
-- events time --
local function EventsTime(self, event, arg1, arg2, arg3, arg4)
	if event == "PLAYER_LOGIN" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			CreateGlobalVariables()
			FirstTimeSavedVariables()
		elseif UnitLevel("player") == 10 and C_SpecializationInfo.GetSpecialization() == 5 then
			if FMCspecialSettings.FirstLogin then
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." FMC is not working, you need to choose a specialization."))
				FMCspecialSettings.FirstLogin = false
			end
		elseif UnitLevel("player") < 10 then
			if FMCspecialSettings.FirstLogin then
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." FMC is not working, you need to be above level 10 and you need to choose a specialization."))
				FMCspecialSettings.FirstLogin = false
			end
		end
	elseif event == "PLAYER_LEVEL_UP" then
		if arg == 10 then
			if C_SpecializationInfo.GetSpecialization() == 5 then
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." FMC is not working, you need to choose a specialization."))
			end
		end
	elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCspecialSettings.FirstSpec then
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." Launching FMC, please wait..."))
				CreateGlobalVariables()
				FirstTimeSavedVariables()
				--FMCspecialSettings.FirstSpec = false
			end
		end
	end
end
fmcZlave:SetScript("OnEvent", EventsTime)
