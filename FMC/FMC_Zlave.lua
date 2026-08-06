-- some variables
FMC = FMC or {}
local Color = VDW.GetAddonColors("FMC")
-- loading first time the variables
local function FirstTimeSavedVariables()
	if FMCprofiles == nil then FMCprofiles = {} end
	if FMCsettings == nil then FMCsettings = {} end
	-- Settings
	-- Specialization
	if FMCsettings.SpecButtons == nil then FMCsettings.SpecButtons = {} end
	if FMCsettings.SpecButtons.Visible == nil then FMCsettings.SpecButtons.Visible = true end
	if FMCsettings.SpecButtons.Size == nil then FMCsettings.SpecButtons.Size = 64 end
	if FMCsettings.SpecButtons.Button1 == nil then FMCsettings.SpecButtons.Button1 = {Position = {X = 0, Y = 540,},} end
	if FMCsettings.SpecButtons.Button2 == nil then FMCsettings.SpecButtons.Button2 = {Position = {X = 80, Y = 540,},} end
	if FMCsettings.SpecButtons.Button3 == nil then FMCsettings.SpecButtons.Button3 = {Position = {X = 160, Y = 540,},} end
	-- loot
	if FMCsettings.LootButtons == nil then FMCsettings.LootButtons = {} end
	if FMCsettings.LootButtons.Visible == nil then FMCsettings.LootButtons.Visible = true end
	if FMCsettings.LootButtons.Size == nil then FMCsettings.LootButtons.Size = 64 end
	if FMCsettings.LootButtons.Button1 == nil then FMCsettings.LootButtons.Button1 = {Position = {X = 0, Y = 440,},} end
	if FMCsettings.LootButtons.Button2 == nil then FMCsettings.LootButtons.Button2 = {Position = {X = 80, Y = 440,},} end
	if FMCsettings.LootButtons.Button3 == nil then FMCsettings.LootButtons.Button3 = {Position = {X = 160, Y = 440,},} end
	if FMCsettings.LootButtons.Button4 == nil then FMCsettings.LootButtons.Button4 = {Position = {X = 240, Y = 440,},} end
	if FMCsettings.LootButtons.Button5 == nil then FMCsettings.LootButtons.Button5 = {Position = {X = 320, Y = 440,},} end
	-- talents
	if FMCsettings.TalentButtons == nil then FMCsettings.TalentButtons = {} end
	if FMCsettings.TalentButtons.Visible == nil then FMCsettings.TalentButtons.Visible = true end
	if FMCsettings.TalentButtons.Position == nil then FMCsettings.TalentButtons.Position = {X = 160, Y = 340} end
	if FMCsettings.TalentButtons.Direction == nil then FMCsettings.TalentButtons.Direction = "Upward" end
	-- animation
	if FMCsettings.TalentAnimation == nil then FMCsettings.TalentAnimation = {} end
	if FMCsettings.TalentAnimation.Visible == nil then FMCsettings.TalentAnimation.Visible = true end
	if FMCsettings.TalentAnimation.Style == nil then FMCsettings.TalentAnimation.Style = "Banner" end
	if FMCsettings.TalentAnimation.Banner == nil then FMCsettings.TalentAnimation.Banner = {} end
	if FMCsettings.TalentAnimation.Banner.Background == nil then FMCsettings.TalentAnimation.Banner.Background = "Class" end
	if FMCsettings.TalentAnimation.Banner.Size == nil then FMCsettings.TalentAnimation.Banner.Size = {W = 400, H = 400} end
	-- removing saved variables
	if FMCsettings.TalentAnimation.Banner.AttachedToCastbar then FMCsettings.TalentAnimation.Banner.AttachedToCastbar = nil end
	if FMCsettings.TalentAnimation.Banner.Position then FMCsettings.TalentAnimation.Banner.Position = nil end
	if FMCsettings.Animation then FMCsettings.Animation = nil end
	if FMCprofilesLayout then FMCprofilesLayout = nil end
	if FMCsettings.LastLocation then FMCsettings.LastLocation = nil end
	if FMCdata then FMCdata = nil end
end
-- events time
local function EventsTime(self, event, arg1, arg2, arg3, arg4)
	if event == "PLAYER_LOGIN" then
		if UnitLevel("player") >= 10 and C_SpecializationInfo.GetSpecialization() ~= 5 then
			VDW.CreateSlashMinmap("FMC", "FMC_Options", "Funky Mojo Changer Options", "fmcOptions", "fmc", "funkymojochanger", Color.Main, Color.High)
			FirstTimeSavedVariables()
			for i = 1, GetNumSpecializations(), 1 do
				local specId, name, _, icon, role = C_SpecializationInfo.GetSpecializationInfo(i)
				FMC["specId"..i] = specId
				FMC["specName"..i] = name
				FMC["specIcon"..i] = icon
				FMC["specRole"..i] = role
			end
		end
	end
end
fmcZlave:SetScript("OnEvent", EventsTime)
