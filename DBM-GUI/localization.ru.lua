if GetLocale() ~= "ruRU" then return end

if not DBM_GUI_Translations then DBM_GUI_Translations = {} end
local L = DBM_GUI_Translations

L.MainFrame = "Dungeon Boss Master"

L.TranslationByPrefix		= "Адаптация под uwow.biz - "
L.TranslationBy 			= "Aleksart163 (Tielle х100)"
L.Website					= "Дискорд для связи по вопросам: Aleksart163#1671 и сайт для обновления: |cFF73C2FBhttps://github.com/Aleksart163/DBM-for-Uwow|r"
L.WebsiteButton				= "Обновление"

L.OTabBosses				= "Боссы"
L.OTabOptions				= "Настройки"

L.TabCategory_Options	 	= "Общие параметры"
L.TabCategory_BFA	 		= "Battle for Azeroth"
L.TabCategory_LEG	 		= "Legion"
L.TabCategory_WOD	 		= "Warlords of Draenor"
L.TabCategory_MOP	 		= "Mists of Pandaria"
L.TabCategory_CATA	 		= "Cataclysm"
L.TabCategory_WOTLK 		= "Wrath of the Lich King"
L.TabCategory_BC 			= "The Burning Crusade"
L.TabCategory_CLASSIC		= "Classic"
L.TabCategory_PVP 			= "PvP"
L.TabCategory_OTHER 		= "Другое"

L.BossModLoaded 			= "%s - статистика"
L.BossModLoad_now 			= [[Модуль для этих боссов не загружен. 
Он будет загружен сразу после входа в подземелье. 
Также вы можете нажать кнопку, чтобы загрузить модуль вручную.]]

L.PosX						= 'Позиция X'
L.PosY						= 'Позиция Y'

L.MoveMe 					= 'Передвинь меня'
L.Button_OK 				= 'OK'
L.Button_Cancel 			= 'Отмена'
L.Button_LoadMod			= 'Загрузить модуль'
L.Mod_Enabled				= "Включить модуль"
L.Mod_Reset					= "Сброс настроек"
L.Reset 					= "Сброс"

L.Enable  					= "Вкл."
L.Disable					= "Откл."

L.NoSound					= "Без звука"

L.IconsInUse				= "Используемые метки"

-- Tab: Boss Statistics
L.BossStatistics			= "Статистика босса"
L.Statistic_Kills			= "Убийства:"
L.Statistic_Wipes			= "Поражения:"
L.Statistic_Incompletes		= "Не завершено:"
L.Statistic_BestKill		= "Лучший бой:"
L.Statistic_BestRank		= "Лучший рейтинг:"--Maybe not get used, not sure yet, localize anyways

-- Tab: General Core Options
L.General 					= "Общие параметры DBM"
L.EnableMiniMapIcon			= "Отображать кнопку на мини-карте"
L.UseSoundChannel			= "Выбор аудио канала для предупреждений DBM"
L.UseMasterChannel			= "Основной аудио канал"
L.UseDialogChannel			= "Аудио канал диалогов"
L.UseSFXChannel				= "Аудио канал эффектов"
L.Latency_Text				= "Макс. задержка для синхронизации: %d"

L.ModelOptions				= "Настройки 3D моделей на странице боссов"
L.EnableModels				= "Показывать 3D модели боссов"
L.ModelSoundOptions			= "Выбор голосового приветствия"
L.ModelSoundShort			= "Короткое"
L.ModelSoundLong			= "Длинное"

