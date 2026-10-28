# GAME_DESIGN — Troll Obby: Trust Nothing!

## Concepto

Obby tradicional con giros troll. El jugador debe desconfiar de todo: plataformas que desaparecen, bloques que caen, paredes que aparecen, etc. El humor viene del engaño, no de la dificultad imposible.

## Estética

- **Colores:** Neón vibrantes (cian, magenta, amarillo, verde lima)
- **Ambiente:** Divertido, colorido, con toques caricaturescos
- **UI:** Minimalista con humor sutil
- **Iluminación:** Brillante y llamativa

## Mecánicas MVP

### Core
| Mecánica | Descripción | Prioridad |
|----------|-------------|-----------|
| **Plataformas falsas** | Plataformas que colapsan/desaparecen al pisar o al acercarse | Alta |
| **Trampas por contacto** | Bloques que caen, pinchos, killbricks activados al pasar | Alta |
| **Obstáculos móviles** | Plataformas que se mueven horizontal/verticalmente | Alta |
| **Checkpoints** | Guardado de progreso por etapa | Alta |
| **Respawn** | Reaparición en último checkpoint al morir | Alta |

### UI/UX
| Elemento | Descripción | Prioridad |
|----------|-------------|-----------|
| **Etapa actual** | "Etapa X/12" visible | Alta |
| **Contador de muertes** | Tracking de muertes del jugador | Alta |
| **Feedback visual** | Colores/efectos para indicar trampas (sutil) | Media |

### Soporte
- **PC:** WASD + Space + Mouse
- **Móvil:** Controles virtuales de Roblox (joystick + jump)
- **Respawn automático** al caer/morir

## Diseño de niveles

**12 etapas progresivas:**
1. **Tutorial engañoso** - Introducción a desconfianza
2. **Primeras falsas** - Plataformas que desaparecen
3. **Caída sorpresa** - Trampas por contacto
4. **Movimiento** - Obstáculos móviles simples
5. **Combinación** - Falsas + trampas
6. **Timing** - Requiere precisión
7. **Desconfianza total** - Múltiples engaños
8. **Labio de troll** - Secuencias consecutivas
9. **Pánico controlado** - Más rápido/intenso
10. **Mezcla caótica** - Todo combinado
11. **Desafío duro** - Difícil pero justo
12. **Final troll** - Giro inesperado pero alcanzable

## Balance

- **Dificultad:** Media-Alta pero nunca puramente aleatoria
- **Justicia:** Siempre hay una forma lógica de pasar (aunque troll)
- **Humor:** Engañar, no humillar
- **Checkpoint frecuente:** En o cerca de cada etapa

## Arquitectura (propuesta)

```
src/
├── server/
│   ├── CheckpointService.luau   # Gestión de checkpoints
│   ├── TrapService.luau         # Activación de trampas
│   └── KillService.luau         # Manejo de muerte/respawn
├── client/
│   ├── UI.luau                  # HUD (etapa, muertes)
│   └── Effects.luau             # Efectos visuales
└── shared/
    ├── Config.luau              # Configuración global
    └── Types.luau               # Tipos Luau
```

> **Nota:** Esta arquitectura es propuesta. No hay código implementado aún.
