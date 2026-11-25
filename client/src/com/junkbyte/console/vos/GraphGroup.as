package com.junkbyte.console.vos
{
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class GraphGroup
   {
      
      public static const FPS_PANEL:uint = 1;
      
      public static const MEMORY_PANEL:uint = 2;
      
      public var type:uint;
      
      public var name:String;
      
      public var intValue161:int = 1;
      
      public var low:Number;
      
      public var hi:Number;
      
      public var flag23:Boolean;
      
      public var averaging:uint;
      
      public var flag79:Boolean;
      
      public var interests:Array = [];
      
      public var rect:Rectangle;
      
      public var intValue168:int;
      
      public function GraphGroup(param1:String)
      {
         super();
         this.name = param1;
      }
      
      public static function getGraphGroup1(param1:ByteArray) : GraphGroup
      {
         var group:GraphGroup = new GraphGroup(param1.readUTF());
         group.type = param1.readUnsignedInt();
         group.intValue168 = param1.readUnsignedInt();
         group.low = param1.readDouble();
         group.hi = param1.readDouble();
         group.flag79 = param1.readBoolean();
         var remainingInterests:uint = param1.readUnsignedInt();
         while(remainingInterests)
         {
            group.interests.push(GraphInterest.getGraphGroup1(param1));
            remainingInterests--;
         }
         return group;
      }
      
      public function doAction686(param1:Number) : void
      {
         if(!isNaN(param1) && !this.flag23)
         {
            if(isNaN(this.low))
            {
               low = param1;
               hi = param1;
            }
            if(param1 > this.hi)
            {
               hi = param1;
            }
            if(param1 < this.low)
            {
               low = param1;
            }
         }
      }
      
      public function doAction32(param1:ByteArray) : void
      {
         var interest:GraphInterest = null;
         param1.writeUTF(this.name);
         param1.writeUnsignedInt(this.type);
         param1.writeUnsignedInt(this.intValue168);
         param1.writeDouble(this.low);
         param1.writeDouble(this.hi);
         param1.writeBoolean(this.flag79);
         param1.writeUnsignedInt(this.interests.length);
         for each(interest in this.interests)
         {
            interest.doAction32(param1);
         }
      }
   }
}

