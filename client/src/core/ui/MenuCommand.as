package core.ui
{
   public class MenuCommand
   {
      
      private var _id:String;
      
      private var str47:String;
      
      private var createCallback:Function;
      
      public function MenuCommand(param1:String, param2:String, param3:Function)
      {
         super();
         this._id = param1;
         this.str47 = param2;
         this.createCallback = param3;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get propValue55() : String
      {
         return this.str47;
      }
      
      public function create(param1:Object) : UIElement
      {
         return this.createCallback(param1);
      }
   }
}

