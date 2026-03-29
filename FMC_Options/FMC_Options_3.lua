-- some variables --
local G = VDW.Local.Override
local L = VDW.FMC.Local
local C = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
local maxW = 160
local finalW = 0
local counter = 0
local talentLD = ""
local equipSet = ""
local popoutDirection = {G.OPTIONS_D_UPWARD, G.OPTIONS_D_DOWNWARD,}
local animationStyle = {G.OPTIONS_S_BANNER, G.OPTIONS_S_RUNES,}
local animationBackgroung = {G.OPTIONS_C_CLASS,}
-- Taking care of the option panel --
fmcOptions3:SetWidth(612)
fmcOptions3:ClearAllPoints()
fmcOptions3:SetPoint("TOPLEFT", fmcOptions00, "TOPLEFT", 0, 0)
-- Background of the option panel --
fmcOptions3.BGtexture:SetTexture("Interface\\BankFrame\\Bank-Background.blp", "CLAMP", "CLAMP", "NEAREST")
fmcOptions3.BGtexture:SetVertexColor(C.High:GetRGB())
fmcOptions3.BGtexture:SetDesaturation(0.3)
fmcOptions3.Logo:SetVertexColor(C.Main:GetRGB())
fmcOptions3.BorderTopRight:SetVertexColor(C.High:GetRGB())
fmcOptions3.BorderBottomRight:SetVertexColor(C.High:GetRGB())
fmcOptions3.BorderRightMiddle:SetVertexColor(C.High:GetRGB())
fmcOptions3.BorderTopLeft:SetVertexColor(C.High:GetRGB())
fmcOptions3.BorderBottomLeft:SetVertexColor(C.High:GetRGB())
fmcOptions3.BorderLeftMiddle:SetVertexColor(C.High:GetRGB())
fmcOptions3.BorderTopMiddle:SetVertexColor(C.High:GetRGB())
fmcOptions3.BorderBottomMiddle:SetVertexColor(C.High:GetRGB())
-- Title of the option panel --
fmcOptions3.Title:SetTextColor(C.Main:GetRGB())
fmcOptions3.Title:SetText(prefixTip.."|nVersion: "..C.High:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("FMC", "Version")))
-- Top text of the option panel --
fmcOptions3.TopTxt:SetTextColor(C.Main:GetRGB())
fmcOptions3.TopTxt:SetText(string.format(L.T_TIP, L.T_T_BUTTONS))
-- Bottom right text of the option panel --
fmcOptions3.BottomRightTxt:SetTextColor(C.Main:GetRGB())
fmcOptions3.BottomRightTxt:SetText("May the Good "..C.High:WrapTextInColorCode("Mojo").." be with you! ")
-- taking care of the boxes --
fmcOptions3Box1:SetHeight(128)
fmcOptions3Box1.Title:SetText("Visibility and direction")
fmcOptions3Box2.Title:SetText("Animation")
fmcOptions3Box2:SetPoint("TOPLEFT", fmcOptions3Box1, "BOTTOMLEFT", 0, 0)
fmcOptions3Box3:SetHeight(128)
fmcOptions3Box3.Title:SetText("Equipment set / Talent loadout")
fmcOptions3Box3:SetPoint("TOPLEFT", fmcOptions3Box1, "TOPRIGHT", 0, 0)
fmcOptions3Box4:SetHeight(216)
fmcOptions3Box4.Title:SetText("Important Notes")
fmcOptions3Box4:SetPoint("TOPLEFT", fmcOptions3Box2, "TOPRIGHT", 0, 0)
fmcOptions3Box4.Notes:SetTextColor(C.Main:GetRGB())
fmcOptions3Box4.Notes:SetWidth(fmcOptions3Box3:GetWidth() - 12)
fmcOptions3Box4.Notes:SetText("|A:"..C_AddOns.GetAddOnMetadata("FMC", "IconAtlas")..":16:16|a"..C.High:WrapTextInColorCode("Note 1: ").."When you "..C.High:WrapTextInColorCode("delete").." an equipment set, please delete from "..C.High:WrapTextInColorCode("bottom").." to "..C.High:WrapTextInColorCode("top").." and avoid to delete the first and the in between if there are more than one|n|n|A:"..C_AddOns.GetAddOnMetadata("FMC", "IconAtlas")..":16:16|a"..C.High:WrapTextInColorCode("Note 2: ").."When you "..C.High:WrapTextInColorCode("create")..", or "..C.High:WrapTextInColorCode("delete").." an equipment set. Please "..C.High:WrapTextInColorCode("/reload").." your game!|n|n|A:"..C_AddOns.GetAddOnMetadata("FMC", "IconAtlas")..":16:16|a"..C.High:WrapTextInColorCode("Note 3: ").."When you "..C.High:WrapTextInColorCode("create")..", or "..C.High:WrapTextInColorCode("delete").." a talent loadout. Please "..C.High:WrapTextInColorCode("/reload").." your game!")

for i = 1, 4, 1 do
	local tW = _G["fmcOptions3Box"..i].Title:GetStringWidth()+16
	local W = _G["fmcOptions3Box"..i]:GetWidth()
	if tW >= W then
		_G["fmcOptions3Box"..i]:SetWidth(tW)
	end
-- Coloring the boxes --
	_G["fmcOptions3Box"..i].Title:SetTextColor(C.Main:GetRGB())
	_G["fmcOptions3Box"..i].BorderTop:SetVertexColor(C.High:GetRGB())
	_G["fmcOptions3Box"..i].BorderBottom:SetVertexColor(C.High:GetRGB())
	_G["fmcOptions3Box"..i].BorderLeft:SetVertexColor(C.High:GetRGB())
	_G["fmcOptions3Box"..i].BorderRight:SetVertexColor(C.High:GetRGB())
