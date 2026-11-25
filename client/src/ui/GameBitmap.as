package ui
{
   import core.loaders.BitmapCache;
   import core.loaders.Picture;
   import core.resources.ResourceManager;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import game.InventoryItem;
   import game.Chat;
   import game.Character;
   
   public class GameBitmap extends NUIComponent
   {
      
      private static const array121:Array = [];
      
      private static const array48:Array = [new GlowFilter(14266157,0.25,5,5,3,BitmapFilterQuality.HIGH)];
      
      protected var str33:String;
      
      private var objectList1:Vector.<Object>;
      
      public function GameBitmap()
      {
         super();
         this.objectList1 = new Vector.<Object>(6,true);
      }
      
      private static function getInt23(param1:Object, param2:Object) : int
      {
         if(param1.depth > param2.depth)
         {
            return 1;
         }
         if(param1.depth < param2.depth)
         {
            return -1;
         }
         return 0;
      }
      
      public function doAction945(param1:Character) : void
      {
         str33 = param1.sex === Character.SEX_MALE ? "m" : "f";
         var layerIndex:int = 5;
         var imageId:int;
         while(layerIndex >= 0)
         {
            if(param1.images[layerIndex] > 0 || param1.images[layerIndex] === 0 && layerIndex === 0)
            {
               imageId = (layerIndex + 1) * 1000 + param1.images[layerIndex] % 1000;
               this.objectList1[layerIndex] = this.getObject11(imageId,param1.palettes[layerIndex]);
            }
            layerIndex--;
         }
         this.loadAllPals();
      }
      
      private function getString30(param1:int) : String
      {
         return ResourceManager.sharedInstance.resolveUrl("animations/inventory/" + this.str33 + param1 + ".swf");
      }
      
      private function getObject11(param1:int, param2:int) : Object
      {
         return {
            "id":param1,
            "url":this.getString30(param1),
            "palette":param2,
            "queued":true
         };
      }
      
      private function loadAllPals() : void
      {
         var layerIndex:int = 0;
         var layer:Object;
         while(layerIndex < 6)
         {
            layer = this.objectList1[layerIndex];
            if(layer && layer.queued)
            {
               layer.queued = false;
               if(BitmapCache.check54(layer.url))
               {
                  this.doAction5(layer.url);
               }
               else
               {
                  BitmapCache.doAction139(layer.url,this.doAction5);
               }
               break;
            }
            layerIndex++;
         }
      }
      
      public function doAction849(param1:int, param2:int) : void
      {
         this.doAction216(Character.HAIR_IDX,(Character.HAIR_IDX + 1) * 1000 + param1 % 1000,param2);
      }
      
      public function doAction211(param1:InventoryItem) : void
      {
         var layerIndex:int = InventoryItem.array83[param1.type];
         var imageId:int = (layerIndex + 1) * 1000 + param1.params[InventoryItem.WEAPON_PENALTY_NONE] % 1000;
         var palette:int = param1.params[InventoryItem.WEAPON_PENALTY_LOW];
         this.doAction216(layerIndex,imageId,palette);
      }
      
      public function doAction657(param1:InventoryItem) : void
      {
         this.doAction384(InventoryItem.array83[param1.type]);
      }
      
      private function doAction216(param1:int, param2:int, param3:int) : void
      {
         var layer:Object = this.objectList1[param1];
         if(layer)
         {
            if(layer.id === param2 && layer.palette === param3)
            {
               return;
            }
            this.doAction384(param1);
         }
         this.objectList1[param1] = this.getObject11(param2,param3);
         this.loadAllPals();
      }
      
      private function doAction384(param1:int) : void
      {
         var layer:Object = this.objectList1[param1];
         if(layer)
         {
            this.objectList1[param1] = null;
            this.doAction554();
         }
      }
      
      public function doAction698(param1:int = -1) : void
      {
         var layerIndex:int = 0;
         if(param1 === -1)
         {
            layerIndex = 2;
            while(layerIndex < 6)
            {
               this.doAction384(layerIndex);
               layerIndex++;
            }
         }
         else
         {
            this.doAction384(param1);
         }
      }
      
      override public function get cursorId() : int
      {
         return this.includesMouse() ? GameCursor.CURSOR_1 : GameCursor.CURSOR_DEFAULT;
      }
      
      override protected function includesMouse() : Boolean
      {
         return mouseX >= 0 && mouseX < 100 && mouseY >= 0 && mouseY <= 270 && (this.check57(Character.HELMET_IDX) || this.check57(Character.ARMOR_IDX) || this.check57(Character.PANTS_IDX) || this.check57(Character.BOOTS_IDX));
      }
      
      public function getInt37() : int
      {
         var topLayer:Object = null;
         var topLayerIndex:int = -1;
         var layerIndex:int = 2;
         while(layerIndex < 6)
         {
            if(this.check57(layerIndex))
            {
               if(topLayer === null || topLayer.depth < this.objectList1[layerIndex].depth)
               {
                  topLayer = this.objectList1[layerIndex];
                  topLayerIndex = layerIndex;
               }
            }
            layerIndex++;
         }
         return topLayerIndex;
      }
      
      private function check57(param1:int) : Boolean
      {
         var layer:Object = this.objectList1[param1];
         var globalMouse:Point;
         if(layer && layer.image && contains(layer.image))
         {
            globalMouse = localToGlobal(new Point(mouseX,mouseY));
            return layer.image.hitTestPoint(globalMouse.x,globalMouse.y,true);
         }
         return false;
      }
      
      public function get image() : Picture
      {
         var layerIndex:int = this.getInt37();
         if(layerIndex !== -1)
         {
            return this.objectList1[layerIndex].image;
         }
         return null;
      }
      
      private function doAction5(param1:String) : void
      {
         var asset:Object = null;
         var picture:Picture = null;
         var layerIndex:int = 0;
         var layer:Object = null;
         var animationData:Object = null;
         var paletteFilter:Object = null;
         if(BitmapCache.check54(param1))
         {
            asset = BitmapCache.doAction50(param1);
            picture = BitmapCache.getPicture1(param1 + "/BITMAP");
            layerIndex = 0;
            while(layerIndex < 6)
            {
               layer = this.objectList1[layerIndex];
               if((layer) && layer.url === param1)
               {
                  if(layer.palette > 0 && "palFilters" in asset && asset.palFilters.length >= layer.palette)
                  {
                     paletteFilter = asset.palFilters[layer.palette - 1];
                     picture.transform.colorTransform = new ColorTransform(paletteFilter.mr,paletteFilter.mg,paletteFilter.mb,paletteFilter.ma,paletteFilter.or,paletteFilter.og,paletteFilter.ob,paletteFilter.oa);
                  }
                  animationData = asset.getData("DEFAULT");
                  picture.x = -animationData.frames[0].ox;
                  picture.y = -animationData.frames[0].oy;
                  layer.depth = "depth" in asset ? asset.depth : int.MIN_VALUE;
                  layer.image = picture;
                  this.doAction554();
                  break;
               }
               layerIndex++;
            }
         }
         this.loadAllPals();
      }
      
      private function doAction554() : void
      {
         removeChildren();
         var visibleLayers:Array = [];
         var layerIndex:int = 0;
         var layer:Object;
         for(; layerIndex < 6; layerIndex++)
         {
            layer = this.objectList1[layerIndex];
            if(layer && layer.image)
            {
               if(layerIndex === Character.HAIR_IDX && this.objectList1[Character.HELMET_IDX])
               {
                  continue;
               }
               visibleLayers.unshift({
                  "image":layer.image,
                  "depth":layer.depth
               });
            }
         }
         Chat.doAction485(visibleLayers,getInt23);
         layerIndex = 0;
         while(layerIndex < visibleLayers.length)
         {
            addChild(visibleLayers[layerIndex].image);
            layerIndex++;
         }
      }
      
      public var onMouseDown:Function;

      override public function get handlesMove() : Boolean
      {
         return true;
      }
      
      override public function mouseMoveHandler() : void
      {
         var topLayer:Object = null;
         var otherImages:Array = [];
         var layerIndex:int = 2;
         var layer:Object;
         var globalMouse:Point;
         while(layerIndex < 6)
         {
            layer = this.objectList1[layerIndex];
            if((layer) && layer.image && contains(layer.image))
            {
               globalMouse = localToGlobal(new Point(mouseX,mouseY));
               if(layer.image.hitTestPoint(globalMouse.x,globalMouse.y,true))
               {
                  if(topLayer === null)
                  {
                     topLayer = {
                        "image":layer.image,
                        "depth":layer.depth
                     };
                  }
                  else if(topLayer.depth < layer.depth)
                  {
                     otherImages.push(topLayer.image);
                     topLayer = {
                        "image":layer.image,
                        "depth":layer.depth
                     };
                  }
                  else
                  {
                     otherImages.push(layer.image);
                  }
               }
               else
               {
                  otherImages.push(layer.image);
               }
            }
            layerIndex++;
         }
         if(topLayer !== null)
         {
            topLayer.image.filters = array48;
         }
         layerIndex = 0;
         while(layerIndex < otherImages.length)
         {
            otherImages[layerIndex].filters = array121;
            layerIndex++;
         }
      }
      
      override public function mouseDownHandler() : void
      {
         if(this.onMouseDown !== null)
         {
            this.onMouseDown(this);
         }
      }
   }
}

