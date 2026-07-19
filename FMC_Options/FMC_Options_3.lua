-- some variables
local Color = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
local maxW = 160
local finalW = 0
local counter = 0
local visibility = {
	{value = false, text = VDWtranslate.Global.HIDE},
	{value = true, text = VDWtranslate.Global.SHOW},
}
local visibilityByValue = {}
for _, option in ipairs(visibility) do
	visibilityByValue[option.value] = option.text
end
local popoutDirection = {
	{value = "Upward", text = VDWtranslate.Global.UPWARD},
	{value = "Downward", text = VDWtranslate.Global.DOWNWARD},
}
local popoutDirectionByValue = {}
for _, option in ipairs(popoutDirection) do
	popoutDirectionByValue[option.value] = option.text
end
local animationStyle = {
	{value = "Banner", text = VDWtranslate.Global.BANNER},
	{value = "Runes", text = VDWtranslate.Global.RUNES},
}
local animationStyleByValue = {}
for _, option in ipairs(animationStyle) do
	animationStyleByValue[option.value] = option.text
end
local bannerBackgroung = {
	{value = "Class", text = VDWtranslate.Global.CLASS},
	{value = "ClassArtifact", text = VDWtranslate.Global.CLASS_ARTIFACT},
}
local bannerBackgroungByValue = {}
for _, option in ipairs(bannerBackgroung) do
	bannerBackgroungByValue[option.value] = option.text
end
local bannerLock = {
	{value = true, text = VDWtranslate.Global.LOCKED},
	{value = false, text = VDWtranslate.Global.UNLOCKED},
}
local bannerLockByValue = {}
for _, option in ipairs(bannerLock) do
	bannerLockByValue[option.value] = option.text
end
-- moving the banner
fmcFrameFX1:RegisterForDrag("RightButton")
local function StopMoving(self)
	FMCsettings.TalentAnimation.Banner.Position.X = Round(self:GetLeft())
	FMCsettings.TalentAnimation.Banner.Position.Y = Round(self:GetBottom())
	self:StopMovingOrSizing()
end
fmcFrameFX1:SetScript("OnDragStart", fmcFrameFX1.StartMoving)
fmcFrameFX1:SetScript("OnDragStop", function(self) StopMoving(self) end)
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
-- animation banner or something else
local function AnimationBannerOr()
	if FMCsettings.TalentAnimation.Style == "Banner" then
		fmcOptions.Panel3.Box3:Show()
		fmcFrameFX1:SetAlpha(1)
		runesDisable()
	elseif FMCsettings.TalentAnimation.Style == "Runes" then
		fmcOptions.Panel3.Box3:Hide()
		fmcFrameFX1:SetAlpha(0)
		runesEnable()
	end
end
-- create panel
VDW.CreateOptionsPanel(fmcOptions.Panel3, VDW.Background.FMC, Color.Main, Color.High, 0, "FMC")
fmcOptions.Panel3.TopTxt:SetText(string.format(VDWtranslate.Global.OPTIONS_FOR, VDWtranslate.Global.TALENT_BUTTONS))
-- create box
fmcOptions.Panel3.Box1.Title:SetText(VDWtranslate.Global.VISIBILITY.." - "..VDWtranslate.Global.DIRECTION)
fmcOptions.Panel3.Box2:SetPoint("TOPLEFT", fmcOptions.Panel3.Box1, "BOTTOMLEFT", 0, 0)
fmcOptions.Panel3.Box2.Title:SetText(VDWtranslate.Global.ANIMATION)
fmcOptions.Panel3.Box3:SetHeight(192)
fmcOptions.Panel3.Box3:SetPoint("TOPLEFT", fmcOptions.Panel3.Box2, "BOTTOMLEFT", 0, 0)
fmcOptions.Panel3.Box3.Title:SetText(VDWtranslate.Global.BANNER)
fmcOptions.Panel3.Box4:SetHeight(128)
fmcOptions.Panel3.Box4:SetPoint("TOPLEFT", fmcOptions.Panel3.Box1, "TOPRIGHT", 0, 0)
fmcOptions.Panel3.Box4.Title:SetText(VDWtranslate.Global.IMPORTANT_NOTES)
fmcOptions.Panel3.Box5:SetHeight(128)
fmcOptions.Panel3.Box5:SetPoint("TOPLEFT", fmcOptions.Panel3.Box4, "BOTTOMLEFT", 0, 0)
fmcOptions.Panel3.Box5.Title:SetText(VDWtranslate.Global.IMPORTANT_NOTES)
for i = 1, 5, 1 do
	VDW.CreateOptionsBox(fmcOptions.Panel3, i, Color.Main, Color.High)
