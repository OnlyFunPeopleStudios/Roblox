# Flujo de Trabajo con Git y GitHub

## Configuración inicial

```bash
# Configurar identidad
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"

# Autenticar con GitHub CLI
gh auth login
gh auth status
```

## Crear rama para trabajar

```bash
git checkout main
git pull origin main
git checkout -b feature/nombre-descriptivo
```

## Hacer cambios y commitear

```bash
# Ver cambios
git status
git diff

# Añadir archivos
git add .

# Commit
git commit -m "feat: agregar sistema de checkpoints"
```

## Subir cambios

```bash
git push -u origin feature/nombre-descriptivo
```

## Crear Pull Request

Con GitHub CLI:
```bash
gh pr create --title "Título del PR" --body "Descripción de cambios"
```

O desde [github.com](https://github.com/OnlyFunPeopleStudios/Roblox/pulls)

## Sincronizar con main

```bash
git checkout main
git pull origin main
git checkout feature/mi-rama
git rebase main  # o merge main
```

## Comandos útiles

```bash
git log --oneline -5      # Ver últimos commits
git branch -a             # Ver ramas
git stash                 # Guardar cambios temporalmente
git stash pop             # Recuperar cambios guardados
```

## Reglas

- **Nunca** hacer `git reset --hard` sin confirmación explícita
- **Nunca** hacer `force push` a `main`
- **Siempre** verificar `git status` antes de commitear
- **No** commitear secretos o archivos generados innecesarios
- **Pull** antes de crear nueva rama desde `main`