end
-- Coloring the pop out buttons --
local function ColoringPopOutButtons(k, var1)
	_G["fmcOptions3Box"..k.."PopOut"..var1].Text:SetTextColor(C.Main:GetRGB())
	_G["fmcOptions3Box"..k.."PopOut"..var1].Title:SetTextColor(C.High:GetRGB())
	_G["fmcOptions3Box"..k.."PopOut"..var1].NormalTexture:SetVertexColor(C.High:GetRGB())
	_G["fmcOptions3Box"..k.."PopOut"..var1].HighlightTexture:SetVertexColor(C.Main:GetRGB())
	_G["fmcOptions3Box"..k.."PopOut"..var1].PushedTexture:SetVertexColor(C.High:GetRGB())
end
-- Mouse Wheel on Sliders --
local function MouseWheelSlider(self, delta)
	if delta == 1 then
		self:SetValue(self:GetValue() + 1)
	elseif delta == -1 then
		self:SetValue(self:GetValue() - 1)
	end
end
-- Scrolling Functions --
local function Scrolling(self, delta)
	if delta == -1 and IsShiftKeyDown() then
		self:ScrollByAmount(-8)
	elseif delta == -1 and not IsShiftKeyDown() then
		self:ScrollByAmount(-1)
	elseif delta == 1 and IsShiftKeyDown() then
		self:ScrollByAmount(8)
	elseif delta == 1 and not IsShiftKeyDown() then
		self:ScrollByAmount(1)
	end
end
-- check button enable - disable --
local function checkButtonEnable(self)
	self:EnableMouse(true)
	self.Text:SetTextColor(C.Main:GetRGB())
end
local function checkButtonDisable(self)
	self:SetChecked(false)
	self:EnableMouse(false)
	self.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
end
-- pop out button enable - disable --
local function popEnable(self)
	self:EnableMouse(true)
	self:SetAlpha(1)
end
local function popDisable(self)
	self:EnableMouse(false)
	self:SetAlpha(0.35)
end
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
-- Moving the Frame --
local function MoveFrame()
	fmcFrameFX1:EnableMouse(true)
	fmcFrameFX1:RegisterForDrag("LeftButton")
	local function StopMoving(self)
		FMCsettings["Animation"]["Position"]["X"] = Round(self:GetLeft())
		FMCsettings["Animation"]["Position"]["Y"] = Round(self:GetBottom())
		self:StopMovingOrSizing()
	end
	fmcFrameFX1:SetScript("OnDragStart", fmcFrameFX1.StartMoving)
	fmcFrameFX1:SetScript("OnDragStop", function(self) StopMoving(self) end)
end
-- animation enable - disable --
local function animationEnable()
	popEnable(fmcOptions3Box2PopOut1)
	popEnable(fmcOptions3Box2PopOut2)
	checkButtonEnable(fmcOptions3Box2CheckButton1)
	sliderEnable(fmcOptions3Box2Slider1)
	sliderEnable(fmcOptions3Box2Slider2)
end
local function animationDisable()
	popDisable(fmcOptions3Box2PopOut1)
	popDisable(fmcOptions3Box2PopOut2)
	checkButtonDisable(fmcOptions3Box2CheckButton1)
	sliderDisable(fmcOptions3Box2Slider1)
	sliderDisable(fmcOptions3Box2Slider2)
end
-- banner enable - disable --
local function bannerEnable()
	popEnable(fmcOptions3Box2PopOut2)
	checkButtonEnable(fmcOptions3Box2CheckButton1)
	sliderEnable(fmcOptions3Box2Slider1)
	sliderEnable(fmcOptions3Box2Slider2)
	fmcFrameFX1:SetAlpha(1)
end
local function bannerDisable()
	popDisable(fmcOptions3Box2PopOut2)
	checkButtonDisable(fmcOptions3Box2CheckButton1)
	sliderDisable(fmcOptions3Box2Slider1)
	sliderDisable(fmcOptions3Box2Slider2)
	fmcFrameFX1:SetAlpha(0)
	fmcFrameFX1:EnableMouse(false)
end
-- runes enable - disable --
local function runesEnable()
	fmcFrameFX2RuneTopLeft:SetAlpha(1)
	fmcFrameFX2RuneBottomRight:SetAlpha(1)
	fmcFrameFX2RuneBottomLeft:SetAlpha(1)
	fmcFrameFX2RuneTopRight:SetAlpha(1)
	fmcFrameFX2RuneTop:SetAlpha(1)
	fmcFrameFX2RuneTopLeftLight:SetAlpha(1)
	fmcFrameFX2RuneBottomRightLight:SetAlpha(1)
	fmcFrameFX2RuneBottomLeftLight:SetAlpha(1)
	fmcFrameFX2RuneTopRightLight:SetAlpha(1)
	fmcFrameFX2RuneTopLight:SetAlpha(1)
end
local function runesDisable()
	fmcFrameFX2RuneTopLeft:SetAlpha(0)
	fmcFrameFX2RuneBottomRight:SetAlpha(0)
	fmcFrameFX2RuneBottomLeft:SetAlpha(0)
	fmcFrameFX2RuneTopRight:SetAlpha(0)
	fmcFrameFX2RuneTop:SetAlpha(0)
	fmcFrameFX2RuneTopLeftLight:SetAlpha(0)
	fmcFrameFX2RuneBottomRightLight:SetAlpha(0)
	fmcFrameFX2RuneBottomLeftLight:SetAlpha(0)
	fmcFrameFX2RuneTopRightLight:SetAlpha(0)
	fmcFrameFX2RuneTopLight:SetAlpha(0)
