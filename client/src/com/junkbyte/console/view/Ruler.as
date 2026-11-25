package com.junkbyte.console.view
{
   import com.junkbyte.console.ConsoleConfig;
   import com.junkbyte.console.ConsoleStyle;
   import com.junkbyte.console.Console;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.ui.Mouse;
   
   public class Ruler extends Sprite
   {
      
      private var _master:Console;
      
      private var _config:ConsoleConfig;
      
      private var _area:Rectangle;
      
      private var shape5:Shape;
      
      private var textField18:TextField;
      
      private var bitmap15:Bitmap;
      
      private var array114:Array;
      
      public function Ruler(param1:Console)
      {
         super();
         this._master = param1;
         this._config = param1.config;
         buttonMode = true;
         this.array114 = new Array();
         this.shape5 = new Shape();
         addChild(this.shape5);
         var origin:Point = new Point();
         origin = globalToLocal(origin);
         this._area = new Rectangle(-param1.stage.stageWidth * 1.5 + origin.x,-param1.stage.stageHeight * 1.5 + origin.y,param1.stage.stageWidth * 3,param1.stage.stageHeight * 3);
         graphics.beginFill(this._config.style.backgroundColor,0.2);
         graphics.drawRect(this._area.x,this._area.y,this._area.width,this._area.height);
         graphics.endFill();
         this.textField18 = this._master.panels.mainPanel.makeTF("positionText",true);
         this.textField18.autoSize = TextFieldAutoSize.LEFT;
         addChild(this.textField18);
         this.bitmap15 = new Bitmap();
         this.bitmap15.scaleY = this.bitmap15.scaleX = 2;
         addChild(this.bitmap15);
         addEventListener(MouseEvent.CLICK,this.onClick2,false,0,true);
         addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove2,false,0,true);
         this.onMouseMove2();
         if(this._config.flag130)
         {
            Mouse.hide();
         }
         this._master.report("<b>Ruler started. Click on two locations to measure.</b>",-1);
      }
      
      private function onMouseMove2(e:MouseEvent = null) : void
      {
         this.shape5.graphics.clear();
         this.shape5.graphics.lineStyle(1,11193344,1);
         this.shape5.graphics.moveTo(this._area.x,mouseY);
         this.shape5.graphics.lineTo(this._area.x + this._area.width,mouseY);
         this.shape5.graphics.moveTo(mouseX,this._area.y);
         this.shape5.graphics.lineTo(mouseX,this._area.y + this._area.height);
         this.shape5.blendMode = BlendMode.INVERT;
         this.textField18.text = "<low>" + mouseX + "," + mouseY + "</low>";
         var bmd:BitmapData = new BitmapData(30,30);
         try
         {
            var m:Matrix = new Matrix();
            m.tx = -stage.mouseX + 15;
            m.ty = -stage.mouseY + 15;
            bmd.draw(stage,m);
         }
         catch(err:Error)
         {
            bmd = null;
         }
         this.bitmap15.bitmapData = bmd;
         var d:int = 10;
         this.textField18.x = mouseX - this.textField18.width - d;
         this.textField18.y = mouseY - this.textField18.height - d;
         this.bitmap15.x = this.textField18.x + this.textField18.width - this.bitmap15.width;
         this.bitmap15.y = this.textField18.y - this.bitmap15.height;
         if(this.textField18.x < 16)
         {
            this.textField18.x = mouseX + d;
            this.bitmap15.x = this.textField18.x;
         }
         if(this.textField18.y < 38)
         {
            this.textField18.y = mouseY + d;
            this.bitmap15.y = this.textField18.y + this.textField18.height;
         }
      }
      
      private function onClick2(param1:MouseEvent) : void
      {
         var firstPoint:Point;
         param1.stopPropagation();
         var consoleStyle:ConsoleStyle = this._config.style;
         var secondPoint:Point;
         var midPoint:Point;
         var leftPoint:Point;
         var rightPoint:Point;
         var topPoint:Point;
         var bottomPoint:Point;
         var horizontalDistance:Number;
         var verticalDistance:Number;
         var distanceValue:Number;
         var label:TextField;
         var firstAngle:Number;
         var secondAngle:Number;
         if(this.array114.length == 0)
         {
            firstPoint = new Point(param1.localX,param1.localY);
            graphics.lineStyle(1,16711680);
            graphics.drawCircle(firstPoint.x,firstPoint.y,3);
            this.array114.push(firstPoint);
         }
         else if(this.array114.length == 1)
         {
            this.bitmap15.bitmapData = null;
            if(this._config.flag130)
            {
               Mouse.show();
            }
            removeChild(this.shape5);
            removeChild(this.textField18);
            removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove2);
            firstPoint = this.array114[0];
            secondPoint = new Point(param1.localX,param1.localY);
            this.array114.push(secondPoint);
            graphics.clear();
            graphics.beginFill(consoleStyle.backgroundColor,0.4);
            graphics.drawRect(this._area.x,this._area.y,this._area.width,this._area.height);
            graphics.endFill();
            graphics.lineStyle(1.5,16711680);
            graphics.drawCircle(firstPoint.x,firstPoint.y,4);
            graphics.lineStyle(1.5,16750848);
            graphics.drawCircle(secondPoint.x,secondPoint.y,4);
            midPoint = Point.interpolate(firstPoint,secondPoint,0.5);
            graphics.lineStyle(1,11184810);
            graphics.drawCircle(midPoint.x,midPoint.y,4);
            leftPoint = firstPoint;
            rightPoint = secondPoint;
            if(firstPoint.x > secondPoint.x)
            {
               leftPoint = secondPoint;
               rightPoint = firstPoint;
            }
            topPoint = firstPoint;
            bottomPoint = secondPoint;
            if(firstPoint.y > secondPoint.y)
            {
               topPoint = secondPoint;
               bottomPoint = firstPoint;
            }
            horizontalDistance = rightPoint.x - leftPoint.x;
            verticalDistance = bottomPoint.y - topPoint.y;
            distanceValue = Point.distance(firstPoint,secondPoint);
            label = this.getTextField1(consoleStyle.highColor);
            label.text = this.round(firstPoint.x) + "," + this.round(firstPoint.y);
            label.x = firstPoint.x;
            label.y = firstPoint.y - (topPoint == firstPoint ? 14 : 0);
            addChild(label);
            label = this.getTextField1(consoleStyle.highColor);
            label.text = this.round(secondPoint.x) + "," + this.round(secondPoint.y);
            label.x = secondPoint.x;
            label.y = secondPoint.y - (topPoint == secondPoint ? 14 : 0);
            addChild(label);
            if(horizontalDistance > 40 || verticalDistance > 25)
            {
               label = this.getTextField1(consoleStyle.uintValue6);
               label.text = this.round(midPoint.x) + "," + this.round(midPoint.y);
               label.x = midPoint.x;
               label.y = midPoint.y;
               addChild(label);
            }
            graphics.lineStyle(1,11193344,0.5);
            graphics.moveTo(this._area.x,topPoint.y);
            graphics.lineTo(this._area.x + this._area.width,topPoint.y);
            graphics.moveTo(this._area.x,bottomPoint.y);
            graphics.lineTo(this._area.x + this._area.width,bottomPoint.y);
            graphics.moveTo(leftPoint.x,this._area.y);
            graphics.lineTo(leftPoint.x,this._area.y + this._area.height);
            graphics.moveTo(rightPoint.x,this._area.y);
            graphics.lineTo(rightPoint.x,this._area.y + this._area.height);
            firstAngle = this.round(this.getNumber3(firstPoint,secondPoint),100);
            secondAngle = this.round(this.getNumber3(secondPoint,firstPoint),100);
            graphics.lineStyle(1,11141120,0.8);
            this.getPoint1(graphics,10,firstPoint,firstAngle,-90);
            graphics.lineStyle(1,13404160,0.8);
            this.getPoint1(graphics,10,secondPoint,secondAngle,-90);
            graphics.lineStyle(2,65280,0.7);
            graphics.moveTo(firstPoint.x,firstPoint.y);
            graphics.lineTo(secondPoint.x,secondPoint.y);
            this._master.report("Ruler results: (red) <b>[" + firstPoint.x + "," + firstPoint.y + "]</b> to (orange) <b>[" + secondPoint.x + "," + secondPoint.y + "]</b>",-2);
            this._master.report("Distance: <b>" + this.round(distanceValue,100) + "</b>",-2);
            this._master.report("Mid point: <b>[" + midPoint.x + "," + midPoint.y + "]</b>",-2);
            this._master.report("Width:<b>" + horizontalDistance + "</b>, Height: <b>" + verticalDistance + "</b>",-2);
            this._master.report("Angle from first point (red): <b>" + firstAngle + "°</b>",-2);
            this._master.report("Angle from second point (orange): <b>" + secondAngle + "°</b>",-2);
         }
         else
         {
            this.doAction201();
         }
      }
      
      public function doAction201() : void
      {
         _master = null;
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function getTextField1(param1:Number, param2:Boolean = true) : TextField
      {
         var labelFormat:TextFormat = new TextFormat(this._config.style.menuFont,this._config.style.menuFontSize,param1,param2,true,null,null,TextFormatAlign.RIGHT);
         var label:TextField = new TextField();
         label.autoSize = TextFieldAutoSize.RIGHT;
         label.selectable = false;
         label.defaultTextFormat = labelFormat;
         return label;
      }
      
      private function round(param1:Number, param2:uint = 10) : Number
      {
         return Math.round(param1 * param2) / param2;
      }
      
      private function getNumber3(param1:Point, param2:Point) : Number
      {
         var angle:Number = Math.atan2(param2.y - param1.y,param2.x - param1.x) / Math.PI * 180;
         angle += 90;
         if(angle > 180)
         {
            angle -= 360;
         }
         return angle;
      }
      
      private function getPoint1(param1:Graphics, param2:Number, param3:Point, param4:Number = 180, param5:Number = 0) : Point
      {
         var reverse:Boolean = false;
         if(param4 < 0)
         {
            reverse = true;
            param4 = Math.abs(param4);
         }
         var sweepRadians:Number = param4 * Math.PI / 180;
         var startRadians:Number = param5 * Math.PI / 180;
         var endPoint:Point = this.getPoint3(param2,startRadians);
         endPoint.offset(param3.x,param3.y);
         param1.moveTo(endPoint.x,endPoint.y);
         var previousAngle:Number = 0;
         var stepIndex:int = 1;
         var currentAngle:Number;
         var angleStep:Number;
         var controlScale:Number;
         var controlPoint:Point;
         while(stepIndex <= sweepRadians + 1)
         {
            currentAngle = stepIndex <= sweepRadians ? stepIndex : sweepRadians;
            angleStep = currentAngle - previousAngle;
            controlScale = 1 + 0.12 * angleStep * angleStep;
            controlPoint = this.getPoint3(param2 * controlScale,(currentAngle - angleStep / 2) * (reverse ? -1 : 1) + startRadians);
            controlPoint.offset(param3.x,param3.y);
            endPoint = this.getPoint3(param2,currentAngle * (reverse ? -1 : 1) + startRadians);
            endPoint.offset(param3.x,param3.y);
            param1.curveTo(controlPoint.x,controlPoint.y,endPoint.x,endPoint.y);
            previousAngle = currentAngle;
            stepIndex++;
         }
         return endPoint;
      }
      
      private function getPoint3(param1:Number, param2:Number) : Point
      {
         return new Point(param1 * Math.cos(param2),param1 * Math.sin(param2));
      }
   }
}

