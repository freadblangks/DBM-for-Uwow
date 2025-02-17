if GetLocale() ~= "ruRU" then return end
local L

--Прошляпанное очко Мурчаля ✔

-----------------------
-- Башня магов: Танк -- (Дк, Монах, Медведь, Ппал, Пвар, Дх)
-----------------------
L= DBM:GetModLocalization("Kruul")

L:SetGeneralLocalization({
	name = "Возвращение верховного лорда"
})

----------------------
-- Башня магов: Хил -- (Хпал, Хприст, Монах, Дерево)
----------------------
L= DBM:GetModLocalization("ErdrisThorn")

L:SetGeneralLocalization({
	name = "Последнее восстание"
})

---------------------
-- Башня магов: ДД -- (БистМастер, Дестрик, ДЦ, Монах)
---------------------
L= DBM:GetModLocalization("FelTotem")

L:SetGeneralLocalization({
	name = "Падение Тотема Скверны"
})

---------------------
-- Башня магов: ДД -- (Элем, Ферал, Фаер, Фури, Головорез, Анхоли)
----------------------
L= DBM:GetModLocalization("ImpossibleFoe")

L:SetGeneralLocalization({
	name = "Невероятный противник"
})

L:SetMiscLocalization({
	impServants = "Перебейте бесов-прислужников, пока они не усилили Агату своей энергией!"
})

---------------------
-- Башня магов: ДД -- (Аркан, Ликвидация, Демон, Энх, Рпал)
---------------------
L= DBM:GetModLocalization("Queen")

L:SetGeneralLocalization({
	name = "Ярость королевы-богини"
})

L:SetMiscLocalization({
	SigrynRP1 = "Что же я делаю? Это неправильно!"
})

---------------------
-- Башня магов: ДД -- (Афлик, Сова, Фрост, Стрельба хант, ШП)
---------------------
L= DBM:GetModLocalization("Twins")

L:SetGeneralLocalization({
	name = "Разделить близнецов"
})

L:SetMiscLocalization({
	TwinsRP1 = "Ты бесполезен, брат! Постой в стороне – а я все сделаю сам!", --Фаза 2
	TwinsRP2 = "Опять мне приходится все делать за тебя, брат!" --Фаза 3
})

---------------------
-- Башня магов: ДД -- (Армс, ФростДк, Дх, Скрытность, Сурв)
---------------------
L= DBM:GetModLocalization("Xylem")

L:SetGeneralLocalization({
	name = "Око Бури"
})

--------------------------
-- Башня магов: Таймеры -- (Прошляпанное очко Мурчаля ✔)
--------------------------
L= DBM:GetModLocalization("Timers")

L:SetGeneralLocalization({
	name = "Таймеры начала боя"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	Kruul = "Дерзкие глупцы! Меня питают души тысяч покоренных миров!", --Верховный лорд Круул https://ru.wowhead.com/npc=117198/верховный-лорд-круул
	Twins1 = "Я не позволю тебе обрушить эту силу на Азерот, Рейст. Остановись, или мне придется убить тебя!", --Карам Волшебное Копье https://ru.wowhead.com/npc=116410/карам-волшебное-копье
	ErdrisThorn1 = "Нет уж! Пора положить конец атакам на мой город!", --Калли Керрингтон
	Agatha1 = "Мои сайаады уже искушают слабовольных магов! Они сами сдадутся Легиону!", --Агата https://ru.wowhead.com/npc=115638/агата
	Sigryn1 = "Один, ты не сможешь вечно прятаться за этими стенами!" --https://ru.wowhead.com/npc=116484/сигрин
})
