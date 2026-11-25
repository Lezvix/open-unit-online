package ui.buttons
{
   import flash.text.TextField;
   import ui.NUIComponent;
   import ui.NTextFormat;
   
   public class SmallChannelButton extends ChannelButton
   {
      
      private static const H:int = 14;
      
      private static const W:int = 108;
      
      private static const font:NTextFormat = NTextFormat.normal.center.derive({"size":9});
      
      public function SmallChannelButton(clickHandler:Function, channel:int, label:String, closeBtn:NButton = null)
      {
         var textField:TextField = new TextField();
         textField.defaultTextFormat = font;
         textField.width = W;
         textField.height = H;
         textField.text = label;
         textField.y = -1;
         var normalState:NUIComponent = new NUIComponent();
         normalState.graphics.drawRect(0,0,W,H);
         normalState.doAction487(0,0,W,6702080,6702080);
         normalState.doAction151(0,0,H,6702080,6702080,1,0);
         normalState.doAction151(W,0,H,6702080,6702080,1,0);
         normalState.addChild(textField);
         textField = new TextField();
         textField.width = W;
         textField.height = H;
         textField.defaultTextFormat = font;
         textField.text = label;
         textField.y = -1;
         var selectedState:NUIComponent = new NUIComponent();
         selectedState.graphics.drawRect(0,0,W,H);
         selectedState.doAction487(0,0,W,6702080,6702080);
         selectedState.doAction151(0,0,H,6702080,13211185);
         selectedState.doAction151(W,0,H,6702080,13211185);
         selectedState.doAction487(0,H,W,13211185,13211185);
         selectedState.addChild(textField);
         super(clickHandler,channel,label,closeBtn,normalState,null,null,selectedState);
         disposeOnRemove = false;
      }
      
      override public function set x(value:Number) : void
      {
         super.x = value;
         if(closeChannelButton != null)
         {
            closeChannelButton.x = value + width - closeChannelButton.width - 3;
         }
      }
      
      override public function set y(value:Number) : void
      {
         super.y = value;
         if(closeChannelButton != null)
         {
            closeChannelButton.y = value + 3;
         }
      }
   }
}

