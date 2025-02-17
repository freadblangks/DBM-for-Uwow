local mod	= DBM:NewMod(1470, "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(95888)
mod:SetEncounterID(1818)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 213576 213583 197251 213685 197422",
	"SPELL_CAST_SUCCESS 197333",
	"SPELL_AURA_APPLIED 205004 197541 216870",
	"SPELL_AURA_REMOVED 206567 197422",
	"SPELL_PERIODIC_DAMAGE 216870",
	"SPELL_PERIODIC_MISSED 216870",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH boss1"
)

--Кордана Оскверненная Песнь https://ru.wowhead.com/npc=95888/кордана-оскверненная-песнь#abilities;mode:
local warnPhase						= mod:NewPhaseChangeAnnounce(1)
local warnPhase2					= mod:NewPrePhaseAnnounce(2, 1, 197422)
local warnDeepeningShadows			= mod:NewSpellAnnounce(213583, 4) --Сгущающиеся тени
local warnCreepingDoom				= mod:NewSpellAnnounce(197422, 4) --Ползучая гибель
local warnCreepingDoom2				= mod:NewSoonAnnounce(197422, 1) --Ползучая гибель

local specWarnFelGlaive				= mod:NewSpecialWarningDodge(197333, nil, nil, nil, 1, 2) --Глефа
local specWarnDeepeningShadows2		= mod:NewSpecialWarningYouMove(213583, "-Tank", nil, nil, 1, 3) --Сгущающиеся тени
local specWarnDetonation			= mod:NewSpecialWarningYouDefensive(197541, nil, nil, nil, 2, 5) --Мгновенный взрыв
local specWarnKick					= mod:NewSpecialWarningSpell(197251, "Tank", nil, nil, 3, 2) --Сбивающий с ног удар
local specWarnDeepeningShadows		= mod:NewSpecialWarningMoveTo(213583, nil, nil, nil, 3, 6) --Сгущающиеся тени
local specWarnHiddenStarted			= mod:NewSpecialWarningSpell(192750, nil, nil, nil, 2, 2) --Пелена тьмы
local specWarnHiddenOver			= mod:NewSpecialWarningEnd(192750, nil, nil, nil, 1, 2) --Пелена тьмы
local specWarnCreepingDoom			= mod:NewSpecialWarningDodge(197422, nil, nil, nil, 2, 5) --Ползучая гибель
local specWarnVengeance				= mod:NewSpecialWarningMoveTo(205004, nil, nil, nil, 3, 6) --Отмщение
local specWarnVengeance2			= mod:NewSpecialWarningSwitch(205004, "-Healer", nil, nil, 3, 5) --Отмщение

--local timerDetonation				= mod:NewTargetTimer(10, 197541, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON) --Мгновенный взрыв
local timerKickCD					= mod:NewCDTimer(16, 197251, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON) --Сбивающий с ног удар 16-42
local timerDeepeningShadowsCD		= mod:NewCDTimer(30.5, 213576, nil, nil, nil, 3) --Сгущающиеся тени
local timerCreepingDoomCD			= mod:NewCDTimer(74.5, 197422, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Ползучая гибель
local timerCreepingDoom				= mod:NewBuffActiveTimer(35, 197422, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Ползучая гибель 35-40
local timerVengeanceCD				= mod:NewCDTimer(35, 205004, nil, nil, nil, 1, nil, DBM_CORE_DAMAGE_ICON) --Отмщение 35-40

local countdownCreepingDoom			= mod:NewCountdown(74.5, 197422, nil, nil, 5) --Ползучая гибель
local countdownCreepingDoom2		= mod:NewCountdownFades("Alt35", 197422, nil, nil, 5) --Ползучая гибель

mod.vb.phase = 1
local warned_preP1 = false
local warned_preP2 = false

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	warned_preP1 = false
	warned_preP2 = false
	timerKickCD:Start(8.3-delay)
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 213576 or spellId == 213583 then
		if ExtraActionBarFrame:IsShown() then--Has light
			specWarnDeepeningShadows:Show(args.spellName)
			specWarnDeepeningShadows:Play("213576")
		else
			warnDeepeningShadows:Show()
		end
		timerDeepeningShadowsCD:Start()
	elseif spellId == 197251 then
		specWarnKick:Show()
		specWarnKick:Play("carefly")
		timerKickCD:Start()
	elseif spellId == 197422 then --первая Ползучая гибель
		specWarnCreepingDoom:Show()
		specWarnCreepingDoom:Play("stilldanger")
		specWarnCreepingDoom:ScheduleVoice(2, "keepmove")
		timerKickCD:Stop()
		timerDeepeningShadowsCD:Stop()
		timerCreepingDoom:Start()
		countdownCreepingDoom2:Start()
		countdownCreepingDoom:Start()
		warnCreepingDoom2:Schedule(69.5)
	elseif spellId == 213685 then --вторая Ползучая гибель
		warnCreepingDoom:Show()
		specWarnCreepingDoom:Show()
		specWarnCreepingDoom:Play("stilldanger")
		specWarnCreepingDoom:ScheduleVoice(2, "keepmove")
		timerCreepingDoom:Start(20)
		countdownCreepingDoom2:Start(20)
		timerCreepingDoomCD:Start(64.5)
		countdownCreepingDoom:Start(64.5)
		warnCreepingDoom2:Schedule(59.5)
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 197333 then --Глефа
		specWarnFelGlaive:Show()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if args.spellId == 205004 then --Отмщение
		if ExtraActionBarFrame:IsShown() then--Has light
			specWarnVengeance:Show(args.spellName)
			specWarnVengeance:Play(205004)
		else
			specWarnVengeance2:Show()
		end
		timerVengeanceCD:Start()
	elseif spellId == 197541 then
	--	timerDetonation:Start(args.destName)
		if args:IsPlayer() then
			specWarnDetonation:Show()
			specWarnDetonation:Play("defensive")
		end
	elseif spellId == 216870 then --Сгущающиеся тени
		if self:IsHard() then
			specWarnDeepeningShadows2:Show()
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 206567 then
		specWarnHiddenOver:Show()
		specWarnHiddenOver:Play("phasechange")
		--timerVengeanceCD:Start(14)
		timerKickCD:Start(15.5)--15-20
		timerDeepeningShadowsCD:Start(20)--20-25
	elseif spellId == 197422 then --Первая ползучая гибель
		timerCreepingDoomCD:Start(39.5)
		timerVengeanceCD:Start(12) --раньше было 14
		timerDeepeningShadowsCD:Start(12)
		timerKickCD:Start(20)--Small sample
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 203416 then--Shadowstep. Faster than 206567 applied
		timerDeepeningShadowsCD:Stop()
		timerKickCD:Stop()
		specWarnHiddenStarted:Show()
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 216870 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if self:IsHard() then
			specWarnDeepeningShadows2:Show()
			specWarnDeepeningShadows2:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_HEALTH(uId)
	if not self:IsNormal() then --гер, миф, миф+ и прошляпанное очко Мурчаля Прошляпенко
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 95888 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			warned_preP1 = true
			warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 95888 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then
			self.vb.phase = 2
			warned_preP2 = true
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
			warnPhase:Play("phasechange")
		end
	else
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 95888 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.51 then
			warned_preP1 = true
		elseif self.vb.phase == 1 and warned_preP1 and not warned_preP2 and self:GetUnitCreatureId(uId) == 95888 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.41 then
			self.vb.phase = 2
			warned_preP2 = true
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
			warnPhase:Play("phasechange")
		end
	end
end