end
-- animation check --
local function animationCheck()
	if FMCsettings["Animation"]["Style"] == G.OPTIONS_S_BANNER then
		bannerEnable()
		runesDisable()
		if FMCsettings["Animation"]["AttachedToCastbar"] then
			fmcOptions3Box2CheckButton1:SetChecked(true)
			fmcOptions3Box2CheckButton1.Text:SetTextColor(C.Main:GetRGB())
			fmcFrameFX1:EnableMouse(false)
		else
			fmcOptions3Box2CheckButton1:SetChecked(false)
			fmcOptions3Box2CheckButton1.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
			MoveFrame()
		end
	elseif FMCsettings["Animation"]["Style"] == G.OPTIONS_S_RUNES then
		bannerDisable()
		runesEnable()
	end
end
-- check button hide and show buttons --
fmcOptions3Box1CheckButton1.Text:SetText(L.T_T_BUTTONS)
fmcOptions3Box1CheckButton1:SetScript("OnEnter", function(self)
	local word = self.Text:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.W_CHECKBOX_TIP, word), C.Main)
end)
fmcOptions3Box1CheckButton1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions3Box1CheckButton1:HookScript("OnClick", function (self, button, down)
	if button == "LeftButton" and down == false then
		if self:GetChecked() == true then
			FMCsettings["TalentButtons"]["Visible"] = true
			self.Text:SetTextColor(C.Main:GetRGB())
			PlaySound(858, "Master")
		elseif self:GetChecked() == false then
			FMCsettings["TalentButtons"]["Visible"] = false
			self.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
			PlaySound(858, "Master")
		end
		C_UI.Reload()
	end
end)
-- check button hide and show animation --
fmcOptions3Box1CheckButton2.Text:SetText("Animation")
fmcOptions3Box1CheckButton2:SetScript("OnEnter", function(self)
	local word = self.Text:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.W_CHECKBOX_TIP, word), C.Main)
end)
fmcOptions3Box1CheckButton2:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions3Box1CheckButton2:HookScript("OnClick", function (self, button, down)
	if button == "LeftButton" and down == false then
		if self:GetChecked() == true then
			FMCsettings["Animation"]["Visible"] = true
			self.Text:SetTextColor(C.Main:GetRGB())
			animationEnable()
			animationCheck()
			PlaySound(858, "Master")
		elseif self:GetChecked() == false then
			FMCsettings["Animation"]["Visible"] = false
			self.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
			animationDisable()
			animationCheck()
			PlaySound(858, "Master")
		end
		VDW.FMC.AnimationSettings()
	end
end)
-- direction --
ColoringPopOutButtons(1, 1)
fmcOptions3Box1PopOut1.Title:SetText(L.W_DIRECTION)
for i, name in ipairs(popoutDirection) do
	counter = counter + 1
	local btn = CreateFrame("Button", "fmcOptions3Box1PopOut1Choice"..i, nil, "vdwPopOutButton")
	_G["fmcOptions3Box1PopOut1Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["fmcOptions3Box1PopOut1Choice"..i]:SetParent(fmcOptions3Box1PopOut1)
		_G["fmcOptions3Box1PopOut1Choice"..i]:SetPoint("TOP", fmcOptions3Box1PopOut1, "BOTTOM", 0, 4)
		_G["fmcOptions3Box1PopOut1Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["fmcOptions3Box1PopOut1Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["fmcOptions3Box1PopOut1Choice"..i]:SetParent(fmcOptions3Box1PopOut1Choice1)
		_G["fmcOptions3Box1PopOut1Choice"..i]:SetPoint("TOP", _G["fmcOptions3Box1PopOut1Choice"..i-1], "BOTTOM", 0, 0)
		_G["fmcOptions3Box1PopOut1Choice"..i]:Show()
	end
	_G["fmcOptions3Box1PopOut1Choice"..i].Text:SetText(name)
	_G["fmcOptions3Box1PopOut1Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			FMCsettings["TalentButtons"]["Direction"] = self.Text:GetText()
			fmcOptions3Box1PopOut1.Text:SetText(self.Text:GetText())
			fmcOptions3Box1PopOut1Choice1:Hide()
			C_UI.Reload()
		end
	end)
	local w = _G["fmcOptions3Box1PopOut1Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["fmcOptions3Box1PopOut1Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
fmcOptions3Box1PopOut1:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.W_DIRECTION_TIP, C.Main)
end)
fmcOptions3Box1PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions3Box1PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not fmcOptions3Box1PopOut1Choice1:IsShown() then
			fmcOptions3Box1PopOut1Choice1:Show()
		else
			fmcOptions3Box1PopOut1Choice1:Hide()
		end
	end
end)
-- animation style --
ColoringPopOutButtons(2, 1)
fmcOptions3Box2PopOut1.Title:SetText(L.W_STYLE)
for i, name in ipairs(animationStyle) do
	counter = counter + 1
	local btn = CreateFrame("Button", "fmcOptions3Box2PopOut1Choice"..i, nil, "vdwPopOutButton")
	_G["fmcOptions3Box2PopOut1Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["fmcOptions3Box2PopOut1Choice"..i]:SetParent(fmcOptions3Box2PopOut1)
		_G["fmcOptions3Box2PopOut1Choice"..i]:SetPoint("TOP", fmcOptions3Box2PopOut1, "BOTTOM", 0, 4)
		_G["fmcOptions3Box2PopOut1Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["fmcOptions3Box2PopOut1Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["fmcOptions3Box2PopOut1Choice"..i]:SetParent(fmcOptions3Box2PopOut1Choice1)
		_G["fmcOptions3Box2PopOut1Choice"..i]:SetPoint("TOP", _G["fmcOptions3Box2PopOut1Choice"..i-1], "BOTTOM", 0, 0)
		_G["fmcOptions3Box2PopOut1Choice"..i]:Show()
	end
	_G["fmcOptions3Box2PopOut1Choice"..i].Text:SetText(name)
	_G["fmcOptions3Box2PopOut1Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			FMCsettings["Animation"]["Style"] = self.Text:GetText()
			if FMCsettings["Animation"]["Style"] == G.OPTIONS_S_BANNER then
				bannerEnable()
				runesDisable()
			elseif FMCsettings["Animation"]["Style"] == G.OPTIONS_S_RUNES then
				bannerDisable()
				runesEnable()
			end
			VDW.FMC.AnimationSettings()
			fmcOptions3Box2PopOut1.Text:SetText(self.Text:GetText())
			fmcOptions3Box2PopOut1Choice1:Hide()
		end
	end)
	local w = _G["fmcOptions3Box2PopOut1Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["fmcOptions3Box2PopOut1Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
fmcOptions3Box2PopOut1:HookScript("OnEnter", function(self)
	local parent = self:GetParent()
	local word = parent.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.W_S_TIP, word), C.Main)
end)
fmcOptions3Box2PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions3Box2PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not fmcOptions3Box2PopOut1Choice1:IsShown() then
			fmcOptions3Box2PopOut1Choice1:Show()
		else
			fmcOptions3Box2PopOut1Choice1:Hide()
		end
	end
end)
-- banner background --
ColoringPopOutButtons(2, 2)
fmcOptions3Box2PopOut2.Title:SetText(L.W_BANNER_ART)
for i, name in ipairs(animationBackgroung) do
	counter = counter + 1
	local btn = CreateFrame("Button", "fmcOptions3Box2PopOut2Choice"..i, nil, "vdwPopOutButton")
	_G["fmcOptions3Box2PopOut2Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["fmcOptions3Box2PopOut2Choice"..i]:SetParent(fmcOptions3Box2PopOut2)
		_G["fmcOptions3Box2PopOut2Choice"..i]:SetPoint("TOP", fmcOptions3Box2PopOut2, "BOTTOM", 0, 4)
		_G["fmcOptions3Box2PopOut2Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["fmcOptions3Box2PopOut2Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["fmcOptions3Box2PopOut2Choice"..i]:SetParent(fmcOptions3Box2PopOut2Choice1)
		_G["fmcOptions3Box2PopOut2Choice"..i]:SetPoint("TOP", _G["fmcOptions3Box2PopOut2Choice"..i-1], "BOTTOM", 0, 0)
		_G["fmcOptions3Box2PopOut2Choice"..i]:Show()
	end
	_G["fmcOptions3Box2PopOut2Choice"..i].Text:SetText(name)
	_G["fmcOptions3Box2PopOut2Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			FMCsettings["Animation"]["Background"] = self.Text:GetText()
			VDW.FMC.AnimationSettings()
			fmcOptions3Box2PopOut2.Text:SetText(self.Text:GetText())
			fmcOptions3Box2PopOut2Choice1:Hide()
		end
	end)
	local w = _G["fmcOptions3Box2PopOut2Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["fmcOptions3Box2PopOut2Choice"..i]:SetWidth(finalW)
end
counter = 0
maxW = 160
fmcOptions3Box2PopOut2:HookScript("OnEnter", function(self)
	local word = self.Title:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.W_S_TIP, word), C.Main)
end)
fmcOptions3Box2PopOut2:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions3Box2PopOut2:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not fmcOptions3Box2PopOut2Choice1:IsShown() then
			fmcOptions3Box2PopOut2Choice1:Show()
		else
			fmcOptions3Box2PopOut2Choice1:Hide()
		end
	end
end)
-- animation to cast bar --
fmcOptions3Box2CheckButton1.Text:SetText("attach animation to cast bar.")
fmcOptions3Box2CheckButton1:SetScript("OnEnter", function(self)
	local word = self.Text:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.W_ATTACH_TIP, word), C.Main)
