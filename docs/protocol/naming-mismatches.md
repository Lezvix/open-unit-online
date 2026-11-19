# Соответствие методов клиента командам

В таблице указано, какую команду отправляет каждый метод `GameSocket` и для чего она служит.

| Метод | Команда | Назначение |
|---|---|---|
| `doAction603(a, b)` | `lg\|a\|b` | логин (не используется; логин шлёт `FightSocket`) |
| `doAction90` | `id` | выбросить предмет |
| `sendClanChatText(int)` | `fs` | режим огня |
| `sendVisualState(int)` | `rp` | ремонт своего предмета |
| `sendChangeFire(int)` | `op` | открыть подарок |
| `sendRepairOwn(int)` | `cf` | крафт по рецепту |
| `sendOpenPresent(int)` | `iw` | снять улучшения |
| `doAction167` | `ir` | гравировка |
| `doAction699` | `aa` | принять запрос действия |
| `sendCraftRequest(int)` | `ai\|x` | (старый `sendAddItem`) |
| `doAction518` | `di` | убрать предмет из бартера |
| `doAction365` | `ai\|inv\|count` | положить предмет в бартер |
| `sendActionAccept(int)` | `af` | положить предмет на ремонт |
| `sendAddItem(int)` | `th` | выбрать травму для лечения |
| `sendClanZonesRequest()` | `ex` | выйти из терминала |
| `doAction567` | `cz` | бой за зону (роль) |
| `doAction298` | `dm` | внести взнос |
| `doAction263(String)` | `au` | пригласить в клан |
| `processDue(int)` | `ru` | исключить из клана |
| `sendAddClanUser(int)` | `dr` | удалить заявку |
| `removeClanUser(String)` | `mt` | сообщить о предыдущем логине |
| `deleteAddRequest(int)` | `bg` | купить значок |
| `sendLogin(int, String)` | `ec` | открыть ячейку |
| `doAction576(int)` | `ld` | журнал ячейки |
| `sendExtendCell(int)` | `eu` | страница биржи |
| `sendUnlockCell(int)` | `ee` | купить лот биржи |
| `doAction844(Boolean)` | `hy` | меню кланового найма |
| `sendCellLogRequest(String)` | `ha` | нанять в клан |
| `sendExchangeUpdateRequest(int)` | `hi` | снять наёмника |
| `applyExchange(int)` | `hr` | удалить заявку найма |
| `sendAddClanHire(int)` | `hb` | принять клановый найм |
| `sendRemoveHireByUserId(int)` | `hd` | отклонить клановый найм |
| `sendRemoveHireRequest(int)` | `ph` | частный найм (страница) |
| `sendClanHireAccept(int)` | `hj` | вступить в частный найм |
| `sendRejectClanHire(int)` | `hk` | удалить частный заказ |
| `sendPrivateHireRequest(String)` | `fu` | найти пользователя |
| `sendPrivateHireJoin(int)` | `ho` | информация о заказе |
| `sendRemovePrivateHire(String)` | `rl` | пеленг игрока (РЛС) |
| `sendFindUserByLogin(int)` | `tc` | кнопка входа терминала |

Обработчики входящих команд в `Client` с вводящими в заблуждение именами:

| Код | Метод | Фактически |
|---|---|---|
| `iv` | `showPaySystemMenu` | открыть инвентарь |
| `ql` | `dataShowInventory` → `showFactoryMenu` | журнал квестов |
| `rm` | `dataFactoryMenuUpdate` | реферальное меню |
| `cv` | `tdataEnterTerminal` | смена внешности существа |
| `hd` | `dataSetFireType` | активная рука |
| `fs` | `dataEvadePlayer` | режим огня |
| `0f`, `ev` | `dataNewClanChatLevel` | надпись «Уклонение» |
| `0e` | `world.evadePlayer` | надпись «Промах» |
| `he` | `dataSilentText` | навык «доктор» |
| `rp` | `dataUpdatePaidValues` | предмет отремонтирован |
| `et` (в мире) | `doAction766` | вход в терминал |
| `rr`, `rl` (терминал) | `tdataBanText`, `tdataSystemText` | данные РЛС, результат пеленга |
| `iv` (терминал) | `tdataAddEvent` | инвентарь терминала |
| `za`, `zd` (терминал) | `tdataShowExchange`, `tdataOwnExchangeAdded` | обновление/удаление зоны |
| `eh`, `eu`, `ae` (терминал) | `tdataRadiolocation*`, `tdataUpdateExchange`, `tdataRadiolocate` | биржа |
| `ri` (терминал) | `tdataClanZoneList` | переход к списку рейдовых групп |
| `ul` (терминал) | `dataWarList` | список пользователей терминала |
