﻿if GetLocale() ~= "deDE" then return end

local L

-----------------------
-- <<<Temple of the Jade Serpent>>> --
-----------------------
-----------------------
-- Wise Mari --
-----------------------
L= DBM:GetModLocalization(672)

-----------------------
-- Lorewalker Stonestep --
-----------------------
L= DBM:GetModLocalization(664)

L:SetWarningLocalization({
	SpecWarnIntensity	= "%s auf %s (%d)"
})

L:SetMiscLocalization({
	Event1	= "Ah, es ist noch nicht vorbei. Wenn ich das richtig sehe, stehen wir der Probe des Yaungol gegenüber. Lasst mich erklären..."
})

-----------------------
-- Liu Flameheart --
-----------------------
L= DBM:GetModLocalization(658)

-----------------------
-- Sha of Doubt --
-----------------------
L= DBM:GetModLocalization(335)

-----------------------
-- <<<Stormstout Brewery>>> --
-----------------------
-----------------------
-- Ook-Ook --
-----------------------
L= DBM:GetModLocalization(668)

-----------------------
-- Hoptallus --
-----------------------
L= DBM:GetModLocalization(669)

-----------------------
-- Yan Zhu the Uncasked --
-----------------------
L= DBM:GetModLocalization(670)

L:SetWarningLocalization({
	SpecWarnFizzyBubbles	= "Hole Blubberblase und fliege"
})

L:SetOptionLocalization({
	SpecWarnFizzyBubbles	= "Spezialwarnung, falls dir der $spell:114459 Buff fehlt"
})

-----------------------
-- <<<Shado-Pan Monastery>>> --
-----------------------
-----------------------
-- Gu Cloudstrike --
-----------------------
L= DBM:GetModLocalization(673)

L:SetWarningLocalization({
	warnStaticField	= "%s"
})


-----------------------
-- Snowdrift --
-----------------------
L= DBM:GetModLocalization(657)

L:SetWarningLocalization({
	warnRemainingNovice	= "Novizen verbleibend: %d"
})

L:SetOptionLocalization({
	warnRemainingNovice	= "Verkünde die Anzahl der verbleibenden Novizen"
})

L:SetMiscLocalization({
	NovicesPulled	= "Ihr! Ihr habt zugelassen, dass das Sha nach all diesen Jahren wieder erwacht ist!",
	NovicesDefeated = "Ihr habt unsere unerfahrensten Schüler bezwungen. Jetzt müsst Ihr Euch gegen zwei der besten behaupten.",
--	Defeat			= "I am bested.  Give me a moment and we will venture forth together to face the Sha." --translate (trigger)
})

-----------------------
-- Sha of Violence --
-----------------------
L= DBM:GetModLocalization(685)

L:SetMiscLocalization({
	Kill		= "So lange die Gewalt in Euren Herzen wohnt... werde ich... zurückkehren..."
})

-----------------------
-- Taran Zhu --
-----------------------
L= DBM:GetModLocalization(686)

L:SetOptionLocalization({
	InfoFrame			= "Zeige Infofenster für $journal:5827"
})

-----------------------
-- <<<The Gate of the Setting Sun>>> --
-----------------------

---------------------
-- Kiptilak --
---------------------
L= DBM:GetModLocalization(655)

-------------
-- Gadok --
-------------
L= DBM:GetModLocalization(675)

L:SetMiscLocalization({
	StaffingRun		= "Bomber Ga'dok bereitet einen Bombenlauf vor!"
})

-----------------------
-- Rimok --
-----------------------
L= DBM:GetModLocalization(676)

-----------------------------
-- Raigonn --
-----------------------------
L= DBM:GetModLocalization(649)

-----------------------
-- <<<Mogu'Shan Palace>>> --
-----------------------
-----------------------
-- Trial of Kings --
-----------------------
L= DBM:GetModLocalization(708)

L:SetMiscLocalization({
	Pull		= "Ihr seid alle nutzlos! Die Wachen, die Ihr mir als Tribut überlasst, können nicht einmal diese minderwertigen Wesen von meinem Palast fernhalten.",
	Kuai		= "Klan Gurthan wird unserem König und dem Rest von Euch machthungrigen Schwindlern zeigen, warum wir zu Recht an seiner Seite stehen!",
	Ming		= "Klan Harthak wird allen zeigen, warum sie die wahren Mogu sind!",
	Haiyan		= "Klan Kargesh wird Euch zeigen, warum nur die Starken es verdient haben, an der Seite des Königs zu stehen!",
	Defeat		= "Wer hat diese Eindringlinge in unsere Hallen gelassen? Nur Klan Harthak oder Klan Kargesh würden einen derartigen Verrat begehen!"
})

-----------------------
-- Gekkan --
-----------------------
L= DBM:GetModLocalization(690)

-----------------------
-- Weaponmaster Xin --
-----------------------
L= DBM:GetModLocalization(698)

-----------------------
-- <<<Siege of Niuzao Temple>>> --
-----------------------
-----------------------
-- Jinbak --
-----------------------
L= DBM:GetModLocalization(693)

-----------------------
-- Vo'jak --
-----------------------
L= DBM:GetModLocalization(738)

L:SetTimerLocalization({
	TimerWave	= "Sendet: %s"
})

L:SetOptionLocalization({
	TimerWave	= "Zeige Zeit bis nächsten Angriffsbefehl"
})

L:SetMiscLocalization({
	WaveStart	= "Narren! Ein Frontalangriff auf die Macht der Mantis? Ich werde Euch einen schnellen Tod bereiten!"
})

-----------------------
-- Pavalak --
-----------------------
L= DBM:GetModLocalization(692)

-----------------------
-- Neronok --
-----------------------
L= DBM:GetModLocalization(727)
