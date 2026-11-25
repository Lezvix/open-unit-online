package ui.addons
{
   import game.npc.PlayerItem;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.geom.ColorTransform;
   import game.Client;
   
   public class Radar extends Addon
   {
      
      protected static const DEAD_COLOR:ColorTransform = new ColorTransform(0.5,0.5,0.5);
      
      protected var ledBitmap:Bitmap;
      
      protected var client:Client;
      
      protected const marks:Vector.<Shape> = new Vector.<Shape>();
      
      public function Radar()
      {
         var body:Bitmap;
         super(ADDON_LOCATOR);
         body = getBmp("RADAR_MODULE");
         this.ledBitmap = getBmp("RADAR_LED");
         draw(body);
         width = body.width;
         height = body.height;
         this.client = Client.client;
         processIntervalValue = 300;
      }
      
      override public function update() : void
      {
         var i:int = 0;
         var player:PlayerItem;
         var mark:Shape;
         while(i < this.marks.length)
         {
            removeChild(this.marks[i]);
            i++;
         }
         this.marks.splice(0,this.marks.length);
         for each(player in this.client.world.Players)
         {
            if(this.client.sessionId != player.sessionId)
            {
               mark = new Shape();
               mark.graphics.beginBitmapFill(this.ledBitmap.bitmapData);
               mark.graphics.drawRect(0,0,this.ledBitmap.width,this.ledBitmap.height);
               mark.graphics.endFill();
               mark.x = 87 + (player.x - this.client.player.x >> 5) - (this.ledBitmap.width >> 1);
               mark.y = 65 + (player.y - this.client.player.y >> 5) - (this.ledBitmap.height >> 1);
               if(player.state == PlayerItem.stDead)
               {
                  mark.transform.colorTransform = DEAD_COLOR;
                  addChildAt(mark,0);
               }
               else
               {
                  addChild(mark);
               }
               this.marks.push(mark);
            }
         }
      }
   }
}