end
-- Box 1, PopOut 1-2 visibility, direction talent buttons
for i = 1, 2, 1 do
	VDW.CreateOptionsPopOut(fmcOptions.Panel3, 1, i, Color.Main, Color.High)
	if i == 1 then
		fmcOptions.Panel3.Box1["PopOut"..i].Title:SetText(VDWtranslate.Global.VISIBILITY)
		fmcOptions.Panel3.Box1["PopOut"..i]:HookScript("OnEnter", function(self)
			VDW.Tooltip_Show(self, prefixTip, string.format(VDWtranslate.Global.VISIBILITY_TIP, VDWtranslate.Global.TALENT_BUTTONS), Color.Main, "Left")
		end)
		for k, v in pairs(visibility) do
			counter = counter + 1
			VDW.CreateOptionsPopOutButtons(fmcOptions.Panel3, 1, i, k, v, Color.Main)
			fmcOptions.Panel3.Box1["PopOut"..i]["Choice"..k]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					FMCsettings.TalentButtons.Visible = v.value
					C_UI.Reload()
				end
			end)
			local w = fmcOptions.Panel3.Box1["PopOut"..i]["Choice"..k].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for c = 1, counter, 1 do
			fmcOptions.Panel3.Box1["PopOut"..i]["Choice"..c]:SetWidth(finalW)
		end
		maxW = 160
		counter = 0
	else
		fmcOptions.Panel3.Box1["PopOut"..i].Title:SetText(VDWtranslate.Global.DIRECTION)
		fmcOptions.Panel3.Box1["PopOut"..i]:HookScript("OnEnter", function(self)
			VDW.Tooltip_Show(self, prefixTip, string.format(VDWtranslate.Global.DIRECTION_POPOUT_TIP, VDWtranslate.Global.TALENTS), Color.Main, "Left")
		end)
		for k, v in pairs(popoutDirection) do
			counter = counter + 1
			VDW.CreateOptionsPopOutButtons(fmcOptions.Panel3, 1, i, k, v, Color.Main)
			fmcOptions.Panel3.Box1["PopOut"..i]["Choice"..k]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					FMCsettings.TalentButtons.Direction = v.value
					C_UI.Reload()
				end
			end)
			local w = fmcOptions.Panel3.Box1["PopOut"..i]["Choice"..k].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for c = 1, counter, 1 do
			fmcOptions.Panel3.Box1["PopOut"..i]["Choice"..c]:SetWidth(finalW)
		end
		maxW = 160
		counter = 0
	end