end)
fmcOptions3Box2CheckButton1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions3Box2CheckButton1:HookScript("OnClick", function (self, button, down)
	if button == "LeftButton" and down == false then
		if self:GetChecked() == true then
			FMCsettings["Animation"]["AttachedToCastbar"] = true
			self.Text:SetTextColor(C.Main:GetRGB())
			fmcFrameFX1:EnableMouse(false)
		elseif self:GetChecked() == false then
			FMCsettings["Animation"]["AttachedToCastbar"] = false
			self.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
			MoveFrame()
		end
		VDW.FMC.AnimationSettings()
		PlaySound(858, "Master")
	end
end)
-- animation width --
fmcOptions3Box2Slider1:SetWidth(fmcOptions3Box2:GetWidth() * 0.9)
fmcOptions3Box2Slider1.Slider.Thumb:SetVertexColor(C.Main:GetRGB())
fmcOptions3Box2Slider1.Back:GetRegions():SetVertexColor(C.Main:GetRGB())
fmcOptions3Box2Slider1.Forward:GetRegions():SetVertexColor(C.Main:GetRGB())
fmcOptions3Box2Slider1.TopText:SetTextColor(C.High:GetRGB())
fmcOptions3Box2Slider1.MinText:SetTextColor(C.High:GetRGB())
fmcOptions3Box2Slider1.MaxText:SetTextColor(C.High:GetRGB())
fmcOptions3Box2Slider1.MinText:SetText(160)
fmcOptions3Box2Slider1.MaxText:SetText(800)
fmcOptions3Box2Slider1.Slider:SetMinMaxValues(160, 800)
-- enter --
fmcOptions3Box2Slider1.Slider:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.W_SLIDER_TIP, C.Main)
end)
-- leave --
fmcOptions3Box2Slider1.Slider:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- mouse wheel --
fmcOptions3Box2Slider1.Slider:SetScript("OnMouseWheel", MouseWheelSlider)
-- value change --
fmcOptions3Box2Slider1.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	fmcOptions3Box2Slider1.TopText:SetText("Width: "..self:GetValue())
	FMCsettings["Animation"]["Size"]["W"] = self:GetValue()
	fmcFrameFX1:SetSize(FMCsettings["Animation"]["Size"]["W"], FMCsettings["Animation"]["Size"]["H"])
	PlaySound(858, "Master")
