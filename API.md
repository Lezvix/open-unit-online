# Game Client-Server Protocol Documentation

## Transport Layer

### Connection
- **Protocol**: TCP Socket (Flash `XMLSocket`-style)
- **Encoding**: Windows-1251 (x-cp1251)
- **Initial handshake**: Flash policy file request

### Flash Policy Handshake
1. Client sends: `<policy-file-request/>\0`
2. Server responds with cross-domain policy XML
3. Server sends `\0` to finalize

### Message Framing

#### Client -> Server
Messages are length-prefixed binary frames:
```
[4 bytes: little-endian uint32 payload length][payload in CP1251]
```
Payload format: `command_code|param1|param2|...|`
Some commands omit the trailing `|`.

#### Server -> Client
Messages are `#`-delimited text in CP1251 encoding:
```
command1|param1|param2#command2|param1#
```
Multiple messages can arrive concatenated in a single TCP segment. The client splits on `#` and then splits each message on `|` into an array.

### Proxy Fallback
If direct TCP fails, the client falls back to HTTP POST polling via `/webrule.fcgi` endpoint using `sock=ID&hash=HASH&put=DATA` parameters.

---

## Authentication Flow

### 1. Ping (`pg`)
- **Direction**: Client -> Server
- **Format**: `pg`
- **Purpose**: Keep-alive. Sent every 25s (direct) or 5s (proxy). Also sent during login sequence.

### 2. Login (`lg`)
- **Direction**: Client -> Server
- **Format**: `lg|username|password|`
- **Example**: `lg|Egor1|password123|`

### 3. Login Failed (`lf`)
- **Direction**: Server -> Client
- **Format**: `lf|error_code#`
- **Error codes**:
  - `0` - Wrong login/password
  - `1` - User already online
  - `2` - Account banned
  - `6` - Too many login attempts (wait 15 seconds)
- **Note**: On `lf`, client increments session ID and retries login automatically.

### 4. Login Success / Full Character Data (`lg`)
- **Direction**: Server -> Client
- **Format**: `lg|timestamp|sessionId|mapWidth|mapHeight|terminalState|gameAccess|addonType|addonValue|runSubValue|runAddValue|userWeight|userMaxWeight|experience|levelExp|nextLevelExp|autoState|currentWeapon|weaponType0|weaponAmmo0|weaponCharge0|fireType0|ammoType0|weaponType1|weaponAmmo1|weaponCharge1|fireType1|ammoType1|settings|...characterData...|...panelData...#`
- **Fields**:
  - `timestamp` - Server time
  - `sessionId` - Player session ID
  - `mapWidth`, `mapHeight` - Map dimensions
  - `terminalState` - Terminal/lobby state (0 = in world, >0 = in terminal; bit 0 = radiolocation flag)
  - `gameAccess` - Access level flags
  - `addonType`, `addonValue` - Active addon
  - `runSubValue`, `runAddValue` - Run stamina drain/regen rates (divided by 2)
  - `userWeight`, `userMaxWeight` - Carry weight
  - `experience`, `levelExp`, `nextLevelExp` - XP progression
  - `autoState` - Auto-attack state (0/1)
  - `currentWeapon` - Active weapon slot (0 or 1)
  - Weapon data for slots 0 and 1: type, ammo, charge, fire type, ammo type
  - `settings` - Client settings bitmask
  - Character data starts at index 29 (parsed by `parseFullInfo`)

---

## Game Initialization

### 5. Enter Game (`eg`)
- **Direction**: Client -> Server
- **Format**: `eg`
- **Purpose**: Request to enter the game world from lobby. Server responds with version info and game data.

### 6. Version Info (`0v`)
- **Direction**: Server -> Client
- **Format**: `0v|param1|param2|param3|...#`
- **Purpose**: New in current version. Sends numeric version/config values. Appears after login and after certain state changes.
- **Example**: `0v|9|5|9|23|123750|24|105000|25|10000|26|10000|27|100000|28|100000|29|10000|30|10000|#`

### 7. Base Stats (`vh`)
- **Direction**: Server -> Client
- **Format**: `vh|runSubValue|runAddValue|maxWeight|maxHp|stat0|stat1|stat2|stat3|stat4|stat5|#`
- **Purpose**: Update base character stats (run sub/add values, max weight, max HP, 6 stats: Strength, Endurance, Luck, Perception, Deftness, Intellect).
- **Example**: `vh|5500|2994|109000|46|8|10|10|3|3|5|#`

### 8. Service List (`ss`)
- **Direction**: Server -> Client
- **Format**: `ss|param1|param2#`
- **Purpose**: Active service/subscription states.

### 9. Gold/Currency (`0g`)
- **Direction**: Server -> Client
- **Format**: `0g|value#`
- **Purpose**: Premium currency balance.

### 10. Money (`0m`)
- **Direction**: Server -> Client
- **Format**: `0m|value1|value2|#`
- **Purpose**: In-game currency/money values.

---

## World & Map

### 11. Character Data (`ch`)
- **Direction**: Server -> Client
- **Format**: `ch|userId|name|sex|race|...full character info...|#`
- **Purpose**: Complete character info block. Contains all stats, equipment images, clan info, weapon data, etc.
- **Example** (abbreviated): `ch|10542309|Egor1|1|0|0|46|46|0|||0|||0|0|0|1|0|1|8|10|10|3|3|5|0|0|0|0|0|0|0|1003|0|0|0|0|0|0|1000|0|0|0|0|0|10025|0|Rezak|Ruka|0|1000.00000|#`
- **Key fields**: userId, name, sex, race, level, maxLevel, HP, various flags, clan info (id, name, url), hire clan info, appearance layers (hair, helmet, armor, pants, boots, weapon), palette data, weapon slot data (image, name), and more.

### 12. Zone Change (`zc`)
- **Direction**: Server -> Client
- **Format**: `zc|zoneName|zoneDescription|pvpType|zoneParam#`
- **Purpose**: Notifies zone entry/change.
- **Example**: `zc|Respawn|Place of respawn for dead players.|1|4#`

### 13. Start Game / Show World (`ls`)
- **Direction**: Server -> Client
- **Format**: `ls#`
- **Purpose**: Signals the client to display the game world (exit loading/terminal).

