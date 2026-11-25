# Сетевой протокол клиента «Unit»: обзор

Описание форматов и порядка обмена между клиентом и сервером.
Разделы: [транспорт](transport.md), [сессия](session.md), [структуры данных](data-structures.md), [движение](movement.md), [карта мира](world-map.md), команды [клиента](client-commands.md), [сервера](server-commands.md), [терминала](terminal.md) и [числовые команды](numeric-commands.md), [улучшение предметов](upgrade.md).

## Как читать документы

- **C→S** — сообщение от клиента серверу, **S→C** — от сервера клиенту.
- В форматах `|` разделяет поля, `[...]` — необязательная часть, `{...}×N` — группа полей, повторённая N раз.
  Имя поля описывает, что клиент делает с этим значением.
- Ссылки вида `Client.handleData` указывают на методы классов в `client/src/`.
- Поля, смысл которых неизвестен, помечены «?». Поля, которые клиент получает, но не читает, помечены «-».

## Общие сведения

| Параметр | Значение | Где в коде |
|---|---|---|
| Сервер | `unit-online.ru` | конструктор `NuclearSocket` |
| Порт | `5190` (TCP) | конструкторы `NuclearSocket`, `NSocket` |
| Резервный канал | HTTP POST `http://unit-online.ru/webrule.fcgi` | `NSocket.sendStr`, `NSocket.connectViaProxy` |
| Кодировка | Windows-1251 в обе стороны | `NSocket.socketDataHandler`, `NSocket.writeCP1251String` |
| Формат | текстовые команды, поля через `\|` | |
| Код команды | первое поле, обычно 2 символа: буквы `[a-z]` или цифры `[0-9a-z]` | |
| Шифрование, сжатие | нет; пароль передаётся открытым текстом | `FightSocket.loginFight` |

Протокол асимметричен: клиент отправляет сообщения с бинарным префиксом длины, сервер — текст с терминатором `#`.

## Маршрутизация входящих сообщений

```
NSocket.socketDataHandler
  └─ для каждого сообщения:
       Client.processData(getData)  ── dataHandler
         ├─ true  → сообщение обработано
         └─ false → NSocket.handleData()  (виртуальный)
                      NuclearSocket.handleData   "ci"
                        → FightSocket.handleData  "lg"
                          → GameSocket.handleData "sg mv ol do bs ub sb md cl cu cd dc du rn ue uo ms pu ut at ht dd ah zz zh hv vs"
```

`Client.handleData()` работает так:

1. **До входа в игру** (`gameStarted == false`, флаг ставится при получении `lg`) пропускаются только
   `lg ls eg cc lf hn cl cd es ch ss 0g 0m 0q 17`. Остальные сообщения молча отбрасываются.
   Например, `vh` и `0v`, пришедшие до `lg`, клиентом игнорируются.
2. **Режим терминала** (окно `Terminal` видимо): сначала вызывается `handleTerminalData()`. Если он вернул `true`, обработка заканчивается.
   Часть кодов в терминале значит другое, чем в мире (`ul`, `cl`, `cu`, `iv`, `eg`, `et`, `mp`, `za`, `eh`, `eu`, `hy`, `ph`, `rr`, `rl` и др.).
3. **Режим мира**: основной `switch` в `Client.handleData()`. Если код не найден или ветка заканчивается `break` (`po`, `wc`), сообщение уходит в цепочку сокетов.

Помимо этого, есть шина подписки `net/GameEventDispatcher`: `dispatch(getData)` вызывает все обработчики, подписанные на `getData[0]`.
Через неё обрабатывается большинство числовых команд ([numeric-commands.md](numeric-commands.md)), а также `cm` и `mv` (для отдельных окон).
