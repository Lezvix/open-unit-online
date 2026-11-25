package core.ui.views
{
   import core.ui.UIComponent;
   import flash.geom.Rectangle;
   
   public class ImageView extends UIComponent
   {
      
      private var iconView:Picture;
      
      private var flag43:Boolean;
      
      public function ImageView(param1:Boolean = true)
      {
         super(true);
         this.flag43 = param1;
         handlesMouse = false;
      }
      
      public function get isValue28() : Boolean
      {
         return this.flag43;
      }
      
      public function set isValue28(param1:Boolean) : void
      {
         if(this.flag43 != param1)
         {
            if(this.iconView)
            {
               this.iconView.isValue28 = flag43 = param1;
            }
            this._redraw();
         }
      }
      
      public function get image() : Picture
      {
         return this.iconView;
      }
      
      override protected function _initView(param1:Object) : void
      {
         super._initView(param1);
         iconView = new Picture(this.flag43);
         this.iconView.width = width;
         this.iconView.height = height;
         this.iconView.flipHorizontaly = param1.flipHorizontaly;
         this.iconView.flipVerticaly = param1.flipVerticaly;
         this.iconView.leftPadding = param1.leftPadding;
         this.iconView.rightPadding = param1.rightPadding;
         this.iconView.topPadding = param1.topPadding;
         this.iconView.bottomPadding = param1.bottomPadding;
         this.iconView.mode = param1.mode;
         this.iconView.doAction549(param1.image);
         addChild(this.iconView);
      }
      
      override public function dispose() : void
      {
         if(this.iconView)
         {
            this.iconView.dispose();
         }
         super.dispose();
      }
      
      override public function reshape(param1:Rectangle = null) : void
      {
         super.reshape(param1);
         if(this.iconView)
         {
            this.iconView.setActualSize(width,height);
         }
      }
      
      override protected function _redraw() : void
      {
         super._redraw();
         if(this.iconView)
         {
            this.iconView.doAction316();
         }
      }
   }
}

