local mod	= DBM:NewMod("ArcwayTrash", "DBM-Party-Legion", 6)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 211757 226206 211115 211771 193938 226269 211217 211917 211875 210645 210662 210684 211007",
	"SPELL_AURA_APPLIED 194006 210750 211745 211756",
	"SPELL_AURA_REMOVED 211756"
)

--Катакомбы Сурамара трэш
local warnPhaseBreach				= mod:NewCastAnnounce(211115, 4) --Фазовый прорыв
local warnArcaneReconstitution		= mod:NewCastAnnounce(226206, 3) --Чародейское воссоздание
local warnOozeExplosion				= mod:NewCastAnnounce(193938, 4) --Взрыв слизнюка
local warnEyeVortex					= mod:NewCastAnnounce(211007, 4) --Око урагана
--local warnPropheciesofDoom			= mod:NewSpellAnnounce(211771, 4) --Предсказания рока

local specWarnFelstorm				= mod:NewSpecialWarningDodge(211917, nil, nil, nil, 2, 2) --Буря Скверны
local specWarnBladestorm			= mod:NewSpecialWarningRun(211875, "Melee", nil, nil, 4, 3) --Вихрь клинков
local specWarnBladestorm2			= mod:NewSpecialWarningDodge(211875, "Ranged", nil, nil, 2, 2) --Вихрь клинков

local specWarnOozeExplosion			= mod:NewSpecialWarningRun(193938, "Melee", nil, nil, 4, 5) --Взрыв слизнюка
local specWarnOozeExplosion2		= mod:NewSpecialWarningDodge(193938, "Ranged", nil, nil, 2, 2) --Взрыв слизнюка
local specWarnPropheciesofDoom		= mod:NewSpecialWarningDefensive(211771, nil, nil, nil, 3, 5) --Предсказания рока

local specWarnSearingWound			= mod:NewSpecialWarningYou(211756, nil, nil, nil, 1, 3) --Жгучая рана
local specWarnArcaneSlicer			= mod:NewSpecialWarningDodge(211217, nil, nil, nil, 2, 3) --Чародейский рассекатель
local specWarnEyeVortex				= mod:NewSpecialWarningInterrupt(211007, "HasInterrupt", nil, nil, 1, 2) --Око урагана
local specWarnTorment				= mod:NewSpecialWarningInterrupt(226269, "HasInterrupt", nil, nil, 1, 2) --Мучение
local specWarnPhaseBreach			= mod:NewSpecialWarningInterrupt(211115, "HasInterrupt", nil, nil, 3, 5) --Фазовый прорыв
local specWarnArgusPortal			= mod:NewSpecialWarningInterrupt(211757, "HasInterrupt", nil, nil, 1, 2) --Портал на Аргус
local specWarnArcaneReconstitution	= mod:NewSpecialWarningInterrupt(226206, "HasInterrupt", nil, nil, 1, 2) --Чародейское воссоздание
local specWarnArcanicBane			= mod:NewSpecialWarningInterrupt(210645, "HasInterrupt", nil, nil, 1, 2) --Чародейская погибель
local specWarnUnstableFlux			= mod:NewSpecialWarningInterrupt(210662, "HasInterrupt", nil, nil, 1, 2) --Нестабильный поток
local specWarnSiphonEssence			= mod:NewSpecialWarningInterrupt(210684, "HasInterrupt", nil, nil, 1, 2) --Вытягивание сущности

local specWarnOozePuddle			= mod:NewSpecialWarningYouMove(194006, nil, nil, nil, 1, 2) --Лужа слизи
local specWarnColapsingRift			= mod:NewSpecialWarningYouMove(210750, nil, nil, nil, 1, 2) --Смыкающийся разлом
local specWarnFelStrike				= mod:NewSpecialWarningYouMove(211745, nil, nil, nil, 1, 2) --Удар скверны

local timerFelstormCD				= mod:NewCDTimer(23.5, 211917, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Буря Скверны
local timerBladestormCD				= mod:NewCDTimer(23.5, 211875, nil, nil, nil, 3) --Вихрь клинков
local timerSearingWound				= mod:NewTargetTimer(10, 211756, nil, nil, nil, 3, nil, DBM_CORE_HEALER_ICON..DBM_CORE_DEADLY_ICON) --Жгучая рана

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 211757 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnArgusPortal:Show()
		specWarnArgusPortal:Play("kickcast")
	elseif spellId == 226206 then --Чародейское воссоздание
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnArcaneReconstitution:Show()
			specWarnArcaneReconstitution:Play("kickcast")
		else
			warnArcaneReconstitution:Show()
			warnArcaneReconstitution:Play("kickcast")
		end
	elseif spellId == 211115 then --Фазовый прорыв
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnPhaseBreach:Show()
			specWarnPhaseBreach:Play("kickcast")
		else
			warnPhaseBreach:Show()
			warnPhaseBreach:Play("kickcast")
		end
	elseif spellId == 211771 and self:AntiSpam(2, 1) then --Предсказания рока
	--	warnPropheciesofDoom:Show()
		specWarnPropheciesofDoom:Show()
	elseif spellId == 193938 and self:AntiSpam(5, 1) then --Взрыв слизнюка
		warnOozeExplosion:Show()
		specWarnOozeExplosion:Show()
		specWarnOozeExplosion:Play("aesoon")
		specWarnOozeExplosion2:Show()
		specWarnOozeExplosion2:Play("aesoon")
	elseif spellId == 226269 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnTorment:Show()
		specWarnTorment:Play("kickcast")
	elseif spellId == 211217 and self:AntiSpam(2, 1) then --Чародейский рассекатель
		specWarnArcaneSlicer:Show()
		specWarnArcaneSlicer:Play("shockwave")
	elseif spellId == 211917 then --Буря Скверны
		specWarnFelstorm:Show()
		timerFelstormCD:Start()
	elseif spellId == 211875 then --Вихрь клинков
		specWarnBladestorm2:Show()
		specWarnBladestorm:Show()
		timerBladestormCD:Start()
	elseif spellId == 210645 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Чародейская погибель
		specWarnArcanicBane:Show()
		specWarnArcanicBane:Play("kickcast")
	elseif spellId == 210662 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Нестабильный поток
		specWarnUnstableFlux:Show()
		specWarnUnstableFlux:Play("kickcast")
	elseif spellId == 210684 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Вытягивание сущности
		specWarnSiphonEssence:Show()
		specWarnSiphonEssence:Play("kickcast")
	elseif spellId == 211007 then --Око урагана
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnEyeVortex:Show()
			specWarnEyeVortex:Play("kickcast")
		else
			warnEyeVortex:Show()
			warnEyeVortex:Play("kickcast")
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 194006 and args:IsPlayer() then
		specWarnOozePuddle:Show()
		specWarnOozePuddle:Play("runaway")
	elseif spellId == 210750 and args:IsPlayer() then
		specWarnColapsingRift:Show()
		specWarnColapsingRift:Play("runaway")
	elseif spellId == 211745 and args:IsPlayer() then
		specWarnFelStrike:Show()
		specWarnFelStrike:Play("runaway")
	elseif spellId == 211756 and args:IsDestTypePlayer() then --Жгучая рана
		timerSearingWound:Start(args.destName)
		if args:IsPlayer() then
			specWarnSearingWound:Show()
			specWarnSearingWound:Play("targetyou")
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 211756 then --Жгучая рана
		timerSearingWound:Cancel(args.destName)
	end
end
	