### 14. User List (`ul`)
- **Direction**: Server -> Client
- **Format**: `ul|sessionId|userId|login|level|maleVal|state|moveStack|isRunning|attackSide|i|j|mapLevel|lastI|lastJ|walkSpeed|runSpeed|hp|hpAll|clanId|clanName|clanUrl|hireClanId|hireClanName|hireClanUrl|hairView|helmetView|armorView|pantsView|bootsView|weaponView|bodyPal|hairPal|helmetPal|armorPal|pantsPal|bootsPal|weaponPal|...next player...|#`
- **Purpose**: Full list of visible players/NPCs. Each entry is 37 fields.
- **Fields per player**:
  - `sessionId` - Negative = NPC, Positive = player
  - `userId` - Database user ID
  - `login` - Display name
  - `level` - Character level
  - `maleVal` - Gender/body type (0=male, 1=female, >1=NPC/monster types)
  - `state` - 0=standing, 1=moving, 2=dead
  - `moveStack` - Movement path (encoded directional string, only if state=1)
  - `isRunning` - 0/1
  - `attackSide` - Combat side
  - `i`, `j` - Grid position
  - `mapLevel` - Vertical map level
  - `lastI`, `lastJ` - Previous position
  - `walkSpeed`, `runSpeed` - Movement speeds
  - `hp`, `hpAll` - Current and max health
  - Clan data: `clanId|clanName|clanUrl|hireClanId|hireClanName|hireClanUrl`
  - Appearance: 6 layer views + 7 layer palettes

### 15. Object List (`ol`)
- **Direction**: Server -> Client
- **Format**: `ol|flags|objId|altId|staticId|spriteId|col|row|type|rect_params...|bgRect_params...|decoCount|...decoImages...|...next object...|#`
- **Purpose**: Add/update world objects (terrain features, decorations, interactive objects, sound sources).
- **Object fields include**: ID pairs, sprite ID, grid position (col, row), type, collision rectangle, background rectangle, and attached decoration/advertisement images.
- **Types**: Static decorations, interactive objects, sound objects (with additional intVal1/intVal2/intVal3 params), and none-type placeholders.

### 16. Delete Object (`do`)
- **Direction**: Server -> Client
- **Format**: `do|objId1|objId2|...|#`
- **Purpose**: Remove world objects by ID.

### 17. Set Background (`sb`)
- **Direction**: Server -> Client
- **Format**: `sb|mapWidth|mapHeight|tileSize|param4|param5|param6|param7|param8|...tileData...|#`
- **Purpose**: Set/update the world background tiles.
- **Tile data**: Long encoded string of base-62 tile indices representing the map background.

### 18. Update Background (`ub`)
- **Direction**: Server -> Client
- **Format**: Same as `sb`
- **Purpose**: Partial background update.

---

## Movement & Position

### 19. Move Request (`mv`)
- **Direction**: Client -> Server
- **Format**: `mv|targetX|targetY`
- **Purpose**: Request movement to pixel coordinates.
- **Example**: `mv|9717|4056`

### 20. Move Response (`mv`)
- **Direction**: Server -> Client
- **Format**: `mv|sessionId|i|j|destI|destJ|angleOrSpeed|moveStack#`
- **Purpose**: Confirms/broadcasts player movement.
- **Example**: `mv|160311|552|60|552|60|0|33111#`
- **`moveStack`**: Encoded path as sequence of direction digits (0-7 for 8 directions).

### 21. Move Direction (`md`)
- **Direction**: Server -> Client
- **Format**: `md|...params...|#`
- **Purpose**: Directional movement broadcast.

### 22. Player Stop (`ms`)
- **Direction**: Server -> Client
- **Format**: `ms|sessionId|i|j#`
- **Purpose**: Player stopped moving.

### 23. Toggle Run (`rn`)
- **Direction**: Client -> Server
- **Format**: `rn`

### 24. Run State (`rn`)
- **Direction**: Server -> Client
- **Format**: `rn|sessionId#`
- **Purpose**: Confirms run toggle for player.

### 25. Update Run (`ur`)
- **Direction**: Server -> Client
- **Format**: `ur|runValue#`
- **Purpose**: Update run stamina.

### 26. Stop (`st`)
- **Direction**: Client -> Server
- **Format**: `st`

### 27. Player Use Position (`pu`)
- **Direction**: Server -> Client
- **Format**: `pu|sessionId|i|j#`
- **Purpose**: Player position update during object use.

---

## Combat

### 28. Attack (`at`)
- **Direction**: Client -> Server
- **Format**: `at|targetSessionId|`

### 29. Attack Broadcast (`at`)
- **Direction**: Server -> Client
- **Format**: `at|sessionId|targetId|weaponId|dmg|i|j|hitType|bulletData#`
- **Purpose**: Broadcast attack animation/result.

### 30. Hit Player (`ht`)
- **Direction**: Server -> Client
- **Format**: `ht|sessionId|damage|attackerName|weaponName#`
- **Purpose**: Player took damage. If sessionId matches local player, HP bar updates.

### 31. Critical Hit (`cr`)
- **Direction**: Server -> Client
- **Format**: `cr|sessionId|damage|attackerName|weaponName#`

### 32. Evade (`ev`)
- **Direction**: Server -> Client
- **Format**: `ev|sessionId#`

### 33. Die (`dd`)
- **Direction**: Server -> Client
- **Format**: `dd|sessionId|killerSessionId#`

### 34. Add HP (`ah`)
- **Direction**: Server -> Client
- **Format**: `ah|sessionId|hpDelta#`
- **Purpose**: Heal/HP change.

### 35. Own Hit Info (`oh`)
- **Direction**: Server -> Client
- **Format**: `oh|damage|attackerName|killed#`

### 36. Own Critical Hit Info (`oc`)
- **Direction**: Server -> Client
- **Format**: `oc|damage|attackerName|killed#`

### 37. Fire Bullet (`fb`)
- **Direction**: Server -> Client
- **Format**: `fb|sessionId|bulletType|startI|startJ|endI|endJ|speed|gravityType|param9|param10|param11|param12|isGrenade#`

### 38. Effect Start (`eb`)
- **Direction**: Server -> Client
- **Format**: `eb|effectId|i|j|type#`

### 39. Effect Icon Show (`zz`)
- **Direction**: Server -> Client
- **Format**: `zz|sessionId|effectId#`

