-- some variables --
local G = VDW.Local.Override
local C = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
-- local-only strings for THIS file --
local L = (function()
	local base = {
-- tip --
		TIP_SPEC_BUTTON = " to change into: ",
	}
-- override --
	local o = {
		frFR = {
-- tip --
			TIP_SPEC_BUTTON = " pour changer en : ",
		},
		deDE = {
-- tip --
			TIP_SPEC_BUTTON = " um zu wechseln zu: ",
		},
		esES = {
-- tip --
			TIP_SPEC_BUTTON = " para cambiar a: ",
		},
		esMX = {
-- tip --
			TIP_SPEC_BUTTON = " para cambiar a: ",
		},
		ptBR = {
-- tip --
			TIP_SPEC_BUTTON = " para mudar para: ",
		},
		itIT = {
-- tip --
			TIP_SPEC_BUTTON = " per cambiare in: ",
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
	if GetNumSpecializations() == 2 then
		local btn = CreateFrame("Button", "fmcButtonSpec1", UIParent, "fmcButtonSpec")
		fmcButtonSpec1:ClearAllPoints()
		fmcButtonSpec1:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", FMCsettings["SpecButtons"]["Button1"]["Position"]["X"], FMCsettings["SpecButtons"]["Button1"]["Position"]["Y"])
		fmcButtonSpec1:SetSize(FMCsettings["SpecButtons"]["Size"], FMCsettings["SpecButtons"]["Size"])
		fmcButtonSpec1.Border:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		fmcButtonSpec1Circle:SetSize(FMCsettings["SpecButtons"]["Size"]*3, FMCsettings["SpecButtons"]["Size"]*3)
		fmcButtonSpec1Circle:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		fmcButtonSpec1:Show()
		fmcButtonSpec1:HookScript("OnClick", function (self, button, down)
			if button == "LeftButton" and down == false then
				if GetSpecialization()== 1 then
					C_SpecializationInfo.SetSpecialization(2)
				else C_SpecializationInfo.SetSpecialization(1)
				end
				C_Timer.After(0.4, function()
					self.Animation.Wirls:SetDuration(PlayerCastingBarFrame.maxValue)
					self.Animation:Play()
				end)
				PlaySound(841, "Master")
			end
		end)
	elseif GetNumSpecializations() == 3 then
		for i = 1, 2, 1 do
			local btn = CreateFrame("Button", "fmcButtonSpec"..i, UIParent, "fmcButtonSpec")
			_G["fmcButtonSpec"..i]:ClearAllPoints()
			_G["fmcButtonSpec"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", FMCsettings["SpecButtons"]["Button"..i]["Position"]["X"], FMCsettings["SpecButtons"]["Button"..i]["Position"]["Y"])
			_G["fmcButtonSpec"..i]:SetSize(FMCsettings["SpecButtons"]["Size"], FMCsettings["SpecButtons"]["Size"])
			_G["fmcButtonSpec"..i].Border:SetVertexColor(VDW.PlayerClassColor:GetRGB())
			_G["fmcButtonSpec"..i.."Circle"]:SetSize(FMCsettings["SpecButtons"]["Size"]*3, FMCsettings["SpecButtons"]["Size"]*3)
			_G["fmcButtonSpec"..i.."Circle"]:SetVertexColor(VDW.PlayerClassColor:GetRGB())
			_G["fmcButtonSpec"..i]:Show()
			if i == 1 then
				_G["fmcButtonSpec"..i]:HookScript("OnClick", function (self, button, down)
					if button == "LeftButton" and down == false then
						if GetSpecialization() == 1 then
							C_SpecializationInfo.SetSpecialization(2)
						else
							C_SpecializationInfo.SetSpecialization(1)
						end
						C_Timer.After(0.4, function()
							self.Animation.Wirls:SetDuration(PlayerCastingBarFrame.maxValue)
							self.Animation:Play()
						end)
						PlaySound(841, "Master")
					end
				end)
			elseif i == 2 then
				_G["fmcButtonSpec"..i]:HookScript("OnClick", function (self, button, down)
					if button == "LeftButton" and down == false then
						if GetSpecialization() == 3 then
							C_SpecializationInfo.SetSpecialization(2)
						else
							C_SpecializationInfo.SetSpecialization(3)
						end
						C_Timer.After(0.4, function()
							self.Animation.Wirls:SetDuration(PlayerCastingBarFrame.maxValue)
							self.Animation:Play()
						end)
						PlaySound(841, "Master")
					end
				end)
			end
			end
	elseif GetNumSpecializations() == 4 then
		for i = 1, 3, 1 do
			local btn = CreateFrame("Button", "fmcButtonSpec"..i, UIParent, "fmcButtonSpec")
			_G["fmcButtonSpec"..i]:ClearAllPoints()
			_G["fmcButtonSpec"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", FMCsettings["SpecButtons"]["Button"..i]["Position"]["X"], FMCsettings["SpecButtons"]["Button"..i]["Position"]["Y"])
			_G["fmcButtonSpec"..i]:SetSize(FMCsettings["SpecButtons"]["Size"], FMCsettings["SpecButtons"]["Size"])
			_G["fmcButtonSpec"..i].Border:SetVertexColor(VDW.PlayerClassColor:GetRGB())
			_G["fmcButtonSpec"..i.."Circle"]:SetSize(FMCsettings["SpecButtons"]["Size"]*3, FMCsettings["SpecButtons"]["Size"]*3)
			_G["fmcButtonSpec"..i.."Circle"]:SetVertexColor(VDW.PlayerClassColor:GetRGB())
			_G["fmcButtonSpec"..i]:Show()
			if i == 1 then
				_G["fmcButtonSpec"..i]:HookScript("OnClick", function (self, button, down)
					if button == "LeftButton" and down == false then
						if GetSpecialization() == 1 then
							C_SpecializationInfo.SetSpecialization(2)
						else
							C_SpecializationInfo.SetSpecialization(1)
						end
						C_Timer.After(0.4, function()
							self.Animation.Wirls:SetDuration(PlayerCastingBarFrame.maxValue)
							self.Animation:Play()
						end)
						PlaySound(841, "Master")
					end
				end)
			elseif i == 2 then
				_G["fmcButtonSpec"..i]:HookScript("OnClick", function (self, button, down)
					if button == "LeftButton" and down == false then
						if GetSpecialization()== 1 or GetSpecialization() == 2 then
							C_SpecializationInfo.SetSpecialization(3)
						else
							C_SpecializationInfo.SetSpecialization(2)
						end
						C_Timer.After(0.4, function()
							self.Animation.Wirls:SetDuration(PlayerCastingBarFrame.maxValue)
							self.Animation:Play()
						end)
						PlaySound(841, "Master")
					end
				end)
			elseif i == 3 then
				_G["fmcButtonSpec"..i]:HookScript("OnClick", function (self, button, down)
					if button == "LeftButton" and down == false then
						if GetSpecialization() == 4 then
							C_SpecializationInfo.SetSpecialization(3)
						else
							C_SpecializationInfo.SetSpecialization(4)
						end
						C_Timer.After(0.4, function()
							self.Animation.Wirls:SetDuration(PlayerCastingBarFrame.maxValue)
							self.Animation:Play()
						end)
						PlaySound(841, "Master")
					end
				end)
			end
		end
	end
-- Moving the buttons --
	local function StopMoving(self, i)
		FMCsettings["SpecButtons"]["Button"..i]["Position"]["X"] = Round(self:GetLeft())
		FMCsettings["SpecButtons"]["Button"..i]["Position"]["Y"] = Round(self:GetBottom())
		self:StopMovingOrSizing()
	end
	for i = 1, (GetNumSpecializations() - 1), 1 do
		_G["fmcButtonSpec"..i]:RegisterForDrag("RightButton")
		_G["fmcButtonSpec"..i]:SetScript("OnDragStart", _G["fmcButtonSpec"..i].StartMoving)
		_G["fmcButtonSpec"..i]:SetScript("OnDragStop", function(self) StopMoving(self, i) end)
	end
end
-- function for button enter, leave, and click --
-- for 1 button --
local function Buttons1bgTool()
	fmcButtonSpec1:SetScript("OnLeave", function(self)
		VDW.Tooltip_Hide()
		self.Background:SetDesaturated(true)
	end)
	if GetSpecialization() == 1 then
		fmcButtonSpec1.Background:SetTexture(VDW.FMC.specIcon2)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName2)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole2)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
	elseif GetSpecialization() == 2 then
		fmcButtonSpec1.Background:SetTexture(VDW.FMC.specIcon1)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName1)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole1)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
	end
end
-- for 2 buttons --
local function Buttons2bgTool()
	for i = 1, 2, 1 do
		_G["fmcButtonSpec"..i]:SetScript("OnLeave", function(self)
			VDW.Tooltip_Hide()
			self.Background:SetDesaturated(true)
		end)
	end
	if GetSpecialization() == 1 then
		fmcButtonSpec1.Background:SetTexture(VDW.FMC.specIcon2)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName2)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole2)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
		fmcButtonSpec2.Background:SetTexture(VDW.FMC.specIcon3)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName3)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole3)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
	elseif GetSpecialization() == 2 then
		fmcButtonSpec1.Background:SetTexture(VDW.FMC.specIcon1)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName1)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole1)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
		fmcButtonSpec2.Background:SetTexture(VDW.FMC.specIcon3)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName3)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole3)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
	elseif GetSpecialization() == 3 then
		fmcButtonSpec1.Background:SetTexture(VDW.FMC.specIcon1)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName1)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole1)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
		fmcButtonSpec2.Background:SetTexture(VDW.FMC.specIcon2)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName2)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole2)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
	end
