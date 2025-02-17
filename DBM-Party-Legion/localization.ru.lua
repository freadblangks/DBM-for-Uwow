if GetLocale() ~= "ruRU" then return end

local L

-------------------------------
--<<<Крепость Черной Ладьи>>>--
-------------------------------

---------------
--Слияние душ--
---------------
L= DBM:GetModLocalization(1518)

----------------------------
--Иллисанна Гребень Ворона--
----------------------------
L= DBM:GetModLocalization(1653)

-------------------
--Хмуродроб Лютый--
-------------------
L= DBM:GetModLocalization(1664)

---------------------------------
--Лорд Кур'талос Гребень Ворона--
---------------------------------
L= DBM:GetModLocalization(1672)

L:SetMiscLocalization({
	proshlyapMurchal = "Все, мне это надоело!"
})

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("BRHTrash")

L:SetGeneralLocalization({
	name = "Трэш КЧЛ"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_DOOR_OPENING
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	RP1 = "Я... я все понял..."
})

----------
--Мифик+--
----------
L = DBM:GetModLocalization("MAffix")

L:SetGeneralLocalization({
	name = "Мифик+ ключи"
})

-----------------------------
--<<<Чаща Темного Сердца>>>--
-----------------------------

-----------------------------
--Верховный друид Глайдалис--
-----------------------------
L= DBM:GetModLocalization(1654)

------------
--Дубосерд--
------------
L= DBM:GetModLocalization(1655)

L:SetMiscLocalization({
	ThrowYell = "Бросок на %s"
})

------------
--Дресарон--
------------
L= DBM:GetModLocalization(1656)

---------------
--Тень Ксавия--
---------------
L= DBM:GetModLocalization(1657)

L:SetMiscLocalization{
	ParanoiaYell = "%s на %s. УЁБЫВАЙТЕ от меня!" --Бегите
}

L:SetMiscLocalization({
	XavApoc = "Вас ждет медленная и мучительная смерть!",
	XavApoc2 = "Я сокрушу ваши слабые разумы!"
})

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("DHTTrash")

L:SetGeneralLocalization({
	name = "Трэш ЧТС"
})

--------------------
--<<<Око Азшары>>>--
--------------------

---------------------
--Полководец Паржеш--
---------------------
L= DBM:GetModLocalization(1480)

-------------------------
--Леди Кольцо Ненависти--
-------------------------
L= DBM:GetModLocalization(1490)

---------------------
--Король Волнобород--
---------------------
L= DBM:GetModLocalization(1491)

----------
--Змеикс--
----------
L= DBM:GetModLocalization(1479)

---------------
--Гнев Азшары--
---------------
L= DBM:GetModLocalization(1492)

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("EoATrash")

L:SetGeneralLocalization({
	name = "Трэш Ока Азшары"
})

--------------------------
--<<<Чертоги Доблести>>>--
--------------------------

------------
--Химдалль--
------------
L= DBM:GetModLocalization(1485)

L:SetMiscLocalization({
	proshlyapMurchal = "Славная битва! Теперь ваш путь свободен."
})

---------
--Хирья--
---------
L= DBM:GetModLocalization(1486)

----------
--Фенрир--
----------
L= DBM:GetModLocalization(1487)

L:SetMiscLocalization({
	MurchalProshlyapOchko = "Раненый Фенрир отступает в свое логово."
})

-----------------------
--Король-бог Сковальд--
-----------------------
L= DBM:GetModLocalization(1488)

--------
--Один--
--------
L= DBM:GetModLocalization(1489)

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("HoVTrash")

