local G = VDW.Local.Override
local C = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
local prefixChat = VDW.PrefixChat("FMC")
local fmcOverlayCastbar = false
local maxW = 160
local finalW = 0
local counter = 0
-- local-only strings for THIS file --
local L = (function()
	local base = {
-- tip --
		TIP_TALENTS_BUTTON = " to choose a talent loadout.|n|n",
	}
-- override --
	local o = {
		frFR = {
-- tip --
			TIP_TALENTS_BUTTON = " pour choisir une configuration de talents.|n|n",
		},
		deDE = {
-- tip --
			TIP_TALENTS_BUTTON =" um eine Talentvorlage auszuwaehlen.|n|n",
		},
		esES = {
-- tip --
			TIP_TALENTS_BUTTON = " para elegir una configuracion de talentos.|n|n",
		},
		esMX = {
-- tip --
			TIP_TALENTS_BUTTON = " para elegir una configuracion de talentos.|n|n",
		},
		ptBR = {
-- tip --
			TIP_TALENTS_BUTTON =" para escolher uma configuracao de talentos.|n|n",
		},
		itIT = {
-- tip --
			TIP_TALENTS_BUTTON = " per scegliere una configurazione di talenti.|n|n",
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
-- protect the options --
local function ProtectOptions()
	local loc = GetLocale()
	if loc ~= FMCsettings["LastLocation"] then
		for k, v in pairs(VDW.Local.Translate) do
			for i, s in pairs (v) do
				if FMCsettings["TalentButtons"]["Direction"] == s then
					FMCsettings["TalentButtons"]["Direction"] = VDW.Local.Translate[loc][i]
				end
				if FMCsettings["Animation"]["Style"] == s then
					FMCsettings["Animation"]["Style"] = VDW.Local.Translate[loc][i]
				end
				if FMCsettings["Animation"]["Background"] == s then
					FMCsettings["Animation"]["Background"] = VDW.Local.Translate[loc][i]
				end
			end
		end
	end
end
-- function for creating Talents Button --
local function CreateButtons()
-- Function for stoping the movement --
	local function StopMoving(self, i)
		FMCsettings["TalentButtons"]["Position"]["X"] = Round(self:GetLeft())
		FMCsettings["TalentButtons"]["Position"]["Y"] = Round(self:GetBottom())
		self:StopMovingOrSizing()
	end
-- creating button --
	for i = 1, GetNumSpecializations(), 1 do
		FMCdata["TalentButtons"]["LastConfig"]["spec"..i]["specID"] = VDW.FMC["specId"..i]
		FMCdata["TalentLayouts"][VDW.FMC["specId"..i]] = {}
		local btn = CreateFrame("Button", "fmcPopOutTalents"..i, UIParent, "vdwPopOut")
		_G["fmcPopOutTalents"..i]:ClearAllPoints()
		_G["fmcPopOutTalents"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", FMCsettings["TalentButtons"]["Position"]["X"], FMCsettings["TalentButtons"]["Position"]["Y"])
		_G["fmcPopOutTalents"..i].NormalTexture:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		_G["fmcPopOutTalents"..i].PushedTexture:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		_G["fmcPopOutTalents"..i].HighlightTexture:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		_G["fmcPopOutTalents"..i]:Show()
		for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(VDW.FMC["specId"..i])) do
			for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
				if sk == "name" then
					counter = counter + 1
					local btn = CreateFrame("Button", "fmcPopOutTalents"..i.."Button"..fk, nil, "vdwPopOutButton")
					_G["fmcPopOutTalents"..i.."Button"..fk]:ClearAllPoints()
					if fk == 1 then
						_G["fmcPopOutTalents"..i.."Button"..fk]:SetParent(_G["fmcPopOutTalents"..i])
						if FMCsettings["TalentButtons"]["Direction"] == G.OPTIONS_D_UPWARD then
							_G["fmcPopOutTalents"..i].NormalTexture:SetRotation(math.pi)
							_G["fmcPopOutTalents"..i].HighlightTexture:SetRotation(math.pi)
							_G["fmcPopOutTalents"..i.."Button"..fk]:SetPoint("BOTTOM", "fmcPopOutTalents"..i, "TOP", 0, 0)
						elseif FMCsettings["TalentButtons"]["Direction"] == G.OPTIONS_D_DOWNWARD then
							_G["fmcPopOutTalents"..i.."Button"..fk]:SetPoint("TOP", "fmcPopOutTalents"..i, "BOTTOM", 0, 0)
						end
						_G["fmcPopOutTalents"..i.."Button"..fk]:SetScript("OnShow", function(self)
							self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
							PlaySound(855, "Master")
						end)
						_G["fmcPopOutTalents"..i.."Button"..fk]:SetScript("OnHide", function(self)
							self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
							PlaySound(855, "Master")
						end)
					else
						if FMCsettings["TalentButtons"]["Direction"] == G.OPTIONS_D_UPWARD then
							_G["fmcPopOutTalents"..i.."Button"..fk]:SetParent(_G["fmcPopOutTalents"..i.."Button1"])
							_G["fmcPopOutTalents"..i.."Button"..fk]:SetPoint("BOTTOM", _G["fmcPopOutTalents"..i.."Button"..fk-1], "TOP", 0, 0)
						elseif FMCsettings["TalentButtons"]["Direction"] == G.OPTIONS_D_DOWNWARD then
							_G["fmcPopOutTalents"..i.."Button"..fk]:SetParent(_G["fmcPopOutTalents"..i.."Button1"])
							_G["fmcPopOutTalents"..i.."Button"..fk]:SetPoint("TOP", _G["fmcPopOutTalents"..i.."Button"..fk-1], "BOTTOM", 0, 0)
						end
						_G["fmcPopOutTalents"..i.."Button"..fk]:Show()
					end
					_G["fmcPopOutTalents"..i.."Button"..fk].Text:SetText(fk..". "..sv)
					_G["fmcPopOutTalents"..i.."Button"..fk]:SetScript("OnClick", function(self, button, down)
						if button == "LeftButton" and down == false then
							if not IsPlayerMoving() then
								C_ClassTalents.LoadConfig(fv, true)
								FMCdata["TalentButtons"]["LastConfig"]["spec"..i]["talentID"] = fv
								if PlayerSpellsFrame ~= nil then PlayerSpellsFrame.TalentsFrame.commitedConfigID = FMCdata["TalentButtons"]["LastConfig"]["spec"..i]["talentID"] end
								_G["fmcPopOutTalents"..i.."Button1"]:Hide()
							else
								DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..G.WRN_MOVING))
								_G["fmcPopOutTalents"..i.."Button1"]:Hide()
							end
						end
					end)
					table.insert(FMCdata["TalentLayouts"][VDW.FMC["specId"..i]], sv)
					local w = _G["fmcPopOutTalents"..i.."Button"..fk].Text:GetStringWidth()
					if w > maxW then maxW = w end
				end
			end
		end
		finalW = math.ceil(maxW + 24)
		for k = 1, counter, 1 do
			_G["fmcPopOutTalents"..i.."Button"..k]:SetWidth(finalW)
		end
		counter = 0
		maxW = 160
		_G["fmcPopOutTalents"..i]:HookScript("OnClick", function(self, button, down)
			if button == "LeftButton" and down == false then
				if not _G["fmcPopOutTalents"..i.."Button1"]:IsShown() then
					_G["fmcPopOutTalents"..i.."Button1"]:Show()
				else
					_G["fmcPopOutTalents"..i.."Button1"]:Hide()
				end
			end
		end)
		_G["fmcPopOutTalents"..i]:HookScript("OnEnter", function (self)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_TALENTS_BUTTON..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Right")
		end)
		_G["fmcPopOutTalents"..i]:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- Moving the buttons --
		_G["fmcPopOutTalents"..i]:SetMovable(true)
		_G["fmcPopOutTalents"..i]:RegisterForDrag("RightButton")
		_G["fmcPopOutTalents"..i]:SetScript("OnDragStart", _G["fmcPopOutTalents"..i].StartMoving)
		_G["fmcPopOutTalents"..i]:SetScript("OnDragStop", function(self) StopMoving(self, i) end)
	end
end
-- show & hide talent pop out 2 specs --
local function ShowHideTalentsPopOut2()
	for i = 1, GetNumSpecializations(), 1 do
		_G["fmcPopOutTalents"..i]:ClearAllPoints()
		_G["fmcPopOutTalents"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", FMCsettings["TalentButtons"]["Position"]["X"], FMCsettings["TalentButtons"]["Position"]["Y"])
	end
	if GetSpecialization() == 1 then
		fmcPopOutTalents1:Show()
		fmcPopOutTalents2:Hide()
		fmcPopOutTalents3:Hide()
	elseif GetSpecialization() == 2 then
		fmcPopOutTalents1:Hide()
		fmcPopOutTalents2:Show()
		fmcPopOutTalents3:Hide()
	end
end
-- show & hide talent pop out 3 specs --
local function ShowHideTalentsPopOut3()
	for i = 1, GetNumSpecializations(), 1 do
		_G["fmcPopOutTalents"..i]:ClearAllPoints()
		_G["fmcPopOutTalents"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", FMCsettings["TalentButtons"]["Position"]["X"], FMCsettings["TalentButtons"]["Position"]["Y"])
	end
	if GetSpecialization() == 1 then
		fmcPopOutTalents1:Show()
		fmcPopOutTalents2:Hide()
		fmcPopOutTalents3:Hide()
	elseif GetSpecialization() == 2 then
		fmcPopOutTalents1:Hide()
		fmcPopOutTalents2:Show()
		fmcPopOutTalents3:Hide()
	elseif GetSpecialization() == 3 then
		fmcPopOutTalents1:Hide()
		fmcPopOutTalents2:Hide()
		fmcPopOutTalents3:Show()
	end
end
-- show & hide talent pop out 4 specs --
local function ShowHideTalentsPopOut4()
	for i = 1, GetNumSpecializations(), 1 do
		_G["fmcPopOutTalents"..i]:ClearAllPoints()
		_G["fmcPopOutTalents"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", FMCsettings["TalentButtons"]["Position"]["X"], FMCsettings["TalentButtons"]["Position"]["Y"])
	end
	if GetSpecialization() == 1 then
		fmcPopOutTalents1:Show()
		fmcPopOutTalents2:Hide()
		fmcPopOutTalents3:Hide()
		fmcPopOutTalents4:Hide()
	elseif GetSpecialization() == 2 then
		fmcPopOutTalents1:Hide()
		fmcPopOutTalents2:Show()
		fmcPopOutTalents3:Hide()
		fmcPopOutTalents4:Hide()
	elseif GetSpecialization() == 3 then
		fmcPopOutTalents1:Hide()
		fmcPopOutTalents2:Hide()
		fmcPopOutTalents3:Show()
		fmcPopOutTalents4:Hide()
	elseif GetSpecialization() == 4 then
		fmcPopOutTalents1:Hide()
		fmcPopOutTalents2:Hide()
		fmcPopOutTalents3:Hide()
		fmcPopOutTalents4:Show()
	end
end
-- function for updating the config ID 2 specs --
local function UpdateConfigID2()
	if GetSpecialization() == 1 then
		if fmcOverlayCastbar then
			FMCdata["TalentButtons"]["LastConfig"]["spec1"]["talentID"] = PlayerSpellsFrame.TalentsFrame.LoadSystem.lastValidSelectionID
			fmcOverlayCastbar = false
		end
		if FMCdata["TalentButtons"]["LastConfig"]["spec1"]["talentID"] ~= 0 then
			C_ClassTalents.UpdateLastSelectedSavedConfigID(FMCdata["TalentButtons"]["LastConfig"]["spec1"]["specID"], FMCdata["TalentButtons"]["LastConfig"]["spec1"]["talentID"])
		end
	elseif GetSpecialization() == 2 then
		if fmcOverlayCastbar then
			FMCdata["TalentButtons"]["LastConfig"]["spec2"]["talentID"] = PlayerSpellsFrame.TalentsFrame.LoadSystem.lastValidSelectionID
			fmcOverlayCastbar = false
		end
		if FMCdata["TalentButtons"]["LastConfig"]["spec2"]["talentID"] ~= 0 then
			C_ClassTalents.UpdateLastSelectedSavedConfigID(FMCdata["TalentButtons"]["LastConfig"]["spec2"]["specID"], FMCdata["TalentButtons"]["LastConfig"]["spec2"]["talentID"])
		end
	end
end
-- function for updating the config ID 3 specs --
local function UpdateConfigID3()
	if GetSpecialization() == 1 then
		if fmcOverlayCastbar then
			FMCdata["TalentButtons"]["LastConfig"]["spec1"]["talentID"] = PlayerSpellsFrame.TalentsFrame.LoadSystem.lastValidSelectionID
			fmcOverlayCastbar = false
		end
		if FMCdata["TalentButtons"]["LastConfig"]["spec1"]["talentID"] ~= 0 then
			C_ClassTalents.UpdateLastSelectedSavedConfigID(FMCdata["TalentButtons"]["LastConfig"]["spec1"]["specID"], FMCdata["TalentButtons"]["LastConfig"]["spec1"]["talentID"])
		end
	elseif GetSpecialization() == 2 then
		if fmcOverlayCastbar then
			FMCdata["TalentButtons"]["LastConfig"]["spec2"]["talentID"] = PlayerSpellsFrame.TalentsFrame.LoadSystem.lastValidSelectionID
			fmcOverlayCastbar = false
		end
		if FMCdata["TalentButtons"]["LastConfig"]["spec2"]["talentID"] ~= 0 then
			C_ClassTalents.UpdateLastSelectedSavedConfigID(FMCdata["TalentButtons"]["LastConfig"]["spec2"]["specID"], FMCdata["TalentButtons"]["LastConfig"]["spec2"]["talentID"])
		end
	elseif GetSpecialization() == 3 then
		if fmcOverlayCastbar then
			FMCdata["TalentButtons"]["LastConfig"]["spec3"]["talentID"] = PlayerSpellsFrame.TalentsFrame.LoadSystem.lastValidSelectionID
			fmcOverlayCastbar = false
		end
		if FMCdata["TalentButtons"]["LastConfig"]["spec3"]["talentID"] ~= 0 then
			C_ClassTalents.UpdateLastSelectedSavedConfigID(FMCdata["TalentButtons"]["LastConfig"]["spec3"]["specID"], FMCdata["TalentButtons"]["LastConfig"]["spec3"]["talentID"])
		end
	end
end
-- function for updating the config ID 4 specs --
local function UpdateConfigID4()
	if GetSpecialization() == 1 then
		if fmcOverlayCastbar then
			FMCdata["TalentButtons"]["LastConfig"]["spec1"]["talentID"] = PlayerSpellsFrame.TalentsFrame.LoadSystem.lastValidSelectionID
			fmcOverlayCastbar = false
		end
		if FMCdata["TalentButtons"]["LastConfig"]["spec1"]["talentID"] ~= 0 then
			C_ClassTalents.UpdateLastSelectedSavedConfigID(FMCdata["TalentButtons"]["LastConfig"]["spec1"]["specID"], FMCdata["TalentButtons"]["LastConfig"]["spec1"]["talentID"])
		end
	elseif GetSpecialization() == 2 then
		if fmcOverlayCastbar then
			FMCdata["TalentButtons"]["LastConfig"]["spec2"]["talentID"] = PlayerSpellsFrame.TalentsFrame.LoadSystem.lastValidSelectionID
			fmcOverlayCastbar = false
		end
		if FMCdata["TalentButtons"]["LastConfig"]["spec2"]["talentID"] ~= 0 then
			C_ClassTalents.UpdateLastSelectedSavedConfigID(FMCdata["TalentButtons"]["LastConfig"]["spec2"]["specID"], FMCdata["TalentButtons"]["LastConfig"]["spec2"]["talentID"])
		end
	elseif GetSpecialization() == 3 then
		if fmcOverlayCastbar then
			FMCdata["TalentButtons"]["LastConfig"]["spec3"]["talentID"] = PlayerSpellsFrame.TalentsFrame.LoadSystem.lastValidSelectionID
			fmcOverlayCastbar = false
		end
		if FMCdata["TalentButtons"]["LastConfig"]["spec3"]["talentID"] ~= 0 then
			C_ClassTalents.UpdateLastSelectedSavedConfigID(FMCdata["TalentButtons"]["LastConfig"]["spec3"]["specID"], FMCdata["TalentButtons"]["LastConfig"]["spec3"]["talentID"])
		end
	elseif GetSpecialization() == 4 then
		if fmcOverlayCastbar then
			FMCdata["TalentButtons"]["LastConfig"]["spec4"]["talentID"] = PlayerSpellsFrame.TalentsFrame.LoadSystem.lastValidSelectionID
			fmcOverlayCastbar = false
		end
		if FMCdata["TalentButtons"]["LastConfig"]["spec3"]["talentID"] ~= 0 then
			C_ClassTalents.UpdateLastSelectedSavedConfigID(FMCdata["TalentButtons"]["LastConfig"]["spec4"]["specID"], FMCdata["TalentButtons"]["LastConfig"]["spec4"]["talentID"])
		end
	end
end
-- function checking talents button and equipment 2 specs--
local function CheckTalentsEquipment2()
	if GetSpecialization() == 1 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(VDW.FMC.specId1)
		if chkTalentID == nil then
			fmcPopOutTalents1.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(VDW.FMC.specId1)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents1.Text:SetText(fk..". "..sv)
						for tk, tv in pairs (FMCdata.TalentBindEquipment[VDW.FMC.specId1]) do
							if tk == sv then
								local _, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(tv) 
								if not isEquipped then C_EquipmentSet.UseEquipmentSet(tv) end
							end
						end
					end
				end
			end
		end
	elseif GetSpecialization() == 2 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(VDW.FMC.specId2)
		if chkTalentID == nil then
			fmcPopOutTalents2.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(VDW.FMC.specId2)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents2.Text:SetText(fk..". "..sv)
						for tk, tv in pairs (FMCdata.TalentBindEquipment[VDW.FMC.specId2]) do
							if tk == sv then
								local _, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(tv) 
								if not isEquipped then C_EquipmentSet.UseEquipmentSet(tv) end
							end
						end
					end
				end
			end
		end
	end
end
-- function checking talents button and equipment 3 specs--
local function CheckTalentsEquipment3()
	if GetSpecialization() == 1 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(VDW.FMC.specId1)
		if chkTalentID == nil then
			fmcPopOutTalents1.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(VDW.FMC.specId1)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents1.Text:SetText(fk..". "..sv)
						for tk, tv in pairs (FMCdata.TalentBindEquipment[VDW.FMC.specId1]) do
							if tk == sv then
								local _, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(tv) 
								if not isEquipped then C_EquipmentSet.UseEquipmentSet(tv) end
							end
						end
					end
				end
			end
		end
	elseif GetSpecialization() == 2 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(VDW.FMC.specId2)
		if chkTalentID == nil then
			fmcPopOutTalents2.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(VDW.FMC.specId2)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents2.Text:SetText(fk..". "..sv)
						for tk, tv in pairs (FMCdata.TalentBindEquipment[VDW.FMC.specId2]) do
							if tk == sv then
								local _, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(tv) 
								if not isEquipped then C_EquipmentSet.UseEquipmentSet(tv) end
							end
						end
					end
				end
			end
		end
	elseif GetSpecialization() == 3 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(VDW.FMC.specId3)
		if chkTalentID == nil then
			fmcPopOutTalents3.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(VDW.FMC.specId3)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents3.Text:SetText(fk..". "..sv)
						for tk, tv in pairs (FMCdata.TalentBindEquipment[VDW.FMC.specId3]) do
							if tk == sv then
								local _, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(tv) 
								if not isEquipped then C_EquipmentSet.UseEquipmentSet(tv) end
							end
						end
					end
				end
			end
		end
	end
end
-- function checking talents button and equipment 4 specs--
local function CheckTalentsEquipment4()
	if GetSpecialization() == 1 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(VDW.FMC.specId1)
		if chkTalentID == nil then
			fmcPopOutTalents1.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(VDW.FMC.specId1)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents1.Text:SetText(fk..". "..sv)
						for tk, tv in pairs (FMCdata.TalentBindEquipment[VDW.FMC.specId1]) do
							if tk == sv then
								local _, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(tv) 
								if not isEquipped then C_EquipmentSet.UseEquipmentSet(tv) end
							end
						end
					end
				end
			end
		end
	elseif GetSpecialization() == 2 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(VDW.FMC.specId2)
		if chkTalentID == nil then
			fmcPopOutTalents2.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(VDW.FMC.specId2)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents2.Text:SetText(fk..". "..sv)
						for tk, tv in pairs (FMCdata.TalentBindEquipment[VDW.FMC.specId2]) do
							if tk == sv then
								local _, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(tv) 
								if not isEquipped then C_EquipmentSet.UseEquipmentSet(tv) end
							end
						end
					end
				end
			end
		end
	elseif GetSpecialization() == 3 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(VDW.FMC.specId3)
		if chkTalentID == nil then
			fmcPopOutTalents3.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(VDW.FMC.specId3)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents3.Text:SetText(fk..". "..sv)
						for tk, tv in pairs (FMCdata.TalentBindEquipment[VDW.FMC.specId3]) do
							if tk == sv then
								local _, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(tv) 
								if not isEquipped then C_EquipmentSet.UseEquipmentSet(tv) end
							end
						end
					end
				end
			end
		end
	elseif GetSpecialization() == 4 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(VDW.FMC.specId4)
		if chkTalentID == nil then
			fmcPopOutTalents4.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(VDW.FMC.specId4)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents4.Text:SetText(fk..". "..sv)
						for tk, tv in pairs (FMCdata.TalentBindEquipment[VDW.FMC.specId4]) do
							if tk == sv then
								local _, _, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(tv) 
								if not isEquipped then C_EquipmentSet.UseEquipmentSet(tv) end
							end
						end
					end
				end
			end
		end
	end
end
-- equipment sets --
local function equipSets()
	FMCdata.EquipmentSets = {}
	for i = 0, C_EquipmentSet.GetNumEquipmentSets() - 1, 1 do
		local name, _, setID = C_EquipmentSet.GetEquipmentSetInfo(i)
		if name ~= nil then FMCdata.EquipmentSets[name] = setID end
	end
	if GetSpecialization() == 1 then
		for _, nameTalent in pairs(FMCdata.TalentLayouts[VDW.FMC.specId1]) do
			if FMCdata.TalentBindEquipment[VDW.FMC.specId1][nameTalent] then
				local name, _, setID = C_EquipmentSet.GetEquipmentSetInfo(FMCdata.TalentBindEquipment[VDW.FMC.specId1][nameTalent])
				if name == nil then FMCdata.TalentBindEquipment[VDW.FMC.specId1][nameTalent] = nil end
			end
		end
	elseif GetSpecialization() == 2 then
		for _, nameTalent in pairs(FMCdata.TalentLayouts[VDW.FMC.specId2]) do
			if FMCdata.TalentBindEquipment[VDW.FMC.specId2][nameTalent] then
				local name, _, setID = C_EquipmentSet.GetEquipmentSetInfo(FMCdata.TalentBindEquipment[VDW.FMC.specId2][nameTalent])
				if name == nil then FMCdata.TalentBindEquipment[VDW.FMC.specId2][nameTalent] = nil end
			end
		end
	elseif GetSpecialization() == 3 then
		for _, nameTalent in pairs(FMCdata.TalentLayouts[VDW.FMC.specId3]) do
			if FMCdata.TalentBindEquipment[VDW.FMC.specId3][nameTalent] then
				local name, _, setID = C_EquipmentSet.GetEquipmentSetInfo(FMCdata.TalentBindEquipment[VDW.FMC.specId3][nameTalent])
				if name == nil then FMCdata.TalentBindEquipment[VDW.FMC.specId3][nameTalent] = nil end
			end
		end
	elseif GetSpecialization() == 4 then
		for _, nameTalent in pairs(FMCdata.TalentLayouts[VDW.FMC.specId4]) do
			if FMCdata.TalentBindEquipment[VDW.FMC.specId4][nameTalent] then
				local name, _, setID = C_EquipmentSet.GetEquipmentSetInfo(FMCdata.TalentBindEquipment[VDW.FMC.specId4][nameTalent])
				if name == nil then FMCdata.TalentBindEquipment[VDW.FMC.specId4][nameTalent] = nil end
			end
		end
	end
end
-- animations --
-- function for the class banner --
local function ChoosingBackground(self)
	if VDW.PlayerClassID == 1 then --Warrior
		self:SetAtlas("talents-animations-class-warrior")
	elseif VDW.PlayerClassID == 2 then --Paladin
		self:SetAtlas("talents-animations-class-paladin")
	elseif VDW.PlayerClassID == 3 then --Hunter
		self:SetAtlas("talents-animations-class-hunter")
	elseif VDW.PlayerClassID == 4 then --Rogue
		self:SetAtlas("talents-animations-class-rogue")
	elseif VDW.PlayerClassID == 5 then --Priest
		self:SetAtlas("talents-animations-class-priest")
	elseif VDW.PlayerClassID == 6 then --Death Kight
		self:SetAtlas("talents-animations-class-deathknight")
	elseif VDW.PlayerClassID == 7 then --Shaman
		self:SetAtlas("talents-animations-class-shaman")
	elseif VDW.PlayerClassID == 8 then --Mage
		self:SetAtlas("talents-animations-class-mage")
	elseif VDW.PlayerClassID == 9 then --Warlock
		self:SetAtlas("talents-animations-class-warlock")
	elseif VDW.PlayerClassID == 10 then --Monk
		self:SetAtlas("talents-animations-class-monk")
	elseif VDW.PlayerClassID == 11 then --Druid
		self:SetAtlas("talents-animations-class-druid")
	elseif VDW.PlayerClassID == 12 then --Demon Hunter
		self:SetAtlas("talents-animations-class-demonhunter")
	elseif VDW.PlayerClassID == 13 then --Evoker
		self:SetAtlas("talents-animations-class-evoker")
	end
end
-- function for the position and bg of banner --
function VDW.FMC.AnimationSettings()
	if FMCsettings["Animation"]["Visible"] then
		if FMCsettings["Animation"]["Style"] == G.OPTIONS_S_BANNER then
			fmcFrameFX1:Show()
			fmcFrameFX2:Hide()
			if FMCsettings["Animation"]["AttachedToCastbar"] then
				fmcFrameFX1:ClearAllPoints()
				fmcFrameFX1:SetPoint("CENTER", PlayerCastingBarFrame, "CENTER", 0, 0)
			else
				fmcFrameFX1:ClearAllPoints()
				fmcFrameFX1:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", FMCsettings["Animation"]["Position"]["X"], FMCsettings["Animation"]["Position"]["Y"])
			end
			fmcFrameFX1:SetSize(FMCsettings["Animation"]["Size"]["W"], FMCsettings["Animation"]["Size"]["H"])
			if FMCsettings["Animation"]["Background"] == G.OPTIONS_C_CLASS then
				ChoosingBackground(fmcFrameFX1Background)
			end
		elseif FMCsettings["Animation"]["Style"] == G.OPTIONS_S_RUNES then
			fmcFrameFX1:Hide()
			fmcFrameFX2:Show()
		end
	else
		fmcFrameFX1:Hide()
		fmcFrameFX2:Hide()
	end
end
-- function for main animation --
local function PlayAnimation()
	if FMCsettings["Animation"]["Visible"] then
		if FMCsettings["Animation"]["Style"] == G.OPTIONS_S_BANNER then
			fmcFrameFX1.Animation.Main:SetDuration(PlayerCastingBarFrame.maxValue)
			fmcFrameFX1.Animation:Play()
		elseif FMCsettings["Animation"]["Style"] == G.OPTIONS_S_RUNES then
			fmcFrameFX2.Animation.Rune1b:SetDuration(PlayerCastingBarFrame.maxValue/5)
			fmcFrameFX2.Animation.Rune1:SetDuration(PlayerCastingBarFrame.maxValue/5)
			fmcFrameFX2.Animation.Rune2b:SetStartDelay(PlayerCastingBarFrame.maxValue/5)
			fmcFrameFX2.Animation.Rune2:SetStartDelay((PlayerCastingBarFrame.maxValue/5) + 0.15)
			fmcFrameFX2.Animation.Rune2:SetDuration(PlayerCastingBarFrame.maxValue/5)
			fmcFrameFX2.Animation.Rune3b:SetStartDelay((PlayerCastingBarFrame.maxValue/5)*2)
			fmcFrameFX2.Animation.Rune3:SetStartDelay(((PlayerCastingBarFrame.maxValue/5)*2) + 0.15)
			fmcFrameFX2.Animation.Rune3:SetDuration(PlayerCastingBarFrame.maxValue/5)
			fmcFrameFX2.Animation.Rune4b:SetStartDelay((PlayerCastingBarFrame.maxValue/5)*3)
			fmcFrameFX2.Animation.Rune4:SetStartDelay(((PlayerCastingBarFrame.maxValue/5)*3) + 0.15)
			fmcFrameFX2.Animation.Rune4:SetDuration(PlayerCastingBarFrame.maxValue/5)
			fmcFrameFX2.Animation.Rune5b:SetStartDelay((PlayerCastingBarFrame.maxValue/5)*4)
			fmcFrameFX2.Animation.Rune5:SetStartDelay(((PlayerCastingBarFrame.maxValue/5)*4) + 0.15)
			fmcFrameFX2.Animation.Rune5:SetDuration(PlayerCastingBarFrame.maxValue/5)
			fmcFrameFX2.Animation:Play()
		end
	end
end
-- Events Time --
local function EventsTime(self, event, arg1, arg2, arg3, arg4)
	if event == "PLAYER_LOGIN" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			--ProtectOptions()
			equipSets()
			VDW.FMC.AnimationSettings()
			if FMCsettings["TalentButtons"]["Visible"] then
				CreateButtons()
				if GetNumSpecializations() == 2 then
					ShowHideTalentsPopOut2()
					UpdateConfigID2()
					CheckTalentsEquipment2()
				elseif GetNumSpecializations() == 3 then
					ShowHideTalentsPopOut3()
					UpdateConfigID3()
					CheckTalentsEquipment3()
				elseif GetNumSpecializations() == 4 then
					ShowHideTalentsPopOut4()
					UpdateConfigID4()
					CheckTalentsEquipment4()
				end
			end
		end
	elseif event == "EQUIPMENT_SETS_CHANGED" then
		equipSets()
	elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			equipSets()
			if FMCdata.FirstSpec then
				CreateButtons()
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." Please select your talents and then restart (/reload) WoW, so the talents buttons will work properly. Read the instruction in the settings."))
				FMCdata.FirstSpec = false
			end
			if FMCsettings["TalentButtons"]["Visible"] then
				if GetNumSpecializations() == 2 then
					ShowHideTalentsPopOut2()
					UpdateConfigID2()
					CheckTalentsEquipment2()
				elseif GetNumSpecializations() == 3 then
					ShowHideTalentsPopOut3()
					UpdateConfigID3()
					CheckTalentsEquipment3()
				elseif GetNumSpecializations() == 4 then
					ShowHideTalentsPopOut4()
					UpdateConfigID4()
					CheckTalentsEquipment4()
				end
			end
		end
	elseif event == "UNIT_SPELLCAST_START" and arg1 == "player" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if arg3 == 384255 then
				if fmcOptions00 and fmcOptions00:IsShown() then fmcOptions00:Hide() end
				PlayAnimation()
				if OverlayPlayerCastingBarFrame.showCastbar then
					fmcOverlayCastbar = true
				end
			end
		end
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings["TalentButtons"]["Visible"] then
				if arg3 == 384255 then
					if GetNumSpecializations() == 2 then
						ShowHideTalentsPopOut2()
						UpdateConfigID2()
						CheckTalentsEquipment2()
					elseif GetNumSpecializations() == 3 then
						ShowHideTalentsPopOut3()
						UpdateConfigID3()
						CheckTalentsEquipment3()
					elseif GetNumSpecializations() == 4 then
						ShowHideTalentsPopOut4()
						UpdateConfigID4()
						CheckTalentsEquipment4()
					end
				end
			end
		end
	end
end
fmcZlave:HookScript("OnEvent", EventsTime)
