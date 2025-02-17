local L

---------------------------
-- Garothi Worldbreaker --
---------------------------
L= DBM:GetModLocalization(1992)

--[[
L:SetMiscLocalization({
	YellPullGarothi = "Enemy combatants detected. Threat level nominal."
})]]

---------------------------
-- Hounds of Sargeras --
---------------------------
L= DBM:GetModLocalization(1987)

L:SetOptionLocalization({
	SequenceTimers = "Squence the cooldown timers on heroic/mythic difficulty off previous ability casts instead of current ability cast to reduce timer clutter at expense of minor timer accuracy (1-2sec early)"
})

---------------------------
-- War Council --
---------------------------
L= DBM:GetModLocalization(1997)

--[[
L:SetMiscLocalization({
	YellPullCouncil = "This is one engagement you will not walk away from."
})]]

---------------------------
-- Eonar, the Lifebinder --
---------------------------
L= DBM:GetModLocalization(2025)

L:SetTimerLocalization({
	timerObfuscator		= "Next Obfuscator (%s)",
	timerDestructor 	= "Next Destructor (%s)",
	timerPurifier 		= "Next Purifier (%s)",
	timerBats	 		= "Next Bats (%s)"
})

L:SetOptionLocalization({
	timerObfuscator		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16501"),
	timerDestructor 	= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16502"),
	timerPurifier 		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej16500"),
	timerBats	 		= DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format("ej17039")
})

L:SetMiscLocalization({
--	YellPullEonar = "Champions! The forces of the Legion seek to capture my essense for their infernal master!",
	Obfuscators = "Obfuscator",
	Destructors = "Destructor",
	Purifiers 	= "Purifier",
	Bats 		= "Bats",
	EonarHealth	= "Eonar Health",
	EonarPower	= "Eonar Power",
	NextLoc		= "Next:"
})

---------------------------
-- Portal Keeper Hasabel --
---------------------------
L= DBM:GetModLocalization(1985)

L:SetOptionLocalization({
	ShowAllPlatforms = "Show all announces regardless of player platform location"
})

--[[
L:SetMiscLocalization({
	YellPullHasabel = "Is this the best you could muster? Hah. Pathetic.",
	YellPullHasabel2 = "Your war ends here.",
	YellPullHasabel3 = "The Legion devastates all who oppose us!",
--	YellPullHasabel4 = "Every world in our path has fallen. Yours is next.",
--	YellPullHasabel5 = "Your resistance is at an end!"
})]]

---------------------------
-- Imonar the Soulhunter --
---------------------------
L= DBM:GetModLocalization(2009)

L:SetWarningLocalization({
	PulseGrenade = "Pulse Grenade - stay away from others"
})

L:SetOptionLocalization({
	PulseGrenade = "Show special warning \"stay away from others\" when you are affected by $spell:250006"
})

L:SetMiscLocalization({
	DispelMe = "Dispel Me!"
--	YellPullImonar = "Your bones will be my biggest payday.", --пеля прошляпнул очко ✔
--	YellPullImonar2 = "Think I'll keep a few of your parts as a trophy.",
--	YellPullImonar3 = "Your heads will adorn my trophy room."
})

---------------------------
-- Kin'garoth --
---------------------------
L= DBM:GetModLocalization(2004)

L:SetOptionLocalization({
	InfoFrame =	"Show InfoFrame for fight overview",
	UseAddTime = "Always show timers for what's coming next when boss leaves initialisation phase instead of hiding them. (If disabled, correct timers will resume when boss becomes active again, but may leave little warning if any cooldowns only had 1-2 seconds left)"
})

--[[
L:SetMiscLocalization({
	YellPullKingaroth = "Time to work.",
	YellPullKingaroth2 = "You hope to topple my machines with those pathetic weapons?",
	YellPullKingaroth3 = "Prepare to be deconstructed."
})]]

---------------------------
-- Varimathras --
---------------------------
L= DBM:GetModLocalization(1983)

