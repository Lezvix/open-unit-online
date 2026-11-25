package ui.buttons
{
   import core.ui.BaseApplication;
   import core.ui.Cursor;
   import core.ui.UIElement;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import ui.GameCursor;
   
   public final dynamic class SelectableButton extends UIElement
   {
      
      private static const DEFAULT_WIDTH:int = 200;
      
      private static const DEFAULT_HEIGHT:int = 20;
      
      protected static const colorHighlighted:ColorTransform = new ColorTransform(1,1,1,1,45,35,15);
      
      protected static const colorNormal:ColorTransform = new ColorTransform();
      
      protected var baseColor:uint = 1776411;
      
      protected var borderColor:uint = 3156252;
      
      protected var textColor:uint = 10187041;
      
      protected var textSize:Number = 10;
      
      protected var _enabledState:Boolean;
      
      protected var _active:Boolean;
      
      protected var colorTransform:ColorTransform;
      
      protected var displayObjects:Array = new Array();
      
      protected var isOver:Boolean = false;
      
      public function SelectableButton(props:Object)
      {
         var key:*;
         super();
         for(key in props)
         {
            this[key] = props[key];
         }
         this.colorTransform = colorNormal;
         transform.colorTransform = this.colorTransform;
         this.drawButtonShape(props.width ? props.width : DEFAULT_WIDTH,props.height ? props.height : DEFAULT_HEIGHT);
         this.Selected = "selected" in props ? props.selected : false;
         this.Enabled = "enabled" in props ? props.enabled : true;
      }
      
      public function addLabel(str:String, align:String = "left") : void
      {
         var format:TextFormat = new TextFormat("Verdana",this.textSize,this.textColor);
         format.align = align;
         var textField:TextField = new TextField();
         textField.selectable = false;
         textField.defaultTextFormat = format;
         textField.width = width - 6;
         textField.text = str;
         textField.height = textField.textHeight + 5;
         textField.x = 3;
         textField.y = (height - textField.height) / 2;
         textField.transform.colorTransform = this.colorTransform;
         this.displayObjects.push(textField);
         addChild(textField);
      }
      
      public function addBitmap(bitmap:Bitmap, posX:Number = 0, posY:Number = 0) : void
      {
         bitmap.x = posX;
         bitmap.y = posY;
         this.displayObjects.push(bitmap);
         addChild(bitmap);
      }
      
      public function getLabel(index:int) : TextField
      {
         return this.displayObjects[index] as TextField;
      }
      
      public function get Enabled() : Boolean
      {
         return this._enabledState;
      }
      
      public function set Enabled(value:Boolean) : void
      {
         if(this._enabledState != value)
         {
            _enabledState = value;
            if(!value)
            {
               Selected = false;
               isOver = false;
            }
         }
      }
      
      public function get Selected() : Boolean
      {
         return this._active;
      }
      
      public function set Selected(value:Boolean) : void
      {
         var child:DisplayObject = null;
         if(this._active != value)
         {
            _active = value;
            colorTransform = value ? colorHighlighted : colorNormal;
            transform.colorTransform = this.colorTransform;
            for each(child in this.displayObjects)
            {
               child.transform.colorTransform = this.colorTransform;
            }
         }
      }
      
      protected function drawButtonShape(shapeWidth:Number, shapeHeight:Number) : void
      {
         graphics.lineStyle(1,this.borderColor);
         graphics.beginFill(this.baseColor);
         graphics.drawRect(0,0,shapeWidth,shapeHeight);
         graphics.endFill();
         this.width = shapeWidth;
         this.height = shapeHeight;
      }
      
      override protected function includesMouse() : Boolean
      {
         return this.Enabled && visible && mouseX < width && mouseX >= 0 && mouseY < height && mouseY >= 0;
      }
      
      override public function mouseDownHandler() : void
      {
         Selected = !this.Selected;
         if(this.clickHandler)
         {
            this.clickHandler(this);
         }
      }
      
      override public function mouseUpHandler() : void
      {
      }
      
      public function get sceneItem() : DisplayObject
      {
         return this;
      }
      
      override public function get cursorId() : int
      {
         return this.Enabled && this.isOver ? GameCursor.CURSOR_1 : Cursor.CURSOR_DEFAULT;
      }
      
      override public function mouseOverHandler() : void
      {
         var child:DisplayObject = null;
         if(this.Enabled && !this.Selected)
         {
            colorTransform = colorHighlighted;
            transform.colorTransform = this.colorTransform;
            for each(child in this.displayObjects)
            {
               child.transform.colorTransform = this.colorTransform;
            }
            isOver = true;
         }
         if(this.hint)
         {
            BaseApplication.showHint(this.hint);
         }
      }
      
      override public function mouseOutHandler() : void
      {
         var child:DisplayObject = null;
         if(this.Enabled && !this.Selected)
         {
            colorTransform = colorNormal;
            transform.colorTransform = this.colorTransform;
            for each(child in this.displayObjects)
            {
               child.transform.colorTransform = this.colorTransform;
            }
            isOver = false;
         }
         if(this.hint)
         {
            BaseApplication.hideHint();
         }
      }
   }
}

