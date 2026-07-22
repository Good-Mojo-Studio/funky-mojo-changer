-- some variables
local Color = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
local name = ""
local NameExist = false
local Keys = 0
local maxW = 160
local finalW = 0
local counter = 0
-- finding keys
for k, v in pairs(FMCprofiles) do
	Keys = Keys + 1
end
-- create panel
VDW.CreateOptionsPanel(fmcOptions.Panel4, VDW.Background.FMC, Color.Main, Color.High, 0, "FMC")
fmcOptions.Panel4.TopTxt:SetText(VDWtranslate.Global.P_TITLE)
fmcOptions.Panel4.Box1.Title:SetText(VDWtranslate.Global.P_SUB_CREATE)
fmcOptions.Panel4.Box2.Title:SetText(VDWtranslate.Global.P_SUB_LOAD)
fmcOptions.Panel4.Box3.Title:SetText(VDWtranslate.Global.P_SUB_DELETE)
fmcOptions.Panel4.Box4.Title:SetText(VDWtranslate.Global.IMPORTANT_NOTES)
for i = 1, 4, 1 do
	VDW.CreateOptionsBox(fmcOptions.Panel4, i, Color.Main, Color.High)
end
-- Box 1, EditBox 1, profile save
VDW.CreateEditBox(fmcOptions.Panel4, 1, 1, Color.High)
fmcOptions.Panel4.Box1.EditBox1.WritingLine:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.P_TIP_CREATE, Color.Main, "Left")
end)
-- pressing enter
fmcOptions.Panel4.Box1.EditBox1.WritingLine:SetScript("OnEnterPressed", function(self)
	if self:HasText() then
		EditBox_HighlightText(self)
		name = self:GetText()
		NameExist = false
		for k, v in pairs(FMCprofiles) do
			if k == name then NameExist = true end
			if NameExist then
				DEFAULT_CHAT_FRAME:AddMessage(Color.Main:WrapTextInColorCode(VDW.PrefixChat("FMC").." "..VDWtranslate.Global.P_WRN_EXIST))
				UIErrorsFrame:AddExternalWarningMessage(VDW.PrefixError("FMC").." "..VDWtranslate.Global.P_WRN_EXIST)
				return
			end
		end
		FMCprofiles[name] = {settings = FMCsettings}
		C_UI.Reload()
	else
		DEFAULT_CHAT_FRAME:AddMessage(Color.Main:WrapTextInColorCode(VDW.PrefixChat("FMC").." "..VDWtranslate.Global.P_WRN_NEED))
		UIErrorsFrame:AddExternalWarningMessage(VDW.PrefixError("FMC").." "..VDWtranslate.Global.P_WRN_NEED)
	end
end)
-- Box 2-3, PopOut 1, profile (load, delete)
for i = 2, 3, 1 do
	fmcOptions.Panel4["Box"..i].PopOut1.Text:SetText(VDWtranslate.Global.LEFT_CLICK)
	VDW.CreateOptionsPopOut(fmcOptions.Panel4, i, 1, Color.Main, Color.High)
	if i == 2 then
		fmcOptions.Panel4["Box"..i].PopOut1:HookScript("OnEnter", function(self)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.P_TIP_LOAD, Color.Main, "Left")
		end)
		fmcOptions.Panel4["Box"..i].PopOut1:HookScript("OnClick", function(self, button, down)
			if button == "LeftButton" and down == false then
				if fmcOptions.Panel4["Box"..i].PopOut1.Choice1 == nil then
					DEFAULT_CHAT_FRAME:AddMessage(Color.Main:WrapTextInColorCode(VDW.PrefixChat("FMC").." "..VDWtranslate.Global.P_WRN_LOAD))
					UIErrorsFrame:AddExternalWarningMessage(VDW.PrefixError("FMC").." "..VDWtranslate.Global.P_WRN_LOAD)
				end
			end
		end)
	else
		fmcOptions.Panel4["Box"..i].PopOut1:HookScript("OnEnter", function(self)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.P_TIP_DELETE, Color.Main, "Left")
		end)
		fmcOptions.Panel4["Box"..i].PopOut1:HookScript("OnClick", function(self, button, down)
			if button == "LeftButton" and down == false then
				if fmcOptions.Panel4["Box"..i].PopOut1.Choice1 == nil then
					DEFAULT_CHAT_FRAME:AddMessage(Color.Main:WrapTextInColorCode(VDW.PrefixChat("FMC").." "..VDWtranslate.Global.P_WRN_DELETE))
					UIErrorsFrame:AddExternalWarningMessage(VDW.PrefixError("FMC").." "..VDWtranslate.Global.P_WRN_DELETE)
				end
			end
		end)
	end
	if counter == 0 and Keys > 0 then
		for k, v in pairs(FMCprofiles) do
			counter = counter + 1
			VDW.CreateOptionsPopOutButtons(fmcOptions.Panel4, i, 1, counter, k, Color.Main)
			fmcOptions.Panel4["Box"..i].PopOut1["Choice"..counter].Text:SetText(k)
			fmcOptions.Panel4["Box"..i].PopOut1["Choice"..counter]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					if i == 2 then
						FMCsettings = FMCprofiles[k]["settings"]
						C_UI.Reload()
					else
						FMCprofiles[k] = nil
						C_UI.Reload()
					end
				end
			end)
			local w = fmcOptions.Panel4["Box"..i].PopOut1["Choice"..counter].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for c = 1, counter, 1 do
			fmcOptions.Panel4["Box"..i].PopOut1["Choice"..c]:SetWidth(finalW)
		end
		counter = 0
	end
end
-- Box 4, Notes
VDW.CreateImportantNotesProfiles("FMC", fmcOptions.Panel4, 4, Color.Main, Color.High)
-- Show the option panel
fmcOptions.Panel4:HookScript("OnShow", function(self)
	for i = 1, 3, 1 do
		fmcOptions["Tab"..i].Text:SetTextColor(0.4, 0.4, 0.4, 1)
		if fmcOptions["Panel"..i]:IsShown() then fmcOptions["Panel"..i]:Hide() end
	end
	fmcOptions.Tab4.Text:SetTextColor(Color.High:GetRGB())
end)
