-- some variables
local Color = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
-- create panel
VDW.CreateOptionsPanel(fmcOptions.Panel2, VDW.Background.FMC, Color.Main, Color.High, 0, "FMC")
fmcOptions.Panel2.TopTxt:SetText(string.format(VDWtranslate.Global.OPTIONS_FOR, VDWtranslate.Global.LOOT_BUTTONS))
-- create box
fmcOptions.Panel2.Box1:SetHeight(128)
fmcOptions.Panel2.Box1.Title:SetText(VDWtranslate.Global.VISIBILITY.." - "..VDWtranslate.Global.SIZE)
fmcOptions.Panel2.Box2:SetPoint("TOPLEFT", fmcOptions.Panel2.Box1, "BOTTOMLEFT", 0, 0)
fmcOptions.Panel2.Box2.Title:SetText(VDWtranslate.Global.IMPORTANT_NOTES)
for i = 1, 2, 1 do
	VDW.CreateOptionsBox(fmcOptions.Panel2, i, Color.Main, Color.High)
end
-- Box 1, CheckButton 1, visibility
VDW.CreateCheckButton(fmcOptions.Panel2, 1, 1)
fmcOptions.Panel2.Box1.CheckButton1.Text:SetText(VDWtranslate.Global.LOOT_BUTTONS)
fmcOptions.Panel2.Box1.CheckButton1:SetScript("OnEnter", function(self)
	local word = self.Text:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(VDWtranslate.Global.CHECK_IF_YOU_WANT_TO_SHOW, word), Color.Main, "Left")
end)
fmcOptions.Panel2.Box1.CheckButton1:HookScript("OnClick", function (self, button, down)
	if button == "LeftButton" and down == false then
		if self:GetChecked() == true then
			FMCsettings.LootButtons.Visible = true
		elseif self:GetChecked() == false then
			FMCsettings.LootButtons.Visible = false
		end
		C_UI.Reload()
	end
end)
-- Box 1, Slider 1, size
VDW.CreateOptionsSlider("FMC", fmcOptions.Panel2, 1, 1, 16, 80, 16, 80, Color.Main, Color.High)
fmcOptions.Panel2.Box1.Slider1.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	fmcOptions.Panel2.Box1.Slider1.TopText:SetText(VDWtranslate.Global.SIZE..": "..self:GetValue())
	FMCsettings.LootButtons.Size = self:GetValue()
	for i = 1, (GetNumSpecializations() + 1), 1 do
		if _G["fmcButtonLoot"..i] then
			_G["fmcButtonLoot"..i]:SetSize(FMCsettings.LootButtons.Size, FMCsettings.LootButtons.Size)
		end
	end
	PlaySound(858, "Master")
end)
-- Box 2, Notes
VDW.CreateImportantNotes(fmcOptions.Panel2, 2, Color.Main)
fmcOptions.Panel2.Box2.Notes:SetText("|A:"..C_AddOns.GetAddOnMetadata("FMC", "IconAtlas")..":16:16|a"..Color.High:WrapTextInColorCode(VDWtranslate.Global.NOTE.." 1: ")..VDWtranslate.Global.NOTES_HIDE_SHOW_BUTTONS)
-- Check Saved Variables
local function CheckSavedVariables()
	if FMCsettings.LootButtons.Visible then
		VDW.CheckButtonCheck(fmcOptions.Panel2, 1, 1, Color.Main)
		VDW.sliderEnable(fmcOptions.Panel2.Box1.Slider1)
	else
		VDW.CheckButtonUnCheck(fmcOptions.Panel2, 1, 1)
		VDW.sliderDisable(fmcOptions.Panel2.Box1.Slider1)
	end
	fmcOptions.Panel2.Box1.Slider1.Slider:SetValue(FMCsettings.LootButtons.Size)
end
-- show the option panel
fmcOptions.Panel2:HookScript("OnShow", function(self)
	if fmcOptions.Panel1:IsShown() then fmcOptions.Panel1:Hide() end
	fmcOptions.Tab1.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	fmcOptions.Tab2.Text:SetTextColor(Color.High:GetRGB())
	for i = 3, 4, 1 do
		fmcOptions["Tab"..i].Text:SetTextColor(0.4, 0.4, 0.4, 1)
		if fmcOptions["Panel"..i]:IsShown() then fmcOptions["Panel"..i]:Hide() end
	end
	CheckSavedVariables()
end)