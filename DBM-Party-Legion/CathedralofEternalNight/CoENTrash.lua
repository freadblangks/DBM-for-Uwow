local mod	= DBM:NewMod("CoENTrash", "DBM-Party-Legion", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 239232 237391 238543 236737 242724 242760 239320 239266 241598 239235 239201 237558 237565",
	"SPELL_AURA_APPLIED 238688 239161 237325 237583 237391 236954",
	"SPELL_AURA_APPLIED_DOSE 236954",
	"SPELL_AURA_REMOVED 237391 236954",
	"SPELL_PERIODIC_DAMAGE 213124",
	"SPELL_PERIODIC_MISSED 213124",
	"UNIT_SPELLCAST_START"
)

--Собор вечной ночи трэш
local warnFelStrike				= mod:NewTargetAnnounce(236737, 3) --Удар Скверны
local warnShadowWall			= mod:NewSpellAnnounce(241598, 3) --Стена Тьмы
local warnFelRejuvenation		= mod:NewCastAnnounce(237558, 3) --Омоложение Скверной
--local warnBlisteringRain		= mod:NewCastAnnounce(237565, 4) --Обжигающий дождь
local warnAlluringAroma			= mod:NewCastAnnounce(237391, 4) --Манящий аромат
local warnSinisterFangs			= mod:NewStackAnnounce(236954, 4, nil, nil, 2) --Зловещие клыки
local warnAlluringAroma2		= mod:NewTargetAnnounce(237391, 2) --Манящий аромат

local specWarnVenomousPool		= mod:NewSpecialWarningYouMove(213124, nil, nil, nil, 1, 2) --Ядовитая лужа
local specWarnSinisterFangs		= mod:NewSpecialWarningStack(236954, nil, 2, nil, nil, 1, 3) --Зловещие клыки
local specWarnSinisterFangs2	= mod:NewSpecialWarningDispel(236954, "RemovePoison", nil, nil, 1, 3) --Зловещие клыки
local specWarnAlluringAroma2	= mod:NewSpecialWarningDispel(237391, "MagicDispeller2", nil, nil, 1, 3) --Манящий аромат
local specWarnFelRejuvenation	= mod:NewSpecialWarningInterrupt(237558, "HasInterrupt", nil, nil, 3, 2) --Омоложение Скверной
local specWarnBlisteringRain	= mod:NewSpecialWarningInterrupt(237565, "HasInterrupt", nil, nil, 3, 3) --Обжигающий дождь
local specWarnFelGlare			= mod:NewSpecialWarningDodge(239201, "Melee", nil, nil, 2, 2) --Взор Скверны
local specWarnFocusedDestruction = mod:NewSpecialWarningDefensive(239235, nil, nil, nil, 3, 5) --Направленное разрушение
local specWarnBurningCelerity	= mod:NewSpecialWarningYouMove(237583, nil, nil, nil, 1, 2) --Пылающая стремительность
local specWarnShadowWall		= mod:NewSpecialWarningInterrupt(241598, "HasInterrupt", nil, nil, 1, 2) --Стена Тьмы
local specWarnToxicPollen		= mod:NewSpecialWarningYouMove(237325, nil, nil, nil, 1, 2) --Ядовитая пыльца
local specWarnFelStrike			= mod:NewSpecialWarningDodge(236737, nil, nil, nil, 1, 2) --Удар Скверны
local specWarnAlluringAroma		= mod:NewSpecialWarningInterrupt(237391, "HasInterrupt", nil, nil, 1, 2) --Манящий аромат
local specWarnDemonicMending	= mod:NewSpecialWarningInterrupt(238543, "HasInterrupt", nil, nil, 1, 2) --Демоническое лечение
local specWarnDreadScream		= mod:NewSpecialWarningInterrupt(242724, "HasInterrupt", nil, nil, 1, 2) --Жуткий крик
local specWarnBlindingGlare		= mod:NewSpecialWarningLookAway(239232, nil, nil, nil, 3, 5) --Ослепляющий взгляд
local specWarnLumberingCrash	= mod:NewSpecialWarningRun(242760, "Melee", nil, nil, 4, 2) --Сокрушение древа
local specWarnShadowWave		= mod:NewSpecialWarningDodge(238653, nil, nil, nil, 2, 2) --Теневая волна
local specWarnChokingVines		= mod:NewSpecialWarningRun(238688, nil, nil, nil, 4, 2) --Удушающие лозы
local specWarnTomeSilence		= mod:NewSpecialWarningSwitch(239161, "-Healer", nil, nil, 1, 2) --Фолиант вечной немоты
local specWarnFelblazeOrb		= mod:NewSpecialWarningDodge(239320, nil, nil, nil, 1, 2) --Сфера пламени Скверны
local specWarnVenomStorm		= mod:NewSpecialWarningDodge(239266, nil, nil, nil, 2, 2) --Ядовитая буря

