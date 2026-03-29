-- some variables --
local G = VDW.Local.Override
local L = VDW.FMC.Local
local C = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
local prefixChat = VDW.PrefixChat("FMC")
local NameExist = false
local maxW = 160
local finalW = 0
local  number = 0
local counterLoading = 0
local counterDeleting = 0
-- Taking care of the option panel --
fmcOptions4:SetWidth(612)
fmcOptions4:ClearAllPoints()
fmcOptions4:SetPoint("TOPLEFT", fmcOptions00, "TOPLEFT", 0, 0)
-- Background of the option panel --
fmcOptions4.BGtexture:SetTexture("Interface\\BankFrame\\Bank-Background.blp", "CLAMP", "CLAMP", "NEAREST")
fmcOptions4.BGtexture:SetVertexColor(C.High:GetRGB())
fmcOptions4.BGtexture:SetDesaturation(0.3)
fmcOptions4.Logo:SetVertexColor(C.Main:GetRGB())
fmcOptions4.BorderTopRight:SetVertexColor(C.High:GetRGB())
fmcOptions4.BorderBottomRight:SetVertexColor(C.High:GetRGB())
fmcOptions4.BorderRightMiddle:SetVertexColor(C.High:GetRGB())
fmcOptions4.BorderTopLeft:SetVertexColor(C.High:GetRGB())
fmcOptions4.BorderBottomLeft:SetVertexColor(C.High:GetRGB())
fmcOptions4.BorderLeftMiddle:SetVertexColor(C.High:GetRGB())
fmcOptions4.BorderTopMiddle:SetVertexColor(C.High:GetRGB())
fmcOptions4.BorderBottomMiddle:SetVertexColor(C.High:GetRGB())
-- Title of the option panel --
fmcOptions4.Title:SetTextColor(C.Main:GetRGB())
fmcOptions4.Title:SetText(prefixTip.."|nVersion: "..C.High:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("FMC", "Version")))
-- Top text of the option panel --
fmcOptions4.TopTxt:SetTextColor(C.Main:GetRGB())
fmcOptions4.TopTxt:SetText(L.P_TITLE)
-- Bottom right text of the option panel --
fmcOptions4.BottomRightTxt:SetTextColor(C.Main:GetRGB())
fmcOptions4.BottomRightTxt:SetText("May the Good "..C.High:WrapTextInColorCode("Mojo").." be with you!")
-- taking care of the boxes --
fmcOptions4Box1.Title:SetText(L.P_SUB_CREATE)
fmcOptions4Box2.Title:SetText(L.P_SUB_LOAD)
fmcOptions4Box2:SetPoint("TOPLEFT", fmcOptions4Box1, "BOTTOMLEFT", 0, 0)
fmcOptions4Box3.Title:SetText(L.P_SUB_DELETE)
fmcOptions4Box3:SetPoint("TOPLEFT", fmcOptions4Box2, "BOTTOMLEFT", 0, 0)
fmcOptions4Box4.Title:SetText("Important Notes")
fmcOptions4Box4:SetPoint("TOPLEFT", fmcOptions4Box3, "BOTTOMLEFT", 0, 0)
fmcOptions4Box4.Notes:SetTextColor(C.Main:GetRGB())
fmcOptions4Box4.Notes:SetWidth(fmcOptions4Box4:GetWidth() - 8)
fmcOptions4Box4.Notes:SetText("|A:"..C_AddOns.GetAddOnMetadata("FMC", "IconAtlas")..":16:16|a"..C.High:WrapTextInColorCode("Note: ").."When you "..C.High:WrapTextInColorCode("CREATE")..", "..C.High:WrapTextInColorCode("LOAD")..", "..C.High:WrapTextInColorCode("DELETE").." a Profile, the UI will be RELOADED!")
-- Coloring the boxes --
for i = 1, 4, 1 do
	_G["fmcOptions4Box"..i].Title:SetTextColor(C.Main:GetRGB())
	_G["fmcOptions4Box"..i].BorderTop:SetVertexColor(C.High:GetRGB())
	_G["fmcOptions4Box"..i].BorderBottom:SetVertexColor(C.High:GetRGB())
	_G["fmcOptions4Box"..i].BorderLeft:SetVertexColor(C.High:GetRGB())
	_G["fmcOptions4Box"..i].BorderRight:SetVertexColor(C.High:GetRGB())
end
-- Coloring the pop out buttons --
local function ColoringPopOutButtons(k, var1)
	_G["fmcOptions4Box"..k.."PopOut"..var1].Text:SetTextColor(C.Main:GetRGB())
	_G["fmcOptions4Box"..k.."PopOut"..var1].Title:SetTextColor(C.High:GetRGB())
	_G["fmcOptions4Box"..k.."PopOut"..var1].NormalTexture:SetVertexColor(C.High:GetRGB())
	_G["fmcOptions4Box"..k.."PopOut"..var1].HighlightTexture:SetVertexColor(C.Main:GetRGB())
	_G["fmcOptions4Box"..k.."PopOut"..var1].PushedTexture:SetVertexColor(C.High:GetRGB())
