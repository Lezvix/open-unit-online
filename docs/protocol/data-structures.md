# Общие структуры данных

Обозначения — в [overview.md](overview.md#как-читать-документы).
Координаты и стек движения — в [movement.md](movement.md), этажи — в [world-map.md](world-map.md#этажи).

## Идентификаторы

| Идентификатор | Смысл |
|---|---|
| `sessionId` | id существа в текущем мире. У игроков > 0, у NPC и мобов < 0 (`-1628`, `-134070`). |
| `userId` | id аккаунта (`10542309`). |
| `inventoryId` | id экземпляра предмета. |
| `itemId` | id типа предмета. Отрицательные значения встречаются у предметов NPC-торговцев. |
| `objectId` | id объекта карты. |

## Внешность (13 полей)

`PlayerItem.doAction332`: 6 видов слоёв (причёска, оружие и части тела/экипировки) и 7 номеров палитр.

```
view0|view1|view2|view3|view4|view5|pal0|pal1|pal2|pal3|pal4|pal5|pal6
```

Используется в `ul`, `uu`, `cv`.

## Информация о персонаже

`Character.parseInfo`, 51 поле:

```
userId|name|level|sex|race|hp|hpMax|
clanId|clanName|clanUrl|hireClanId|hireClanName|hireClanUrl|clanPosition|
armorClass|armorBonus|seenPerks|terminal|online|
stat0|…|stat5|                       (6 характеристик)
health0|…|health4|                   (алкоголизм, хим. отравление, облучение, наркозависимость, ?)
userAbilities|clanAbilities|avatarImg|
palette0|…|palette5|image0|…|image5|
weaponImg0|weaponImg1|weaponName0|weaponName1|
rank|nextRankPoints
```

`Character.parseFullInfo` (`:1145`) после этого читает ещё:

```
experience|prioritySkills|availablePerks|perks|intellect|skill0|…|skill8|battleSkillSum|pieceSkillSum
```

`Character.parseTraums` (`:1190`), используется в `ci`:

```
fullName|country|city|about|
N|{presentId|senderLogin|type|img|signature}×N|
M|{traumType|traumParam|traumTime}×M|
pvpRating
```

## Запись предмета (InventoryItem)

Самоописываемая запись **с префиксом длины**: первое поле — общее число полей записи, включая само это поле (конструктор `InventoryItem`).
Списки предметов разбираются так: `len = int(data[p]); item = data.slice(p, p + len); p += len`.

```
len|itemId|inventoryId|endtime|requiredRank|name|level|image|type|price|weight|upgradeCategory|
effectsCount|upgradesCount|{upgradeId}×upgradesCount|
<поля по типу>|
<params…>|                                 (до позиции len − 4*effectsCount)
{effType|probability|param|duration×10}×effectsCount
```

`requiredRank` — требуемый PvP-ранг (`IDS_PVP_RANK`): если он выше ранга персонажа, предмет нельзя надеть (`Inventory.check1`, `ItemInfo.create`).
Эффекты всегда занимают последние `4 × effectsCount` полей записи, даже если поля по типу их перекрывают.

Поля по типу (`type`):

| type | Тип | Поля |
|---|---|---|
| 0–4 | оружие, шлем, броня, штаны, ботинки | `itemClass\|status\|repairPrice\|isChanged\|isArt\|tear\|repairType` |
| 15, 17, 20 | инструменты и прочие | как у оружия |
| 5, 6, 7, 8, 16, 21 | граната, деньги, медицина, патроны, мина, редкое | `status\|count` |
| 9 | аддон (прибор) | `status\|repairPrice\|isChanged\|isArt\|tear` |
| 10, 19 | прочий предмет | `repairPrice\|isChanged\|isArt` |
| 11, 12, 13, 18 | расходники, запчасти, аптечки | `count` |
| 14 | подарок | — |

`status`: 0 — не надет, 1 — надет или в первом слоте оружия, 2 — во втором слоте.
Смысл `params` зависит от типа. Для оружия индексы заданы в `InventoryItem.WP_*`: тип оружия, урон мин./макс., точность, пробитие брони, дистанция, скорость, тип патронов, магазин, очередь, навык и т.д.

Пример из `iv` (15 полей):

```
15|-77|-173668087|0|0|Моток провода|1|20078|11|2|200|0|0|0|1
```

## Записи игроков

**Полная запись игрока** (`ul` и `uu` в мире), `Main.dataUserList`, 38 полей:

```
sessionId|userId|login|friendly|level|model|moveState|moveStack|
running|fraction|i|j|mapLevel|lastI|lastJ|walkSpeed|runSpeed|hp|hpMax|
clanId|clanName|clanUrl|hireClanId|hireClanName|hireClanUrl|
<внешность, 13 полей>
```

- `model` — класс модели (`PlayerItem.create`): 0 — мужчина, 1 — женщина, 2 — человекоподобный NPC, 3–11 — мобы `Npc002`…`Npc010`, 12 и 13 — «Голиафы».
- `moveState`: 0 — стоит, 1 — идёт (используется `moveStack`), 2 — мёртв.
- `running`: `1` — бежит.

**Короткая запись пользователя** (`UserList.parse`), 10 полей. Используется в списках чата и терминала (`cl`, `cu`, `ul` и `uu` в терминале):

```
sessionId|userId|login|level|clanId|clanName|clanUrl|hireClanId|hireClanName|hireClanUrl
```

## Быстрые слоты расходников

10 слотов × 3 поля (`NuclearEPanel.drawAddon`):

```
{imageId|name|count}×10
```

## Список пар «предмет — количество» (C→S)

`Chat.getString38`: `{inventoryId|count|}×N`. Используется в `bb`.
