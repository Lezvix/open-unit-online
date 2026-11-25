package ui.buttons
{
   import core.ui.UIComponent;
   import flash.display.DisplayObject;
   
   public class ChannelButton extends ToggleButton
   {
      
      protected var _channel:int;
      
      protected var labelText:String;
      
      protected var closeChannelButton:NButton;
      
      public function ChannelButton(clickHandler:Function, channel:int, label:String, closeBtn:NButton, normalState:DisplayObject, overState:DisplayObject, downState:DisplayObject, hitState:DisplayObject = null)
      {
         this._channel = channel;
         this.labelText = label;
         this.closeChannelButton = closeBtn;
         super(clickHandler,normalState,overState,downState,hitState);
      }
      
      public function setNotification() : void
      {
      }
      
      public function resetNotification() : void
      {
      }
      
      override public function toggleOn() : void
      {
         this.resetNotification();
         super.toggleOn();
      }
      
      override public function dispose() : void
      {
         if(this.closeChannelButton != null && this.closeChannelButton.parent != null)
         {
            UIComponent(this.closeChannelButton.parent).removeUIChild(this.closeChannelButton);
            closeChannelButton = null;
         }
         super.dispose();
      }
      
      public function get label() : String
      {
         return this.labelText;
      }
      
      public function get channel() : int
      {
         return this._channel;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(this.closeChannelButton != null)
         {
            this.closeChannelButton.visible = value;
         }
      }
   }
}

