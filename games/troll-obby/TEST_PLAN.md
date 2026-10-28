# TEST_PLAN — Troll Obby: Trust Nothing!

## Objetivo
Verificar funcionalidad del MVP antes de considerar jugable.

## Pruebas por mecánica

| Mecánica | Caso de prueba | Esperado | Estado |
|----------|----------------|----------|--------|
| **Plataformas falsas** | Pisar plataforma falsa | Desaparece/cae tras delay | Pendiente |
| **Trampas por contacto** | Tocar trigger de trampa | Se activa y mata/jugador cae | Pendiente |
| **Obstáculos móviles** | Observar movimiento | Movimiento cíclico fluido | Pendiente |
| **Checkpoints** | Pasar checkpoint | Se guarda como respawn | Pendiente |
| **Respawn** | Morir y respawnear | Aparece en último checkpoint | Pendiente |
| **UI Etapa** | Avanzar de etapa | Actualiza contador correctamente | Pendiente |
| **UI Muertes** | Morir varias veces | Incrementa contador | Pendiente |

## Pruebas de plataforma

| Plataforma | Caso | Esperado | Estado |
|------------|------|----------|--------|
| **PC** | WASD + Space | Movimiento normal | Pendiente |
| **Móvil** | Joystick virtual + jump | Funciona correctamente | Pendiente |
| **Roblox Studio Play Solo** | Probar local | Sin errores en Output | Pendiente |
| **Test Server** | Probar multijugador | Checkpoints independientes por jugador | Pendiente |

## Pruebas de nivel

- [ ] Completar etapas 1-3 sin errores
- [ ] Verificar que todas las 12 etapas son alcanzables
- [ ] No hay soft-locks
- [ ] Caídas fuera del mapa respawnean correctamente
- [ ] No hay trampas imposibles de evitar

## Criterios de aceptación MVP

- [ ] 12 etapas funcionales
- [ ] Sistema de checkpoints + respawn
- [ ] UI básica funcionando
- [ ] Sin errores críticos en Output
- [ ] Jugable en PC y móvil
- [ ] Experiencia divertida (test con al menos 1 persona)

**Nota:** Todas las pruebas están pendientes hasta implementar el código.
