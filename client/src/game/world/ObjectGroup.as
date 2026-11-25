package game.world
{
   import flash.geom.Rectangle;
   
   public class ObjectGroup
   {
      
      public var flag42:Boolean;
      
      public var id:String;
      
      public var rect:Rectangle;
      
      public var objects:Vector.<CellRef> = new Vector.<CellRef>();
      
      public function ObjectGroup()
      {
         super();
      }
   }
}

