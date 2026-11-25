package core.ui
{
   import flash.display.DisplayObject;
   
   public class HintInfo
   {
      
      public static const HINT_INFO_CONST1:int = 0;
      
      private static var nextHintId:int = 0;
      
      public var image:DisplayObject = null;
      
      public var text:String = "";
      
      public var owner:Object;
      
      public var images:Array;
      
      private var _type:int = 0;
      
      private var _data:Object;
      
      public function HintInfo(param1:String, param2:Object = null, param3:DisplayObject = null, param4:Array = null)
      {
         super();
         this.text = param1;
         this.image = param3;
         this.images = param4;
         if(param2 == null)
         {
            param2 = nextHintId;
            ++nextHintId;
         }
         else
         {
            this.owner = param2;
         }
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
      }
      
      public function check44(param1:HintInfo) : Boolean
      {
         var otherData:Object = null;
         var value:String = null;
         if(param1 == null || this.text != param1.text || this.image != param1.image || this._type != param1.type || this.images != param1.images || param1.data != this._data)
         {
            return false;
         }
         if(this._data != null && param1 != null)
         {
            otherData = param1.data;
            for each(value in this._data)
            {
               if(this._data[value] != otherData[value])
               {
                  return false;
               }
            }
            for each(value in otherData)
            {
               if(this._data[value] != otherData[value])
               {
                  return false;
               }
            }
         }
         return true;
      }
   }
}

