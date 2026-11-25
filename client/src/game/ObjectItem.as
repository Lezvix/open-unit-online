package game
{
   import game.world.WorldObject;
   import game.world.MovieBitmap;
   import game.world.IJPoint;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class ObjectItem extends WorldObject
   {
      
      public static const otNone:String = "0";
      
      public static const otBox:String = "1";
      
      public static const otDoor:String = "2";
      
      public static const OBJECT_ITEM_CONST11:String = "3";
      
      public static const OBJECT_ITEM_CONST9:String = "4";
      
      public static const otRibdoor:String = "5";
      
      public static const OBJECT_ITEM_CONST2:String = "6";
      
      public static const OBJECT_ITEM_CONST4:String = "7";
      
      public static const OBJECT_ITEM_CONST3:String = "8";
      
      public static const OBJECT_ITEM_CONST7:String = "9";
      
      public static const otDialogObject:String = "10";
      
      public static const otDepodObject:String = "11";
      
      public static const otSoundObject:String = "12";
      
      public static const OBJECT_ITEM_CONST1:String = "13";
      
      public static const otResource:String = "14";
      
      public static const otFactory:String = "15";
      
      public static const otClanProductDepod:String = "16";
      
      public static const OBJECT_ITEM_CONST6:String = "17";
      
      public static const OBJECT_ITEM_CONST8:String = "18";
      
      public static const OBJECT_ITEM_CONST5:String = "19";
      
      public static const OBJECT_ITEM_CONST10:String = "20";
      
      public static const START_SOUND_21:String = "21";
      
      public static const START_SOUND_22:String = "22";
      
      public static const START_SOUND_23:String = "23";
      
      public static var START_SOUND_PAUSE:int = 5000;
      
      public static var cItemTree:int = 0;
      
      public static var target:ObjectItem;

      protected static const colorTransform3:ColorTransform = new ColorTransform(2,2,2);
      
      protected static const transformNormal:ColorTransform = new ColorTransform();
      
      public var advObjects:Array = null;
      
      private var client:Client;
      
      public function ObjectItem(param1:Sprite)
      {
         super(param1);
         this.client = Client.client;
      }
      
      protected function setLastAnim() : void
      {
         var animationIndex:int = 0;
         while(animationIndex < dAnimImgsArray.length)
         {
            MovieItem(dAnimImgsArray[animationIndex]).setLastAnim();
            animationIndex++;
         }
      }
      
      override public function initState() : void
      {
         if(type != otNone)
         {
            switch(type)
            {
               case otDoor:
               case otRibdoor:
               case otBox:
               case otDialogObject:
               case otDepodObject:
               case otResource:
               case otFactory:
               case otClanProductDepod:
                  cycled = false;
                  if(state == 0)
                  {
                     animationState = animateNone;
                  }
                  else
                  {
                     this.setLastAnim();
                     animationState = animateForward;
                  }
                  break;
            }
         }
      }
      
      public function createObj(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         doAction646(param1,param2,param3,param5.toString(),"");
         this.state = param4;
         if(this.type != otNone)
         {
            animationState = animateNone;
            isSpecialItem = true;
         }
         else
         {
            animationState = animateForward;
            isSpecialItem = false;
         }
      }
      
      public function addAdvImage(param1:int, param2:int, param3:String, param4:String) : void
      {
         if(this.advObjects == null)
         {
            advObjects = new Array();
         }
         var advert:AdvertItem = new AdvertItem(param3,param4);
         advert.x = param1;
         advert.y = param2;
         dImgs.push(advert);
         this.advObjects.push(advert);
         addChild(advert);
      }
      
      public function addDecoImage(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:String) : void
      {
         var image:MovieItem = new MovieItem(this);
         image.x = param1;
         image.y = param2;
         image.hide = param5;
         image.doAction199(param3,param4,param6,param7,param6 > 0);
         image.load();
         dImgs.push(image);
         if(param6 > 0)
         {
            dAnimImgsArray.push(image);
         }
         cacheAsBitmap = true;
      }
      
      override public function isPlayerNear(param1:*) : int
      {
         if(type == otSoundObject)
         {
            return -1;
         }
         var otherI:int = param1.i;
         var otherJ:int = param1.j;
         if(rect.width == -1)
         {
            if(mapLevel <= param1.mapLevel)
            {
               return 1;
            }
            return -1;
         }
         if(mapLevel > param1.mapLevel)
         {
            return -1;
         }
         if(mapLevel < param1.mapLevel)
         {
            return 1;
         }
         if(param1.isBackground)
         {
            return -1;
         }
         if(otherI + otherJ >= sumStart && otherI + otherJ <= intValue117)
         {
            if(otherI >= rect.y + rect.height || otherJ < rect.x)
            {
               return 1;
            }
            return -1;
         }
         return 0;
      }
      
      public function setHideDeco(param1:Boolean) : void
      {
         var image:MovieItem = null;
         i = 0;
         while(i < dImgs.length)
         {
            image = dImgs[i] as MovieItem;
            if(image.hide == MovieBitmap.MOVIE_BITMAP_CONST4 || image.hide == MovieBitmap.MOVIE_BITMAP_CONST5)
            {
               image.visible = !param1;
            }
            else if(image.hide == MovieBitmap.MOVIE_BITMAP_CONST1 || image.hide == MovieBitmap.MOVIE_BITMAP_CONST3)
            {
               image.visible = param1;
            }
            ++i;
         }
      }
      
      override public function process(param1:int, param2:int, param3:int, param4:int) : void
      {
         var imageIndex:int;
         if(type == otSoundObject)
         {
            if(getTimer() >= nextTime)
            {
               World(world).playObjectSound(intVal1,this.i,this.j);
               nextTime = getTimer() + (intVal2 + int(Math.random() * (intVal3 - intVal2))) * 1000;
            }
         }
         if(animationState != animateNone)
         {
            imageIndex = 0;
            while(imageIndex < dAnimImgsArray.length)
            {
               if(dAnimImgsArray[imageIndex].animate(cycled,animationState == animateBackward) && highlight == HIGHLIGHT_1)
               {
                  animatedBitmap = dAnimImgsArray[imageIndex];
                  if(animatedBitmap)
                  {
                     animatedBitmap.bitmapData.colorTransform(new Rectangle(0,0,animatedBitmap.width,animatedBitmap.height),colorTransform3);
                  }
               }
               imageIndex++;
            }
         }
         var localMouseX:int = param1;
         var localMouseY:int = param2;
         var animatedBitmap:Bitmap;
         var advert:AdvertItem;
         var animatedImage:MovieBitmap;
         var pixelAlpha:int;
         var mouseCell:IJPoint;
         var imageData:BitmapData;
         if(this.advObjects != null && target == null && visible)
         {
            imageIndex = 0;
            while(imageIndex < this.advObjects.length)
            {
               advert = AdvertItem(this.advObjects[imageIndex]);
               if(advert.isSelected(localMouseX - advert.x,localMouseY - advert.y))
               {
                  target = this;
                  advert.setHighlight(true);
               }
               else
               {
                  advert.setHighlight(false);
               }
               imageIndex++;
            }
         }
         if(isSpecialItem)
         {
            if(target == null && (this.client.player.mapLevel == mapLevel || type == OBJECT_ITEM_CONST11 && this.client.player.mapLevel == mapLevel + 1))
            {
               if(this.client.player.mapLevel == mapLevel + 1)
               {
                  mouseCell = getIJCoords(this.client.mouseX - this.client.world.x,this.client.mouseY - this.client.world.y + this.client.player.mapLevel * cMapLevelHeight);
                  if(bgRect && bgRect.width != -1 && (mouseCell.i < bgRect.y || mouseCell.i >= bgRect.y + bgRect.height || mouseCell.j < bgRect.x || mouseCell.j >= bgRect.x + bgRect.width))
                  {
                     setHighlight(HIGHLIGHT_SELECTED);
                     return;
                  }
               }
               imageIndex = 0;
               while(imageIndex < dAnimImgsArray.length)
               {
                  animatedImage = dAnimImgsArray[imageIndex];
                  imageData = null;
                  if(animatedImage.visible)
                  {
                     if(animatedImage.bitmapData != null)
                     {
                        imageData = animatedImage.bitmapData;
                     }
                     else if(animatedImage.bitmap != null)
                     {
                        imageData = animatedImage.bitmap.bitmapData;
                     }
                     if(imageData != null)
                     {
                        pixelAlpha = imageData.getPixel32(localMouseX - animatedImage.x,localMouseY - animatedImage.y) >> 24 & 0xFF;
                        if(pixelAlpha > 0)
                        {
                           target = this;
                           if(highlight == HIGHLIGHT_SELECTED)
                           {
                              this.highlight = HIGHLIGHT_1;
                              animatedImage.setHightlight(HIGHLIGHT_1);
                           }
                           break;
                        }
                        else if(highlight)
                        {
                           this.highlight = HIGHLIGHT_SELECTED;
                           animatedImage.setHightlight(HIGHLIGHT_SELECTED);
                        }
                     }
                  }
                  else
                  {
                     this.highlight = HIGHLIGHT_SELECTED;
                     animatedImage.setHightlight(HIGHLIGHT_SELECTED);
                  }
                  imageIndex++;
               }
            }
            else if(highlight == HIGHLIGHT_1)
            {
               setHighlight(HIGHLIGHT_SELECTED);
            }
         }
      }
      
      public function useObject() : void
      {
         switch(type)
         {
            case otDoor:
            case otRibdoor:
            case otBox:
            case otDialogObject:
            case otDepodObject:
            case otResource:
            case otFactory:
            case otClanProductDepod:
               if(animationState == animateNone || animationState == animateBackward)
               {
                  animationState = animateForward;
               }
               else
               {
                  animationState = animateBackward;
               }
               break;
         }
      }
      
      public function processAdvertize() : void
      {
         i = 0;
         while(i < this.advObjects.length)
         {
            this.advObjects[i].processUrl();
            ++i;
         }
      }
   }
}