L.Button_RangeFrame			= "Окно проверки дистанции"
L.Button_InfoFrame			= "Окно информации"
L.Button_TestBars			= "Проверка индикаторов"
L.Button_ResetInfoRange		= "Сбросить информ./дист. окна"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Предупреждения для рейда"
L.RaidWarning_Header		= "Параметры рейд-предупреждений"
L.RaidWarnColors 			= "Цвета предупреждений для рейда"
L.RaidWarnColor_1 			= "Цвет 1"
L.RaidWarnColor_2 			= "Цвет 2"
L.RaidWarnColor_3		 	= "Цвет 3"
L.RaidWarnColor_4 			= "Цвет 4"
L.InfoRaidWarning			= [[Вы можете указать расположение и цвет предупреждений для рейда. 
Используется для сообщений вроде "Игрок X под воздействием Y"]]
L.ColorResetted 			= "Цветовые параметры для этого поля восстановлены."
L.ShowWarningsInChat 		= "Показывать предупреждения в окне чата"
L.WarningIconLeft 			= "Отображать значок с левой стороны"
L.WarningIconRight 			= "Отображать значок с правой стороны"
L.WarningIconChat 			= "Отображать значки в окне чата"
L.WarningAlphabetical		= "Сортировать имена по алфавиту"
L.Warn_FontType				= "Выбор шрифта"
L.Warn_FontStyle			= "Флаги шрифта"
L.Warn_FontShadow			= "Тень"
L.Warn_FontSize				= "Размер шрифта: %d"
L.Warn_Duration				= "Длительность предупреждения: %0.1f сек"
L.None						= "Нет"
L.Random					= "Случайно"
L.Outline					= "Контур"
L.ThickOutline				= "Толстый контур"
L.MonochromeOutline			= "Монохромный контур"
L.MonochromeThickOutline	= "Монохромный толстый контур"
L.RaidWarnSound				= "Звук рейд-предупреждения"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "Общие сообщения"
L.CoreMessages				= "Параметры общих сообщений"
L.ShowPizzaMessage 			= "Показывать сообщения транслируемых таймеров в окне чата"
L.ShowAllVersions	 		= "Показывать версии босс мода для всех членов группы в окне чата"
L.CombatMessages			= "Параметры сообщений в бою"
L.ShowEngageMessage 		= "Показывать сообщения о вступлении в бой в окне чата"
L.ShowDefeatMessage 		= "Показывать сообщения об убийстве босса в окне чата"
L.ShowGuildMessages 		= "Показывать сообщения о вступлении в бой/убийстве/вайпе гильдии в окне чата"
L.ShowGuildMessagesPlus		= "Также показывать сообщения начале/убийстве/вайпе для групп из гильдии в Мифик+ (требуется опция рейда)"
L.WhisperMessages			= "Параметры приватных сообщений"
L.AutoRespond 				= "Включить авто-ответ в бою"
L.EnableStatus 				= "Отвечать на запрос статуса боя шепотом"
L.WhisperStats 				= "Добавлять статистику убийств/вайпов в авто-ответ"
L.DisableStatusWhisper 		= "Отключить ответы на запрос статуса боя шепотом для всей группы (требуется лидер группы). Применяется только для обычных/гер./эпох. рейдов и испытаний/эпох. подземелий"
L.DisableGuildStatus 		= "Отключить отправку сообщений о прогрессе в гильдию для всей группы (требуется лидер группы)"