--[[
L:SetMiscLocalization({
	YellPullVarimathras = "Draw your blades! I will show you torment!",
	YellPullVarimathras2 = "Come, then. We will trade pain for pain!"
})]]

---------------------------
-- The Coven of Shivarra --
---------------------------
L= DBM:GetModLocalization(1986)

L:SetWarningLocalization({
	Amantul = "Torment of Aman'Thul in 5 sec - switch target",
	Norgannon = "Torment of Norgannon in 5 sec - run to the center",
	Golgannet = "Torment of Golganneth in 5 sec - keep a distance of 2m",
	Kazgagot = "Torment of Khaz'goroth in 5 sec - leave the center"
})

L:SetTimerLocalization({
	timerBossIncoming = DBM_INCOMING
})

L:SetOptionLocalization({
	Amantul = "Show special warning 5 seconds before appearing $spell:252479",
	Norgannon = "Show special warning 5 seconds before appearing $spell:244740",
	Golgannet = "Show special warning 5 seconds before appearing $spell:244756",
	Kazgagot = "Show special warning 5 seconds before appearing $spell:244733",
	timerBossIncoming	= "Show timer for next boss swap",
	TauntBehavior		= "Set taunt behavior for tank swaps",
	TwoMythicThreeNon	= "Swap at 2 stacks on mythic, 3 stacks on other difficulties",--Default
	TwoAlways			= "Always swap at 2 stacks regardless of difficulty",
	ThreeAlways			= "Always swap at 3 stacks regardless of difficulty",
	SetLighting			= "Automatically turn lighting setting to low when coven is engaged and restore on combat end (Not supported in mac client since mac client doesn't support low lighting)",
	InterruptBehavior	= "Set interrupt behavior for raid (Requires raid leader)",
	Three				= "3 person rotation ",--Default
	Four				= "4 person rotation ",
	Five				= "5 person rotation ",
	IgnoreFirstKick		= "With this option, very first interrupt is excluded in rotation (Requires raid leader)"
})

--[[
L:SetMiscLocalization({
	YellPullCoven = "I can't wait to hear your flesh sizzle."
})]]

---------------------------
-- Aggramar --
---------------------------
L= DBM:GetModLocalization(1984)

L:SetWarningLocalization({
--	FlameRend1 = "Damage is shared by the 1st group",
--	FlameRend2 = "Damage is shared by the 2nd group",
	FlameRend3 = "Another group's turn"
})

L:SetOptionLocalization({
	FlameRend1 = "Show special warning during $spell:245463 for the first group (only in mythic)",
	FlameRend2 = "Show special warning during $spell:245463 for the second group (only in mythic)",
	FlameRend3 = "Show special warning during $spell:245463 when it's not your turn (only in mythic)",
	ignoreThreeTank	= "Filter Rend/Foe Taunt special warnings when using 3 or more tanks (since DBM can't determine exact tanking rotation in this setup). If any tanks die and it drops to 2, filter auto disables"
})

L:SetMiscLocalization({
--	YellPullAggramar = "You will burn!",
	Foe			= "Foe",
	Rend		= "Rend",
	Tempest 	= "Tempest",
	Current		= "Current:"
})

---------------------------
-- Argus the Unmaker --
---------------------------
L= DBM:GetModLocalization(2031)

L:SetTimerLocalization({
	timerSargSentenceCD	= "Sentence CD (%s)"
})

L:SetOptionLocalization({
	timerSargSentenceCD = DBM_CORE_AUTO_TIMER_OPTIONS["cdcount"]:format(257966)
})

L:SetMiscLocalization({
--	YellPullArgus = "Death! Death and pain!",
	SeaText		= "{rt6} Haste/Vers on %s",
	SkyText		= "{rt5} Crit/Mast on %s",
	Blight		= "Blight on %s",
	Burst		= "Burst on me!",
	Sentence	= "Sentence on %s",
	Bomb		= "Bomb on me!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("AntorusTrash")

L:SetGeneralLocalization({
	name =	"Antorus Trash"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RPImonar = "Halt!"
})
