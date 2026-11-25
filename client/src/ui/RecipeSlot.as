package ui
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.net.URLRequest;
   import flash.text.TextField;
   
   public class RecipeSlot extends NUIComponent
   {
      
      public static const WIDTH:int = 96;
      
      private static const HEIGHT:int = 56;
      
      private static const NAME_FORMAT:NTextFormat = NTextFormat.normal.derive({
         "size":9,
         "letterSpacing":-1
      });
      
      private static const COUNT_FILTERS:Array = [new GlowFilter(1776411,0.5,1.1,1.1,15,BitmapFilterQuality.HIGH)];
      
      private static const NO_FILTERS:Array = [];
      
      private static const GLOW_FILTERS:Array = [new GlowFilter(14266157,0.25,5,5,3,BitmapFilterQuality.HIGH)];
      
      private var _recipe:Object = null;
      
      private var _task:Object = null;
      
      private var iconView:DisplayObject = null;
      
      private var _selected:Boolean = false;
      
      private var selectHandler:Function = null;
      
      private var flag98:Boolean = false;
      
      public function RecipeSlot(onSelect:Function = null)
      {
         super();
         this.selectHandler = onSelect;
         this.updateView();
      }
      
      public function clear() : void
      {
         this.setRecipe(null);
      }
      
      public function setRecipe(recipe:Object, task:Object = null) : void
      {
         _recipe = recipe;
         this.removeListeners();
         iconView = null;
         _task = task;
         removeChildren();
         this.updateView();
      }
      
      private function updateView() : void
      {
         this.drawBackground();
         if(this._recipe != null)
         {
            if(this._recipe.type == 0)
            {
               var textField:TextField = new TextField();
               textField.defaultTextFormat = NAME_FORMAT;
               textField.height = 22;
               textField.width = WIDTH - 1;
               textField.text = this._recipe.product.item.itemname + " ";
               textField.x = 1;
               textField.y = HEIGHT - 16;
               addChild(textField);
               textField = new TextField();
               textField.defaultTextFormat = NTextFormat.normal;
               textField.x = 2;
               textField.text = "" + this._recipe.product.count;
               textField.filters = COUNT_FILTERS;
               textField.height = 22;
               textField.width = WIDTH - 2;
               addChild(textField);
               var loader:Loader = new Loader();
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onIconLoad);
               loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIconError);
               loader.load(new URLRequest("icons/inv/i" + this._recipe.product.item.image + ".png"));
               iconView = loader;
            }
            else
            {
               iconView = getBmp("FACTORY_UPGRADE_" + this._recipe.upgrade.type);
               this.iconView.x = (WIDTH - this.iconView.width) / 2;
               this.iconView.y = (HEIGHT - this.iconView.height) / 2;
               addChild(this.iconView);
            }
         }
      }
      
      private function removeListeners() : void
      {
         var loader:Loader = null;
         if(this.iconView != null && this.iconView is Loader)
         {
            loader = Loader(this.iconView);
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onIconLoad);
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onIconError);
         }
      }
      
      private function onIconLoad(event:Event) : void
      {
         this.removeListeners();
         this.iconView.x = (WIDTH - this.iconView.width) / 2;
         this.iconView.y = (HEIGHT - this.iconView.height) / 2 - 6;
         addChild(this.iconView);
         setChildIndex(this.iconView,0);
      }
      
      private function onIconError(event:Event) : void
      {
         this.removeListeners();
      }
      
      private function drawBackground() : void
      {
         graphics.clear();
         graphics.lineStyle(1,3156252);
         if(this.Selected)
         {
            graphics.beginFill(3156252,0.7);
         }
         else
         {
            graphics.beginFill(1776411);
         }
         if(this.iconView != null)
         {
            this.iconView.filters = this.Selected ? GLOW_FILTERS : NO_FILTERS;
         }
         graphics.drawRect(0,0,WIDTH,HEIGHT);
         if(this._recipe != null && this._recipe.type != 1)
         {
            graphics.lineStyle();
            graphics.beginFill(4013373);
            graphics.drawRect(1,HEIGHT - 16,WIDTH - 1,16);
         }
         graphics.endFill();
      }
      
      public function get Selected() : Boolean
      {
         return this._selected;
      }
      
      public function get recipeData() : Object
      {
         return this._recipe;
      }
      
      public function get taskData() : Object
      {
         return this._task;
      }
      
      public function set Selected(value:Boolean) : void
      {
         if(this._selected != value)
         {
            _selected = value;
            this.drawBackground();
         }
      }
      
      override public function mouseDownHandler() : void
      {
         if(this.selectHandler != null)
         {
            this.selectHandler(this);
         }
      }
      
      override public function get cursorId() : int
      {
         return GameCursor.CURSOR_1;
      }
      
      override public function mouseOverHandler() : void
      {
         super.mouseOverHandler();
         if(this.iconView != null)
         {
            this.iconView.filters = GLOW_FILTERS;
         }
      }
      
      override public function mouseOutHandler() : void
      {
         super.mouseOutHandler();
         if(this.iconView != null && !this.Selected)
         {
            this.iconView.filters = NO_FILTERS;
         }
      }
      
      public function setLevelBadge(level:int, color:uint) : void
      {
         if(level > 0)
         {
            var badge:Sprite = new Sprite();
            badge.graphics.lineStyle(1,3156252);
            badge.graphics.drawRect(0,0,16,16);
            var textField:TextField = new TextField();
            textField.width = 16;
            textField.height = 16;
            textField.y = 0;
            textField.x = 1;
            textField.defaultTextFormat = NTextFormat.plain.center.derive({"color":color});
            textField.text = level.toString();
            badge.addChild(textField);
            badge.x = WIDTH - 18;
            badge.y = 2;
            addChild(badge);
         }
      }
   }
}

