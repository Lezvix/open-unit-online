package com.junkbyte.console.view
{
   import com.junkbyte.console.KeyBind;
   import com.junkbyte.console.Console;
   import com.junkbyte.console.core.LogReferences;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.TextEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   
   public class RollerPanel extends ConsolePanel
   {
      
      public static const CHANNELS_PANEL:String = "rollerPanel";
      
      private var flag38:Boolean;
      
      public function RollerPanel(param1:Console)
      {
         super(param1);
         name = CHANNELS_PANEL;
         init(60,100,false);
         txtField = makeTF("rollerPrints");
         txtField.multiline = true;
         txtField.autoSize = TextFieldAutoSize.LEFT;
         doAction732(txtField,this.onMenuRollOver,this.onLink);
         doAction246(txtField);
         addChild(txtField);
         addEventListener(Event.ENTER_FRAME,this.onEnterFrame2);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removeListeners);
      }
      
      private function removeListeners(param1:Event = null) : void
      {
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrame2);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removeListeners);
         if(stage)
         {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onStageKeyDown);
         }
      }
      
      private function onEnterFrame2(param1:Event) : void
      {
         if(!console.stage)
         {
            this.close();
            return;
         }
         if(this.flag38)
         {
            txtField.htmlText = "<high><menu>Press a key to set [ <a href=\"event:cancel\"><b>cancel</b></a> ]</menu></high>";
         }
         else
         {
            txtField.htmlText = "<low>" + this.getString50(false) + "</low>";
            txtField.autoSize = TextFieldAutoSize.LEFT;
            txtField.setSelection(0,0);
         }
         width = txtField.width + 4;
         height = txtField.height;
      }
      
      public function getString50(param1:Boolean) : String
      {
         var currentStage:Stage = console.stage;
         var output:String = "";
         if(!param1)
         {
            captureKeyText = console.rollerCaptureKey ? console.rollerCaptureKey.key : "unassigned";
            output = "<menu> <a href=\"event:close\"><b>X</b></a></menu> Capture key: <menu><a href=\"event:capture\">" + captureKeyText + "</a></menu><br/>";
         }
         var mousePosition:Point = new Point(currentStage.mouseX,currentStage.mouseY);
         if(currentStage.areInaccessibleObjectsUnderPoint(mousePosition))
         {
            output += "<p9>Inaccessible objects detected</p9><br/>";
         }
         var objectsUnderMouse:Array = currentStage.getObjectsUnderPoint(mousePosition);
         var visited:Dictionary = new Dictionary(true);
         var targetObject:DisplayObject;
         var captureKeyText:String;
         var ancestors:Array;
         var ancestor:DisplayObjectContainer;
         var ancestorCount:uint;
         var depth:uint;
         var displayObject:DisplayObject;
         var indentDepth:uint;
         var displayName:String;
         var referenceId:uint;
         if(objectsUnderMouse.length == 0)
         {
            objectsUnderMouse.push(currentStage);
         }
         for each(targetObject in objectsUnderMouse)
         {
            ancestors = new Array(targetObject);
            ancestor = targetObject.parent;
            while(ancestor)
            {
               ancestors.unshift(ancestor);
               ancestor = ancestor.parent;
            }
            ancestorCount = ancestors.length;
            depth = 0;
            while(depth < ancestorCount)
            {
               displayObject = ancestors[depth];
               if(visited[displayObject] == undefined)
               {
                  visited[displayObject] = depth;
                  indentDepth = depth;
                  while(indentDepth > 0)
                  {
                     output += indentDepth == 1 ? " ∟" : " -";
                     indentDepth--;
                  }
                  displayName = displayObject.name;
                  if(param1 && console.config.useObjectLinking)
                  {
                     referenceId = console.refs.setLogRef(displayObject);
                     displayName = "<a href=\'event:cl_" + referenceId + "\'>" + displayName + "</a> " + console.refs.makeRefTyped(displayObject);
                  }
                  else
                  {
                     displayName = displayName + " (" + LogReferences.ShortClassName(displayObject) + ")";
                  }
                  if(displayObject == currentStage)
                  {
                     referenceId = console.refs.setLogRef(currentStage);
                     if(referenceId)
                     {
                        output += "<p3><a href=\'event:cl_" + referenceId + "\'><i>Stage</i></a> ";
                     }
                     else
                     {
                        output += "<p3><i>Stage</i> ";
                     }
                     output += "[" + currentStage.mouseX + "," + currentStage.mouseY + "]</p3><br/>";
                  }
                  else if(depth == ancestorCount - 1)
                  {
                     output += "<p5>" + displayName + "</p5><br/>";
                  }
                  else
                  {
                     output += "<p2><i>" + displayName + "</i></p2><br/>";
                  }
               }
               depth++;
            }
         }
         return output;
      }
      
      override public function close() : void
      {
         this.doAction887();
         this.removeListeners();
         super.close();
         console.panels.updateMenu();
      }
      
      private function onMenuRollOver(param1:TextEvent) : void
      {
         var tooltipText:String = param1.text ? param1.text.replace("event:","") : "";
         var captureBinding:KeyBind;
         if(tooltipText == "close")
         {
            tooltipText = "Close";
         }
         else if(tooltipText == "capture")
         {
            captureBinding = console.rollerCaptureKey;
            if(captureBinding)
            {
               tooltipText = "Unassign key ::" + captureBinding.key;
            }
            else
            {
               tooltipText = "Assign key";
            }
         }
         else if(tooltipText == "cancel")
         {
            tooltipText = "Cancel assign key";
         }
         else
         {
            tooltipText = null;
         }
         console.panels.tooltip(tooltipText,this);
      }
      
      protected function onLink(param1:TextEvent) : void
      {
         TextField(param1.currentTarget).setSelection(0,0);
         if(param1.text == "close")
         {
            this.close();
         }
         else if(param1.text == "capture")
         {
            if(console.rollerCaptureKey)
            {
               console.setRollerCaptureKey(null);
            }
            else
            {
               flag38 = true;
               stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onStageKeyDown,false,0,true);
            }
            console.panels.tooltip(null);
         }
         else if(param1.text == "cancel")
         {
            this.doAction887();
            console.panels.tooltip(null);
         }
         param1.stopPropagation();
      }
      
      private function doAction887() : void
      {
         flag38 = false;
         if(stage)
         {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onStageKeyDown);
         }
      }
      
      private function onStageKeyDown(param1:KeyboardEvent) : void
      {
         if(!param1.charCode)
         {
            return;
         }
         var keyChar:String = String.fromCharCode(param1.charCode);
         this.doAction887();
         console.setRollerCaptureKey(keyChar,param1.shiftKey,param1.ctrlKey,param1.altKey);
         console.panels.tooltip(null);
      }
   }
}

