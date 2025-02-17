local mod	= DBM:NewMod("NLTrash", "DBM-Party-Legion", 5)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
--mod:SetModelID(47785)
mod:SetZone()

mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 183088 193585 226296",
	"SPELL_AURA_APPLIED 200154 201983",
	"SPELL_PERIODIC_DAMAGE 226388 183407",
	"SPELL_PERIODIC_MISSED 226388 183407",
	"CHAT_MSG_MONSTER_YELL"
)

--Логово Нелтариона трэш
local warnBurningHatred			= mod:NewTargetAnnounce(200154, 3) --Пламенная ненависть
local warnFrenzy				= mod:NewTargetAnnounce(201983, 4) --Бешенство
local warnBound					= mod:NewCastAnnounce(193585, 3) --Скованность
local warnPiercingShards		= mod:NewCastAnnounce(226296, 4) --Острые осколки

local specWarnBound				= mod:NewSpecialWarningInterrupt(193585, "HasInterrupt", nil, nil, 1, 2) --Скованность
local specWarnBurningHatred		= mod:NewSpecialWarningYouRun(200154, nil, nil, nil, 4, 2) --Пламенная ненависть
local specWarnAcidSplatter		= mod:NewSpecialWarningYouMove(183407, nil, nil, nil, 1, 2) --Кислотный всплеск
local specWarnRancidOoze		= mod:NewSpecialWarningYouMove(226388, nil, nil, nil, 1, 2) --Тухлая слизь
local specWarnAvalanche			= mod:NewSpecialWarningDodge(183088, "Tank", nil, nil, 1, 2) --Лавина

local timerFrenzy				= mod:NewTargetTimer(8, 201983, nil, "Tank", nil, 3, nil) --Бешенство

local timerRoleplay				= mod:NewTimer(20, "timerRoleplay", "Interface\\Icons\\Spell_Holy_BorrowedTime", nil, nil, 7) --Ролевая игра

function mod:SPELL_CAST_START(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 183088 and self:AntiSpam(2, 2) then
		specWarnAvalanche:Show()
		specWarnAvalanche:Play("shockwave")
	elseif spellId == 193585 then
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnBound:Show()
			specWarnBound:Play("kickcast")
		else
			warnBound:Show()
			warnBound:Play("kickcast")
		end
	elseif spellId == 226296 then
		warnPiercingShards:Show()
		warnPiercingShards:Play("watchstep")
	end
end

		
function mod:SPELL_AURA_APPLIED(args)
	if not self.Options.Enabled then return end
	local spellId = args.spellId
	if spellId == 200154 and self:AntiSpam(2.5, args.destName) then --Пламенная ненависть
		if args:IsPlayer() then
			specWarnBurningHatred:Show()
			specWarnBurningHatred:Play("targetyou")
		else
			warnBurningHatred:Show(args.destName)
		end
	elseif spellId == 201983 then
		warnFrenzy:Show(args.destName)
		timerFrenzy:Start(args.destName)
	end
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.RoleP1 then
		self:SendSync("RP1")
	end
end

function mod:OnSync(msg, GUID)
	if msg == "RP1" then
		timerRoleplay:Start(20)
	end
end

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 226388 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		if not self:IsNormal() then
			specWarnRancidOoze:Show()
			specWarnRancidOoze:Play("runaway")
		end
	elseif spellId == 183407 and destGUID == UnitGUID("player") and self:AntiSpam(3, 1) then
		if not self:IsNormal() then
			specWarnAcidSplatter:Show()
			specWarnAcidSplatter:Play("runaway")
		end
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
