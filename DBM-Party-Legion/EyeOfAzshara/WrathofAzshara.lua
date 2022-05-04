local mod	= DBM:NewMod(1492, "DBM-Party-Legion", 3, 716)
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 17650 $"):sub(12, -3))
mod:SetCreatureID(96028)
mod:SetEncounterID(1814)
mod:SetZone()

mod:RegisterCombat("combat")
mod:SetUsedIcons(8)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 192706",
	"SPELL_AURA_REMOVED 192706",
	"SPELL_CAST_START 192617 192985",
	"CHAT_MSG_RAID_BOSS_EMOTE",
	"UNIT_SPELLCAST_SUCCEEDED boss1"
)
local warnArcaneBomb				= mod:NewTargetNoFilterAnnounce(192706, 4) --Чародейская бомба
local warnMythicTornado				= mod:NewSpellAnnounce(192680, 3) --Волшебный торнадо target scanning not available

local specWarnArcaneBomb			= mod:NewSpecialWarningYouMoveAway(192706, nil, nil, nil, 3, 2) --Чародейская бомба
local specWarnArcaneBomb2			= mod:NewSpecialWarningDispel(192706, "MagicDispeller2", nil, nil, 3, 5) --Чародейская бомба
local specWarnMassiveDeluge			= mod:NewSpecialWarningDodge(192617, "Tank", nil, nil, 3, 2) --Потоп

local timerMythicTornadoCD			= mod:NewCDTimer(25, 192680, nil, nil, nil, 3) --Волшебный торнадо
local timerMassiveDelugeCD			= mod:NewCDTimer(50, 192617, nil, "Tank", nil, 5, nil, DBM_CORE_TANK_ICON) --Потоп
local timerArcaneBomb				= mod:NewTargetTimer(15, 192706, nil, nil, nil, 5, nil, DBM_CORE_MAGIC_ICON) --Чародейская бомба
local timerArcaneBombCD				= mod:NewCDTimer(23, 192706, nil, nil, nil, 3, nil, DBM_CORE_DEADLY_ICON) --Чародейская бомба 23-37

local yellArcaneBomb				= mod:NewYell(192706, nil, nil, nil, "YELL") --Чародейская бомба
local yellArcaneBombFades			= mod:NewFadesYell(192706, nil, nil, nil, "YELL") --Чародейская бомба

mod:AddRangeFrameOption(10, 192706) --Чародейская бомба
mod:AddSetIconOption("SetIconOnArcaneBomb", 192706, true, false, {8}) --Чародейская бомба

mod.vb.phase = 1
local serpMod = DBM:GetModByName(1479)

function mod:CheckPhase2()
	return 
end

function mod:OnCombatStart(delay)
	self.vb.phase = 1
	timerMythicTornadoCD:Start(8.5-delay)
	timerMassiveDelugeCD:Start(12-delay)
	timerArcaneBombCD:Start(23-delay)
end

function mod:OnCombatEnd()
	self.vb.phase = 1
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	local spellId = args.spellId
	if spellId == 192706 then --Чародейская бомба
		timerArcaneBomb:Start(args.destName)
		if self.Options.RangeFrame then
			DBM.RangeCheck:Show(10)
		end
		if self.Options.SetIconOnArcaneBomb then
			self:SetIcon(args.destName, 8, 15)
		end
	end
end

function mod:SPELL_AURA_REMOVED(args)
	local spellId = args.spellId
	if spellId == 192706 then --Чародейская бомба
		timerArcaneBomb:Cancel(args.destName)
		if args:IsPlayer() then
			yellArcaneBombFades:Cancel()
		end
		if self.Options.RangeFrame then
			DBM.RangeCheck:Hide()
		end
		if self.Options.SetIconOnArcaneBomb then
			self:SetIcon(args.destName, 0)
		end
	end
end

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 192985 then
		self.vb.phase = 2
		if not serpMod then serpMod = DBM:GetModByName(1479) end
		serpMod:UpdateWinds()--At present it may not actually reset here. Just in case though
	elseif spellId == 192617 then
		specWarnMassiveDeluge:Show()
		specWarnMassiveDeluge:Play("shockwave")
		if self.vb.phase == 2 then
			timerMassiveDelugeCD:Start(35)
		else
			timerMassiveDelugeCD:Start()
		end
	end
end

--2 seconds faster than combat log
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg, _, _, _, targetname)
	if msg:find("spell:192708") then
		timerArcaneBombCD:Start()
		if targetname == UnitName("player") then
			specWarnArcaneBomb:Show()
			specWarnArcaneBomb:Play("runout")
			yellArcaneBomb:Yell()
			yellArcaneBombFades:Countdown(15, 3)
		else
			specWarnArcaneBomb2:Show(targetname)
		end
		warnArcaneBomb:Show(targetname)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(uId, _, bfaSpellId, _, legacySpellId)
	local spellId = legacySpellId or bfaSpellId
	if spellId == 192680 then--Mythic Tornado
		warnMythicTornado:Show()
		if self.vb.phase == 2 then
			timerMythicTornadoCD:Start(15)
		else
			timerMythicTornadoCD:Start()
		end
	end
end
