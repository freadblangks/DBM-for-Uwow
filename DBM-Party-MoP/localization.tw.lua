﻿if GetLocale() ~= "zhTW" then return end

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
	SpecWarnIntensity	= "%s在%s有(%d)層"
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
	SpecWarnFizzyBubbles	= "點擊多彩泡泡然後飛起來!"
})

L:SetOptionLocalization({
	SpecWarnFizzyBubbles	= "當你缺少$spell:114459時顯示特別警告"
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
	warnRemainingNovice	= "學徒剩餘:%d"
})

L:SetOptionLocalization({
	warnRemainingNovice	= "提示剩餘多少學徒"
})

L:SetMiscLocalization({
	NovicesPulled	= "你!在煞沉眠了這麼多年之後，你竟然讓它甦醒了!",
	NovicesDefeated = "你打贏了我資歷最淺的徒弟。現在你要面對我最資深的兩個徒弟。"
})

-----------------------
-- Sha of Violence --
-----------------------
L= DBM:GetModLocalization(685)

L:SetMiscLocalization({
	Kill			= "只要你們心中還存有暴力，我就..會回來..."
})

-----------------------
-- Taran Zhu --
-----------------------
L= DBM:GetModLocalization(686)

L:SetOptionLocalization({
	InfoFrame			= "為$journal:5827顯示訊息框"
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
	StaffingRun		= "打擊者卡多克準備開始低空掃射!"
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
	Pull		= "你們這些沒用的東西!就連你們獻上的守衛，都擋不住這些低等的生物。",
	Kuai		= "葛薩恩部族會讓你們這些想要權力的傢伙知道為什麼我們才是王身邊真正的勇士!",
	Ming		= "哈薩科會讓所有人看看為什麼我們才是真正的魔古!",
	Haiyan		= "卡傑許部族會展示出強者才有資格替王效勞的原因!",
	Defeat		= "是誰讓外來者進入我們的殿堂?只有哈薩科或卡傑許部族會做出這種背叛的行為!"
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
	TimerWave	= "進攻:%s"
})

L:SetOptionLocalization({
	TimerWave	= "為下一波攻擊顯示計時器"
})

L:SetMiscLocalization({
	WaveStart	= "蠢蛋!敢跟螳螂人的力量正面衝突?你的死期就要到了!"
})

-----------------------
-- Pavalak --
-----------------------
L= DBM:GetModLocalization(692)

-----------------------
-- Neronok --
-----------------------
L= DBM:GetModLocalization(727)
