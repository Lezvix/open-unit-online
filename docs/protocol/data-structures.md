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

Запись содержит 6 видов слоёв внешности (причёска, оружие и части тела или экипировки) и 7 номеров палитр.

```
view0|view1|view2|view3|view4|view5|pal0|pal1|pal2|pal3|pal4|pal5|pal6
```

Используется в `ul`, `uu`, `cv`.

## Информация о персонаже

### Основные сведения

Запись содержит 51 поле.

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

### Полная информация

В полной записи после основных сведений идут дополнительные поля.

```
experience|prioritySkills|availablePerks|perks|intellect|skill0|…|skill8|battleSkillSum|pieceSkillSum
```

### Анкета, подарки и травмы

В `ci` после основных сведений идут данные анкеты, подарков и травм.

```
fullName|country|city|about|
N|{presentId|senderLogin|type|img|signature}×N|
M|{traumType|traumParam|traumTime}×M|
pvpRating
```

## Запись предмета

Первое поле `len` содержит общее число полей записи, включая само `len`. В списке предметов следующая запись начинается через `len` полей от начала текущей.

```
len|itemId|inventoryId|endtime|requiredRank|name|level|image|type|price|weight|upgradeCategory|
effectsCount|upgradesCount|{upgradeId}×upgradesCount|
<поля по типу>|
<params…>|                                 (до позиции len − 4*effectsCount)
{effType|probability|param|duration×10}×effectsCount
```

`requiredRank` задаёт минимальный PvP-ранг персонажа для экипировки предмета.
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
Смысл `params` зависит от типа предмета. У оружия параметры включают тип, минимальный и максимальный урон, точность, пробитие брони, дистанцию, скорость, тип патронов, ёмкость магазина, размер очереди и навык.

Пример из `iv` (15 полей):

```
15|-77|-173668087|0|0|Моток провода|1|20078|11|2|200|0|0|0|1
```

## Записи игроков

**Полная запись игрока** в мировых `ul` и `uu` содержит 38 полей.

```
sessionId|userId|login|friendly|level|model|moveState|moveStack|
running|fraction|i|j|mapLevel|lastI|lastJ|walkSpeed|runSpeed|hp|hpMax|
clanId|clanName|clanUrl|hireClanId|hireClanName|hireClanUrl|
<внешность, 13 полей>
```

- `model` задаёт внешнюю модель существа. `0` — мужчина, `1` — женщина, `2` — человекоподобный NPC, `3`–`11` — разновидности мобов, `12` и `13` — «Голиафы».
- `moveState`: 0 — стоит, 1 — идёт (используется `moveStack`), 2 — мёртв.
- `running`: `1` — бежит.

**Короткая запись пользователя** содержит 10 полей и используется в списках чата и терминала (`cl`, `cu`, `ul` и `uu` в терминале).

```
sessionId|userId|login|level|clanId|clanName|clanUrl|hireClanId|hireClanName|hireClanUrl
```

## Быстрые слоты расходников

В каждом из 10 слотов три поля.

```
{imageId|name|count}×10
```

## Список пар «предмет — количество» (C→S)

В `bb` список передаётся в формате `{inventoryId|count|}×N`.