L:SetGeneralLocalization({
	name = "Трэш Чертогов Доблести"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT, --"Interface\\Icons\\ability_warrior_offensivestance"
	BossActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RPSolsten = "Смертные, вы оскверняете ритуал!",
	RPSolsten2 = "Хирья... Теперь ты можешь повелевать яростью бури!",
	RPOlmyr = "Вы не помешаете перерождению Хирьи!",
	RPOlmyr2 = "Да озарит тебя вечный Свет, Хирья!",
	RPSkovald = "Нет! Я, Король-бог Сковальд, тоже доказал, что достоин. Эти смертные не посмеют оспорить мое право владеть Эгидой!",
	RPOdyn = "Удивительно! Я не верил, что кто-то может сравниться с валарьярами... Но вы доказали, что это возможно."
})

---------------------------
--<<<Логово Нелтариона>>>--
---------------------------

-----------
--Рокмора--
-----------
L= DBM:GetModLocalization(1662)

--------------------
--Уларогг Скаломол--
--------------------
L= DBM:GetModLocalization(1665)

------------
--Нараксас--
------------
L= DBM:GetModLocalization(1673)

-----------------------------
--Король подземелий Даргрул--
-----------------------------
L= DBM:GetModLocalization(1687)

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("NLTrash")

L:SetGeneralLocalization({
	name = "Трэш Логова Нелтариона"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT --"Interface\\Icons\\ability_warrior_offensivestance"
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RoleP1 = "Наваррогг?! Предатель, ты привел к нам чужаков?!"
})

----------------------------
--<<<Катакомбы Сурамара>>>--
----------------------------

----------
--Иванир--
----------
L= DBM:GetModLocalization(1497)

--------------
--Корстилакс--
--------------
L= DBM:GetModLocalization(1498)

------------------
--Генерал Ксакал--
------------------
L= DBM:GetModLocalization(1499)

------------
--Нал'тира--
------------
L= DBM:GetModLocalization(1500)

--------------------
--Советник Вандрос--
--------------------
L= DBM:GetModLocalization(1501)

L:SetMiscLocalization({
	RPVandros = "Довольно! Вы что-то совсем распоясались!"
})

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("ArcwayTrash")

L:SetGeneralLocalization({
	name = "Трэш Катакомб Сурамара"
})

-----------------------
--<<<Квартал Звезд>>>--
-----------------------

-------------------------
--Капитан патруля Гердо--
-------------------------
L= DBM:GetModLocalization(1718)

-----------------------
--Таликса Пламя Гнева--
-----------------------
L= DBM:GetModLocalization(1719)

--------------------
--Советник Меландр--
--------------------
L= DBM:GetModLocalization(1720)

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("CoSTrash")

L:SetGeneralLocalization({
	name = "Трэш Квартала Звезд"
})

L:SetWarningLocalization({
	warnSpy = "Шпион обнаружен"
})

