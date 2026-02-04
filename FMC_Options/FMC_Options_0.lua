-- some variables --
local L = VDW.FMC.Local
local C = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
local maxW = 128
local finalW = 0
-- Entering the tabs frame' Exit Button --
fmcOptions00.ExitButton:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.TIP_CLOSE_PANEL, C.Main)
end)
-- Move the tabs frame --
fmcOptions00:RegisterForDrag("LeftButton")
fmcOptions00:SetScript("OnDragStart", fmcOptions00.StartMoving)
fmcOptions00:SetScript("OnDragStop", fmcOptions00.StopMovingOrSizing)
-- Taking care of the Tabs --
-- Naming the tab --
fmcOptions00Tab1.Text:SetText(L.T_S_BUTTONS)
fmcOptions00Tab2.Text:SetText(L.T_L_BUTTONS)
fmcOptions00Tab3.Text:SetText(L.T_T_BUTTONS)
fmcOptions00Tab4.Text:SetText(L.P_TAB)
-- Position & center text color --
for i = 1, 4, 1 do
	local w = _G["fmcOptions00Tab"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 16)
for i = 1, 4, 1 do
	if i == 1 then
		_G["fmcOptions00Tab"..i]:SetWidth(finalW)
	else
		_G["fmcOptions00Tab"..i]:SetWidth(finalW)
		_G["fmcOptions00Tab"..i]:SetPoint("TOP", _G["fmcOptions00Tab"..i-1], "BOTTOM", 0, 0)
	end
end
-- Entering the tabs --
for i = 1, 3, 1 do
	_G["fmcOptions00Tab"..i]:HookScript("OnEnter", function(self)
		local word = self.Text:GetText()
		VDW.Tooltip_Show(self, prefixTip, string.format(L.T_TIP, word), C.Main)
	end)
end
fmcOptions00Tab4:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.P_TITLE, C.Main)
end)
-- leaving the tab --
for i = 1, 4, 1 do
	_G["fmcOptions00Tab"..i]:HookScript("OnLeave", function(self)
		VDW.Tooltip_Hide()
	end)
end
-- clickingthe tabs --
for i = 1, 4, 1 do
	_G["fmcOptions00Tab"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			if not _G["fmcOptions"..i]:IsShown() then _G["fmcOptions"..i]:Show() end
		end
	end)
end
-- show the tabs frame --
fmcOptions00:SetScript("OnShow", function(self)
	self:SetWidth(fmcOptions00Tab1:GetWidth() + fmcOptions1:GetWidth())
	if not fmcOptions1:IsShown() then fmcOptions1:Show() end
end)
-- Hide the tabs frame --
fmcOptions00:HookScript("OnHide", function(self)
	for i = 1, 4, 1 do
		if _G["fmcOptions"..i]:IsShown() then _G["fmcOptions"..i]:Hide() end
	end
end)