end
-- for 3 buttons --
local function Buttons3bgTool()
	for i = 1, 3, 1 do
		_G["fmcButtonSpec"..i]:SetScript("OnLeave", function(self)
			VDW.Tooltip_Hide()
			self.Background:SetDesaturated(true)
		end)
	end
	if GetSpecialization() == 1 then
		fmcButtonSpec1.Background:SetTexture(VDW.FMC.specIcon2)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName2)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole2)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
		fmcButtonSpec2.Background:SetTexture(VDW.FMC.specIcon3)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName3)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole3)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
		fmcButtonSpec3.Background:SetTexture(VDW.FMC.specIcon4)
		fmcButtonSpec3:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName4)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole4)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
	elseif GetSpecialization() == 2 then
		fmcButtonSpec1.Background:SetTexture(VDW.FMC.specIcon1)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName1)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole1)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
		fmcButtonSpec2.Background:SetTexture(VDW.FMC.specIcon3)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName3)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole3)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
		fmcButtonSpec3.Background:SetTexture(VDW.FMC.specIcon4)
		fmcButtonSpec3:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName4)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole4)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
	elseif GetSpecialization() == 3 then
		fmcButtonSpec1.Background:SetTexture(VDW.FMC.specIcon1)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName1)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole1)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
		fmcButtonSpec2.Background:SetTexture(VDW.FMC.specIcon2)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName2)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole2)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
		fmcButtonSpec3.Background:SetTexture(VDW.FMC.specIcon4)
		fmcButtonSpec3:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName4)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole4)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
	elseif GetSpecialization() == 4 then
		fmcButtonSpec1.Background:SetTexture(VDW.FMC.specIcon1)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName1)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole1)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
		fmcButtonSpec2.Background:SetTexture(VDW.FMC.specIcon2)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName2)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole2)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
		fmcButtonSpec3.Background:SetTexture(VDW.FMC.specIcon3)
		fmcButtonSpec3:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, G.BUTTON_L_CLICK..L.TIP_SPEC_BUTTON..C.High:WrapTextInColorCode(VDW.FMC.specName3)..", "..C.High:WrapTextInColorCode(string.lower(VDW.FMC.specRole3)).."|n|n"..G.BUTTON_R_CLICK..G.TIP_DRAG_ME, C.Main, "Bottom")
		end)
	end