L:SetOptionLocalization({
	YellOnEating = "Сообщать, когда кто-то применяеет заклинание $spell:208585",
	YellOnSiphoningMagic = "Сообщать, когда кто-то применяеет заклинание $spell:208427",
	YellOnPurifying = "Сообщать, когда кто-то применяеет заклинание $spell:209767",
	YellOnDraining = "Сообщать, когда кто-то применяеет заклинание $spell:208334",
	YellOnInvokingText = "Сообщать, когда кто-то применяеет заклинание $spell:210872",
	YellOnDrinking = "Сообщать, когда кто-то применяеет заклинание $spell:210307",
	YellOnReleaseSpores = "Сообщать, когда кто-то применяеет заклинание $spell:208939",
	YellOnShuttingDown = "Сообщать, когда кто-то применяеет заклинание $spell:208370",
	YellOnTreating = "Сообщать, когда кто-то применяеет заклинание $spell:210925",
	YellOnPilfering = "Сообщать, когда кто-то применяеет заклинание $spell:210217",
	YellOnDefacing = "Сообщать, когда кто-то применяеет заклинание $spell:210330",
	YellOnTinkering = "Сообщать, когда кто-то применяеет заклинание $spell:210922",
	warnSpy = "Спец-предупреждение когда шпион обнаружен",
	SpyHelper = "Помочь идентифицировать шпиона",
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	EatingYell = "[DBM RV] %s использует %s, теперь у нас больше хп!",
	SiphoningMagic = "[DBM RV] %s использует %s, теперь у нас больше урона!",
	PurifyingYell = "[DBM RV] %s использует %s, теперь у нас больше защиты!",
	DrainingYell = "[DBM RV] %s использует %s, теперь у нас больше крита!",
	InvokingTextYell = "[DBM RV] %s использует %s, теперь у нас больше скорости бега!",
	DrinkingYell = "[DBM RV] %s использует %s, теперь у нас больше регена хп и маны!",
	ReleaseSporesYell = "[DBM RV] %s использует %s, теперь у нас больше скорости боя!",
	ShuttingDownYell = "[DBM RV] %s использует %s, теперь все Големы-стражи будут выключены!",
	TreatingYell = "[DBM RV] %s использует %s и отвлекает мини-босса!",
	PilferingYell = "[DBM RV] %s использует %s и отвлекает мини-босса!",
	DefacingYell = "[DBM RV] %s использует %s и отвлекает мини-босса!",
	TinkeringYell = "[DBM RV] %s использует %s и отвлекает мини-босса!",
	--
	proshlyapMurchal = "Великий магистр, не слишком ли рано?",
	Gloves1			= "Ходят слухи, что шпион все время носит перчатки.",
	Gloves2			= "Я слышал, шпион все время носит перчатки.",
	Gloves3			= "Кто-то сказал, что у шпиона все руки в шрамах, поэтому бедняге приходится носить перчатки, чтобы скрывать их.",
	Gloves4			= "Я слышал, что шпион старается никому не показывать свои руки.",
	NoGloves1		= "Я слышал, шпион обычно не носит перчаток, чтобы они не сковывали движений при опасности.",
	NoGloves2		= "Я слышал, шпион не любит надевать перчатки.",
	NoGloves3		= "Слушай... Я нашел в задней комнате пару бесхозных перчаток. Вероятно, шпион окажется без перчаток.",
	NoGloves4		= "Говорят, что шпион никогда не носит перчаток.",
	Cape1			= "Говорят, шпион очень любит носить накидки.",
	Cape2			= "Кто-то говорил, что у шпиона была на плечах накидка.",
	NoCape1			= "Говорят, что накидка шпиона осталась лежать во дворце.",
	NoCape2			= "Говорят, шпион терпеть не может носить накидки.",
	LightVest1		= "Говорят, на сегодняшней вечеринке шпион носит светлый жилет.",
	LightVest2		= "Шпион определенно предпочитает жилеты светлых тонов.",
	LightVest3		= "Говорят, что этим вечером шпион не носит темный жилет.",
	DarkVest1		= "Шпион определенно предпочитает одеваться в темное.",
	DarkVest2		= "По слухам, шпион избегает светлых тонов в одежде, чтобы проще было сливаться с толпой.",
	DarkVest3		= "Говорят, шпион носит жилет цвета глубокой ночи.",
	DarkVest4		= "Шпион очень любит темные жилеты... цвета ночи.",
	Female1			= "Я слышал, что какая-то женщина всех расспрашивала о нашем квартале...",
	Female2			= "Кто-то, кажется, говорил, что наш новый гость – дама.",
	Female3			= "Говорят, что шпионка уже здесь и выглядит она просто сногсшибательно.",
	Female4			= "Кто-то из гостей видел ее вместе с Элисандой чуть ли не под ручку.",
	Male1			= "Кто-то из музыкантов общался со шпионом. И он буквально засыпал бедолагу вопросами про здешний квартал.",
	Male2			= "Я слышал, что шпион уже здесь и он очень хорош собой.",
	Male3			= "Одна гостья утверждает, что видела, как он входил в особняк вместе с Великим магистром.",
	Male4			= "Я где-то слышал, что шпион не женщина.",
	ShortSleeve1	= "Говорят, шпион любит прохладу и поэтому на сегодняшней вечеринке не носит одежду с длинными рукавами.",
	ShortSleeve2	= "Моя подруга как-то обмолвилась, что видела одежду, которую носит шпион. Вроде что-то с короткими рукавами...",
	ShortSleeve3	= "Мне кто-то говорил, будто шпион терпеть не может одежду с длинными рукавами.",
	ShortSleeve4	= "Я слышал, шпион носит одежду с короткими рукавами, которая не стесняет движений.",
	LongSleeve1 	= "Говорят, этим вечером на шпионе одежда с длинными рукавами.",
	LongSleeve2 	= "Один мой друг говорил, что шпион носит одежду с длинными рукавами.",
	LongSleeve3 	= "Кто-то сказал, что на сегодня шпион носит одежду с длинными рукавами.",
	LongSleeve4 	= "Немногим раньше я видел кое-кого в одежде с длинными рукавами. Наверное, это и был шпион.",
	Potions1		= "Я тебе ничего такого не говорила... но шпион присутствует на вечеринке в костюме алхимика. Ищи кого-то с зельями на поясе.",
	Potions2		= "Я почти уверена, что у шпиона на поясе должны быть флаконы с зельями.",
	Potions3		= "Говорят, у шпиона при себе есть несколько зелий... на всякий случай.",
	Potions4		= "Говорят, у шпиона при себе есть зелья... интересно, для чего?",
	NoPotions1		= "Музыкантша рассказала мне, что своими глазами видела, как шпион выбрасывает последнее зелье.",
	NoPotions2		= "Говорят, что у шпиона нет при себе никаких зелий.",
	Book1			= "Ходят слухи, что шпион очень любит читать и носит с собой по меньшей мере одну книгу.",
	Book2			= "Я слышал, что у шпиона на поясе болтается книжица, в которой записаны шпионские наблюдения.",
	Pouch1			= "Я слышал, шпион всегда носит на поясе волшебный кошель.",
	Pouch2			= "Я слышал, поясной кошель шпиона украшен причудливой вышивкой.",
	Pouch3			= "Мой друг говорил, что шпион просто обожает золото, и поэтому шпионский поясной кошель туго набит золотыми монетами.",
	Pouch4			= "Я слышал, поясной кошель шпиона расшит золотом, чтобы подчеркнуть утонченность.",
	Found			= "зачем же так спешить",
	--
	Gloves		= "Носит перчатки/Wears gloves",
	NoGloves	= "Без перчаток/No gloves",
	Cape		= "Носит плащ/Wearing a cape",
	Nocape		= "Без плаща/No cape",
	LightVest	= "Светлый жилет/Light vest",
	DarkVest	= "Темный жилет/Dark vest",
	Female		= "Женщина/Female",
	Male		= "Мужчина/Male",
	ShortSleeve = "Короткие рукава/Short sleeves",
	LongSleeve	= "Длинные рукава/Long sleeves",
	Potions		= "Зелья/Potions",
	NoPotions	= "Нет зелий/No potions",
	Book		= "Книга/Book",
	Pouch		= "Кошель/Pouch"
})