end)
-- animation height --
fmcOptions3Box2Slider2:SetWidth(fmcOptions3Box2:GetWidth() * 0.9)
fmcOptions3Box2Slider2.Slider.Thumb:SetVertexColor(C.Main:GetRGB())
fmcOptions3Box2Slider2.Back:GetRegions():SetVertexColor(C.Main:GetRGB())
fmcOptions3Box2Slider2.Forward:GetRegions():SetVertexColor(C.Main:GetRGB())
fmcOptions3Box2Slider2.TopText:SetTextColor(C.High:GetRGB())
fmcOptions3Box2Slider2.MinText:SetTextColor(C.High:GetRGB())
fmcOptions3Box2Slider2.MaxText:SetTextColor(C.High:GetRGB())
fmcOptions3Box2Slider2.MinText:SetText(160)
fmcOptions3Box2Slider2.MaxText:SetText(800)
fmcOptions3Box2Slider2.Slider:SetMinMaxValues(160, 800)
-- enter --
fmcOptions3Box2Slider2.Slider:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.W_SLIDER_TIP, C.Main)
end)
-- leave --
fmcOptions3Box2Slider2.Slider:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- mouse wheel --
fmcOptions3Box2Slider2.Slider:SetScript("OnMouseWheel", MouseWheelSlider)
-- value change --
fmcOptions3Box2Slider2.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	fmcOptions3Box2Slider2.TopText:SetText("Height: "..self:GetValue())
	FMCsettings["Animation"]["Size"]["H"] = self:GetValue()
	fmcFrameFX1:SetSize(FMCsettings["Animation"]["Size"]["W"], FMCsettings["Animation"]["Size"]["H"])
	PlaySound(858, "Master")
end)
-- equipment set --
ColoringPopOutButtons(3, 1)
fmcOptions3Box3PopOut1.Title:SetText("Equipment Set")
for name, v in pairs(FMCdata.EquipmentSets) do
	counter = counter + 1
	local btn = CreateFrame("Button", "fmcOptions3Box3PopOut1Choice"..counter, nil, "vdwPopOutButton")
	_G["fmcOptions3Box3PopOut1Choice"..counter]:ClearAllPoints()
	if counter == 1 then
		_G["fmcOptions3Box3PopOut1Choice"..counter]:SetParent(fmcOptions3Box3PopOut1)
		_G["fmcOptions3Box3PopOut1Choice"..counter]:SetPoint("TOP", fmcOptions3Box3PopOut1, "BOTTOM", 0, 4)
		_G["fmcOptions3Box3PopOut1Choice"..counter]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["fmcOptions3Box3PopOut1Choice"..counter]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["fmcOptions3Box3PopOut1Choice"..counter]:SetParent(fmcOptions3Box3PopOut1Choice1)
		_G["fmcOptions3Box3PopOut1Choice"..counter]:SetPoint("TOP", _G["fmcOptions3Box3PopOut1Choice"..counter-1], "BOTTOM", 0, 0)
		_G["fmcOptions3Box3PopOut1Choice"..counter]:Show()
	end
	_G["fmcOptions3Box3PopOut1Choice"..counter].Text:SetText(name)
	_G["fmcOptions3Box3PopOut1Choice"..counter]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			fmcOptions3Box3PopOut1.Text:SetText(self.Text:GetText())
			fmcOptions3Box3PopOut1Choice1:Hide()
		end
	end)
	local w = _G["fmcOptions3Box3PopOut1Choice"..counter].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["fmcOptions3Box3PopOut1Choice"..counter]:SetWidth(finalW)
end
counter = 0
maxW = 160
fmcOptions3Box3PopOut1:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, "Choose an equipment set", C.Main)
end)
fmcOptions3Box3PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions3Box3PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if fmcOptions3Box3PopOut1Choice1 then
			if not fmcOptions3Box3PopOut1Choice1:IsShown() then
				fmcOptions3Box3PopOut1Choice1:Show()
			else
				fmcOptions3Box3PopOut1Choice1:Hide()
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(VDW.PrefixChat("FMC").." There are no Equipment Sets!|nPlease create some."))
			UIErrorsFrame:AddExternalWarningMessage("There are no Equipment Sets, please create some!")
			C_Sound.PlayVocalErrorSound(48)
		end
	end
