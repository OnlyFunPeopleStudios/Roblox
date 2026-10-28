# Troll Obby: Trust Nothing!

Obby humorístico con estética colorida, plataformas falsas, trampas inesperadas y mecánicas troll. El objetivo es engañar al jugador de forma divertida sin resultar frustrante en exceso.

## Estado

**Fase:** Diseño inicial / Prototipo estructural  
**Objetivo:** Prototipo jugable en 1-3 días (tras implementación)

## Características planificadas (MVP)

- [ ] 12 etapas de dificultad progresiva
- [ ] Plataformas falsas
- [ ] Trampas activadas por contacto
- [ ] Obstáculos móviles
- [ ] Checkpoints
- [ ] Reaparición tras morir
- [ ] UI: etapa actual y contador de muertes
- [ ] Soporte PC y móvil
- [ ] Estética colorida y humorística

## Documentación

- [GAME_DESIGN.md](GAME_DESIGN.md) - Diseño detallado
- [TEST_PLAN.md](TEST_PLAN.md) - Plan de pruebas
- [default.project.json](default.project.json) - Configuración Rojo

## Desarrollo

### Sincronizar con Rojo
```bash
cd games/troll-obby
rojo serve default.project.json
```

Conectar desde Roblox Studio con plugin Rojo en `localhost:34872`.

### Estructura
```
troll-obby/
├── README.md
├── GAME_DESIGN.md
├── TEST_PLAN.md
├── default.project.json
└── src/
    ├── server/   # Scripts del servidor
    ├── client/   # Scripts del cliente
    └── shared/   # Módulos compartidos
```

**Nota:** Las mecánicas aún no están implementadas. Solo documentación y estructura.