### 40. Effect Icon Hide (`zh`)
- **Direction**: Server -> Client
- **Format**: `zh|sessionId|effectId#`

### 41. Pet Attack (`ap`)
- **Direction**: Client -> Server
- **Format**: `ap|targetSessionId|`

---

## Weapon & Equipment

### 42. Change Hand / Weapon Slot (`hd`)
- **Direction**: Client -> Server
- **Format**: `hd|slotIndex`
- **Values**: `0` or `1`

### 43. Hand Changed (`hd`)
- **Direction**: Server -> Client
- **Format**: `hd|slotIndex#`

### 44. Change View (`cv`)
- **Direction**: Server -> Client
- **Format**: `cv|sessionId|hairView|helmetView|armorView|pantsView|bootsView|weaponView|bodyPal|hairPal|helmetPal|armorPal|pantsPal|bootsPal|weaponPal|#`
- **Purpose**: Update player appearance layers and palettes (14 values after sessionId).

### 45. New Weapons (`nw`)
- **Direction**: Server -> Client
- **Format**: `nw|weaponImg0|weaponName0|weaponType0|weaponAmmo0|weaponCharge0|fireType0|ammoType0|currentAmmo0|weaponImg1|weaponName1|weaponType1|weaponAmmo1|weaponCharge1|fireType1|ammoType1|currentAmmo1|#`
- **Purpose**: Full weapon slot refresh (2 weapon slots, 8 fields each).
- **Example**: `nw|10025|Rezak|0|0|0|0|0|-|0|Ruka|0|0|0|0|0|-|#`

### 46. New Bullets (`nb`)
- **Direction**: Server -> Client
- **Format**: `nb|slotIndex|charge|ammo#`

### 47. Change Fire Type (`fs`)
- **Direction**: Client -> Server
- **Format**: `fs|fireTypeIndex`

### 48. Fire Type Set (`fs`)
- **Direction**: Server -> Client
- **Format**: `fs|fireTypeIndex#`

### 49. Reload (`rd`)
- **Direction**: Client -> Server
- **Format**: `rd`

### 50. Unload Weapon (`un`)
- **Direction**: Client -> Server
- **Format**: `un`

### 51. Own Use/Cooldown (`oe`)
- **Direction**: Server -> Client
- **Format**: `oe|cooldownMs#`
- **Purpose**: Own action cooldown timer.

### 52. Own Weapon Wait (`uw`)
- **Direction**: Server -> Client
- **Format**: `uw|waitTime#`

---

## Inventory

### 53. Request Inventory (`iv`)
- **Direction**: Client -> Server
- **Format**: `iv`

### 54. Inventory Data (`iv`)
- **Direction**: Server -> Client
- **Format**: `iv|maxWeight|itemCount|...items...|#`
- **Purpose**: Full inventory contents.
- **Item format** (per item): `slotFlags|subSlot|itemUniqueId|flags1|flags2|itemName|flags3|itemSpriteId|itemType|itemSubType|durability|param1|...|paramN|`
- **Example item**: `32|9|5210933|0|0|Jeans|0|13000|3|8|1000|6|0|0|0|0|8|0|0|100|0|5005|0|5|5|5|5|5|2|0|1|0|`

### 55. Inventory Cancel (`ic`)
- **Direction**: Server -> Client
- **Format**: `ic#`
- **Purpose**: Close inventory screen.

### 56. Inventory Action (`ia`)
- **Direction**: Client -> Server
- **Format**: `ia`
- **Purpose**: Generic inventory action request (context-dependent).

### 57. Use Item (`ui`)
- **Direction**: Client -> Server
- **Format**: `ui|itemX|itemY|`

### 58. Direct Use (`ud`)
- **Direction**: Client -> Server
- **Format**: `ud|targetX|targetY|throwAngle|rectX|rectY|rectW|rectH`

### 59. Drop Item (`id`)
- **Direction**: Client -> Server
- **Format**: `id|itemId|count`

### 60. Use Expendable (`ue`)
- **Direction**: Client -> Server
- **Format**: `ue|slotIndex`

### 61. Expendable End (`ef`)
- **Direction**: Server -> Client
- **Format**: `ef|param#`

### 62. Rename Item (`ir`)
- **Direction**: Client -> Server
- **Format**: `ir|itemId|newName`

### 63. Open Present (`op`)
- **Direction**: Client -> Server
- **Format**: `op|presentId`

---

## Character & Stats

### 64. Character Menu (`cm`)
- **Direction**: Client -> Server
- **Format**: `cm`

### 65. Character Menu Data (`cm`)
- **Direction**: Server -> Client
- **Format**: `cm|stat0|stat1|stat2|stat3|...extended character data...|currencyData...|#`
- **Purpose**: Full character menu info including stats, skills, perks, currency balances.
- **Example**: `cm|0|0|0|0|||||123750|105000|10000|10000|100000|100000|10000|10000|1697671216|2|0|#`

### 66. Character Info Request (`ci`)
- **Direction**: Client -> Server
- **Format**: `ci|userId`

### 67. Character Info Response (`ci`)
- **Direction**: Server -> Client
- **Format**: `ci|...characterData...|#`

### 68. Character Update (`ch`)
- **Direction**: Server -> Client
- **Format**: `ch|...characterFields...|#`

### 69. Update Character (`uc`)
- **Direction**: Server -> Client
- **Format**: `uc|...characterFields...|#`

### 70. Skill Value Change (`ps`)
- **Direction**: Server -> Client
- **Format**: `ps|intellect|prioritySkills#`

### 71. Character Expendable Update (`ce`)
- **Direction**: Server -> Client
- **Format**: `ce|...panelImageData...|#`

### 72. Experience Change (`ec`)
- **Direction**: Server -> Client
- **Format**: `ec|xpGained|totalXP|levelXP|nextLevelXP#`

### 73. Player Level (`pl`)
- **Direction**: Server -> Client
- **Format**: `pl|newLevel#`

### 74. Weight Change (`wc`)
- **Direction**: Server -> Client
- **Format**: `wc|newWeight#`

### 75. Available Perks (`pc`)
- **Direction**: Server -> Client
- **Format**: `pc|...perkData...|#`

### 76. Trauma Add (`ta`)
- **Direction**: Server -> Client
- **Format**: `ta|...traumaData...|#`

### 77. Trauma Over (`to`)
- **Direction**: Server -> Client
- **Format**: `to|...params...|#`

