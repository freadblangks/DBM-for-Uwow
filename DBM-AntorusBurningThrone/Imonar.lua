local mod	= DBM:NewMod(2009, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(124158)--or 124158 or 125692
mod:SetEncounterID(2082)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(8, 7, 6, 5, 4, 3, 2, 1)
mod:SetHotfixNoticeRev(16961)
mod.respawnTime = 30

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.YellPullImonar)
--mod:RegisterCombat("combat_yell", L.YellPullImonar2)
--mod:RegisterCombat("combat_yell", L.YellPullImonar3)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 247376 247923 248068 248070 248254",
	"SPELL_CAST_SUCCESS 247367 247552 247687 250255 254244 248254",
	"SPELL_AURA_APPLIED 247367 247565 247687 250255 250006 247641 255029 250224 254183 248424",
	"SPELL_AURA_APPLIED_DOSE 247367 247687 250255 250224 248424",
	"SPELL_AURA_REMOVED 248233 250135 250006",
--	"SPELL_PERIODIC_DAMAGE",
--	"SPELL_PERIODIC_MISSED",
	"RAID_BOSS_WHISPER",
	"RAID_TARGET_UPDATE",
	"UNIT_SPELLCAST_SUCCEEDED boss1",
	"UNIT_HEALTH boss1"
)

--Ловец душ Имонар
local warnPhase							= mod:NewPhaseChangeAnnounce(1, nil, nil, nil, nil, nil, 2) --фаза
local warnPrePhase2						= mod:NewPrePhaseAnnounce(2, 1)
local warnPrePhase3						= mod:NewPrePhaseAnnounce(3, 1)
local warnPrePhase4						= mod:NewPrePhaseAnnounce(4, 1)
local warnPrePhase5						= mod:NewPrePhaseAnnounce(5, 1)
local warnGatheringPower				= mod:NewStackAnnounce(248424, 4, nil, nil, 2) --Накопление силы
--Stage One: Attack Force
local warnShocklance					= mod:NewStackAnnounce(247367, 2, nil, "Tank") --Копье-шокер
local warnSleepCanister					= mod:NewTargetAnnounce(247552, 4) --Склянка с усыпляющим газом
local warnSlumberGas					= mod:NewTargetAnnounce(247565, 3) --Усыпляющий газ
--Stage Two: Contract to Kill
local warnSever							= mod:NewStackAnnounce(247687, 2, nil, "Tank") --Рассечение
--Stage Three/Five: The Perfect Weapon
local warnEmpoweredPulseGrenade			= mod:NewTargetAnnounce(250006, 3) --Усиленная импульсная граната

--General
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Stage One: Attack Force
local specWarnSearedSkin				= mod:NewSpecialWarningYouMove(254183, nil, nil, nil, 3, 3) --Опаленная кожа
local specWarnShocked					= mod:NewSpecialWarningStack(250224, nil, 2, nil, nil, 3, 5) --Шок
local specWarnShocklance				= mod:NewSpecialWarningTaunt(247367, nil, nil, nil, 3, 5) --Копье-шокер
local specWarnShocklance2				= mod:NewSpecialWarningStack(247367, nil, 3, nil, nil, 3, 3) --Копье-шокер
local specWarnSleepCanister				= mod:NewSpecialWarningYouMoveAway(247552, nil, nil, nil, 3, 5) --Склянка с усыпляющим газом
local specWarnSleepCanisterNear			= mod:NewSpecialWarningCloseMoveAway(247552, nil, nil, nil, 1, 2) --Склянка с усыпляющим газом
local specWarnPulseGrenade				= mod:NewSpecialWarningDodge(247376, nil, nil, nil, 1, 2) --Импульсная граната
--Stage Two: Contract to Kill
local specWarnSever						= mod:NewSpecialWarningTaunt(247687, nil, nil, nil, 3, 5) --Рассечение
local specWarnSever2					= mod:NewSpecialWarningStack(247687, nil, 3, nil, nil, 3, 3) --Рассечение
local specWarnChargedBlastsUnknown		= mod:NewSpecialWarningDodge(247716, nil, nil, nil, 2, 2) --Направленные взрывы
local specWarnShrapnalBlast				= mod:NewSpecialWarningDodge(247923, nil, nil, nil, 1, 2) --Заряд шрапнели
--Stage Three/Five: The Perfect Weapon
local specWarnEmpPulseGrenade			= mod:NewSpecialWarningYouMoveAway(250006, nil, nil, nil, 4, 5) --Усиленная импульсная граната
local specWarnEmpPulseGrenade2			= mod:NewSpecialWarning("PulseGrenade", nil, nil, nil, 1, 3) --Усиленная импульсная граната
--Intermission: On Deadly Ground