--------------------
--<<<Утроба душ>>>--
--------------------

-------------------------
--Имирон, падший король--
-------------------------
L= DBM:GetModLocalization(1502)

------------
--Харбарон--
------------
L= DBM:GetModLocalization(1512)

---------
--Хелия--
---------
L= DBM:GetModLocalization(1663)

L:SetMiscLocalization({
	TaintofSeaYell = "%s спадает с %s. Берегись!"
})

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("MawTrash")

L:SetGeneralLocalization({
	name = "Трэш Утробы Душ"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Helya = "Вы пожалеете о том, что пришли в мой мир."
})

------------------------------------
--<<<Штурм Аметистовой крепости>>>--
------------------------------------

---------------------------
--Пожиратель разума Каарж--
---------------------------
L= DBM:GetModLocalization(1686)

-------------------------
--Миллифисент Манашторм--
-------------------------
L= DBM:GetModLocalization(1688)

-------------
--Тухломорд--
-------------
L= DBM:GetModLocalization(1693)

-------------
--Ледопасть--
-------------
L= DBM:GetModLocalization(1694)

------------------------------
--Кровавая принцесса Тал'ена--
------------------------------
L= DBM:GetModLocalization(1702)

--------------
--Ануб'ессет--
--------------
L= DBM:GetModLocalization(1696)

