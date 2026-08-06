-- some aliases
local Color = VDW.GetAddonColors("FMC")
local prefixTip = VDW.Prefix("FMC")
-- some variables
local maxW = 160
local finalW = 0
local counter = 0
local duration = 0
local CastbarOverlay = false
local configID = 0
local specID = 0
local loadoutIndex = 0
local function CheckLoadPlayerSpellsFrame()
	if not PlayerSpellsFrame then
		PlayerSpellsFrame_LoadUI()
		fmcWarning:ClearAllPoints()
		fmcWarning:SetPoint("TOP", PlayerSpellsFrame, "BOTTOM", 0, 20)
		PlayerSpellsFrame.TalentsFrame:HookScript("OnShow", function(self)
			local FrameSlectionID = PlayerSpellsFrame.TalentsFrame.LoadSystem.lastValidSelectionID
			local TrueSelectionID = C_ClassTalents.GetLastSelectedSavedConfigID(FMC["specId"..GetSpecialization()])
			if TrueSelectionID ~= nil then
				if FrameSlectionID ~= TrueSelectionID then
					local configInfo = C_Traits.GetConfigInfo(TrueSelectionID)
					fmcWarning:Show()
					fmcWarning.Box1.Notes:SetText(string.format("|A:"..C_AddOns.GetAddOnMetadata("FMC", "IconAtlas")..":16:16|a "..VDWtranslate.Global.TALENTS_NOT_SAME, Color.High:WrapTextInColorCode(configInfo.name)))
					--self:SetConfigID(TrueSelectionID, true)
				end
			end
		end)
		PlayerSpellsFrame.TalentsFrame:HookScript("OnHide", function(self)
			if fmcWarning:IsShown() then fmcWarning:Hide() end
		end)
	end
end
-- Create frame warning
VDW.CreateOptionsPanel(fmcWarning, VDW.Background.FMC, Color.Main, Color.High, 0, "FMC")
VDW.CreateOptionsBox(fmcWarning, 1, Color.Main, Color.High)
fmcWarning.Box1.Title:SetText(VDWtranslate.Global.IMPORTANT_NOTES)
VDW.CreateImportantNotes(fmcWarning, 1, Color.Main)
fmcWarning.ExitButton:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.CLOSE_THIS_PANEL, Color.Main, "Left")
end)
-- Create buttons
local function CreateButtons()
-- stoping the movement
	local function StopMoving(self, i)
		FMCsettings.TalentButtons.Position.X = Round(self:GetLeft())
		FMCsettings.TalentButtons.Position.Y = Round(self:GetBottom())
		self:StopMovingOrSizing()
	end
