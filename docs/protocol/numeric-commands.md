# Числовые команды (`net/Commands.as`)

Обозначения — в [overview.md](overview.md#как-читать-документы).

Появились в новой версии. Названия констант в восстановленном коде — плейсхолдеры (`COMMANDS_CONSTn`), поэтому ниже указаны и код, и константа.
«Источник» — окно, которое отправляет команду или подписано на ответ через `GameEventDispatcher`.

| Код | Константа | C→S | S→C | Источник |
|---|---|---|---|---|
| `02` | `CONST24` | — | `02\|menuType\|…` открыть окно по типу, см. ниже | `Client.doAction629` |
| `04` | `CONST14` | — | `04\|id\|args…` уведомление `IDS_NOTIFICATION_<id>`; id 80/81 снимают блокировку оплаты | `Client.doAction449` |
| `07` | `CONST2` | `07` | `07\|money` счёт клана | `ClanMoneyMenu` |
| `08` | `CONST34` | `08\|clanId` капитулировать | | `ClanWarsMenu` |
| `09` | `CONST20` | `09\|clanId` предложить мир | | `ClanWarsMenu` |
| `0a` | `CONST17` | `0a\|clanId` принять мир | | `ClanWarsMenu` |
| `0b` | `CONST13` | `0b\|clanId` отклонить мир | | `ClanWarsMenu` |
| `0c` | `CONST12` | `0c` | `0c\|N\|{clanA\|clanB}×N` идущие войны | `NewsMenu` |
| `0d` | `CONST6` | `0d\|page` | `0d\|page\|lastPage\|N\|{eventType\|time\|a1\|a2\|a3\|a4}×N` новости (`IDS_POLITIC_EVENT_<type>`) | `NewsMenu` |
| `0e` | `CONST29` | — | `0e\|sessionId\|` «Промах» | `Client` |
| `0f` | `CONST32` | — | `0f\|sessionId` «Уклонение» | `Client` |
| `0g` | `CONST27` | — | `0g\|clanId[\|clanName\|clanUrl\|position\|N\|{id}×N\|flag]` клан персонажа (при `clanId = 0` больше полей нет) | `Character.doAction303`, `NewsMenu` |
| `0h` | `CONST16` | `0h` | `0h\|declLimit\|v1\|v2\|v3\|v4\|v5\|N\|{clanId\|name}×N` кланы и параметры войн | `ClanWarsMenu` |
| `0i` | `CONST21` | `0i\|clanId` | `0i\|clanId\|startDate\|enemyPoints\|yourPoints\|state[\|reqClanId\|reqDate\|lifetime]`. `state`: 0 — война, 1 — запрошен мир (тогда есть данные запроса), 2 — завершена | `ClanWarsMenu` |
| `0j` | `FRIENDS_0j` | `0j\|clanId` объявить войну | | `ClanWarsMenu` |
| `0k` | `FRIENDS_0k` | `0k\|name` добавить друга | | `SocialMenu`, `CharacterInfo` |
| `0l` | `FRIENDS_0l` | `0l\|name` удалить друга | | то же |
| `0m` | `FRIENDS_INFO` | — | `0m\|N\|{name\|level\|userId\|online\|clanId\|clanName\|status}×N\|M\|{name\|level\|userId\|clanId\|clanName}×M` друзья (`status = 2` — входящая заявка) и враги | `Character.parseFriendsInfo` |
| `0n` | `FRIENDS_0n` | `0n\|type\|id\|token` вход через соцсеть | | `FightSocket` |
| `0o` | `FRIENDS_0o` | `0o\|name` добавить врага | | `SocialMenu`, `CharacterInfo` |
| `0p` | `FRIENDS_0p` | `0p\|name` удалить врага | | то же |
| `0q` | `CONST8` | — | `0q\|money` деньги персонажа | `Character.parseMoney`, `NuclearEPanel` |
| `0r` | `CONST30` | `0r` | `0r\|?\|N\|{item}×N\|M\|{type\|count\|…}×M` данные кастомизации: предметы и варианты видов | `CustomizationMenu` |
| `0s` | `CONST40` | `0s\|flag\|inventoryId\|newType\|newView` сменить тип и вид предмета | | `CustomizationMenu` |
| `0t` | `CONST36` | `0t\|inventoryId\|view` сменить вид предмета | | `CustomizationMenu` |
| `0v` | `CONST15` | — | `0v\|N\|{paramId\|value}×N` параметры персонажа, см. ниже | `Character.onStatusUpdate` |
| `0w` | `CONST22` | `0w\|cellId` | `0w\|cellId\|?\|N\|{item}×N` содержимое ячейки фабрики (сырьё/продукция) | `ManagementMenu` |
| `0x` | `CONST39` | `0x` | `0x\|initQueue\|queuePerLevel\|maxManagers\|speedPerLevel\|N\|{рецепт}×N` рецепты фабрики | `ManagementMenu` |
| `0y` | `CONST37` | `0y\|cellId` очистить ячейку фабрики | | `ManagementMenu` |
| `0z` | `CONST5` | `0z` доставить продукцию | | `ManagementMenu` |
| `10` | `CONST10` | `10` расширить клановый склад продукции | | `ClanProductMenu` |
| `11` | `CONST26` | `11\|login` добавить управляющего фабрикой | | `ManagementMenu` |
| `12` | `CONST18` | `12\|userId` удалить управляющего | | `ManagementMenu` |
| `13` | `CONST28` | `13\|recipeId` поставить рецепт в очередь | | `ManagementMenu` |
| `14` | `CONST31` | `14\|queueId` убрать из очереди | | `ManagementMenu` |
| `15` | `CONST7` | `15\|queueId\|position` переместить в очереди | | `ManagementMenu` |
| `16` | `CONST11` | `16` остановить или прервать производство | | `ManagementMenu` |
| `17` | `CONST25` | — | `17\|email\|` e-mail аккаунта | `Character.onEmailUpdate`, `SettingsMenu` |
| `18` | `CONST23` | `18` | `18\|N\|{zoneId\|name\|info\|type\|x\|y\|reward}×N` зоны клана | `ClanZonesMenu` |
| `19` | `CONST33` | `19\|zoneId` отказаться от зоны | | `ClanZonesMenu` |
| `1a` | `CONST35` | `1a` «опечатать» клан | | `NewsMenu` |
| `1b` | `CONST19` | `1b` снять печать | | `NewsMenu` |
| `1c` | `CONST4` | `1c\|clanId` выплатить контрибуцию | | `ClanWarsMenu` |
| `1d` | `CONST9` | `1d\|period` (0 — день, 1 — неделя, 2 — месяц) | `1d\|{index\|value}…` журнал счёта клана (13 значений для `IDS_CLAN_ACCOUNT_LOG`) | `ClanMoneyMenu` |
| `1e` | `CONST1` | — | `1e\|{sessionId\|}…` пометить существ неактивными | `World.doAction37` |
| `1f` | `CONST38` | `1f` | `1f\|text` объявление клана | `ClanAnnounceMenu` |
| `1g` | `CONST3` | `1g\|text\|` сохранить объявление | | `ClanAnnounceMenu` |

## Типы окон для `02`

Константы `BaseMenu.TYPE_*`.

| menuType | Окно |
|---|---|
| 23 | управление фабрикой (`ManagementMenu`; данные с индекса 2) |
| 24 | крафт: `02\|24\|N\|{resourceId\|count}×N\|workbenchId` (ресурсы игрока); если рецептов верстака ещё нет, клиент шлёт `rk` |
| 25 | улучшение предметов: `02\|25\|canRemoveUpgrades\|N\|{item}×N\|workbenchId` (предметы игрока, которые можно улучшить); если рецептов нет, клиент шлёт `rv`, а при первом открытии — `ug` |
| 26 | гравировка |
| 27 | магазин значков |
| 31 | депозитарий |
| 32 | друзья |
| 33 | кастомизация |
| 35 | клановый склад продукции |
| −25 | открыть в терминале меню войн клана |

Окна 23–27 и 35, если уже открыты, обновляются через `parseData`.

## Параметры `0v`

См. `Character.onStatusUpdate` и `game/CharParam.as`.

| paramId | Параметр |
|---|---|
| 0 | алкоголизм |
| 1 | химическое отравление |
| 2 | облучение |
| 3 | наркозависимость |
| 4 | скорость атаки (`aspd`) |
| 5 | сопротивление радиации |
| 21 | текущий вес груза |
| 22 | PvP-рейтинг |
| 23–27, 29, 30 | навык `paramId − 23` |
| 28 | навык торговли |
| 31 | ранг |
| 32 | очки до следующего ранга |

## Запись рецепта в `0x`

```
id|type|duration|
  если type == 0: level|<item>|count       (продукт)
  иначе:          upgradeType|upgradeLevel (улучшение фабрики)
N|{ingredientId|name|count}×N
```
