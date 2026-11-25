package core.ui.views
{
   import core.ui.UIComponent;
   import flash.geom.Rectangle;
   
   public class ContainerView extends UIComponent
   {
      
      protected var uiComponentList1:Vector.<UIComponent> = new Vector.<UIComponent>();
      
      public function ContainerView()
      {
         super(true);
      }
      
      override public function reshape(param1:Rectangle = null) : void
      {
         super.reshape(param1);
         this.sortItems();
      }
      
      public function add(param1:UIComponent) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         this.uiComponentList1.push(param1);
         addView(param1);
         this.sortItems(this.uiComponentList1.length - 1);
         return true;
      }
      
      protected function sortItems(param1:int = 0) : void
      {
      }
      
      public function doAction864(param1:*) : void
      {
         var item:UIComponent = null;
         for each(item in param1)
         {
            this.add(item);
         }
      }
      
      public function doAction475(param1:*) : void
      {
         this.clear();
         if(param1)
         {
            this.doAction864(param1);
         }
      }
      
      public function clear() : void
      {
         var index:int = 0;
         while(index < this.uiComponentList1.length)
         {
            if(check23(this.uiComponentList1[index]))
            {
               removeUIChild(this.uiComponentList1[index]);
            }
            else
            {
               removeChild(this.uiComponentList1[index]);
            }
            index++;
         }
         this.uiComponentList1.splice(0,this.uiComponentList1.length);
      }
   }
}