end)
-- talent loadout 1  --
ColoringPopOutButtons(3, 2)
fmcOptions3Box3PopOut2.Title:SetText("Talent loadout")
for i, name in pairs(FMCdata.TalentLayouts[VDW.FMC.specId1]) do
	counter = counter + 1
	local btn = CreateFrame("Button", "fmcOptions3Box3PopOut2Choice"..i, nil, "vdwPopOutButton")
	_G["fmcOptions3Box3PopOut2Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["fmcOptions3Box3PopOut2Choice"..i]:SetParent(fmcOptions3Box3PopOut2)
		_G["fmcOptions3Box3PopOut2Choice"..i]:SetPoint("TOP", fmcOptions3Box3PopOut2, "BOTTOM", 0, 4)
		_G["fmcOptions3Box3PopOut2Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["fmcOptions3Box3PopOut2Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["fmcOptions3Box3PopOut2Choice"..i]:SetParent(fmcOptions3Box3PopOut2Choice1)
		_G["fmcOptions3Box3PopOut2Choice"..i]:SetPoint("TOP", _G["fmcOptions3Box3PopOut2Choice"..i-1], "BOTTOM", 0, 0)
		_G["fmcOptions3Box3PopOut2Choice"..i]:Show()
	end
	_G["fmcOptions3Box3PopOut2Choice"..i].Text:SetText(name)
	_G["fmcOptions3Box3PopOut2Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			fmcOptions3Box3PopOut2.Text:SetText(self.Text:GetText())
			fmcOptions3Box3PopOut2Choice1:Hide()
		end
	end)
	local w = _G["fmcOptions3Box3PopOut2Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["fmcOptions3Box3PopOut2Choice"..counter]:SetWidth(finalW)
end
counter = 0
maxW = 160
fmcOptions3Box3PopOut2:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, "Choose a talent loadout", C.Main)
end)
fmcOptions3Box3PopOut2:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions3Box3PopOut2:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not fmcOptions3Box3PopOut2Choice1:IsShown() then
			fmcOptions3Box3PopOut2Choice1:Show()
		else
			fmcOptions3Box3PopOut2Choice1:Hide()
		end
	end
end)
-- talent loadout 2  --
ColoringPopOutButtons(3, 3)
fmcOptions3Box3PopOut3.Title:SetText("Talent loadout")
for i, name in pairs(FMCdata.TalentLayouts[VDW.FMC.specId2]) do
	counter = counter + 1
	local btn = CreateFrame("Button", "fmcOptions3Box3PopOut3Choice"..i, nil, "vdwPopOutButton")
	_G["fmcOptions3Box3PopOut3Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["fmcOptions3Box3PopOut3Choice"..i]:SetParent(fmcOptions3Box3PopOut3)
		_G["fmcOptions3Box3PopOut3Choice"..i]:SetPoint("TOP", fmcOptions3Box3PopOut3, "BOTTOM", 0, 4)
		_G["fmcOptions3Box3PopOut3Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["fmcOptions3Box3PopOut3Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["fmcOptions3Box3PopOut3Choice"..i]:SetParent(fmcOptions3Box3PopOut3Choice1)
		_G["fmcOptions3Box3PopOut3Choice"..i]:SetPoint("TOP", _G["fmcOptions3Box3PopOut3Choice"..i-1], "BOTTOM", 0, 0)
		_G["fmcOptions3Box3PopOut3Choice"..i]:Show()
	end
	_G["fmcOptions3Box3PopOut3Choice"..i].Text:SetText(name)
	_G["fmcOptions3Box3PopOut3Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			fmcOptions3Box3PopOut3.Text:SetText(self.Text:GetText())
			fmcOptions3Box3PopOut3Choice1:Hide()
		end
	end)
	local w = _G["fmcOptions3Box3PopOut3Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["fmcOptions3Box3PopOut3Choice"..counter]:SetWidth(finalW)
end
counter = 0
maxW = 160
fmcOptions3Box3PopOut3:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, "Choose a talent loadout", C.Main)
end)
fmcOptions3Box3PopOut3:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions3Box3PopOut3:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not fmcOptions3Box3PopOut3Choice1:IsShown() then
			fmcOptions3Box3PopOut3Choice1:Show()
		else
			fmcOptions3Box3PopOut3Choice1:Hide()
		end
	end
end)
-- talent loadout 3  --
ColoringPopOutButtons(3, 4)
fmcOptions3Box3PopOut4.Title:SetText("Talent loadout")
for i, name in pairs(FMCdata.TalentLayouts[VDW.FMC.specId3]) do
	counter = counter + 1
	local btn = CreateFrame("Button", "fmcOptions3Box3PopOut4Choice"..i, nil, "vdwPopOutButton")
	_G["fmcOptions3Box3PopOut4Choice"..i]:ClearAllPoints()
	if i == 1 then
		_G["fmcOptions3Box3PopOut4Choice"..i]:SetParent(fmcOptions3Box3PopOut4)
		_G["fmcOptions3Box3PopOut4Choice"..i]:SetPoint("TOP", fmcOptions3Box3PopOut4, "BOTTOM", 0, 4)
		_G["fmcOptions3Box3PopOut4Choice"..i]:SetScript("OnShow", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
			PlaySound(855, "Master")
		end)
		_G["fmcOptions3Box3PopOut4Choice"..i]:SetScript("OnHide", function(self)
			self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
			PlaySound(855, "Master")
		end)
	else
		_G["fmcOptions3Box3PopOut4Choice"..i]:SetParent(fmcOptions3Box3PopOut4Choice1)
		_G["fmcOptions3Box3PopOut4Choice"..i]:SetPoint("TOP", _G["fmcOptions3Box3PopOut4Choice"..i-1], "BOTTOM", 0, 0)
		_G["fmcOptions3Box3PopOut4Choice"..i]:Show()
	end
	_G["fmcOptions3Box3PopOut4Choice"..i].Text:SetText(name)
	_G["fmcOptions3Box3PopOut4Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			fmcOptions3Box3PopOut4.Text:SetText(self.Text:GetText())
			fmcOptions3Box3PopOut4Choice1:Hide()
		end
	end)
	local w = _G["fmcOptions3Box3PopOut4Choice"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 24)
for i = 1, counter, 1 do
	_G["fmcOptions3Box3PopOut4Choice"..counter]:SetWidth(finalW)
end
counter = 0
maxW = 160
fmcOptions3Box3PopOut4:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, "Choose a talent loadout", C.Main)
end)
fmcOptions3Box3PopOut4:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions3Box3PopOut4:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if not fmcOptions3Box3PopOut4Choice1:IsShown() then
			fmcOptions3Box3PopOut4Choice1:Show()
		else
			fmcOptions3Box3PopOut4Choice1:Hide()
		end
	end
