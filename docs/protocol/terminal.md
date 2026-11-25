# Терминал: кланы, зоны, рейды, биржа, найм

Обозначения — в [overview.md](overview.md#как-читать-документы).
Вход в терминал и выход из него — в [session.md](session.md#терминал).

## Команды клиента (C→S)

| Команда | Формат | Назначение |
|---|---|---|
| `ex` | `ex` | выйти из терминала в мир |
| `tc` | `tc\|channel` | кнопка «войти» терминала (номер канала из `et`) |
| `lr` | `lr` | список локаций (радиоменю) |
| `az` | `az\|` | доступные для заявки зоны |
| `za` | `za\|` | выйти из меню зон / отменить заявки |
| `zl` | `zl` | зоны для атаки (аукцион) |
| `zr` | `zr\|zoneId\|money` | ставка на аукционе зоны |
| `cz` | `cz\|zoneId\|role` | присоединиться к бою за зону: 1 — атакующий, 2 — защитник, 3 — зритель |
| `rz` | `rz[\|id]` | отклонить запрос атаки |
| `ry` | `ry` | локации рейдов |
| `ri` | `ri\|locationId\|password` | создать рейд |
| `rj` | `rj\|partyId\|password` | вступить в рейд |
| `r4` | `r4` | начать рейд |
| `ro` | `ro` | список рейдовых групп |
| `rx` | `rx\|userId` | выйти из группы или исключить участника |
| `r3` | `r3` | перестать следить за списком групп |
| `co` | `co` | управление кланом |
| `de` | `de` | взносы клана |
| `sd` | `sd\|amount` | установить ежемесячный взнос |
| `dm` | `dm\|amount` | внести взнос |
| `au` | `au\|login` | пригласить в клан |
| `ru` | `ru\|userId` | исключить из клана |
| `up` | `up\|userId\|position` | назначить должность |
| `dr` | `dr\|userId` | удалить заявку на вступление |
| `ra` | `ra\|userId\|1/0` | принять / отклонить заявку |
| `eh` | `eh` | открыть биржу обмена |
| `eu` | `eu\|page` | страница биржи |
| `ea` | `ea\|inventoryId\|count` | выставить на биржу |
| `er` | `er` | снять свой лот |
| `ee` | `ee\|lotId` | купить или принять лот |
| `rr` | `rr` | радиолокация (РЛС) |
| `rl` | `rl\|login` | запеленговать игрока |

Команды найма (терминал `ClanHireMenu`):

| Команда | Формат | Назначение |
|---|---|---|
| `hy` | `hy\|0/1` | меню кланового найма |
| `ha` | `ha\|login` | нанять игрока в клан |
| `hi` | `hi\|userId` | снять наёмника |
| `hr` | `hr\|requestId` | удалить заявку найма |
| `hb` | `hb\|requestId` | принять клановый найм |
| `hd` | `hd\|requestId` | отклонить клановый найм |
| `hm` | `hm` | уйти из найма |
| `ph` | `ph\|page` | частный найм |
| `hn` | `hn` | мои заявки |
| `hf` | `hf` | форма новой заявки |
| `hg` | `hg\|userId\|money\|days\|anonymous` | создать частный заказ |
| `hj` | `hj\|id` | вступить в частный найм |
| `hl` | `hl\|id` | покинуть частный найм |
| `hk` | `hk\|id` | удалить частный заказ |
| `fu` | `fu\|login` | найти пользователя |
| `ho` | `ho\|id` | информация о заказе |
| `hu` | `hu\|requestId\|…` | данные заявки (`Client.tdataHireUsers`) |

## Команды сервера (S→C)

Только при открытом терминале.

| Команда | Действие клиента |
|---|---|
| `eg` | закрыть терминал, показать мир |
| `et\|channel` | номер канала терминала |
| `ul`, `cl`, `cu`, `uu` | списки пользователей терминала — короткие записи ([записи игроков](data-structures.md#записи-игроков)) |
| `du\|sessionId` | удалить пользователя из списков |
| `lr\|{locationId\|questId\|name\|questName}…\|` | список локаций (`LocationsMenu.parseLocations`): строка `N. name (Квест: questName)`, выбор отправляет `sl\|questId\|locationId` |
| `de` | взносы клана |
| `co`, `rc` | управление кланом, заявки в клан |
| `zl`, `au`, `an`, `zf`, `zs` | зоны для атаки, обновление/удаление аукциона, ошибка, успех атаки |
| `az`, `za`, `zd` | доступные зоны, обновление/удаление зоны |
| `ry`, `ro`, `ri`, `r1`, `r2` | рейды: локации, группы, переход к группам, обновление/удаление группы |
| `eh`, `eu`, `ae` | биржа: открыть, страница, лот добавлен |
| `hy`, `ph`, `hm`, `hu`, `hg`, `fu` | найм: клановый, частный, мои заявки, наёмники, новый заказ, поиск игрока |
| `rr`, `rl`, `mp` | РЛС: данные, результат пеленга, карта с отметкой |
| `ua` | права пользователя (пересчитать страницы меню) |
| `iv` | открыть инвентарь терминала |
| `ah`, `ht` | игнорируются |

Форматы окон терминала:

| Команда | Формат | Где разбирается |
|---|---|---|
| `az` | `az\|canSpectate\|currentSide\|currentLocationId\|N\|{location}×N` | `AttackRequestsMenu.parseLocationsList`. `currentSide` пусто — не участвует |
| `za` | `za\|<location>` | `AttackRequestsMenu.updateLocation` |
| `zd` | `zd\|locationId` | `AttackRequestsMenu.removeLocation` |
| `eh` | `eh\|gameMoney\|goldMoney\|ownYear\|ownMonth\|ownDay\|ownGoldMoney\|ownGameMoney\|adminCourse\|adminGameMoney\|adminGoldMoney\|<лоты>` | `ExchangeMenu.parseCreateMenu`. `ownYear` = 0 — своего лота нет; год считается от 1900, месяц с нуля |
| `eu` | `eu\|<лоты>` | `ExchangeMenu.parseMenuItems` |
| `ae` | `ae\|gameMoney\|ownYear\|ownMonth\|ownDay\|ownGoldMoney\|ownGameMoney` | `ExchangeMenu.parseExchangeAdded` |
| `hy` | `hy\|type\|…` | `ClanHireMenu.parseClanHireData`, см. ниже |
| `ph` | `ph\|N\|{joinedOrderId}×N\|curPage\|pagesCount\|M\|{id\|customerId\|customerLogin\|targetId\|targetLogin\|killCount\|killPrice}×M` | `ClanHireMenu.parsePrivateHireData`. Первый список — заказы, в которые игрок уже вступил: у них кнопка «X» (`hl`), у остальных «Принять» (`hj`). `customerId` = 0 — аноним |
| `rr` | `rr\|available` | `RadioMenu.parseData`. 0 — РЛС недоступна (`IDS_RLS_NOT_AVAIBLE`) |
| `rl` | `rl\|0\|timeLeftMs` или `rl\|1\|terminalChannel[\|i×2\|j×2]` | `RadioMenu.parseRadiolocation`. Цель в терминале, если `terminalChannel` > 0, иначе координаты удвоены |

Лоты биржи: `pagesCount|curPage|N|{id|year|month|day|userId|login|goldMoney|gameMoney}×N`. На странице 0 клиент добавляет строку администрации сам.

Локация зоны (`location`):

```
id|type|
  type 0 (клановая зона): zoneName|zoneI|zoneJ|ownerClanId|ownerClanName|ownerClanUrl|attackingClanId|attackingClanName|attackingClanUrl|timeLeft
  type 1, 2 (PvP, PvE):   eventName|curAttackers|curDefenders|maxAttackers|maxDefenders|minLevel|maxLevel|timeLeft
{current|max|{userId|name|level|clanId}×current}×3      атакующие, защитники, зрители
```

`hy` по типу: 0 — список заявок `dynamicValue|deltaCost|N|{status|userId|login|clanName|timeLeft}×N` (`status` 0 — активен, иначе ожидание); 1 — предложение `requestId|clanName|days` (`IDS_HREQUEST`); 2 — найма нет; 3 — текущий найм `clanName|timeLeft`.
