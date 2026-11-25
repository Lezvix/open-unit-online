package game.npc
{
   import flash.geom.ColorTransform;
   import flash.utils.getTimer;
   
   public class TargetDummy extends PlayerItem
   {
      
      protected static const colorTransform4:ColorTransform = new ColorTransform();
      
      public function TargetDummy()
      {
         super();
         headAnchor.y = -80;
      }
      
      override public function get running() : Boolean
      {
         return false;
      }
      
      override public function set highlight(param1:int) : void
      {
         if(login == "Мишень")
         {
            if(state == stDead)
            {
               return;
            }
            _playerHighlight = param1;
            switch(param1)
            {
               case PLAYER_ITEM_CONST1:
                  bitmapData2.colorTransform(drawRect,colorTransform1);
                  break;
               case PLAYER_ITEM_CONST2:
               default:
                  colorTransform4.redMultiplier = colorTransform4.greenMultiplier = colorTransform4.blueMultiplier = Math.sin(getTimer() / 300) * 0.5 + 1.5;
                  bitmapData2.colorTransform(drawRect,colorTransform4);
                  break;
            }
         }
         else
         {
            super.highlight = param1;
         }
      }
      
      override protected function get deathSounds() : Array
      {
         return [61];
      }
   }
}

