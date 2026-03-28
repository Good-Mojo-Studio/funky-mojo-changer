-- some variables --
local G = VDW.Local.Override
local C = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
-- local-only strings for THIS file --
local L = (function()
	local base = {
-- tip --
		TIP_SPEC_LOOT_BUTTON = " to change your loot specialization into: %s Specialization!",
		TIP_SPEC_LOOT_CURRENT = " to change your loot specialization into: Current Specialization (%s)",
-- warn --
		WRN_SPEC_LOOT_CURRENT = "|cnYELLOW_FONT_COLOR:Loot Specialization set to: Current Specialization (%s)|r",
	}
-- override --
	local o = {
		frFR = {
-- tip --
			TIP_SPEC_LOOT_BUTTON = " pour changer votre spécialisation de butin en : Spécialisation %s !",
			TIP_SPEC_LOOT_CURRENT = " pour changer votre spécialisation de butin en : Spécialisation actuelle (%s)",
-- warn --
			WRN_SPEC_LOOT_CURRENT = "|cnYELLOW_FONT_COLOR:Spécialisation de butin définie sur : Spécialisation actuelle (%s)|r",
		},
		deDE = {
-- tip --
			TIP_SPEC_LOOT_BUTTON = " um deine Beutespezialisierung zu ändern zu: Spezialisierung %s!",
			TIP_SPEC_LOOT_CURRENT = " um deine Beutespezialisierung zu ändern zu: Aktuelle Spezialisierung (%s)",
-- warn --
			WRN_SPEC_LOOT_CURRENT = "|cnYELLOW_FONT_COLOR:Beutespezialisierung gesetzt auf: Aktuelle Spezialisierung (%s)|r",
		},
		esES = {
-- tip --
			TIP_SPEC_LOOT_BUTTON = " para cambiar tu especialización de botín a: Especialización %s!",
			TIP_SPEC_LOOT_CURRENT = " para cambiar tu especialización de botín a: Especialización actual (%s)",
-- warn --
			WRN_SPEC_LOOT_CURRENT = "|cnYELLOW_FONT_COLOR:Especialización de botín establecida en: Especialización actual (%s)|r",
		},
		esMX = {
-- tip --
			TIP_SPEC_LOOT_BUTTON = " para cambiar tu especialización de botín a: Especialización %s!",
			TIP_SPEC_LOOT_CURRENT = " para cambiar tu especialización de botín a: Especialización actual (%s)",
-- warn --
			WRN_SPEC_LOOT_CURRENT = "|cnYELLOW_FONT_COLOR:Especialización de botín establecida en: Especialización actual (%s)|r",
		},
		ptBR = {
-- tip --
			TIP_SPEC_LOOT_BUTTON = " para mudar sua especialização de saque para: Especialização %s!",
			TIP_SPEC_LOOT_CURRENT = " para mudar sua especialização de saque para: Especialização atual (%s)",
-- warn --
			WRN_SPEC_LOOT_CURRENT = "|cnYELLOW_FONT_COLOR:Especialização de saque definida para: Especialização atual (%s)|r",
		},
		itIT = {
-- tip --
			TIP_SPEC_LOOT_BUTTON = "  per cambiare la specializzazione del bottino in: Specializzazione %s!",
			TIP_SPEC_LOOT_CURRENT = " per cambiare la specializzazione del bottino in: Specializzazione attuale (%s)",
-- warn --
			WRN_SPEC_LOOT_CURRENT = "|cnYELLOW_FONT_COLOR:Specializzazione del bottino impostata su: Specializzazione attuale (%s)|r",
		},
		ruRU = base,
		zhCN = base,
		zhTW = base,
		koKR = base,
	}
-- function --
	local loc = GetLocale()
	local ov = o[loc]
	if type(ov) == "string" then ov = o[ov] end
	if ov then
		for k, v in pairs(ov) do base[k] = v end
	end
	return base
end)()
-- function for creating buttons --
local function CreateButtons()
-- Function for stoping the movement --
	local function StopMoving(self, i)
		FMCsettings["LootButtons"]["Button"..i]["Position"]["X"] = Round(self:GetLeft())
		FMCsettings["LootButtons"]["Button"..i]["Position"]["Y"] = Round(self:GetBottom())
		self:StopMovingOrSizing()
	end
