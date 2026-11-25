package game
{
   import game.npc.PlayerItem;
   import ui.addons.Addon;
   import core.ui.BaseApplication;
   import game.world.*;
   import flash.display.*;
   import flash.geom.*;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   import ui.*;
   
   public class NuclearWorld extends World
   {
      
      public static var instance:NuclearWorld;
      
      public static const SOUND_DEATH:int = 0;
      
      public static const SOUND_DEATH_MEAT:int = 16;
      
      public static const SOUND_HEGRENADE:int = 2;
      
      public static const SOUND_FIREWORK_01:int = 18;
      
      public static const SOUND_SNOWBALL_HIT:int = 19;
      
      private static var GRENADE_PARAMS:Array = new Array({
         "flyAnim":"SPR_GRENADE",
         "effAnim":"SPR_EXPLOSION",
         "blowAnim":"SPR_EXPLOSION",
         "flyAnimCount":9,
         "effectAnimCount":29,
         "startY":30,
         "middleY":110,
         "endY":0,
         "flyOfsX":6,
         "flyOfsY":6,
         "blowEffOfsX":80,
         "blowEffOfsY":153,
         "effOfsX":80,
         "effOfsY":153,
         "sound":SOUND_HEGRENADE
      },{
         "flyAnim":"SPR_FIREWORK_BULLET",
         "effAnim":"SPR_FIREWORK_00",
         "blowAnim":"SPR_FIREWORK_00",
         "flyAnimCount":6,
         "effectAnimCount":16,
         "startY":30,
         "middleY":110,
         "endY":95,
         "flyOfsX":26,
         "flyOfsY":25,
         "blowEffOfsX":75,
         "blowEffOfsY":81,
         "effOfsX":75,
         "effOfsY":81,
         "sound":SOUND_FIREWORK_01
      },{
         "flyAnim":"SPR_FIREWORK_BULLET",
         "effAnim":"SPR_FIREWORK_01",
         "blowAnim":"SPR_FIREWORK_01",
         "flyAnimCount":6,
         "effectAnimCount":16,
         "startY":30,
         "middleY":110,
         "endY":95,
         "flyOfsX":26,
         "flyOfsY":25,
         "blowEffOfsX":79,
         "blowEffOfsY":85,
         "effOfsX":79,
         "effOfsY":85,
         "sound":SOUND_FIREWORK_01
      },{
         "flyAnim":"SPR_FIREWORK_BULLET",
         "effAnim":"SPR_FIREWORK_02",
         "blowAnim":"SPR_FIREWORK_02",
         "flyAnimCount":6,
         "effectAnimCount":18,
         "startY":30,
         "middleY":110,
         "endY":95,
         "flyOfsX":26,
         "flyOfsY":25,
         "blowEffOfsX":73,
         "blowEffOfsY":81,
         "effOfsX":73,
         "effOfsY":81,
         "sound":SOUND_FIREWORK_01
      },{
         "flyAnim":"SPR_SNOWBALL",
         "effAnim":"SPR_SNOWBALL_HIT",
         "blowAnim":"SPR_SNOWBALL_HIT",
         "flyAnimCount":3,
         "effectAnimCount":4,
         "startY":30,
         "middleY":110,
         "endY":0,
         "flyOfsX":3,
         "flyOfsY":2,
         "blowEffOfsX":16,
         "blowEffOfsY":11,
         "effOfsX":16,
         "effOfsY":11,
         "sound":SOUND_SNOWBALL_HIT
      });
      
      public static var MUSIC_MAIN:int = 0;
      
      public static var musicUrls:Array = new Array("main.mp3");
      
      public static var array101:Array = new Array([15,62,63],4,7,5,7,12,6,14,7,9,24,25,26,21,22,27,28,29,30,31,32,33,[35,36]);
      
      public static var array92:Array = new Array([15,62,63],5,7,5,8,12,23,14,13,9,24,25,26,21,22,27,28,29,30,31,32,34,[35,36]);
      
      public static var RUN_MAX:int = 1000000;
      
      private var grenadeBulletFly:BitmapData;
      
      private var grenadeBulletEffect:BitmapData;
      
      private var grenadeBulletBlowEffect:BitmapData;
      
      private var blowAnimations:Array = new Array();
      
      private var fogBitmapData:BitmapData;
      
      public var runVal:int = RUN_MAX;
      
      public var runAddValue:int;
      
      public var runSubValue:int;
      
      public var upPanelLeftLine:Object;
      
      public var upPanelDownLine:Object;
      
      public var addonLeftLine:Object;
      
      public var addonUpLine:Object;
      
      public var main:Main;
      
      public function NuclearWorld(param1:WorldView)
      {
         super(param1);
         this.main = Client.client as Main;
         var grenadeIndex:int = 0;
         while(grenadeIndex < GRENADE_PARAMS.length)
         {
            this.grenadeBulletFly = new NuclearMenu.uiContainer[GRENADE_PARAMS[grenadeIndex].flyAnim]().bitmapData;
            this.grenadeBulletEffect = new NuclearMenu.uiContainer[GRENADE_PARAMS[grenadeIndex].effAnim]().bitmapData;
            if(GRENADE_PARAMS[grenadeIndex].blowAnim == GRENADE_PARAMS[grenadeIndex].effAnim)
            {
               this.grenadeBulletBlowEffect = this.grenadeBulletEffect;
            }
            else
            {
               this.grenadeBulletBlowEffect = new NuclearMenu.uiContainer[GRENADE_PARAMS[grenadeIndex].blowAnim]().bitmapData;
            }
            this.blowAnimations.push({
               "fly":this.grenadeBulletFly,
               "effect":this.grenadeBulletEffect,
               "blow":this.grenadeBulletBlowEffect
            });
            grenadeIndex++;
         }
         this.upPanelLeftLine = {
            "x1":0,
            "y1":0,
            "x2":0,
            "y2":0
         };
         this.upPanelDownLine = {
            "x1":0,
            "y1":0,
            "x2":0,
            "y2":0
         };
         this.addonLeftLine = {
            "x1":0,
            "y1":0,
            "x2":0,
            "y2":0
         };
         this.addonUpLine = {
            "x1":0,
            "y1":0,
            "x2":0,
            "y2":0
         };
         arrowLinesYD.push({
            "x1":0,
            "y1":138,
            "x2":315,
            "y2":138
         });
         arrowLinesXR.push({
            "x1":315,
            "y1":138,
            "x2":315,
            "y2":30
         });
         arrowLinesYD.push({
            "x1":315,
            "y1":30,
            "x2":698,
            "y2":30
         });
         arrowLinesXR.push({
            "x1":698,
            "y1":30,
            "x2":698,
            "y2":0
         });
         arrowLinesXL.push(this.upPanelLeftLine);
         arrowLinesYD.push(this.upPanelDownLine);
         instance = this;
      }
      
      public function updateAddonLines() : void
      {
         var index:int = 0;
         index = 0;
         while(index < arrowLinesXL.length)
         {
            if(arrowLinesXL[index] == this.addonLeftLine)
            {
               arrowLinesXL.splice(index,1);
               break;
            }
            index++;
         }
         index = 0;
         while(index < arrowLinesYU.length)
         {
            if(arrowLinesYU[index] == this.addonUpLine)
            {
               arrowLinesYU.splice(index,1);
               break;
            }
            index++;
         }
         switch(this.main.nuclearChat.addonType)
         {
            case Addon.ADDON_LOCATOR:
               addonLeftLine = {
                  "x1":BaseApplication.stageWidth - 170,
                  "y1":this.main.nuclearChat.y,
                  "x2":BaseApplication.stageWidth - 170,
                  "y2":BaseApplication.stageHeight
               };
               addonUpLine = {
                  "x1":BaseApplication.stageWidth - 170,
                  "y1":this.main.nuclearChat.y,
                  "x2":BaseApplication.stageWidth,
                  "y2":this.main.nuclearChat.y
               };
               arrowLinesXL.push(this.addonLeftLine);
               arrowLinesYU.push(this.addonUpLine);
               break;
            case Addon.MINE_DETECTOR_1:
               addonLeftLine = {
                  "x1":BaseApplication.stageWidth - 136,
                  "y1":this.main.nuclearChat.y,
                  "x2":BaseApplication.stageWidth - 136,
                  "y2":BaseApplication.stageHeight
               };
               addonUpLine = {
                  "x1":BaseApplication.stageWidth - 136,
                  "y1":this.main.nuclearChat.y,
                  "x2":BaseApplication.stageWidth,
                  "y2":this.main.nuclearChat.y
               };
               arrowLinesXL.push(this.addonLeftLine);
               arrowLinesYU.push(this.addonUpLine);
               break;
         }
         updateArrows();
      }
      
      public function updatePanelLines() : void
      {
         this.updateAddonLines();
         this.upPanelLeftLine.x1 = BaseApplication.stageWidth - this.main.nuclearPanel.width;
         this.upPanelLeftLine.y1 = 0;
         this.upPanelLeftLine.x2 = BaseApplication.stageWidth - this.main.nuclearPanel.width;
         this.upPanelLeftLine.y2 = this.main.nuclearPanel.height;
         this.upPanelDownLine.x1 = BaseApplication.stageWidth - this.main.nuclearPanel.width;
         this.upPanelDownLine.y1 = this.main.nuclearPanel.height;
         this.upPanelDownLine.x2 = BaseApplication.stageWidth - 1;
         this.upPanelDownLine.y2 = this.main.nuclearPanel.height;
      }
      
      public function start() : void
      {
         lastTime = getTimer();
      }
      
      override public function processWorld(param1:int) : void
      {
         if(client.player)
         {
            if(client.player.running && client.player.state == PlayerItem.stMove)
            {
               runVal -= this.runSubValue * param1 / 50;
               if(this.runVal < 0)
               {
                  runVal = 0;
               }
               this.main.upPanel.setRun(this.runVal,RUN_MAX);
            }
            else if(this.runVal != RUN_MAX)
            {
               runVal += this.runAddValue * param1 / 50;
               if(this.runVal > RUN_MAX)
               {
                  runVal = RUN_MAX;
               }
               this.main.upPanel.setRun(this.runVal,RUN_MAX);
            }
         }
      }
      
      override public function moveCameraFor(param1:int, param2:int) : void
      {
         centerCameraOn(param1,param2,ChatPanel.instance.propValue139);
      }
      
      override public function moveCameraDirect(param1:int, param2:int) : void
      {
         centerCameraDirectOn(param1,param2,ChatPanel.instance.propValue139);
      }
      
      override protected function getFlyTextYOfset() : int
      {
         return 50;
      }
      
      override public function playerAttack(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int) : PlayerItem
      {
         var attacker:PlayerItem = super.playerAttack(param1,param2,param3,param4,param5,param6,param7,param8);
         playSound(this.getInt43(param7,param6),attacker.i,attacker.j);
         return attacker;
      }
      
      protected function getInt43(param1:int, param2:int) : int
      {
         var soundChoices:Array = param1 > 1 ? array92 : array101;
         if(soundChoices[param2] is int)
         {
            return soundChoices[param2];
         }
         if(soundChoices[param2] is Array)
         {
            return soundChoices[param2][int(Math.random() * soundChoices[param2].length)];
         }
         return 0;
      }
      
      override public function startEffect(param1:int, param2:int, param3:int, param4:int) : void
      {
         var effectObject:EffectObject = new EffectObject(this);
         addChild(effectObject);
         effectObject.startEffectAnimation(new IJPoint(param2,param3),param4,this.blowAnimations[0].effect,GRENADE_PARAMS[0].effectAnimCount,0,new NPoint(GRENADE_PARAMS[0].effOfsX,GRENADE_PARAMS[0].effOfsY));
         playSound(GRENADE_PARAMS[0].sound,param2,param3);
         effectObjects.push(effectObject);
      }
      
      public function addGranade(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int, param13:Boolean) : void
      {
         var effectObject:EffectObject = new EffectObject(this);
         addChild(effectObject);
         if(param6 == param4 && param7 == param5)
         {
            effectObject.startThrowAnimation(new IJPoint(param2,param3),new IJPoint(param4,param5),new IJPoint(param6,param7),param9,param10,param11,param12,param13,this.blowAnimations[param1].fly,this.blowAnimations[param1].effect,GRENADE_PARAMS[param1].flyAnimCount,GRENADE_PARAMS[param1].effectAnimCount,param8,0,GRENADE_PARAMS[param1].startY,GRENADE_PARAMS[param1].middleY,GRENADE_PARAMS[param1].endY,new NPoint(GRENADE_PARAMS[param1].flyOfsX,GRENADE_PARAMS[param1].flyOfsY),new NPoint(GRENADE_PARAMS[param1].effOfsX,GRENADE_PARAMS[param1].effOfsY),0,0,false,GRENADE_PARAMS[param1].sound);
         }
         else
         {
            effectObject.startThrowAnimation(new IJPoint(param2,param3),new IJPoint(param4,param5),new IJPoint(param6,param7),param9,param10,param11,param12,param13,this.blowAnimations[param1].fly,this.blowAnimations[param1].blow,GRENADE_PARAMS[param1].flyAnimCount,GRENADE_PARAMS[param1].effectAnimCount,param8,0,GRENADE_PARAMS[param1].startY,GRENADE_PARAMS[param1].middleY,GRENADE_PARAMS[param1].endY,new NPoint(GRENADE_PARAMS[param1].flyOfsX,GRENADE_PARAMS[param1].flyOfsY),new NPoint(GRENADE_PARAMS[param1].blowEffOfsX,GRENADE_PARAMS[param1].blowEffOfsY),0,0,false,GRENADE_PARAMS[param1].sound);
         }
         effectObjects.push(effectObject);
      }
      
      override public function createObject() : WorldObject
      {
         return new NuclearObject(this);
      }
   }
}