### 78. Trauma Request (`tr`)
- **Direction**: Client -> Server
- **Format**: `tr|userId`

---

## Chat & Communication

### 79. Chat Text (`ct`)
- **Direction**: Bidirectional
- **Client->Server**: `ct|message`
- **Server->Client**: `ct|senderLogin|message#`

### 80. Clan Chat (`lt`)
- **Direction**: Bidirectional
- **Client->Server**: `lt|message`
- **Server->Client**: `lt|senderLogin|message#`

### 81. Private Message (`pt`)
- **Direction**: Bidirectional
- **Client->Server**: `pt|targetUserId|message`
- **Server->Client**: `pt|senderLogin|targetLogin|message#`

### 82. Own Private (`ot`)
- **Direction**: Server -> Client
- **Format**: `ot|param1|targetLogin|message#`

### 83. System Message (`sy`)
- **Direction**: Server -> Client
- **Format**: `sy|message|messageType#`

### 84. System Msg (`sm`)
- **Direction**: Server -> Client
- **Format**: `sm|msgId#`

### 85. Admin/Silent (`sl`)
- **Direction**: Server -> Client
- **Format**: `sl|muteTime#`

### 86. Ban (`bn`)
- **Direction**: Server -> Client
- **Format**: `bn#`

### 87. Bot Say (`bs`)
- **Direction**: Server -> Client
- **Format**: `bs|sessionId|param2|text#`
- **Purpose**: NPC speech bubble.
- **Example**: `bs|-1625|0|Hold your gun in the holster and head on shoulders#`

### 88. Hint (`hv`)
- **Direction**: Server -> Client
- **Format**: `hv|hintId|param1|param2|param3#`
- **Purpose**: Display localized hint text.

### 89. Hint Notification (`hn`)
- **Direction**: Server -> Client
- **Format**: `hn|...params...|#`

### 90. Visual State (`vs`)
- **Direction**: Bidirectional
- **Client->Server**: `vs|stateId`
- **Server->Client**: `vs|stateId#`

---

## NPC Interaction

### 91. Use Object (`us`)
- **Direction**: Client -> Server
- **Format**: `us|objectId|`

### 92. Object Use Start (`uo`)
- **Direction**: Server -> Client
- **Format**: `uo|sessionId|objectId|param3|param4#`

### 93. Object Use End (`ue`)
- **Direction**: Server -> Client
- **Format**: `ue|param1|objectId#`

### 94. Action Request (`ar`)
- **Direction**: Bidirectional
- **Client->Server**: `ar|targetSessionId|actionType`
- **Server->Client**: `ar|barterUserId|name|level#`
- **Action types**: 0=None, 1=Barter, 2=Dialog, 3=AskRepair, 4=Repair, 5=AskHeal, 6=Heal

### 95. Action Wait (`aw`)
- **Direction**: Server -> Client
- **Format**: `aw|barterUserId|name|level#`

### 96. Action Leave (`al`)
- **Direction**: Bidirectional
- **Client->Server**: `al`
- **Server->Client**: `al#`

### 97. Action Menu (`am`)
- **Direction**: Server -> Client
- **Format**: `am|actionType|...params...|#`

### 98. Action Confirm (`ac`)
- **Direction**: Bidirectional
- **Client->Server**: `ac|barterOpId`
- **Server->Client**: `ac#`

### 99. Action Confirm Fault (`bf`)
- **Direction**: Server -> Client
- **Format**: `bf#`

### 100. Safe Barter (`sa`)
- **Direction**: Server -> Client
- **Format**: `sa|timeSeconds#`

### 101. Start Dialog (`sd`)
- **Direction**: Server -> Client
- **Format**: `sd|...dialogData...|#`

### 102. Object Dialog (`ds`)
- **Direction**: Server -> Client
- **Format**: `ds|...dialogData...|#`

### 103. Dialog Node (`dn`)
- **Direction**: Server -> Client
- **Format**: `dn|...nodeData...|#`

### 104. Dialog Leave (`dl`)
- **Direction**: Server -> Client
- **Format**: `dl#`

### 105. Bot Barter (`bb`)
- **Direction**: Server -> Client
- **Format**: `bb|actionType|...barterData...|#`

---

## Barter/Trade Items

### 106. Add Barter Item (`ai`)
- **Direction**: Bidirectional
- **Client->Server**: `ai|itemId|count`
- **Server->Client**: `ai|barterOpId|...itemData...|#`

### 107. Delete Barter Item (`di`)
- **Direction**: Bidirectional
- **Client->Server**: `di|itemId|count`
- **Server->Client**: `di|barterOpId|itemIdx|count#`

### 108. Add Fix Item (`af`)
- **Direction**: Client -> Server
- **Format**: `af|itemId`

### 109. Delete Fix Item (`df`)
- **Direction**: Client -> Server
- **Format**: `df`

### 110. Heal Trauma Add (`th`)
- **Direction**: Client -> Server
- **Format**: `th|traumaId`

### 111. Heal Trauma Delete (`td`)
- **Direction**: Client -> Server
- **Format**: `td`

### 112. Set Price (`sp`)
- **Direction**: Bidirectional
- **Client->Server**: `sp|price`
- **Server->Client**: `sp|price#`

### 113. Add Existing Items Count (`bc`)
- **Direction**: Server -> Client
- **Format**: `bc|barterOpId|itemIdx|count#`

---

## Trade Box / Depot / Cell

### 114. Trade Box (`bx`)
- **Direction**: Server -> Client
- **Format**: `bx|...tradeBoxData...|#`

### 115. Trade Cell (`cb`)
- **Direction**: Bidirectional
- **Client->Server**: `cb|cellId|param2|param3|`
- **Server->Client**: `cb|...tradeCellData...|#`

### 116. Enter Cell (`ec`)
- **Direction**: Client -> Server
- **Format**: `ec|cellId|password|`

### 117. Prolong Cell (`pl`)
- **Direction**: Client -> Server
- **Format**: `pl|cellId|duration|`

### 118. Extend Cell (`ed`)
- **Direction**: Client -> Server
- **Format**: `ed|cellId`

### 119. Unlock Cell (`uc`)
- **Direction**: Client -> Server
- **Format**: `uc|cellId`