------------
--Саел'орн--
------------
L= DBM:GetModLocalization(1697)

-----------------------------
--Повелитель Скверны Бетруг--
-----------------------------
L= DBM:GetModLocalization(1711)

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("AVHTrash")

L:SetGeneralLocalization({
	name = "Трэш ШАК"
})

L:SetWarningLocalization({
	WarningPortalSoon	= "Скоро новый портал",
	WarningPortalNow	= "Портал #%d",
	WarningBossNow		= "Прибытие босса"
})

L:SetTimerLocalization({
	TimerPortal			= "Восст. Портал"
})

L:SetOptionLocalization({
	WarningPortalNow		= "Предупреждение о новом портале",
	WarningPortalSoon		= "Предупреждать заранее о новом портале",
	WarningBossNow			= "Предупреждать о прибытии босса",
	TimerPortal				= "Отсчет вермени до след. портала (после босса)"
})

L:SetMiscLocalization({
	Malgath		= "Лорд  Малгат"
})

--------------------------
--<<<Казематы Стражей>>>--
--------------------------

--------------------
--Тиратон Салтерил--
--------------------
L= DBM:GetModLocalization(1467)

------------------------
--Инквизитор Истязарий--
------------------------
L= DBM:GetModLocalization(1695)

L:SetOptionLocalization({
	lookSphere = "Спец-предупреждение \"гляди на Сферу\" когда вы цель $spell:212564"
})

L:SetMiscLocalization({
	lookSphere = "Сферу"
})

-----------
--Вул'кан--
-----------
L= DBM:GetModLocalization(1468)

L:SetMiscLocalization({
	MurchalProshlyapOchko = "Система безопасности комнаты теперь вооружена."
})

-------------
--Смотрящий--
-------------
L= DBM:GetModLocalization(1469)

------------------------------
--Кордана Оскверненная Песнь--
------------------------------
L= DBM:GetModLocalization(1470)

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("VoWTrash")