end)
if FMCdata.TalentLayouts[VDW.FMC.specId4] then
-- talent loadout 4  --
	ColoringPopOutButtons(3, 5)
	fmcOptions3Box3PopOut5.Title:SetText("Talent loadout")
	for i, name in pairs(FMCdata.TalentLayouts[VDW.FMC.specId4]) do
		counter = counter + 1
		local btn = CreateFrame("Button", "fmcOptions3Box3PopOut5Choice"..i, nil, "vdwPopOutButton")
		_G["fmcOptions3Box3PopOut5Choice"..i]:ClearAllPoints()
		if i == 1 then
			_G["fmcOptions3Box3PopOut5Choice"..i]:SetParent(fmcOptions3Box3PopOut5)
			_G["fmcOptions3Box3PopOut5Choice"..i]:SetPoint("TOP", fmcOptions3Box3PopOut5, "BOTTOM", 0, 4)
			_G["fmcOptions3Box3PopOut5Choice"..i]:SetScript("OnShow", function(self)
				self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
				PlaySound(855, "Master")
			end)
			_G["fmcOptions3Box3PopOut5Choice"..i]:SetScript("OnHide", function(self)
				self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
				PlaySound(855, "Master")
			end)
		else
			_G["fmcOptions3Box3PopOut5Choice"..i]:SetParent(fmcOptions3Box3PopOut5Choice1)
			_G["fmcOptions3Box3PopOut5Choice"..i]:SetPoint("TOP", _G["fmcOptions3Box3PopOut5Choice"..i-1], "BOTTOM", 0, 0)
			_G["fmcOptions3Box3PopOut5Choice"..i]:Show()
		end
		_G["fmcOptions3Box3PopOut5Choice"..i].Text:SetText(name)
		_G["fmcOptions3Box3PopOut5Choice"..i]:HookScript("OnClick", function(self, button, down)
			if button == "LeftButton" and down == false then
				fmcOptions3Box3PopOut5.Text:SetText(self.Text:GetText())
				fmcOptions3Box3PopOut5Choice1:Hide()
			end
		end)
		local w = _G["fmcOptions3Box3PopOut5Choice"..i].Text:GetStringWidth()
		if w > maxW then maxW = w end
	end
	finalW = math.ceil(maxW + 24)
	for i = 1, counter, 1 do
		_G["fmcOptions3Box3PopOut5Choice"..counter]:SetWidth(finalW)
	end
	counter = 0
	maxW = 160
	fmcOptions3Box3PopOut5:HookScript("OnEnter", function(self)
		VDW.Tooltip_Show(self, prefixTip, "Choose a talent loadout", C.Main)
	end)
	fmcOptions3Box3PopOut5:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
	fmcOptions3Box3PopOut5:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			if not fmcOptions3Box3PopOut5Choice1:IsShown() then
				fmcOptions3Box3PopOut5Choice1:Show()
			else
				fmcOptions3Box3PopOut5Choice1:Hide()
			end
		end
	end)
end
-- bind button
fmcOptions3Box3Button1.Text:SetTextColor(C.Main:GetRGB())
fmcOptions3Box3Button1.NormalTexture:SetVertexColor(C.High:GetRGB())
fmcOptions3Box3Button1.HighlightTexture:SetVertexColor(C.Main:GetRGB())
fmcOptions3Box3Button1.PushedTexture:SetVertexColor(C.High:GetRGB())
fmcOptions3Box3Button1.Text:SetText("Bind them")
fmcOptions3Box3Button1:HookScript("OnEnter", function(self)
	if fmcOptions3Box3PopOut1.Text:GetText() ~= nil and (fmcOptions3Box3PopOut2.Text:GetText() ~= nil or fmcOptions3Box3PopOut3.Text:GetText() ~= nil or fmcOptions3Box3PopOut4.Text:GetText() ~= nil or fmcOptions3Box3PopOut5.Text:GetText() ~= nil) then
		talentLD = ""
		equipSet = fmcOptions3Box3PopOut1.Text:GetText()
		if GetSpecialization() == 1 then talentLD = fmcOptions3Box3PopOut2.Text:GetText()
		elseif GetSpecialization() == 2 then talentLD = fmcOptions3Box3PopOut3.Text:GetText()
		elseif GetSpecialization() == 3 then talentLD = fmcOptions3Box3PopOut4.Text:GetText()
		elseif GetSpecialization() == 4 then talentLD = fmcOptions3Box3PopOut5.Text:GetText()
		end
		VDW.Tooltip_Show(self, prefixTip, "Bind the equipment set '"..equipSet.."' to talent loadout '"..talentLD.."'", C.Main)
	end
end)
fmcOptions3Box3Button1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
fmcOptions3Box3Button1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if fmcOptions3Box3PopOut1.Text:GetText() ~= nil and (fmcOptions3Box3PopOut2.Text:GetText() ~= nil or fmcOptions3Box3PopOut3.Text:GetText() ~= nil or fmcOptions3Box3PopOut4.Text:GetText() ~= nil or fmcOptions3Box3PopOut5.Text:GetText() ~= nil) then
			if GetSpecialization() == 1 then FMCdata.TalentBindEquipment[VDW.FMC.specId1][talentLD] = FMCdata.EquipmentSets[equipSet]
			elseif GetSpecialization() == 2 then FMCdata.TalentBindEquipment[VDW.FMC.specId2][talentLD] = FMCdata.EquipmentSets[equipSet]
			elseif GetSpecialization() == 3 then FMCdata.TalentBindEquipment[VDW.FMC.specId3][talentLD] = FMCdata.EquipmentSets[equipSet]
			elseif GetSpecialization() == 4 then FMCdata.TalentBindEquipment[VDW.FMC.specId4][talentLD] = FMCdata.EquipmentSets[equipSet]
			end
			DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(VDW.PrefixChat("FMC").." The Equipment Set has been bound to the Talent Loadout!"))
			UIErrorsFrame:AddExternalWarningMessage("The Equipment Set has been bound to the Talent Loadout!")
			fmcOptions00:Hide()
		else
			DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(VDW.PrefixChat("FMC").." One or both of the Pop Out Buttons are empty!"))
			UIErrorsFrame:AddExternalWarningMessage("One or both of the Pop Out Buttons are empty!")
			C_Sound.PlayVocalErrorSound(48)
		end
	end
