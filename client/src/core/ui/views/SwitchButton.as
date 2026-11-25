package core.ui.views
{
   public class SwitchButton extends ButtonView
   {
      
      protected var _toggled:Boolean = false;
      
      protected var selectedUpStateIndex:int = 0;
      
      public function SwitchButton()
      {
         super();
      }
      
      override protected function _initView(param1:Object) : void
      {
         super._initView(param1);
         if(pictureList1[BUTTON_VIEW_CONST3])
         {
            selectedUpStateIndex = BUTTON_VIEW_CONST3;
         }
         else if(pictureList1[BUTTON_VIEW_CONST2])
         {
            selectedUpStateIndex = BUTTON_VIEW_CONST2;
         }
      }
      
      public function get toggled() : Boolean
      {
         return this._toggled;
      }
      
      public function set toggled(param1:Boolean) : void
      {
         if(param1 != this._toggled)
         {
            this.doAction172();
         }
      }
      
      public function doAction172() : void
      {
         if(this._toggled)
         {
            this.toggleOff();
         }
         else
         {
            this.toggleOn();
         }
      }
      
      public function toggleOn() : void
      {
         _toggled = true;
         upState = pictureList1[this.selectedUpStateIndex];
         setCurrentDO(upState);
      }
      
      public function toggleOff() : void
      {
         _toggled = false;
         upState = pictureList1[BUTTON_VIEW_CONST4];
         setCurrentDO(upState);
      }
      
      override protected function onClick(param1:Object) : void
      {
         this.doAction172();
         super.onClick(param1);
      }
   }
}