L:SetGeneralLocalization({
	name = "Трэш Каземат Стражей"
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetMiscLocalization({
	proshlyapMurchalRP = "Как предсказуемо! Я знала, что вы придете." --Прошляпанное очко Мурчаля Прошляпенко
})

-------------------------------
--<<<Возвращение в Каражан>>>--
-------------------------------

----------------------
--Благочестивая дева--
----------------------
L= DBM:GetModLocalization(1825)

-------------------------
--Оперный зал: "Злюкер"--
-------------------------
L= DBM:GetModLocalization(1820)

------------------------------------------
--Оперный зал: "Однажды в Западном Крае"--
------------------------------------------
L= DBM:GetModLocalization(1826)

L:SetMiscLocalization({
	Tonny = "Ну что, покружимся?",
	Phase3 = "Да, детка, весь этот мир против нас!"
})

------------------------------------
--Оперный зал: "Красавица и Зверь"--
------------------------------------
L= DBM:GetModLocalization(1827)

------------------
--Ловчий Аттумен--
------------------
L= DBM:GetModLocalization(1835)

L:SetMiscLocalization({
	SharedSufferingYell = "%s на %s. УЁБЫВАЙТЕ от меня!",
	Perephase1 = "Что ж, сразимся лицом к лицу!",
	Perephase2 = "Вперед, Полночь, к победе!"
})

----------
--Мороуз--
----------
L= DBM:GetModLocalization(1837)

--------------
--Смотритель--
--------------
L= DBM:GetModLocalization(1836)

---------------
--Тень Медива--
---------------
L= DBM:GetModLocalization(1817)

-------------------
--Пожиратель маны--
-------------------
L= DBM:GetModLocalization(1818)

------------------------
--Виз'адуум Всевидящий--
------------------------
L= DBM:GetModLocalization(1838)

-------------------
--Ночная погибель--
-------------------
L = DBM:GetModLocalization("Nightbane")

L:SetGeneralLocalization({
	name = "Ночная погибель"
})

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("RTKTrash")

L:SetGeneralLocalization({
	name = "Трэш Возвращения в каражан"
})

L:SetOptionLocalization({
	timerRoleplay3 = "Отсчет времени до начала представления \"Злюкер\"",
	timerRoleplay2 = "Отсчет времени до начала представления \"Однажды в Западном крае\"",
	timerRoleplay = "Отсчет времени до начала представления \"Красавица и Зверь\"",
	timerRoleplay4 = DBM_CORE_OPTION_TIMER_DOOR_OPENING,
	OperaActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay3 = "\"Злюкер\"",
	timerRoleplay2 = "\"Однажды и Западном крае\"",
	timerRoleplay = "\"Красавица и Зверь\"",
	timerRoleplay4 = DBM_CORE_GENERIC_TIMER_DOOR_OPENING
})

L:SetMiscLocalization({
	Beauty = "Добрый вечер, дамы и господа, и добро пожаловать на наше сегодняшнее представление!",
	Westfall = "Дамы и господа, добро пожаловать на вечернее представление!",
	Wikket = "Дамы и господа, добро пожаловать... ОХ!",
	Medivh1 = "Я разбросал по башне столько фрагментов своей души...",
	speedRun = "Странный холод возвещает о темном присутствии..."
})

---------------------------
--<<<Собор Вечной Ночи>>>--
---------------------------

------------
--Агронокс--
------------
L= DBM:GetModLocalization(1905)

-----------------------
--Долбогрыз Глумливый--
-----------------------
L= DBM:GetModLocalization(1906)

-------------
--Доматракс--
-------------
L= DBM:GetModLocalization(1904)

-------------
--Мефистрот--
-------------
L= DBM:GetModLocalization(1878)

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("CoENTrash")

L:SetGeneralLocalization({
	name = "Трэш Собора Вечной Ночи"
})

-----------------------------
--<<<Престол Триумвирата>>>--
-----------------------------

------------------------
--Зураал Перерожденный--
------------------------
L= DBM:GetModLocalization(1979)

L:SetWarningLocalization({
	UmbraShift = "Теневой рывок на вас - уничтожайте врагов"
})

L:SetOptionLocalization({
	UmbraShift = "Спец-предупреждение \"уничтожайте врагов\" когда вы цель $spell:244433"
})

----------
--Сарпиш--
----------
L= DBM:GetModLocalization(1980)

--------------------
--Наместник Незжар--
--------------------
L= DBM:GetModLocalization(1981)

---------
--Л'ура--
---------
L= DBM:GetModLocalization(1982)

-------------
--Трэш-мобы--
-------------
L = DBM:GetModLocalization("SoTTrash")

L:SetGeneralLocalization({
	name = "Трэш Престола Триумвирата"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_DOOR_OPENING,
	timerRoleplay2 = DBM_CORE_OPTION_TIMER_COMBAT,
	AlleriaActivation = DBM_CORE_GENERIC_TIMER_ROLE_PLAY
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_DOOR_OPENING,
	timerRoleplay2 = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RP1 = "Темная Стража укрепляет позиции вокруг храма.",
	RP2 = "Из храма исходит великое отчаяние. Л'ура...",
	RP3 = "Такой хаос... такая боль. Я еще не чувствовала ничего подобного."
})