end)
-- taking care of the scrolling list 1
fmcOptions3List1.BGtexture:SetVertexColor(C.High:GetRGB())
fmcOptions3List1.Title:SetTextColor(C.Main:GetRGB())
fmcOptions3List1:SetFontObject("vdw_NFshadow_14")
fmcOptions3List1:SetTextColor(C.Main:GetRGB())
fmcOptions3List1:SetScript("OnMouseWheel", function(self, delta) Scrolling(self, delta) end)
local function sendMessages(specID)
	local count = 0
	for fk, fv in pairs(FMCdata.TalentBindEquipment[specID]) do
		if fk then
			for sk, sv in pairs (FMCdata.EquipmentSets) do
				if sk then
					if sv == fv then
						count = count + 1
						fmcOptions3List1:AddMessage(" "..count..".The equipment set '"..sk.."' is bound to the '"..fk.."' talent loadout")
						fmcOptions3List1:AddMessage("---")
					end
				else
					FMCdata.TalentBindEquipment[specID] = {}
				end
			end
		end
	end
end
-- Checking the Saved Variables --
local function CheckSavedVariables()
	if FMCsettings["TalentButtons"]["Visible"] then
		fmcOptions3Box1CheckButton1:SetChecked(true)
		fmcOptions3Box1CheckButton1.Text:SetTextColor(C.Main:GetRGB())
		popEnable(fmcOptions3Box1PopOut1)
		checkButtonEnable(fmcOptions3Box1CheckButton2)
		if FMCsettings["Animation"]["Visible"] then
			fmcOptions3Box1CheckButton2:SetChecked(true)
			fmcOptions3Box1CheckButton2.Text:SetTextColor(C.Main:GetRGB())
			animationEnable()
			animationCheck()
		else
			fmcOptions3Box1CheckButton2:SetChecked(false)
			fmcOptions3Box1CheckButton2.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
			animationDisable()
		end
	else
		popDisable(fmcOptions3Box1PopOut1)
		checkButtonDisable(fmcOptions3Box1CheckButton2)
		animationDisable()
		fmcOptions3Box1CheckButton1:SetChecked(false)
		fmcOptions3Box1CheckButton1.Text:SetTextColor(0.35, 0.35, 0.35, 0.8)
	end
	fmcOptions3Box1PopOut1.Text:SetText(FMCsettings["TalentButtons"]["Direction"])
	fmcOptions3Box2PopOut1.Text:SetText(FMCsettings["Animation"]["Style"])
	fmcOptions3Box2PopOut2.Text:SetText(FMCsettings["Animation"]["Background"])
	fmcOptions3Box2Slider1.Slider:SetValue(FMCsettings["Animation"]["Size"]["W"])
	fmcOptions3Box2Slider2.Slider:SetValue(FMCsettings["Animation"]["Size"]["H"])
	if GetSpecialization() == 1 then
		fmcOptions3Box3PopOut2:Show()
		fmcOptions3Box3PopOut3:Hide()
		fmcOptions3Box3PopOut4:Hide()
		fmcOptions3Box3PopOut5:Hide()
		sendMessages(VDW.FMC.specId1)
	elseif GetSpecialization() == 2 then
		fmcOptions3Box3PopOut2:Hide()
		fmcOptions3Box3PopOut3:Show()
		fmcOptions3Box3PopOut4:Hide()
		fmcOptions3Box3PopOut5:Hide()
		sendMessages(VDW.FMC.specId2)
	elseif GetSpecialization() == 3 then
		fmcOptions3Box3PopOut2:Hide()
		fmcOptions3Box3PopOut3:Hide()
		fmcOptions3Box3PopOut4:Show()
		fmcOptions3Box3PopOut5:Hide()
		sendMessages(VDW.FMC.specId3)
	elseif GetSpecialization() == 4 then
		fmcOptions3Box3PopOut2:Hide()
		fmcOptions3Box3PopOut3:Hide()
		fmcOptions3Box3PopOut4:Hide()
		fmcOptions3Box3PopOut5:Show()
		sendMessages(VDW.FMC.specId4)
	end
end
-- Show the option panel --
fmcOptions3:HookScript("OnShow", function(self)
	fmcOptions00Tab1.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	fmcOptions00Tab2.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	fmcOptions00Tab3.Text:SetTextColor(C.High:GetRGB())
	fmcOptions00Tab4.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	if fmcOptions1:IsShown() then fmcOptions1:Hide() end
	if fmcOptions2:IsShown() then fmcOptions2:Hide() end
	if fmcOptions4:IsShown() then fmcOptions4:Hide() end
	CheckSavedVariables()
	fmcOptions3Box2CheckButton1.Text:SetWidth(fmcOptions3Box2:GetWidth() * 0.9)
end)
-- hide the option panel --
fmcOptions3:HookScript("OnHide", function(self)
	fmcFrameFX1:SetAlpha(0)
	fmcFrameFX1:EnableMouse(false)
	runesDisable()
	fmcOptions3List1:Clear()
	fmcOptions3Box3PopOut1:SetText("")
	fmcOptions3Box3PopOut2:SetText("")
	fmcOptions3Box3PopOut3:SetText("")
	fmcOptions3Box3PopOut4:SetText("")
	fmcOptions3Box3PopOut5:SetText("")
end)