-- Tab: Barsetup
L.BarSetup   				= "Настройки индикатора"
L.BarTexture 				= "Текстура индикатора"
L.BarStyle					= "Стиль индикатора"
L.BarDBM					= "DBM"
L.BarSimple					= "Simple (без анимации)"
L.BarStartColor				= "Цвет в начале"
L.BarEndColor 				= "Цвет в конце"
L.Bar_Font					= "Шрифт для индикаторов"
L.Bar_FontSize				= "Размер шрифта: %d"
L.Bar_Height				= "Высота индикатора: %d"
L.Slider_BarOffSetX 		= "Сдвиг X: %d"
L.Slider_BarOffSetY 		= "Сдвиг Y: %d"
L.Slider_BarWidth 			= "Ширина: %d"
L.Slider_BarScale 			= "Масштаб: %0.2f"
--Types
L.BarStartColorAdd			= "Начальный цвет (Треш)"
L.BarEndColorAdd			= "Конечный цвет (Треш)"
L.BarStartColorAOE			= "Начальный цвет (АОЕ)"
L.BarEndColorAOE			= "Конечный цвет (АОЕ)"
L.BarStartColorDebuff		= "Начальный цвет (Цель)"
L.BarEndColorDebuff			= "Конечный цвет (Цель)"
L.BarStartColorInterrupt	= "Начальный цвет (Прерывание)"
L.BarEndColorInterrupt		= "Конечный цвет (Прерывание)"
L.BarStartColorRole			= "Начальный цвет (Роль)"
L.BarEndColorRole			= "Конечный цвет (Роль)"
L.BarStartColorPhase		= "Начальный цвет (Фаза)"
L.BarEndColorPhase			= "Конечный цвет (Фаза)"
L.BarStartColorUI			= "Начальный цвет (Важно)"
L.BarEndColorUI				= "Конечный цвет (Важно)"
--Type 7 options
L.Bar7Header				= "Параметры пользовательского индикатора"
L.Bar7ForceLarge			= "Всегда использовать большой индикатор"
L.Bar7CustomInline			= "Использовать пользовательскую '!' встроенную иконку"
L.Bar7Footer				= "(Манекен-бар не обновляется в реальном времени)"

--Dropdown Options
L.CBTGeneric				= "Общий"
L.CBTAdd					= "Треш"
L.CBTAOE					= "АОЕ"
L.CBTTargeted				= "Цель"
L.CBTInterrupt				= "Прерывание"
L.CBTRole					= "Роль"
L.CBTPhase					= "Фаза"
L.CBTImportant				= "Важно"
L.CVoiceOne					= "Count Voice 1"
L.CVoiceTwo					= "Count Voice 2"
L.CVoiceThree				= "Count Voice 3"

-- Tab: Timers
L.AreaTitle_BarColors		= "Цвета индикатора по типу таймера"
L.AreaTitle_BarSetup		= "Параметры основного индикатора"
L.AreaTitle_BarSetupSmall 	= "Параметры уменьшенного индикатора"
L.AreaTitle_BarSetupHuge	= "Параметры увеличенного индикатора"
L.EnableHugeBar 			= "Включить увеличенный индикатор (Полоса 2)"
L.BarIconLeft 				= "Значок слева"
L.BarIconRight 				= "Значок справа"
L.ExpandUpwards				= "Выровнять по верху"
L.FillUpBars				= "Наполняющая заливка"
L.ClickThrough				= "Отключить события мыши (щелчок сквозь)"
L.Bar_Decimal				= "Отображать десятые когда время меньше: %d"
L.Bar_DBMOnly				= "Настройки ниже работают только со стилем индикатора \"DBM\"."
L.Bar_EnlargeTime			= "Увеличивать, когда время меньше: %d"
L.Bar_EnlargePercent		= "Увеличивать, когда процент меньше: %0.1f%%"
L.BarSpark					= "Искрение индикатора"
L.BarFlash					= "Мигание когда индикатор скоро исчезнет"
L.BarSort					= "Сортировать по оставшемуся времени"
L.BarColorByType			= "Цвет по типу"
L.BarInlineIcons			= "Показывать встроенные иконки"
L.ShortTimerText			= "Использовать короткий текст таймера (когда это возможно)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Специальные предупреждения"
L.Area_SpecWarn				= "Настройка специальных предупреждений"
L.SpecWarn_ClassColor		= "Использовать цвета классов для спец-предупреждений"
L.ShowSWarningsInChat 		= "Показывать спец-предупреждения в окне чата"
L.SWarnNameInNote			= "Использовать SW5 настройки если пользовательская заметка содержит ваше имя"
L.SpecialWarningIcon		= "Показывать иконки на специальных предупреждениях"
L.SpecWarn_FlashFrame		= "Мигать экраном во время специальных предупреждений"
L.SpecWarn_FlashFrameRepeat	= "Повторять %d раз (если включено)"
L.SpecWarn_Font				= "Выбор шрифта для специальных предупреждений"
L.SpecWarn_FontSize			= "Размер шрифта: %d"
L.SpecWarn_FontColor		= "Цвет шрифта"
L.SpecWarn_FontType			= "Выбор шрифта"
L.SpecWarn_FlashRepeat		= "Повторять мигание"
L.SpecWarn_FlashColor		= "Цвет мигания"
L.SpecWarn_FlashDur			= "Длительности мигания: %0.1f"
L.SpecWarn_FlashAlpha		= "Прозрачность мигания: %0.1f"
L.SpecWarn_DemoButton		= "Показать пример"
L.SpecWarn_MoveMe			= "Расположение"
L.SpecWarn_ResetMe			= "Восстановить умолчания"
L.SpecialWarnSound			= "Звук спец-предупреждения для вас или для вашей роли"
L.SpecialWarnSound2			= "Звук спец-предупреждения для всех"
L.SpecialWarnSound3			= "Звук очень важного спец-предупреждения"
L.SpecialWarnSound4			= "Звук для спец-предупреждений \"убегайте\""
L.SpecialWarnSound5			= "Звук по умолчанию для спец-предупреждений с заметками, содержащими ваше имя"

