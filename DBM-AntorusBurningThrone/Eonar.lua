local mod	= DBM:NewMod(2025, "DBM-AntorusBurningThrone", nil, 946)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(122500, 124445)
mod:SetEncounterID(2075)
mod:SetZone()
--mod:SetBossHPInfoToHighest()
mod:SetUsedIcons(8, 7, 6, 5, 4)
mod:SetHotfixNoticeRev(16960)
mod.respawnTime = 30

mod:RegisterCombat("combat")
--mod:RegisterCombat("combat_yell", L.YellPullEonar)

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 249121 250701 246305",
	"SPELL_CAST_SUCCESS 254769 250048", --246753
	"SPELL_AURA_APPLIED 250074 250555 249016 248332 250073 250693 250691 250140 246753 249017 249015",
	"SPELL_AURA_APPLIED_DOSE 250140",
	"SPELL_AURA_REMOVED 250074 250555 249016 248332 250693 250691",
--	"SPELL_DAMAGE 248329",
--	"SPELL_MISSED 248329",
	"UNIT_DIED",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"SPELL_PERIODIC_DAMAGE 248795",
	"SPELL_PERIODIC_MISSED 248795",
	"UNIT_SPELLCAST_SUCCEEDED boss1 boss2 boss3 boss4 boss5",
	"UNIT_SPELLCAST_CHANNEL_STOP boss1 boss2 boss3 boss4 boss5",
	"UNIT_SPELLCAST_STOP boss1 boss2 boss3 boss4 boss5"
)

--The Paraxis
local warnRainofFel						= mod:NewTargetAnnounce(248332, 2) --Дождь Скверны
local warnWarpIn						= mod:NewTargetAnnounce(246888, 3, nil, nil, nil, nil, nil, 2, true) --Прибытие
local warnLifeForce						= mod:NewCountAnnounce(250048, 1) --Жизненная сила
local warnPurge							= mod:NewCastAnnounce(249934, 4) --Судный миг

local specWarnFelWake					= mod:NewSpecialWarningYouMove(248795, nil, nil, nil, 1, 2) --Отголосок скверны
--The Paraxis
local specWarnSpearofDoom				= mod:NewSpecialWarningDodge(248789, nil, nil, nil, 2, 3) --Копье Рока
--local yellSpearofDoom					= mod:NewYell(248789) --Копье Рока
local specWarnRainofFel					= mod:NewSpecialWarningYouMoveAway(248332, nil, nil, 2, 1, 2) --Дождь Скверны
--Adds
local specWarnSwing						= mod:NewSpecialWarningDodge(250701, "Melee", nil, nil, 1, 2) --Размах Скверны
local specWarnArtilleryStrike			= mod:NewSpecialWarningInterrupt(246305, "HasInterrupt", nil, nil, 1, 3) --Артиллерийский удар
--local yellBurstingDreadflame			= mod:NewPosYell(238430, DBM_CORE_AUTO_YELL_CUSTOM_POSITION)
--local specWarnMalignantAnguish		= mod:NewSpecialWarningInterrupt(236597, "HasInterrupt")
--local specWarnGTFO					= mod:NewSpecialWarningGTFO(238028, nil, nil, nil, 1, 2)
--Mythic
local specWarnFinalDoom					= mod:NewSpecialWarningParaxisCount(249121, nil, nil, nil, 1, 2) --Всеобщая погибель
local specWarnArcaneBuildup				= mod:NewSpecialWarningYouMoveAway(250171, nil, nil, nil, 4, 2) --Волшебный вихрь
local specWarnBurningEmbers				= mod:NewSpecialWarningYouMoveAway(250691, nil, nil, nil, 4, 2) --Раскаленные угли
local specWarnFoulSteps					= mod:NewSpecialWarningStack(250140, nil, 12, nil, nil, 1, 6) --Гнусные приемы Fine tune