local timerSinisterFangs		= mod:NewTargetTimer(15, 236954, nil, "Tank|RemovePoison", nil, 3, nil, DBM_CORE_POISON_ICON..DBM_CORE_HEALER_ICON) --Зловещие клыки
local timerAlluringAroma		= mod:NewTargetTimer(8, 237391, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Манящий аромат

local yellSinisterFangs			= mod:NewYell(236954, nil, nil, nil, "YELL") --Зловещие клыки
local yellAlluringAroma			= mod:NewYell(237391, nil, nil, nil, "YELL") --Манящий аромат
local yellFelStrike				= mod:NewYell(236737, nil, nil, nil, "YELL") --Удар Скверны

function mod:FelStrikeTarget(targetname, uId)
	if not targetname then
		warnFelStrike:Show(DBM_CORE_UNKNOWN)
		return
	end
	if self:AntiSpam(2, targetname) then--In case two enemies target same target
		if targetname == UnitName("player") then
			specWarnFelStrike:Show()
			specWarnFelStrike:Play("watchstep")
			yellFelStrike:Yell()
		else
			warnFelStrike:CombinedShow(0.5, targetname)
		end
	end
end

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 236737 then
		self:BossTargetScanner(args.sourceGUID, "FelStrikeTarget", 0.1, 9)
	elseif spellId == 239232 then
		specWarnBlindingGlare:Show()
		specWarnBlindingGlare:Play("turnaway")
	elseif spellId == 237391 then --Манящий аромат
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnAlluringAroma:Show()
			specWarnAlluringAroma:Play("kickcast")
		else
			warnAlluringAroma:Show()
			warnAlluringAroma:Play("kickcast")
		end
	elseif spellId == 238543 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDemonicMending:Show(args.sourceName)
		specWarnDemonicMending:Play("kickcast")
	elseif spellId == 242724 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnDreadScream:Show(args.sourceName)
		specWarnDreadScream:Play("kickcast")
	elseif spellId == 241598 then --Стена Тьмы
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnShadowWall:Show()
			specWarnShadowWall:Play("kickcast")
		else
			warnShadowWall:Show()
			warnShadowWall:Play("kickcast")
		end
	elseif spellId == 242760 then
		specWarnLumberingCrash:Show()
		specWarnLumberingCrash:Play("runout")
	elseif spellId == 239320 then
		specWarnFelblazeOrb:Show()
		specWarnFelblazeOrb:Play("watchorb")
	elseif spellId == 239266 then --Ядовитая буря
		specWarnVenomStorm:Show()
		specWarnVenomStorm:Play("watchstep")
	elseif spellId == 239235 then --Направленное разрушение
		specWarnFocusedDestruction:Show()
		specWarnFocusedDestruction:Play("defensive")
	elseif spellId == 239201 then --Взор Скверны
		specWarnFelGlare:Show()
		specWarnFelGlare:Play("watchstep")
	elseif spellId == 237558 then --Омоложение Скверной
		if not self:IsNormal() then
			if self:CheckInterruptFilter(args.sourceGUID, false, true) then
				specWarnFelRejuvenation:Show()
				specWarnFelRejuvenation:Play("kickcast")
			else
				warnFelRejuvenation:Show()
				warnFelRejuvenation:Play("kickcast")
			end
		end
	elseif spellId == 237565 then --Обжигающий дождь
	--	warnBlisteringRain:Show()
		if self:IsHard() then
			specWarnBlisteringRain:Show()
			specWarnBlisteringRain:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 238688 and args:IsPlayer() then
		specWarnChokingVines:Show()
		specWarnChokingVines:Play("runout")
	elseif spellId == 239161 and self:AntiSpam(4, 1) then
		specWarnTomeSilence:Show()
		specWarnTomeSilence:Play("targetchange")
	elseif spellId == 237325 and args:IsPlayer() then --если не робит, то переделать
		specWarnToxicPollen:Show()
		specWarnToxicPollen:Play("runout")
	elseif spellId == 237583 and args:IsPlayer() then --если не робит, то переделать
		specWarnBurningCelerity:Show()
		specWarnBurningCelerity:Play("runout")
	elseif spellId == 237391 then --Манящий аромат
		warnAlluringAroma2:CombinedShow(0.5, args.destName)
		timerAlluringAroma:Start(args.destName)
		if args:IsPlayer() then
			yellAlluringAroma:Yell()
		else
			specWarnAlluringAroma2:Show(args.destName)
			specWarnAlluringAroma2:Play("dispelnow")
		end
	elseif spellId == 236954 then --Зловещие клыки
		local amount = args.amount or 1
		if self:IsHard() then
			timerSinisterFangs:Start(args.destName)
			if amount >= 2 and amount % 2 == 0 then
				if args:IsPlayer() then
					specWarnSinisterFangs:Show(amount)
					specWarnSinisterFangs:Play("stackhigh")
					yellSinisterFangs:Yell()
				else
					warnSinisterFangs:Show(args.destName, amount)
					specWarnSinisterFangs2:Show(args.destName)
					specWarnSinisterFangs2:Play("dispelnow")
				end
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 237391 then --Манящий аромат
		timerAlluringAroma:Cancel(args.destName)
	elseif spellId == 236954 then --Зловещие клыки
		timerSinisterFangs:Cancel(args.destName)
	end
end

function mod:UNIT_SPELLCAST_START(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 238653 then
		self:SendSync("ShadowWave")
	end
end

function mod:OnSync(msg)
	if msg == "ShadowWave" then
		specWarnShadowWave:Show()
		specWarnShadowWave:Play("shockwave")
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 213124 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		if not self:IsNormal() then
			specWarnVenomousPool:Show()
			specWarnVenomousPool:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
