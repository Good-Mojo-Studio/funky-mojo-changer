-- some variables
local Color = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
local specButton = 0
local duration = 0
-- create buttons
local function CreateButtons()
	if GetNumSpecializations() == 3 then
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
						specButton = _G["fmcButtonSpec"..i]
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
						specButton = _G["fmcButtonSpec"..i]
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
						specButton = _G["fmcButtonSpec"..i]
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
						specButton = _G["fmcButtonSpec"..i]
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
						specButton = _G["fmcButtonSpec"..i]
						PlaySound(841, "Master")
					end
				end)
			end
		end
	end
-- moving the buttons
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
-- function for button enter, leave, and click
-- for 2 buttons
local function Buttons2bgTool()
	for i = 1, 2, 1 do
		_G["fmcButtonSpec"..i]:SetScript("OnLeave", function(self)
			VDW.Tooltip_Hide()
			self.Background:SetDesaturated(true)
		end)
	end
	if GetSpecialization() == 1 then
		FMC.SpecName = FMC.specName1
		fmcButtonSpec1.Background:SetTexture(FMC.specIcon2)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName2)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole2)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
		fmcButtonSpec2.Background:SetTexture(FMC.specIcon3)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName3)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole3)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
	elseif GetSpecialization() == 2 then
		FMC.SpecName = FMC.specName2
		fmcButtonSpec1.Background:SetTexture(FMC.specIcon1)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName1)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole1)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
		fmcButtonSpec2.Background:SetTexture(FMC.specIcon3)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName3)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole3)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
	elseif GetSpecialization() == 3 then
		FMC.SpecName = FMC.specName3
		fmcButtonSpec1.Background:SetTexture(FMC.specIcon1)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName1)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole1)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
		fmcButtonSpec2.Background:SetTexture(FMC.specIcon2)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName2)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole2)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
	end
end
-- for 3 buttons
local function Buttons3bgTool()
	for i = 1, 3, 1 do
		_G["fmcButtonSpec"..i]:SetScript("OnLeave", function(self)
			VDW.Tooltip_Hide()
			self.Background:SetDesaturated(true)
		end)
	end
	if GetSpecialization() == 1 then
		FMC.SpecName = FMC.specName1
		fmcButtonSpec1.Background:SetTexture(FMC.specIcon2)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName2)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole2)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
		fmcButtonSpec2.Background:SetTexture(FMC.specIcon3)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName3)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole3)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
		fmcButtonSpec3.Background:SetTexture(FMC.specIcon4)
		fmcButtonSpec3:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName4)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole4)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
	elseif GetSpecialization() == 2 then
		FMC.SpecName = FMC.specName2
		fmcButtonSpec1.Background:SetTexture(FMC.specIcon1)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName1)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole1)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
		fmcButtonSpec2.Background:SetTexture(FMC.specIcon3)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName3)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole3)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
		fmcButtonSpec3.Background:SetTexture(FMC.specIcon4)
		fmcButtonSpec3:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName4)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole4)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
	elseif GetSpecialization() == 3 then
		FMC.SpecName = FMC.specName3
		fmcButtonSpec1.Background:SetTexture(FMC.specIcon1)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName1)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole1)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
		fmcButtonSpec2.Background:SetTexture(FMC.specIcon2)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName2)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole2)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
		fmcButtonSpec3.Background:SetTexture(FMC.specIcon4)
		fmcButtonSpec3:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName4)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole4)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
	elseif GetSpecialization() == 4 then
		FMC.SpecName = FMC.specName4
		fmcButtonSpec1.Background:SetTexture(FMC.specIcon1)
		fmcButtonSpec1:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName1)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole1)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
		fmcButtonSpec2.Background:SetTexture(FMC.specIcon2)
		fmcButtonSpec2:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName2)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole2)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
		fmcButtonSpec3.Background:SetTexture(FMC.specIcon3)
		fmcButtonSpec3:SetScript("OnEnter", function (self)
			self.Background:SetDesaturated(false)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.SPECIALIZATION_BUTTONS_TIP.." "..Color.High:WrapTextInColorCode(FMC.specName3)..", "..Color.High:WrapTextInColorCode(string.lower(FMC.specRole3)).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
		end)
	end
end
-- events time
local function EventsTime(self, event, arg1, arg2, arg3, arg4)
	if event == "PLAYER_LOGIN" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings.SpecButtons.Visible then
				CreateButtons()
				if GetNumSpecializations() == 3 then
					Buttons2bgTool()
				elseif GetNumSpecializations() == 4 then
					Buttons3bgTool()
				end
			else
				FMC.SpecName = VDWtranslate.Global.SPECIALIZATION_BUTTONS_NOT_SHOWN
			end
		else
			FMC.SpecName = VDWtranslate.Global.SPECIALIZATION_BUTTONS_LOW_LVL
		end
	elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings.SpecButtons.Visible then
				if GetNumSpecializations() == 3 then
					Buttons2bgTool()
				elseif GetNumSpecializations() == 4 then
					Buttons3bgTool()
				end
			else
				FMC.SpecName = VDWtranslate.Global.SPECIALIZATION_BUTTONS_NOT_SHOWN
			end
		end
	elseif event == "UNIT_SPELLCAST_START" and arg1 == "player" and arg3 == 200749 then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings.SpecButtons.Visible then
				duration = UnitCastingDuration(arg1)
				specButton.Animation.Wirls:SetDuration(duration:GetTotalDuration(Enum.DurationTimeModifier.RealTime))
				specButton.Animation:Play()
			end
		end
	elseif event == "UNIT_SPELLCAST_INTERRUPTED" and arg1 == "player" and arg3 == 200749 then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings.SpecButtons.Visible then
				if GetNumSpecializations() == 3 then
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
fmcZlave:HookScript("OnEvent", EventsTime)
