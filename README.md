<h2>📋 Sistema de Estilo de Animaciones de Radio</h2>

Este recurso permite ejecutar animaciones personalizadas al hablar por radio, integrando RPEmotes Reborn con detección de voz vía PMA-Voice. El jugador puede seleccionar su animación mediante un menú visual con qb-menu, accesible por tecla o comando. El script gestiona automáticamente la activación y cancelación de la animación según el estado de la radio, asegurando compatibilidad total y sin interferencias de otros scripts.

Pronto tendra soporte para otras Frameworks.

<h2>📋 Discord
<h3>thomhp</h3>
<h4><a href="https://discord.gg/ufSmtdX6AZ">Comunidad Discord</a></h4>


<h2>Instalación</h2>

**1.** Asegurese de tener `qb-core` & `qb-menu` en este caso instaladas en su servidor

**2.** Descargue el recurso `v1.0.0`

**3.** Agregue el sistema de Animaciones en su carpeta de recursos del servidor

**4.** inicie el script en su server.cfg

```html
ensure thom_animradio
```
<h2>Modificacion PMA-VOICE</h2>

Para el buen funcionamiento de el Recurso siga estos pasos

**1.** Dirijase a `pma-voice/client/module/radio.lua` en su servidor.

**2.** Busque y comente la siguiente linea de codigo
```html
if shouldPlayAnimation and HasAnimDictLoaded(dict) then
	if not IsEntityPlayingAnim(PlayerPedId(), dict, anim, 3) then
		TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 2.0, -1, 50, 2.0, false,
			false,
		false)
	end
end
```

