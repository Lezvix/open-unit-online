package game.npc
{
   import core.display.InkText;
   import core.ui.*;
   import game.world.WorldItem;
   import game.world.WorldBase;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.*;
   import flash.utils.getTimer;
   import game.*;
   import ui.NTextFormat;
   
   public class PlayerItem extends AnimatedSprite
   {
      
      public static const ATTACK_SIDE_NONE:int = 0;
      
      public static const ATTACK_SIDE_ATTACKER:int = 1;
      
      public static const ATTACK_SIDE_DEFENDER:int = 2;
      
      public static const ATTACK_SIDE_SPECTATOR:int = 3;
      
      public static const ATTACK_SIDE_4:int = 4;
      
      public static const ATTACK_SIDE_5:int = 5;
      
      public static const cHitAnimCount:int = 6;
      
      public static const ATTACK_SIDE_7:int = 7;
      
      public static const cAnimCount:int = 8;
      
      public static const ATTACK_SIDE_9:int = 9;
      
      public static const ATTACK_SIDE_10:int = 10;
      
      public static const GOLIATH_11:int = 11;
      
      public static const GOLIATH_6:int = 12;
      
      public static const GOLIATH_8:int = 13;
      
      public static const HIDE_TIME:int = 4000;
      
      public static const MESSAGE_DEFAULT:int = 0;
      
      public static const MESSAGE_AGRESSIVE:int = 1;
      
      public static const MESSAGE_FEAR:int = 2;
      
      public static const bsNone:int = 0;
      
      public static const bsBlood:int = 1;
      
      public static const MESSAGE_2:int = 2;
      
      public static const MESSAGE_3:int = 3;
      
      private static const array49:Array = [16777215,16735832,9089535,16777215];
      
      private static const array71:Array = [new TextStyle("Verdana",12,14934736),new TextStyle("Verdana",12,16746842),new TextStyle("Verdana",12,14934736)];
      
      private static const array112:Array = [0,2686976,0];
      
      public static const csStand:int = 0;
      
      public static const csMove:int = 1;
      
      public static const csDead:int = 2;
      
      public static const stMove:int = 0;
      
      public static const stStand:int = 1;
      
      public static const stHit:int = 2;
      
      public static const stUsingObject:int = 3;
      
      public static const stDead:int = 4;
      
      public static const stUse:int = 5;
      
      public static const dirDown:int = 0;
      
      public static const dirLeftDown:int = 1;
      
      public static const dirRightDown:int = 2;
      
      public static const dirLeft:int = 3;
      
      public static const dirRight:int = 4;
      
      public static const dirUp:int = 5;
      
      public static const dirLeftUp:int = 6;
      
      public static const dirRightUp:int = 7;
      
      public static const dirNone:int = 8;
      
      public static const ROTATE_DIRS:Array = [dirDown,dirRightDown,dirRight,dirRightUp,dirUp,dirLeftUp,dirLeft,dirLeftDown];
      
      protected static const down2:Array = ["DOWN","DOWN_LEFT","DOWN_RIGHT","LEFT","RIGHT","UP","UP_LEFT","UP_RIGHT"];
      
      protected static const array33:Array = [dirRightDown,dirDown,dirRight,dirLeftDown,dirRightUp,dirLeftUp,dirLeft,dirUp];
      
      [Embed(source="/assets/PlayerItem_UP_STAIR.png")]
      
      private static const UP_STAIR:Class;
      
      [Embed(source="/assets/PlayerItem_DOWN_STAIR.png")]
      
      private static const DOWN_STAIR:Class;
      
      [Embed(source="/assets/PlayerItem_IMG_34.png")]
      
      protected static var IMG_34:Class;
      
      protected static const bitmapData4:BitmapData = new IMG_34().bitmapData;
      
      [Embed(source="/assets/PlayerItem_IMG_36.png")]
      
      protected static var IMG_36:Class;
      
      protected static const bitmapData6:BitmapData = new IMG_36().bitmapData;
      
      [Embed(source="/assets/PlayerItem_IMG_1.png")]
      
      private static var IMG_1:Class;
      
      [Embed(source="/assets/PlayerItem_IMG_14.png")]
      
      private static var IMG_14:Class;
      
      [Embed(source="/assets/PlayerItem_IMG_30.png")]
      
      private static var IMG_30:Class;
      
      [Embed(source="/assets/PlayerItem_IMG_21.png")]
      
      private static var IMG_21:Class;
      
      [Embed(source="/assets/PlayerItem_IMG_32.png")]
      
      private static var IMG_32:Class;
      
      [Embed(source="/assets/PlayerItem_IMG_31.png")]
      
      private static var IMG_31:Class;
      
      private static const bitmap42:Bitmap = new IMG_1();
      
      private static const bitmap11:Bitmap = new IMG_14();
      
      private static const bitmap41:Bitmap = new IMG_30();
      
      private static const bitmap40:Bitmap = new IMG_21();
      
      private static const bitmap4:Bitmap = new IMG_32();
      
      private static const bitmap32:Bitmap = new IMG_31();
      
      private static const matrix15:Matrix = new Matrix(1,0,0,1,1,1);
      
      private static const matrix19:Matrix = new Matrix(1,0,0,1,1,0);
      
      private static const bitmap36:Bitmap = new UP_STAIR();
      
      private static const bitmap34:Bitmap = new DOWN_STAIR();
      
      private static const rect6:Rectangle = new Rectangle(0,0,bitmap36.width,bitmap36.height);
      
      private static var EFFECT_14_ICON:Class = Liveitem_EFFECT_14_ICON;
      
      private static var EFFECT_16_ICON:Class = Liveitem_EFFECT_16_ICON;
      
      private static var EFFECT_18_ICON:Class = Liveitem_EFFECT_18_ICON;
      
      private static var EFFECT_20_ICON:Class = Liveitem_EFFECT_20_ICON;
      
      private static var EFFECT_27_ICON:Class = Liveitem_EFFECT_27_ICON;
      
      private static var EFFECT_29_ICON:Class = Liveitem_EFFECT_29_ICON;
      
      private static var EFFECT_31_ICON:Class = Liveitem_EFFECT_31_ICON;
      
      private static var EFFECT_36_ICON:Class = Liveitem_EFFECT_36_ICON;
      
      private static var EFFECT_37_ICON:Class = Liveitem_EFFECT_37_ICON;
      
      private static const EFFECT_ICONS:Object = {};
      
      public static const PANTS_LAYER:uint = 0;
      
      public static const HAIR_LAYER:uint = 1;
      
      public static const WEAPON_LAYER:uint = 2;
      
      public static const WEAPON_3:uint = 3;
      
      public static const WEAPON_4:uint = 4;
      
      public static const BODY_5:uint = 5;
      
      public static const BODY_LAYER:uint = 6;
      
      public static const ANIMATION_7:uint = 7;
      
      private static const ANIMATION_FEMALE:int = 1;
      
      private static const ANIMATION_BOMZ:int = 2;
      
      private static const ANIMATION_DOG:int = 3;
      
      private static const ANIMATION_BUG:int = 4;
      
      private static const ANIMATION_LIZARD:int = 5;
      
      private static const ANIMATION_ALIEN:int = 6;
      
      private static const ANIMATION_ROBOT:int = 7;
      
      private static const ANIMATION_TARGET_A:int = 8;
      
      public static var isGlobalSelected:Boolean;

      public static var target:PlayerItem;

      public static var selectedTarget:PlayerItem = null;
      
      public static var selectedDObject:DisplayObject = null;
      
      private static const alphaArray:Array = new Array(256);
      
      private static const selectedArray:Array = new Array(256);
      
      private static const zeroArray:Array = new Array(256);
      
      public static const PLAYER_ITEM_CONST2:int = 0;
      
      public static const PLAYER_ITEM_CONST1:int = 1;
      
      protected static const colorTransform1:ColorTransform = new ColorTransform(1.8,1.8,1.8);
      
      private var _playerSessionId:int;
      
      private var _playerUserId:int;
      
      private var _playerLogin:String;
      
      private var _friendly:Boolean;
      
      private var _playerLevel:int;
      
      private var manualDir:int;
      
      private var bloodState:int;
      
      public var clanId:int;
      
      public var clanName:String;
      
      public var clanUrl:String;
      
      public var hireClanId:int;
      
      public var hireClanName:String;
      
      public var hireClanUrl:String;
      
      public var fraction:int = 0;
      
      public var isBackground:Boolean = false;
      
      protected var headAnchor:Shape;
      
      protected var sprite2:Sprite;
      
      private var _speed:int;
      
      private var walkSpeed:int;
      
      private var runSpeed:int;
      
      private var flag26:Boolean;
      
      protected var anim:int;
      
      private var hashDigits:Array = new Array(64);
      
      private var stackTop:int = -1;
      
      private var moveTime:int;
      
      private var intValue194:int;
      
      private var effectsSprite:Sprite;
      
      private var effectsList:Array = new Array();
      
      private var iter:int = 0;
      
      private var bitmap8:Bitmap = null;
      
      private var bitmap44:Bitmap = null;
      
      public const layerView:Vector.<int> = new Vector.<int>(ANIMATION_7,true);
      
      public const layerPal:Vector.<int> = new Vector.<int>(ANIMATION_7,true);
      
      private const bloodEffectList1:Vector.<BloodEffect> = new Vector.<BloodEffect>();
      
      protected var intValue156:int;
      
      private var inkText1:InkText;
      
      private var wordsText:InkText;
      
      private var sayTicks:int;
      
      private var lastState:int = -1;
      
      private var maleVal:int;
      
      private var allMoveTime:int;
      
      private var tanVal:int;
      
      public var mapLevel:int;
      
      public var i:int;
      
      public var j:int;
      
      public var lastI:int;
      
      public var lastJ:int;
      
      protected var world:NuclearWorld;
      
      public var tx:int;
      
      public var ty:int;
      
      private var flag138:Boolean = true;
      
      public function PlayerItem()
      {
         super();
         this.world = NuclearWorld.instance;
         this.headAnchor = new Shape();
         this.headAnchor.x = -25;
         addChild(this.headAnchor);
         this.sprite2 = new Sprite();
         addChildAt(this.sprite2,0);
         this.addShadow();
      }
      
      public static function createPals() : void
      {
         var index:int = 0;
         while(index < 256)
         {
            if(index < 2 || index > 250)
            {
               alphaArray[index] = 0;
               selectedArray[index] = 0;
            }
            else
            {
               alphaArray[index] = 4211081215;
               selectedArray[index] = 4211015680;
            }
            zeroArray[index] = 0;
            index++;
         }
         bitmap42.x = bitmap11.x = bitmap41.x = -27;
         bitmap42.y = bitmap11.y = bitmap41.y = -13;
         EFFECT_ICONS[14] = new EFFECT_14_ICON().bitmapData;
         EFFECT_ICONS[16] = new EFFECT_16_ICON().bitmapData;
         EFFECT_ICONS[18] = new EFFECT_18_ICON().bitmapData;
         EFFECT_ICONS[20] = new EFFECT_20_ICON().bitmapData;
         EFFECT_ICONS[27] = new EFFECT_27_ICON().bitmapData;
         EFFECT_ICONS[29] = new EFFECT_29_ICON().bitmapData;
         EFFECT_ICONS[31] = new EFFECT_31_ICON().bitmapData;
         EFFECT_ICONS[36] = new EFFECT_36_ICON().bitmapData;
         EFFECT_ICONS[37] = new EFFECT_37_ICON().bitmapData;
      }
      
      public static function create(param1:int) : PlayerItem
      {
         switch(param1)
         {
            case ATTACK_SIDE_NONE:
               return new ManPlayer();
            case ATTACK_SIDE_ATTACKER:
               return new WomanPlayer();
            case ATTACK_SIDE_DEFENDER:
               return new ActionNpc();
            case ATTACK_SIDE_SPECTATOR:
               return new Npc002();
            case ATTACK_SIDE_4:
               return new Npc003();
            case ATTACK_SIDE_5:
               return new Npc004();
            case cHitAnimCount:
               return new Npc005();
            case ATTACK_SIDE_7:
               return new Npc006();
            case cAnimCount:
               return new Npc007();
            case ATTACK_SIDE_9:
               return new Npc008();
            case ATTACK_SIDE_10:
               return new Npc009();
            case GOLIATH_11:
               return new Npc010();
            case GOLIATH_6:
               return new Goliath6();
            case GOLIATH_8:
               return new Goliath8();
            default:
               throw new Error();
         }
      }
      
      public static function getCoords(param1:int, param2:int) : Point
      {
         return new Point((param1 + param2) * WorldItem.cJHCellSize - WorldBase.worldXOfs,(param1 - param2) * WorldItem.cIHHCellSize - WorldBase.worldYOfs);
      }
      
      public static function getIJCoords(param1:Number, param2:Number) : Point
      {
         return new Point(((param2 + WorldBase.worldYOfs) * WorldItem.cMulFactor / WorldItem.cICellSize + (param1 + WorldItem.cJHCellSize + WorldBase.worldXOfs) * WorldItem.cMulFactor / WorldItem.cJCellSize) / WorldItem.cMulFactor,((param1 + WorldItem.cJHCellSize + WorldBase.worldXOfs) * WorldItem.cMulFactor / WorldItem.cJCellSize - (param2 + WorldBase.worldYOfs) * WorldItem.cMulFactor / WorldItem.cICellSize) / WorldItem.cMulFactor);
      }
      
      public function get enabled() : Boolean
      {
         return this.flag138;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         flag138 = param1;
         if(!param1 && selectedTarget == this)
         {
            this.removeSelectTarget();
            selectedTarget = null;
         }
      }
      
      protected function addShadow() : void
      {
         this.doAction275(bitmapData4,0,0);
      }
      
      protected function doAction275(param1:BitmapData, param2:int, param3:int) : void
      {
         this.sprite2.graphics.clear();
         matrix.identity();
         matrix.tx = param2 - param1.width >> 1;
         matrix.ty = param3 - param1.height >> 1;
         this.sprite2.graphics.beginBitmapFill(param1,matrix,false);
         this.sprite2.graphics.drawRect(matrix.tx,matrix.ty,param1.width,param1.height);
         this.sprite2.graphics.endFill();
      }
      
      protected function hideShadow() : void
      {
      }
      
      override public function dispose() : void
      {
         if(this.bitmap8 != null)
         {
            this.bitmap8.bitmapData.dispose();
         }
         super.dispose();
      }
      
      protected var _playerHighlight:int;

      public function get highlight() : int
      {
         return this._playerHighlight;
      }
      
      public function set highlight(param1:int) : void
      {
         _playerHighlight = param1;
         switch(param1)
         {
            case PLAYER_ITEM_CONST1:
               if(this.showOnTopTime > 0)
               {
                  point1.x = drawRect.x;
                  point1.y = drawRect.y;
                  bitmapData2.paletteMap(bitmapData2,drawRect,point1,zeroArray,zeroArray,zeroArray,selectedArray);
               }
               else
               {
                  bitmapData2.colorTransform(drawRect,colorTransform1);
               }
               break;
            case PLAYER_ITEM_CONST2:
            default:
               if(this.showOnTopTime > 0)
               {
                  point1.x = drawRect.x;
                  point1.y = drawRect.y;
                  bitmapData2.paletteMap(bitmapData2,drawRect,point1,zeroArray,zeroArray,zeroArray,alphaArray);
               }
               break;
         }
      }
      
      public function doAction545() : void
      {
         var textFormat:NTextFormat = null;
         if(this.sessionId > 0 && this.inkText1.text && Main.UserCharacter.userId != this.userId)
         {
            textFormat = NTextFormat.login.derive();
            if(this.fraction > 0)
            {
               textFormat.color = array49[this.fraction];
            }
            else if(Main.UserCharacter.clanId == this.clanId && this.clanId != 0 && this.clanId != -1 || Main.UserCharacter.hireClanId == this.clanId && this.clanId != 0 && this.clanId != -1 || Main.UserCharacter.clanId == this.hireClanId && this.hireClanId != 0 && this.hireClanId != -1)
            {
               textFormat.color = 8513102;
            }
            else if(Main.UserCharacter.check26(this.clanId))
            {
               textFormat.color = 16735832;
            }
            else
            {
               textFormat.color = array49[this.fraction];
            }
            this.inkText1.setTextFormat(textFormat.getTextStyle2(),this.fraction > 0 ? 0 : 3091753,TextFormatAlign.CENTER);
            this.inkText1.text = this.login;
         }
      }
      
      public function removeSelectTarget() : void
      {
         if(selectedDObject && this.sprite2.contains(selectedDObject))
         {
            this.sprite2.removeChild(selectedDObject);
         }
      }
      
      public function addSelectTarget(param1:Boolean) : void
      {
         if(this.state == stDead)
         {
            selectedDObject = bitmap41;
         }
         else
         {
            selectedDObject = param1 ? bitmap11 : bitmap42;
         }
         this.sprite2.addChild(selectedDObject);
      }
      
      public function get type() : int
      {
         throw new Error();
      }
      
      public function get sessionId() : int
      {
         return this._playerSessionId;
      }
      
      public function set sessionId(param1:int) : void
      {
         _playerSessionId = param1;
      }
      
      public function get userId() : int
      {
         return this._playerUserId;
      }
      
      public function set userId(param1:int) : void
      {
         _playerUserId = param1;
      }
      
      public function get login() : String
      {
         return this._playerLogin;
      }
      
      public function set login(param1:String) : void
      {
         _playerLogin = param1;
         if(this.inkText1 != null)
         {
            throw new Error();
         }
         inkText1 = new InkText(120,20);
         this.inkText1.x = -60;
         this.inkText1.y = this.headAnchor.y - this.inkText1.height;
         var textFormat:NTextFormat = NTextFormat.login.derive();
         if(this.fraction > 0)
         {
            textFormat.color = array49[this.fraction];
         }
         else if(this.sessionId > 0)
         {
            if((Main.UserCharacter.clanId == this.clanId && this.clanId != 0 && this.clanId != -1 || Main.UserCharacter.hireClanId == this.clanId && this.clanId != 0 && this.clanId != -1 || Main.UserCharacter.clanId == this.hireClanId && this.hireClanId != 0 && this.hireClanId != -1) && Main.UserCharacter.userId != this.userId)
            {
               textFormat.color = 8513102;
            }
            else if(Main.UserCharacter.check26(this.clanId))
            {
               textFormat.color = 16735832;
            }
            else
            {
               textFormat.color = array49[this.fraction];
            }
         }
         else
         {
            textFormat.color = 16759654;
         }
         this.inkText1.setTextFormat(textFormat.getTextStyle2(),this.sessionId > 0 || this.fraction > 0 ? 0 : 3091753,TextFormatAlign.CENTER);
         this.inkText1.text = this._playerLogin;
         this.inkText1.cacheAsBitmap = true;
         this.inkText1.mouseChildren = false;
         this.inkText1.mouseEnabled = false;
         addChild(this.inkText1);
      }
      
      public function get friendly() : Boolean
      {
         return this._friendly;
      }
      
      public function set friendly(param1:Boolean) : void
      {
         _friendly = param1;
      }
      
      public function get level() : int
      {
         return this._playerLevel;
      }
      
      public function set level(param1:int) : void
      {
         _playerLevel = param1;
      }
      
      public function get state() : int
      {
         return this.lastState;
      }
      
      public function get isValue37() : Boolean
      {
         return this.lastState != stDead;
      }
      
      public function set state(param1:int) : void
      {
         if(this.lastState != param1)
         {
            if(this.lastState == stDead)
            {
               enabled = true;
            }
            lastState = param1;
            isBackground = param1 == stDead;
            this.update();
         }
      }
      
      private var forceRedraw:Boolean = false;

      private var flag140:Boolean = false;

      public function get forceRedrawValue() : Boolean
      {
         return this.forceRedraw;
      }
      
      public function set forceRedrawValue(param1:Boolean) : void
      {
         if(this.forceRedraw != param1)
         {
            forceRedraw = !this.forceRedraw;
            visible = !this.forceRedraw && this.flag140;
         }
      }
      
      public function setNotHide(param1:Boolean) : void
      {
         if(this.flag140 != param1)
         {
            flag140 = !this.flag140;
            visible = !this.forceRedraw && this.flag140;
         }
      }
      
      public function update() : void
      {
      }
      
      protected function get propValue65() : String
      {
         return down2[this.dir];
      }
      
      override protected function animationCompleted() : void
      {
         switch(this.state)
         {
            case stUse:
            case stHit:
               state = stStand;
               break;
            case stDead:
               return;
            default:
               break;
         }
         super.animationCompleted();
      }
      
      public function loadMoveStack(param1:String) : void
      {
         stackTop = -1;
         while(this.stackTop < param1.length - 1)
         {
            stackTop += 1;
            this.hashDigits[this.stackTop] = parseInt(param1.charAt(this.stackTop),10);
         }
      }
      
      public function set speed(param1:int) : void
      {
         _speed = param1;
      }
      
      public function get speed() : int
      {
         return this._speed;
      }
      
      public function get running() : Boolean
      {
         return this.flag26;
      }
      
      public function set running(param1:Boolean) : void
      {
         if(this.flag26 != param1)
         {
            flag26 = param1;
            speed = param1 ? this.runSpeedValue : this.walkSpeedValue;
            if(this.state == stMove)
            {
               this.update();
            }
         }
      }
      
      public function set destI(param1:int) : void
      {
         maleVal = param1;
      }
      
      public function set destJ(param1:int) : void
      {
         allMoveTime = param1;
      }
      
      public function get destI() : int
      {
         return this.maleVal;
      }
      
      public function get destJ() : int
      {
         return this.allMoveTime;
      }
      
      private function startNextMove() : void
      {
         var directionCode:int = 0;
         var destination:Point = null;
         var stepDuration:int = 0;
         if(this.stackTop >= 0 && this.moveTime <= 0)
         {
            directionCode = this.hashDigits[this.stackTop];
            --this.stackTop;
            i = this.maleVal;
            j = this.allMoveTime;
            lastI = this.i;
            lastJ = this.j;
            destination = new Point(this.i,this.j);
            stepDuration = 0;
            switch(directionCode)
            {
               case dirLeft:
                  destination.offset(0,-2);
                  stepDuration = this.speed;
                  break;
               case dirRight:
                  destination.offset(0,2);
                  stepDuration = this.speed;
                  break;
               case dirUp:
                  destination.offset(-2,0);
                  stepDuration = this.speed;
                  break;
               case dirDown:
                  destination.offset(2,0);
                  stepDuration = this.speed;
                  break;
               case dirLeftDown:
                  destination.offset(2,-2);
                  stepDuration = this.speed * 10 / 7;
                  break;
               case dirLeftUp:
                  destination.offset(-2,-2);
                  stepDuration = this.speed * 10 / 7;
                  break;
               case dirRightDown:
                  destination.offset(2,2);
                  stepDuration = this.speed * 10 / 7;
                  break;
               case dirRightUp:
                  destination.offset(-2,2);
                  stepDuration = this.speed * 10 / 7;
                  break;
            }
            if(this.stackTop >= 0 || !this.world.getPlayerItem1(destination.x,destination.y))
            {
               maleVal = destination.x;
               allMoveTime = destination.y;
               moveTime += stepDuration;
               intValue194 = stepDuration;
            }
            dir = array33[directionCode];
         }
         else if(this.moveTimeValue <= 0)
         {
            moveTime = 0;
            state = stStand;
         }
      }
      
      public function stopPlayer(param1:int, param2:int) : void
      {
         stackTop = -1;
         i = param1;
         j = param2;
         if(this.state == stMove)
         {
            this.doAction432();
            state = stStand;
         }
      }
      
      public function checkDirrection(param1:int, param2:int, param3:int, param4:int) : void
      {
         var deltaI:int = param1 - param3;
         var deltaJ:int = param4 - param2;
         var slope:int;
         if(deltaJ == 0)
         {
            if(deltaI > 0)
            {
               dir = dirLeftUp;
            }
            else
            {
               dir = dirRightDown;
            }
         }
         else
         {
            slope = deltaI / deltaJ;
            if(deltaJ > 0)
            {
               if(slope > 2.41)
               {
                  dir = dirLeftUp;
               }
               else if(slope > 0.41)
               {
                  dir = dirUp;
               }
               else if(slope > -0.41)
               {
                  dir = dirRightUp;
               }
               else if(slope > -2.41)
               {
                  dir = dirRight;
               }
               else
               {
                  dir = dirRightDown;
               }
            }
            else if(slope > 2.41)
            {
               dir = dirRightDown;
            }
            else if(slope > 0.41)
            {
               dir = dirDown;
            }
            else if(slope > -0.41)
            {
               dir = dirLeftDown;
            }
            else if(slope > -2.41)
            {
               dir = dirLeft;
            }
            else
            {
               dir = dirLeftUp;
            }
         }
      }
      
      public function playerUse() : void
      {
         this.doAction432();
         state = stUse;
      }
      
      public function attack(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : void
      {
         i = param1;
         j = param2;
         anim = param5;
         this.doAction432();
         state = stHit;
         this.checkDirrection(param1,param2,param3,param4);
      }
      
      public function doAction432() : void
      {
         x = (this.i + this.j) * WorldItem.cJHCellSize - WorldBase.worldXOfs;
         y = (this.i - this.j) * WorldItem.cIHHCellSize - WorldBase.worldYOfs - WorldItem.cMapLevelHeight * this.mapLevel;
      }
      
      public function get dir() : int
      {
         return this.tanVal;
      }
      
      public function set dir(param1:int) : void
      {
         if(this.tanVal != param1)
         {
            tanVal = param1;
            this.update();
         }
      }
      
      public function get showOnTopTime() : int
      {
         return this.iter;
      }
      
      public function set showOnTopTime(param1:int) : void
      {
         iter = param1;
         var localPlayer:PlayerItem = this.world.lPlayer;
         if(localPlayer == null)
         {
            return;
         }
         if(this.userId != localPlayer.userId)
         {
            if(param1 > 0)
            {
               if(localPlayer.mapLevel != this.mapLevel)
               {
                  if(this.bitmap8 == null)
                  {
                     bitmap8 = new Bitmap(new BitmapData(rect6.width,rect6.height));
                  }
                  if(localPlayer.mapLevel > this.mapLevel)
                  {
                     if(this.bitmap8 != bitmap34)
                     {
                        bitmap44 = bitmap34;
                        this.bitmap8.bitmapData.copyPixels(this.bitmap44.bitmapData,rect6,point5);
                     }
                  }
                  else if(this.bitmap44 != bitmap36)
                  {
                     bitmap44 = bitmap36;
                     this.bitmap8.bitmapData.copyPixels(this.bitmap44.bitmapData,rect6,point5);
                  }
                  if(!contains(this.bitmap8))
                  {
                     this.bitmap8.x = 24;
                     this.bitmap8.y = -30;
                     addChild(this.bitmap8);
                  }
               }
               else if(this.bitmap8 != null && contains(this.bitmap8))
               {
                  removeChild(this.bitmap8);
               }
            }
            else if(this.bitmap8 != null && contains(this.bitmap8))
            {
               removeChild(this.bitmap8);
            }
         }
      }
      
      public function processState(deltaTime:int) : void
      {
         var position:Point = null;
         var lastPosition:Point = null;
         var cell:Point = null;
         if(this.wordsText != null && this.wordsText.visible && this.sayTicks < getTimer())
         {
            this.wordsText.visible = false;
         }
         if(this.iter > 0)
         {
            showOnTopTime -= deltaTime;
         }
         switch(this.state)
         {
            case stMove:
               moveTime -= deltaTime;
               this.startNextMove();
               lastPosition = getCoords(this.lastI,this.lastJ);
               position = getCoords(this.destI,this.destJ);
               ty = int(position.y + int((lastPosition.y - position.y) * this.moveTime / this.intValue194));
               tx = int(position.x + int((lastPosition.x - position.x) * this.moveTime / this.intValue194));
               cell = getIJCoords(this.tx,this.ty);
               i = cell.x;
               j = cell.y;
               break;
            default:
               moveTime -= deltaTime;
               if(this.moveTime < 0)
               {
                  moveTime = 0;
               }
               position = getCoords(this.i,this.j);
               ty = position.y;
               tx = position.x;
               break;
         }
         x = this.tx;
         y = this.ty - WorldItem.cMapLevelHeight * this.mapLevel;
         if(this.sessionId == Main.instance.sessionId)
         {
            if(this.state == stMove)
            {
               this.world.followMode = World.FOLLOW_PLAYER;
            }
            switch(this.world.followMode)
            {
               case World.FOLLOW_PLAYER:
                  this.world.moveCameraFor(this.tx,this.ty - WorldItem.cMapLevelHeight * this.mapLevel);
                  break;
               case World.FOLLOW_POSITION:
                  this.world.moveCameraForPosition();
                  break;
            }
         }
      }
      
      protected function updateEffectsSprite() : void
      {
         var index:int = 0;
         var icon:BitmapData = null;
         var iconWidth:int = 0;
         if(this.effectsSprite == null)
         {
            return;
         }
         this.effectsSprite.graphics.clear();
         if(this.effectsList.length > 0)
         {
            matrix.identity();
            index = 0;
            while(index < this.effectsList.length)
            {
               icon = EFFECT_ICONS[this.effectsList[index]];
               if(icon)
               {
                  iconWidth = icon.width;
                  matrix.tx = index * (iconWidth + 1);
                  this.effectsSprite.graphics.beginBitmapFill(icon,matrix,false);
                  this.effectsSprite.graphics.drawRect(matrix.tx,0,iconWidth,iconWidth);
                  this.effectsSprite.graphics.endFill();
               }
               index++;
            }
            this.effectsSprite.x = this.inkText1.textWidth / 2 + 2;
            this.effectsSprite.y = this.inkText1.y + 3;
            this.effectsSprite.visible = true;
         }
         else
         {
            this.effectsSprite.visible = false;
         }
      }
      
      public function addEffectIcon(param1:int) : void
      {
         if(this.effectsList.indexOf(param1) == -1)
         {
            this.effectsList.push(param1);
            if(this.effectsSprite == null)
            {
               effectsSprite = new Sprite();
               addChild(this.effectsSprite);
            }
            this.updateEffectsSprite();
         }
      }
      
      public function removeEffectIcon(param1:int) : void
      {
         var index:int = this.effectsList.indexOf(param1);
         if(index != -1)
         {
            this.effectsList.splice(index,1);
            this.updateEffectsSprite();
         }
      }
      
      public function setCurDir() : void
      {
         this.checkDirrection(this.lastI,this.lastJ,this.i,this.j);
      }
      
      public function isPlayerNear(param1:PlayerItem) : int
      {
         if(this.iter > 0 || this.mapLevel > param1.mapLevel && param1.iter <= 0)
         {
            return 1;
         }
         if(this.mapLevel < param1.mapLevel || param1.iter > 0)
         {
            return -1;
         }
         if(this.isBackground)
         {
            return param1.isBackground ? 0 : -1;
         }
         else if(this.i + this.j >= param1.i + param1.j - 2 && this.i + this.j <= param1.i + param1.j + 3)
         {
            if(param1.isBackground || this.i - this.j > param1.i - param1.j)
            {
               return 1;
            }
            if(this.i - this.j < param1.i - param1.j)
            {
               return -1;
            }
         }
         return 0;
      }
      
      public function get hp() : int
      {
         return this.manualDir;
      }
      
      public function set hp(param1:int) : void
      {
         if(this.manualDir != param1)
         {
            manualDir = Math.max(0,Math.min(param1,this.maxHp));
            this.doAction794();
         }
      }
      
      public function get maxHp() : int
      {
         return this.bloodState;
      }
      
      public function set maxHp(param1:int) : void
      {
         if(this.bloodState != param1)
         {
            bloodState = Math.max(param1,0);
            if(this.bloodState < this.hp)
            {
               hp = this.bloodState;
            }
            else
            {
               this.doAction794();
            }
         }
      }
      
      public function hit(param1:int, param2:int) : void
      {
         hp -= param1;
      }
      
      public function doAction332(param1:Array) : void
      {
         this.layerView[HAIR_LAYER] = int(param1[0]);
         this.layerView[WEAPON_4] = int(param1[1]);
         this.layerView[BODY_5] = int(param1[2]);
         this.layerView[WEAPON_LAYER] = int(param1[3]);
         this.layerView[WEAPON_3] = int(param1[4]);
         this.layerView[BODY_LAYER] = int(param1[5]);
         this.layerPal[PANTS_LAYER] = int(param1[6]);
         this.layerPal[HAIR_LAYER] = int(param1[7]);
         this.layerPal[WEAPON_4] = int(param1[8]);
         this.layerPal[BODY_5] = int(param1[9]);
         this.layerPal[WEAPON_LAYER] = int(param1[10]);
         this.layerPal[WEAPON_3] = int(param1[11]);
         this.layerPal[BODY_LAYER] = int(param1[12]);
         this.update();
      }
      
      public function say(param1:String, param2:int) : void
      {
         if(this.wordsText == null)
         {
            wordsText = new InkText(120,70,true);
            this.wordsText.x = -60;
            addChild(this.wordsText);
         }
         this.wordsText.setTextFormat(array71[param2],array112[param2],TextFormatAlign.CENTER);
         this.wordsText.text = param1;
         this.wordsText.y = this.inkText1.y - this.wordsText.textHeight;
         this.wordsText.visible = true;
         sayTicks = getTimer() + 7000;
      }
      
      override public function animate() : void
      {
         var index:int = 0;
         var effect:BloodEffect = null;
         super.animate();
         if(includesMouse() && NUIController.sharedController.overItemValue == null && this.sessionId != Main.instance.sessionId && this.enabled)
         {
            if(isGlobalSelected)
            {
               if(target.state == stDead && this.state != stDead)
               {
                  target.highlight = PLAYER_ITEM_CONST2;
               }
            }
            isGlobalSelected = true;
            target = this;
            highlight = PLAYER_ITEM_CONST1;
         }
         else
         {
            highlight = PLAYER_ITEM_CONST2;
         }
         if(this.bloodEffectList1.length > 0)
         {
            index = this.bloodEffectList1.length;
            while(index > 0)
            {
               effect = this.bloodEffectList1[--index];
               if(effect.isValue42)
               {
                  effect.animate();
               }
               else
               {
                  removeChild(effect);
                  effect.dispose();
                  this.bloodEffectList1.splice(index,1);
               }
            }
         }
      }
      
      protected function doAction960(param1:int) : void
      {
         var effect:BloodEffect = new BloodEffect(param1);
         addChild(effect);
         effect.play();
         this.bloodEffectList1.push(effect);
      }
      
      protected function get dieTypesCount() : int
      {
         return 1;
      }
      
      public function get stackTopValue() : int
      {
         return this.stackTop;
      }
      
      public function set stackTopValue(param1:int) : void
      {
         stackTop = param1;
      }
      
      public function get moveTimeValue() : int
      {
         return this.moveTime;
      }
      
      public function set moveTimeValue(param1:int) : void
      {
         moveTime = param1;
      }
      
      public function get walkSpeedValue() : int
      {
         return this.walkSpeed;
      }
      
      public function set walkSpeedValue(param1:int) : void
      {
         walkSpeed = param1;
      }
      
      public function get runSpeedValue() : int
      {
         return this.runSpeed;
      }
      
      public function set runSpeedValue(param1:int) : void
      {
         runSpeed = param1;
      }
      
      public function die(param1:Boolean, param2:int) : void
      {
         intValue156 = Math.max(0,Math.min(param2,this.dieTypesCount - 1));
         this.doAction238();
         this.headAnchor.visible = false;
         this.inkText1.visible = false;
         if(this.effectsSprite)
         {
            this.effectsSprite.visible = false;
         }
         if(param1)
         {
            this.doAction664();
         }
         if(selectedTarget == this)
         {
            this.removeSelectTarget();
            selectedTarget = null;
         }
      }
      
      protected function get deathSounds() : Array
      {
         return [NuclearWorld.SOUND_DEATH];
      }
      
      private function doAction664() : void
      {
         var sounds:Array = this.deathSounds;
         var soundId:int;
         if(sounds && sounds.length > 0)
         {
            soundId = sounds[int(Math.random() * sounds.length)];
            this.world.playSound(soundId,this.i,this.j);
         }
      }
      
      public function doAction238() : void
      {
         if(this.showOnTopTime > 0)
         {
            showOnTopTime = 1;
         }
         state = stDead;
         this.hideShadow();
      }
      
      private function doAction794() : void
      {
         this.headAnchor.graphics.clear();
         this.headAnchor.graphics.beginBitmapFill(bitmap4.bitmapData,matrix19);
         this.headAnchor.graphics.drawRect(1,0,48,4);
         this.headAnchor.graphics.beginBitmapFill(bitmap40.bitmapData);
         this.headAnchor.graphics.drawRect(50 - bitmap40.width,0,bitmap40.width,4);
         this.headAnchor.graphics.drawRect(0,0,bitmap40.width,4);
         this.headAnchor.graphics.beginBitmapFill(bitmap32.bitmapData,matrix15);
         this.headAnchor.graphics.drawRect(1,1,Math.max(this.hp,0) * 48 / Math.max(1,this.maxHp),2);
         this.headAnchor.graphics.endFill();
         this.headAnchor.width = 50;
         this.headAnchor.height = 4;
      }
   }
}

