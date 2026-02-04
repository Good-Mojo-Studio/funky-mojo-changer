-- some variables --
local L = VDW.FMC.Local
local C = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
-- Taking care of the option panel --
fmcOptions2:ClearAllPoints()
fmcOptions2:SetPoint("TOPLEFT", fmcOptions00, "TOPLEFT", 0, 0)
-- Background of the option panel --
fmcOptions2.BGtexture:SetTexture("Interface\\BankFrame\\Bank-Background.blp", "CLAMP", "CLAMP", "NEAREST")
fmcOptions2.BGtexture:SetVertexColor(C.High:GetRGB())
fmcOptions2.BGtexture:SetDesaturation(0.3)
-- Title of the option panel --
fmcOptions2.Title:SetTextColor(C.Main:GetRGB())
fmcOptions2.Title:SetText(prefixTip.."|nVersion: "..C.High:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("FMC", "Version")))
-- Top text of the option panel --
fmcOptions2.TopTxt:SetTextColor(C.Main:GetRGB())
fmcOptions2.TopTxt:SetText(string.format(L.T_TIP, L.T_L_BUTTONS))
-- Bottom right text of the option panel --
fmcOptions2.BottomRightTxt:SetTextColor(C.Main:GetRGB())
fmcOptions2.BottomRightTxt:SetText("May the Good "..C.High:WrapTextInColorCode("Mojo").." be with you!")
-- taking care of the boxes --
fmcOptions2Box1:SetHeight(128)
fmcOptions2Box1.Title:SetText(L.BOX_TITLE)
-- Coloring the boxes --
fmcOptions2Box1.Title:SetTextColor(C.Main:GetRGB())
fmcOptions2Box1.BorderTop:SetVertexColor(C.High:GetRGB())
fmcOptions2Box1.BorderBottom:SetVertexColor(C.High:GetRGB())
fmcOptions2Box1.BorderLeft:SetVertexColor(C.High:GetRGB())
fmcOptions2Box1.BorderRight:SetVertexColor(C.High:GetRGB())
-- slider enable - disable --
local function sliderEnable(self)
	self.Slider:EnableMouse(true)
	self.Back:EnableMouse(true)
	self.Forward:EnableMouse(true)
	self:SetAlpha(1)
end
local function sliderDisable(self)
	self.Slider:EnableMouse(false)
	self.Back:EnableMouse(false)
	self.Forward:EnableMouse(false)
	self:SetAlpha(0.35)
end
-- Mouse Wheel on Sliders --
local function MouseWheelSlider(self, delta)
	if delta == 1 then
		self:SetValue(self:GetValue() + 1)
	elseif delta == -1 then
		self:SetValue(self:GetValue() - 1)
	end
end
-- check button hide and show buttons --
fmcOptions2Box1CheckButton1.Text:SetText(L.T_L_BUTTONS)
fmcOptions2Box1CheckButton1:SetScript("OnEnter", function(self)
	local word = self.Text:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.W_CHECKBOX_TIP, word), C.Main)
end)
fmcOptions2Box1CheckButton1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions2Box1CheckButton1:HookScript("OnClick", function (self, button, down)
	if button == "LeftButton" and down == false then
		if self:GetChecked() == true then
			FMCsettings["LootButtons"]["Visible"] = true
			self.Text:SetTextColor(C.Main:GetRGB())
			sliderEnable(fmcOptions2Box1Slider1)
			PlaySound(858, "Master")
		elseif self:GetChecked() == false then
			FMCsettings["LootButtons"]["Visible"] = false
			self.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
			sliderDisable(fmcOptions2Box1Slider1)
			PlaySound(858, "Master")
		end
		C_UI.Reload()
	end
end)
-- slide bar 1 size buttons --
fmcOptions2Box1Slider1:SetWidth(fmcOptions2Box1:GetWidth() * 0.9)
fmcOptions2Box1Slider1.Slider.Thumb:SetVertexColor(C.Main:GetRGB())
fmcOptions2Box1Slider1.Back:GetRegions():SetVertexColor(C.Main:GetRGB())
fmcOptions2Box1Slider1.Forward:GetRegions():SetVertexColor(C.Main:GetRGB())
fmcOptions2Box1Slider1.TopText:SetTextColor(C.High:GetRGB())
fmcOptions2Box1Slider1.MinText:SetTextColor(C.High:GetRGB())
fmcOptions2Box1Slider1.MaxText:SetTextColor(C.High:GetRGB())
fmcOptions2Box1Slider1.MinText:SetText(16)
fmcOptions2Box1Slider1.MaxText:SetText(80)
fmcOptions2Box1Slider1.Slider:SetMinMaxValues(16, 80)
-- enter --
fmcOptions2Box1Slider1.Slider:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.W_SLIDER_TIP, C.Main)
end)
-- leave --
fmcOptions2Box1Slider1.Slider:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- mouse wheel --
fmcOptions2Box1Slider1.Slider:SetScript("OnMouseWheel", MouseWheelSlider)
-- value change --
fmcOptions2Box1Slider1.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	fmcOptions2Box1Slider1.TopText:SetText("Size: "..self:GetValue())
	FMCsettings["LootButtons"]["Size"] = self:GetValue()
	for i = 1, (GetNumSpecializations() + 1), 1 do
		_G["fmcButtonLoot"..i]:SetSize(FMCsettings["LootButtons"]["Size"], FMCsettings["LootButtons"]["Size"])
	end
	PlaySound(858, "Master")
end)
-- Checking the Saved Variables --
local function CheckSavedVariables()
	if FMCsettings["LootButtons"]["Visible"] then
		fmcOptions2Box1CheckButton1:SetChecked(true)
		fmcOptions2Box1CheckButton1.Text:SetTextColor(C.Main:GetRGB())
		sliderEnable(fmcOptions2Box1Slider1)
	else
		fmcOptions2Box1CheckButton1:SetChecked(false)
		fmcOptions2Box1CheckButton1.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
		sliderDisable(fmcOptions2Box1Slider1)
	end
	if FMCsettings["LootButtons"]["Visible"] then fmcOptions2Box1Slider1.Slider:SetValue(FMCsettings["LootButtons"]["Size"]) end
end
-- Show the option panel --
fmcOptions2:HookScript("OnShow", function(self)
	fmcOptions00Tab1.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	fmcOptions00Tab2.Text:SetTextColor(C.High:GetRGB())
	fmcOptions00Tab3.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	fmcOptions00Tab4.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	if fmcOptions1:IsShown() then fmcOptions1:Hide() end
	if fmcOptions3:IsShown() then fmcOptions3:Hide() end
	if fmcOptions4:IsShown() then fmcOptions4:Hide() end
	CheckSavedVariables()
end)