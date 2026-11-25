package ui.buttons
{
   import flash.display.DisplayObject;
   
   public class ToggleButton extends NButton
   {
      
      protected var displayObject5:DisplayObject;
      
      protected var displayObject2:DisplayObject;
      
      protected var _toggled:Boolean = false;
      
      public function ToggleButton(param1:Function, param2:DisplayObject, param3:DisplayObject, param4:DisplayObject, param5:DisplayObject = null, param6:String = "")
      {
         super(param1,param2,param3,param4,null,param6);
         this.displayObject2 = (param5 == null) ? param4 : param5;
         this.displayObject5 = param2;
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
         upState = this.displayObject2;
         setCurrentDO(upState);
      }
      
      public function toggleOff() : void
      {
         _toggled = false;
         upState = this.displayObject5;
         setCurrentDO(upState);
      }
   }
}