end
-- taking care of the edit box --
-- colors --
fmcOptions4Box1EditBox1["GlowTopLeft"]:SetVertexColor(C.Main:GetRGB())
fmcOptions4Box1EditBox1["GlowTopRight"]:SetVertexColor(C.Main:GetRGB())
fmcOptions4Box1EditBox1["GlowBottomLeft"]:SetVertexColor(C.Main:GetRGB())
fmcOptions4Box1EditBox1["GlowBottomRight"]:SetVertexColor(C.Main:GetRGB())
fmcOptions4Box1EditBox1["GlowTop"]:SetVertexColor(C.Main:GetRGB())
fmcOptions4Box1EditBox1["GlowBottom"]:SetVertexColor(C.Main:GetRGB())
fmcOptions4Box1EditBox1["GlowLeft"]:SetVertexColor(C.Main:GetRGB())
fmcOptions4Box1EditBox1["GlowRight"]:SetVertexColor(C.Main:GetRGB())
-- width and height --
local fontFile, height, flags = fmcOptions4Box1EditBox1.WritingLine:GetFont()
fmcOptions4Box1EditBox1.WritingLine:SetHeight(height)
fmcOptions4Box1EditBox1:SetWidth(fmcOptions4Box1:GetWidth()*0.65)
fmcOptions4Box1EditBox1:SetHeight(fmcOptions4Box1EditBox1.WritingLine:GetHeight()*1.75)
fmcOptions4Box1EditBox1.WritingLine:SetWidth(fmcOptions4Box1EditBox1:GetWidth()*0.95)
-- enter --
fmcOptions4Box1EditBox1:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.P_TIP_CREATE, C.Main)
end)
-- leave --
fmcOptions4Box1EditBox1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- pressing enter --
fmcOptions4Box1EditBox1.WritingLine:SetScript("OnEnterPressed", function(self)
	if self:HasText() then
		EditBox_HighlightText(self)
		local name = self:GetText()
		for k, v in pairs(FMCprofiles) do
			if k == name then
				NameExist = true
			else
				NameExist = false
			end
			if NameExist then
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..L.P_WRN_EXIST))
				return
			end
		end
		number = number + 1
		FMCprofiles[name] = {settings = FMCsettings,}
		C_UI.Reload()
	else
		DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..L.P_WRN_NEED))
	end
end)
-- Pop out 1 Buttons loading profiles  --
ColoringPopOutButtons(2, 1)
-- enter --
fmcOptions4Box2PopOut1:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.P_TIP_LOAD, C.Main)
end)
-- leave --
fmcOptions4Box2PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- click --
fmcOptions4Box2PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if fmcOptions4Box2PopOut1Choice1 ~= nil then
			if not fmcOptions4Box2PopOut1Choice1:IsShown() then
				fmcOptions4Box2PopOut1Choice1:Show()
			else
				fmcOptions4Box2PopOut1Choice1:Hide()
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..L.P_WRN_LOAD))
		end
	end
end)
-- Pop out 1 Buttons deleting profiles  --
ColoringPopOutButtons(3, 1)
-- enter --
fmcOptions4Box3PopOut1:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.P_TIP_DELETE, C.Main)
end)
-- leave --
fmcOptions4Box3PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- click --
fmcOptions4Box3PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if fmcOptions4Box3PopOut1Choice1 ~= nil then
			if not fmcOptions4Box3PopOut1Choice1:IsShown() then
				fmcOptions4Box3PopOut1Choice1:Show()
			else
				fmcOptions4Box3PopOut1Choice1:Hide()
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..L.P_WRN_DELETE))
		end
	end
end)
-- finding keys --
local function FindingKeys()
	local Keys = 0
	for k, v in pairs(FMCprofiles) do
		Keys = Keys + 1
	end
	number = Keys