--The Paraxis
mod:AddTimerLine(GENERAL)
local timerSpearofDoomCD				= mod:NewCDCountTimer(55, 248789, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Копье Рока 55-69
--local timerRainofFelCD					= mod:NewCDCountTimer(61, 248332, nil, nil, nil, 3) --Дождь Скверны
mod:AddTimerLine(DBM_ADDS)
local timerDestructorCD					= mod:NewTimer(90, "timerDestructor", 254769, nil, nil, 1, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --Разрушитель
local timerObfuscatorCD					= mod:NewTimer(90, "timerObfuscator", 246753, nil, nil, 1, DBM_CORE_DAMAGE_ICON) --Маскировщик
local timerPurifierCD					= mod:NewTimer(90, "timerPurifier", 250074, nil, nil, 1, DBM_CORE_TANK_ICON..DBM_CORE_DAMAGE_ICON) --Очиститель
local timerBatsCD						= mod:NewTimer(90, "timerBats", 242080, nil, nil, 1, DBM_CORE_DAMAGE_ICON) --Мыши
--Mythic 
mod:AddTimerLine(ENCOUNTER_JOURNAL_SECTION_FLAG12)
local timerPurge						= mod:NewCastTimer(30, 249934, nil, nil, nil, 2, nil, DBM_CORE_MYTHIC_ICON..DBM_CORE_DEADLY_ICON) --Судный миг
local timerFinalDoom					= mod:NewCastTimer(50, 249121, nil, nil, nil, 2, nil, DBM_CORE_MYTHIC_ICON..DBM_CORE_DEADLY_ICON) --Всеобщая погибель
local timerFinalDoomCD					= mod:NewCDCountTimer(90, 249121, nil, nil, nil, 6, nil, DBM_CORE_MYTHIC_ICON) --Всеобщая погибель

local timerArcaneSingularity			= mod:NewNextTimer(25, 250171, nil, nil, nil, 7) --Магическая сингулярность
local timerArcaneSingularity2			= mod:NewCastTimer(3, 250171, nil, nil, nil, 7) --Магическая сингулярность
local timerBurningEmbers				= mod:NewNextTimer(30, 250691, nil, nil, nil, 7) --Раскаленные угли
local timerBurningEmbers2				= mod:NewCastTimer(3, 250691, nil, nil, nil, 7) --Раскаленные угли

local berserkTimer						= mod:NewBerserkTimer(600)

local yellRainofFel						= mod:NewYell(248332, nil, nil, nil, "YELL") --Дождь Скверны
local yellRainofFelFades				= mod:NewShortFadesYell(248332, nil, nil, nil, "YELL") --Дождь Скверны
local yellArcaneBuildup					= mod:NewYell(250171, nil, nil, nil, "YELL") --Волшебный вихрь
local yellArcaneBuildupFades			= mod:NewFadesYell(250171, nil, nil, nil, "YELL") --Волшебный вихрь
local yellBurningEmbers					= mod:NewYell(250691, nil, nil, nil, "YELL") --Раскаленные угли
local yellBurningEmbersFades			= mod:NewFadesYell(250691, nil, nil, nil, "YELL") --Раскаленные угли
--The Paraxis
--local countdownRainofFel				= mod:NewCountdown("Alt60", 248332) --Дождь Скверны Not accurate enough yet. not until timer correction is added to handle speed of raids dps affecting sequence
--Mythic
local countdownFinalDoom				= mod:NewCountdown(90, 249121, nil, nil, 5) --Всеобщая погибель
local countdownFinalDoom2				= mod:NewCountdownFades(50, 249121, nil, nil, 5) --Всеобщая погибель
local countdownArcaneSingularity		= mod:NewCountdown("Alt3", 250171, nil, nil) --Магическая сингулярность
local countdownBurningEmbers			= mod:NewCountdown("Alt3", 250691, nil, nil) --Раскаленные угли

--mod:AddSetIconOption("SetIconOnFeedbackTargeted2", 249016, false, false, {6, 5, 4, 3, 2, 1})
mod:AddSetIconOption("SetIconOnBurningEmbers", 249015, true, false, {8, 7, 6, 5, 4})
mod:AddInfoFrameOption(250030, true)
mod:AddNamePlateOption("NPAuraOnPurification", 250074)
mod:AddNamePlateOption("NPAuraOnFelShielding", 250555)
mod:AddRangeFrameOption("8/10")

mod.vb.rainOfFelCount = 0
mod.vb.lifeForceCast = 0
mod.vb.purgeCast = 0
mod.vb.lifeRequired = 5
mod.vb.spearCast = 0
mod.vb.finalDoomCast = 0
mod.vb.destructors = 0
mod.vb.obfuscators = 0
mod.vb.purifiers = 0
--Timers combine multi sets,counts above do not combine cause for info frame
mod.vb.destructorCast = 0
mod.vb.obfuscatorCast = 0
mod.vb.purifierCast = 0
mod.vb.batCast = 0
mod.vb.targetedIcon = 1
mod.vb.burningembersIcon = 8
--local normalRainOfFelTimers = {}--PTR, recheck
--local burningembersTargets = {}
--local mythicSpearofDoomTimers = {}
--ЛФР треш
local lfrDestructors = {21.5, 51.9, 50.3, 64.3, 107.2, 58.2, 44.1, 46.2, 44.2}--4 Life Force LFR Version
local lfrDestructors2 = {21.2, 43.8, 39.0, 51.1, 37.0, 53.0, 43.6, 45.2, 43.2}--3 Life force LFR version
--Нормал треш
--local normalDestructors = {17, 46.2, 32, 52.4, 93.7, 40.9, 50.2, 55.4, 49.2}--Live, Dec 01. Old 17, 39.4, 28, 44.2, 92.4, 41.3, 50, 53.4, 48.1
local normalDestructors = {15.7, 35.3, 41, 102, 133.5, 99.6}--Live, Dec 01. Old 17, 39.4, 28, 44.2, 92.4, 41.3, 50, 53.4, 48.1
local normalObfuscators = {79, 146.5, 94.7, 100} --переправленные сервером, всё ок
local normalBats = {159, 124, 79, 105} --переправленные сервером (почти такие же как в героике)
--Дождь Скверны героик-------------------------------------------------------------------------------------------------------------
--local heroicRainOfFelTimers = {9.3, 43, 10, 43, 20, 19, 20, 29.2, 45, 25, 99}--Live, Dec 26
--local heroicRainOfFelTimers = {14, 37.5, 21.5, 28, 29, 43.5, 32, 31.5, 25, 34, 45} --у 1 +4.7сек, у 2 -5.5сек, у 3 +11.5 сек, у 4 -15сек, у 5 +9сек, у 6 +24.5сек, у 7 +12сек, у 8 +2.3сек, у 9 -20сек, у 10 +9сек, у 11 -54сек
-----------------------------------------------------------------------------------------------------------------------------------
--Разрушитель героик---------------------------------------------------------------------------------------------------------------
--local heroicDestructors = {15.7, 35.3, 40.6, 104.6, 134.7, 99.6}
local heroicDestructors = {15.7, 35.3, 41, 102, 133.5, 99.6} -- ВСЕ ГОТОВО у 1 и 2 норм, у 3 -3сек, у 4 норм, у 5 +4.3 сек, у 6 хз
-----------------------------------------------------------------------------------------------------------------------------------
--Маскировщик героик---------------------------------------------------------------------------------------------------------------
--local heroicObfuscators = {80.6, 148.5, 94.7, 99.9}
local heroicObfuscators = {77.6, 146.5, 94.7, 100} --у 1 -3сек, у 2 -2.5сек, у 3 хз
-----------------------------------------------------------------------------------------------------------------------------------
--Очиститель героик----------------------------------------------------------------------------------------------------------------
--local heroicPurifiers = {125, 66.1, 30.6}
local heroicPurifiers = {116.5, 67.3, 29.6} --у 1 -8.5сек, у 2 +1.2 сек, у 3 -1сек
-----------------------------------------------------------------------------------------------------------------------------------
--Мыши героик----------------------------------------------------------------------------------------------------------------------
--local heroicBats = {170, 125, 105, 105}
local heroicBats = {159, 124, 79, 105} --у 1 -10сек, у 2 -3сек, у 3 -20сек
--Копье Рока героик----------------------------------------------------------------------------------------------------------------
--local heroicSpearofDoomTimers = {35, 59.2, 64.3, 40, 84.7, 34.1, 65.2}--Live, Nov 29
local heroicSpearofDoomTimers = {34, 60, 60, 60, 60, 60, 60} -- ВСЕ ГОТОВО у 1 -1сек, у 2 +0.8 сек, у 3 -4.3сек, у 4 +20сек, у 5 -25сек, у 6+ 26сек, у 7 хз, НО СКОРЕЕ ВСЕГО -5сек
-----------------------------------------------------------------------------------------------------------------------------------
--Дождь Скверны мифик--------------------------------------------------------------------------------------------------------------
--local mythicRainOfFelTimers = {6, 23.1, 24.1, 46, 25, 49.3, 15, 45, 24, 49.2, 24.1, 49.2, 50}--Live, Dec 14
--local mythicRainOfFelTimers = {14, 39.5, 68.8, 28, 32.5, 38.3, 21, 29.5, 26, 21.2, 33.5, 41.2, 58.5} -- ВСЕ ГОТОВО у 1 +8сек, у 2 +16.4сек, у 3 +38.7сек, у 4 -18сек, у 5 +7.5 сек, у 6 -11сек, у 7 +6сек, у 8 -15.5, у 9 +2сек, у 10 -28сек, у 11 +9.4, у 12 -8сек, у 13 +8.5сек
-----------------------------------------------------------------------------------------------------------------------------------
--Разрушитель мифик----------------------------------------------------------------------------------------------------------------
--local mythicDestructors = {27, 18, 87.4, 288.4, 20, 79}--Changed Dec 12th
local mythicDestructors = {27, 21, 90.4, 289.5, 22, 80} --у 2 +3 сек, у 3 +3 сек, у 4 +1 сек
-----------------------------------------------------------------------------------------------------------------------------------
--Маскировщик мифик----------------------------------------------------------------------------------------------------------------
--local mythicObfuscators = {46, 243, 43.8, 90.8}
local mythicObfuscators = {43, 247.5, 44.3, 90, 100.5} --у 1 -3сек, у 2 +4.5сек, у 4 -0.8сек
-----------------------------------------------------------------------------------------------------------------------------------
--Очиститель мифик-----------------------------------------------------------------------------------------------------------------
--local mythicPurifiers = {65.7, 82.6, 66.9, 145.7}
local mythicPurifiers = {66, 83, 60, 137.7} --у 3 -6.9сек
-----------------------------------------------------------------------------------------------------------------------------------
--Мыши мифик-----------------------------------------------------------------------------------------------------------------------
--local mythicBats = {195, 79.9, 100, 95}
--local mythicBats = {180, 70.5, 93.6, 121} --у 1 -15сек, у 2 -9.4сек, у 3 -6.4 сек, у 4 +26 сек
local mythicBats = {189, 76, 103.5, 84} --
-----------------------------------------------------------------------------------------------------------------------------------
--Копье Рока мифик--
local mythicSpearofDoomTimers = {34, 96.5, 135.5, 74.5, 116, 34.1, 65.2} --у 1 -1сек, у 2 +37.3 сек, у 3 +71.2 сек, у 4 +34.5 сек, у 5 +31.3 сек - далее хз
-------------------------------------------------------------------------------------------------------------------------------------------------------------
--Всеобщая погибель----------------------------------------------------------------------------------------------------------------
--local finalDoomTimers = {59.3, 120, 94, 104.6, 99.6}--Live, Dec 5
local finalDoomTimers = {58.8, 126, 98, 106.1, 100} -- ВСЕ ГОТОВО у 1 -0.5 сек, у 2 +6 сек, у 3 +4 секLive, у 4 +1.5 сек, у 5 +0.4
-----------------------------------------------------------------------------------------------------------------------------------
local warnedAdds = {} --центр, сверху, снизу
local addCountToLocationMythic = {
	["Dest"] = {DBM_CORE_MIDDLE, DBM_CORE_TOP, DBM_CORE_BOTTOM, DBM_CORE_MIDDLE, DBM_CORE_TOP, DBM_CORE_MIDDLE},
	["Obfu"] = {DBM_CORE_BOTTOM, DBM_CORE_MIDDLE, DBM_CORE_TOP, DBM_CORE_BOTTOM, DBM_CORE_UNKNOWN}, --определить откуда выходит 5-ый маскировщик
	["Pur"] = {DBM_CORE_MIDDLE, DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_TOP}
--	["Pur"] = {DBM_CORE_MIDDLE, DBM_CORE_MIDDLE, DBM_CORE_TOP}
}
local addCountToLocationHeroic = {
	["Dest"] = {DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_TOP, DBM_CORE_BOTTOM, DBM_CORE_MIDDLE.."/"..DBM_CORE_TOP, DBM_CORE_MIDDLE.."/"..DBM_CORE_TOP},
	["Obfu"] = {DBM_CORE_TOP, DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_BOTTOM},
	["Pur"] = {DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_MIDDLE}
}
local addCountToLocationNormal = {
--	["Dest"] = {DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_MIDDLE, DBM_CORE_TOP, DBM_CORE_BOTTOM, DBM_CORE_TOP, DBM_CORE_MIDDLE, DBM_CORE_TOP, DBM_CORE_MIDDLE},
	["Dest"] = {DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_TOP, DBM_CORE_BOTTOM, DBM_CORE_MIDDLE.."/"..DBM_CORE_TOP, DBM_CORE_MIDDLE.."/"..DBM_CORE_TOP},
	["Obfu"] = {DBM_CORE_TOP, DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_BOTTOM} --всё збс
}
local addCountToLocationLFR = {
	["Dest"] = {DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_TOP, DBM_CORE_MIDDLE, DBM_CORE_BOTTOM, DBM_CORE_TOP,DBM_CORE_BOTTOM, DBM_CORE_TOP, DBM_CORE_BOTTOM}
}

local lifeForceName = DBM:GetSpellInfo(250048)
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
		--Boss Powers first
		local cid = mod:GetUnitCreatureId("boss1") or 0
		if cid ~= 124445 then--Filter Paraxus
			local currentPower = UnitPower("boss1", 10) or 0
			local currentHealth = (UnitHealth("boss1")/UnitHealthMax("boss1") * 100) or 100
			addLine(L.EonarHealth, math.floor(currentHealth).."%")
			addLine(L.EonarPower, currentPower)
		end
		local cid2 = mod:GetUnitCreatureId("boss2") or 0
		if cid2 ~= 124445 then--Filter Paraxus
			local currentPower = UnitPower("boss2", 10) or 0
			local currentHealth = (UnitHealth("boss2")/UnitHealthMax("boss2") * 100) or 100
			addLine(L.EonarHealth, math.floor(currentHealth).."%")
			addLine(L.EonarPower, currentPower.."%")
		end
		addLine(lifeForceName, mod.vb.lifeForceCast.."/"..mod.vb.lifeRequired)
		if mod:IsLFR() then
			local nextLocation = addCountToLocationLFR["Dest"][mod.vb.destructorCast+1]
			if nextLocation then
				addLine(L.NextLoc, nextLocation)
			end
		end
		if mod.vb.obfuscators > 0 then
			addLine(L.Obfuscators, mod.vb.obfuscators)
		end
		if mod.vb.destructors > 0 then
			addLine(L.Destructors, mod.vb.destructors)
		end
		if mod.vb.purifiers > 0 then
			addLine(L.Purifiers, mod.vb.purifiers)
		end
		return lines, sortedLines
	end
end

--This is backup for fixing timers if destructors die before they ever cast high alert, such as massively overgearing encounter and able to burn it down in less than 10 seconds
local function checkForDeadDestructor(self, forceStart)
	self:Unschedule(checkForDeadDestructor)
	self.vb.destructorCast = self.vb.destructorCast + 1
	local timer = self:IsMythic() and mythicDestructors[self.vb.destructorCast+1] or self:IsHeroic() and heroicDestructors[self.vb.destructorCast+1] or self:IsNormal() and normalDestructors[self.vb.destructorCast+1] or self:IsLFR() and lfrDestructors2[self.vb.destructorCast+1]
	if forceStart then
		DBM:Debug("checkForDeadDestructor ran with forceStart arg for "..self.vb.destructorCast, 2)
		local text = self:IsHeroic() and addCountToLocationHeroic["Dest"][self.vb.destructorCast+1] or self:IsNormal() and addCountToLocationNormal["Dest"][self.vb.destructorCast+1] or self:IsMythic() and addCountToLocationMythic["Dest"][self.vb.destructorCast+1] or self:IsLFR() and addCountToLocationLFR["Dest"][self.vb.destructorCast+1] or self.vb.destructorCast+1
		timerDestructorCD:Start(forceStart, text)--Minus 10 for being 10 seconds after high alert, and minus 10 for wanting when it spawns not high alert cast
		self:Schedule(forceStart+20, checkForDeadDestructor, self)--10 seconds after high alert
	elseif timer then
		local text = self:IsHeroic() and addCountToLocationHeroic["Dest"][self.vb.destructorCast+1] or self:IsNormal() and addCountToLocationNormal["Dest"][self.vb.destructorCast+1] or self:IsMythic() and addCountToLocationMythic["Dest"][self.vb.destructorCast+1] or self:IsLFR() and addCountToLocationLFR["Dest"][self.vb.destructorCast+1] or self.vb.destructorCast+1
		timerDestructorCD:Start(timer-20, text)--Minus 10 for being 10 seconds after high alert, and minus 10 for wanting when it spawns not high alert cast
		self:Schedule(timer, checkForDeadDestructor, self)--10 seconds after high alert
	end
	DBM:Debug("checkForDeadDestructor ran, which means a destructor died before casting high alert, or DBM has a timer error near: "..self.vb.destructorCast, 2)
end


local function burningembersOnPlayer(self) --Раскаленные угли
	specWarnBurningEmbers:Show()
	specWarnBurningEmbers:Play("runaway")
	timerBurningEmbers2:Start()
	countdownBurningEmbers:Start()
	yellBurningEmbersFades:Countdown(3)
	if self:IsHard() then
		self:Schedule(30, burningembersOnPlayer, self)
		timerBurningEmbers:Start(30)
	end
end

local function arcanesingularityOnPlayer(self) --Магическая сингулярность
	specWarnArcaneBuildup:Show()
	specWarnArcaneBuildup:Play("runaway")
	timerArcaneSingularity2:Start()
	countdownArcaneSingularity:Start()
	yellArcaneBuildupFades:Countdown(3)
	if self:IsHard() then
		self:Schedule(25, arcanesingularityOnPlayer, self)
		timerArcaneSingularity:Start(25)
	end
end


local function startBatsStuff(self)
	self.vb.batCast = self.vb.batCast + 1
	warnWarpIn:Show(L.Bats)
	warnWarpIn:Play("killmob")
	local timer = self:IsMythic() and mythicBats[self.vb.batCast+1] or self:IsHeroic() and heroicBats[self.vb.batCast+1] or self:IsNormal() and normalBats[self.vb.batCast+1]
	if timer then
		timerBatsCD:Start(timer, self.vb.batCast+1)
		self:Schedule(timer, startBatsStuff, self)
	end
end

function mod:OnCombatStart(delay)
	self.vb.rainOfFelCount = 0
	self.vb.destructors = 0
	self.vb.obfuscators = 0
	self.vb.purifiers = 0
	self.vb.destructorCast = 0
	self.vb.obfuscatorCast = 0
	self.vb.purifierCast = 0
	self.vb.batCast = 0
	self.vb.lifeForceCast = 0
	self.vb.purgeCast = 0
	self.vb.spearCast = 0
	self.vb.finalDoomCast = 0
	self.vb.targetedIcon = 1
	self.vb.burningembersIcon = 8
	berserkTimer:Start(-delay)
	if not self:IsLFR() then
		self.vb.lifeRequired = 4
		if self:IsMythic() then
		--	timerRainofFelCD:Start(14-delay, 1) --Дождь Скверны
			timerSpearofDoomCD:Start(34-delay, 1) --Копье Рока
			timerDestructorCD:Start(17, DBM_CORE_MIDDLE) --Разрушитель
			self:Schedule(30, checkForDeadDestructor, self, 5)
			timerObfuscatorCD:Start(43, DBM_CORE_BOTTOM) --маскировщик, подправил
			timerPurifierCD:Start(65.7, DBM_CORE_MIDDLE) --Очиститель
			timerFinalDoomCD:Start(58.8-delay, 1) --Всеобщая погибель
			countdownFinalDoom:Start(58.8-delay) --Всеобщая погибель
			timerBatsCD:Start(189, 1) --мыши, подправил
			self:Schedule(189, startBatsStuff, self)
		elseif self:IsHeroic() then
		--	timerRainofFelCD:Start(14 -delay, 1) --Дождь Скверны, подправил
			timerDestructorCD:Start(13, DBM_CORE_MIDDLE) --Разрушитель
			self:Schedule(27, checkForDeadDestructor, self)
			timerSpearofDoomCD:Start(34-delay, 1) --Копье Рока
			timerObfuscatorCD:Start(77.6, DBM_CORE_TOP) --маскировщик, подправил
			timerPurifierCD:Start(116.5, DBM_CORE_MIDDLE) --очиститель, подправил
			timerBatsCD:Start(159, 1) --мыши, подправил
			self:Schedule(159, startBatsStuff, self) --мыши, подправил
		else--Normal
			timerDestructorCD:Start(13, DBM_CORE_MIDDLE) --Разрушитель, было 7
			self:Schedule(27, checkForDeadDestructor, self)
			timerObfuscatorCD:Start(79, DBM_CORE_TOP) --маскировщик, подправил
			timerBatsCD:Start(159, 1) --мыши, подправил
			self:Schedule(159, startBatsStuff, self)
		--	timerRainofFelCD:Start(30-delay, 1)
		end
	else
		self.vb.lifeRequired = 3
		timerDestructorCD:Start(12, DBM_CORE_MIDDLE)
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Show(7, "function", updateInfoFrame, false, false)
	end
	if self.Options.NPAuraOnPurification or self.Options.NPAuraOnFelShielding then
		DBM:FireEvent("BossMod_EnableHostileNameplates")
	end
end

function mod:OnCombatEnd()
	table.wipe(warnedAdds)
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.InfoFrame then
		DBM.InfoFrame:Hide()
	end
	if self.Options.NPAuraOnPurification or self.Options.NPAuraOnFelShielding then
		DBM.Nameplate:Hide(true, nil, nil, nil, true, true)
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 249121 then
		self.vb.finalDoomCast = self.vb.finalDoomCast + 1
		specWarnFinalDoom:Show(self.vb.finalDoomCast)
		specWarnFinalDoom:Play("specialsoon")
		timerFinalDoom:Start()
		countdownFinalDoom2:Start()
		local timer = finalDoomTimers[self.vb.finalDoomCast+1]
		if timer then
			timerFinalDoomCD:Start(timer, self.vb.finalDoomCast+1)
			countdownFinalDoom:Start(timer)
		end
	elseif spellId == 250701 and self:CheckInterruptFilter(args.sourceGUID, false, true) then --Размах скверны
		specWarnSwing:Show()
		specWarnSwing:Play("watchstep")
	elseif spellId == 246305 then --Артиллерийский удар
		if self:CheckTargetFilter(args.sourceGUID) then
			specWarnArtilleryStrike:Show()
			specWarnArtilleryStrike:Play("kickcast")
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	local spellId = args.spellId
--[[	if spellId == 246753 and not warnedAdds[args.sourceGUID] then--Cloak
		warnedAdds[args.sourceGUID] = true
		self.vb.obfuscators = self.vb.obfuscators + 1
		if self:AntiSpam(5, args.sourceName) then
			warnWarpIn:Show(L.Obfuscators)
			warnWarpIn:Play("bigmob")
			self.vb.obfuscatorCast = self.vb.obfuscatorCast + 1
			local timer = self:IsMythic() and mythicObfuscators[self.vb.obfuscatorCast+1] or self:IsHeroic() and heroicObfuscators[self.vb.obfuscatorCast+1] or self:IsNormal() and normalObfuscators[self.vb.obfuscatorCast+1]
			if timer then
				local text = self:IsHeroic() and addCountToLocationHeroic["Obfu"][self.vb.obfuscatorCast+1] or self:IsNormal() and addCountToLocationNormal["Obfu"][self.vb.obfuscatorCast+1] or self:IsMythic() and addCountToLocationMythic["Obfu"][self.vb.obfuscatorCast+1] or self.vb.obfuscatorCast+1
				timerObfuscatorCD:Start(timer, text)
			end
		end
	if spellId == 254769 and args:GetSrcCreatureID() == 123760 and not warnedAdds[args.sourceGUID] then --Повышенная готовность
		warnedAdds[args.sourceGUID] = true
		self:Unschedule(checkForDeadDestructor)
		self.vb.destructors = self.vb.destructors + 1
		if self:AntiSpam(5, args.sourceName) then
			warnWarpIn:Show(L.Destructors)
			warnWarpIn:Play("bigmob")
			self.vb.destructorCast = self.vb.destructorCast + 1
			local timer = self:IsMythic() and mythicDestructors[self.vb.destructorCast+1] or self:IsHeroic() and heroicDestructors[self.vb.destructorCast+1] or self:IsNormal() and normalDestructors[self.vb.destructorCast+1] or self:IsLFR() and lfrDestructors2[self.vb.destructorCast+1]
			if timer then
				local text = self:IsHeroic() and addCountToLocationHeroic["Dest"][self.vb.destructorCast+1] or self:IsNormal() and addCountToLocationNormal["Dest"][self.vb.destructorCast+1] or self:IsMythic() and addCountToLocationMythic["Dest"][self.vb.destructorCast+1] or self:IsLFR() and addCountToLocationLFR["Dest"][self.vb.destructorCast+1] or self.vb.destructorCast+1
				if not self:IsLFR() then--This work around doesn't work in LFR because if dps is slow LFR massively slows down spawns to help out
					self:Schedule(timer+10, checkForDeadDestructor, self)
				else
					timerDestructorCD:Stop()--Because of way LFR works, we need to do timer cleanup if they come earlier than expected
				end
				timerDestructorCD:Start(timer-10, text)--High alert fires about 9 seconds after spawn so using it as a trigger has a -10 adjustment
			end
		end]]
	if spellId == 250048 then
		self.vb.lifeForceCast = self.vb.lifeForceCast + 1
		warnLifeForce:Show(self.vb.lifeForceCast)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 250073 and not warnedAdds[args.sourceGUID] then --Очиститель (баф очистителя)
		warnedAdds[args.sourceGUID] = true
		self.vb.purifiers = self.vb.purifiers + 1
		if self:AntiSpam(5, 2) then
			warnWarpIn:Show(L.Purifiers)
			warnWarpIn:Play("bigmob")
			self.vb.purifierCast = self.vb.purifierCast + 1
			local timer = self:IsMythic() and mythicPurifiers[self.vb.purifierCast+1] or self:IsHeroic() and heroicPurifiers[self.vb.purifierCast+1]
			if timer then
				local text = self:IsHeroic() and addCountToLocationHeroic["Pur"][self.vb.purifierCast+1] or self:IsNormal() and addCountToLocationNormal["Pur"][self.vb.purifierCast+1] or self:IsMythic() and addCountToLocationMythic["Pur"][self.vb.purifierCast+1] or self.vb.purifierCast+1
				timerPurifierCD:Start(timer, text)
			end
		end
	elseif spellId == 246753 and not warnedAdds[args.sourceGUID] then --Маскировщик (баф маскировщика)
		warnedAdds[args.sourceGUID] = true
		self.vb.obfuscators = self.vb.obfuscators + 1
		if self:AntiSpam(5, 2) then
			warnWarpIn:Show(L.Obfuscators)
			warnWarpIn:Play("bigmob")
			self.vb.obfuscatorCast = self.vb.obfuscatorCast + 1
			local timer = self:IsMythic() and mythicObfuscators[self.vb.obfuscatorCast+1] or self:IsHeroic() and heroicObfuscators[self.vb.obfuscatorCast+1] or self:IsNormal() and normalObfuscators[self.vb.obfuscatorCast+1]
			if timer then
				local text = self:IsHeroic() and addCountToLocationHeroic["Obfu"][self.vb.obfuscatorCast+1] or self:IsNormal() and addCountToLocationNormal["Obfu"][self.vb.obfuscatorCast+1] or self:IsMythic() and addCountToLocationMythic["Obfu"][self.vb.obfuscatorCast+1] or self.vb.obfuscatorCast+1
				timerObfuscatorCD:Start(timer, text)
			end
		end
	elseif spellId == 254769 and args:GetSrcCreatureID() == 123760 and not warnedAdds[args.sourceGUID] then --Повышенная готовность
		warnedAdds[args.sourceGUID] = true
		self:Unschedule(checkForDeadDestructor)
		self.vb.destructors = self.vb.destructors + 1
		if self:AntiSpam(5, args.sourceName) then
			warnWarpIn:Show(L.Destructors)
			warnWarpIn:Play("bigmob")
			self.vb.destructorCast = self.vb.destructorCast + 1
			local timer = self:IsMythic() and mythicDestructors[self.vb.destructorCast+1] or self:IsHeroic() and heroicDestructors[self.vb.destructorCast+1] or self:IsNormal() and normalDestructors[self.vb.destructorCast+1] or self:IsLFR() and lfrDestructors2[self.vb.destructorCast+1]
			if timer then
				local text = self:IsHeroic() and addCountToLocationHeroic["Dest"][self.vb.destructorCast+1] or self:IsNormal() and addCountToLocationNormal["Dest"][self.vb.destructorCast+1] or self:IsMythic() and addCountToLocationMythic["Dest"][self.vb.destructorCast+1] or self:IsLFR() and addCountToLocationLFR["Dest"][self.vb.destructorCast+1] or self.vb.destructorCast+1
				if not self:IsLFR() then--This work around doesn't work in LFR because if dps is slow LFR massively slows down spawns to help out
					self:Schedule(timer+10, checkForDeadDestructor, self)
				else
					timerDestructorCD:Stop()--Because of way LFR works, we need to do timer cleanup if they come earlier than expected
				end
				timerDestructorCD:Start(timer-10, text)--High alert fires about 9 seconds after spawn so using it as a trigger has a -10 adjustment
			end
		end
	elseif spellId == 250074 then--Purification (buff on enemies near purifier)
		if self.Options.NPAuraOnPurification then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
	elseif spellId == 250555 then--Fel Shielding
		if self.Options.NPAuraOnFelShielding then
			DBM.Nameplate:Show(true, args.destGUID, spellId)
		end
--[[	elseif spellId == 249016 then
		if self.Options.SetIconOnFeedbackTargeted2 then
			self:SetIcon(args.destName, self.vb.targetedIcon)
		end
		self.vb.targetedIcon = self.vb.targetedIcon + 1]]
	elseif spellId == 248332 then--Rain of Fel
		warnRainofFel:CombinedShow(1, args.destName)
		if args:IsPlayer() then
			specWarnRainofFel:Show()
			specWarnRainofFel:Play("scatter")
			yellRainofFel:Yell()
			yellRainofFelFades:Countdown(5, 3)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
	elseif spellId == 249017 then --Магическая сингулярность
		if args:IsPlayer() then
			self:Schedule(22, arcanesingularityOnPlayer, self)
			timerArcaneSingularity:Start(22)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(10)
			end
		end
	elseif spellId == 249015 then --Раскаленные угли
		self.vb.burningembersIcon = self.vb.burningembersIcon - 1
		if args:IsPlayer() then
			self:Schedule(27, burningembersOnPlayer, self)
			timerBurningEmbers:Start(27)
			if self.Options.RangeFrame then
				DBM.RangeCheck:Show(8)
			end
		end
		if self.Options.SetIconOnBurningEmbers then
			self:SetIcon(args.destName, self.vb.burningembersIcon)
		end
	elseif spellId == 250140 then--Foul Steps
		if args:IsPlayer() then
			local amount = args.amount or 1
			if amount >= 12 and amount % 4 == 0 then
				specWarnFoulSteps:Show(amount)
				specWarnFoulSteps:Play("stackhigh")
			end
		end
	end
end
mod.SPELL_AURA_APPLIED_DOSE = mod.SPELL_AURA_APPLIED

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 250074 then--Purification
		if self.Options.NPAuraOnPurification then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
	elseif spellId == 250555 then--Fel Shielding
		if self.Options.NPAuraOnFelShielding then
			DBM.Nameplate:Hide(true, args.destGUID, spellId)
		end
--[[	elseif spellId == 249016 then
		if self.Options.SetIconOnFeedbackTargeted2 then
			self:SetIcon(args.destName, 0)
		end]]
	elseif spellId == 248332 then--Rain of Fel
		if args:IsPlayer() then
			yellRainofFelFades:Cancel()
			if self.Options.RangeFrame then
				DBM.RangeCheck:Hide()
			end
		end
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 124207 and self.vb.obfuscators > 0 then--Fel-Charged Obfuscator
		self.vb.obfuscators = self.vb.obfuscators - 1
	elseif cid == 123760 then 
		if warnedAdds[args.destGUID] and self.vb.destructors > 0 then--Fel-Infused Destructor
			self.vb.destructors = self.vb.destructors - 1
		end
	elseif cid == 123726 and self.vb.purifiers > 0 then--Fel-Infused Purifier
		self.vb.purifiers = self.vb.purifiers - 1
	end
end

--[[
function mod:SPELL_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId)
	if spellId == 248329 and self:AntiSpam(5, 4) then

	end
end
mod.SPELL_MISSED = mod.SPELL_DAMAGE
--]]

function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, npc, _, _, target)
	if msg:find("spell:248861") then
		self.vb.spearCast = self.vb.spearCast + 1
		specWarnSpearofDoom:Show()
		specWarnSpearofDoom:Play("watchstep")
		local timer = self:IsHeroic() and heroicSpearofDoomTimers[self.vb.spearCast+1] or self:IsMythic() and mythicSpearofDoomTimers[self.vb.spearCast+1]
		if timer then
			timerSpearofDoomCD:Start(timer, self.vb.spearCast+1)
		end
	elseif msg:find("spell:249934") then --Судный миг
		self.vb.purgeCast = self.vb.purgeCast + 1
		warnPurge:Show()
	end
end

function mod:UNIT_SPELLCAST_CHANNEL_STOP(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 249121 then
		timerFinalDoom:Stop()
		countdownFinalDoom2:Cancel()
		timerPurge:Start()
	end
end
mod.UNIT_SPELLCAST_STOP = mod.UNIT_SPELLCAST_CHANNEL_STOP

function mod:SPELL_PERIODIC_DAMAGE(_, _, _, _, destGUID, _, _, _, spellId, spellName)
	if spellId == 248795 and destGUID == UnitGUID("player") and self:AntiSpam(2, 1) then
		specWarnFelWake:Show()
		specWarnFelWake:Play("runaway")
	end
end
mod.SPELL_PERIODIC_MISSED = mod.SPELL_PERIODIC_DAMAGE
