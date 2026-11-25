package ui
{
   import ui.buttons.NButton;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   
   public class PvpRankIcon extends NButton
   {
      
      private var _blank:DisplayObject = new Shape();
      
      private var _rank:int;
      
      public function PvpRankIcon()
      {
         super(null,this._blank);
      }
      
      public function get propValue95() : int
      {
         return this._rank;
      }
      
      public function set propValue95(param1:int) : void
      {
         if(param1 != this._rank)
         {
            _rank = param1;
            if(this._rank > 0)
            {
               upState = getBmp("RANK_" + this._rank);
               hintText = NUIComponent.formatString("IDS_PVP_RANK_TEMPLATE",this._rank);
            }
            else
            {
               upState = this._blank;
            }
         }
      }
   }
}

