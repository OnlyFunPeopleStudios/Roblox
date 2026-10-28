# Log de Sesión — 2026-10-27/28

## Resumen

Se inicializó el repositorio central de Roblox para OnlyFunPeople Studios y se construyó el primer prototipo estructural de **Troll Obby: Trust Nothing!**.

## Lo que se implementó

### Repositorio
- Creación del repositorio `OnlyFunPeopleStudios/Roblox` en GitHub
- Estructura base: `docs/`, `templates/`, `games/troll-obby/`
- Documentación completa en español (README, CONTRIBUTING, STUDIO_WORKFLOW, GIT_WORKFLOW, MONETIZATION, RELEASE_CHECKLIST)
- `.gitignore` configurado para excluir secretos, archivos temporales, logs, cachés

### Troll Obby — Prototipo
- `src/shared/Config.luau` — Configuración centralizada (colores, tamaños, delays)
- `src/server/MapBuilder.luau` — Generación procedural de 12 etapas, checkpoints, plataformas falsas, trampas, meta
- `src/server/TrapService.luau` — Plataformas falsas que desaparecen y reaparecen; trampas killbrick con debounce
- `src/server/CheckpointService.luau` — Checkpoints por etapa, reaparición segura con `PivotTo()`, contador de muertes
- `src/server/Main.server.luau` — Inicialización única del servidor, creación de RemoteEvent `UpdateUI`
- `src/client/UI.client.luau` — HUD con etapa actual y contador de muertes

### Herramientas
- Rojo 7.7.1 instalado vía GitHub Releases
- Plugin de Rojo instalado en Roblox Studio

## Cambios de spawn y respawn (sesión de corrección)

### MapBuilder.luau
- `CanCollide = true` explícito en StartPlatform, Base, Meta, checkpoints, plataformas y plataformas falsas
- Trampas con `CanCollide = false` (no bloquean movimiento, solo detectan contacto)
- Geometría real: StartPlatform en `CFrame.new(0, 1, -12)`, tamaño `Vector3.new(8, 1, 8)`, superficie superior en Y=1.5

### CheckpointService.luau
- **Cálculo desde geometría real**: `getSpawnCFrame()` calcula posición por encima de StartPlatform usando `startPlatform.Position` y `startPlatform.Size` (no coordenadas arbitrarias)
- **Uso de `Character:PivotTo()`** en vez de `hrp.CFrame = ...` para teletransportar todo el personaje de forma confiable
- **Espera robusta**: `WaitForChild("HumanoidRootPart", 10)`, espera a que el personaje esté parentado en Workspace, espera un frame adicional
- **Re-verificación**: Después de un frame, si el personaje se movió más de 5 studs del destino, re-aplica PivotTo
- **Checkpoints**: `getCheckpointSpawnCFrame()` calcula spawn por encima del cilindro del checkpoint
- **Sin conexiones duplicadas**: `Died` se desconecta antes de crear una nueva conexión
- **Mantiene Stage al morir**: No retrocede de etapa, solo incrementa Deaths
- **Fallback**: Si no encuentra checkpoint esperado, usa spawn inicial y loggea warning

### TrapService.luau
- **Debounce por jugador**: Tabla `deadPlayers` con limpieza tras 3 segundos
- **Verificación de Health**: Solo mata si `humanoid.Health > 0`
- **Una muerte por vida**: Previene que múltiples eventos `Touched` (de brazos, piernas, accesorios) provoquen muertes duplicadas
- **Trampas permanecen activas**: No se desactivan, siguen siendo letales para intentos posteriores

## Verificaciones estáticas realizadas

- ✅ `rojo sourcemap` confirma todos los archivos mapeados correctamente
- ✅ Plugin de Rojo actualizado (`rojo plugin install`)
- ✅ Requires usan `:WaitForChild()` con timeout en Main.server.luau
- ✅ Sin acceso directo que pueda fallar por timing
- ✅ `CanCollide = true` explícito en StartPlatform
- ✅ `PivotTo()` usado en vez de `hrp.CFrame`
- ✅ Posición calculada desde geometría real (no hardcodeada)
- ✅ Debounce en trampas con limpieza tras 3s
- ✅ Sin conexiones duplicadas (Died se desconecta antes de crear nueva)
- ✅ Sin secretos, tokens ni credenciales en el código
- ✅ `.gitignore` excluye archivos temporales y sensibles

## Problemas conocidos

1. **Respawn no verificado en Studio** — Las correcciones de respawn (PivotTo, cálculo desde geometría) no se han probado en Roblox Studio. Se requiere verificación manual.
2. **Bucle de muerte potencial** — Si el respawn no funciona correctamente, el personaje puede reaparecer sobre una trampa. Las correcciones intentan resolver esto pero no están verificadas.
3. **Licencia pendiente** — No se agregó licencia. Requiere decisión del propietario.
4. **Rojo no instalado globalmente** — Solo CLI vía cargo/bin. Documentado en README.

## Pruebas manuales pendientes en Roblox Studio

### Aparición inicial
- [ ] El personaje debe aparecer flotando ~4.5 unidades sobre StartPlatform (Y=4.5), no en el suelo (Y≈0)
- [ ] Verificar en Output que no haya errores de "not a valid member"
- [ ] Verificar que StartPlatform tenga CanCollide = true

### Muerte por trampa
- [ ] Tocar una trampa roja (etapas 3, 6, 8, 10, 12) debe matar al jugador
- [ ] Debe morir una sola vez (no múltiples muertes por un solo contacto)
- [ ] El contador de muertes debe incrementar exactamente +1

### Contador de muertes
- [ ] "MUERTES: N" debe incrementar en 1 por cada muerte real
- [ ] No debe incrementar por eventos duplicados de Touched

### Respawn en checkpoints
- [ ] Si no alcanzó checkpoint → reaparece sobre StartPlatform (z=-12)
- [ ] Si alcanzó checkpoint → reaparece sobre ese checkpoint (no en la trampa)
- [ ] La posición de respawn debe estar fuera de zonas mortales
- [ ] El Stage alcanzado se conserva al morir

### Otras pruebas
- [ ] Sincronización de archivos con plugin Rojo
- [ ] Generación del mapa (12 etapas, checkpoints, trampas, plataformas falsas)
- [ ] Plataformas falsas desaparecen y reaparecen correctamente
- [ ] UI muestra etapa y muertes correctamente
- [ ] Funciona en PC y móvil
- [ ] Sin errores en Output de Studio

## Próximos pasos para continuar mañana

1. Abrir Roblox Studio y conectar plugin Rojo a `localhost:34872`
2. Verificar sincronización de archivos
3. Ejecutar Play Solo y probar mecánicas según TEST_PLAN.md
4. Corregir cualquier error encontrado en Studio
5. Implementar obstáculos móviles (etapas 4, 6, 8, 10, 12)
6. Añadir efectos visuales y feedback
7. Preparar primera versión jugable (MVP)

## Archivos creados en esta sesión

```
docs/SESSION_LOG.md
games/troll-obby/src/shared/Config.luau
games/troll-obby/src/server/MapBuilder.luau
games/troll-obby/src/server/TrapService.luau
games/troll-obby/src/server/CheckpointService.luau
games/troll-obby/src/server/Main.server.luau
games/troll-obby/src/client/UI.client.luau
```

## Estado del repositorio

- Rama: `main`
- Remoto: `origin` → https://github.com/OnlyFunPeopleStudios/Roblox
- Commit inicial: `7c0dd1f`
- Último commit: `0ce89f5` — feat(troll-obby): initial playable prototype and respawn fixes