-- Tab: Spoken Alerts Frame
L.Panel_SpokenAlerts		= "Голосовые предупреждения"
L.Area_VoiceSelection		= "Выбор голоса"
L.CountdownVoice			= "Основной голос для звуков отсчета"
L.CountdownVoice2			= "Вторичный голос для звуков отсчета"
L.CountdownVoice3			= "Третичный голос для звуков отсчета"
L.VoicePackChoice			= "Голосовой пакет для предупреждений"
L.Area_CountdownOptions		= "Настройки обратного отсчета"
L.Area_VoicePackOptions		= "Настройки голосового пакета (голосовые пакеты третих лиц)"
L.SpecWarn_NoSoundsWVoice	= "Не проигрывать звуки спец-предупреждений для предупреждений, которые имеют голосовую настройку"
L.SWFNever					= "Никогда"
L.SWFDefaultOnly			= "когда спец-предупреждения используют звуки по умолчанию"--too long, doesn't fit into frame
L.SWFAll					= "когда спец-предупреждения используют любые звуки"
L.SpecWarn_AlwaysVoice		= "Всегда воспроизводить все голосовые предупреждения (Переопределяет настройки для конкретных боссов. Полезно для рейд лидера.)"
--TODO, maybe add URLS right to GUI panel on where to acquire 3rd party voice packs?
L.Area_GetVEM				= "Получить голосовой пакет VEM"
L.VEMDownload				= "|cFF73C2FBhttps://wow.curseforge.com/projects/dbm-voicepack-vem|r"
L.Area_BrowseOtherVP		= "Просмотреть другие голосовые пакеты на curseforge"
L.BrowseOtherVPs			= "|cFF73C2FBhttps://wow.curseforge.com/search?search=dbm+voice|r"
L.Area_BrowseOtherCT		= "Просмотреть пакеты обратного отсчета на curseforge"
L.BrowseOtherCTs			= "|cFF73C2FBhttps://wow.curseforge.com/search?search=dbm+count+pack|r"

