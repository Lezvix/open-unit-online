package game
{
   import net.GameEventDispatcher;
   import net.Commands;
   import game.npc.PlayerItem;
   import core.ui.NUIController;
   import game.world.*;
   import flash.display.*;
   import flash.geom.*;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.utils.Dictionary;
   import flash.utils.clearInterval;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import ui.GameCursor;
   import ui.ChatPanel;
   
   public class World extends WorldBase
   {
      
      public static const ATTACK_CLAN_ZONE:int = 0;
      
      public static const ATTACK_PVP:int = 1;
      
      public static const ATTACK_PVE:int = 2;
      
      public static var SR_NO_MINE:int = 0;
      
      public static var SR_BLOW:int = 1;
      
      public static var SR_SUCCESS:int = 2;
      
      public static var HP_FLY_TICKS:int = 20;
      
      public static var HP_WAIT_TICKS:int = 3;
      
      public static var FILL_DELTA:int = 1000;
      
      public static var HP_ADD:int = 0;
      
      public static var HP_SUB:int = 1;
      
      public static var HP_CRITICAL:int = 2;
      
      public static var cVersion:String = "";
      
      public static var cIsHtml:Boolean = false;
      
      public static var cIsClient:Boolean = false;
      
      public static var curDir:int = PlayerItem.dirNone;
      
      public static var FOLLOW_PLAYER:int = 0;
      
      public static var FOLLOW_POSITION:int = 1;
      
      public static var resPacks:Array = new Array();
      
      public static var MAX_FLY_OBJECTS:uint = 20;
      
      public static var sprite7:Sprite;

      public static var MAX_OBJ_PROCESS_TIME:uint = 9;
      
      public static var MAX_LOAD_TIME:uint = 5;
      
      public static const MAX_DISTANCE:Number = 96;
      
      public static var loadObjectsFirst:WorldObject = null;
      
      public static var worldObject1:WorldObject = null;
      
      protected var client:Client;
      
      private var i:int;
      
      private var j:int;
      
      private var b:int;
      
      private var xy:int;
      
      private var xy1:int;
      
      private var wh:int;
      
      private var wh1:int;
      
      private var xx:int;
      
      private var yy:int;
      
      private var vis:int;
      
      private var tempMovie:Sprite;
      
      public var loadTime:uint;
      
      private var si:int;
      
      private var sj:int;
      
      private var obj35:Object;
      
      private var players_:Dictionary = new Dictionary();
      
      public function World(param1:WorldView)
      {
         super(param1);
         this.client = Client.client;
         this.upSprite = new Sprite();
         this.upSprite.y = -WorldItem.cMapLevelHeight;
         addChild(this.upSprite);
         this.str30 = Client.getString("IDS_EVADE");
         this.evadeText = Client.getString("IDS_MISS");
         this.mineSuccessText = Client.getString("IDS_MINE_MINE_SUCCESS");
         this.mineFailText = Client.getString("IDS_MINE_NO_MINE");
         mouseChildren = false;
         mouseEnabled = false;
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST1,this.doAction37);
      }

      public function get Players() : Dictionary
      {
         return this.players_;
      }

      public var lPlayer:PlayerItem;
      
      private var sortLen:int;
      
      public var curObj:ObjectItem;
      
      private var c:int;
      
      private var c1:int;
      
      private var c2:int;
      
      private var c3:int;
      
      private var cng:Boolean;
      
      private var clow:Boolean;
      
      private var chigh:Boolean;
      
      public var MAX_MOVE_DELTA:int = 500;
      
      public var moveToX:int = 0;
      
      public var moveToY:int = 0;
      
      public var followMode:int = FOLLOW_PLAYER;
      
      private var MAX_BG_COUNT:int = 600;
      
      private var bgBitmaps:Array = new Array(MAX_BG_COUNT);
      
      private var flyObjects:Array = new Array(MAX_FLY_OBJECTS);
      
      private var curFlyObject:uint = 0;
      
      public var hi:WorldObject = null;
      
      public var upSprite:Sprite;
      
      public var sortTime:int = 0;
      
      public var objData:Array = new Array();
      
      private var getData:Array = null;
      
      private var dataI:int = -1;
      
      private var dataJ:int = -1;
      
      private var objInProcess:Boolean = false;
      
      private var obj:WorldObject;
      
      public var questArrowSprite:Sprite;
      
      private var questArrowX:int;
      
      private var questArrowY:int;
      
      public var questI:int = 0;
      
      public var questJ:int = 0;
      
      private var questLevel:int = 0;
      
      private var lastPlayerX:int = -32000;
      
      private var lastPlayerY:int = -32000;
      
      private var upStairsBmp:Bitmap;
      
      private var downStairsBmp:Bitmap;
      
      private var stairsSprite:Sprite;
      
      private var stairPosX:int;
      
      private var stairPosY:int;
      
      private var arrowChanged:Boolean;
      
      protected var arrowLinesYU:Array = new Array();
      
      protected var arrowLinesXL:Array = new Array();
      
      protected var arrowLinesXR:Array = new Array();
      
      protected var arrowLinesYD:Array = new Array();
      
      private var str30:String;
      
      private var evadeText:String;
      
      private var mineSuccessText:String;
      
      private var mineFailText:String;
      
      public var userWeight:int;
      
      private var radioSound:Sound;
      
      private var radioSoundChannel:SoundChannel;
      
      private var lastHpObject:FlyText;
      
      private function doAction37(param1:Array) : void
      {
         var fieldIndex:int = 1;
         var playerId:int;
         var player:PlayerItem;
         while(fieldIndex < param1.length && param1[fieldIndex] != "")
         {
            playerId = param1[fieldIndex];
            player = this.getPlayer(playerId);
            if(player)
            {
               player.enabled = false;
            }
            fieldIndex++;
         }
      }
      
      override protected function initObjectItemManager() : void
      {
      }
      
      public function setQuestArrow(param1:Sprite, param2:Sprite, param3:Bitmap, param4:Bitmap, param5:int, param6:int) : void
      {
         questArrowSprite = param1;
         this.stairsSprite = param2;
         this.upStairsBmp = param3;
         this.downStairsBmp = param4;
         this.stairPosX = param5;
         this.stairPosY = param6;
         param3.visible = false;
         param4.visible = false;
      }
      
      public function resetQuestCoords() : void
      {
         questI = 0;
         questJ = 0;
         questLevel = 0;
         this.questArrowSprite.visible = false;
         this.stairsSprite.visible = false;
         this.upStairsBmp.visible = false;
         this.downStairsBmp.visible = false;
         lastPlayerX = -32000;
         lastPlayerY = -32000;
      }
      
      public function setQuestCoords(param1:int, param2:int, param3:int) : void
      {
         questI = param1;
         questJ = param2;
         questLevel = param3;
         this.questArrowSprite.visible = true;
         this.stairsSprite.visible = true;
         this.updateArrow();
      }
      
      public function updateArrow(param1:int = -1, param2:int = -1) : void
      {
         lastPlayerX = -32000;
         lastPlayerY = -32000;
         this.updateArrowsRotation();
         this.updateArrows(param1,param2);
         this.updateStairsSprite();
      }
      
      override public function playSound(param1:int, param2:int, param3:int) : void
      {
         var deltaI:int;
         var deltaJ:int;
         var offsetX:int;
         var offsetY:int;
         var pan:Number;
         var distance:Number;
         var soundKey:String = null;
         var sound:Sound = null;
         var soundTransform:SoundTransform = null;
         if(Client.settings.enableSounds)
         {
            deltaI = param2 - this.client.player.i;
            deltaJ = param3 - this.client.player.j;
            offsetX = deltaI + deltaJ;
            offsetY = deltaI - deltaJ;
            pan = 0;
            distance = Math.sqrt(offsetX * offsetX + offsetY * offsetY);
            if(offsetX != 0 || offsetY != 0)
            {
               pan = offsetX / distance;
            }
            soundKey = "SND_" + param1;
            if(soundKey in sprite7)
            {
               sound = new sprite7[soundKey]() as Sound;
               soundTransform = new SoundTransform((MAX_DISTANCE - distance) / MAX_DISTANCE * Client.settings.soundVolume,pan);
               sound.play(0,0,soundTransform);
            }
         }
      }
      
      public function playObjectSound(param1:int, param2:int, param3:int) : void
      {
         var soundObject:SoundObject = null;
         if(Client.settings.enableSounds)
         {
            soundObject = new SoundObject(param1,SoundObject.TYPE_ITEM_SOUND,0);
            soundObject.coordI = param2;
            soundObject.coordJ = param3;
         }
      }
      
      public function playMusic(param1:int) : void
      {
         SoundObject.currentMusicId = param1;
         if(Client.settings.enableMusic && !Client.settings.enableRadio)
         {
            SoundObject.startPlaying();
         }
      }
      
      public function findNearCorpse(param1:int, param2:int) : PlayerItem
      {
         var nearestDistanceSquared:uint = 1000000;
         var nearestPlayer:PlayerItem = null;
         var distanceSquared:uint;
         var player:PlayerItem;
         for each(player in this.players_)
         {
            if(player != this.client.player && player.state == PlayerItem.stDead && player.enabled)
            {
               distanceSquared = (player.x - param1) * (player.x - param1) + (player.y - param2) * (player.y - param2);
               if(distanceSquared < nearestDistanceSquared)
               {
                  nearestPlayer = player;
                  nearestDistanceSquared = distanceSquared;
               }
            }
         }
         return nearestPlayer;
      }
      
      public function findNearPlayer(param1:int, param2:int) : PlayerItem
      {
         var nearestDistanceSquared:uint = 1000000;
         var nearestPlayer:PlayerItem = null;
         var distanceSquared:uint;
         var player:PlayerItem;
         for each(player in this.players_)
         {
            if(player != this.client.player && player.state != PlayerItem.stDead)
            {
               distanceSquared = (player.x - param1) * (player.x - param1) + (player.y - param2) * (player.y - param2);
               if(distanceSquared < nearestDistanceSquared)
               {
                  nearestPlayer = player;
                  nearestDistanceSquared = distanceSquared;
               }
            }
         }
         return nearestPlayer;
      }
      
      override public function updateOfsX(param1:int) : void
      {
         var offsetDelta:int = worldXOfs - param1;
         var objectIndex:uint;
         var objectCount:uint = objects.length;
         var player:PlayerItem;
         objectIndex = 0;
         while(objectIndex < objectCount)
         {
            objects[objectIndex].x += offsetDelta;
            objectIndex++;
         }
         objectCount = tempObjects.length;
         objectIndex = 0;
         while(objectIndex < objectCount)
         {
            tempObjects[objectIndex].x += offsetDelta;
            objectIndex++;
         }
         for each(player in this.players_)
         {
            player.x += offsetDelta;
         }
         moveToX -= offsetDelta;
         x -= offsetDelta;
         worldXOfs = param1;
      }
      
      override public function updateOfsY(param1:int) : void
      {
         var offsetDelta:int = worldYOfs - param1;
         var objectIndex:uint;
         var objectCount:uint = objects.length;
         var player:PlayerItem;
         objectIndex = 0;
         while(objectIndex < objectCount)
         {
            objects[objectIndex].y += offsetDelta;
            objectIndex++;
         }
         objectCount = tempObjects.length;
         objectIndex = 0;
         while(objectIndex < objectCount)
         {
            tempObjects[objectIndex].y += offsetDelta;
            objectIndex++;
         }
         for each(player in this.players_)
         {
            player.y += offsetDelta;
         }
         moveToY -= offsetDelta;
         y -= offsetDelta;
         worldYOfs = param1;
      }
      
      public function createBackground(param1:Boolean, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:String) : void
      {
         var backgroundSprite:Sprite;
         var worldPosition:NPoint;
         this.parent.parent.opaqueBackground = 0;
         if(param1)
         {
            backgroundSprite = this.upSprite;
         }
         else
         {
            backgroundSprite = this;
         }
         if(((param4 + param5) * WorldItem.cJHCellSize > OFFSET_DELTA_X || worldXOfs > 0) && int(((param4 + param5) * WorldItem.cJHCellSize - OFFSET_DELTA_X) / OFFSET_CHANGE_X) != int(worldXOfs / OFFSET_CHANGE_X))
         {
            this.updateOfsX(int(((param4 + param5) * WorldItem.cJHCellSize - OFFSET_DELTA_X) / OFFSET_CHANGE_X) * OFFSET_CHANGE_X);
         }
         if(((param4 - param5) * WorldItem.cIHHCellSize > OFFSET_DELTA_Y || worldYOfs > 0) && int(((param4 - param5) * WorldItem.cIHHCellSize - OFFSET_DELTA_Y) / OFFSET_CHANGE_Y) != int(worldYOfs / OFFSET_CHANGE_Y))
         {
            this.updateOfsY(int(((param4 - param5) * WorldItem.cIHHCellSize - OFFSET_DELTA_Y) / OFFSET_CHANGE_Y) * OFFSET_CHANGE_Y);
         }
         if(((param4 - param5) * WorldItem.cIHHCellSize < -OFFSET_DELTA_Y || worldYOfs < 0) && int(((param4 - param5) * WorldItem.cIHHCellSize + OFFSET_DELTA_Y) / OFFSET_CHANGE_Y) != int(worldYOfs / OFFSET_CHANGE_Y))
         {
            this.updateOfsY(int(((param4 - param5) * WorldItem.cIHHCellSize + OFFSET_DELTA_Y) / OFFSET_CHANGE_Y) * OFFSET_CHANGE_Y);
         }
         this.mapHeight = param3;
         this.mapWidth = param2;
         var resourcePack:Sprite = resPacks[param8];
         graphics.clear();
         if(param1)
         {
            opaqueBackground = 2104598;
            graphics.beginFill(2104598);
         }
         else
         {
            opaqueBackground = 9142900;
            graphics.beginFill(9142900);
         }
         worldPosition = WorldItem.getCoords(param4,param5);
         graphics.drawRect(worldPosition.x - FILL_DELTA,worldPosition.y - FILL_DELTA - param2 * WorldItem.cIHHCellSize * 2,(param2 + param3) * WorldItem.cJHCellSize * 2 + 2 * FILL_DELTA,(param2 + param3) * WorldItem.cIHHCellSize * 2 + 2 * FILL_DELTA);
         graphics.endFill();
         this.upSprite.graphics.clear();
         var cellI:int;
         var cellJ:int;
         var rowDataIndex:int = 0;
         var tileDataIndex:int = 0;
         var columnOffset:int = 0;
         var tileId:int;
         var firstTileIds:Dictionary = new Dictionary();
         var secondTileIds:Dictionary = new Dictionary();
         cellI = param4;
         while(cellI < param4 + param7)
         {
            cellJ = param5;
            while(cellJ < param5 + param6)
            {
               if(param9.charAt(rowDataIndex) >= "a")
               {
                  tileId = int(param9.charCodeAt(rowDataIndex)) - 85;
               }
               else if(param9.charAt(rowDataIndex) >= "A")
               {
                  tileId = int(param9.charCodeAt(rowDataIndex)) - 27;
               }
               else
               {
                  tileId = int(param9.charCodeAt(rowDataIndex)) - 48;
               }
               if(param9.charAt(rowDataIndex + 1) >= "a")
               {
                  tileId = tileId << 6 | int(param9.charCodeAt(rowDataIndex + 1)) - 85;
               }
               else if(param9.charAt(rowDataIndex + 1) >= "A")
               {
                  tileId = tileId << 6 | int(param9.charCodeAt(rowDataIndex + 1)) - 27;
               }
               else
               {
                  tileId = tileId << 6 | int(param9.charCodeAt(rowDataIndex + 1)) - 48;
               }
               if(!this.bgBitmaps[tileId])
               {
                  imageClass = resourcePack["IMAGE_" + tileId];
                  this.bgBitmaps[tileId] = new imageClass();
               }
               if(int(cellI + cellJ & 7) == 0)
               {
                  firstTileIds[tileId] = tileId;
               }
               else
               {
                  secondTileIds[tileId] = tileId;
               }
               rowDataIndex += 2;
               cellJ += 4;
            }
            cellI += 4;
         }
         rowDataIndex = 0;
         var firstFillMatrix:Matrix = new Matrix();
         firstFillMatrix.tx = -WorldItem.cJHCellSize * 2;
         firstFillMatrix.ty = -WorldItem.cICellSize * 2;
         var secondFillMatrix:Matrix = new Matrix();
         var fillTileId:int;
         var firstTileEntry:Object;
         var secondTileEntry:Object;
         var imageClass:Class;
         secondFillMatrix.tx = WorldItem.cJHCellSize * 2;
         secondFillMatrix.ty = 0;
         for each(firstTileEntry in firstTileIds)
         {
            fillTileId = int(firstTileEntry);
            rowDataIndex = 0;
            backgroundSprite.graphics.beginBitmapFill(this.bgBitmaps[fillTileId].bitmapData,firstFillMatrix);
            cellI = param4;
            while(cellI < param4 + param7)
            {
               if(int(cellI & 7) == 0)
               {
                  tileDataIndex = rowDataIndex;
                  columnOffset = 0;
               }
               else
               {
                  tileDataIndex = rowDataIndex + 2;
                  columnOffset = 4;
               }
               cellJ = param5 + columnOffset;
               while(cellJ < param5 + param6)
               {
                  if(param9.charAt(tileDataIndex) >= "a")
                  {
                     tileId = int(param9.charCodeAt(tileDataIndex)) - 85;
                  }
                  else if(param9.charAt(tileDataIndex) >= "A")
                  {
                     tileId = int(param9.charCodeAt(tileDataIndex)) - 27;
                  }
                  else
                  {
                     tileId = int(param9.charCodeAt(tileDataIndex)) - 48;
                  }
                  if(param9.charAt(tileDataIndex + 1) >= "a")
                  {
                     tileId = tileId << 6 | int(param9.charCodeAt(tileDataIndex + 1)) - 85;
                  }
                  else if(param9.charAt(tileDataIndex + 1) >= "A")
                  {
                     tileId = tileId << 6 | int(param9.charCodeAt(tileDataIndex + 1)) - 27;
                  }
                  else
                  {
                     tileId = tileId << 6 | int(param9.charCodeAt(tileDataIndex + 1)) - 48;
                  }
                  if(tileId == fillTileId)
                  {
                     worldPosition = WorldItem.getCoords(cellI,cellJ);
                     backgroundSprite.graphics.drawRect(worldPosition.x - WorldItem.cJHCellSize * 2,worldPosition.y - WorldItem.cICellSize * 2,WorldItem.cJCellSize * 4,WorldItem.cICellSize * 4);
                  }
                  tileDataIndex += 4;
                  cellJ += 8;
               }
               rowDataIndex += param6 >> 1;
               cellI += 4;
            }
            backgroundSprite.graphics.endFill();
         }
         for each(secondTileEntry in secondTileIds)
         {
            fillTileId = int(secondTileEntry);
            rowDataIndex = 0;
            backgroundSprite.graphics.beginBitmapFill(this.bgBitmaps[fillTileId].bitmapData,secondFillMatrix);
            cellI = param4;
            while(cellI < param4 + param7)
            {
               if(int(cellI & 7) == 0)
               {
                  tileDataIndex = rowDataIndex + 2;
                  columnOffset = 4;
               }
               else
               {
                  tileDataIndex = rowDataIndex;
                  columnOffset = 0;
               }
               cellJ = param5 + columnOffset;
               while(cellJ < param5 + param6)
               {
                  if(param9.charAt(tileDataIndex) >= "a")
                  {
                     tileId = int(param9.charCodeAt(tileDataIndex)) - 85;
                  }
                  else if(param9.charAt(tileDataIndex) >= "A")
                  {
                     tileId = int(param9.charCodeAt(tileDataIndex)) - 27;
                  }
                  else
                  {
                     tileId = int(param9.charCodeAt(tileDataIndex)) - 48;
                  }
                  if(param9.charAt(tileDataIndex + 1) >= "a")
                  {
                     tileId = tileId << 6 | int(param9.charCodeAt(tileDataIndex + 1)) - 85;
                  }
                  else if(param9.charAt(tileDataIndex + 1) >= "A")
                  {
                     tileId = tileId << 6 | int(param9.charCodeAt(tileDataIndex + 1)) - 27;
                  }
                  else
                  {
                     tileId = tileId << 6 | int(param9.charCodeAt(tileDataIndex + 1)) - 48;
                  }
                  if(tileId == fillTileId)
                  {
                     worldPosition = WorldItem.getCoords(cellI,cellJ);
                     backgroundSprite.graphics.drawRect(worldPosition.x - WorldItem.cJHCellSize * 2,worldPosition.y - WorldItem.cICellSize * 2,WorldItem.cJCellSize * 4,WorldItem.cICellSize * 4);
                  }
                  tileDataIndex += 4;
                  cellJ += 8;
               }
               rowDataIndex += param6 >> 1;
               cellI += 4;
            }
            backgroundSprite.graphics.endFill();
         }
      }
      
      public function getPlayer(param1:int) : PlayerItem
      {
         return this.players_[param1];
      }
      
      public function getPlayerItem1(param1:int, param2:int) : PlayerItem
      {
         var candidate:PlayerItem = null;
         for each(candidate in this.players_)
         {
            if(candidate.isValue37 && candidate.i == param1 && candidate.j == param2)
            {
               return candidate;
            }
         }
         return null;
      }
      
      public function addItem(param1:PlayerItem) : void
      {
         if(param1.sessionId == this.client.sessionId)
         {
            this.client.gameStarted = true;
            intValue218 = param1.userId;
            lPlayer = param1;
            this.client.player = param1;
         }
         param1.dir = PlayerItem.dirDown;
         this.players_[param1.sessionId] = param1;
         param1.setCurDir();
         addChild(param1);
         param1.play();
         if(param1.state == PlayerItem.stDead)
         {
            param1.die(false,0);
            param1.stop();
            param1.play(param1.frames - 1);
         }
      }
      
      override public function addPlayer(param1:WorldEntity) : void
      {
         throw new Error();
      }
      
      public function addHp(param1:int, param2:int) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            targetPlayer.hp += param2;
            this.hpChange(targetPlayer,param2,HP_ADD);
         }
      }
      
      public function playerEffectIconShow(param1:int, param2:int) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            targetPlayer.addEffectIcon(param2);
         }
      }
      
      public function playerEffectIconHide(param1:int, param2:int) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            targetPlayer.removeEffectIcon(param2);
         }
      }
      
      public function stopPlayer(param1:int, param2:int, param3:int) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            targetPlayer.stopPlayer(param2,param3);
         }
      }
      
      public function playerUse(param1:int, param2:int, param3:int) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            targetPlayer.stopPlayer(param2,param3);
            targetPlayer.playerUse();
         }
      }
      
      public function playerUseTarget(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            targetPlayer.stopPlayer(param2,param3);
            targetPlayer.checkDirrection(targetPlayer.i,targetPlayer.j,param4,param5);
            targetPlayer.playerUse();
         }
      }
      
      public function playerSay(param1:int, param2:int, param3:String) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            targetPlayer.say(param3,param2);
         }
      }
      
      public function playerAttack(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int) : PlayerItem
      {
         var attacker:PlayerItem = this.getPlayer(param1);
         var coverObjects:Array;
         var coverObject:WorldObject;
         var coverCount:uint;
         var hiddenCount:uint;
         if(attacker)
         {
            coverObjects = null;
            attacker.attack(param2,param3,param4,param5,param7,param8);
            j = objects.length;
            while(this.j > 0)
            {
               coverObject = objects[this.j - 1];
               if(coverObject.canObjHide && coverObject.containsInHide(attacker) && (coverObject.visible && coverObject.mapLevel > attacker.mapLevel || attacker.mapLevel != this.lPlayer.mapLevel))
               {
                  attacker.setNotHide(true);
                  attacker.showOnTopTime = PlayerItem.HIDE_TIME;
                  coverObjects = null;
                  break;
               }
               if(coverObject.mapLevel > attacker.mapLevel && coverObject.containsInHide(attacker))
               {
                  if(coverObjects == null || coverObjects[0].mapLevel > coverObject.mapLevel)
                  {
                     coverObjects = new Array();
                  }
                  coverObjects.push(coverObject);
               }
               --this.j;
            }
            if(coverObjects != null && attacker.showOnTopTime != PlayerItem.HIDE_TIME)
            {
               coverCount = coverObjects.length;
               hiddenCount = hideItems.length;
               j = 0;
               while(this.j < coverCount)
               {
                  i = 0;
                  while(this.i < hiddenCount)
                  {
                     if(coverObjects[this.j] == hideItems[this.i] && coverObjects[this.j].visible)
                     {
                        attacker.setNotHide(true);
                        attacker.showOnTopTime = PlayerItem.HIDE_TIME;
                        return attacker;
                     }
                     ++this.i;
                  }
                  ++this.j;
               }
            }
         }
         return attacker;
      }
      
      public function setUpSprite() : void
      {
         setChildIndex(this.upSprite,getChildIndex(this.curObj));
      }
      
      override public function createObject() : WorldObject
      {
         return new ObjectItem(this);
      }
      
      public function addObject(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int, param13:int, param14:int, param15:int) : WorldObject
      {
         var newObject:ObjectItem = new ObjectItem(this);
         newObject.createObj(param1,param2,param3,param4,param5);
         newObject.setPos(param6,param7,new Rectangle(param9,param8,param11,param10),new Rectangle(param13,param12,param15,param14));
         tempObjects.push(newObject);
         curObj = newObject;
         return newObject;
      }
      
      public function addObjDecoImage(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:String) : void
      {
         this.curObj.addDecoImage(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function addObjAdvImage(param1:int, param2:int, param3:String, param4:String) : void
      {
         this.curObj.addAdvImage(param1,param2,param3,param4);
      }
      
      public function useObject(param1:int) : void
      {
         var objectCount:uint = objects.length;
         i = 0;
         while(this.i < objectCount)
         {
            if(objects[this.i].id == param1)
            {
               ObjectItem(objects[this.i]).useObject();
               break;
            }
            ++this.i;
         }
      }
      
      public function startUsingObject(param1:int, param2:int, param3:int, param4:int) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            targetPlayer.stopPlayer(param3,param4);
            if(targetPlayer.state != PlayerItem.stUsingObject)
            {
               targetPlayer.state = PlayerItem.stUsingObject;
            }
            else
            {
               targetPlayer.state = PlayerItem.stStand;
            }
         }
      }
      
      public function processObjData() : void
      {
         var message:String;
         var startTime:uint = getTimer();
         while((this.objData.length > 0 || this.objInProcess) && getTimer() - startTime < MAX_OBJ_PROCESS_TIME)
         {
            if(!this.objInProcess)
            {
               message = this.objData.shift();
               getData = message.split("|");
            }
            switch(this.getData[0])
            {
               case "ol":
                  if(this.client.socket.gameIsStarted)
                  {
                     if(!this.objInProcess)
                     {
                        dataI = 1;
                     }
                     while(this.dataI < this.getData.length - 1)
                     {
                        if(!this.objInProcess)
                        {
                           var objectDataStart:int = this.dataI;
                           obj = this.addObject(this.getData[this.dataI + 1],this.getData[this.dataI + 2],this.getData[this.dataI + 3],this.getData[this.dataI],this.getData[this.dataI + 4],this.getData[this.dataI + 5],this.getData[this.dataI + 6],this.getData[this.dataI + 7],this.getData[this.dataI + 8],this.getData[this.dataI + 9],this.getData[this.dataI + 10],this.getData[this.dataI + 11],this.getData[this.dataI + 12],this.getData[this.dataI + 13],this.getData[this.dataI + 14]);
                           if(this.obj.rect.width == -1 || this.obj.type != ObjectItem.otNone)
                           {
                              this.obj.bgRect = new Rectangle(this.obj.j + int(this.getData[this.dataI + 16]),this.obj.i + int(this.getData[this.dataI + 15]),int(this.getData[this.dataI + 18]),int(this.getData[this.dataI + 17]));
                              dataJ = this.getData[this.dataI + 19];
                              dataI += 20;
                           }
                           else
                           {
                              dataJ = this.getData[this.dataI + 15];
                              dataI += 16;
                           }
                        }
                        while(this.dataJ > 0)
                        {
                           if(getTimer() - startTime > MAX_OBJ_PROCESS_TIME)
                           {
                              objInProcess = true;
                              sortTime = MAX_OBJ_PROCESS_TIME;
                              return;
                           }
                           if(this.getData[this.dataI] == WorldObject.HIDE_ADVERTIZE)
                           {
                              this.addObjAdvImage(this.getData[this.dataI + 1],this.getData[this.dataI + 2],this.getData[this.dataI + 3],this.getData[this.dataI + 4]);
                              dataI += 5;
                           }
                           else
                           {
                              this.addObjDecoImage(this.getData[this.dataI + 1],this.getData[this.dataI + 2],this.getData[this.dataI + 3],this.getData[this.dataI + 4],this.getData[this.dataI],this.getData[this.dataI + 5],this.getData[this.dataI + 6]);
                              dataI += 7;
                           }
                           --this.dataJ;
                        }
                        this.obj.initState();
                        objInProcess = false;
                     }
                     if(this.getData.length > 2)
                     {
                        this.setUpSprite();
                     }
                     sortObj = true;
                     sortTime = getTimer() - startTime;
                  }
                  break;
               case "do":
                  if(this.client.socket.gameIsStarted)
                  {
                     i = 1;
                     while(this.i < this.getData.length - 1)
                     {
                        this.deleteObject(this.getData[this.i]);
                        ++this.i;
                     }
                     sortObj = true;
                  }
                  break;
            }
            objInProcess = false;
         }
      }
      
      public function placeRespawnHandler() : void
      {
         loadTime = getTimer() + MAX_LOAD_TIME;
         while(loadObjectsFirst && loadObjectsFirst.check24(this.loadTime))
         {
            loadObjectsFirst = loadObjectsFirst.worldObject2;
            if(loadObjectsFirst == null)
            {
               worldObject1 = null;
            }
         }
      }
      
      public function updatePointLine(param1:NPoint, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : void
      {
         var denominator:Number = (param7 - param5) * (param2 - param1.x) - (param6 - param4) * (param3 - param1.y);
         var firstFraction:Number;
         var secondFraction:Number;
         var intersectionX:int;
         var intersectionY:int;
         if(denominator != 0)
         {
            firstFraction = ((param6 - param4) * (param1.y - param5) - (param7 - param5) * (param1.x - param4)) / denominator;
            secondFraction = ((param2 - param1.x) * (param1.y - param5) - (param3 - param1.y) * (param1.x - param4)) / denominator;
            if(firstFraction >= 0 && firstFraction <= 1 && secondFraction >= 0 && secondFraction <= 1)
            {
               intersectionX = param1.x + firstFraction * (param2 - param1.x);
               intersectionY = param1.y + firstFraction * (param3 - param1.y);
               param1.x = intersectionX;
               param1.y = intersectionY;
            }
         }
      }
      
      public function updateArrowsRotation() : void
      {
         var playerX:int;
         var playerY:int;
         var questPosition:NPoint;
         if((this.questI != 0 || this.questJ != 0) && this.client.player && (this.lastPlayerX != this.client.player.x || this.lastPlayerY != this.client.player.y))
         {
            playerX = this.client.player.x + x;
            playerY = this.client.player.y + y;
            questPosition = WorldItem.getCoords(this.questI,this.questJ);
            questPosition.x += x;
            questPosition.y += y;
            if(questPosition.x == playerX && questPosition.y == playerY)
            {
               this.questArrowSprite.rotation = 180;
            }
            else
            {
               var angle:Number = Math.asin((playerY - questPosition.y) / Math.sqrt((questPosition.x - playerX) * (questPosition.x - playerX) + (questPosition.y - playerY) * (questPosition.y - playerY)));
               if(questPosition.x < playerX)
               {
                  this.questArrowSprite.rotation = angle * 180 / Math.PI - 90;
               }
               else
               {
                  this.questArrowSprite.rotation = -angle * 180 / Math.PI + 90;
               }
            }
            lastPlayerX = this.client.player.x;
            lastPlayerY = this.client.player.y;
            arrowChanged = true;
         }
      }
      
      public function updateStairsSprite() : void
      {
         var angleRadians:Number;
         if(this.arrowChanged && (this.questI != 0 || this.questJ != 0) && this.client.player)
         {
            if(this.client.player.mapLevel == this.questLevel)
            {
               this.upStairsBmp.visible = false;
               this.downStairsBmp.visible = false;
            }
            else
            {
               if(this.client.player.mapLevel > this.questLevel)
               {
                  this.upStairsBmp.visible = false;
                  this.downStairsBmp.visible = true;
               }
               else
               {
                  this.upStairsBmp.visible = true;
                  this.downStairsBmp.visible = false;
               }
               angleRadians = this.questArrowSprite.rotation * Math.PI / 180;
               this.stairsSprite.x = this.questArrowSprite.x + this.stairPosX * Math.cos(angleRadians) - this.stairPosY * Math.sin(angleRadians);
               this.stairsSprite.y = this.questArrowSprite.y + this.stairPosX * Math.sin(angleRadians) + this.stairPosY * Math.cos(angleRadians);
            }
         }
      }
      
      public function updateArrows(param1:int = -1, param2:int = -1) : void
      {
         var playerX:int = 0;
         var playerY:int = 0;
         var questPosition:NPoint = null;
         var chatHeight:int = 0;
         var lineIndex:int = 0;
         if((this.questI != 0 || this.questJ != 0) && this.client.player)
         {
            if(param1 == -1)
            {
               param1 = Math.min(Client.curWidth,Client.MAX_STAGE_WIDTH);
            }
            if(param2 == -1)
            {
               param2 = Math.min(Client.curHeight,Client.MAX_STAGE_HEIGHT);
            }
            playerX = this.client.player.x + x;
            playerY = this.client.player.y + y;
            questPosition = WorldItem.getCoords(this.questI,this.questJ);
            questPosition.x += x;
            questPosition.y += y - this.questLevel * WorldItem.cMapLevelHeight - 24;
            chatHeight = ChatPanel.instance.propValue139;
            if(playerX > 0)
            {
               this.updatePointLine(questPosition,playerX,playerY,this.questArrowSprite.parent.x,this.questArrowSprite.parent.y,this.questArrowSprite.parent.x,param2 - 1 - chatHeight);
            }
            if(playerY > 0)
            {
               this.updatePointLine(questPosition,playerX,playerY,this.questArrowSprite.parent.x,this.questArrowSprite.parent.y,this.questArrowSprite.parent.x + param1 - 1,this.questArrowSprite.parent.y);
            }
            if(playerX < param1 - 1)
            {
               this.updatePointLine(questPosition,playerX,playerY,this.questArrowSprite.parent.x + param1 - 1,this.questArrowSprite.parent.y,this.questArrowSprite.parent.x + param1 - 1,this.questArrowSprite.parent.y + param2 - 1 - chatHeight);
            }
            if(playerY < param2 - 1 - chatHeight)
            {
               this.updatePointLine(questPosition,playerX,playerY,this.questArrowSprite.parent.x,this.questArrowSprite.parent.y + param2 - 1 - chatHeight,this.questArrowSprite.parent.x + param1 - 1,this.questArrowSprite.parent.y + param2 - 1 - chatHeight);
            }
            lineIndex = 0;
            while(lineIndex < this.arrowLinesYD.length)
            {
               if(playerY > this.arrowLinesYD[lineIndex].y1)
               {
                  this.updatePointLine(questPosition,playerX,playerY,this.arrowLinesYD[lineIndex].x1,this.arrowLinesYD[lineIndex].y1,this.arrowLinesYD[lineIndex].x2,this.arrowLinesYD[lineIndex].y2);
               }
               lineIndex++;
            }
            lineIndex = 0;
            while(lineIndex < this.arrowLinesYU.length)
            {
               if(playerY < this.arrowLinesYU[lineIndex].y1)
               {
                  this.updatePointLine(questPosition,playerX,playerY,this.arrowLinesYU[lineIndex].x1,this.arrowLinesYU[lineIndex].y1,this.arrowLinesYU[lineIndex].x2,this.arrowLinesYU[lineIndex].y2);
               }
               lineIndex++;
            }
            lineIndex = 0;
            while(lineIndex < this.arrowLinesXR.length)
            {
               if(playerX > this.arrowLinesXR[lineIndex].x1)
               {
                  this.updatePointLine(questPosition,playerX,playerY,this.arrowLinesXR[lineIndex].x1,this.arrowLinesXR[lineIndex].y1,this.arrowLinesXR[lineIndex].x2,this.arrowLinesXR[lineIndex].y2);
               }
               lineIndex++;
            }
            lineIndex = 0;
            while(lineIndex < this.arrowLinesXL.length)
            {
               if(playerX < this.arrowLinesXL[lineIndex].x1)
               {
                  this.updatePointLine(questPosition,playerX,playerY,this.arrowLinesXL[lineIndex].x1,this.arrowLinesXL[lineIndex].y1,this.arrowLinesXL[lineIndex].x2,this.arrowLinesXL[lineIndex].y2);
               }
               lineIndex++;
            }
            this.questArrowSprite.x = questPosition.x - this.questArrowSprite.parent.x;
            this.questArrowSprite.y = questPosition.y - this.questArrowSprite.parent.y;
            arrowChanged = true;
         }
      }
      
      override public function process(param1:Boolean) : void
      {
         var currentPlayer:PlayerItem;
         var currentObject:WorldObject;
         deltaTime = getTimer() - lastTime;
         lastTime = getTimer();
         arrowChanged = false;
         this.updateArrowsRotation();
         if(x != this.moveToX || y != this.moveToY)
         {
            cameraStepX = (this.moveToX - x) * Math.min(deltaTime,200) / 200;
            x += cameraStepX;
            cameraStepY = (this.moveToY - y) * Math.min(deltaTime,200) / 200;
            y += cameraStepY;
            if(cameraStepX == 0)
            {
               moveToX = x;
            }
            if(cameraStepY == 0)
            {
               moveToY = y;
            }
            this.updateArrows();
         }
         this.updateStairsSprite();
         processWorld(deltaTime);
         PlayerItem.isGlobalSelected = false;
         PlayerItem.target = null;
         for each(currentPlayer in this.players_)
         {
            currentPlayer.processState(deltaTime);
            if(Math.abs(followPosition.x - currentPlayer.x) > 700 || Math.abs(followPosition.y - currentPlayer.y) > 700)
            {
               currentPlayer.forceRedrawValue = true;
            }
            else
            {
               currentPlayer.forceRedrawValue = false;
               currentPlayer.animate();
            }
         }
         if(NUIController.sharedController.overItemValue == null && ObjectItem.target != null)
         {
            if(ObjectItem.target.dImgs != null)
            {
               ObjectItem.target.setHighlight(0);
            }
            ObjectItem.target = null;
         }
         var globalMouse:Point = new Point();
         globalMouse.x = forcedMouseX < 0 ? stage.mouseX : forcedMouseX;
         globalMouse.y = forcedMouseY < 0 ? stage.mouseY : forcedMouseY;
         var localMouse:Point = new Point();
         var cameraStepX:int;
         var cameraStepY:int;
         i = objects.length - 1;
         while(this.i >= 0)
         {
            currentObject = objects[this.i];
            localMouse = currentObject.globalToLocal(globalMouse);
            currentObject.process(localMouse.x,localMouse.y,globalMouse.x,globalMouse.y);
            --this.i;
         }
         this.processEffects();
         this.processFlyText();
         if(NUIController.sharedController.overItemValue == null)
         {
            if(ObjectItem.target == null && PlayerItem.target == null)
            {
               NUIController.sharedController.cursorManager.cursorId = GameCursor.CURSOR_DEFAULT;
            }
            else
            {
               NUIController.sharedController.cursorManager.cursorId = GameCursor.CURSOR_1;
            }
         }
      }
      
      override public function processEffects() : void
      {
         var effectIndex:int = 0;
         while(effectIndex < effectObjects.length)
         {
            if(effectObjects[effectIndex].isAlive())
            {
               effectObjects[effectIndex].process();
            }
            else
            {
               this.delEffect(effectIndex);
               effectIndex--;
            }
            effectIndex++;
         }
      }
      
      override public function delEffect(param1:int) : void
      {
         effectObjects[param1].free();
         removeChild(effectObjects[param1]);
         effectObjects.splice(param1,1);
      }
      
      public function playerMove(param1:Array) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(int(param1[1]));
         if(targetPlayer)
         {
            targetPlayer.destI = param1[2];
            targetPlayer.destJ = param1[3];
            targetPlayer.i = targetPlayer.destI;
            targetPlayer.j = targetPlayer.destJ;
            targetPlayer.lastI = param1[4];
            targetPlayer.lastJ = param1[5];
            targetPlayer.moveTimeValue = param1[6];
            targetPlayer.loadMoveStack(param1[7]);
            targetPlayer.state = PlayerItem.stMove;
            targetPlayer.setCurDir();
         }
      }
      
      public function runPlayer(param1:int) : PlayerItem
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            targetPlayer.running = !targetPlayer.running;
            if(targetPlayer == this.lPlayer)
            {
               this.client.updateRun();
            }
         }
         return targetPlayer;
      }
      
      public function playerMoveDir(param1:Array) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(int(param1[1]));
         if(targetPlayer)
         {
            targetPlayer.stackTopValue = -1;
            targetPlayer.state = PlayerItem.stMove;
            targetPlayer.i = param1[2];
            targetPlayer.j = param1[3];
            targetPlayer.lastI = param1[4];
            targetPlayer.lastJ = param1[5];
            targetPlayer.setCurDir();
         }
      }
      
      public function diePlayer(param1:int, param2:int) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            targetPlayer.die(true,param2);
         }
      }
      
      private function processFlyText() : void
      {
         var flyObjectIndex:uint = 0;
         flyObjectIndex = 0;
         while(flyObjectIndex < MAX_FLY_OBJECTS)
         {
            if(this.flyObjects[flyObjectIndex] && this.flyObjects[flyObjectIndex].enabled)
            {
               this.flyObjects[flyObjectIndex].process();
            }
            flyObjectIndex++;
         }
      }
      
      protected function getFlyTextYOfset() : int
      {
         return 0;
      }
      
      public function hitPlayer(param1:int, param2:int, param3:int) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            targetPlayer.hit(param2,param3);
            this.hpChange(targetPlayer,param2,param3 != PlayerItem.MESSAGE_DEFAULT ? HP_CRITICAL : HP_SUB);
         }
      }
      
      public function redrawPlayers() : void
      {
         var currentPlayer:PlayerItem = null;
         for each(currentPlayer in this.players_)
         {
            currentPlayer.doAction545();
         }
      }
      
      public function evadePlayer(param1:int) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            if(this.flyObjects[this.curFlyObject])
            {
               this.flyObjects[this.curFlyObject].parentObject.removeChild(this.flyObjects[this.curFlyObject]);
            }
            this.flyObjects[this.curFlyObject] = new FlyText(targetPlayer,16759654,4402220,10);
            this.flyObjects[this.curFlyObject].init(this.evadeText,20);
            this.flyObjects[this.curFlyObject].y -= this.getFlyTextYOfset();
            targetPlayer.addChild(this.flyObjects[this.curFlyObject]);
            ++this.curFlyObject;
            if(this.curFlyObject >= MAX_FLY_OBJECTS)
            {
               curFlyObject = 0;
            }
         }
      }
      
      public function doAction265(param1:int) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            if(this.flyObjects[this.curFlyObject])
            {
               this.flyObjects[this.curFlyObject].parentObject.removeChild(this.flyObjects[this.curFlyObject]);
            }
            this.flyObjects[this.curFlyObject] = new FlyText(targetPlayer,16759654,4402220,10);
            this.flyObjects[this.curFlyObject].init(this.str30,20);
            this.flyObjects[this.curFlyObject].y -= this.getFlyTextYOfset();
            targetPlayer.addChild(this.flyObjects[this.curFlyObject]);
            ++this.curFlyObject;
            if(this.curFlyObject >= MAX_FLY_OBJECTS)
            {
               curFlyObject = 0;
            }
         }
      }
      
      public function sapperText(param1:int, param2:int) : void
      {
         var targetPlayer:PlayerItem = null;
         if(param2 != SR_BLOW)
         {
            targetPlayer = this.getPlayer(param1);
            if(targetPlayer)
            {
               if(this.flyObjects[this.curFlyObject])
               {
                  this.flyObjects[this.curFlyObject].parentObject.removeChild(this.flyObjects[this.curFlyObject]);
               }
               switch(param2)
               {
                  case SR_NO_MINE:
                     this.flyObjects[this.curFlyObject] = new FlyText(targetPlayer,16739378,5898240,10);
                     this.flyObjects[this.curFlyObject].init(this.mineFailText,20);
                     break;
                  case SR_SUCCESS:
                     this.flyObjects[this.curFlyObject] = new FlyText(targetPlayer,9094246,3032615,10);
                     this.flyObjects[this.curFlyObject].init(this.mineSuccessText,20);
                     break;
               }
               this.flyObjects[this.curFlyObject].y -= this.getFlyTextYOfset();
               targetPlayer.addChild(this.flyObjects[this.curFlyObject]);
               ++this.curFlyObject;
               if(this.curFlyObject >= MAX_FLY_OBJECTS)
               {
                  curFlyObject = 0;
               }
            }
         }
      }
      
      public function hpChange(param1:PlayerItem, param2:int, param3:int) : void
      {
         var delayTicks:int = 0;
         if(this.flyObjects[this.curFlyObject])
         {
            this.flyObjects[this.curFlyObject].parentObject.removeChild(this.flyObjects[this.curFlyObject]);
         }
         switch(param3)
         {
            case HP_ADD:
               delayTicks = 0;
               if(this.lastHpObject && this.lastHpObject.parentObject == param1 && this.lastHpObject.tick == HP_FLY_TICKS)
               {
                  delayTicks = HP_WAIT_TICKS;
               }
               this.flyObjects[this.curFlyObject] = new FlyText(param1,9094246,3032615,10);
               this.flyObjects[this.curFlyObject].init("+" + param2,HP_FLY_TICKS,delayTicks);
               break;
            case HP_SUB:
               this.flyObjects[this.curFlyObject] = new FlyText(param1,16759654,4402220,10);
               this.flyObjects[this.curFlyObject].init("-" + param2,HP_FLY_TICKS);
               break;
            case HP_CRITICAL:
               this.flyObjects[this.curFlyObject] = new FlyText(param1,16739378,5898240,10);
               this.flyObjects[this.curFlyObject].init("-" + param2,HP_FLY_TICKS);
               break;
         }
         this.flyObjects[this.curFlyObject].y -= this.getFlyTextYOfset();
         param1.addChild(this.flyObjects[this.curFlyObject]);
         lastHpObject = FlyText(this.flyObjects[this.curFlyObject]);
         ++this.curFlyObject;
         if(this.curFlyObject >= MAX_FLY_OBJECTS)
         {
            curFlyObject = 0;
         }
      }
      
      public function moveCameraForPosition() : void
      {
         this.moveCameraDirect(followPosition.x,followPosition.y);
      }
      
      public function moveCameraDirect(param1:int, param2:int) : void
      {
         this.centerCameraDirectOn(param1,param2);
      }
      
      public function centerCameraDirectOn(param1:int, param2:int, param3:int = 0) : void
      {
         var centerX:int = Client.curWidth / 2;
         var centerY:int = (Client.curHeight - param3) / 2;
         if(param2 - Client.curHeight / 2 < this.client.player.y - Client.MAX_STAGE_HEIGHT)
         {
            param2 = this.client.player.y - Client.MAX_STAGE_HEIGHT + Client.curHeight / 2;
         }
         if(param1 - Client.curWidth / 2 < this.client.player.x - Client.MAX_STAGE_WIDTH)
         {
            param1 = this.client.player.x - Client.MAX_STAGE_WIDTH + Client.curWidth / 2;
         }
         if(param2 + Client.curHeight / 2 > this.client.player.y + Client.MAX_STAGE_HEIGHT)
         {
            param2 = this.client.player.y + Client.MAX_STAGE_HEIGHT - Client.curHeight / 2;
         }
         if(param1 + Client.curWidth / 2 > this.client.player.x + Client.MAX_STAGE_WIDTH)
         {
            param1 = this.client.player.x + Client.MAX_STAGE_WIDTH - Client.curWidth / 2;
         }
         moveToX = Math.max(Math.min(centerX - param1,WorldItem.cJHCellSize * 2),-WorldItem.cJHCellSize * 2 * ((mapWidth + mapHeight >> 1) - 1) + Client.curWidth);
         moveToY = Math.max(Math.min(centerY - param2,WorldItem.cIHHCellSize * 2 * mapWidth),-WorldItem.cIHHCellSize * 2 * (mapHeight >> 1) + Client.curHeight - 160);
      }
      
      public function moveCameraFor(param1:int, param2:int) : void
      {
         this.centerCameraOn(param1,param2);
      }
      
      public function centerCameraOn(param1:int, param2:int, param3:int = 0) : void
      {
         followPosition.x = param1;
         followPosition.y = param2;
         var centerX:int = Client.curWidth / 2;
         var centerY:int = (Client.curHeight - param3 + 50) / 2;
         cMaxCameraXDelta = Client.curWidth / 9;
         cMaxCameraYDelta = (Client.curHeight - param3) / 7;
         moveToX = centerX - this.moveToX;
         moveToY = centerY - this.moveToY;
         if(Client.settings.fixedCamera)
         {
            moveToX = param1;
            moveToY = param2;
         }
         else
         {
            if(this.moveToX - param1 > cMaxCameraXDelta)
            {
               moveToX = param1 - cMaxCameraXDelta;
            }
            else if(param1 - this.moveToX > cMaxCameraXDelta)
            {
               moveToX = param1 + cMaxCameraXDelta;
            }
            if(this.moveToY - param2 > cMaxCameraYDelta)
            {
               moveToY = param2 - cMaxCameraYDelta;
            }
            else if(param2 - this.moveToY > cMaxCameraYDelta)
            {
               moveToY = param2 + cMaxCameraYDelta;
            }
         }
         moveToX = Math.max(Math.min(centerX - this.moveToX,WorldItem.cJHCellSize * 2),-WorldItem.cJHCellSize * 2 * ((mapWidth + mapHeight >> 1) - 1) + Client.curWidth);
         moveToY = Math.max(Math.min(centerY - this.moveToY,WorldItem.cIHHCellSize * 2 * mapWidth),-WorldItem.cIHHCellSize * 2 * (mapHeight >> 1) + Client.curHeight);
         if(Math.abs(x - this.moveToX) > Client.curWidth)
         {
            x = this.moveToX;
         }
         if(Math.abs(y - this.moveToY) > Client.curHeight)
         {
            y = this.moveToY;
         }
      }
      
      override public function deleteAll() : void
      {
         var worldObject:WorldObject = null;
         var playerItem:PlayerItem = null;
         var effectObject:EffectObject = null;
         while(tempObjects.length > 0)
         {
            worldObject = WorldObject(tempObjects.pop());
            removeChild(worldObject);
            worldObject.unloadMovies();
            worldObject.preDelete();
         }
         while(objects.length > 0)
         {
            worldObject = WorldObject(objects.pop());
            removeChild(worldObject);
            worldObject.unloadMovies();
            worldObject.preDelete();
         }
         while(effectObjects.length > 0)
         {
            effectObject = EffectObject(effectObjects.pop());
            removeChild(effectObject);
         }
         for each(playerItem in this.players_)
         {
            removeChild(playerItem);
            playerItem.dispose();
         }
         players_ = new Dictionary();
      }
      
      public function deleteObject(param1:int) : void
      {
         if(objects.length == 0)
         {
            return;
         }
         i = 0;
         j = objects.length - 1;
         while(this.j > this.i + 1)
         {
            if(objects[this.j + this.i >> 1].id < param1)
            {
               i = this.j + this.i >> 1;
            }
            else
            {
               j = this.j + this.i >> 1;
            }
         }
         if(objects[this.i].id < param1)
         {
            i = this.j;
         }
         if(objects[this.i].id == param1)
         {
            removeChild(objects[this.i]);
            objects[this.i].unloadMovies();
            objects[this.i].preDelete();
            delete objects[this.i];
            objects.splice(this.i,1);
            return;
         }
         i = 0;
         var tempObjectCount:uint = tempObjects.length;
         while(this.i < tempObjectCount && tempObjects[this.i].id != param1)
         {
            ++this.i;
         }
         if(this.i < tempObjectCount)
         {
            removeChild(tempObjects[this.i]);
            tempObjects[this.i].unloadMovies();
            tempObjects[this.i].preDelete();
            delete tempObjects[this.i];
            tempObjects.splice(this.i,1);
            return;
         }
      }
      
      public function deletePlayer(param1:int) : void
      {
         var targetPlayer:PlayerItem = this.getPlayer(param1);
         if(targetPlayer)
         {
            if(PlayerItem.isGlobalSelected && targetPlayer == PlayerItem.target)
            {
               PlayerItem.isGlobalSelected = false;
            }
            if(PlayerItem.selectedTarget == targetPlayer)
            {
               PlayerItem.selectedTarget = null;
            }
            if(this.client.clickedUser == targetPlayer)
            {
               clearInterval(this.client.useMenuInterval);
               this.client.clickedUser = null;
            }
            removeChild(targetPlayer);
            delete this.players_[param1];
            targetPlayer.dispose();
         }
      }
      
      public function sortObjects() : void
      {
         var startTime:uint = getTimer();
         while(tempObjects.length > 0)
         {
            currentObject = tempObjects.pop();
            if(objects.length > 0 && objects[0].depth > currentObject.depth)
            {
               objects.splice(0,0,currentObject);
            }
            else if(objects.length > 0 && objects[objects.length - 1].depth < currentObject.depth)
            {
               objects.push(currentObject);
            }
            else
            {
               i = 0;
               j = objects.length - 1;
               while(this.j > this.i + 1)
               {
                  if(objects[this.j + this.i >> 1].depth > currentObject.depth)
                  {
                     j = this.j + this.i >> 1;
                  }
                  else
                  {
                     i = this.j + this.i >> 1;
                  }
               }
               if(this.j < this.i)
               {
                  objects.splice(0,0,currentObject);
               }
               else if(this.j == this.i && objects[this.i].depth < currentObject.depth)
               {
                  objects.push(currentObject);
               }
               else
               {
                  objects.splice(this.j,0,currentObject);
               }
            }
         }
         var currentObject:WorldObject;
         var firstForegroundIndex:int = 0;
         var lastObjectIndex:int = objects.length - 1;
         i = 0;
         while(this.i < lastObjectIndex)
         {
            if(firstForegroundIndex == 0 && !objects[this.i].isBackground && objects[this.i].mapLevel == this.client.player.mapLevel)
            {
               firstForegroundIndex = this.i;
            }
            setChildIndex(objects[this.i],this.i);
            ++this.i;
         }
         sortTime = 0;
         if(tempObjects.length == 0)
         {
            sortObj = false;
         }
      }
      
      override public function sortView() : void
      {
         var outerIndex:int;
         var scanIndex:int;
         var childIndexA:int;
         var childIndexB:int;
         var unusedObject:Object;
         var sortValue:int;
         var firstPlayer:PlayerItem;
         var secondPlayer:PlayerItem;
         var currentObject:ObjectItem;
         if(sortObj)
         {
            this.sortObjects();
            sortObj = false;
         }
         hideItem = null;
         hideItems.length = 0;
         var playerIds:Vector.<int> = new Vector.<int>();
         var insideHiddenArea:Boolean;
         var hiddenAreaLevel:int;
         for each(firstPlayer in this.players_)
         {
            playerIds.push(firstPlayer.sessionId);
         }
         sortValue = objects.length - 1;
         outerIndex = 0;
         while(outerIndex < playerIds.length)
         {
            firstPlayer = this.players_[playerIds[outerIndex]];
            scanIndex = sortValue;
            while(scanIndex >= 0)
            {
               if(objects[scanIndex].isPlayerNear(firstPlayer) > 0 || firstPlayer.showOnTopTime > 0)
               {
                  break;
               }
               scanIndex--;
            }
            if(scanIndex == -1)
            {
               setChildIndex(firstPlayer,0);
            }
            else
            {
               childIndexA = getChildIndex(firstPlayer);
               if(scanIndex < sortValue && childIndexA > (childIndexB = getChildIndex(objects[scanIndex + 1])))
               {
                  setChildIndex(firstPlayer,childIndexB);
               }
               else if(childIndexA < (childIndexB = getChildIndex(objects[scanIndex])))
               {
                  setChildIndex(firstPlayer,childIndexB);
               }
            }
            outerIndex++;
         }
         scanIndex = objects.length - 1;
         while(scanIndex >= 0)
         {
            if(objects[scanIndex].rect.width == -1 && objects[scanIndex].mapLevel > this.lPlayer.mapLevel && (hideItem == null || hideItem.mapLevel >= objects[scanIndex].mapLevel) && objects[scanIndex].containsInHide(this.lPlayer))
            {
               if(hideItem == null || hideItem.mapLevel > objects[scanIndex].mapLevel)
               {
                  hideItem = objects[scanIndex];
                  hideItems.length = 0;
               }
               hideItems.push(objects[scanIndex]);
            }
            scanIndex--;
         }
         outerIndex = 0;
         while(outerIndex < playerIds.length - 1)
         {
            firstPlayer = this.players_[playerIds[outerIndex]];
            scanIndex = outerIndex + 1;
            while(scanIndex < playerIds.length)
            {
               secondPlayer = this.players_[playerIds[scanIndex]];
               sortValue = firstPlayer.isPlayerNear(secondPlayer);
               if(sortValue != 0)
               {
                  childIndexB = getChildIndex(firstPlayer);
                  childIndexA = getChildIndex(secondPlayer);
                  if(sortValue == 1 && childIndexB < childIndexA)
                  {
                     setChildIndex(firstPlayer,childIndexA);
                  }
                  else if(sortValue == -1 && childIndexB > childIndexA)
                  {
                     setChildIndex(secondPlayer,childIndexB);
                  }
               }
               scanIndex++;
            }
            outerIndex++;
         }
         if(hideItem != null)
         {
            scanIndex = 0;
            while(scanIndex < objects.length)
            {
               currentObject = objects[scanIndex] as ObjectItem;
               insideHiddenArea = false;
               outerIndex = 0;
               while(outerIndex < hideItems.length)
               {
                  if(hideItems[outerIndex].containsObjectInBg(currentObject))
                  {
                     insideHiddenArea = true;
                     hiddenAreaLevel = hideItems[outerIndex].mapLevel;
                  }
                  outerIndex++;
               }
               if(insideHiddenArea)
               {
                  if(currentObject.mapLevel >= hideItem.mapLevel)
                  {
                     currentObject.setNotHide(false);
                  }
                  else
                  {
                     currentObject.setNotHide(true);
                     if(currentObject.mapLevel >= this.lPlayer.mapLevel && currentObject.mapLevel < hiddenAreaLevel && currentObject.flag15)
                     {
                        currentObject.setHideDeco(true);
                     }
                     else if(currentObject.canObjHide)
                     {
                        if(currentObject.containsInHide(this.lPlayer) && currentObject.mapLevel >= this.lPlayer.mapLevel)
                        {
                           currentObject.setHideDeco(true);
                        }
                        else
                        {
                           currentObject.setHideDeco(false);
                        }
                     }
                  }
               }
               else
               {
                  currentObject.setNotHide(true);
                  if(currentObject.canObjHide)
                  {
                     currentObject.setHideDeco(currentObject.containsInHide(this.lPlayer));
                  }
               }
               scanIndex++;
            }
            scanIndex = 0;
            while(scanIndex < playerIds.length)
            {
               secondPlayer = this.players_[playerIds[scanIndex]];
               if(secondPlayer.showOnTopTime <= 0)
               {
                  outerIndex = 0;
                  while(outerIndex < hideItems.length && (hideItems[outerIndex].mapLevel != hideItem.mapLevel || secondPlayer.mapLevel < hideItems[outerIndex].mapLevel || !hideItems[outerIndex].containsInBg(secondPlayer)))
                  {
                     outerIndex++;
                  }
                  if(outerIndex < hideItems.length)
                  {
                     secondPlayer.setNotHide(false);
                  }
                  else
                  {
                     secondPlayer.setNotHide(true);
                  }
               }
               else
               {
                  secondPlayer.setNotHide(true);
               }
               scanIndex++;
            }
         }
         else
         {
            scanIndex = 0;
            while(scanIndex < objects.length)
            {
               currentObject = objects[scanIndex] as ObjectItem;
               currentObject.setNotHide(true);
               if(currentObject.canObjHide)
               {
                  if(currentObject.mapLevel == this.lPlayer.mapLevel && currentObject.containsInHide(this.lPlayer))
                  {
                     currentObject.setHideDeco(true);
                  }
                  else
                  {
                     currentObject.setHideDeco(false);
                  }
               }
               scanIndex++;
            }
            outerIndex = 0;
            while(outerIndex < playerIds.length)
            {
               this.players_[playerIds[outerIndex]].setNotHide(true);
               outerIndex++;
            }
         }
         outerIndex = 0;
         while(outerIndex < effectObjects.length)
         {
            scanIndex = objects.length - 1;
            while(scanIndex >= 0)
            {
               if(objects[scanIndex].isPlayerNear(effectObjects[outerIndex]) > 0)
               {
                  break;
               }
               scanIndex--;
            }
            if(scanIndex == -1)
            {
               setChildIndex(effectObjects[outerIndex],0);
            }
            else if(scanIndex < objects.length - 1 && getChildIndex(effectObjects[outerIndex]) > getChildIndex(objects[scanIndex + 1]))
            {
               setChildIndex(effectObjects[outerIndex],getChildIndex(objects[scanIndex + 1]));
            }
            else if(getChildIndex(effectObjects[outerIndex]) < getChildIndex(objects[scanIndex]))
            {
               setChildIndex(effectObjects[outerIndex],getChildIndex(objects[scanIndex]));
            }
            outerIndex++;
         }
      }
      
      public function updateMusic() : void
      {
         SoundObject.updateMusic();
      }
      
      public function updateMusicVolume() : void
      {
         SoundObject.updateMusicVolume();
      }
      
      public function startRadio() : void
      {
         Client.settings.enableRadio = true;
         SoundObject.startRadio();
      }
      
      public function stopRadio() : void
      {
         Client.settings.enableRadio = false;
         if(Client.settings.enableMusic)
         {
            SoundObject.startPlaying();
         }
         else
         {
            SoundObject.stopPlaying();
         }
      }
      
      public function updateRadioVolume() : void
      {
         SoundObject.updateRadioVolume();
      }
   }
}

