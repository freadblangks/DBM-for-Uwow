local mod	= DBM:NewMod(1703, "DBM-EmeraldNightmare", nil, 768)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(102672)
mod:SetEncounterID(1853)
mod:SetZone()
mod:SetUsedIcons(4, 3, 2, 1)
mod:SetHotfixNoticeRev(15286)
mod.respawnTime = 30

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 203552 202977 205070 225943",
	"SPELL_CAST_SUCCESS 204463",
	"SPELL_AURA_APPLIED 204463 203096 205043",
	"SPELL_AURA_REMOVED 204463 203096 203552 204504",
	"SPELL_DAMAGE 203646",
	"SPELL_MISSED 203646",
	"SPELL_PERIODIC_DAMAGE 203045",
	"SPELL_PERIODIC_MISSED 203045",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)

local warnVolatileRot				= mod:NewTargetAnnounce(204463, 4) --Взрывоопасная гниль
local warnRot						= mod:NewTargetAnnounce(203096, 3) --Гниль
local warnRotFades					= mod:NewFadesAnnounce(203096, 1) --Гниль
local warnHeartofSwarm				= mod:NewSpellAnnounce(203552, 2) --Королева роя
local warnHeartofSwarmEnd			= mod:NewEndAnnounce(203552, 2) --Королева роя
local warnInfestedMind				= mod:NewTargetAnnounce(205043, 4) --Зараженный разум

local specWarnBreath				= mod:NewSpecialWarningDodge(202977, nil, nil, nil, 2, 2) --Заразное дыхание
local specWarnVolatileRot			= mod:NewSpecialWarningYouMoveAway(204463, nil, nil, nil, 3, 2) --Взрывоопасная гниль
local specWarnVolatileRotSwap		= mod:NewSpecialWarningTaunt(204463, nil, nil, nil, 1, 2) --Взрывоопасная гниль
local specWarnRot					= mod:NewSpecialWarningYouMoveAway(203096, nil, nil, nil, 1, 2) --Гниль
local specWarnInfestedGround		= mod:NewSpecialWarningYouMove(203045, nil, nil, nil, 1, 2) --Зараженная земля
local specWarnBurst					= mod:NewSpecialWarningYouMove(203646, nil, nil, nil, 1, 2) --Выброс порчи
local specWarnInfestedMindYou		= mod:NewSpecialWarningYou(205043, nil, nil, nil, 1, 2) --Зараженный разум
local specWarnInfestedMind			= mod:NewSpecialWarningSwitch(205043, "Dps", nil, nil, 1, 2) --Зараженный разум
local specWarnSpreadInfestation		= mod:NewSpecialWarningInterrupt(205070, "HasInterrupt", nil, nil, 1, 2) --Распространение заразы
local specWarnInfestedStack			= mod:NewSpecialWarningStack(204504, nil, 7, nil, 2, 1, 5) --Чумное заражение

