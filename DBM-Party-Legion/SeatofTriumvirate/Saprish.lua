local mod	= DBM:NewMod(1980, "DBM-Party-Legion", 13, 945)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(124872)
mod:SetEncounterID(2066)
mod:SetZone()
mod:SetUsedIcons(8, 7, 6)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 245802 248831",
	"SPELL_CAST_SUCCESS 247245 247175",
	"SPELL_AURA_APPLIED 247245",
	"SPELL_AURA_REMOVED 247245",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

--Сарпиш https://ru.wowhead.com/npc=122316/сарпиш/эпохальный-журнал-сражений
local warnUmbralFlanking				= mod:NewTargetAnnounce(247245, 3) --Призрачный удар
local warnVoidTrap						= mod:NewSpellAnnounce(246026, 3, nil, nil, nil, nil, nil, 2) --Ловушка Бездны
--local warnDreadScreech					= mod:NewCastAnnounce(248831, 2)

--local specWarnHuntersRush				= mod:NewSpecialWarningDefensive(247145, "Tank", nil, nil, 1, 2)
--local specWarnOverloadTrap				= mod:NewSpecialWarningDodge(247206, nil, nil, nil, 2, 2) --Заряженные ловушки
local specWarnUmbralFlanking			= mod:NewSpecialWarningYouMoveAway(247245, nil, nil, nil, 1, 2) --Призрачный удар
local specWarnRavagingDarkness			= mod:NewSpecialWarningDodge(245802, nil, nil, nil, 2, 3) --Опустошающая тьма
local specWarnDreadScreech				= mod:NewSpecialWarningInterrupt(248831, "HasInterrupt", nil, nil, 3, 5) --Ужасный визг

local timerVoidTrapCD					= mod:NewCDTimer(16, 247175, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Ловушка Бездны +++
--local timerOverloadTrapCD				= mod:NewCDTimer(20.6, 247206, nil, nil, nil, 3) --Заряженные ловушки
local timerRavagingDarknessCD			= mod:NewCDTimer(9.5, 245802, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Опустошающая тьма +++
local timerUmbralFlankingCD				= mod:NewCDTimer(35.2, 247245, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Призрачный удар +++
local timerScreechCD					= mod:NewCDTimer(15.8, 248831, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_MYTHIC_ICON) --Ужасный визг

local yellUmbralFlanking				= mod:NewYell(247245, nil, nil, nil, "YELL") --Призрачный удар

--local countdownBreath					= mod:NewCountdown(22, 227233)

mod:AddSetIconOption("SetIconOnUmbralFlanking", 247245, true, false, {8, 7, 6}) --Призрачный удар

mod.vb.umbralflankingIcon = 8

function mod:OnCombatStart(delay)
	self.vb.umbralflankingIcon = 8
	if self:IsHard() then
		timerRavagingDarknessCD:Start(5-delay) --Опустошающая тьма +++
		timerVoidTrapCD:Start(9-delay) --Ловушка Бездны возможно 10 +++
	--	timerOverloadTrapCD:Start(12.5-delay) --Заряженные ловушки
		timerUmbralFlankingCD:Start(21-delay) --Призрачный удар +++
		timerScreechCD:Start(6-delay) --Ужасный визг +++
	else
		timerRavagingDarknessCD:Start(5.5-delay) --Опустошающая тьма
		timerVoidTrapCD:Start(8.8-delay) --Ловушка Бездны
	--	timerOverloadTrapCD:Start(12.5-delay) --Заряженные ловушки
		timerUmbralFlankingCD:Start(20.4-delay) --Призрачный удар
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 245802 then
		specWarnRavagingDarkness:Show()
		specWarnRavagingDarkness:Play("watchstep")
		timerRavagingDarknessCD:Start()
	elseif spellId == 248831 then --Ужасный визг
		specWarnDreadScreech:Show()
		specWarnDreadScreech:Play("kickcast")
		timerScreechCD:Start() 
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247245 then
		timerUmbralFlankingCD:Start()
	elseif spellId == 247175 then --Ловушка Бездны
		warnVoidTrap:Show()
		warnVoidTrap:Play("watchstep")
		timerVoidTrapCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247245 then
		warnUmbralFlanking:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnUmbralFlanking:Show()
			specWarnUmbralFlanking:Play("scatter")
			yellUmbralFlanking:Yell()
		end
		if self.Options.SetIconOnUmbralFlanking then
			self:SetIcon(args.destName, self.vb.umbralflankingIcon)
		end
		self.vb.umbralflankingIcon = self.vb.umbralflankingIcon - 1
--	elseif spellId == 247145 then
--		specWarnHuntersRush:Show()
--		specWarnHuntersRush:Play("defensive")
	end
end


function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 247245 then
		self.vb.umbralflankingIcon = self.vb.umbralflankingIcon + 1
		if self.Options.SetIconOnUmbralFlanking then
			self:SetIcon(args.destName, 0)
		end
	end
end
--[[
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("inv_misc_monsterhorn_03") then

	end
end
--]]

--[[function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 247175 then--Void Trap
		warnVoidTrap:Show()
		warnVoidTrap:Play("watchstep")
	--	timerVoidTrapCD:Start()
	elseif spellId == 247206 then--Overload Trap
		specWarnOverloadTrap:Show()
		specWarnOverloadTrap:Play("watchstep")
		timerOverloadTrapCD:Start()
	end
end
]]
