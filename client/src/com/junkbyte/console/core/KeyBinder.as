package com.junkbyte.console.core
{
   import com.junkbyte.console.KeyBind;
   import com.junkbyte.console.Console;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class KeyBinder extends ConsoleCore
   {
      
      private var intValue104:int;
      
      private var obj37:Object = {};
      
      private var uintValue27:uint;
      
      public function KeyBinder(param1:Console)
      {
         super(param1);
         param1.cl.addCLCmd("keybinds",this.doAction559,"List all keybinds used");
      }
      
      public function doAction842(param1:KeyBind, param2:Function, param3:Array = null) : void
      {
         if(config.keystrokePassword && (!param1.isValue70 && param1.key.charAt(0) == config.keystrokePassword.charAt(0)))
         {
            report("Error: KeyBind [" + param1.key + "] is conflicting with Console password.",9);
            return;
         }
         if(param2 == null)
         {
            delete this.obj37[param1.key];
         }
         else
         {
            this.obj37[param1.key] = [param2,param3];
         }
      }
      
      public function onStageKeyDown(param1:KeyboardEvent) : void
      {
         this.doAction345(param1,false);
      }
      
      public function onStageKeyUp(param1:KeyboardEvent) : void
      {
         this.doAction345(param1,true);
      }
      
      private function doAction345(param1:KeyboardEvent, param2:Boolean) : void
      {
         var keyChar:String = String.fromCharCode(param1.charCode);
         var binding:KeyBind;
         if(param2 && config.keystrokePassword != null && keyChar && keyChar == config.keystrokePassword.substring(this.intValue104,this.intValue104 + 1))
         {
            ++this.intValue104;
            if(this.intValue104 >= config.keystrokePassword.length)
            {
               intValue104 = 0;
               if(this.check11())
               {
                  if(console.visible && !console.panels.mainPanel.visible)
                  {
                     console.panels.mainPanel.visible = true;
                  }
                  else
                  {
                     console.visible = !console.visible;
                  }
                  if(console.visible && console.panels.mainPanel.visible)
                  {
                     console.panels.mainPanel.visible = true;
                     console.panels.mainPanel.moveBackSafePosition();
                  }
               }
               else if(this.uintValue27 < 3)
               {
                  ++this.uintValue27;
                  report("Password did not trigger because you have focus on an input TextField.",8);
               }
            }
         }
         else
         {
            if(param2)
            {
               intValue104 = 0;
            }
            binding = new KeyBind(param1.keyCode,param1.shiftKey,param1.ctrlKey,param1.altKey,param2);
            this.doAction707(binding.key);
            if(keyChar)
            {
               binding = new KeyBind(keyChar,param1.shiftKey,param1.ctrlKey,param1.altKey,param2);
               this.doAction707(binding.key);
            }
         }
      }
      
      private function doAction559(... rest) : void
      {
         report("Key binds:",-2);
         var bindingCount:uint = 0;
         var bindingKey:String;
         for(bindingKey in this.obj37)
         {
            bindingCount++;
            report(bindingKey,-2);
         }
         report("--- Found " + bindingCount,-2);
      }
      
      private function doAction707(param1:String) : void
      {
         var bindingData:Array = this.obj37[param1];
         if(config.keyBindsEnabled && bindingData)
         {
            if(this.check11())
            {
               (bindingData[0] as Function).apply(null,bindingData[1]);
            }
            else if(this.uintValue27 < 3)
            {
               ++this.uintValue27;
               report("Key bind [" + param1 + "] did not trigger because you have focus on an input TextField.",8);
            }
         }
      }
      
      private function check11() : Boolean
      {
         var focusedField:TextField = null;
         try
         {
            if(console.stage && console.stage.focus is TextField)
            {
               focusedField = console.stage.focus as TextField;
               if(focusedField.type == TextFieldType.INPUT)
               {
                  return false;
               }
            }
         }
         catch(err:Error)
         {
         }
         return true;
      }
   }
}

