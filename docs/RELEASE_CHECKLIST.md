# Checklist de Release

## Pre-Release

### Código
- [ ] Todos los sistemas probados en Test Server
- [ ] Sin `print()` de debug innecesarios (o usar sistema de logging)
- [ ] Sin código comentado masivo
- [ ] Errores en Output revisados
- [ ] Funciona en PC y móvil (si aplica)

### Documentación
- [ ] README del juego actualizado
- [ ] GAME_DESIGN actualizado con cambios
- [ ] CHANGELOG o descripción de versión
- [ ] Instrucciones claras si hay mecánicas nuevas

### Git
- [ ] Todos los cambios commiteados
- [ ] Rama mergeada a `main`
- [ ] Tag de versión creado: `git tag -a vX.Y.Z -m "Release vX.Y.Z"`
- [ ] Push de tag: `git push origin vX.Y.Z`

### Roblox
- [ ] Juego publicado en Roblox (solo con autorización)
- [ ] Configuración de juego revisada (accesibilidad, permisos)
- [ ] Monetización revisada si aplica
- [ ] Descripción y thumbnails actualizados
- [ ] Probar en juego publicado (link privado primero)

## Post-Release
- [ ] Monitorear errores/reportes
- [ ] Hotfixes si son críticos
- [ ] Documentar lecciones aprendidas
- [ ] Planificar siguiente versión

## Versionado

Seguir [Semantic Versioning](https://semver.org/):
- **MAJOR**: Cambios incompatibles o gran reinvención
- **MINOR**: Nuevas funcionalidades compatibles
- **PATCH**: Correcciones de bugs