### 120. Cell Log (`ld`)
- **Direction**: Bidirectional
- **Client->Server**: `ld|cellId`
- **Server->Client**: `ld|...logData...|#`

### 121. Depot Menu (`dm`)
- **Direction**: Server -> Client
- **Format**: `dm|...depotData...|#`

---

## Quests

### 122. Quest Log Request (`ql`)
- **Direction**: Client -> Server
- **Format**: `ql`

### 123. Quest Log Data (`ql`)
- **Direction**: Server -> Client
- **Format**: `ql|...questData...|#`

### 124. Place List (`lp`)
- **Direction**: Server -> Client
- **Format**: `lp|count|questName|questState|npcName|npcI|npcJ|...repeat per quest...|#`
- **Purpose**: Quest markers/objectives.
- **Example**: `lp|1|Registration in Nizhneatom|1|Lieutenant Pilotkina|968|1512|0|...more quests...|#`

### 125. Finish Quest (`fq`)
- **Direction**: Server -> Client
- **Format**: `fq|...params...|#`

### 126. Place Respawn (`pr`)
- **Direction**: Bidirectional
- **Client->Server**: `pr`
- **Server->Client**: `pr|...params...|#`

---

## Player Management

### 127. Update User (`uu`)
- **Direction**: Server -> Client
- **Format**: `uu|sessionId|userId|login|level|maleVal|state|moveStack|isRunning|attackSide|i|j|mapLevel|lastI|lastJ|walkSpeed|runSpeed|hp|hpAll|clanId|clanName|clanUrl|hireClanId|hireClanName|hireClanUrl|hairView|helmetView|armorView|pantsView|bootsView|weaponView|bodyPal|hairPal|helmetPal|armorPal|pantsPal|bootsPal|weaponPal#`
- **Purpose**: Full player state update (same 37-field structure as `ul` entries).

### 128. Delete User (`du`)
- **Direction**: Server -> Client
- **Format**: `du|sessionId1|sessionId2|...|#`

### 129. Delete All (`da`)
- **Direction**: Server -> Client
- **Format**: `da#`
- **Purpose**: Clear all players from world.

### 130. Die Player (`dd`)
- **Direction**: Server -> Client
- **Format**: `dd|sessionId|killerSessionId#`

### 131. Respawn (`dt`)
- **Direction**: Server -> Client
- **Format**: `dt|...respawnData...|#`

---

## Terminal / Lobby

### 132. Enter Terminal (`et`)
- **Direction**: Server -> Client
- **Format**: `et|showWelcome#`
- **Purpose**: Switch to terminal/lobby view.

### 133. Terminal Exit (`ex`)
- **Direction**: Client -> Server
- **Format**: `ex`

### 134. Effect Update (`ex`)
- **Direction**: Server -> Client
- **Format**: `ex|effectCount|...effectData...|#`
- **Purpose**: Active effects/buffs update. (Shares command code with terminal exit; direction distinguishes them.)
- **Example**: `ex|32|-42|175|1|#`

### 135. Change Terminal (`tc`)
- **Direction**: Client -> Server
- **Format**: `tc|terminalId`

### 136. Terminal Error (`te`)
- **Direction**: Server -> Client
- **Format**: `te|...params...|#`

---

## Clan

### 137. Clan User List (`cl`)
- **Direction**: Server -> Client
- **Format**: `cl|sessionId|userId|login|level|clanId|clanName|clanUrl|hireClanId|hireClanName|hireClanUrl|...repeat...|#`
- **Purpose**: Full clan member list (10 fields per user).

### 138. Clan User Update (`cu`)
- **Direction**: Server -> Client
- **Format**: `cu|sessionId|userId|login|level|clanId|clanName|clanUrl|hireClanId|hireClanName|hireClanUrl#`

### 139. Clan User Delete (`cd`)
- **Direction**: Server -> Client
- **Format**: `cd|sessionId1|sessionId2|...|#`

### 140. Disconnect Clan (`dc`)
- **Direction**: Server -> Client
- **Format**: `dc#`

### 141. Clan Control (`co`)
- **Direction**: Bidirectional
- **Client->Server**: `co`
- **Server->Client**: `co|...clanControlData...|#`

### 142. Add Clan User (`au`)
- **Direction**: Client -> Server
- **Format**: `au|username`

### 143. Remove Clan User (`ru`)
- **Direction**: Client -> Server
- **Format**: `ru|userId`

### 144. Set User Position (`up`)
- **Direction**: Client -> Server
- **Format**: `up|userId|position`

### 145. Clan Add Accept/Reject (`ra`)
- **Direction**: Client -> Server
- **Format**: `ra|userId|1` (accept) or `ra|userId|0` (reject)

### 146. Delete Add Request (`dr`)
- **Direction**: Client -> Server
- **Format**: `dr|requestId`

### 147. Clan Request (`rc`)
- **Direction**: Server -> Client
- **Format**: `rc|...data...|#`

---

## Zones & Territories

### 148. Locations Request (`lr`)
- **Direction**: Bidirectional
- **Client->Server**: `lr`
- **Server->Client**: `lr|...locationData...|#`

### 149. Attack Zones List (`zl`)
- **Direction**: Bidirectional
- **Client->Server**: `zl`
- **Server->Client**: `zl|...zoneList...|#`

### 150. Zone Auction (`zr`)
- **Direction**: Client -> Server
- **Format**: `zr|zoneId|bid`

### 151. Available Zones (`az`)
- **Direction**: Bidirectional
- **Client->Server**: `az|`
- **Server->Client**: `az|...zoneData...|#`

### 152. Clan Zones (`zn`)
- **Direction**: Bidirectional
- **Client->Server**: `zn`
- **Server->Client**: `zn|...zoneData...|#`

### 153. Exit Zones (`za`)
- **Direction**: Bidirectional
- **Client->Server**: `za|`
- **Server->Client**: `za|...eventData...|#`

### 154. Attack Connect (`cz`)
- **Direction**: Client -> Server
- **Format**: `cz|zoneId|param2`

### 155. Attack Reject (`rz`)
- **Direction**: Client -> Server
- **Format**: `rz` or `rz|param`

### 156. Zone Failed (`zf`)
- **Direction**: Server -> Client
- **Format**: `zf#`

### 157. Zone Success (`zs`)
- **Direction**: Server -> Client
- **Format**: `zs#`

