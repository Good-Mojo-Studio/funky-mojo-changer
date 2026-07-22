-- some variables
local Color = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
local maxW = 128
local finalW = 0
-- create panel
fmcOptions.ExitButton:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.CLOSE_THIS_PANEL, Color.Main, "Left")
end)
VDW.MoveTheFrame(fmcOptions, "LeftButton")
fmcOptions.Tab1.Text:SetText(VDWtranslate.Global.SPECIALIZATION_BUTTONS)
fmcOptions.Tab2.Text:SetText(VDWtranslate.Global.LOOT_BUTTONS)
fmcOptions.Tab3.Text:SetText(VDWtranslate.Global.TALENT_BUTTONS)
fmcOptions.Tab4.Text:SetText(VDWtranslate.Global.P_TAB)
for i = 1, 4, 1 do
	local w = fmcOptions["Tab"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 16)
for i = 1, 4, 1 do
	fmcOptions["Tab"..i]:SetWidth(finalW)
	fmcOptions["Tab"..i].NormalTexture:SetVertexColor(Color.High:GetRGB())
	fmcOptions["Tab"..i]:HookScript("OnLeave", function(self)
		VDW.Tooltip_Hide()
	end)
	fmcOptions["Tab"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			if not fmcOptions["Panel"..i]:IsShown() then fmcOptions["Panel"..i]:Show() end
		end
	end)
	if i == 1 then
		fmcOptions["Tab"..i]:HookScript("OnEnter", function(self)
			local word = self.Text:GetText()
			VDW.Tooltip_Show(self, prefixTip, string.format(VDWtranslate.Global.OPTIONS_FOR, word), Color.Main, "Left")
		end)
	elseif i == 4 then
		fmcOptions["Tab"..i]:SetPoint("TOP", fmcOptions["Tab"..i-1], "BOTTOM", 0, 0)
		fmcOptions["Tab"..i]:HookScript("OnEnter", function(self)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.P_TITLE, Color.Main, "Left")
		end)
	else
		fmcOptions["Tab"..i]:SetPoint("TOP", fmcOptions["Tab"..i-1], "BOTTOM", 0, 0)
		fmcOptions["Tab"..i]:HookScript("OnEnter", function(self)
			local word = self.Text:GetText()
			VDW.Tooltip_Show(self, prefixTip, string.format(VDWtranslate.Global.OPTIONS_FOR, word), Color.Main, "Left")
		end)
	end
end
-- show the option panel
fmcOptions:SetScript("OnShow", function(self)
	if not fmcOptions.Panel1:IsShown() then fmcOptions.Panel1:Show() end
end)
-- hide the option panel
fmcOptions:HookScript("OnHide", function(self)
	for i = 1, 4, 1 do
		if fmcOptions["Panel"..i]:IsShown() then fmcOptions["Panel"..i]:Hide() end
	end
end)