local timerBreathCD					= mod:NewCDCountTimer(36, 202977, nil, nil, nil, 3) --Заразное дыхание 36-42
local timerVolatileRotCD			= mod:NewCDCountTimer(20.5, 204463, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Взрывоопасная гниль 20.5-24 variation non mythic. 22-30 mythic
local timerRotCD					= mod:NewCDCountTimer(15.3, 203096, nil, nil, nil, 3) --Гниль
local timerSwarm					= mod:NewBuffActiveTimer(23, 203552, nil, nil, nil, 6) --Королева роя
local timerSwarmCD					= mod:NewCDCountTimer(98, 203552, nil, nil, nil, 6) --Королева роя Needs new sample size
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerInfestingMindCD			= mod:NewNextTimer(10, 205043, nil, nil, nil, 3, nil, DBM_CORE_HEROIC_ICON) --Зараженный разум 36-42

local berserkTimer					= mod:NewBerserkTimer(600)

local countdownBreath				= mod:NewCountdown(36, 202977, false) --Заразное дыхание Can't in good concious have a countdown on by default for something with a 6 second variation
local countdownVolatileRot			= mod:NewCountdown("Alt20.5", 204463, false) --Взрывоопасная гниль Same deal as above
local countdownRot					= mod:NewCountdownFades("Alt5", 203096) --Гниль
local countdownSwarm				= mod:NewCountdown(10, 203552, nil, nil, 5) --Королева роя
local countdownSwarm2				= mod:NewCountdownFades(10, 203552, nil, nil, 5) --Королева роя

local yellVolatileRot				= mod:NewFadesYell(204463, nil, nil, nil, "YELL") --Взрывоопасная гниль
local yellRot						= mod:NewFadesYell(203096, nil, nil, nil, "YELL") --Гниль
local yellInfestedMind				= mod:NewYell(205043, nil, nil, nil, "YELL") --Зараженный разум

mod:AddSetIconOption("SetIconOnRot", 203096, true, false, {4, 3, 2, 1}) --Гниль Of course I'll probably be forced to change method when BW does their own thing, for compat.
mod:AddRangeFrameOption(30, 204463) --Взрывоопасная гниль Range not actually known, 30 used for now
mod:AddInfoFrameOption(204506)

local debuffName, stackDebuff = DBM:GetSpellInfo(204463), DBM:GetSpellInfo(204506) --Взрывоопасная гниль

mod.vb.breathCount = 0
mod.vb.rotCast = 0
mod.vb.volatileRotCast = 0
mod.vb.swarmCast = 0
local playerHasTen = false

local debuffFilter
do
	debuffFilter = function(uId)
		if UnitDebuff(uId, debuffName) then
			return true
		end
	end
end

function mod:OnCombatStart(delay)
	self.vb.breathCount = 0
	self.vb.rotCast = 0
	self.vb.volatileRotCast = 0
	self.vb.swarmCast = 0
	--Only start timers if boss isn't starting at 0 energy
	timerRotCD:Start(5.5-delay, 1) --Гниль+++
	timerVolatileRotCD:Start(24-delay, 1) --Взрывоопасная гниль+++ (героик и обычка)
	countdownVolatileRot:Start(24-delay) --Взрывоопасная гниль+++ (героик и обычка)
	timerBreathCD:Start(37-delay, 1) --Заразное дыхание+++ (героик и обычка)
	countdownBreath:Start(37-delay) --Заразное дыхание+++ (героик и обычка)
	timerSwarmCD:Start(83.5-delay, 1) --Королева роя+++ (обычка)
	countdownSwarm:Start(83.5-delay) --Королева роя+++ (обычка)
	if self:IsEasy() then
		berserkTimer:Start(-delay)
	else
		berserkTimer:Start(480-delay)
	end
	if self.Options.InfoFrame and self:IsMythic() then
		DBM.InfoFrame:SetHeader(stackDebuff)
		DBM.InfoFrame:Show(8, "playerdebuffstacks", stackDebuff)
	end
	if self:IsMythic() then
		playerHasTen = false
		self:RegisterShortTermEvents(
			"SPELL_AURA_APPLIED_DOSE 204504"
		)
	end
end

function mod:OnCombatEnd()
	self:UnregisterShortTermEvents()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 203552 then
		--Cancel for good measure since blizzard is still tweaking fight
		timerRotCD:Stop()
		timerVolatileRotCD:Stop()
		countdownVolatileRot:Cancel()
		timerBreathCD:Stop()
		countdownBreath:Cancel()
		--Cancel for good measure since blizzard is still tweaking fight
		self.vb.swarmCast = self.vb.swarmCast + 1
		warnHeartofSwarm:Show(self.vb.swarmCast)
		timerSwarm:Start()
	elseif spellId == 202977 then
		DBM:Debug("CLEU event for breath, pruned. If you see this message it was unpruned!")
	elseif spellId == 205070 and self:CheckInterruptFilter(args.sourceGUID, false, true) then
		specWarnSpreadInfestation:Show(args.sourceName)
		specWarnSpreadInfestation:Play("kickcast")
	elseif spellId == 225943 then
		if playerHasTen then
			specWarnInfestedMindYou:Show()
			specWarnInfestedMindYou:Play("targetyou")
			yellInfestedMind:Yell()
		else
			specWarnInfestedMind:Show()
			specWarnInfestedMind:Play("findmc")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 204463 then
		self.vb.volatileRotCast = self.vb.volatileRotCast + 1
		if self.vb.volatileRotCast < 3 then
			if self:IsMythic() then
				timerVolatileRotCD:Start(22, self.vb.volatileRotCast+1)
				countdownVolatileRot:Start(22)
			else
				timerVolatileRotCD:Start(nil, self.vb.volatileRotCast+1)
				countdownVolatileRot:Start()
			end
		end
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 204463 then --Взрывоопасная гниль
		if args:IsPlayer() then
			specWarnVolatileRot:Show()
			specWarnVolatileRot:Play("runout")
			yellVolatileRot:Countdown(8, 3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(30)
			end
		else
			if self:IsTank() then
				specWarnVolatileRotSwap:Show(args.destName)
				specWarnVolatileRotSwap:Play("tauntboss")
			else
				warnVolatileRot:Show(args.destName)
			end
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(30, debuffFilter)
			end
		end
	elseif spellId == 203096 then --Гниль
		warnRot:CombinedShow(0.5, args.destName)
		if args:IsPlayer() then
			specWarnRot:Show()
			specWarnRot:Play("runout")
			yellRot:Countdown(9, 3)
		end
		if self.Options.SetIconOnRot then
			self:SetAlphaIcon(0.8, args.destName)--Number of icons variable by raid size and duration of fight
		end
	elseif spellId == 205043 then
		warnInfestedMind:CombinedShow(0.5, args.destName)
	end
end

function mod:SPELL_AURA_APPLIED_DOSE(args)
	local spellId = args.spellId
	if spellId == 204504 and args:IsPlayer() then
		local amount = args.amount or 1
		if amount >= 7 and amount < 11 then
			specWarnInfestedStack:Cancel()
			specWarnInfestedStack:Schedule(0.5, amount)
			if self:AntiSpam(2, 4) then
				specWarnInfestedStack:Play("stackhigh")
			end
		end
		if amount >= 10 then
			playerHasTen = true
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 204463 then
		if args:IsPlayer() then
			warnRotFades:Show()
			yellVolatileRot:Cancel()
			countdownRot:Cancel()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
	elseif spellId == 203096 then
		if args:IsPlayer() then
			yellRot:Cancel()
		end
		if self.Options.SetIconOnRot then
			self:SetIcon(args.destName, 0)
		end
	elseif spellId == 203552 then--Heart of swarm ending
		warnHeartofSwarmEnd:Show()
		self.vb.breathCount = 0
		self.vb.rotCast = 0
		self.vb.volatileRotCast = 0
		timerRotCD:Start(12, 1)
		timerVolatileRotCD:Start(28, 1)--28-31
		countdownVolatileRot:Start(28)
		timerBreathCD:Start(43, 1)
		countdownBreath:Start(43)
		timerSwarmCD:Start(nil, self.vb.swarmCast+1)
	elseif spellId == 204504 and args:IsPlayer() then
		playerHasTen = false
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 203646 and destGUID == UnitGUID("player") and self:AntiSpam(2, 3) then
		specWarnBurst:Show()
		specWarnBurst:Play("runaway")
	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 203045 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnInfestedGround:Show()
		specWarnInfestedGround:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 203095 then--CAST Doesn't show in combat log for some reason. Applied does but don't want to risk misses
		self.vb.rotCast = self.vb.rotCast + 1
		if self.vb.rotCast < 5 then
			timerRotCD:Start(nil, self.vb.rotCast+1)
		end
	elseif spellId == 202968 then--Infested Breath (CAST_SUCCESS and CAST_START pruned from combat log)
		self.vb.breathCount = self.vb.breathCount + 1
		specWarnBreath:Show(self.vb.breathCount)
		specWarnBreath:Play("breathsoon")
		if self.vb.breathCount < 2 then
			timerBreathCD:Start(nil, self.vb.breathCount+1)
			countdownBreath:Start()
		end
		if self:IsMythic() then
			timerInfestingMindCD:Start()
		end
	end
end