end
-- Events Time --
local function EventsTime(self, event, arg1, arg2, arg3, arg4)
	if event == "PLAYER_LOGIN" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings["SpecButtons"]["Visible"] then
				CreateButtons()
				if GetNumSpecializations() == 2 then
					Buttons1bgTool()
				elseif GetNumSpecializations() == 3 then
					Buttons2bgTool()
				elseif GetNumSpecializations() == 4 then
					Buttons3bgTool()
				end
			end
		end
	elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if fmcOptions00 and fmcOptions00:IsShown() then fmcOptions00:Hide() end
			if FMCdata.FirstSpec then CreateButtons() end
			if FMCsettings["SpecButtons"]["Visible"] then
				if GetNumSpecializations() == 2 then
					Buttons1bgTool()
				elseif GetNumSpecializations() == 3 then
					Buttons2bgTool()
				elseif GetNumSpecializations() == 4 then
					Buttons3bgTool()
				end
			end
		end
	elseif event == "UNIT_SPELLCAST_INTERRUPTED" and arg1 == "player" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings["SpecButtons"]["Visible"] then
				if arg3 == 200749 then
					if GetNumSpecializations() == 2 then
						if fmcButtonSpec1.Animation:IsPlaying() then fmcButtonSpec1.Animation:Stop() end
					elseif GetNumSpecializations() == 3 then
						if fmcButtonSpec1.Animation:IsPlaying() then fmcButtonSpec1.Animation:Stop() end
						if fmcButtonSpec2.Animation:IsPlaying() then fmcButtonSpec2.Animation:Stop() end
					elseif GetNumSpecializations() == 4 then
						if fmcButtonSpec1.Animation:IsPlaying() then fmcButtonSpec1.Animation:Stop() end
						if fmcButtonSpec2.Animation:IsPlaying() then fmcButtonSpec2.Animation:Stop() end
						if fmcButtonSpec3.Animation:IsPlaying() then fmcButtonSpec3.Animation:Stop() end
					end
				end
			end
		end
	end
end
fmcZlave:HookScript("OnEvent", EventsTime)
