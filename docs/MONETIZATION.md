# Monetización — Principios y Consideraciones

> **IMPORTANTE:** Esta documentación es solo informativa para fase futura. **NO** implementar compras reales, productos de desarrollador o mecanismos de retiro durante esta fase inicial.

## Principios

- **Transparente**: Los jugadores deben saber qué están comprando
- **Justo**: Evitar pay-to-win excesivo que arruine la experiencia
- **Opcional**: Las compras deben ser cosméticas o convenientes, nunca obligatorias
- **Cumplimiento**: Seguir [Términos de Uso de Roblox](https://en.help.roblox.com/hc/es/articles/115004647846) y [Políticas de Monetización](https://create.roblox.com/docs/production/monetization)

## Opciones de monetización en Roblox

| Método | Uso | Notas |
|--------|-----|-------|
| **Game Passes** | Funcionalidades permanentes | Comprar una vez, acceso permanente |
| **Developer Products** | Items consumibles | Robux por item/uso |
| **Private Servers** | Servidores privados | Suscripción o compra |
| **Asset Marketplace** | Vender assets (si aplica) | Diferente al juego |

## Guardado de progreso

- Usar **DatastoreService** con cuidado
- Implementar **retry logic** y manejo de errores
- Respetar límites de API de Roblox
- Considerar **session locking** para evitar exploits
- **Nunca** guardar información sensible
- Implementar backups/lógica defensiva

## Seguridad

- **NUNCA** exponer claves o tokens
- Validar todas las compras en **servidor** (ServerScriptService)
- Usar `MarketplaceService.ProcessReceipt` correctamente
- No confiar en datos del cliente
- Documentar pero no implementar hasta fase de release planificada

## Checklist futuro

- [ ] Definir estrategia de monetización (si aplica)
- [ ] Diseñar productos sin romper experiencia free-to-play
- [ ] Implementar con validación server-side
- [ ] Probar en desarrollo con Robux de prueba
- [ ] Revisar políticas antes de publicar