-- creating button
	for i = 1, GetNumSpecializations(), 1 do
		local btn = CreateFrame("Button", "fmcPopOutTalents"..i, UIParent, "vdwPopOut")
		_G["fmcPopOutTalents"..i]:ClearAllPoints()
		_G["fmcPopOutTalents"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", FMCsettings["TalentButtons"]["Position"]["X"], FMCsettings["TalentButtons"]["Position"]["Y"])
		_G["fmcPopOutTalents"..i].NormalTexture:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		_G["fmcPopOutTalents"..i].PushedTexture:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		_G["fmcPopOutTalents"..i].HighlightTexture:SetVertexColor(VDW.PlayerClassColor:GetRGB())
		_G["fmcPopOutTalents"..i]:Show()
		for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(FMC["specId"..i])) do
			for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
				if sk == "name" then
					counter = counter + 1
					local btn = CreateFrame("Button", "fmcPopOutTalents"..i.."Button"..fk, nil, "vdwPopOutButton")
					_G["fmcPopOutTalents"..i.."Button"..fk]:ClearAllPoints()
					if fk == 1 then
						_G["fmcPopOutTalents"..i.."Button"..fk]:SetParent(_G["fmcPopOutTalents"..i])
						if FMCsettings["TalentButtons"]["Direction"] == "Upward" then
							_G["fmcPopOutTalents"..i].NormalTexture:SetRotation(math.pi)
							_G["fmcPopOutTalents"..i].HighlightTexture:SetRotation(math.pi)
							_G["fmcPopOutTalents"..i.."Button"..fk]:SetPoint("BOTTOM", "fmcPopOutTalents"..i, "TOP", 0, 0)
						elseif FMCsettings["TalentButtons"]["Direction"] == "Downward" then
							_G["fmcPopOutTalents"..i.."Button"..fk]:SetPoint("TOP", "fmcPopOutTalents"..i, "BOTTOM", 0, 0)
						end
						_G["fmcPopOutTalents"..i.."Button"..fk]:SetScript("OnShow", function(self)
							self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
							PlaySound(SOUNDKIT.IG_MINIMAP_OPEN, "Master")
						end)
						_G["fmcPopOutTalents"..i.."Button"..fk]:SetScript("OnHide", function(self)
							self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
							PlaySound(SOUNDKIT.IG_MINIMAP_CLOSE, "Master")
						end)
					else
						if FMCsettings["TalentButtons"]["Direction"] == "Upward" then
							_G["fmcPopOutTalents"..i.."Button"..fk]:SetParent(_G["fmcPopOutTalents"..i.."Button1"])
							_G["fmcPopOutTalents"..i.."Button"..fk]:SetPoint("BOTTOM", _G["fmcPopOutTalents"..i.."Button"..fk-1], "TOP", 0, 0)
						elseif FMCsettings["TalentButtons"]["Direction"] == "Downward" then
							_G["fmcPopOutTalents"..i.."Button"..fk]:SetParent(_G["fmcPopOutTalents"..i.."Button1"])
							_G["fmcPopOutTalents"..i.."Button"..fk]:SetPoint("TOP", _G["fmcPopOutTalents"..i.."Button"..fk-1], "BOTTOM", 0, 0)
						end
						_G["fmcPopOutTalents"..i.."Button"..fk]:Show()
					end
					_G["fmcPopOutTalents"..i.."Button"..fk].Text:SetText(fk..". "..sv)
					_G["fmcPopOutTalents"..i.."Button"..fk]:SetScript("OnClick", function(self, button, down)
						if button == "LeftButton" and down == false then
							if IsPlayerMoving() then
								DEFAULT_CHAT_FRAME:AddMessage(Color.Main:WrapTextInColorCode(VDW.PrefixChat("FMC").." "..VDWtranslate.Global.MOVING_LOCKDOWN))
								UIErrorsFrame:AddExternalWarningMessage(VDW.PrefixError("FMC").." "..VDWtranslate.Global.MOVING_LOCKDOWN)
							else
								C_ClassTalents.LoadConfig(fv, true)
								configID = fv
								specID = FMC["specId"..i]
								loadoutIndex = fk
							end
							_G["fmcPopOutTalents"..i.."Button1"]:Hide()
						end
					end)
					local w = _G["fmcPopOutTalents"..i.."Button"..fk].Text:GetStringWidth()
					if w > maxW then maxW = w end
				end
			end
		end
		finalW = math.ceil(maxW + 24)
		for k = 1, counter, 1 do
			_G["fmcPopOutTalents"..i.."Button"..k]:SetWidth(finalW)
		end
		counter = 0
		maxW = 160
		_G["fmcPopOutTalents"..i]:HookScript("OnClick", function(self, button, down)
			if button == "LeftButton" and down == false then
				if not _G["fmcPopOutTalents"..i.."Button1"]:IsShown() then
					_G["fmcPopOutTalents"..i.."Button1"]:Show()
				else
					_G["fmcPopOutTalents"..i.."Button1"]:Hide()
				end
			end
		end)
		_G["fmcPopOutTalents"..i]:HookScript("OnEnter", function (self)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.LEFT_CLICK.." "..VDWtranslate.Global.TALENT_BUTTONS_TIP.."|n|n"..VDWtranslate.Global.RIGHT_CLICK.." "..VDWtranslate.Global.DRAG_ME_TO_MOVE, Color.Main, "Left")
		end)
		_G["fmcPopOutTalents"..i]:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- moving the buttons
		_G["fmcPopOutTalents"..i]:SetMovable(true)
		_G["fmcPopOutTalents"..i]:RegisterForDrag("RightButton")
		_G["fmcPopOutTalents"..i]:SetScript("OnDragStart", _G["fmcPopOutTalents"..i].StartMoving)
		_G["fmcPopOutTalents"..i]:SetScript("OnDragStop", function(self) StopMoving(self, i) end)
	end
end
-- Show-hide talent popout button
local function ShowHideTalentsPopOut()
	for i = 1, GetNumSpecializations(), 1 do
		_G["fmcPopOutTalents"..i]:ClearAllPoints()
		_G["fmcPopOutTalents"..i]:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", FMCsettings["TalentButtons"]["Position"]["X"], FMCsettings["TalentButtons"]["Position"]["Y"])
	end
	if GetSpecialization() == 1 then
		fmcPopOutTalents1:Show()
		fmcPopOutTalents2:Hide()
		fmcPopOutTalents3:Hide()
		if fmcPopOutTalents4 then fmcPopOutTalents4:Hide() end
	elseif GetSpecialization() == 2 then
		fmcPopOutTalents1:Hide()
		fmcPopOutTalents2:Show()
		fmcPopOutTalents3:Hide()
		if fmcPopOutTalents4 then fmcPopOutTalents4:Hide() end
	elseif GetSpecialization() == 3 then
		fmcPopOutTalents1:Hide()
		fmcPopOutTalents2:Hide()
		fmcPopOutTalents3:Show()
		if fmcPopOutTalents4 then fmcPopOutTalents4:Hide() end
	elseif GetSpecialization() == 4 then
		fmcPopOutTalents1:Hide()
		fmcPopOutTalents2:Hide()
		fmcPopOutTalents3:Hide()
		if fmcPopOutTalents4 then fmcPopOutTalents4:Show() end
	end
