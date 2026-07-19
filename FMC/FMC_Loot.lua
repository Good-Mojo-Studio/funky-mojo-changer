-- some variables
local Color = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
-- create buttons
local function CreateButtons()
-- stoping the movement
	local function StopMoving(self, i)
		FMCsettings["LootButtons"]["Button"..i]["Position"]["X"] = Round(self:GetLeft())
		FMCsettings["LootButtons"]["Button"..i]["Position"]["Y"] = Round(self:GetBottom())
		self:StopMovingOrSizing()
	end
-- creating button
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
				VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..string.format(VDWtranslate.Global.LOOT_BUTTONS_TIP_CURRENT, select(2, GetSpecializationInfo(GetSpecialization()))).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
			end)
			_G["fmcButtonLoot"..i]:HookScript("OnClick", function (self, button, down)
				if button == "LeftButton" and down == false then
					SetLootSpecialization(0)
					DEFAULT_CHAT_FRAME:AddMessage(string.format(VDWtranslate.Global.LOOT_BUTTONS_WRN_CURRENT, select(2, GetSpecializationInfo(GetSpecialization()))))
					PlaySound(841, "Master")
				end
			end)
		else
			_G["fmcButtonLoot"..i]:SetScript("OnEnter", function (self)
				VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..string.format(VDWtranslate.Global.LOOT_BUTTONS_TIP, FMC["specName"..i-1]).."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main)
			end)
			_G["fmcButtonLoot"..i].Background:SetTexture(FMC["specIcon"..i-1])
			_G["fmcButtonLoot"..i]:HookScript("OnClick", function (self, button, down)
				if button == "LeftButton" and down == false then
					SetLootSpecialization(FMC["specId"..i-1])
					PlaySound(841, "Master")
				end
			end)
		end
-- moving the buttons
		_G["fmcButtonLoot"..i]:RegisterForDrag("RightButton")
		_G["fmcButtonLoot"..i]:SetScript("OnDragStart", _G["fmcButtonLoot"..i].StartMoving)
		_G["fmcButtonLoot"..i]:SetScript("OnDragStop", function(self) StopMoving(self, i) end)
	end
end
-- check loot specialization 3 specs
local function CheckLootSpec3()
	if GetLootSpecialization() == 0 then
		fmcButtonLoot1.Background:SetDesaturated(false)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(true)
		FMC.LootSpecName = "Current Specialization"
	elseif GetLootSpecialization() == FMC.specId1 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(false)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(true)
		FMC.LootSpecName = FMC.specName1
	elseif GetLootSpecialization() == FMC.specId2 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(false)
		fmcButtonLoot4.Background:SetDesaturated(true)
		FMC.LootSpecName = FMC.specName2
	elseif GetLootSpecialization() == FMC.specId3 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(false)
		FMC.LootSpecName = FMC.specName3
	end
end
-- check loot specialization 4 specs
local function CheckLootSpec4()
	if GetLootSpecialization() == 0 then
		fmcButtonLoot1.Background:SetDesaturated(false)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(true)
		fmcButtonLoot5.Background:SetDesaturated(true)
		FMC.LootSpecName = "Current Specialization"
	elseif GetLootSpecialization() == FMC.specId1 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(false)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(true)
		fmcButtonLoot5.Background:SetDesaturated(true)
		FMC.LootSpecName = FMC.specName1
	elseif GetLootSpecialization() == FMC.specId2 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(false)
		fmcButtonLoot4.Background:SetDesaturated(true)
		fmcButtonLoot5.Background:SetDesaturated(true)
		FMC.LootSpecName = FMC.specName2
	elseif GetLootSpecialization() == FMC.specId3 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(false)
		fmcButtonLoot5.Background:SetDesaturated(true)
		FMC.LootSpecName = FMC.specName3
	elseif GetLootSpecialization() == FMC.specId4 then
		fmcButtonLoot1.Background:SetDesaturated(true)
		fmcButtonLoot2.Background:SetDesaturated(true)
		fmcButtonLoot3.Background:SetDesaturated(true)
		fmcButtonLoot4.Background:SetDesaturated(true)
		fmcButtonLoot5.Background:SetDesaturated(false)
		FMC.LootSpecName = FMC.specName4
	end
end
-- events time
local function EventsTime(self, event, arg1, arg2, arg3, arg4)
	if event == "PLAYER_LOGIN" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings.LootButtons.Visible then
				CreateButtons()
				if GetNumSpecializations() == 3 then
					CheckLootSpec3()
				elseif GetNumSpecializations() == 4 then
					CheckLootSpec4()
				end
			end
		end
	elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings.LootButtons.Visible then
				if GetNumSpecializations() == 3 then
					CheckLootSpec3()
				elseif GetNumSpecializations() == 4 then
					CheckLootSpec4()
				end
			end
		end
	elseif event == "PLAYER_LOOT_SPEC_UPDATED" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings.LootButtons.Visible then
				if GetNumSpecializations() == 3 then
					CheckLootSpec3()
				elseif GetNumSpecializations() == 4 then
					CheckLootSpec4()
				end
			end
		end
	end
end
fmcZlave:HookScript("OnEvent", EventsTime)