### 158. Zone Auction Update (`au`)
- **Direction**: Server -> Client
- **Format**: `au|...data...|#`

### 159. Zone Auction Delete (`an`)
- **Direction**: Server -> Client
- **Format**: `an|...data...|#`

---

## Events / Attacks

### 160. Event Added (`ea`)
- **Direction**: Server -> Client
- **Format**: `ea|count|...eventName|eventType|clan1|clan2|minLevel|maxLevel|time...|#`

### 161. Event Result (`er`)
- **Direction**: Server -> Client
- **Format**: `er|...resultData...|#`

### 162. Event Deleted (`ed`)
- **Direction**: Server -> Client
- **Format**: `ed|eventName#`

### 163. Attack Message (`ma`)
- **Direction**: Server -> Client
- **Format**: `ma|zoneName|clanName|time#`

### 164. Own Attack Message (`mz`)
- **Direction**: Server -> Client
- **Format**: `mz|zoneName|clanName|time#`

### 165. Event Chat Text (`vt`)
- **Direction**: Server -> Client
- **Format**: `vt|...text...|#`

---

## Raids

### 166. Raid Locations (`ry`)
- **Direction**: Bidirectional
- **Client->Server**: `ry`
- **Server->Client**: `ry|...raidLocData...|#`

### 167. Init Raid (`ri`)
- **Direction**: Bidirectional
- **Client->Server**: `ri|raidId|password`
- **Server->Client**: `ri|...data...|#`

### 168. Join Raid (`rj`)
- **Direction**: Bidirectional
- **Client->Server**: `rj|raidId|password`
- **Server->Client**: `rj|...data...|#`

### 169. Start Raid (`r4`)
- **Direction**: Client -> Server
- **Format**: `r4`

### 170. Raid Parties (`ro`)
- **Direction**: Bidirectional
- **Client->Server**: `ro`
- **Server->Client**: `ro|...partyData...|#`

### 171. Raid Party Update (`r1`)
- **Direction**: Server -> Client
- **Format**: `r1|...data...|#`

### 172. Raid Party Remove (`r2`)
- **Direction**: Server -> Client
- **Format**: `r2|...data...|#`

### 173. Raid Party Leave (`rx`)
- **Direction**: Client -> Server
- **Format**: `rx|memberId`

### 174. Stop Observe Raids (`r3`)
- **Direction**: Client -> Server
- **Format**: `r3`

---

## Crafting & Upgrades

### 175. Craft Request (`cf`)
- **Direction**: Client -> Server
- **Format**: `cf|recipeId`

### 176. Craft Recipes (`rk`)
- **Direction**: Bidirectional
- **Client->Server**: `rk`
- **Server->Client**: `rk|...recipeData...|#`

### 177. Upgrade Request (`iu`)
- **Direction**: Client -> Server
- **Format**: `iu|itemId|recipeId`

### 178. Upgrade Recipes (`rv`)
- **Direction**: Bidirectional
- **Client->Server**: `rv`
- **Server->Client**: `rv|...recipeData...|#`

### 179. Upgrade Groups (`ug`)
- **Direction**: Bidirectional
- **Client->Server**: `ug`
- **Server->Client**: `ug|...groupData...|#`

### 180. Menu Open (`mn`)
- **Direction**: Server -> Client
- **Format**: `mn|menuType|...menuData...|#`
- **Menu types**: Craft (24), Upgrade (25), Print (26)

---

## Repair & Heal

### 181. Repair Own (`rp`)
- **Direction**: Bidirectional
- **Client->Server**: `rp|itemId`
- **Server->Client**: `rp|...repairResult...|#`

### 182. Heal (`he`)
- **Direction**: Bidirectional
- **Client->Server**: `he|traumaId`
- **Server->Client**: `he|...healResult...|#`

### 183. Heal Failed (`hf`)
- **Direction**: Server -> Client
- **Format**: `hf#`

---

## Paid Services / Shop

### 184. Paid Services (`pd`)
- **Direction**: Bidirectional
- **Client->Server**: `pd`
- **Server->Client**: `pd|...servicesData...|#`

### 185. Paid Presents (`pp`)
- **Direction**: Bidirectional
- **Client->Server**: `pp`
- **Server->Client**: `pp|...presentsData...|#`

### 186. Paid Shop Items (`pi`)
- **Direction**: Bidirectional
- **Client->Server**: `pi`
- **Server->Client**: `pi|...shopData...|#`

### 187. Update Paid Services (`ud`)
- **Direction**: Server -> Client
- **Format**: `ud|...updateData...|#`

### 188. Pay Error (`pe`)
- **Direction**: Server -> Client
- **Format**: `pe#`

### 189. Change Paid Features (`cp`)
- **Direction**: Server -> Client
- **Format**: `cp|...params...|#`

### 190. Update Paid Values (`um`)
- **Direction**: Server -> Client
- **Format**: `um|...params...|#`

### 191. Service Active (`sa`)
- **Direction**: Client -> Server
- **Format**: `sa|serviceId|active|` (active = 0 or 1)

### 192. Service End (`es`)
- **Direction**: Server -> Client
- **Format**: `es|...params...|#`

### 193. Buy Hair (`bh`)
- **Direction**: Client -> Server
- **Format**: `bh|hairId|paletteId`

### 194. Buy Avatar (`pa`)
- **Direction**: Client -> Server
- **Format**: `pa|avatarId`

---

## Exchange / Auction

### 195. Exchange Start (`eh`)
- **Direction**: Bidirectional
- **Client->Server**: `eh`
- **Server->Client**: `eh|...exchangeData...|#`

### 196. Exchange Update (`eu`)
- **Direction**: Bidirectional
- **Client->Server**: `eu|param`
- **Server->Client**: `eu|...updateData...|#`

### 197. Add to Exchange (`ea`)
- **Direction**: Client -> Server
- **Format**: `ea|itemId|count`

### 198. Delete from Exchange (`er`)
- **Direction**: Client -> Server
- **Format**: `er`

### 199. Apply Exchange (`ee`)
- **Direction**: Client -> Server
- **Format**: `ee|param`

### 200. Exchange Processed (`ep`)
- **Direction**: Server -> Client
- **Format**: `ep#`

### 201. Exchange End (`en`)
- **Direction**: Server -> Client
- **Format**: `en#`