end
-- Before checking
local function BeforeCheckingTalentsChanged()
	if CastbarOverlay then
		C_ClassTalents.UpdateLastSelectedSavedConfigID(FMC["specId"..GetSpecialization()], PlayerSpellsFrame.TalentsFrame.LoadSystem.lastValidSelectionID)
		CastbarOverlay = false
	else
		C_ClassTalents.UpdateLastSelectedSavedConfigID(FMC["specId"..GetSpecialization()], configID)
	end
end
-- Check talents
local function CheckTalents()
	if GetSpecialization() == 1 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(FMC.specId1)
		if chkTalentID == nil then
			fmcPopOutTalents1.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(FMC.specId1)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents1.Text:SetText(fk..". "..sv)
						FMC.TalentsName = sv
						local heroSpecID = C_ClassTalents.GetActiveHeroTalentSpec()
						if heroSpecID then
							local subTreeInfo = C_Traits.GetSubTreeInfo(fv, heroSpecID)
							FMC.HeroName = subTreeInfo.name
						else
							FMC.HeroName = VDWtranslate.Global.HERO_NOT_SELECTED
						end
					end
				end
			end
		end
	elseif GetSpecialization() == 2 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(FMC.specId2)
		if chkTalentID == nil then
			fmcPopOutTalents2.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(FMC.specId2)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents2.Text:SetText(fk..". "..sv)
						FMC.TalentsName = sv
						local heroSpecID = C_ClassTalents.GetActiveHeroTalentSpec()
						if heroSpecID then
							local subTreeInfo = C_Traits.GetSubTreeInfo(fv, heroSpecID)
							FMC.HeroName = subTreeInfo.name
						else
							FMC.HeroName = VDWtranslate.Global.HERO_NOT_SELECTED
						end
					end
				end
			end
		end
	elseif GetSpecialization() == 3 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(FMC.specId3)
		if chkTalentID == nil then
			fmcPopOutTalents3.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(FMC.specId3)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents3.Text:SetText(fk..". "..sv)
						FMC.TalentsName = sv
						local heroSpecID = C_ClassTalents.GetActiveHeroTalentSpec()
						if heroSpecID then
							local subTreeInfo = C_Traits.GetSubTreeInfo(fv, heroSpecID)
							FMC.HeroName = subTreeInfo.name
						else
							FMC.HeroName = VDWtranslate.Global.HERO_NOT_SELECTED
						end
					end
				end
			end
		end
	elseif GetSpecialization() == 4 then
		local chkTalentID = C_ClassTalents.GetLastSelectedSavedConfigID(FMC.specId4)
		if chkTalentID == nil then
			fmcPopOutTalents4.Text:SetText("Starter Build")
		else
			for fk, fv in pairs(C_ClassTalents.GetConfigIDsBySpecID(FMC.specId4)) do
				for sk, sv in pairs (C_Traits.GetConfigInfo(fv)) do
					if fv == chkTalentID and sk == "name" then
						fmcPopOutTalents4.Text:SetText(fk..". "..sv)
						FMC.TalentsName = sv
						local heroSpecID = C_ClassTalents.GetActiveHeroTalentSpec()
						if heroSpecID then
							local subTreeInfo = C_Traits.GetSubTreeInfo(fv, heroSpecID)
							FMC.HeroName = subTreeInfo.name
						else
							FMC.HeroName = VDWtranslate.Global.HERO_NOT_SELECTED
						end
					end
				end
			end
		end
	end
