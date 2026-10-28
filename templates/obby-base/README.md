# Plantilla Obby Base

Plantilla estructural para crear nuevos Obbys. Copiar esta estructura a `games/nuevo-obby/` y adaptar según necesidades.

## Estructura sugerida

```
nuevo-obby/
├── README.md
├── GAME_DESIGN.md
├── TEST_PLAN.md
├── default.project.json
└── src/
    ├── server/
    ├── client/
    └── shared/
```

## Archivos a crear al usar plantilla

- `default.project.json` - Configuración Rojo
- `GAME_DESIGN.md` - Diseño del juego
- `TEST_PLAN.md` - Plan de pruebas
- `README.md` - Info específica del juego

## Notas

- Mantener independencia entre juegos
- No compartir código directamente, copiar/adaptar si necesario
- Seguir convenciones del estudio
