package core.ui.views
{
   import core.ui.UIComponent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.geom.*;
   import flash.text.*;
   
   public class TextView extends UIComponent
   {
      
      private var _tf:TextField = new TextField();
      
      private var _format:TextFormat = new TextFormat();
      
      private var configuredTextSize:int;
      
      private var _horizontalTextAlign:String;
      
      private var _verticalTextAlign:String;
      
      public function TextView()
      {
         super(true);
         handlesMouse = false;
      }
      
      override protected function _initView(param1:Object) : void
      {
         super._initView(param1);
         switch(param1.textAlignment)
         {
            case 3:
               _horizontalTextAlign = TextFormatAlign.RIGHT;
               break;
            case 2:
               _horizontalTextAlign = TextFormatAlign.JUSTIFY;
               break;
            case 1:
               _horizontalTextAlign = TextFormatAlign.CENTER;
               break;
            case 0:
            default:
               _horizontalTextAlign = TextFormatAlign.LEFT;
               break;
         }
         switch(param1.textVerticalAlignment)
         {
            case 2:
               _verticalTextAlign = TextFormatAlign.RIGHT;
               break;
            case 1:
               _verticalTextAlign = TextFormatAlign.CENTER;
               break;
            case 0:
            default:
               _verticalTextAlign = TextFormatAlign.LEFT;
               break;
         }
         this._format.font = param1.font.name;
         configuredTextSize = param1.font.size;
         this._format.size = this.configuredTextSize;
         this._format.color = param1.color;
         this._format.align = this._horizontalTextAlign;
         this._format.leading = -2;
         this._tf.embedFonts = true;
         this._tf.multiline = true;
         this._tf.wordWrap = true;
         this._tf.defaultTextFormat = this._format;
         this._tf.width = 0;
         this._tf.height = 0;
         this._tf.text = param1.text;
         var outlineSize:Number = param1.outlineSize;
         var outlineAlpha:Number = (param1.outlineColor >> 24 & 0xFF) / 255;
         var outlineColor:uint = param1.outlineColor & 0xFFFFFF;
         if(outlineSize > 0 && outlineAlpha > 0)
         {
            this._tf.filters = [new GlowFilter(outlineColor,outlineAlpha,outlineSize,outlineSize,3,BitmapFilterQuality.HIGH)];
         }
         this._tf.cacheAsBitmap = true;
         addChild(this._tf);
      }
      
      private function check30(param1:String) : Boolean
      {
         var fonts:Array = Font.enumerateFonts();
         var index:int = 0;
         while(index < fonts.length)
         {
            if(fonts[index].fontName == param1)
            {
               return true;
            }
            index++;
         }
         return false;
      }
      
      public function get text() : String
      {
         return this._tf.text;
      }
      
      public function set text(param1:String) : void
      {
         if(param1 != this._tf.text)
         {
            this._tf.text = param1;
            this.reshape();
         }
      }
      
      public function get horizontalTextAlign() : String
      {
         return this._horizontalTextAlign;
      }
      
      public function set horizontalTextAlign(alignment:String) : void
      {
         if(this._horizontalTextAlign != alignment)
         {
            this._format.align = _horizontalTextAlign = alignment;
            this._tf.defaultTextFormat = this._format;
            this.reshape();
         }
      }
      
      override public function reshape(param1:Rectangle = null) : void
      {
         super.reshape(param1);
         if(this._tf.text)
         {
            this._tf.width = width;
            this._tf.height = height + int(this.configuredTextSize * 0.5);
            this.doAction931();
            switch(this._verticalTextAlign)
            {
               case TextFormatAlign.RIGHT:
                  this._tf.y = height - this._tf.textHeight;
                  break;
               case TextFormatAlign.CENTER:
                  this._tf.y = int((height - this._tf.textHeight) / 2);
                  break;
               case TextFormatAlign.LEFT:
               default:
                  this._tf.y = 0;
                  break;
            }
            this._tf.y -= int(int(this._format.size) * 0.15);
         }
      }
      
      override protected function appendTo(param1:UIComponent) : void
      {
         param1.addChild(this);
      }
      
      private function doAction931() : void
      {
         var reduceSize:Function = function():void
         {
            _format.size = int(_format.size) - 1;
            _tf.defaultTextFormat = _format;
            _tf.text = _tf.text;
         };
         this._format.size = this.configuredTextSize;
         this._tf.defaultTextFormat = this._format;
         this._tf.text = this._tf.text;
         while(this._tf.textWidth > width && this._format.size > 0)
         {
            reduceSize();
         }
         while(this._tf.textHeight - int(int(this._format.size) * 0.5) > height && this._format.size > 0)
         {
            reduceSize();
         }
      }
      
      public function get verticalTextAlign() : String
      {
         return this._verticalTextAlign;
      }
      
      public function set verticalTextAlign(alignment:String) : void
      {
         if(this._verticalTextAlign != alignment)
         {
            _verticalTextAlign = alignment;
            this.reshape();
         }
      }
   }
}

