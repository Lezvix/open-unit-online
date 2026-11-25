package ui.buttons
{
   import core.ui.BaseApplication;
   import flash.display.Sprite;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import game.Client;
   import game.Chat;
   import game.Effect;
   import ui.GameCursor;
   import ui.NTextFormat;
   
   public class EffectIcon extends NButton
   {
      
      protected static const COUNTER_FORMAT:TextFormat = NTextFormat.plain.center.derive({"color":14540253});
      
      protected static const COUNTER_FILTERS:Array = [new GlowFilter(3355443,1,1.1,1.1,50,BitmapFilterQuality.HIGH)];
      
      protected var effects:Array;
      
      protected var typeValue:int;
      
      protected var sprite:Sprite = new Sprite();
      
      protected var counter:TextField;
      
      protected var description:String;
      
      public function EffectIcon(effect:Object)
      {
         this.effects = [effect];
         this.typeValue = effect.type;
         this.sprite.addChild(getBmp("BUFF_" + effect.type));
         this.description = Client._("IDS_BUFF_" + this.typeValue);
         super(null,this.sprite);
         intValue57 = intValue8 = GameCursor.CURSOR_DEFAULT;
         hintText = this.description;
      }
      
      public function update(now:int) : void
      {
         var secondsLeft:int = 0;
         if(this.effectCount == 1)
         {
            switch(this.typeValue)
            {
               case Effect.ALCOHOLISM:
               case Effect.EffectCount:
               case Effect.DRUG_ADDICTION:
               case Effect.IRRADIATION:
               case Effect.CHEMICAL_POISONING:
                  if(!this.counter)
                  {
                     counter = new TextField();
                     this.counter.defaultTextFormat = COUNTER_FORMAT;
                     this.counter.width = 30;
                     this.counter.y = 7;
                     this.counter.filters = COUNTER_FILTERS;
                     this.sprite.addChild(this.counter);
                  }
                  if(!this.counter.visible)
                  {
                     this.counter.visible = true;
                  }
                  this.counter.text = (Main.UserCharacter.getEffect(this.typeValue).param >> 24 & 0xFF).toString();
                  break;
               default:
                  secondsLeft = this.effects[0].endtime - now;
                  if(secondsLeft >= 0)
                  {
                     hintText = this.description + " " + Chat.secondsToStr(secondsLeft);
                     if(isOver)
                     {
                        BaseApplication.showHint(hintText);
                     }
                     if(secondsLeft <= Effect.EffectFlashingSeconds)
                     {
                        if(!this.counter)
                        {
                           counter = new TextField();
                           this.counter.defaultTextFormat = COUNTER_FORMAT;
                           this.counter.width = 30;
                           this.counter.y = 7;
                           this.counter.filters = COUNTER_FILTERS;
                           this.sprite.addChild(this.counter);
                        }
                        if(!this.counter.visible)
                        {
                           this.counter.visible = true;
                        }
                        this.counter.text = secondsLeft.toString();
                     }
                     else if(this.counter && this.counter.visible)
                     {
                        this.counter.visible = false;
                     }
                  }
                  else if(this.counter && this.counter.visible)
                  {
                     this.counter.visible = false;
                  }
                  break;
            }
         }
         else if(this.counter && this.counter.visible)
         {
            this.counter.visible = false;
         }
      }
      
      public function get type() : int
      {
         return this.typeValue;
      }
      
      public function get effectCount() : int
      {
         return this.effects.length;
      }
      
      public function add(effect:Object) : void
      {
         var i:int = 0;
         while(i < this.effects.length)
         {
            if(this.effects[i].uid == effect.uid)
            {
               this.effects[i].endtime = effect.endtime;
               this.effects[i].param = effect.param;
               return;
            }
            i++;
         }
         this.effects.push(effect);
         hintText = this.description;
         if(isOver)
         {
            BaseApplication.showHint(hintText);
         }
      }
      
      override protected function includesMouse() : Boolean
      {
         return stage != null && mouseX < 30 && mouseX >= 0 && mouseY < 30 && mouseY >= 0;
      }
      
      public function remove(uid:int) : void
      {
         var i:int = 0;
         while(i < this.effects.length)
         {
            if(this.effects[i].uid == uid)
            {
               this.effects.splice(i,1);
               return;
            }
            i++;
         }
      }
   }
}

