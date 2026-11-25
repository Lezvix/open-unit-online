package game.world
{
   import social.SocialApi;
   import core.system.GlobalContext;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   
   public class ObjectFactory
   {
      
      private var obj22:Object = new Object();
      
      private var obj26:Object = new Object();
      
      private var _world:WorldBase;
      
      private var obj47:Object;
      
      private var str34:String;
      
      public function ObjectFactory(param1:WorldBase)
      {
         super();
         this._world = param1;
         this.obj47 = GlobalContext.sharedInstance.propValue174;
         this.str34 = SocialApi.api.lang;
      }
      
      public function get world() : WorldBase
      {
         return this._world;
      }
      
      public function set world(param1:WorldBase) : void
      {
         _world = param1;
      }
      
      public function doAction814(param1:ByteArray) : void
      {
         param1.uncompress();
         var groupsRemaining:int = param1.readInt();
         var group:ObjectGroup;
         var cellsRemaining:int;
         var cell:CellRef;
         while(groupsRemaining > 0)
         {
            group = new ObjectGroup();
            group.id = this.getString7(param1);
            group.flag42 = param1.readByte() == 1;
            group.rect = new Rectangle();
            group.rect.x = param1.readInt();
            group.rect.y = param1.readInt();
            group.rect.width = param1.readInt();
            group.rect.height = param1.readInt();
            cellsRemaining = param1.readInt();
            while(cellsRemaining > 0)
            {
               cell = new CellRef(param1.readInt(),param1.readInt(),param1.readInt());
               group.objects.push(cell);
               cellsRemaining--;
            }
            this.obj26[group.id] = group;
            groupsRemaining--;
         }
      }
      
      public function doAction266(bytes:ByteArray) : void
      {
         bytes.uncompress();
         var areasRemaining:int = bytes.readInt();
         var area:LocationArea;
         var bounds:Rectangle;
         var alternateBounds:Rectangle;
         var layersRemaining:int;
         var areaId:int;
         var unusedFirst:int;
         var unusedSecond:int;
         var posX:int;
         var posY:int;
         var animationCount:int;
         var frameCount:int;
         var animationNumbers:Vector.<int>;
         var animationTimes:Vector.<int>;
         var stateAnimations:Vector.<int>;
         var statesRemaining:int;
         var stateOffset:int;
         var layerType:int;
         var frameIndex:int;
         var localizedAnimations:Vector.<AnimationInfo>;
         var localesRemaining:int;
         var animationInfo:AnimationInfo;
         while(areasRemaining > 0)
         {
            areaId = bytes.readInt();
            bounds = new Rectangle();
            bounds.x = bytes.readInt();
            bounds.y = bytes.readInt();
            bounds.width = bytes.readInt();
            bounds.height = bytes.readInt();
            alternateBounds = new Rectangle();
            alternateBounds.x = bytes.readInt();
            alternateBounds.y = bytes.readInt();
            alternateBounds.width = bytes.readInt();
            alternateBounds.height = bytes.readInt();
            area = new LocationArea(areaId,bounds,alternateBounds);
            layersRemaining = bytes.readInt();
            while(layersRemaining > 0)
            {
               localizedAnimations = new Vector.<AnimationInfo>();
               localesRemaining = bytes.readInt();
               while(localesRemaining > 0)
               {
                  animationInfo = new AnimationInfo();
                  animationInfo.localization1 = this.getString7(bytes);
                  animationInfo.intValue189 = bytes.readInt();
                  animationInfo.packId = bytes.readInt();
                  localizedAnimations.push(animationInfo);
                  localesRemaining--;
               }
               layerType = bytes.readInt();
               posX = bytes.readInt();
               posY = bytes.readInt();
               animationCount = bytes.readInt();
               animationNumbers = new Vector.<int>();
               animationTimes = new Vector.<int>();
               frameCount = bytes.readInt();
               frameIndex = 0;
               while(frameIndex < frameCount)
               {
                  animationTimes.push(bytes.readInt());
                  animationNumbers.push(bytes.readByte());
                  frameIndex++;
               }
               stateAnimations = new Vector.<int>();
               statesRemaining = bytes.readInt();
               stateOffset = 0;
               if(statesRemaining > 0)
               {
                  while(statesRemaining > 0)
                  {
                     stateOffset += bytes.readByte();
                     stateAnimations.push(stateOffset);
                     statesRemaining--;
                  }
               }
               else if(frameCount > 0)
               {
                  stateAnimations.push(frameCount);
               }
               area.doAction321(localizedAnimations,layerType,posX,posY,animationCount,animationNumbers,animationTimes,stateAnimations);
               layersRemaining--;
            }
            this.obj22[area.id] = area;
            areasRemaining--;
         }
      }
      
      private function getString7(param1:ByteArray) : String
      {
         var result:String = "";
         var bytesRemaining:int = param1.readInt();
         while(bytesRemaining > 0)
         {
            result += String.fromCharCode(param1.readByte());
            bytesRemaining--;
         }
         return result;
      }
      
      public function createObject(param1:Composition, param2:int, param3:int, param4:int, param5:String, param6:String) : WorldObject
      {
         var worldObject:WorldObject = this._world.createObject();
         worldObject.composition = param1;
         var area:LocationArea = this.obj22[param4];
         worldObject.doAction646(area.id,0,0,param5,param6);
         worldObject.locationArea1 = area;
         if(area.rect.width >= 0 && area.rect.height >= 0)
         {
            bounds = area.rect;
         }
         else
         {
            bounds = area.rect4;
         }
         worldObject.setPos(param3,param2,bounds,new Rectangle(-1,-1,-1,-1));
         var bounds:Rectangle;
         var animationLayer:Object;
         var defaultAnimation:AnimationInfo;
         var localizedAnimation:AnimationInfo;
         var layerIndex:int = 0;
         var animation:AnimationInfo;
         while(layerIndex < area.array64.length)
         {
            animationLayer = area.array64[layerIndex];
            worldObject.doAction684(animationLayer.type);
            defaultAnimation = null;
            localizedAnimation = null;
            for each(animation in animationLayer.locales)
            {
               if(animation.localization1 == "")
               {
                  defaultAnimation = animation;
               }
               if(animation.localization1 == this.str34)
               {
                  localizedAnimation = animation;
                  break;
               }
            }
            if(localizedAnimation != null)
            {
               worldObject.doAction204(animationLayer.posX,animationLayer.posY,localizedAnimation.packId,localizedAnimation.intValue189,animationLayer.type,param5,param6,animationLayer.animCount,animationLayer.animNums,animationLayer.animTimes,animationLayer.stateAnims);
            }
            else if(defaultAnimation != null)
            {
               worldObject.doAction204(animationLayer.posX,animationLayer.posY,defaultAnimation.packId,defaultAnimation.intValue189,animationLayer.type,param5,param6,animationLayer.animCount,animationLayer.animNums,animationLayer.animTimes,animationLayer.stateAnims);
            }
            layerIndex++;
         }
         worldObject.state = 0;
         return worldObject;
      }
      
      public function getObjectGroup1(param1:String) : ObjectGroup
      {
         return this.obj26[param1] as ObjectGroup;
      }
      
      public function getComposition18(param1:int, param2:int, param3:String, param4:String, param5:String, param6:Object = null) : Composition
      {
         var group:ObjectGroup = this.obj26[param3] as ObjectGroup;
         var composition:Composition = this.getComposition7(param4,param5);
         composition.initComposition(this._world,group,this,param4,param5,param6);
         composition.setPos(param2,param1);
         composition.init();
         return composition;
      }
      
      public function getComposition7(param1:String, param2:String) : Composition
      {
         var composition:Composition = null;
         if(param2 != null)
         {
            composition = new this.obj47[param1 + "-" + param2]();
         }
         else
         {
            composition = new this.obj47[param1]();
         }
         return composition;
      }
      
      protected function get propValue174() : Object
      {
         return this.obj47;
      }
   }
}