-- Tab: Event Sounds
L.Panel_EventSounds			= "Звуковые события"
L.Area_SoundSelection		= "Выбор звука (прокрутка меню выбора с помощью колеса мыши)"
L.EventVictorySound			= "Установить звук при победе в бою"
L.EventWipeSound			= "Установить звук при поражении в бою"
L.EventEngageSound			= "Установить звук при вступлении в бой"
L.EventDungeonMusic			= "Установить музыку в подземельях/рейдах"
L.EventEngageMusic			= "Установить музыку во время боя с боссом"
L.Area_EventSoundsExtras	= "Параметры звуковых событий"
L.EventMusicCombined		= "Разрешить все варианты выбора музыки для подземелий и боя (изменение этой настройки требует перезагрузки интерфейса, чтобы увидеть изменения)"
L.Area_EventSoundsFilters	= "Условия фильтрации звуковых событий"
L.EventFilterDungMythicMusic= "Не воспроизводить музыку в подземельях на сложности Мифик/Мифик+"
L.EventFilterMythicMusic	= "Не воспроизводить музыку во время боя с боссом на сложности Мифик/Мифик+"

-- Tab: Global Filter
L.Panel_SpamFilter			= "Общие и спам-фильтры"
L.Area_SpamFilter_Outgoing	= "Параметры общего фильтра"
L.SpamBlockNoShowAnnounce	= "Не объявлять или предупреждать звуком игрока"
L.SpamBlockNoShowTgtAnnounce= "Не показывать текст и не воспроизводить звук для общих объявлений цели (фильтр выше отменяет этот)"
L.SpamBlockNoSpecWarn		= "Не показывать спец-предупреждения и не проигрывать звуки для них"
L.SpamBlockNoSpecWarnText	= "Не показывать специальный текст предупреждения, но разрешить голосовые пакеты (фильтр выше отменяет этот)"
L.SpamBlockNoShowTimers		= "Не показывать таймеры (отсчет времени)"
L.SpamBlockNoShowUTimers	= "Не показывать таймеры, отправленные пользователями (пользов./пул/отдых)"
L.SpamBlockNoSetIcon		= "Не устанавливать метки на цели"
L.SpamBlockNoRangeFrame		= "Не отображать окно проверки дистанции"
L.SpamBlockNoInfoFrame		= "Не отображать информационное окно"
L.SpamBlockNoHudMap			= "Не отображать HudMap"
L.SpamBlockNoNameplate		= "Не показывать ауры на табличке с именами"
L.SpamBlockNoCountdowns		= "Не воспроизводить звуки обратного отсчета"
L.SpamBlockNoYells			= "Не отправлять крики в чат"
L.SpamBlockNoNoteSync		= "Не принимать заметки"
L.SpamBlockNoReminders		= "Не показывать никаких сообщений при входе, рекомендациях или обновлениях (НЕ рекомендуется)"

L.Area_Restore				= "Параметры DBM для возврата настроек (восстанавливать ли предыдущее пользов. состояние по окончание работы модулей)"
L.SpamBlockNoIconRestore	= "Не сохранять состояние меток и восстанавливать их после боя"
L.SpamBlockNoRangeRestore	= "Не восстанавливать окно проверки дистанции в предыдущее состояние при скрытии модулями"

-- Tab: Spam Filter
L.Area_SpamFilter			= "Параметры спам-фильтра"
L.DontShowFarWarnings		= "Не отображать предупреждения/таймеры для событий, которые далеко"
L.StripServerName			= "Удалять имя сервера в предупреждениях и таймерах"

L.Area_SpecFilter			= "Параметры фильтра по роли"
L.FilterTankSpec			= "Фильтровать предупреждения для роли танка когда не в специализации танка"
L.FilterInterruptsHeader	= "Фильтровать предупреждения о прерываемых заклинаниях на основе предпочтений в поведении."
L.FilterInterrupts			= "Фильтровать предупреждения для прерываемых спеллов если кастер не является вашей текущей целью или фокусом."
L.FilterInterrupts2			= "Если кастер не является текущей целью/фокусом (всегда) или прерывается на CD (только для боссов)"
L.FilterInterrupts3			= "Если кастер не является текущей целью/фокусом (всегда) или прерывается на CD (босс и треш)"
L.FilterInterruptNoteName	= "Фильтровать предупреждения для прерываемых спеллов (со счетчиком) если предупреждение не содержит ваше имя в пользов. заметке"
L.FilterDispels				= "Фильтровать предупреждения для рассеиваемых спеллов если ваш диспел на кулдауне."
L.FilterSelfHud				= "Фильтровать себя на HudMap (кроме функций проверки дистанции)"

