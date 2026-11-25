package ui.menus
{
   import core.ui.UIComponent;
   import core.ui.UIElement;
   import debug.Assert;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   
   public class ModalLayer extends UIComponent
   {
      
      private static const GRAYSCALE_FILTERS:Array = [new ColorMatrixFilter([0.2225,0.7169,0.0606,0,0,0.2225,0.7169,0.0606,0,0,0.2225,0.7169,0.0606,0,0,0,0,0,1,0])];
      
      protected var mainMenu:BaseMenu;
      
      protected var modalMenu:BaseMenu;
      
      public function ModalLayer(menu:BaseMenu)
      {
         super();
         this.mainMenu = menu;
         addUIChild(menu);
         width = menu.width;
         height = menu.height;
      }
      
      public function showModal(modal:BaseMenu, grayscale:Boolean = false) : void
      {
         Assert.isTrue(this.modalMenu == null);
         modalMenu = modal;
         addUIChild(modal);
         this.menu.addChild(modal);
         modal.centerInParent();
         var position:Point = globalToLocal(modal.localToGlobal(modal.getBounds(this.menu).topLeft));
         addChild(modal);
         modal.setPos(position.x - (this.menu.W - modal.W) / 2,position.y - (this.menu.H - modal.H) / 2);
         if(grayscale)
         {
            this.menu.filters = GRAYSCALE_FILTERS;
         }
         this.menu.enabled = false;
      }
      
      public function centerMenu(areaWidth:int, areaHeight:int) : void
      {
         setPos(Math.max(0,int((areaWidth - width) / 2)),Math.max(0,int((areaHeight - height) / 2)));
      }
      
      override public function removeUIChild(child:UIElement) : void
      {
         if(child == this.modalMenu)
         {
            modalMenu = null;
            this.menu.filters = null;
            this.menu.enabled = true;
         }
         super.removeUIChild(child);
         if(child == this.mainMenu)
         {
            mainMenu = null;
            (parent as UIComponent).removeUIChild(this);
         }
      }
      
      public function get menu() : BaseMenu
      {
         return this.mainMenu;
      }
   }
}