-- creating button --
	for i = 1, (GetNumSpecializations() + 1), 1 do
		local btn = CreateFrame("Button", "fmcButtonLoot"..i, UIParent, "fmcButtonLoot")
		_G["fmcButtonLoot"..i]:ClearAllPoints()
		_G["fmcButtonLoot"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", FMCsettings["LootButtons"]["Button"..i]["Position"]["X"], FMCsettings["LootButtons"]["Button"..i]["Position"]["Y"])
		_G["fmcButtonLoot"..i]:SetSize(FMCsettings["LootButtons"]["Size"], FMCsettings["LootButtons"]["Size"])
		_G["fmcButtonLoot"..i].Border:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		_G["fmcButtonLoot"..i]:Show()
		_G["fmcButtonLoot"..i]:SetScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
		if i == 1 then
			_G["fmcButtonLoot"..i]:SetScript("OnEnter", function (self)
				VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..string.format(L.TIP_SPEC_LOOT_CURRENT, select(2, GetSpecializationInfo(GetSpecialization()))).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Top")
			end)
			_G["fmcButtonLoot"..i]:HookScript("OnClick", function (self, button, down)
				if button == "LeftButton" and down == false then
					SetLootSpecialization(0)
					DEFAULT_CHAT_FRAME:AddMessage(string.format(L.WRN_SPEC_LOOT_CURRENT, select(2, GetSpecializationInfo(GetSpecialization()))))
					PlaySound(841, "Master")
				end
			end)
		else
			_G["fmcButtonLoot"..i]:SetScript("OnEnter", function (self)
				VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..string.format(L.TIP_SPEC_LOOT_BUTTON, VDW.FMC["specName"..i-1]).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Top")
			end)
			_G["fmcButtonLoot"..i].Background:SetTexture(VDW.FMC["specIcon"..i-1])
			_G["fmcButtonLoot"..i]:HookScript("OnClick", function (self, button, down)
				if button == "LeftButton" and down == false then
					SetLootSpecialization(VDW.FMC["specId"..i-1])
					PlaySound(841, "Master")
				end
			end)
		end
-- Moving the buttons --
		_G["fmcButtonLoot"..i]:RegisterForDrag("RightButton")
		_G["fmcButtonLoot"..i]:SetScript("OnDragStart", _G["fmcButtonLoot"..i].StartMoving)
		_G["fmcButtonLoot"..i]:SetScript("OnDragStop", function(self) StopMoving(self, i) end)
	end
end
-- function check the loot specialization 2 specs --
local function CheckLootSpec2()
	if GetLootSpecialization() == 0 then
		fmcButtonLoot1.Background:SetDesaturated(false)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(true)
	elseif GetLootSpecialization() == VDW.FMC.specId1 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(false)
		fmcButtonLoot3.Background:SetDesaturated(true)
	elseif GetLootSpecialization() == VDW.FMC.specId2 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(false)
	end
end
-- function check the loot specialization 3 specs --
local function CheckLootSpec3()
	if GetLootSpecialization() == 0 then
		fmcButtonLoot1.Background:SetDesaturated(false)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(true)
	elseif GetLootSpecialization() == VDW.FMC.specId1 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(false)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(true)
	elseif GetLootSpecialization() == VDW.FMC.specId2 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(false)
		fmcButtonLoot4.Background:SetDesaturated(true)
	elseif GetLootSpecialization() == VDW.FMC.specId3 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(false)
	end
end
-- function check the loot specialization 4 specs --
local function CheckLootSpec4()
	if GetLootSpecialization() == 0 then
		fmcButtonLoot1.Background:SetDesaturated(false)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(true)
		fmcButtonLoot5.Background:SetDesaturated(true)
	elseif GetLootSpecialization() == VDW.FMC.specId1 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(false)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(true)
		fmcButtonLoot5.Background:SetDesaturated(true)
	elseif GetLootSpecialization() == VDW.FMC.specId2 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(false)
		fmcButtonLoot4.Background:SetDesaturated(true)
		fmcButtonLoot5.Background:SetDesaturated(true)
	elseif GetLootSpecialization() == VDW.FMC.specId3 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(false)
		fmcButtonLoot5.Background:SetDesaturated(true)
	elseif GetLootSpecialization() == VDW.FMC.specId4 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(true)
		fmcButtonLoot5.Background:SetDesaturated(false)
	end
end
-- Events Time --
local function EventsTime(self, event, arg1, arg2, arg3, arg4)
	if event == "PLAYER_LOGIN" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings["LootButtons"]["Visible"] then
				CreateButtons()
				if GetNumSpecializations() == 2 then
					CheckLootSpec2()
				elseif GetNumSpecializations() == 3 then
					CheckLootSpec3()
				elseif GetNumSpecializations() == 4 then
					CheckLootSpec4()
				end
			end
		end
	elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCdata.FirstSpec then
				CreateButtons()
				if GetNumSpecializations() == 2 then
					CheckLootSpec2()
				elseif GetNumSpecializations() == 3 then
					CheckLootSpec3()
				elseif GetNumSpecializations() == 4 then
					CheckLootSpec4()
				end
			end
		end
	elseif event == "PLAYER_LOOT_SPEC_UPDATED" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings["LootButtons"]["Visible"] then
				if GetNumSpecializations() == 2 then
					CheckLootSpec2()
				elseif GetNumSpecializations() == 3 then
					CheckLootSpec3()
				elseif GetNumSpecializations() == 4 then
					CheckLootSpec4()
				end
			end
		end
	end
end
fmcZlave:HookScript("OnEvent", EventsTime)
