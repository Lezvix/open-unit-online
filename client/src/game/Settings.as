package game
{
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   import flash.ui.Keyboard;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public dynamic class Settings extends Proxy
   {
      
      public static const HOTKEY_COUNT:int = 36;
      
      protected var settings:SharedObject;
      
      public function Settings()
      {
         super();
         this.settings = SharedObject.getLocal("unit-data-1","/");
         this.setDefault("enableSounds",true);
         this.setDefault("soundVolume",1);
         this.setDefault("enableMusic",true);
         this.setDefault("musicVolume",1);
         this.setDefault("enableRadio",false);
         this.setDefault("radioVolume",1);
         this.setDefault("radioType",0);
         this.setDefault("questId",-1);
         this.setDefault("autoTarget",true);
         this.setDefault("tips",true);
         this.setDefault("lastLogin","");
         this.setDefault("selectedI",-1);
         this.setDefault("selectedJ",-1);
         this.setDefault("selectedLev",-1);
         this.setDefault("mapFilter",5);
         this.setDefault("showPvP",true);
         this.setDefault("fixedCamera",false);
         this.setDefault("autoBattleMode",true);
         this.setDefault("showMassInPercent",true);
         this.setDefault("showMovePoint",false);
         this.setDefault("screenshotIndex",0);
         this.setDefault("showFriendGoesOnline",true);
         this.setDefault("showChannel_1",true);
         this.setDefault("showChannel_2",true);
         this.setDefault("showChannel_3",true);
         this.setDefault("showChannel_4",true);
         this.setDefault("showChannel_8",true);
         this.setDefault("showChannel_0",true);
         this.setDefault("hideFoesMessages",true);
         var index:int = 0;
         var otherIndex:int;
         for(; index < HOTKEY_COUNT; index++)
         {
            if(this.settings.data["key_" + index] == null)
            {
               this.doAction758();
               return;
            }
            if(this.settings.data["key_" + index] != 0)
            {
               otherIndex = index + 1;
               while(otherIndex < HOTKEY_COUNT)
               {
                  if(this.settings.data["key_" + index] == this.settings.data["key_" + otherIndex])
                  {
                     this.doAction758();
                     return;
                  }
                  otherIndex++;
               }
            }
         }
      }
      
      private function setDefault(param1:String, param2:*) : void
      {
         if(!(param1 in this.settings.data))
         {
            this.settings.data[param1] = param2;
         }
      }
      
      public function save() : Boolean
      {
         return this.settings.flush() == SharedObjectFlushStatus.FLUSHED;
      }
      
      public function doAction758() : void
      {
         this.settings.data.key_0 = Keyboard.CONTROL;
         this.settings.data.key_1 = Keyboard.UP;
         this.settings.data.key_2 = Keyboard.DOWN;
         this.settings.data.key_3 = Keyboard.LEFT;
         this.settings.data.key_4 = Keyboard.RIGHT;
         this.settings.data.key_5 = Keyboard.HOME;
         this.settings.data.key_6 = Keyboard.SPACE;
         this.settings.data.key_7 = 87;
         this.settings.data.key_8 = 81;
         this.settings.data.key_9 = 65;
         this.settings.data.key_10 = 69;
         this.settings.data.key_11 = 67;
         this.settings.data.key_12 = 76;
         this.settings.data.key_13 = 73;
         this.settings.data.key_14 = 77;
         this.settings.data.key_15 = 82;
         this.settings.data.key_16 = 192;
         this.settings.data.key_17 = 49;
         this.settings.data.key_18 = 50;
         this.settings.data.key_19 = 51;
         this.settings.data.key_20 = 52;
         this.settings.data.key_21 = 53;
         this.settings.data.key_22 = 54;
         this.settings.data.key_23 = 55;
         this.settings.data.key_24 = 56;
         this.settings.data.key_25 = 57;
         this.settings.data.key_26 = 48;
         this.settings.data.key_27 = 84;
         this.settings.data.key_28 = 83;
         this.settings.data.key_29 = 68;
         this.settings.data.key_30 = 70;
         this.settings.data.key_31 = 71;
         this.settings.data.key_32 = 90;
         this.settings.data.key_33 = 88;
         this.settings.data.key_34 = Keyboard.F12;
         this.settings.data.key_35 = Keyboard.SHIFT;
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean
      {
         return param1 in this.settings.data;
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return this.settings.data[param1];
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         if(this.settings.data[param1] != param2)
         {
            this.settings.data[param1] = param2;
         }
      }
   }
}