L.Area_PullTimer			= "Параметры фильтра таймеров пулла/боя/пользов."
L.DontShowPTNoID			= "Блокировать таймер пулла, отправленный из другой зоны"
L.DontShowPT				= "Не отображать индикатор таймера пулла"
L.DontShowPTText			= "Не отображать текст объявления для таймера пулла"
L.DontPlayPTCountdown		= "Не воспроизводить звук отсчета таймера пулла/боя/пользов."
L.DontShowPTCountdownText	= "Не отображать текст отсчета таймера пулла/боя/пользов."
L.PT_Threshold				= "Не отображать текст отсчета таймера пулла/боя/пользов. больше: %d"

L.Panel_HideBlizzard		= "Скрыть Blizzard"
L.Area_HideBlizzard			= "Настройки скрытия Blizzard"
L.HideBossEmoteFrame		= "Скрывать окно эмоций рейдового босса во время боя с боссом"
L.HideWatchFrame			= "Скрывать окно отслеживания заданий во время боя с боссом"
L.HideGarrisonUpdates		= "Скрывать уведомления из гарнизона во время боя с боссом"
L.HideGuildChallengeUpdates	= "Скрывать уведомления о гильдейских испытаниях во время боя с боссом"
L.HideQuestTooltips			= "Скрывать цели квестов во время боя с боссом"
L.HideTooltips				= "Скрывать подсказки во время боя с боссом"
L.DisableSFX				= "Отключить канал звуковых эффектов во время боя с боссами"
L.DisableCinematics			= "Отключить внутриигровые ролики"
L.AfterFirst				= "После одного просмотра"
L.Always					= "Всегда"
L.CombatOnly				= "Вывод в бою (любой)"
L.RaidCombat				= "Отключить в бою (только для боссов)"

