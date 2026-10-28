# Guía para Contribuir — OnlyFunPeople Studios

## Principios

- **Juegos independientes**: Cada juego bajo `games/` debe ser autónomo. No crear dependencias entre juegos.
- **Código limpio**: Usar Luau con estilo consistente. Comentarios en español cuando aporten contexto.
- **Commits atómicos**: Un commit = un cambio lógico.
- **Documentación**: Actualizar README/GAME_DESIGN si cambia la mecánica principal.

## Flujo de trabajo

1. Crear rama desde `main`: `git checkout -b feature/descripcion-corta`
2. Desarrollar y probar localmente con Rojo + Roblox Studio
3. Commits descriptivos siguiendo convención
4. Push y abrir Pull Request
5. Revisión antes de merge

## Convención de commits

Formato: `tipo: descripción`

Tipos sugeridos:
- `feat:` Nueva funcionalidad
- `fix:` Corrección de bug
- `docs:` Cambios en documentación
- `refactor:` Refactor sin cambio funcional
- `style:` Formato/estilo
- `test:` Añadir o modificar tests
- `chore:` Tareas de mantenimiento

Ejemplos:
- `feat: agregar sistema de checkpoints`
- `fix: corregir activación de trampa`
- `docs: actualizar GAME_DESIGN de troll-obby`

## Reglas de seguridad

- **NUNCA** commitear tokens, API keys, cookies o credenciales
- **NUNCA** commitear archivos `.rbxl` con contenido sensible
- **NUNCA** implementar compras reales o endpoints con secretos en esta fase
- Verificar `.gitignore` antes de commitear

## Añadir un nuevo juego

Ver [README.md](README.md#agregar-juegos-nuevos) para instrucciones detalladas.
