# OnlyFunPeople Studios — Roblox

**OnlyFunPeople Studios** es un estudio de desarrollo enfocado a crear experiencias divertidas, únicas y memorables en Roblox.

## Propósito

Este repositorio centraliza el desarrollo, mantenimiento y documentación de múltiples juegos independientes de Roblox. Cada juego vive en su propia carpeta bajo `games/`, con sus propios sistemas, assets y documentación, sin mezclar dependencias entre ellos.

## Juego actual en desarrollo

- **[Troll Obby: Trust Nothing!](games/troll-obby/)** — Obby humorístico con plataformas falsas, trampas inesperadas y mecánicas troll. Colores llamativos y dificultad progresiva.

## Tecnologías

- **[Luau](https://luau-lang.org/)** — Lenguaje de scripting usado por Roblox
- **[Roblox Studio](https://create.roblox.com/)** — Motor y editor oficial
- **[Rojo](https://rojo.space/)** — Sincronización bidireccional entre archivos locales y Roblox Studio
- **[Git](https://git-scm.com/)** + **[GitHub](https://github.com/)** — Control de versiones y colaboración
- **[OpenCode](https://opencode.ai/)** — Asistente de desarrollo para este proyecto

## Instalación de herramientas necesarias

### Windows

| Herramienta | Instalación | Notas |
|-------------|-------------|-------|
| Git | [git-scm.com/download/win](https://git-scm.com/download/win) | Incluir Git Bash (opcional) |
| GitHub CLI | [cli.github.com](https://cli.github.com/) | Autenticación con `gh auth login` |
| Roblox Studio | [create.roblox.com/download](https://create.roblox.com/download) | Cuenta de Roblox necesaria |
| Rojo | [rojo.space/docs/installation](https://rojo.space/docs/installation) | Ver sección abajo |

### Instalar Rojo

**Opción 1: Rojo CLI (recomendado)**
```powershell
# Con Aftman (gestor de herramientas de Roblox)
aftman add rojo-rbx/rojo
aftman install

# O con Cargo (Rust)
cargo install rojo

# O descargar desde GitHub Releases
# https://github.com/rojo-rbx/rojo/releases
```

**Opción 2: Rojo Plugin para Roblox Studio**
Descarga e instala el plugin desde [Rojo Plugin Marketplace](https://create.roblox.com/marketplace/asset/13916111004) o desde el repositorio oficial.

> **Nota:** Actualmente Rojo no está instalado en este entorno. Sigue los pasos arriba según tu preferencia.

## Iniciar un juego localmente

1. Clona el repositorio:
```bash
git clone https://github.com/OnlyFunPeopleStudios/Roblox.git
cd Roblox
```

2. Abre el juego que quieras trabajar (ej. `games/troll-obby/`).

3. Inicia Rojo desde ese directorio:
```bash
cd games/troll-obby
rojo serve default.project.json
```

4. Abre Roblox Studio, instala/activa el plugin de Rojo y conéctalo al servidor local (`localhost:34872` por defecto).

## Trabajar con Git y GitHub

Ver [docs/GIT_WORKFLOW.md](docs/GIT_WORKFLOW.md) para el flujo completo.

Flujo básico:
```bash
git checkout -b feature/nombre-cambio
# ... hacer cambios ...
git add .
git commit -m "tipo: descripción corta"
git push -u origin feature/nombre-cambio
# Crear Pull Request en GitHub
```

## Agregar juegos nuevos

1. Crear carpeta bajo `games/` con nombre en `kebab-case`: `games/nombre-juego/`
2. Seguir la estructura base similar a `games/troll-obby/`
3. Incluir `README.md`, `GAME_DESIGN.md`, `default.project.json`
4. Documentar en el README principal si se desea destacar
5. **Nunca** compartir código/sistemas entre juegos sin justificación y sin crear dependencias acopladas

## Versionado y documentación de cambios

- Usar [Semantic Versioning](https://semver.org/): `MAJOR.MINOR.PATCH`
- Documentar cambios importantes en commits descriptivos
- Para lanzamientos, seguir [docs/RELEASE_CHECKLIST.md](docs/RELEASE_CHECKLIST.md)
- Etiquetar versiones: `git tag -a v1.0.0 -m "Release v1.0.0" && git push origin v1.0.0`

## Estructura del repositorio

```
Roblox/
├── README.md           # Este archivo
├── .gitignore          # Archivos excluidos
├── CONTRIBUTING.md     # Guía para contribuir
├── LICENSE             # Licencia (pendiente de confirmación)
├── docs/               # Documentación del estudio
├── templates/          # Plantillas reutilizables
└── games/              # Juegos independientes
```

## Licencia

**Pendiente de confirmación por el propietario.** Ver alternativas en la conversación o consultar antes de publicar.
