local mod	= DBM:NewMod(1663, "DBM-Party-Legion", 8, 727)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(96759)
mod:SetEncounterID(1824)
mod:SetZone()
mod:SetUsedIcons(8, 7)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 227233 202088 198495",
--	"SPELL_CAST_SUCCESS 197262",
	"SPELL_AURA_APPLIED 196947 197262",
	"SPELL_AURA_REMOVED 196947 197262",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH boss1"
)

--Хелия https://ru.wowhead.com/npc=96759/хелия
local warnPhase							= mod:NewPhaseChangeAnnounce(1)
local warnPhase2						= mod:NewPrePhaseAnnounce(2, 1, 196947)
local warnTaintofSea					= mod:NewTargetAnnounce(197262, 3) --Морская порча
local warnSubmerged2					= mod:NewPreWarnAnnounce(196947, 5, 1) --Погружение

local specWarnTaintofSea				= mod:NewSpecialWarningYou(197262, nil, nil, nil, 1, 3) --Морская порча
local specWarnTaintofSea2				= mod:NewSpecialWarningDispel(197262, "MagicDispeller2", nil, nil, 1, 3) --Морская порча
local specWarnDestructorTentacle		= mod:NewSpecialWarningSwitch("ej12364", "Tank|Dps") --Щупальце разрушения
local specWarnBrackwaterBarrage			= mod:NewSpecialWarningDodge(202088, nil, nil, nil, 3, 5) --Обстрел солоноватой водой Tank stays with destructor tentacle no matter what
local specWarnSubmerged					= mod:NewSpecialWarningDodge(196947, nil, nil, nil, 1, 2) --Погружение
local specWarnSubmergedOver				= mod:NewSpecialWarningEnd(196947, nil, nil, nil, 1, 2) --Погружение
local specWarnTaintofSeaOver			= mod:NewSpecialWarningEnd(197262, nil, nil, nil, 1, 2) --Морская порча
local specWarnBreath					= mod:NewSpecialWarningDodge(227233, nil, nil, nil, 3, 5) --Оскверняющий рев
local specWarnTorrent					= mod:NewSpecialWarningInterrupt(198495, "HasInterrupt", nil, nil, 1, 2) --Стремительный поток

