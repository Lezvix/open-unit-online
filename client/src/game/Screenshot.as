package game
{
   import com.adobe.images.PNGEncoder;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.net.FileReference;
   import flash.text.TextField;
   import ui.NuclearEPanel;
   import ui.ChatPanel;
   import ui.NTextFormat;
   
   public class Screenshot
   {
      
      public function Screenshot()
      {
         super();
      }
      
      public static function doAction404() : void
      {
         var w:int = Client.curWidth - Main.instance.uiContainer.x * 2;
         var h:int = Client.curHeight - Main.instance.uiContainer.y * 2;
         var screenshot:BitmapData = new BitmapData(w,h);
         NuclearEPanel.instance.hideMoney();
         screenshot.draw(Main.instance.stage,new Matrix(1,0,0,1,-Main.instance.uiContainer.x,-Main.instance.uiContainer.y),null,null,new Rectangle(0,0,w,h));
         NuclearEPanel.instance.showMoney();
         var triangle:Shape = new Shape();
         triangle.graphics.beginFill(0,0.7);
         triangle.graphics.lineTo(280,0);
         triangle.graphics.lineTo(280,90);
         triangle.graphics.lineTo(0,0);
         triangle.graphics.endFill();
         screenshot.draw(triangle,new Matrix(1,0,0,1,w - 280));
         var t:TextField = new TextField();
         t.defaultTextFormat = NTextFormat.titleFormat.right;
         t.text = ChatPanel.instance.propValue140;
         t.width = 250;
         screenshot.draw(t,new Matrix(1,0,0,1,w - 260,5));
         t.text = ChatPanel.instance.propValue94;
         screenshot.draw(t,new Matrix(1,0,0,1,w - 260,22));
         var file:FileReference = new FileReference();
         file.addEventListener(Event.COMPLETE,onFileComplete);
         try
         {
            file.save(PNGEncoder.getString20(screenshot),"screen" + Client.settings.screenshotIndex + ".png");
         }
         catch(err:Error)
         {
            file.removeEventListener(Event.COMPLETE,onFileComplete);
         }
      }
      
      private static function onFileComplete(param1:Event) : void
      {
         Client.settings.screenshotIndex += 1;
         Client.settings.save();
         param1.target.removeEventListener(Event.COMPLETE,onFileComplete);
      }
   }
}

