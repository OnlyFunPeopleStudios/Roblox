# Flujo de Trabajo en Roblox Studio

## Configuración inicial

1. **Instalar herramientas**: Git, GitHub CLI, Roblox Studio, Rojo
2. **Clonar repositorio**: `git clone https://github.com/OnlyFunPeopleStudios/Roblox.git`
3. **Seleccionar juego**: Navegar a `games/<nombre-juego>/`

## Sincronización con Rojo

### Método 1: Rojo CLI + Plugin
1. Abrir terminal en la carpeta del juego: `cd games/troll-obby`
2. Iniciar servidor: `rojo serve default.project.json`
3. Abrir Roblox Studio
4. Instalar/activar plugin Rojo
5. Conectar al servidor local (por defecto `localhost:34872`)
6. Los cambios en archivos locales se sincronizan con Studio

### Método 2: Rojo Build
```bash
rojo build default.project.json -o juego.rbxl
```
Abrir el `.rbxl` generado en Roblox Studio.

## Estructura recomendada en Rojo

El `default.project.json` define el árbol de instancias. Mantener correspondencia entre:
- `src/server/` → `ServerScriptService`
- `src/client/` → `StarterPlayer/StarterPlayerScripts` o `StarterGui`
- `src/shared/` → `ReplicatedStorage`

## Buenas prácticas

- **Trabajar localmente**: Editar archivos `.luau`/`.lua` en editor (VS Code) y sincronizar con Rojo
- **Probar frecuentemente**: Usar Play Solo/Test Server en Roblox Studio
- **Commits pequeños**: Guardar cambios funcionales con commits descriptivos
- **No editar directamente en Studio**: Si se edita en Studio, usar Rojo para sincronizar hacia archivos o tener cuidado con conflictos
- **Mantener juegos separados**: Cada juego tiene su propio `default.project.json`

## Debugging

- Usar Output de Roblox Studio
- Usar `print()`, `warn()`, `error()` en Luau
- Revisar logs de Rojo en terminal
- Probar en modo Test Server para simular cliente/servidor
