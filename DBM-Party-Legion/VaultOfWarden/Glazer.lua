local mod	= DBM:NewMod(1469, "DBM-Party-Legion", 10, 707)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(95887)
mod:SetEncounterID(1817)
mod:SetZone()

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 193443 194942",
	"SPELL_AURA_APPLIED 195034 194333",
	"SPELL_AURA_APPLIED_DOSE 195034",
	"SPELL_AURA_REMOVED 194333",
	"SPELL_PERIODIC_DAMAGE 194945",
	"SPELL_PERIODIC_MISSED 194945"
)

--Смотрящий https://ru.wowhead.com/npc=99865/смотрящий/эпохальный-журнал-сражений
local warnRadiationLevel			= mod:NewStackAnnounce(195034, 4, nil, nil, 2) --Уровень радиации
local warnFocused					= mod:NewSoonAnnounce(194289, 1) --Фокусировка

local specWarnGaze					= mod:NewSpecialWarningDodge(194942, nil, nil, nil, 2, 2) --Подавляющий взгляд
local specWarnBeamed				= mod:NewSpecialWarningMoreDamage(194333, "-Healer", nil, nil, 1, 2) --Облучение
local specWarnFocused				= mod:NewSpecialWarningSwitch(194289, nil, nil, nil, 2, 2) --Фокусировка
local specWarnGazeGTFO				= mod:NewSpecialWarningYouMove(194945, nil, nil, nil, 1, 2) --Подавляющий взгляд

local timerGazeCD					= mod:NewCDTimer(15.5, 194942, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Подавляющий взгляд+++
local timerFocusedCD				= mod:NewCDCountTimer(60, 194289, nil, nil, nil, 7) --Фокусировка+++
local timerFocused					= mod:NewCastTimer(62, 194289, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Фокусировка+++
local timerBeamed					= mod:NewTargetTimer(15, 194333, nil, nil, nil, 3, nil, DBM_CORE_DAMAGE_ICON) --Облучение+++

local countdownFocused				= mod:NewCountdown(60, 194289, nil, nil, 5) --Фокусировка

mod.vb.focusedCount = 0

function mod:OnCombatStart(delay)
	self.vb.focusedCount = 0
	if not self:IsNormal() then
		timerGazeCD:Start(12-delay) --Подавляющий взгляд+++
		timerFocusedCD:Start(30-delay, 1) --Фокусировка+++
		countdownFocused:Start(30-delay) --Фокусировка+++
		warnFocused:Schedule(20-delay) --Фокусировка+++
	else
		timerGazeCD:Start(11.8-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 193443 then --Фокусировка
		self.vb.focusedCount = self.vb.focusedCount + 1
		timerGazeCD:Stop()
		timerFocused:Start()
		specWarnFocused:Show()
		specWarnFocused:Play("specialsoon")
	elseif spellId == 194942 then --Подавляющий взгляд
		specWarnGaze:Show()
		specWarnGaze:Play("watchstep")
		timerGazeCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 195034 then --Уровень радиации
		local amount = args.amount or 1
		if not self:IsNormal() then
			if amount >= 10 and amount % 5 == 0 then
				warnRadiationLevel:Show(args.destName, amount)
			end
		end
	elseif spellId == 194333 then --Облучение
		timerBeamed:Start(args.destName)
		timerFocused:Stop()
		specWarnBeamed:Show()
		timerFocusedCD:Start(nil, self.vb.focusedCount+1)
		countdownFocused:Start()
		warnFocused:Schedule(50)
		timerGazeCD:Start(6)
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 194333 then --Облучение
		timerBeamed:Cancel(args.destName)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 194945 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then --Подавляющий взгляд
		if not self:IsNormal() then
			specWarnGazeGTFO:Show()
			specWarnGazeGTFO:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
