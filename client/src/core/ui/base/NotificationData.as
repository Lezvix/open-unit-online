package core.ui.base
{
   public class NotificationData
   {
      
      private var _type:String;
      
      private var _notificationTitle:String;
      
      private var numValue20:Number = 0;
      
      private var numValue57:Number = 0;
      
      private var notificationDirty:Boolean = true;
      
      private var _notificationMessage:String;
      
      private var _item:Object;
      
      private var flag20:Boolean = false;
      
      public var flag131:Boolean = false;
      
      public function NotificationData()
      {
         super();
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         _type = param1;
      }
      
      public function get propValue31() : Number
      {
         return this.numValue20;
      }
      
      public function set propValue31(param1:Number) : void
      {
         numValue20 = param1;
      }
      
      public function get propValue44() : Number
      {
         return this.numValue57;
      }
      
      public function set propValue44(param1:Number) : void
      {
         numValue57 = param1;
      }
      
      public function get isValue19() : Boolean
      {
         return this.notificationDirty;
      }
      
      public function clear() : void
      {
         flag131 = false;
      }
      
      public function get message() : String
      {
         return this._notificationMessage;
      }
      
      public function set message(param1:String) : void
      {
         if(this._notificationMessage != param1)
         {
            notificationDirty = true;
         }
         _notificationMessage = param1;
      }
      
      public function set item(param1:Object) : void
      {
         if(this._item != param1)
         {
            notificationDirty = true;
         }
         _item = param1;
      }
      
      public function get item() : Object
      {
         return this._item;
      }
      
      public function get title() : String
      {
         return this._notificationTitle;
      }
      
      public function set title(param1:String) : void
      {
         if(this._notificationTitle != param1)
         {
            notificationDirty = true;
         }
         _notificationTitle = param1;
      }
      
      public function get isValue13() : Boolean
      {
         return this.flag20;
      }
      
      public function set isValue13(param1:Boolean) : void
      {
         if(this.flag20 != param1)
         {
            notificationDirty = true;
         }
         flag20 = param1;
      }
   }
}

