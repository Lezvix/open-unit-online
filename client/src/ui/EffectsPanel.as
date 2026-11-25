package ui
{
   import ui.buttons.EffectIcon;
   import events.EventType;
   import events.UnitEventDispatcher;
   
   public class EffectsPanel extends NUIComponent
   {
      
      protected const icons:Vector.<EffectIcon> = new Vector.<EffectIcon>();
      
      public function EffectsPanel()
      {
         super();
         processIntervalValue = 1000;
         UnitEventDispatcher.instance.addListener(EventType.EffectUpdated,this.onEffectChanged);
         UnitEventDispatcher.instance.addListener(EventType.EffectRemoved,this.onEffectRemoved);
      }
      
      protected function onEffectChanged(effect:Object) : void
      {
         var effectType:int = effect.type;
         var i:int = 0;
         while(i < this.icons.length)
         {
            if(this.icons[i].type == effectType)
            {
               this.icons[i].add(effect);
               return;
            }
            i++;
         }
         var icon:EffectIcon = new EffectIcon(effect);
         this.icons.push(icon);
         addUIChild(icon);
         this.layoutIcons();
      }
      
      protected function onEffectRemoved(effect:Object) : void
      {
         var effectType:int = effect.type;
         var i:int = 0;
         while(i < this.icons.length)
         {
            if(this.icons[i].type == effectType)
            {
               this.icons[i].remove(effect.uid);
               return;
            }
            i++;
         }
      }
      
      override protected function process() : void
      {
         var now:int = new Date().valueOf() / 1000;
         var removed:Boolean = false;
         var i:int = 0;
         while(i < this.icons.length)
         {
            if(this.icons[i].effectCount == 0)
            {
               removeUIChild(this.icons[i]);
               this.icons.splice(i,1);
               i--;
               removed = true;
            }
            else
            {
               this.icons[i].update(now);
            }
            i++;
         }
         if(removed)
         {
            this.layoutIcons();
         }
      }
      
      protected function layoutIcons() : void
      {
         var i:int = 0;
         while(i < this.icons.length)
         {
            this.icons[i].setPos(i % 2 * 30,int(i / 2) * 30);
            i++;
         }
      }
   }
}