end
-- Box 2, PopOut 1-2 visibility, style animation
for i = 1, 2, 1 do
	VDW.CreateOptionsPopOut(fmcOptions.Panel3, 2, i, Color.Main, Color.High)
	if i == 1 then
		fmcOptions.Panel3.Box2["PopOut"..i].Title:SetText(VDWtranslate.Global.VISIBILITY)
		fmcOptions.Panel3.Box2["PopOut"..i]:HookScript("OnEnter", function(self)
			local parent = self:GetParent()
			local word = parent.Title:GetText()
			VDW.Tooltip_Show(self, prefixTip, string.format(VDWtranslate.Global.VISIBILITY_TIP, word), Color.Main, "Left")
		end)
		for k, v in pairs(visibility) do
			counter = counter + 1
			VDW.CreateOptionsPopOutButtons(fmcOptions.Panel3, 2, i, k, v, Color.Main)
			fmcOptions.Panel3.Box2["PopOut"..i]["Choice"..k]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					FMCsettings.TalentAnimation.Visible = v.value
					FMC.AnimationSettings()
					if FMCsettings.TalentAnimation.Visible then
						VDW.popEnable(fmcOptions.Panel3.Box2.PopOut2)
						AnimationBannerOr()
					else
						fmcOptions.Panel3.Box3:Hide()
						VDW.popDisable(fmcOptions.Panel3.Box2.PopOut2)
					end
					fmcOptions.Panel3.Box2["PopOut"..i].Text:SetText(self.Text:GetText())
					fmcOptions.Panel3.Box2["PopOut"..i].Choice1:Hide()
				end
			end)
			local w = fmcOptions.Panel3.Box2["PopOut"..i]["Choice"..k].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for c = 1, counter, 1 do
			fmcOptions.Panel3.Box2["PopOut"..i]["Choice"..c]:SetWidth(finalW)
		end
		maxW = 160
		counter = 0
	else
		fmcOptions.Panel3.Box2["PopOut"..i].Title:SetText(VDWtranslate.Global.STYLE)
		fmcOptions.Panel3.Box2["PopOut"..i]:HookScript("OnEnter", function(self)
			local parent = self:GetParent()
			local word = parent.Title:GetText()
			VDW.Tooltip_Show(self, prefixTip, string.format(VDWtranslate.Global.STYLE_TIP, word), Color.Main, "Left")
		end)
		for k, v in pairs(animationStyle) do
			counter = counter + 1
			VDW.CreateOptionsPopOutButtons(fmcOptions.Panel3, 2, i, k, v, Color.Main)
			fmcOptions.Panel3.Box2["PopOut"..i]["Choice"..k]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					FMCsettings.TalentAnimation.Style = v.value
					FMC.AnimationSettings()
					AnimationBannerOr()
					fmcOptions.Panel3.Box2["PopOut"..i].Text:SetText(self.Text:GetText())
					fmcOptions.Panel3.Box2["PopOut"..i].Choice1:Hide()
				end
			end)
			local w = fmcOptions.Panel3.Box2["PopOut"..i]["Choice"..k].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for c = 1, counter, 1 do
			fmcOptions.Panel3.Box2["PopOut"..i]["Choice"..c]:SetWidth(finalW)
		end
		maxW = 160
		counter = 0
	end
