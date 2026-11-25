package com.junkbyte.console.view
{
   import com.junkbyte.console.ConsoleConfig;
   import com.junkbyte.console.ConsoleStyle;
   import com.junkbyte.console.Console;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class ConsolePanel extends Sprite
   {
      
      public static const DRAGGING:String = "DRAGGING";
      
      public static const SCALING:String = "SCALING";
      
      public static const VISIBILITY_CHANGED:String = "visibilityChanged";
      
      private static const TEXT_ROLL:String = "TEXT_ROLL";
      
      private var array38:Array;
      
      private var point3:Point;
      
      private var textField28:TextField;
      
      protected var console:Console;
      
      protected var bg:Sprite;
      
      protected var scaler:Sprite;
      
      protected var txtField:TextField;
      
      protected var minWidth:int = 18;
      
      protected var minHeight:int = 18;
      
      private var point6:Point;
      
      public var flag21:Boolean = true;
      
      public function ConsolePanel(param1:Console)
      {
         super();
         this.console = param1;
         this.bg = new Sprite();
         this.bg.name = "background";
         addChild(this.bg);
      }
      
      private static function onRollOut(param1:MouseEvent) : void
      {
         TextField(param1.currentTarget).dispatchEvent(new TextEvent(TEXT_ROLL));
      }
      
      private static function onMouseMove(e:MouseEvent) : void
      {
         var field:TextField = e.currentTarget as TextField;
         var index:int;
         if(field.scrollH > 0)
         {
            var scrollH:Number = field.scrollH;
            var w:Number = field.width;
            field.width = w + scrollH;
            index = field.getCharIndexAtPoint(field.mouseX + scrollH,field.mouseY);
            field.width = w;
            field.scrollH = scrollH;
         }
         else
         {
            index = field.getCharIndexAtPoint(field.mouseX,field.mouseY);
         }
         var url:String = null;
         if(index > 0)
         {
            try
            {
               var X:XML = new XML(field.getXMLText(index,index + 1));
               if(X.hasOwnProperty("textformat"))
               {
                  var txtformat:XML = X["textformat"][0] as XML;
                  if(txtformat)
                  {
                     url = txtformat.@url;
                  }
               }
            }
            catch(err:Error)
            {
               url = null;
            }
         }
         field.dispatchEvent(new TextEvent(TEXT_ROLL,false,false,url));
      }
      
      protected function get config() : ConsoleConfig
      {
         return this.console.config;
      }
      
      protected function get style() : ConsoleStyle
      {
         return this.console.config.style;
      }
      
      protected function init(param1:Number, param2:Number, param3:Boolean = false, param4:Number = -1, param5:Number = -1, param6:int = -1) : void
      {
         this.bg.graphics.clear();
         this.bg.graphics.beginFill(param4 >= 0 ? param4 : this.style.backgroundColor,param5 >= 0 ? param5 : this.style.numValue24);
         if(param6 < 0)
         {
            param6 = this.style.intValue86;
         }
         if(param6 <= 0)
         {
            this.bg.graphics.drawRect(0,0,100,100);
         }
         else
         {
            this.bg.graphics.drawRoundRect(0,0,param6 + 10,param6 + 10,param6,param6);
            this.bg.scale9Grid = new Rectangle(param6 * 0.5,param6 * 0.5,10,10);
         }
         isValue63 = param3;
         width = param1;
         height = param2;
      }
      
      public function close() : void
      {
         this.doAction281();
         this.console.panels.tooltip();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         dispatchEvent(new Event(VISIBILITY_CHANGED));
      }
      
      override public function set width(param1:Number) : void
      {
         if(param1 < this.minWidth)
         {
            param1 = this.minWidth;
         }
         if(this.scaler)
         {
            this.scaler.x = param1;
         }
         this.bg.width = param1;
      }
      
      override public function set height(param1:Number) : void
      {
         if(param1 < this.minHeight)
         {
            param1 = this.minHeight;
         }
         if(this.scaler)
         {
            this.scaler.y = param1;
         }
         this.bg.height = param1;
      }
      
      override public function get width() : Number
      {
         return this.bg.width;
      }
      
      override public function get height() : Number
      {
         return this.bg.height;
      }
      
      public function doAction72(param1:Array, param2:Array) : void
      {
         array38 = [param1,param2];
      }
      
      protected function doAction246(param1:DisplayObject, param2:Boolean = false) : void
      {
         if(param2)
         {
            param1.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown2);
         }
         else
         {
            param1.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown2,false,0,true);
         }
      }
      
      private function onMouseDown2(param1:MouseEvent) : void
      {
         if(!stage || !this.flag21)
         {
            return;
         }
         textField28 = this.makeTF("positioningField",true);
         this.textField28.mouseEnabled = false;
         this.textField28.autoSize = TextFieldAutoSize.LEFT;
         addChild(this.textField28);
         this.doAction622();
         point6 = new Point(x,y);
         point3 = new Point(mouseX,mouseY);
         array38 = [[],[]];
         dispatchEvent(new Event(DRAGGING));
         stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp,false,0,true);
         stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove,false,0,true);
      }
      
      private function onStageMouseMove(param1:MouseEvent = null) : void
      {
         if(this.style.intValue15 == 0)
         {
            return;
         }
         var position:Point = this.getPoint4(parent.mouseX - this.point3.x,parent.mouseY - this.point3.y);
         x = position.x;
         y = position.y;
         this.doAction622();
      }
      
      private function doAction622() : void
      {
         this.textField28.text = "<low>" + x + "," + y + "</low>";
      }
      
      private function onStageMouseUp(param1:MouseEvent) : void
      {
         this.doAction281();
      }
      
      private function doAction281() : void
      {
         array38 = null;
         if(stage)
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove);
         }
         if(this.textField28 && this.textField28.parent)
         {
            this.textField28.parent.removeChild(this.textField28);
         }
         textField28 = null;
      }
      
      public function moveBackSafePosition() : void
      {
         if(this.point6 != null)
         {
            if(x + this.width < 10 || stage && stage.stageWidth < x + 10 || y + this.height < 10 || stage && stage.stageHeight < y + 20)
            {
               x = this.point6.x;
               y = this.point6.y;
            }
            point6 = null;
         }
      }
      
      public function get isValue63() : Boolean
      {
         return this.scaler ? true : false;
      }
      
      public function set isValue63(param1:Boolean) : void
      {
         var scalerSize:uint = 0;
         if(param1 && !this.scaler)
         {
            scalerSize = 8 + this.style.controlSize * 0.5;
            scaler = new Sprite();
            this.scaler.name = "scaler";
            this.scaler.graphics.beginFill(0,0);
            this.scaler.graphics.drawRect(-scalerSize * 1.5,-scalerSize * 1.5,scalerSize * 1.5,scalerSize * 1.5);
            this.scaler.graphics.endFill();
            this.scaler.graphics.beginFill(this.style.controlColor,this.style.numValue24);
            this.scaler.graphics.moveTo(0,0);
            this.scaler.graphics.lineTo(-scalerSize,0);
            this.scaler.graphics.lineTo(0,-scalerSize);
            this.scaler.graphics.endFill();
            this.scaler.buttonMode = true;
            this.scaler.doubleClickEnabled = true;
            this.scaler.addEventListener(MouseEvent.MOUSE_DOWN,this.onScalerMouseDown,false,0,true);
            addChildAt(this.scaler,getChildIndex(this.bg) + 1);
         }
         else if(!param1 && this.scaler)
         {
            if(contains(this.scaler))
            {
               removeChild(this.scaler);
            }
            scaler = null;
         }
      }
      
      private function onScalerMouseDown(param1:Event) : void
      {
         textField28 = this.makeTF("resizingField",true);
         this.textField28.mouseEnabled = false;
         this.textField28.autoSize = TextFieldAutoSize.RIGHT;
         this.textField28.x = -4;
         this.textField28.y = -17;
         this.scaler.addChild(this.textField28);
         this.doAction665();
         point3 = new Point(this.scaler.mouseX,this.scaler.mouseY);
         array38 = [[],[]];
         this.scaler.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp2,false,0,true);
         this.scaler.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove2,false,0,true);
         dispatchEvent(new Event(SCALING));
      }
      
      private function onStageMouseMove2(param1:Event = null) : void
      {
         var position:Point = this.getPoint4(x + mouseX - this.point3.x,y + mouseY - this.point3.x);
         position.x -= x;
         position.y -= y;
         width = position.x < this.minWidth ? this.minWidth : position.x;
         height = position.y < this.minHeight ? this.minHeight : position.y;
         this.doAction665();
      }
      
      private function doAction665() : void
      {
         this.textField28.text = "<low>" + this.width + "," + this.height + "</low>";
      }
      
      public function doAction77() : void
      {
         this.onStageMouseUp2(null);
      }
      
      private function onStageMouseUp2(param1:Event) : void
      {
         this.scaler.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUp2);
         this.scaler.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onStageMouseMove2);
         this.onStageMouseMove2();
         array38 = null;
         if(this.textField28 && this.textField28.parent)
         {
            this.textField28.parent.removeChild(this.textField28);
         }
         textField28 = null;
      }
      
      public function makeTF(param1:String, param2:Boolean = false) : TextField
      {
         var textField:TextField = new TextField();
         textField.name = param1;
         textField.styleSheet = this.style.styleSheet;
         if(param2)
         {
            textField.background = true;
            textField.backgroundColor = this.style.backgroundColor;
         }
         return textField;
      }
      
      private function getPoint4(param1:Number, param2:Number) : Point
      {
         return new Point(this.getNumber2(param1,true),this.getNumber2(param2,false));
      }
      
      private function getNumber2(param1:Number, param2:Boolean) : Number
      {
         var oppositeEdge:Number = param1 + this.width;
         var snapEdges:Array = this.array38[param2 ? 0 : 1];
         var snapDistance:int = this.style.intValue15;
         var edge:Number;
         for each(edge in snapEdges)
         {
            if(Math.abs(edge - param1) < snapDistance)
            {
               return edge;
            }
            if(Math.abs(edge - oppositeEdge) < snapDistance)
            {
               return edge - this.width;
            }
         }
         return param1;
      }
      
      protected function doAction732(param1:TextField, param2:Function, param3:Function = null) : void
      {
         param1.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OUT,onRollOut,false,0,true);
         param1.addEventListener(TEXT_ROLL,param2,false,0,true);
         if(param3 != null)
         {
            param1.addEventListener(TextEvent.LINK,param3,false,0,true);
         }
      }
   }
}

