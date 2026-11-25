package game.world
{
   import flash.geom.Rectangle;
   
   public class LocationArea
   {
      
      public var id:int;
      
      public var rect:Rectangle;
      
      public var rect4:Rectangle;
      
      public var array64:Array = new Array();
      
      public function LocationArea(param1:int, param2:Rectangle, param3:Rectangle)
      {
         super();
         this.id = param1;
         this.rect = param2;
         this.rect4 = param3;
      }
      
      public function doAction321(param1:Vector.<AnimationInfo>, param2:int, param3:int, param4:int, param5:int, param6:Vector.<int>, param7:Vector.<int>, param8:Vector.<int>) : void
      {
         this.array64.push({
            "locales":param1,
            "type":param2,
            "posX":param3,
            "posY":param4,
            "animCount":param5,
            "animNums":param6,
            "animTimes":param7,
            "stateAnims":param8
         });
      }
   }
}

