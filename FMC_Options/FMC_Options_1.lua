-- some variables --
local L = VDW.FMC.Local
local C = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
-- Taking care of the option panel --
fmcOptions1:ClearAllPoints()
fmcOptions1:SetPoint("TOPLEFT", fmcOptions00, "TOPLEFT", 0, 0)
-- Background of the option panel --
fmcOptions1.BGtexture:SetTexture("Interface\\BankFrame\\Bank-Background.blp", "CLAMP", "CLAMP", "NEAREST")
fmcOptions1.BGtexture:SetVertexColor(C.High:GetRGB())
fmcOptions1.BGtexture:SetDesaturation(0.3)
-- Title of the option panel --
fmcOptions1.Title:SetTextColor(C.Main:GetRGB())
fmcOptions1.Title:SetText(prefixTip.."|nVersion: "..C.High:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("FMC", "Version")))
-- Top text of the option panel --
fmcOptions1.TopTxt:SetTextColor(C.Main:GetRGB())
fmcOptions1.TopTxt:SetText(string.format(L.T_TIP, L.T_S_BUTTONS))
-- Bottom right text of the option panel --
fmcOptions1.BottomRightTxt:SetTextColor(C.Main:GetRGB())
fmcOptions1.BottomRightTxt:SetText("May the Good "..C.High:WrapTextInColorCode("Mojo").." be with you!")
-- taking care of the boxes --
fmcOptions1Box1:SetHeight(128)
fmcOptions1Box1.Title:SetText(L.BOX_TITLE)
-- Coloring the boxes --
fmcOptions1Box1.Title:SetTextColor(C.Main:GetRGB())
fmcOptions1Box1.BorderTop:SetVertexColor(C.High:GetRGB())
fmcOptions1Box1.BorderBottom:SetVertexColor(C.High:GetRGB())
fmcOptions1Box1.BorderLeft:SetVertexColor(C.High:GetRGB())
fmcOptions1Box1.BorderRight:SetVertexColor(C.High:GetRGB())
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
fmcOptions1Box1CheckButton1.Text:SetText(L.T_S_BUTTONS)
fmcOptions1Box1CheckButton1:SetScript("OnEnter", function(self)
	local word = self.Text:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.W_CHECKBOX_TIP, word), C.Main)
end)
fmcOptions1Box1CheckButton1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions1Box1CheckButton1:HookScript("OnClick", function (self, button, down)
	if button == "LeftButton" and down == false then
		if self:GetChecked() == true then
			FMCsettings["SpecButtons"]["Visible"] = true
			self.Text:SetTextColor(C.Main:GetRGB())
			sliderEnable(fmcOptions1Box1Slider1)
			PlaySound(858, "Master")
		elseif self:GetChecked() == false then
			FMCsettings["SpecButtons"]["Visible"] = false
			self.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
			sliderDisable(fmcOptions1Box1Slider1)
			PlaySound(858, "Master")
		end
		C_UI.Reload()
	end
end)
-- slide bar 1 size buttons --
fmcOptions1Box1Slider1:SetWidth(fmcOptions1Box1:GetWidth() * 0.9)
fmcOptions1Box1Slider1.Slider.Thumb:SetVertexColor(C.Main:GetRGB())
fmcOptions1Box1Slider1.Back:GetRegions():SetVertexColor(C.Main:GetRGB())
fmcOptions1Box1Slider1.Forward:GetRegions():SetVertexColor(C.Main:GetRGB())
fmcOptions1Box1Slider1.TopText:SetTextColor(C.High:GetRGB())
fmcOptions1Box1Slider1.MinText:SetTextColor(C.High:GetRGB())
fmcOptions1Box1Slider1.MaxText:SetTextColor(C.High:GetRGB())
fmcOptions1Box1Slider1.MinText:SetText(16)
fmcOptions1Box1Slider1.MaxText:SetText(80)
fmcOptions1Box1Slider1.Slider:SetMinMaxValues(16, 80)
-- enter --
fmcOptions1Box1Slider1.Slider:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.W_SLIDER_TIP, C.Main)
end)
-- leave --
fmcOptions1Box1Slider1.Slider:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- mouse wheel --
fmcOptions1Box1Slider1.Slider:SetScript("OnMouseWheel", MouseWheelSlider)
-- value change --
fmcOptions1Box1Slider1.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	fmcOptions1Box1Slider1.TopText:SetText("Size: "..self:GetValue())
	FMCsettings["SpecButtons"]["Size"] = self:GetValue()
	for i = 1, (GetNumSpecializations() - 1), 1 do
		_G["fmcButtonSpec"..i]:SetSize(FMCsettings["SpecButtons"]["Size"], FMCsettings["SpecButtons"]["Size"])
		_G["fmcButtonSpec"..i.."Circle"]:SetSize(FMCsettings["SpecButtons"]["Size"]*3, FMCsettings["SpecButtons"]["Size"]*3)
	end
	PlaySound(858, "Master")
end)
-- Checking the Saved Variables --
local function CheckSavedVariables()
	if FMCsettings["SpecButtons"]["Visible"] then
		fmcOptions1Box1CheckButton1:SetChecked(true)
		fmcOptions1Box1CheckButton1.Text:SetTextColor(C.Main:GetRGB())
		sliderEnable(fmcOptions1Box1Slider1)
	else
		fmcOptions1Box1CheckButton1:SetChecked(false)
		fmcOptions1Box1CheckButton1.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
		sliderDisable(fmcOptions1Box1Slider1)
	end
	if FMCsettings["SpecButtons"]["Visible"] then fmcOptions1Box1Slider1.Slider:SetValue(FMCsettings["SpecButtons"]["Size"]) end
end
-- Show the option panel --
fmcOptions1:HookScript("OnShow", function(self)
	fmcOptions00Tab1.Text:SetTextColor(C.High:GetRGB())
	fmcOptions00Tab2.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	fmcOptions00Tab3.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	fmcOptions00Tab4.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	if fmcOptions2:IsShown() then fmcOptions2:Hide() end
	if fmcOptions3:IsShown() then fmcOptions3:Hide() end
	if fmcOptions4:IsShown() then fmcOptions4:Hide() end
	CheckSavedVariables()
end)
-- Background of the tabs frame --
local OptionsW = fmcOptions1:GetWidth()
fmcOptions00:SetWidth(fmcOptions00Tab1:GetWidth() + OptionsW)
fmcOptions00:SetHeight(fmcOptions1:GetHeight())
fmcOptions00.BGtexture:ClearAllPoints()
fmcOptions00.BGtexture:SetPoint("TOPRIGHT", fmcOptions00, "TOPRIGHT", 0, 0)
fmcOptions00.BGtexture:SetPoint("BOTTOMLEFT", fmcOptions00, "BOTTOMLEFT", OptionsW, 0)
fmcOptions00.BGtexture:SetTexture("Interface\\BankFrame\\Bank-Background.blp", "CLAMP", "CLAMP", "NEAREST")
fmcOptions00.BGtexture:SetDesaturation(0.3)
fmcOptions00.BGtexture:SetGradient("VERTICAL", C.NoHigh, C.High)