--Stage One: Attack Force
local timerShocklanceCD					= mod:NewCDTimer(4, 247367, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Копье-шокер 4-5.1
local timerSleepCanisterCD				= mod:NewCDTimer(11.3, 247552, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON) --Склянка с усыпляющим газом 11.3-13.4
local timerPulseGrenadeCD				= mod:NewCDTimer(17, 247376, nil, nil, nil, 3) --Импульсная граната 17?
--Stage Two: Contract to Kill
local timerSeverCD						= mod:NewCDTimer(7.2, 247687, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Рассечение
local timerChargedBlastsCD				= mod:NewCDTimer(18.2, 247716, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Направленные взрывы
local timerShrapnalBlastCD				= mod:NewCDCountTimer(13.3, 247923, nil, nil, nil, 3, nil, DBM_CORE_TANK_ICON) --Заряд шрапнели
--Stage Three/Five: The Perfect Weapon

--Intermission: On Deadly Ground
local yellSleepCanisterStun				= mod:NewYell(255029, L.DispelMe, nil, nil, "YELL") --Склянка с усыпляющим газом Auto yell when safe to dispel (no players within 10 yards)
local yellStasisTrap					= mod:NewYell(247641, L.DispelMe, nil, nil, "YELL") --Стазисная ловушка
local yellEmpPulseGrenade				= mod:NewYell(250006, nil, nil, nil, "YELL") --Усиленная импульсная граната
local yellSleepCanister					= mod:NewPosYell(247552, DBM_CORE_AUTO_YELL_CUSTOM_POSITION, nil, nil, "YELL") --Склянка с усыпляющим газом
local yellSleepCanister2				= mod:NewYell(255029, nil, nil, nil, "YELL") --Усыпляющий газ

local berserkTimer						= mod:NewBerserkTimer(420)

--Stage One: Attack Force
local countdownPulseGrenade				= mod:NewCountdown(17, 247376, nil, nil, 5) --Импульсная граната
--Stage Two: Contract to Kill
local countdownChargedBlasts			= mod:NewCountdown("AltTwo18", 247716, nil, nil, 5) --Направленные взрывы

mod:AddSetIconOption("SetIconOnSleepCanister", 247552, true, false, {3, 2, 1}) --Склянка с усыпляющим газом
mod:AddSetIconOption("SetIconOnEmpPulse2", 250006, true, false, {8, 7, 6, 5, 4}) --Усиленная импульсная граната
mod:AddInfoFrameOption(250006, true) --Усиленная импульсная граната
mod:AddRangeFrameOption("5/10")

mod.vb.phase = 1
mod.vb.shrapnalCast = 0
mod.vb.empoweredPulseActive = 0
mod.vb.sleepCanisterIcon = 1
local mythicP5ShrapnalTimers = {15, 15.8, 14.5, 12, 10}--Doesn't seem right, seems health based?
local empoweredPulseTargets = {}

local warned_preP1 = false
local warned_preP2 = false
local warned_preP3 = false
local warned_preP4 = false
local warned_preP5 = false
local warned_preP6 = false
local warned_preP7 = false
local warned_preP8 = false

local debuffFilter
local playerSleepDebuff = false
do
	debuffFilter = function(uId)
		if DBM:UnitDebuff(uId, 250006) then
			return true
		end
	end
end

local function updateRangeFrame(self)
	if not self.Options.RangeFrame then return end
	if playerSleepDebuff then
		DBM.RangeCheck:Show(10)--There are no 15 yard items that are actually 15 yard, this will round to 18 :\
	elseif DBM:UnitDebuff("player", 250006) then
		DBM.RangeCheck:Show(5)
	elseif self.vb.empoweredPulseActive > 0 then--Spread for Horn of Valor
		DBM.RangeCheck:Show(5, debuffFilter)
	else
		DBM.RangeCheck:Hide()
	end
end

local updateInfoFrame
do
	local lines = {}
	local sortedLines = {}
	local function addLine(key, value)
		-- sort by insertion order
		lines[key] = value
		sortedLines[#sortedLines + 1] = key
	end
	updateInfoFrame = function()
		table.wipe(lines)
		table.wipe(sortedLines)
		for i = 1, #empoweredPulseTargets do
			local name = empoweredPulseTargets[i]
			addLine(name, i)
		end
		if #empoweredPulseTargets == 0 then--None found, hide infoframe because all broke
			DBM.InfoFrame:Hide()
		end
		return lines, sortedLines
	end
end

function mod:OnCombatStart(delay)
	warned_preP1 = false
	warned_preP2 = false
	warned_preP3 = false
	warned_preP4 = false
	warned_preP5 = false
	warned_preP6 = false
	warned_preP7 = false
	warned_preP8 = false
	table.wipe(empoweredPulseTargets)
	self.vb.phase = 1
	self.vb.shrapnalCast = 0
	self.vb.empoweredPulseActive = 0
	self.vb.sleepCanisterIcon = 1
	if self:IsMythic() then --проверено 1 раз, все ок
		timerShocklanceCD:Start(5-delay)
		timerSleepCanisterCD:Start(6-delay)
		timerPulseGrenadeCD:Start(14.5-delay)--14.2
		countdownPulseGrenade:Start(14.5-delay)
		berserkTimer:Start(480-delay)--8min
	else
		timerShocklanceCD:Start(4.2-delay)
		timerSleepCanisterCD:Start(7-delay)
		timerPulseGrenadeCD:Start(14.2-delay)--14.2
		countdownPulseGrenade:Start(14.2-delay)
		berserkTimer:Start(-delay)
	end
end

function mod:OnCombatEnd()
	table.wipe(empoweredPulseTargets)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 247376 or spellId == 248068 then
		if spellId == 247376 then--Non Empowered
			specWarnPulseGrenade:Show()
			specWarnPulseGrenade:Play("watchstep")
			timerPulseGrenadeCD:Start()
			countdownPulseGrenade:Start()
		else--Empowered
			if self.vb.phase == 5 then--Only happens on mythic and only phase where empowered isn't long cd
				timerPulseGrenadeCD:Start(13.3)
				countdownPulseGrenade:Start(13.3)
			else
				timerPulseGrenadeCD:Start(25.5)
				countdownPulseGrenade:Start(25.5)
			end
		end
	elseif spellId == 247923 or spellId == 248070 then
		self.vb.shrapnalCast = self.vb.shrapnalCast + 1
		specWarnShrapnalBlast:Show()
		specWarnShrapnalBlast:Play("watchstep")
		if self:IsMythic() then
			if self.vb.phase == 2 then
				timerShrapnalBlastCD:Start(16.4, self.vb.shrapnalCast+1)
			elseif self.vb.phase == 3 then
				timerShrapnalBlastCD:Start(14, self.vb.shrapnalCast+1)--14-15.8
			elseif self.vb.phase == 4 then
				timerShrapnalBlastCD:Start(26.7, self.vb.shrapnalCast+1)
			elseif self.vb.phase == 5 then
				local timer = mythicP5ShrapnalTimers[self.vb.shrapnalCast+1]
				if timer then
					timerShrapnalBlastCD:Start(timer, self.vb.shrapnalCast+1)
				end
			end
		elseif spellId == 248070 then--Empowered (p3)
			timerShrapnalBlastCD:Start(17, self.vb.shrapnalCast+1)--17-23
		else
			timerShrapnalBlastCD:Start(nil, self.vb.shrapnalCast+1)--13
		end
	elseif spellId == 248254 then
		if self:IsMythic() and self.vb.phase < 4 then
			timerChargedBlastsCD:Start(13.4)
			countdownChargedBlasts:Start(13.4)
		else
			timerChargedBlastsCD:Start()--18.2
			countdownChargedBlasts:Start(18.2)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
	if spellId == 247367 or spellId == 250255 then
		if spellId == 247367 or self:IsMythic() then
			timerShocklanceCD:Start()
		else--Empowered seems less often
			timerShocklanceCD:Start(9.7)
		end
	elseif spellId == 247552 or spellId == 254244 then
		if self:IsMythic() then
			timerSleepCanisterCD:Start(11.3)
		else
			timerSleepCanisterCD:Start()--10.7
		end
	elseif spellId == 247687 then
		timerSeverCD:Start()
	elseif spellId == 248254 then
		specWarnChargedBlastsUnknown:Show()
		specWarnChargedBlastsUnknown:Play("farfromline")
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 247367 or spellId == 250255 then --Копье-шокер
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if spellId == 247367 and amount >= 3 then
				if args:IsPlayer() then
					specWarnShocklance2:Show(amount)
					specWarnShocklance2:Play("stackhigh")
				else
					local _, _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 4) then
						specWarnShocklance:Show(args.destName)
						specWarnShocklance:Play("tauntboss")
					else
						warnShocklance:Show(args.destName, amount)
					end
				end
			else
				warnShocklance:Show(args.destName, amount)
			end
		end
	elseif spellId == 247687 then --Рассечение
		local uId = DBM:GetRaidUnitId(args.destName)
		if self:IsTanking(uId) then
			local amount = args.amount or 1
			if amount >= 3 then
				if args:IsPlayer() then
					specWarnSever2:Show(amount)
					specWarnSever2:Play("stackhigh")
				else
					local _, _, _, _, _, _, expireTime = DBM:UnitDebuff("player", spellId)
					local remaining
					if expireTime then
						remaining = expireTime-GetTime()
					end
					if not UnitIsDeadOrGhost("player") and (not remaining or remaining and remaining < 7) then
						specWarnSever:Show(args.destName)
						specWarnSever:Play("tauntboss")
					else
						warnSever:Show(args.destName, amount)
					end
				end
			else
				warnSever:Show(args.destName, amount)
			end
		end
	elseif spellId == 255029 then--Sleep Canister Stun Effect
		if args:IsPlayer() then
			if self:CheckNearby(11) then
				yellSleepCanisterStun:Yell()
			end
		elseif self:CheckNearby(10, args.destName) then--Warn nearby again
			specWarnSleepCanisterNear:CombinedShow(0.3, args.destName)
			specWarnSleepCanisterNear:Play("runaway")
		end
	elseif spellId == 247565 then
		warnSlumberGas:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			playerSleepDebuff = false
			updateRangeFrame(self)
		end
	elseif spellId == 250006 then
		self.vb.empoweredPulseActive = self.vb.empoweredPulseActive + 1
		warnEmpoweredPulseGrenade:CombinedShow(0.3, args.destName)
		if args:IsPlayer() then
			specWarnEmpPulseGrenade:Show()
			specWarnEmpPulseGrenade:Play("range5")
			specWarnEmpPulseGrenade2:Schedule(7)
			yellEmpPulseGrenade:Yell()
		end
		updateRangeFrame(self)
		if not tContains(empoweredPulseTargets, args.destName) then
			table.insert(empoweredPulseTargets, args.destName)
		end
		if self.Options.SetIconOnEmpPulse2 and #empoweredPulseTargets < 7 then
			self:SetIcon(args.destName, #empoweredPulseTargets+2)
		end
		if self.Options.InfoFrame then
			if #empoweredPulseTargets == 1 then
				DBM.InfoFrame:SetHeader(args.spellName)
				DBM.InfoFrame:Show(5, "function", updateInfoFrame, false, true, true)--No sort function, use icons, no onupdate
			else
				DBM.InfoFrame:Update()
			end
		end
	elseif spellId == 247641 then
		if args:IsPlayer() then
			yellStasisTrap:Yell()
		end
	elseif spellId == 250224 then --Шок
		local amount = args.amount or 1
		if amount >= 2 and not self:IsTank() then
			if args:IsPlayer() then
				specWarnShocked:Show(amount)
				specWarnShocked:Play("stackhigh")
			end
		elseif amount >= 5 and self:IsTank() then
			if args:IsPlayer() then
				specWarnShocked:Show(amount)
				specWarnShocked:Play("stackhigh")
			end
		end
	elseif spellId == 254183 and self:AntiSpam(2, 1) then --Опаленная кожа
		if args:IsPlayer() then
			specWarnSearedSkin:Show()
			specWarnSearedSkin:Play("stackhigh")
		end
	elseif spellId == 248424 then --Накопление силы
		local amount = args.amount or 1
		if amount >= 10 and amount % 5 == 0 then
			warnGatheringPower:Show(args.destName, amount)
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if (spellId == 248233 or spellId == 250135) and not args:IsDestTypePlayer() then--Conflagration
		self.vb.phase = self.vb.phase + 1
		self.vb.shrapnalCast = 0
		warnPhase:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase))
		if self.vb.phase == 2 then
			warnPhase:Play("ptwo")
			warned_preP2 = true
			timerSeverCD:Start(6.6)--6.6-8.2
			timerChargedBlastsCD:Start(8.4)
			countdownChargedBlasts:Start(8.4)
			timerShrapnalBlastCD:Start(12, 1)
		elseif self.vb.phase == 3 then
			warnPhase:Play("pthree")
			warned_preP4 = true
			if self:IsMythic() then
				timerShocklanceCD:Start(4)--NOT empowered
				timerSleepCanisterCD:Start(7.9)
				timerPulseGrenadeCD:Start(12.6)--Empowered
				countdownPulseGrenade:Start(12.6)
				timerShrapnalBlastCD:Start(13.9, 1)--Empowered
			else
				timerShocklanceCD:Start(5)--Empowered
				timerPulseGrenadeCD:Start(6.3)--Empowered
				countdownPulseGrenade:Start(6.3)
				timerShrapnalBlastCD:Start(15.4, 1)--Empowered
			end
		elseif self.vb.phase == 4 then--Mythic Only
			warnPhase:Play("pfour")
			warned_preP6 = true
			timerSeverCD:Start(7.5)
			timerChargedBlastsCD:Start(9)
			timerSleepCanisterCD:Start(12.5)
			timerShrapnalBlastCD:Start(12.7, 1)--Empowered
		elseif self.vb.phase == 5 then--Mythic Only (Identical to non mythic 3?)
			warnPhase:Play("pfive")
			warned_preP8 = true
			timerShocklanceCD:Start(5)--Empowered
			timerPulseGrenadeCD:Start(7)--Empowered
			countdownPulseGrenade:Start(7)
			timerSleepCanisterCD:Start(12.9)
			timerShrapnalBlastCD:Start(15.5, 1)--Empowered
		end
	elseif spellId == 250006 then
		self.vb.empoweredPulseActive = self.vb.empoweredPulseActive - 1
		tDeleteItem(empoweredPulseTargets, args.destName)
		updateRangeFrame(self)
		if self.Options.SetIconOnEmpPulse2 then
			self:SetIcon(args.destName, 0)
		end
		if self.Options.InfoFrame then
			DBM.InfoFrame:Update()
		end
	elseif spellId == 255029 then
		if self.Options.SetIconOnSleepCanister then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:RAID_BOSS_WHISPER(msg)
	if msg:find("spell:254244") then
		specWarnSleepCanister:Show()
		specWarnSleepCanister:Play("runout")
		yellSleepCanister2:Yell()
		playerSleepDebuff = true
		updateRangeFrame(self)
	end
end

function mod:RAID_TARGET_UPDATE()
	if self.Options.InfoFrame then
		DBM.InfoFrame:Update()
	end
end

do
	local playerName = UnitName("player")
	local sleepCanister = DBM:GetSpellInfo(254244)
	function mod:OnTranscriptorSync(msg, targetName)
		if msg:find("spell:254244") then
			targetName = Ambiguate(targetName, "none")
			if self:AntiSpam(4, targetName) then
				warnSleepCanister:CombinedShow(0.3, targetName)
				if targetName == playerName then
					local icon = self.vb.sleepCanisterIcon
					yellSleepCanister:Yell(icon, sleepCanister, icon)
				elseif self:CheckNearby(10, targetName) then
					specWarnSleepCanisterNear:CombinedShow(0.3, targetName)
					specWarnSleepCanisterNear:Play("runaway")
				end
			end
			if self.Options.SetIconOnSleepCanister then
				self:SetIcon(targetName, self.vb.sleepCanisterIcon)
			end
			self.vb.sleepCanisterIcon = self.vb.sleepCanisterIcon + 1
			if self.vb.sleepCanisterIcon == 3 then
				self.vb.sleepCanisterIcon = 1
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 248995 or spellId == 248194 then
		timerSeverCD:Stop()
		timerChargedBlastsCD:Stop()
		countdownChargedBlasts:Cancel()
		timerShrapnalBlastCD:Stop()
		timerPulseGrenadeCD:Stop()
		countdownPulseGrenade:Cancel()
		timerSleepCanisterCD:Stop()
		timerShocklanceCD:Stop()
		warnPhase:Play("phasechange")
	end
end

function mod:UNIT_HEALTH(uId)
	if self:IsHeroic() or self:IsNormal() or self:IsLFR() then
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 124158 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.72 then --Скоро фаза 2 (за 5%)
			warned_preP1 = true
			warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 124158 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.39 then --Скоро фаза 3 (за 5%)
			warned_preP3 = true
			warnPrePhase3:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		end
	elseif self:IsMythic() then
		if self.vb.phase == 1 and not warned_preP1 and self:GetUnitCreatureId(uId) == 124158 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.86 then --Скоро фаза 2 +
			warned_preP1 = true
			warnPrePhase2:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 2 and warned_preP2 and not warned_preP3 and self:GetUnitCreatureId(uId) == 124158 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.66 then --Скоро фаза 3 (за 5%)
			warned_preP3 = true
			warnPrePhase3:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 3 and warned_preP4 and not warned_preP5 and self:GetUnitCreatureId(uId) == 124158 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.46 then --Скоро фаза 4 (за 5%)
			warned_preP5 = true
			warnPrePhase4:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		elseif self.vb.phase == 4 and warned_preP6 and not warned_preP7 and self:GetUnitCreatureId(uId) == 124158 and UnitHealth(uId) / UnitHealthMax(uId) <= 0.26 then --Скоро фаза 5 (за 5%)
			warned_preP7 = true
			warnPrePhase5:Show(DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage:format(self.vb.phase+1))
		end
	end
end
