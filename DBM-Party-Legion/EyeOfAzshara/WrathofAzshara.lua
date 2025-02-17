local mod	= DBM:NewMod(1492, "DBM-Party-Legion", 3, 716)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(96028)
mod:SetEncounterID(1814)
mod:SetZone()
mod:SetUsedIcons(8, 7)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 192617 192985 192696 197365",
--	"SPELL_CAST_SUCCESS 197365",
	"SPELL_AURA_APPLIED 192706",
	"SPELL_AURA_REMOVED 192706",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Гнев Азшары https://ru.wowhead.com/npc=96028/гнев-азшары/эпохальный-журнал-сражений
local warnArcaneBomb				= mod:NewTargetAnnounce(192706, 4) --Чародейская бомба
local warnMythicTornado				= mod:NewSpellAnnounce(192680, 3) --Волшебный торнадо
local warnRagingStorms				= mod:NewCastAnnounce(192696, 4) --Бушующий шторм
local warnCrushingDepths			= mod:NewTargetAnnounce(197365, 4) --Морская пучина

local specWarnArcaneBomb			= mod:NewSpecialWarningYouMoveAway(192706, nil, nil, nil, 3, 3) --Чародейская бомба
local specWarnArcaneBomb2			= mod:NewSpecialWarningDispel(192706, "MagicDispeller2", nil, nil, 1, 3) --Чародейская бомба
local specWarnArcaneBomb3			= mod:NewSpecialWarningEnd(192706, nil, nil, nil, 1, 2) --Чародейская бомба
local specWarnCrushingDepths		= mod:NewSpecialWarningYouClose(197365, nil, nil, nil, 2, 2) --Морская пучина
local specWarnCrushingDepths2		= mod:NewSpecialWarningYouShare(197365, nil, nil, nil, 3, 5) --Морская пучина
local specWarnMassiveDeluge			= mod:NewSpecialWarningDodge(192617, nil, nil, nil, 2, 2) --Потоп

local timerCrushingDepthsCD			= mod:NewCDTimer(34, 197365, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Морская пучина
local timerMythicTornadoCD			= mod:NewCDTimer(25, 192680, nil, nil, nil, 3) --Волшебный торнадо
local timerMassiveDelugeCD			= mod:NewCDTimer(50, 192617, nil, nil, nil, 2, nil, DBM_CORE_TANK_ICON..DBM_CORE_DEADLY_ICON) --Потоп
local timerArcaneBombCD				= mod:NewCDTimer(30, 192706, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_DEADLY_ICON) --Чародейская бомба+++
local timerArcaneBomb				= mod:NewTargetTimer(15, 192706, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON..DBM_CORE_DEADLY_ICON) --Чародейская бомба+++

local yellArcaneBomb				= mod:NewYell(192706, nil, nil, nil, "YELL") --Чародейская бомба
local yellArcaneBombFades			= mod:NewShortFadesYell(192706, nil, nil, nil, "YELL") --Чародейская бомба
local yellCrushingDepths			= mod:NewYellHelp(197365, nil, nil, nil, "YELL") --Морская пучина
local yellCrushingDepthsFades		= mod:NewShortFadesYell(197365, nil, nil, nil, "YELL") --Морская пучина

local countdownrushingDepths		= mod:NewCountdown(34, 197365, nil, nil, 5) --Морская пучина
local countdownrushingDepths2		= mod:NewCountdownFades("Alt6", 197365, nil, nil, 5) --Морская пучина

mod:AddSetIconOption("SetIconOnCrushingDepths", 197365, true, false, {8}) --Морская пучина
mod:AddSetIconOption("SetIconOnArcaneBomb", 192706, true, false, {7}) --Чародейская бомба
mod:AddRangeFrameOption(10, 192706) --Чародейская бомба

mod.vb.phase = 1
local serpMod = DBM:GetModByName(1479)

function mod:CheckPhase2()
	return 
end

function mod:CrushingDepthsTarget(targetname, uId) --Морская пучина
	if not targetname then return end
	if targetname == UnitName("player") then
		specWarnCrushingDepths2:Show()
		specWarnCrushingDepths2:Play("defensive")
		yellCrushingDepths:Yell()
		yellCrushingDepthsFades:Countdown(6, 3)
	elseif self:CheckNearby(40, targetname) then
		specWarnCrushingDepths:Show(targetname)
		specWarnCrushingDepths:Play("gather")
	else
		warnCrushingDepths:Show(targetname)
	end
	if self.Options.SetIconOnCrushingDepths then
		self:SetIcon(targetname, 7, 6)
	end
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	if not self:IsNormal() then
		timerMythicTornadoCD:Start(9-delay) --Волшебный торнадо +++
		timerMassiveDelugeCD:Start(11.5-delay) --Потоп +++
		timerArcaneBombCD:Start(26-delay) --Чародейская бомба +++
		timerCrushingDepthsCD:Start(20-delay) --Морская пучина +++
	else
		timerMythicTornadoCD:Start(8.5-delay) --Волшебный торнадо
		timerMassiveDelugeCD:Start(12-delay) --Потоп
		timerArcaneBombCD:Start(23-delay) --Чародейская бомба
		timerCrushingDepthsCD:Start(20-delay) --Морская пучина
	end
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 192706 then --Чародейская бомба
		timerArcaneBomb:Start(args.destName)
	--	specWarnArcaneBomb2:Schedule(3, args.destName)
	--	specWarnArcaneBomb2:ScheduleVoice(3, "dispelnow")
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
		if self.Options.SetIconOnArcaneBomb then
			self:SetIcon(args.destName, 8, 15)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 192706 then --Чародейская бомба
		timerArcaneBomb:Cancel(args.destName)
		if args:IsPlayer() then
			specWarnArcaneBomb3:Show()
			yellArcaneBombFades:Cancel()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnArcaneBomb then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 192985 then
		self.vb.phase = 2
		if not serpMod then serpMod = DBM:GetModByName(1479) end
		serpMod:UpdateWinds()--At present it may not actually reset here. Just in case though
	elseif spellId == 192617 then
		specWarnMassiveDeluge:Show()
		specWarnMassiveDeluge:Play("shockwave")
		if self.vb.phase == 2 then
			timerMassiveDelugeCD:Start(35)
		else
			timerMassiveDelugeCD:Start()
		end
	elseif spellId == 192696 then --Бушующий шторм
		warnRagingStorms:Show()
	elseif spellId == 197365 then --Морская пучина
		self:BossTargetScanner(args.sourceGUID, "CrushingDepthsTarget", 0.1, 2)
		timerCrushingDepthsCD:Start(40)
		countdownrushingDepths:Start(40)
		countdownrushingDepths2:Start()
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetname)
	if msg:find("spell:192708") then --Чародейская бомба
		timerArcaneBombCD:Start()
		if targetname == UnitName("player") then
			specWarnArcaneBomb:Show()
			specWarnArcaneBomb:Play("runout")
			yellArcaneBomb:Yell()
			yellArcaneBombFades:Countdown(15, 3)
		else
			warnArcaneBomb:Show(targetname)
			specWarnArcaneBomb2:Schedule(3, targetname)
			specWarnArcaneBomb2:ScheduleVoice(3, "dispelnow")
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 192680 then--Mythic Tornado
		warnMythicTornado:Show()
		if self.vb.phase == 2 then
			timerMythicTornadoCD:Start(15)
		else
			timerMythicTornadoCD:Start()
		end
	end
end