local timerBrackwaterBarrageCD			= mod:NewCDTimer(15, 202088, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Обстрел солоноватой водой
local timerTaintofSeaCD					= mod:NewCDTimer(12, 197262, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Морская порча
local timerPiercingTentacleCD			= mod:NewNextTimer(9, 197596, nil, nil, nil, 3) --Пронзающее щупальце
--local timerDestructorTentacleCD		= mod:NewCDTimer(26, "ej12364", nil, nil, nil, 1)--More data
local timerSubmerged					= mod:NewBuffFadesTimer(15, 196947, nil, nil, nil, 6) --Погружение
local timerSubmerged2					= mod:NewCDTimer(74.5, 196947, nil, nil, nil, 6) --Погружение
local timerBreathCD						= mod:NewNextTimer(21, 227233, nil, nil, nil, 2, nil, DBM_CORE_DEADLY_ICON) --Оскверняющий рев
local timerTorrentCD					= mod:NewCDTimer(9.7, 198495, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_DEADLY_ICON) --Стремительный поток

local yellTaintofSea					= mod:NewYell(197262, nil, nil, nil, "YELL") --Морская порча
local yellTaintofSea2					= mod:NewYell(197264, L.TaintofSeaYell, nil, nil, "YELL") --Морская порча

local countdownBrackwaterBarrage		= mod:NewCountdown(15, 202088, nil, nil, 5) --Обстрел солоноватой водой
local countdownBreath					= mod:NewCountdown(21, 227233, nil, nil, 5) --Оскверняющий рев
local countdownSubmerged				= mod:NewCountdown("Alt74.5", 196947, nil, nil, 5) --Погружение

mod:AddSetIconOption("SetIconOnTaintofSea", 197262, true, false, {8, 7}) --Морская порча

mod.vb.phase = 1
mod.vb.submerged = 0
mod.vb.taintofseaIcon = 8

local warned_preP1 = false
local warned_preP2 = false
local playerName = UnitName("player")
local taintofSea = DBM:GetSpellInfo(197262) --Морская порча

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	self.vb.submerged = 0
	self.vb.taintofseaIcon = 8
	warned_preP1 = false
	warned_preP2 = false
	if not self:IsNormal() then
		timerPiercingTentacleCD:Start(8.5-delay)
		timerBrackwaterBarrageCD:Start(15-delay)
		countdownBrackwaterBarrage:Start(15-delay)
		timerTaintofSeaCD:Start(12.5-delay)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 227233 then --Оскверняющий рев
		specWarnBreath:Show()
		specWarnBreath:Play("breathsoon")
		timerBreathCD:Start()
		countdownBreath:Start()
	elseif spellId == 202088 then --Обстрел солоноватой водой
		specWarnBrackwaterBarrage:Show()
		specWarnBrackwaterBarrage:Play("breathsoon")
		if not self:IsNormal() then
			timerBrackwaterBarrageCD:Start(22)
			countdownBrackwaterBarrage:Start(22)
		end
	elseif spellId == 198495 then --Стремительный поток
		timerTorrentCD:Start()
		specWarnTorrent:Show()
		specWarnTorrent:Play("kickcast")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 196947 then --Погружение
		timerBrackwaterBarrageCD:Stop()
		timerPiercingTentacleCD:Stop()
		timerTaintofSeaCD:Stop()
		timerTorrentCD:Stop()
		timerBreathCD:Cancel()
		countdownBreath:Cancel()
		specWarnSubmerged:Show()
		timerSubmerged:Start()
		countdownBrackwaterBarrage:Cancel()
		countdownSubmerged:Start(15)
		if self.vb.phase == 1 then
			self.vb.phase = 2
			warned_preP2 = true
		end
	elseif spellId == 197262 then --Морская порча
		self.vb.taintofseaIcon = self.vb.taintofseaIcon - 1
		if self:IsHard() then
			if args:IsPlayer() then
				specWarnTaintofSea:Show()
				specWarnTaintofSea:Play("targetyou")
				yellTaintofSea:Yell()
			else
				warnTaintofSea:Show(args.destName)
				specWarnTaintofSea2:Show(args.destName)
				specWarnTaintofSea2:Play("dispelnow")
			end
		else
			if args:IsPlayer() then
				specWarnTaintofSea:Show()
				specWarnTaintofSea:Play("targetyou")
				yellTaintofSea:Yell()
			else
				warnTaintofSea:Show(args.destName)
			end
		end
		if self.vb.phase == 1 then
			timerTaintofSeaCD:Start()
		else
			timerTaintofSeaCD:Start(20)
		end
		if self.Options.SetIconOnTaintofSea then
			self:SetIcon(args.destName, self.vb.taintofseaIcon)
		end
		if self.vb.taintofseaIcon == 7 then
			self.vb.taintofseaIcon = 8
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 196947 then --Погружение
		self.vb.submerged = self.vb.submerged + 1
		timerTorrentCD:Start(11) --было 5
		timerSubmerged2:Start()
		countdownSubmerged:Start()
		warnSubmerged2:Schedule(69.5)
		specWarnSubmergedOver:Show()
		timerBreathCD:Start(19)
		countdownBreath:Start(19)
		timerTaintofSeaCD:Start(10)
		if self.vb.submerged == 1 then
			warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
			warnPhase:Play("phasechange")
		end
	elseif spellId == 197262 then --Морская порча
		if args:IsPlayer() then
			specWarnTaintofSeaOver:Show()
			yellTaintofSea2:Yell(taintofSea, playerName)
		end
		if self.Options.SetIconOnTaintofSea then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if msg:find("inv_misc_monsterhorn_03") then
		specWarnDestructorTentacle:Show()
		specWarnDestructorTentacle:Play("killmob")
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 197596 then--Piercing Tentacle
		if self.vb.phase == 1 then
			timerPiercingTentacleCD:Start()
		else
			timerPiercingTentacleCD:Start(6)
		end
	end
end

function mod:UNIT_HEALTH(uId)
	if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 96759 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.85 then
		warned_preP1 = true
		warnPhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
	end
end
