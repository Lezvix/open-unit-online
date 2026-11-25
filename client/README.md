# Клиент Unit

Flash-клиент на ActionScript 3 для Flash Player 11.1. Точка входа — `src/unit.as`. Исходники включают используемые сторонние библиотеки AS3; классы Flex (`mx.*`) подключаются из `framework.swc` SDK.

## Зависимости

- Adobe Flex SDK 4.6.0 build 23201 и Java для компилятора. Также подходит Apache Flex SDK 4.16.1 с `playerglobal.swc` для Flash Player 11.1.
- В Windows — `cmd` для `build.bat` или Git Bash для `build.sh`; в Linux и macOS — POSIX shell для `build.sh`.
- 110 PNG для встраивания через `[Embed]`: поместите файлы в `src/assets/` с именами из [списка ассетов](assets-list.txt). Ассеты в репозиторий не включены; их нужно получить отдельно. Без них компилятор не соберёт клиент.

По умолчанию SDK ищется в `../tools/flexsdk460/` относительно папки клиента. Можно задать `FLEX_HOME` в окружении, либо скопировать `local.env.example` в `local.env` для shell-сборки или `local.bat.example` в `local.bat` для Windows и указать свои пути. Для Apache Flex при необходимости задайте `PLAYERGLOBAL_HOME`, содержащий каталог `11.1` с `playerglobal.swc`.

## Сборка

Из каталога `client/`:

```sh
sh build.sh                  # Git Bash, Linux, macOS
# или в Windows cmd:
build.bat
```

Результат — `bin/unit.swf`. Оба скрипта принимают необязательный путь выходного SWF первым аргументом. Для запуска нужен Flash Player 11.1 или совместимая среда.

## Ресурсы для запуска

Помимо встроенных PNG, клиент загружает ресурсы относительно SWF: `locale/{lang}/locale.bin`, `locale/{lang}/ui.swf`, `locale/{lang}/sounds.swf`, `res/BgPack0.swf`, `res/ResPack*.swf`, `animations/*.swf`, `icons/...`, `sounds/items/*.mp3` и `sounds/music/zone_music.xml`. Эти ресурсы тоже нужно получить отдельно и разместить рядом с SWF с сохранением путей; без них игра не сможет полноценно работать.