### 202. Own Exchange Added (`ae`)
- **Direction**: Server -> Client
- **Format**: `ae|...data...|#`

---

## Clan Hire

### 203. Clan Hire Request (`hy`)
- **Direction**: Bidirectional
- **Client->Server**: `hy|flag` (0 or 1)
- **Server->Client**: `hy|...hireData...|#`

### 204. Add Clan Hire (`ha`)
- **Direction**: Client -> Server
- **Format**: `ha|username`

### 205. Remove Hire By User (`hi`)
- **Direction**: Client -> Server
- **Format**: `hi|userId`

### 206. Remove Hire Request (`hr`)
- **Direction**: Client -> Server
- **Format**: `hr|requestId`

### 207. Hire Accept (`hb`)
- **Direction**: Client -> Server
- **Format**: `hb|userId`

### 208. Reject Hire (`hd`)
- **Direction**: Client -> Server
- **Format**: `hd|requestId`

### 209. Exit Hire (`hm`)
- **Direction**: Bidirectional
- **Client->Server**: `hm`
- **Server->Client**: `hm|...data...|#`

### 210. Private Hire (`ph`)
- **Direction**: Bidirectional
- **Client->Server**: `ph|param`
- **Server->Client**: `ph|...data...|#`

### 211. Add Private Hire (`hg`)
- **Direction**: Bidirectional
- **Client->Server**: `hg|param1|param2|param3|flag`
- **Server->Client**: `hg|...data...|#`

### 212. Private Hire Join (`hj`)
- **Direction**: Client -> Server
- **Format**: `hj|hireId`

### 213. Leave Private Hire (`hl`)
- **Direction**: Client -> Server
- **Format**: `hl|hireId`

### 214. Remove Private Hire (`hk`)
- **Direction**: Client -> Server
- **Format**: `hk|hireId`

### 215. My Hire Requests (`hn`)
- **Direction**: Client -> Server
- **Format**: `hn`

### 216. Show Hire Add (`hf`)
- **Direction**: Client -> Server
- **Format**: `hf`

### 217. Hire Users (`hu`)
- **Direction**: Server -> Client
- **Format**: `hu|...userData...|#`

### 218. Show Hire Info (`ho`)
- **Direction**: Client -> Server
- **Format**: `ho|hireId`

---

## Factory / Production

### 219. Factory Menu (`fm`)
- **Direction**: Server -> Client
- **Format**: `fm|...factoryData...|#`

### 220. Factory Update (`uf`)
- **Direction**: Server -> Client
- **Format**: `uf|...updateData...|#`

### 221. Factory Operations (`fo`)
- **Direction**: Client -> Server
- **Sub-commands** (first param):
  - `fo|0|managerName` - Set manager
  - `fo|1` - Delete manager
  - `fo|2` - Upgrade technology
  - `fo|3` - Upgrade device
  - `fo|4|recipeId|count` - Start production
  - `fo|5` - Stop production
  - `fo|6` - Clear crude
  - `fo|7` - Clear product
  - `fo|8` - Refill crude
  - `fo|9` - Product delivery

### 222. Production Ask (`pn`)
- **Direction**: Bidirectional
- **Client->Server**: `pn|1` (accept) or `pn|0` (reject)
- **Server->Client**: `pn|...data...|#`

### 223. Production Error (`pw`)
- **Direction**: Server -> Client
- **Format**: `pw|...params...|#`

---

## Map

### 224. Map Request (`mp`)
- **Direction**: Bidirectional
- **Client->Server**: `mp`
- **Server->Client**: `mp|...mapData...|#`

---

## Miscellaneous

### 225. Server Group (`sg`)
- **Direction**: Server -> Client
- **Format**: `sg|groupId|serverName|speed|scale|#`
- **Purpose**: Server configuration parameters (new in current version).
- **Example**: `sg|7|server|70|1.75000|#`

### 226. No Money (`me`)
- **Direction**: Server -> Client
- **Format**: `me#`

### 227. User Access Change (`ua`)
- **Direction**: Server -> Client
- **Format**: `ua|...params...|#`

### 228. Notify Client (`cs`)
- **Direction**: Server -> Client
- **Format**: `cs|...params...|#`

### 229. Referal Menu (`rm`)
- **Direction**: Bidirectional
- **Client->Server**: `rm`
- **Server->Client**: `rm|...data...|#`

### 230. Find User (`fu`)
- **Direction**: Bidirectional
- **Client->Server**: `fu|username`
- **Server->Client**: `fu|...userData...|#`

### 231. Radiolocation (`rr`)
- **Direction**: Bidirectional
- **Client->Server**: `rr`
- **Server->Client**: `rr|...data...|#`

### 232. Radiolocate (`rl`)
- **Direction**: Bidirectional
- **Client->Server**: `rl|target`
- **Server->Client**: `rl|...data...|#`

### 233. Multi-login (`mt`)
- **Direction**: Client -> Server
- **Format**: `mt|previousLogin`

### 234. Due Request (`de`)
- **Direction**: Bidirectional
- **Client->Server**: `de`
- **Server->Client**: `de|...dueData...|#`

### 235. Set Due (`sd`)
- **Direction**: Client -> Server
- **Format**: `sd|dueValue`

### 236. Process Due (`dm`)
- **Direction**: Client -> Server
- **Format**: `dm|dueId`

### 237. Pet Settings (`pb`)
- **Direction**: Client -> Server
- **Format**: `pb|name|param|autoHeal|agression|`

### 238. Pet Agression (`ag`)
- **Direction**: Client -> Server
- **Format**: `ag|agressionType`
- **Types**: 0=Total, 1=PvE, 2=PvP, 3=None

### 239. Auto State (`as`)
- **Direction**: Client -> Server
- **Format**: `as|flag` (0 or 1)

### 240. Stop Operation (`so`)
- **Direction**: Client -> Server
- **Format**: `so`

### 241. Fade (`fd`)
- **Direction**: Server -> Client
- **Format**: `fd|direction#`
- **Values**: `0` = fade in, `1` = fade out

### 242. Tutorial Highlight (`tl`)
- **Direction**: Server -> Client
- **Format**: `tl|elementId#`

### 243. Sapper Result (`sr`)
- **Direction**: Server -> Client
- **Format**: `sr|...data...|#`

### 244. Show Welcome (`sw`)
- **Direction**: Server -> Client
- **Format**: `sw#`