end
-- functions for loading the profiles --
local function LoadingProfiles() -- vdwLoadingProfiles(asv1, asv2, asv3, txt1) 
	if counterLoading == 0 and number > 0 then
		for k, v in pairs(FMCprofiles) do
			counterLoading = counterLoading + 1
			local btn = CreateFrame("Button", "fmcOptions4Box2PopOut1Choice"..counterLoading, nil, "vdwPopOutButton")
			_G["fmcOptions4Box2PopOut1Choice"..counterLoading]:ClearAllPoints()
			if counterLoading == 1 then
				_G["fmcOptions4Box2PopOut1Choice"..counterLoading]:SetParent(fmcOptions4Box2PopOut1)
				_G["fmcOptions4Box2PopOut1Choice"..counterLoading]:SetPoint("TOP", fmcOptions4Box2PopOut1, "BOTTOM", 0, 4)
				_G["fmcOptions4Box2PopOut1Choice"..counterLoading]:SetScript("OnShow", function(self)
					self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
					PlaySound(855, "Master")
				end)
				_G["fmcOptions4Box2PopOut1Choice"..counterLoading]:SetScript("OnHide", function(self)
					self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
					PlaySound(855, "Master")
				end)
			else
				_G["fmcOptions4Box2PopOut1Choice"..counterLoading]:SetParent(fmcOptions4Box2PopOut1Choice1)
				_G["fmcOptions4Box2PopOut1Choice"..counterLoading]:SetPoint("TOP", _G["fmcOptions4Box2PopOut1Choice"..counterLoading-1], "BOTTOM", 0, 0)
				_G["fmcOptions4Box2PopOut1Choice"..counterLoading]:Show()
			end
				_G["fmcOptions4Box2PopOut1Choice"..counterLoading].Text:SetText(k)
				_G["fmcOptions4Box2PopOut1Choice"..counterLoading]:SetWidth(_G["fmcOptions4Box2PopOut1Choice"..counterLoading].Text:GetWidth())
			_G["fmcOptions4Box2PopOut1Choice"..counterLoading]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					FMCsettings = FMCprofiles[k]["settings"]
					C_UI.Reload()
				end
			end)
		local w = _G["fmcOptions4Box2PopOut1Choice"..counterLoading].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for i = 1, counterLoading do
			_G["fmcOptions4Box2PopOut1Choice"..i]:SetWidth(finalW)
		end
	end
end
-- functions for deleting the profiles --
local function DeletingProfiles()
	if counterDeleting == 0 and number > 0 then
		for k, v in pairs(FMCprofiles) do
			counterDeleting = counterDeleting + 1
			local btn = CreateFrame("Button", "fmcOptions4Box3PopOut1Choice"..counterDeleting, nil, "vdwPopOutButton")
			_G["fmcOptions4Box3PopOut1Choice"..counterDeleting]:ClearAllPoints()
			if counterDeleting == 1 then
				_G["fmcOptions4Box3PopOut1Choice"..counterDeleting]:SetParent(fmcOptions4Box3PopOut1)
				_G["fmcOptions4Box3PopOut1Choice"..counterDeleting]:SetPoint("TOP", fmcOptions4Box3PopOut1, "BOTTOM", 0, 4)
				_G["fmcOptions4Box3PopOut1Choice"..counterDeleting]:SetScript("OnShow", function(self)
					self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
					PlaySound(855, "Master")
				end)
				_G["fmcOptions4Box3PopOut1Choice"..counterDeleting]:SetScript("OnHide", function(self)
					self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
					PlaySound(855, "Master")
				end)
			else
				_G["fmcOptions4Box3PopOut1Choice"..counterDeleting]:SetParent(fmcOptions4Box3PopOut1Choice1)
				_G["fmcOptions4Box3PopOut1Choice"..counterDeleting]:SetPoint("TOP", _G["fmcOptions4Box3PopOut1Choice"..counterDeleting-1], "BOTTOM", 0, 0)
				_G["fmcOptions4Box3PopOut1Choice"..counterDeleting]:Show()
			end
				_G["fmcOptions4Box3PopOut1Choice"..counterDeleting].Text:SetText(k)
				_G["fmcOptions4Box3PopOut1Choice"..counterDeleting]:SetWidth(_G["fmcOptions4Box3PopOut1Choice"..counterDeleting].Text:GetWidth())
			_G["fmcOptions4Box3PopOut1Choice"..counterDeleting]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					FMCprofiles[k] = nil
					C_UI.Reload()
				end
			end)
		local w = _G["fmcOptions4Box3PopOut1Choice"..counterDeleting].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for i = 1, counterDeleting do
			_G["fmcOptions4Box3PopOut1Choice"..i]:SetWidth(finalW)
		end
	end
end
fmcOptions4Box2PopOut1.Text:SetText(G.BUTTON_L_CLICK)
fmcOptions4Box3PopOut1.Text:SetText(G.BUTTON_L_CLICK)
FindingKeys()
LoadingProfiles()
DeletingProfiles()
-- Show the option panel --
fmcOptions4:HookScript("OnShow", function(self)
	fmcOptions00Tab1.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	fmcOptions00Tab2.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	fmcOptions00Tab3.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	fmcOptions00Tab4.Text:SetTextColor(C.High:GetRGB())
	if fmcOptions1:IsShown() then fmcOptions1:Hide() end
	if fmcOptions2:IsShown() then fmcOptions2:Hide() end
	if fmcOptions3:IsShown() then fmcOptions3:Hide() end
end)