end
-- animations --
-- function for the class banner --
local function ChoosingBackground1(self)
	if VDW.PlayerClassID == 1 then --Warrior
		self:SetAtlas("talents-animations-class-warrior")
	elseif VDW.PlayerClassID == 2 then --Paladin
		self:SetAtlas("talents-animations-class-paladin")
	elseif VDW.PlayerClassID == 3 then --Hunter
		self:SetAtlas("talents-animations-class-hunter")
	elseif VDW.PlayerClassID == 4 then --Rogue
		self:SetAtlas("talents-animations-class-rogue")
	elseif VDW.PlayerClassID == 5 then --Priest
		self:SetAtlas("talents-animations-class-priest")
	elseif VDW.PlayerClassID == 6 then --Death Kight
		self:SetAtlas("talents-animations-class-deathknight")
	elseif VDW.PlayerClassID == 7 then --Shaman
		self:SetAtlas("talents-animations-class-shaman")
	elseif VDW.PlayerClassID == 8 then --Mage
		self:SetAtlas("talents-animations-class-mage")
	elseif VDW.PlayerClassID == 9 then --Warlock
		self:SetAtlas("talents-animations-class-warlock")
	elseif VDW.PlayerClassID == 10 then --Monk
		self:SetAtlas("talents-animations-class-monk")
	elseif VDW.PlayerClassID == 11 then --Druid
		self:SetAtlas("talents-animations-class-druid")
	elseif VDW.PlayerClassID == 12 then --Demon Hunter
		self:SetAtlas("talents-animations-class-demonhunter")
	elseif VDW.PlayerClassID == 13 then --Evoker
		self:SetAtlas("talents-animations-class-evoker")
		self:SetAlpha(1)
	end
end
local function ChoosingBackground2(self)
	if VDW.PlayerClassID == 1 then --Warrior
		self:SetAtlas("Artifacts-Warrior-BG-rune")
	elseif VDW.PlayerClassID == 2 then --Paladin
		self:SetAtlas("Artifacts-Paladin-BG-rune")
	elseif VDW.PlayerClassID == 3 then --Hunter
		self:SetAtlas("Artifacts-Hunter-BG-rune")
	elseif VDW.PlayerClassID == 4 then --Rogue
		self:SetAtlas("Artifacts-Rogue-BG-rune")
	elseif VDW.PlayerClassID == 5 then --Priest
		self:SetAtlas("Artifacts-Priest-BG-rune")
	elseif VDW.PlayerClassID == 6 then --Death Kight
		self:SetAtlas("Artifacts-DeathKnightFrost-BG-Rune")
	elseif VDW.PlayerClassID == 7 then --Shaman
		self:SetAtlas("Artifacts-Shaman-BG-rune")
	elseif VDW.PlayerClassID == 8 then --Mage
		self:SetAtlas("Artifacts-MageArcane-BG-rune")
	elseif VDW.PlayerClassID == 9 then --Warlock
		self:SetAtlas("Artifacts-Warlock-BG-rune")
	elseif VDW.PlayerClassID == 10 then --Monk
		self:SetAtlas("Artifacts-Monk-BG-rune")
	elseif VDW.PlayerClassID == 11 then --Druid
		self:SetAtlas("Artifacts-Druid-BG-rune")
	elseif VDW.PlayerClassID == 12 then --Demon Hunter
		self:SetAtlas("Artifacts-DemonHunter-BG-rune")
	elseif VDW.PlayerClassID == 13 then --Evoker
		self:SetTexture("Interface\\AddOns\\VDW\\media\\banners\\Dracthyr_Crest.png")
		self:SetAlpha(0.25)
	end
end
-- position and background of banner
function FMC.AnimationSettings()
	if FMCsettings.TalentAnimation.Visible then
		if FMCsettings.TalentAnimation.Style == "Banner" then
			fmcFrameFX1:Show()
			fmcFrameFX2:Hide()
			fmcFrameFX1:ClearAllPoints()
			fmcFrameFX1:SetPoint("CENTER", PlayerCastingBarFrame, "CENTER", 0, 0)
			fmcFrameFX1:SetSize(FMCsettings.TalentAnimation.Banner.Size.W, FMCsettings.TalentAnimation.Banner.Size.H)
			if FMCsettings.TalentAnimation.Banner.Background == "Class" then
				ChoosingBackground1(fmcFrameFX1Background)
			elseif FMCsettings.TalentAnimation.Banner.Background == "ClassArtifact" then
				ChoosingBackground2(fmcFrameFX1Background)
			end
		elseif FMCsettings.TalentAnimation.Style == "Runes" then
			fmcFrameFX1:Hide()
			fmcFrameFX2:Show()
		end
	else
		fmcFrameFX1:Hide()
		fmcFrameFX2:Hide()
	end