end
-- Box 3, PopOut 1-2 lock, style banner
for i = 1, 2, 1 do
	VDW.CreateOptionsPopOut(fmcOptions.Panel3, 3, i, Color.Main, Color.High)
	if i == 1 then
		fmcOptions.Panel3.Box3["PopOut"..i].Title:SetText(VDWtranslate.Global.LOCKING)
		fmcOptions.Panel3.Box3["PopOut"..i]:HookScript("OnEnter", function(self)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LOCKING_TIP_BANNER, Color.Main, "Left")
		end)
		for k, v in pairs(bannerLock) do
			counter = counter + 1
			VDW.CreateOptionsPopOutButtons(fmcOptions.Panel3, 3, i, k, v, Color.Main)
			fmcOptions.Panel3.Box3["PopOut"..i]["Choice"..k]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					FMCsettings.TalentAnimation.Banner.AttachedToCastbar = v.value
					FMC.AnimationSettings()
					fmcOptions.Panel3.Box3["PopOut"..i].Text:SetText(self.Text:GetText())
					fmcOptions.Panel3.Box3["PopOut"..i].Choice1:Hide()
				end
			end)
			local w = fmcOptions.Panel3.Box3["PopOut"..i]["Choice"..k].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for c = 1, counter, 1 do
			fmcOptions.Panel3.Box3["PopOut"..i]["Choice"..c]:SetWidth(finalW)
		end
		maxW = 160
		counter = 0
	else
		fmcOptions.Panel3.Box3["PopOut"..i].Title:SetText(VDWtranslate.Global.STYLE)
		fmcOptions.Panel3.Box3["PopOut"..i]:HookScript("OnEnter", function(self)
			local parent = self:GetParent()
			local word = parent.Title:GetText()
			VDW.Tooltip_Show(self, prefixTip, string.format(VDWtranslate.Global.STYLE_TIP, word), Color.Main, "Left")
		end)
		for k, v in pairs(bannerBackgroung) do
			counter = counter + 1
			VDW.CreateOptionsPopOutButtons(fmcOptions.Panel3, 3, i, k, v, Color.Main)
			fmcOptions.Panel3.Box3["PopOut"..i]["Choice"..k]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					FMCsettings.TalentAnimation.Banner.Background = v.value
					FMC.AnimationSettings()
					fmcOptions.Panel3.Box3["PopOut"..i].Text:SetText(self.Text:GetText())
					fmcOptions.Panel3.Box3["PopOut"..i].Choice1:Hide()
				end
			end)
			local w = fmcOptions.Panel3.Box3["PopOut"..i]["Choice"..k].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for c = 1, counter, 1 do
			fmcOptions.Panel3.Box3["PopOut"..i]["Choice"..c]:SetWidth(finalW)
		end
		maxW = 160
		counter = 0
	end
end
-- Box 3, Slider 1-2, width, height, banner
for i = 1, 2, 1 do
	VDW.CreateOptionsSlider("FMC", fmcOptions.Panel3, 3, i, 120, 440, 120, 440, Color.Main, Color.High)
end
fmcOptions.Panel3.Box3.Slider1.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	fmcOptions.Panel3.Box3.Slider1.TopText:SetText(VDWtranslate.Global.WIDTH..": "..self:GetValue())
	FMCsettings.TalentAnimation.Banner.Size.W = self:GetValue()
	fmcFrameFX1:SetSize(FMCsettings.TalentAnimation.Banner.Size.W, FMCsettings.TalentAnimation.Banner.Size.H)
	PlaySound(858, "Master")
end)
fmcOptions.Panel3.Box3.Slider2.Slider:SetScript("OnValueChanged", function (self, value, userInput)
	fmcOptions.Panel3.Box3.Slider2.TopText:SetText(VDWtranslate.Global.HEIGHT..": "..self:GetValue())
	FMCsettings.TalentAnimation.Banner.Size.H = self:GetValue()
	fmcFrameFX1:SetSize(FMCsettings.TalentAnimation.Banner.Size.W, FMCsettings.TalentAnimation.Banner.Size.H)
	PlaySound(858, "Master")
end)
-- Box 4-5, Notes
for i = 4, 5, 1 do
	VDW.CreateImportantNotes(fmcOptions.Panel3, i, Color.Main)