### 245. Item Autocollection (`ad`)
- **Direction**: Server -> Client
- **Format**: `ad|count|...itemName|itemCount...|#`

### 246. Give Item (`gi`)
- **Direction**: Server -> Client
- **Format**: `gi|itemName|count#`

### 247. Take Item (`ti`)
- **Direction**: Server -> Client
- **Format**: `ti|itemName|count#`

### 248. Medicine Use (`mu`)
- **Direction**: Server -> Client
- **Format**: `mu|itemName|hpHealed#`

### 249. Addon Change (`ca`)
- **Direction**: Server -> Client
- **Format**: `ca|...addonData...|#`

### 250. Addon Value (`av`)
- **Direction**: Server -> Client
- **Format**: `av|...value...|#`

### 251. Buff Delete (`bd`)
- **Direction**: Server -> Client
- **Format**: `bd|...params...|#`

### 252. Status Update (`su`)
- **Direction**: Server -> Client
- **Format**: `su|...params...|#`

### 253. War List (`wl`)
- **Direction**: Server -> Client
- **Format**: `wl|clanId1|clanId2|...|#`

### 254. Operation ID (`od`)
- **Direction**: Server -> Client
- **Format**: `od|...params...|#`

### 255. Start Expendable Use (`se`)
- **Direction**: Server -> Client
- **Format**: `se|...params...|#`

### 256. Can't Move Weight (`mw`)
- **Direction**: Server -> Client
- **Format**: `mw#`

### 257. Can't Run Weight (`rw`)
- **Direction**: Server -> Client
- **Format**: `rw#`

### 258. Can't Run Trauma (`rt`)
- **Direction**: Server -> Client
- **Format**: `rt#`

---

## New Version Commands (Current Client)

These commands are present in the new/current version but not in the old client:

### 259. Version Config (`0v`)
- **Direction**: Server -> Client
- **Format**: `0v|...numeric_params...|#`
- **Purpose**: Extended version/config values. Appears multiple times with varying parameter counts.

### 260. Gold Update (`0g`)
- **Direction**: Server -> Client
- **Format**: `0g|value#`

### 261. Money Update (`0m`)
- **Direction**: Server -> Client
- **Format**: `0m|value1|value2|#`

### 262. Server Config (`sg`)
- **Direction**: Server -> Client
- **Format**: `sg|groupId|serverLabel|tickRate|timeScale|#`

### 263. Service List (`ss`)
- **Direction**: Server -> Client
- **Format**: `ss|param1|param2#`

### 264. Numeric Command `17`
- **Direction**: Server -> Client
- **Format**: `17|emailOrUrl|#`
- **Purpose**: Server notification / redirect. May contain email/URL data.
- **Example**: `17|skip@skip.sp|#`

### 265. Marker/Flag `1e`
- **Direction**: Server -> Client
- **Format**: `1e|#`
- **Purpose**: Map/state marker or flag.

### 266. Additional numeric commands (`02`-`1g`)
- The new client defines a full range of two-character alphanumeric commands from `02` through `1g`. These appear to extend game state synchronization with additional config/parameter passing beyond what the old protocol supported.

---

## Complete Login Sequence (from traffic log)

```
1.  C->S: <policy-file-request/>\0
2.  S->C: <cross-domain-policy>...</cross-domain-policy>
3.  S->C: \0
4.  C->S: pg                              (ping)
5.  C->S: lg|Username|password|            (login attempt)
6.  S->C: lf|0#                           (login failed - wrong password)
7.  C->S: pg                              (ping)
8.  C->S: lg|Username|correctpass|         (login retry)
9.  S->C: 0v|9|5|9|23|...|#              (version config)
10. S->C: vh|5500|2994|109000|46|...|#    (base stats)
         ss|0|0#                          (services)
         0v|1|21|4396#                    (version config)
         0g|0#                            (gold)
         0m|0|0|#                         (money)
         ls#                              (start game)
11. C->S: eg                              (enter game)
12. S->C: 0v|1|5|9|#                      (version config update)
13. S->C: ch|...|#                         (character data)
         zc|...|#                         (zone info)
         vh|...|#                         (stats update)
         lg|...|#                         (full login data)
         nw|...|#                         (weapons)
         sb|...|#                         (background tiles)
         ul|...|#                         (user/NPC list)
         1e|#                             (marker)
         ol|...|#                         (object list)
         zc|...|#                         (zone change)
         lp|...|#                         (quest places)
         sg|...|#                         (server config)
         17|...|#                          (notification)
         ex|...|#                         (effects)
         0v|1|5|9|#                       (version)
         ss|0|0#                          (services)
14. C->S: pg (periodic pings)
15. C->S: mv|9717|4056                    (move request)
16. S->C: mv|160311|552|60|...|#          (move response)
17. S->C: ol|...|#                         (new objects appear)
18. S->C: do|214114|#                     (old objects removed)
19. C->S: rn                              (toggle run)
20. S->C: rn|160311#                      (run confirmed)
21. S->C: sb|...|#                         (background update)
22. S->C: bs|-1625|0|NPC dialogue text#   (NPC speech)
23. C->S: hd|1                            (switch weapon slot)
24. S->C: cv|...|#                         (appearance update)
         oe|1000#                         (cooldown)
         pu|160311|560|46#               (position update)
         hd|1#                            (hand confirmed)
25. C->S: iv                              (open inventory)
26. S->C: iv|...|#                         (inventory contents)
27. C->S: ia                              (inventory action)
28. S->C: ic#                             (inventory closed)
29. C->S: cm                              (character menu)
30. S->C: cm|...|#                         (character menu data)
```

---

## Data Type Notes

- **Session IDs**: Positive = real players, Negative = NPCs/bots
- **Coordinates**: Grid-based `i,j` system with pixel positions derived from isometric projection
- **Map levels**: Integer vertical levels (0 = ground)
- **Movement stack**: Digit string where each digit (0-7) represents a direction step
- **Appearance layers**: Body(0), Hair(1), Helmet(2), Armor(3), Pants(4), Boots(5), Weapon(6)
- **Background tiles**: Encoded in base-62 alphanumeric system (0-9, a-z, A-Z and special ranges)
- **Item durability**: Typically `current/max` expressed as integer values
- **Timestamps**: Server-relative, often in deciseconds (divide by 10 for seconds)
