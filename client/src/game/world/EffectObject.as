package game.world
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class EffectObject extends WorldItem
   {
      
      public static const STATE_FLY:int = 0;
      
      public static const STATE_EFFECT:int = 1;
      
      private static const ANGLE_TAN:Array = new Array(68,148,256,443,955);
      
      private static const ANGLE_FACTOR:int = 102 * 2;
      
      private static const ANGLE_COS:Array = new Array(0.9659258262890683,0.8660254037844386,0.7071067811865476,0.5,0.25881904510252074);
      
      public var startTime:int;
      
      public var flyTime:int;
      
      public var blowFlyTime:int;
      
      public var effectTime:int;
      
      public var lifeTime:int;
      
      public var animationNum:int;
      
      public var flyAnimations:int;
      
      public var effectAnimations:int;
      
      public var flyAnimationStartCycle:int;
      
      public var effectAnimationStartCycle:int;
      
      public var flyAnimationBmp:BitmapData;
      
      public var effectAnimationBmp:BitmapData;
      
      private var curentBitmap:Bitmap;
      
      private var curentBmpData:BitmapData;
      
      private var startIJPoint:IJPoint;
      
      private var endIJPoint:IJPoint;
      
      private var blowIJPOint:IJPoint;
      
      private var startY:int;
      
      private var endY:int;
      
      private var middleY:int;
      
      private var flySpriteOffset:NPoint;
      
      private var effectSpriteOffset:NPoint;
      
      private var isEffectCycled:Boolean;
      
      private var effectSound:int = -1;
      
      private var startLevel:int;
      
      private var blowLevel:int;
      
      private var blowLevelSpot:Boolean;
      
      private var blowMinY:int;
      
      private var speed:int;
      
      private var speedX:int;
      
      private var angleTan:int;
      
      private var angleFactor:int;
      
      private var angleCos:Number;
      
      private var fall:Boolean;
      
      public var state:int;
      
      public function EffectObject(param1:Sprite)
      {
         super(param1);
      }
      
      public function startThrowAnimation(param1:IJPoint, param2:IJPoint, param3:IJPoint, param4:int, param5:int, param6:int, param7:int, param8:Boolean, param9:BitmapData, param10:BitmapData, param11:int, param12:int, param13:int, param14:int, param15:int, param16:int, param17:int, param18:NPoint, param19:NPoint, param20:int = 0, param21:int = 0, param22:Boolean = false, param23:int = -1) : void
      {
         blowLevelSpot = false;
         muchLast = true;
         startTime = getTimer() - 100;
         startIJPoint = param1;
         endIJPoint = param2;
         blowIJPOint = param3;
         mapLevel = param4;
         angleTan = ANGLE_TAN[param7];
         angleFactor = ANGLE_FACTOR;
         this.fall = param8;
         this.speed = param6 * 35;
         angleCos = ANGLE_COS[param7] * ANGLE_COS[param7];
         this.speedX = this.speed * ANGLE_COS[param7];
         this.startLevel = param4;
         this.blowLevel = param5;
         this.effectSound = param23;
         this.startY = param15;
         this.middleY = param16;
         this.endY = param17;
         this.isEffectCycled = param22;
         this.flySpriteOffset = param18;
         this.effectSpriteOffset = param19;
         var endPosition:NPoint = getCoords(this.endIJPoint.i,this.endIJPoint.j);
         if(param8)
         {
            blowMinY = endPosition.y - cMapLevelHeight * param5;
         }
         else
         {
            blowMinY = endPosition.y - cMapLevelHeight * (param5 + 1);
         }
         flyAnimations = param11;
         effectAnimations = param12;
         flyAnimationStartCycle = param20;
         effectAnimationStartCycle = param21;
         if(param11 > 0)
         {
            flyAnimationBmp = param9;
            state = STATE_FLY;
         }
         else
         {
            if(param23 != -1)
            {
               world.playSound(param23,param1.i,param1.j);
            }
            state = STATE_EFFECT;
         }
         if(param12 > 0)
         {
            effectAnimationBmp = param10;
         }
         animationNum = 0;
         curentBitmap = null;
         this.flyTime = param13;
         this.effectTime = param14;
         lastI = param1.i;
         lastJ = param1.j;
         lifeTime = param13 + param14;
         this.process();
      }
      
      public function startEffectAnimation(param1:IJPoint, param2:int, param3:BitmapData, param4:int, param5:int, param6:NPoint, param7:int = 0, param8:Boolean = false) : void
      {
         muchLast = true;
         startTime = getTimer();
         endIJPoint = param1;
         mapLevel = param2;
         blowLevel = param2;
         this.endY = 0;
         this.isEffectCycled = param8;
         this.effectSpriteOffset = param6;
         effectAnimations = param4;
         effectAnimationStartCycle = param7;
         state = STATE_EFFECT;
         effectAnimationBmp = param3;
         animationNum = 0;
         curentBitmap = null;
         lifeTime = param5;
         this.setEffectPos();
         this.draw();
      }
      
      private function draw() : void
      {
         var frameWidth:int = 0;
         var animationBitmapData:BitmapData = null;
         var spriteOffset:NPoint = null;
         switch(this.state)
         {
            case STATE_FLY:
               frameWidth = this.flyAnimationBmp.width / this.flyAnimations;
               animationBitmapData = this.flyAnimationBmp;
               spriteOffset = this.flySpriteOffset;
               break;
            case STATE_EFFECT:
               frameWidth = this.effectAnimationBmp.width / this.effectAnimations;
               animationBitmapData = this.effectAnimationBmp;
               spriteOffset = this.effectSpriteOffset;
               break;
         }
         if(this.curentBitmap)
         {
            this.curentBmpData.lock();
            this.curentBmpData.copyPixels(animationBitmapData,new Rectangle(frameWidth * this.animationNum,0,frameWidth,animationBitmapData.height),new Point(0,0));
            this.curentBmpData.unlock();
         }
         else
         {
            curentBmpData = new BitmapData(frameWidth,animationBitmapData.height);
            this.curentBmpData.lock();
            this.curentBmpData.copyPixels(animationBitmapData,new Rectangle(frameWidth * this.animationNum,0,frameWidth,animationBitmapData.height),new Point(0,0));
            curentBitmap = new Bitmap(this.curentBmpData);
            addChild(this.curentBitmap);
            this.curentBmpData.unlock();
         }
         this.curentBitmap.x = -spriteOffset.x;
         this.curentBitmap.y = -spriteOffset.y;
      }
      
      public function free() : void
      {
         if(this.curentBmpData)
         {
            this.curentBmpData.dispose();
            this.curentBitmap.bitmapData.dispose();
         }
      }
      
      private function setBlowFlyPos() : void
      {
         var endPosition:NPoint = getCoords(this.blowIJPOint.i,this.blowIJPOint.j);
         x = endPosition.x;
         var deltaY:int = (this.flyTime * this.speedX * this.angleTan / 16384 - this.angleFactor * this.flyTime * this.flyTime / 1000) / 1000;
         y = endPosition.y - deltaY - cMapLevelHeight * this.startLevel;
         i = this.blowIJPOint.i;
         j = this.blowIJPOint.j;
         mapLevel = this.blowLevel;
      }
      
      private function setEffectPos() : void
      {
         var position:NPoint = getCoords(this.endIJPoint.i,this.endIJPoint.j);
         x = position.x;
         y = position.y;
         var cell:IJPoint = getIJCoords(x,y);
         i = cell.i;
         j = cell.j;
         lastI = i;
         lastJ = j;
         y -= cMapLevelHeight * this.blowLevel + this.endY;
         mapLevel = this.blowLevel;
      }
      
      private function setFlyPos(elapsed:int) : void
      {
         var startPosition:NPoint = getCoords(this.startIJPoint.i,this.startIJPoint.j);
         var endPosition:NPoint = getCoords(this.endIJPoint.i,this.endIJPoint.j);
         x = startPosition.x + (endPosition.x - startPosition.x) * elapsed / this.flyTime;
         var deltaY:int = (elapsed * this.speedX * this.angleTan / 16384 - this.angleFactor * elapsed * elapsed / 1000) / 1000;
         y = startPosition.y + (endPosition.y - startPosition.y) * elapsed / this.flyTime;
         var cell:IJPoint = getIJCoords(x,y);
         i = cell.i;
         j = cell.j;
         mapLevel = this.startLevel + (deltaY + 5 * cMapLevelHeight) / cMapLevelHeight - 5;
         if(y <= this.blowMinY)
         {
            blowLevelSpot = true;
         }
         y -= deltaY + cMapLevelHeight * this.startLevel;
      }
      
      private function endFly() : void
      {
         if(this.curentBitmap)
         {
            removeChild(this.curentBitmap);
            curentBitmap = null;
         }
         if(this.blowIJPOint.i != this.endIJPoint.i || this.blowIJPOint.j != this.endIJPoint.j)
         {
            this.setBlowFlyPos();
         }
         else
         {
            this.setEffectPos();
         }
         animationNum = 0;
         i = this.blowIJPOint.i;
         j = this.blowIJPOint.j;
         if(this.effectSound != -1)
         {
            world.playSound(this.effectSound,i,j);
         }
         state = STATE_EFFECT;
      }
      
      public function process() : void
      {
         var startCycle:int = 0;
         var animationCount:int = 0;
         var elapsed:int = getTimer() - this.startTime;
         if(elapsed >= this.flyTime && this.state == STATE_FLY)
         {
            this.endFly();
         }
         switch(this.state)
         {
            case STATE_FLY:
               this.setFlyPos(elapsed);
               startCycle = this.flyAnimationStartCycle;
               animationCount = this.flyAnimations;
               if(this.blowLevelSpot && y > this.blowMinY || !this.fall && y < this.blowMinY)
               {
                  this.endFly();
               }
               break;
            case STATE_EFFECT:
               startCycle = this.effectAnimationStartCycle;
               animationCount = this.effectAnimations;
               break;
         }
         ++this.animationNum;
         if(this.animationNum >= animationCount)
         {
            animationNum = startCycle;
         }
         this.draw();
      }
      
      override public function isAlive() : Boolean
      {
         if(this.isEffectCycled && this.startTime + this.lifeTime < getTimer() || !this.isEffectCycled && this.state == STATE_EFFECT && this.animationNum == this.effectAnimations - 1)
         {
            return false;
         }
         return true;
      }
   }
}