L.Panel_ExtraFeatures		= "Дополнительные возможности"
--
L.Area_ChatAlerts			= "Параметры оповещений в чате"
L.RoleSpecAlert				= "Показывать предупреждение когда ваша специализация добычи не совпадает с текущей специализацией при присоединении к рейду"
L.CheckGear					= "Показывать предупреждение когда уровень надетых предметов намного ниже чем максимальный (40+)"
L.WorldBossAlert			= "Показывать предупреждение когда в вашем игровом мире ваши друзья или согильдийцы возможно вступают в бой с боссами вне подземелья<br/>(неточно, если отправитель в межсерверной зоне)"
--
L.Area_SoundAlerts			= "Параметры звуковых оповещений"
L.LFDEnhance				= "Проигрывать звук проверки готовности для проверки ролей и приглашений на БГ/ЛФГ через основной аудио канал"
L.WorldBossNearAlert		= "Проигрывать звук проверки готовности когда неподалеку пулят нужных вам боссов вне подземелья (переопределяет настройку для конкретного босса)"
L.RLReadyCheckSound			= "Проигрывать звук проверки готовности при проверке готовности через основной аудио канал или канал диалогов"
L.AFKHealthWarning			= "Звуковое оповещение если вы теряете здоровье во время АФК"
L.AutoReplySound			= "Звуковое оповещение при получении авто-ответа шепотом от DBM"
--
L.TimerGeneral 				= "Параметры таймера"
L.SKT_Enabled				= "Всегда отображать таймер рекордной победы<br/>(переопределяет настройку для конкретного босса)"
L.ShowRespawn				= "Отсчет времени до появления босса после вайпа"
L.ShowQueuePop				= "Отсчет оставшегося времени до принятия очереди (поиск группы, БГ и т.д.)"
L.ChallengeTimerOptions		= "Отображать таймер лучшего прохождения для режима испытаний"
L.ChallengeTimerPersonal	= "Персональный"
L.ChallengeTimerGuild		= "Гильдия"
L.ChallengeTimerRealm		= "Сервер"
--
L.Area_AutoLogging			= "Параметры автоматической записи"
L.AutologBosses				= "Автоматически записывать бои с боссами используя журнал боя Blizzard (Требуется использовать /dbm pull перед боссами для совместимости с <a href=\"http://www.warcraftlogs.com\">|cff3588ffwarcraftlogs.com|r</a>)"
L.AdvancedAutologBosses		= "Автоматически записывать бои с боссами используя Transcriptor"
L.LogOnlyRaidBosses			= "Записывать только бои с рейдовыми боссами (искл. Поиск Рейдов/5 ппл/сценарии)"
--
L.Area_3rdParty				= "Параметры аддонов третих лиц"
L.ShowBBOnCombatStart		= "Выполнять проверку положительных эффектов Big Brother в начале боя"
L.BigBrotherAnnounceToRaid	= "Объявлять результаты проверки Big Brother в рейд"
L.Area_Invite				= "Параметры приглашений"
L.AutoAcceptFriendInvite	= "Автоматически принимать приглашения в группу от друзей"
L.AutoAcceptGuildInvite		= "Автоматически принимать приглашения в группу от согильдийцев"
L.Area_Key					= "Параметры Мифик+ ключей"
L.AutoKeyLink				= "Линковать свой эпохальный+ ключ в чат группы/рейда (в разработке)"
L.Area_Advanced				= "Дополнительные настройки"
L.FakeBW					= "Притворяться BigWigs вместо DBM при проверке версий (Полезно для гильдий которые заставляют использовать BigWigs)"
L.AITimer					= "Автоматически генерировать таймеры для невиданных ранее боев с помощью встроенного в DBM таймера AI (полезно для первого появления тестового босса, например, в бета-версии или на PTR). Примечание: Это не будет работать правильно для нескольких дополнений с одинаковыми способностями"
L.AutoCorrectTimer			= "Автоматически исправлять слишком длинные таймеры (полезно для гильдий, использующих передовой контент, для которого еще не обновлены моды боссов). Примечание: Эта опция также может ухудшить некоторые таймеры, если босс сбрасывает таймеры при смене фазы, что DBM пока не умеет делать"

L.Panel_Profile				= "Профили"
L.Area_CreateProfile		= "Создание профиля настроек DBM Core"
L.EnterProfileName			= "Введите имя профиля"
L.CreateProfile				= "Создать новый профиль с стандартными настройками"--Might go off screen?
L.Area_ApplyProfile			= "Выбор активного профиля"
L.SelectProfileToApply		= "Выберите профиль для применения"
L.Area_CopyProfile			= "Копирование профиля настроек DBM Core"
L.SelectProfileToCopy		= "Выберите профиль для копирования"
L.Area_DeleteProfile		= "Удаление профиля настроек DBM Core"
L.SelectProfileToDelete		= "Выберите профиль для удаления"
L.Area_DualProfile			= "Настройки профиля для босс-модулей"
L.DualProfile				= "Включить поддержку разных настроек босс-модулей для специализаций. (Управление профилями босс-модулей производится с экрана статистики загруженного модуля)"

L.Area_ModProfile			= "Копирование настроек модуля с другого персонажа/спека или удаление настроек модуля"
L.ModAllReset				= "Сбросить все настройки модуля"
L.ModAllStatReset			= "Сбросить всю статистику модуля"
L.SelectModProfileCopy		= "Скопировать все настройки из"
L.SelectModProfileCopySound	= "Скопировать настройки звука из"
L.SelectModProfileCopyNote	= "Скопировать заметки из"
L.SelectModProfileDelete	= "Удалить настройки модуля для"

-- Misc
L.FontHeight	= 16
--Волосали