end
-- animation play
local function PlayAnimation()
	local durationSec = duration:GetTotalDuration(Enum.DurationTimeModifier.RealTime)
	if FMCsettings.TalentAnimation.Style == "Banner" then
		fmcFrameFX1.Animation.Main:SetDuration(durationSec)
		fmcFrameFX1.Animation:Play()
	elseif FMCsettings.TalentAnimation.Style == "Runes" then
		fmcFrameFX2.Animation.Rune1b:SetDuration(durationSec/5)
		fmcFrameFX2.Animation.Rune1:SetDuration(durationSec/5)
		fmcFrameFX2.Animation.Rune2b:SetStartDelay(durationSec/5)
		fmcFrameFX2.Animation.Rune2:SetStartDelay((durationSec/5) + 0.15)
		fmcFrameFX2.Animation.Rune2:SetDuration(durationSec/5)
		fmcFrameFX2.Animation.Rune3b:SetStartDelay((durationSec/5)*2)
		fmcFrameFX2.Animation.Rune3:SetStartDelay(((durationSec/5)*2) + 0.15)
		fmcFrameFX2.Animation.Rune3:SetDuration(durationSec/5)
		fmcFrameFX2.Animation.Rune4b:SetStartDelay((durationSec/5)*3)
		fmcFrameFX2.Animation.Rune4:SetStartDelay(((durationSec/5)*3) + 0.15)
		fmcFrameFX2.Animation.Rune4:SetDuration(durationSec/5)
		fmcFrameFX2.Animation.Rune5b:SetStartDelay((durationSec/5)*4)
		fmcFrameFX2.Animation.Rune5:SetStartDelay(((durationSec/5)*4) + 0.15)
		fmcFrameFX2.Animation.Rune5:SetDuration(durationSec/5)
		fmcFrameFX2.Animation:Play()
	end
end
-- animation stop
local function StopAnimation()
	if fmcFrameFX1.Animation:IsPlaying() then
		fmcFrameFX1.Animation:Stop()
	elseif fmcFrameFX2.Animation:IsPlaying() then
		fmcFrameFX2.Animation:Stop()
	end
end
-- events time
local function EventsTime(self, event, arg1, arg2, arg3, arg4)
	if event == "PLAYER_LOGIN" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings.TalentButtons.Visible then
				CheckLoadPlayerSpellsFrame()
				FMC.AnimationSettings()
				CreateButtons()
				ShowHideTalentsPopOut()
				CheckTalents()
			else
				FMC.TalentsName = VDWtranslate.Global.TALENT_BUTTONS_NOT_SHOWN
				FMC.HeroName = VDWtranslate.Global.TALENT_BUTTONS_NOT_SHOWN
			end
		else
			FMC.TalentsName = VDWtranslate.Global.TALENT_BUTTONS_LOW_LVL
			FMC.HeroName = VDWtranslate.Global.TALENT_BUTTONS_LOW_LVL
		end
	elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings.TalentButtons.Visible then
				ShowHideTalentsPopOut()
				CheckTalents()
			else
				FMC.TalentsName = VDWtranslate.Global.TALENT_BUTTONS_NOT_SHOWN
				FMC.HeroName = VDWtranslate.Global.TALENT_BUTTONS_NOT_SHOWN
			end
		else
			FMC.TalentsName = VDWtranslate.Global.TALENT_BUTTONS_LOW_LVL
			FMC.HeroName = VDWtranslate.Global.TALENT_BUTTONS_LOW_LVL
		end
	elseif event == "UNIT_SPELLCAST_START" and arg1 == "player" and arg3 == 384255 then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if OverlayPlayerCastingBarFrame.showCastbar then CastbarOverlay = true end
			if FMCsettings.TalentButtons.Visible and FMCsettings.TalentAnimation.Visible then
				duration = UnitCastingDuration(arg1)
				PlayAnimation()
			end
		end
	elseif event == "UNIT_SPELLCAST_INTERRUPTED" and arg1 == "player" and arg3 == 384255 then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings.TalentButtons.Visible and FMCsettings.TalentAnimation.Visible then
				StopAnimation()
			end
		end
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" and arg1 == "player" and arg3 == 384255 then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			if FMCsettings.TalentButtons.Visible then
				C_Timer.After(0.5, function()
					BeforeCheckingTalentsChanged()
					CheckTalents()
				end)
				if FMCsettings.TalentAnimation.Visible then StopAnimation() end
			else
				FMC.TalentsName = VDWtranslate.Global.TALENT_BUTTONS_NOT_SHOWN
				FMC.HeroName = VDWtranslate.Global.TALENT_BUTTONS_NOT_SHOWN
			end
		else
			FMC.TalentsName = VDWtranslate.Global.TALENT_BUTTONS_LOW_LVL
			FMC.HeroName = VDWtranslate.Global.TALENT_BUTTONS_LOW_LVL
		end
	end
end
fmcZlave:HookScript("OnEvent", EventsTime)
