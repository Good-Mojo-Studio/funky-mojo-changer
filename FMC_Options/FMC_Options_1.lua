-- some variables
local Color = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
-- create panel
VDW.CreateOptionsPanel(fmcOptions.Panel1, VDW.Background.FMC, Color.Main, Color.High, 0, "FMC")
fmcOptions.Panel1.TopTxt:SetText(string.format(VDWtranslate.Global.OPTIONS_FOR, VDWtranslate.Global.SPECIALIZATION_BUTTONS))
-- create box
fmcOptions.Panel1.Box1:SetHeight(128)
fmcOptions.Panel1.Box1.Title:SetText(VDWtranslate.Global.VISIBILITY.." - "..VDWtranslate.Global.SIZE)
fmcOptions.Panel1.Box2:SetPoint("TOPLEFT", fmcOptions.Panel1.Box1, "BOTTOMLEFT", 0, 0)
fmcOptions.Panel1.Box2.Title:SetText(VDWtranslate.Global.IMPORTANT_NOTES)
for i = 1, 2, 1 do
	VDW.CreateOptionsBox(fmcOptions.Panel1, i, Color.Main, Color.High)
end
-- Box 1, CheckButton 1, Visibility
fmcOptions.Panel1.Box1.CheckButton1.Text:SetText(VDWtranslate.Global.SPECIALIZATION_BUTTONS)
VDW.CreateCheckButton(fmcOptions.Panel1, 1, 1)
fmcOptions.Panel1.Box1.CheckButton1:SetScript("OnEnter", function(self)
	local word = self.Text:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(VDWtranslate.Global.CHECK_IF_YOU_WANT_TO_SHOW, word), Color.Main, "Left")
end)
fmcOptions.Panel1.Box1.CheckButton1:HookScript("OnClick", function (self, button, down)
	if button == "LeftButton" and down == false then
		if self:GetChecked() == true then
			FMCsettings.SpecButtons.Visible = true
			VDW.sliderEnable(fmcOptions.Panel1.Box1.Slider1)
			VDW.CheckButtonTick(self, Color.Main)
		elseif self:GetChecked() == false then
			FMCsettings.SpecButtons.Visible = false
			VDW.sliderDisable(fmcOptions.Panel1.Box1.Slider1)
			VDW.CheckButtonUnTick(self)
		end
		PlaySound(858, "Master")
		C_UI.Reload()
	end
end)
-- Box 1, Slider 1, Size
VDW.CreateOptionsSlider("FMC", fmcOptions.Panel1, 1, 1, 16, 80, 16, 80, Color.Main, Color.High)
fmcOptions.Panel1.Box1.Slider1.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	fmcOptions.Panel1.Box1.Slider1.TopText:SetText(VDWtranslate.Global.SIZE..": "..self:GetValue())
	FMCsettings.SpecButtons.Size = self:GetValue()
	for i = 1, (GetNumSpecializations() - 1), 1 do
		if _G["fmcButtonSpec"..i] then
			_G["fmcButtonSpec"..i]:SetSize(FMCsettings.SpecButtons.Size, FMCsettings.SpecButtons.Size)
			_G["fmcButtonSpec"..i.."Circle"]:SetSize(FMCsettings.SpecButtons.Size*3, FMCsettings.SpecButtons.Size*3)
		end
	end
	PlaySound(858, "Master")
end)
-- Box 2, Notes
VDW.CreateImportantNotes(fmcOptions.Panel1, 2, Color.Main)
fmcOptions.Panel1.Box2.Notes:SetText("|A:"..C_AddOns.GetAddOnMetadata("FMC", "IconAtlas")..":16:16|a"..Color.High:WrapTextInColorCode(VDWtranslate.Global.NOTE.." 1: ")..VDWtranslate.Global.NOTES_HIDE_SHOW_BUTTONS)
-- Checking the Saved Variables
local function CheckSavedVariables()
	if FMCsettings.SpecButtons.Visible then
		VDW.CheckButtonCheck(fmcOptions.Panel1, 1, 1, Color.Main)
		VDW.sliderEnable(fmcOptions.Panel1.Box1.Slider1)
	else
		VDW.CheckButtonUnCheck(fmcOptions.Panel1, 1, 1)
		VDW.sliderDisable(fmcOptions.Panel1.Box1.Slider1)
	end
	fmcOptions.Panel1.Box1.Slider1.Slider:SetValue(FMCsettings.SpecButtons.Size)
end
-- Show the option panel
fmcOptions.Panel1:HookScript("OnShow", function(self)
	fmcOptions.Tab1.Text:SetTextColor(Color.High:GetRGB())
	for i = 2, 4, 1 do
		fmcOptions["Tab"..i].Text:SetTextColor(0.4, 0.4, 0.4, 1)
		if fmcOptions["Panel"..i]:IsShown() then fmcOptions["Panel"..i]:Hide() end
	end
	CheckSavedVariables()
end)
VDW.CreateBackgroundTab(fmcOptions, "Panel1", "Tab1", VDW.Background.FMC, 0, Color.NoHigh, Color.High)
