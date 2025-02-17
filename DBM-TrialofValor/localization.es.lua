if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

----------
-- Odyn --
----------
L= DBM:GetModLocalization(1819)

-----------
-- Guarm --
-----------
L= DBM:GetModLocalization(1830)

L:SetOptionLocalization({
	YellActualRaidIcon		= "Cambiar todos los mensajes de chat de las espumas para que digan los iconos de los jugadores en lugar de los colores correspondientes (requiere ser líder de banda)",
	FilterSameColor			= "No asignar iconos, enviar mensajes de chat ni mostrar avisos especiales para las espumas si coinciden con el perjuicio de los alientos"
})

-----------
-- Helya --
-----------
L= DBM:GetModLocalization(1829)

L:SetTimerLocalization({
	OrbsTimerText		= "Orbes (%d-%s)"
})

L:SetMiscLocalization({
	phaseThree		= "¡Vuestros esfuerzos son fútiles, mortales! ¡Odyn NUNCA será libre!",
	near			= "cerca",
	far				= "lejos",
	multiple		= "múltiple"
})

----------------------
-- Enemigos menores --
----------------------
L = DBM:GetModLocalization("TrialofValorTrash")

L:SetGeneralLocalization({
	name =	"Enemigos menores"
})

L:SetOptionLocalization({
	timerRoleplay = DBM_CORE_OPTION_TIMER_COMBAT
})

L:SetTimerLocalization({
	timerRoleplay = DBM_CORE_GENERIC_TIMER_COMBAT
})

L:SetMiscLocalization({
	RP1 = "¡Campeones! Han derramado la sangre de los esbirros de Helya. Llegó la hora de entrar al Helheim y terminar con el reino oscuro de la bruja del mar. Pero primero... ¡un reto final!"
})
