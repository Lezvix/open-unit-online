package ui
{
   import flash.display.Bitmap;
   import flash.text.TextField;
   
   public class NewsTicker extends NUIComponent
   {
      
      public static const ADVERT_COUNT:int = 5;
      
      public static const ADVERT_INTERVAL:int = 7;
      
      private const advertImages:Vector.<Bitmap> = new Vector.<Bitmap>(ADVERT_COUNT,true);
      
      private const advertTexts:Vector.<String> = new Vector.<String>(ADVERT_COUNT,true);
      
      private var currentAdvert:int = 0;
      
      private const text:TextField = new TextField();
      
      public function NewsTicker()
      {
         super();
         var header:TextField = new TextField();
         header.x = 75;
         header.y = 5;
         header.height = 18;
         header.width = 544;
         header.defaultTextFormat = new NTextFormat({
            "size":12,
            "color":13408825
         });
         header.text = _("IDS_UNIT_DIRECT");
         addChild(header);
         this.text.x = 75;
         this.text.y = 20;
         this.text.height = 52;
         this.text.defaultTextFormat = new NTextFormat({
            "size":12,
            "color":13408825
         });
         this.text.width = 544;
         this.text.wordWrap = true;
         this.text.multiline = true;
         addChild(this.text);
         var i:int = 0;
         while(i < this.advertImages.length)
         {
            this.advertImages[i] = getBmp("ADVERTISE_" + i);
            this.advertTexts[i] = _("IDS_ADVERT_TEXT_" + i);
            i++;
         }
         this.showAdvert(0);
         processIntervalValue = ADVERT_INTERVAL * 1000;
      }
      
      public function showAdvert(index:int) : void
      {
         currentAdvert = index;
         graphics.clear();
         drawRect(0,0,625,73,13408825);
         draw(this.advertImages[this.currentAdvert],2,1);
         this.text.text = this.advertTexts[this.currentAdvert];
      }
      
      override protected function process() : void
      {
         this.showAdvert((this.currentAdvert + Math.random() * (ADVERT_COUNT - 2) + 1) % ADVERT_COUNT);
      }
   }
}