end
fmcOptions.Panel3.Box4.Notes:SetText("|A:"..C_AddOns.GetAddOnMetadata("FMC", "IconAtlas")..":16:16|a"..Color.High:WrapTextInColorCode(VDWtranslate.Global.NOTE.." 1: ")..VDWtranslate.Global.NOTES_HIDE_SHOW_BUTTONS.."|n|n|A:"..C_AddOns.GetAddOnMetadata("FMC", "IconAtlas")..":16:16|a"..Color.High:WrapTextInColorCode(VDWtranslate.Global.NOTE.." 2: ")..VDWtranslate.Global.NOTES_DIRECTION_BUTTONS)
fmcOptions.Panel3.Box5.Notes:SetText("|A:"..C_AddOns.GetAddOnMetadata("FMC", "IconAtlas")..":16:16|a"..Color.High:WrapTextInColorCode(VDWtranslate.Global.NOTE.." 1: ")..VDWtranslate.Global.NOTES_CHANGE_TALENTS)
-- Checking the Saved Variables --
local function CheckSavedVariables()
	fmcOptions.Panel3.Box1.PopOut1.Text:SetText(visibilityByValue[FMCsettings.TalentButtons.Visible] or VDWtranslate.Global.HIDE)
	if FMCsettings.TalentButtons.Visible then
		VDW.popEnable(fmcOptions.Panel3.Box1.PopOut2)
		fmcOptions.Panel3.Box2:Show()
	else
		VDW.popDisable(fmcOptions.Panel3.Box1.PopOut2)
		fmcOptions.Panel3.Box2:Hide()
	end
	fmcOptions.Panel3.Box1.PopOut2.Text:SetText(popoutDirectionByValue[FMCsettings.TalentButtons.Direction] or VDWtranslate.Global.HIDE)
	-- animation
	fmcOptions.Panel3.Box2.PopOut1.Text:SetText(visibilityByValue[FMCsettings.TalentAnimation.Visible] or VDWtranslate.Global.HIDE)
	if FMCsettings.TalentAnimation.Visible then
		VDW.popEnable(fmcOptions.Panel3.Box2.PopOut2)
		AnimationBannerOr()
	else
		VDW.popDisable(fmcOptions.Panel3.Box2.PopOut2)
		fmcOptions.Panel3.Box3:Hide()
	end
	fmcOptions.Panel3.Box2.PopOut2.Text:SetText(animationStyleByValue[FMCsettings.TalentAnimation.Style] or VDWtranslate.Global.HIDE)
	if FMCsettings.TalentAnimation.Style == "Banner" then
		if FMCsettings.TalentAnimation.Visible then
			fmcOptions.Panel3.Box3:Show()
			fmcFrameFX1:SetAlpha(1)
			runesDisable()
		end
	elseif FMCsettings.TalentAnimation.Style == "Runes" then
		if FMCsettings.TalentAnimation.Visible then
			fmcOptions.Panel3.Box3:Hide()
			fmcFrameFX1:SetAlpha(0)
			runesEnable()
		end
	end
	-- banner
	fmcOptions.Panel3.Box3.PopOut1.Text:SetText(bannerLockByValue[FMCsettings.TalentAnimation.Banner.AttachedToCastbar] or VDWtranslate.Global.HIDE)
	fmcOptions.Panel3.Box3.PopOut2.Text:SetText(bannerBackgroungByValue[FMCsettings.TalentAnimation.Banner.Background] or VDWtranslate.Global.HIDE)
	fmcOptions.Panel3.Box3.Slider1.Slider:SetValue(FMCsettings.TalentAnimation.Banner.Size.W)
	fmcOptions.Panel3.Box3.Slider2.Slider:SetValue(FMCsettings.TalentAnimation.Banner.Size.H)
end
-- Show the option panel --
fmcOptions.Panel3:HookScript("OnShow", function(self)
	for i = 1, 2, 1 do
		fmcOptions["Tab"..i].Text:SetTextColor(0.4, 0.4, 0.4, 1)
		if fmcOptions["Panel"..i]:IsShown() then fmcOptions["Panel"..i]:Hide() end
	end
	fmcOptions.Tab3.Text:SetTextColor(Color.High:GetRGB())
	fmcOptions.Tab4.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	if fmcOptions.Panel4:IsShown() then fmcOptions.Panel4:Hide() end
	CheckSavedVariables()
	fmcFrameFX1:EnableMouse(true)
end)
-- Hide the option panel
fmcOptions.Panel3:HookScript("OnHide", function(self)
	fmcFrameFX1:SetAlpha(0)
	fmcFrameFX1:EnableMouse(false)
	runesDisable()
end)
