package com.junkbyte.console.view
{
   import com.junkbyte.console.Console;
   import com.junkbyte.console.vos.GraphGroup;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class PanelsManager
   {
      
      private var console:Console;
      
      private var _mainPanel:MainPanel;
      
      private var _ruler:Ruler;
      
      private var _chsPanel:ChannelsPanel;
      
      private var _fpsPanel:GraphingPanel;
      
      private var _memoryPanel:GraphingPanel;
      
      private var obj41:Object = {};
      
      private var uintValue4:uint = 0;
      
      private var _tooltipField:TextField;
      
      private var flag30:Boolean;
      
      public function PanelsManager(param1:Console)
      {
         super();
         this.console = param1;
         this._mainPanel = new MainPanel(this.console);
         this._tooltipField = this.mainPanel.makeTF("tooltip",true);
         this._tooltipField.mouseEnabled = false;
         this._tooltipField.autoSize = TextFieldAutoSize.CENTER;
         this._tooltipField.multiline = true;
         this.doAction128(this._mainPanel);
      }
      
      public function doAction128(param1:ConsolePanel) : void
      {
         if(this.console.contains(this._tooltipField))
         {
            this.console.addChildAt(param1,this.console.getChildIndex(this._tooltipField));
         }
         else
         {
            this.console.addChild(param1);
         }
         param1.addEventListener(ConsolePanel.DRAGGING,this.onDragging,false,0,true);
         param1.addEventListener(ConsolePanel.SCALING,this.onDragging,false,0,true);
      }
      
      public function doAction595(param1:String) : void
      {
         var panel:ConsolePanel = this.console.getChildByName(param1) as ConsolePanel;
         if(panel)
         {
            panel.close();
         }
      }
      
      public function getConsolePanel1(param1:String) : ConsolePanel
      {
         return this.console.getChildByName(param1) as ConsolePanel;
      }
      
      public function get mainPanel() : MainPanel
      {
         return this._mainPanel;
      }
      
      public function check35(param1:String) : Boolean
      {
         return this.console.getChildByName(param1) as ConsolePanel ? true : false;
      }
      
      public function doAction510(param1:String, param2:Rectangle) : void
      {
         var panel:ConsolePanel = this.getConsolePanel1(param1);
         if(panel)
         {
            panel.x = param2.x;
            panel.y = param2.y;
            if(param2.width)
            {
               panel.width = param2.width;
            }
            if(param2.height)
            {
               panel.height = param2.height;
            }
         }
      }
      
      public function updateMenu() : void
      {
         this._mainPanel.updateMenu();
         var channelPanel:ChannelsPanel = this.getConsolePanel1(ChannelsPanel.CHANNELS_PANEL) as ChannelsPanel;
         if(channelPanel)
         {
            channelPanel.update();
         }
      }
      
      public function update(param1:Boolean, param2:Boolean) : void
      {
         flag30 = !param1;
         this._mainPanel.update(!param1 && param2);
         if(!param1)
         {
            if(param2 && this._chsPanel != null)
            {
               this._chsPanel.update();
            }
         }
      }
      
      public function updateGraphs(param1:Array) : void
      {
         var activeGroups:Object = {};
         var fpsGroup:GraphGroup;
         var memoryGroup:GraphGroup;
         var graphGroup:GraphGroup;
         var existingName:String;
         var groupName:String;
         var graphPanel:GraphingPanel;
         var panelBounds:Rectangle;
         var panelSize:Number;
         var columnCount:Number;
         var columnIndex:int;
         var rowIndex:int;
         uintValue4 = 0;
         for each(graphGroup in param1)
         {
            if(graphGroup.type == GraphGroup.FPS_PANEL)
            {
               fpsGroup = graphGroup;
            }
            else if(graphGroup.type == GraphGroup.MEMORY_PANEL)
            {
               memoryGroup = graphGroup;
            }
            else
            {
               groupName = graphGroup.name;
               graphPanel = this.obj41[groupName] as GraphingPanel;
               if(!graphPanel)
               {
                  panelBounds = graphGroup.rect;
                  if(panelBounds == null)
                  {
                     panelBounds = new Rectangle(NaN,NaN,0,0);
                  }
                  panelSize = 100;
                  if(isNaN(panelBounds.x) || isNaN(panelBounds.y))
                  {
                     if(this._mainPanel.width < 150)
                     {
                        panelSize = 50;
                     }
                     columnCount = Math.floor(this._mainPanel.width / panelSize) - 1;
                     if(columnCount <= 1)
                     {
                        columnCount = 2;
                     }
                     columnIndex = this.uintValue4 % columnCount;
                     rowIndex = Math.floor(this.uintValue4 / columnCount);
                     panelBounds.x = this._mainPanel.x + panelSize + columnIndex * panelSize;
                     panelBounds.y = this._mainPanel.y + panelSize * 0.6 + rowIndex * panelSize;
                     ++this.uintValue4;
                  }
                  if(panelBounds.width <= 0 || isNaN(panelBounds.width))
                  {
                     panelBounds.width = panelSize;
                  }
                  if(panelBounds.height <= 0 || isNaN(panelBounds.height))
                  {
                     panelBounds.height = panelSize;
                  }
                  graphPanel = new GraphingPanel(this.console,panelBounds.width,panelBounds.height);
                  graphPanel.x = panelBounds.x;
                  graphPanel.y = panelBounds.y;
                  graphPanel.name = "graph_" + groupName;
                  this.obj41[groupName] = graphPanel;
                  this.doAction128(graphPanel);
               }
               graphPanel.update(graphGroup,this.flag30);
            }
            activeGroups[graphGroup.name] = true;
         }
         for(existingName in this.obj41)
         {
            if(!activeGroups[existingName])
            {
               this.obj41[existingName].close();
               delete this.obj41[existingName];
            }
         }
         if(fpsGroup != null)
         {
            if(this._fpsPanel == null)
            {
               _fpsPanel = new GraphingPanel(this.console,80,40,GraphingPanel.FPS_PANEL);
               this._fpsPanel.name = GraphingPanel.FPS_PANEL;
               this._fpsPanel.x = this._mainPanel.x + this._mainPanel.width - 160;
               this._fpsPanel.y = this._mainPanel.y + 15;
               this.doAction128(this._fpsPanel);
               this._mainPanel.updateMenu();
            }
            this._fpsPanel.update(fpsGroup,this.flag30);
         }
         else if(this._fpsPanel != null)
         {
            this.doAction595(GraphingPanel.FPS_PANEL);
            _fpsPanel = null;
         }
         if(memoryGroup != null)
         {
            if(this._memoryPanel == null)
            {
               _memoryPanel = new GraphingPanel(this.console,80,40,GraphingPanel.MEMORY_PANEL);
               this._memoryPanel.name = GraphingPanel.MEMORY_PANEL;
               this._memoryPanel.x = this._mainPanel.x + this._mainPanel.width - 80;
               this._memoryPanel.y = this._mainPanel.y + 15;
               this.doAction128(this._memoryPanel);
               this._mainPanel.updateMenu();
            }
            this._memoryPanel.update(memoryGroup,this.flag30);
         }
         else if(this._memoryPanel != null)
         {
            this.doAction595(GraphingPanel.MEMORY_PANEL);
            _memoryPanel = null;
         }
         flag30 = false;
      }
      
      public function removeGraph(param1:GraphGroup) : void
      {
         var graphPanel:GraphingPanel = null;
         if(this._fpsPanel && param1 == this._fpsPanel.group)
         {
            this._fpsPanel.close();
            _fpsPanel = null;
         }
         else if(this._memoryPanel && param1 == this._memoryPanel.group)
         {
            this._memoryPanel.close();
            _memoryPanel = null;
         }
         else
         {
            graphPanel = this.obj41[param1.name];
            if(graphPanel)
            {
               graphPanel.close();
               delete this.obj41[param1.name];
            }
         }
      }
      
      public function get displayRoller() : Boolean
      {
         return this.getConsolePanel1(RollerPanel.CHANNELS_PANEL) as RollerPanel ? true : false;
      }
      
      public function set displayRoller(param1:Boolean) : void
      {
         var rollerPanel:RollerPanel = null;
         if(this.displayRoller != param1)
         {
            if(param1)
            {
               if(this.console.config.displayRollerEnabled)
               {
                  rollerPanel = new RollerPanel(this.console);
                  rollerPanel.x = this._mainPanel.x + this._mainPanel.width - 180;
                  rollerPanel.y = this._mainPanel.y + 55;
                  this.doAction128(rollerPanel);
               }
               else
               {
                  this.console.report("Display roller is disabled in config.",9);
               }
            }
            else
            {
               this.doAction595(RollerPanel.CHANNELS_PANEL);
            }
            this._mainPanel.updateMenu();
         }
      }
      
      public function get channelsPanel() : Boolean
      {
         return this._chsPanel != null;
      }
      
      public function set channelsPanel(param1:Boolean) : void
      {
         if(this.channelsPanel != param1)
         {
            this.console.logs.doAction329();
            if(param1)
            {
               _chsPanel = new ChannelsPanel(this.console);
               this._chsPanel.x = this._mainPanel.x + this._mainPanel.width - 332;
               this._chsPanel.y = this._mainPanel.y - 2;
               this.doAction128(this._chsPanel);
               this._chsPanel.update();
               this.updateMenu();
            }
            else
            {
               this.doAction595(ChannelsPanel.CHANNELS_PANEL);
               _chsPanel = null;
            }
            this.updateMenu();
         }
      }
      
      public function get memoryMonitor() : Boolean
      {
         return this._memoryPanel != null;
      }
      
      public function get fpsMonitor() : Boolean
      {
         return this._fpsPanel != null;
      }
      
      public function tooltip(param1:String = null, param2:ConsolePanel = null) : void
      {
         var parts:Array;
         var tooltipBounds:Rectangle;
         var panelBounds:Rectangle;
         if(param1 && !this.rulerActive)
         {
            parts = param1.split("::");
            param1 = parts[0];
            if(parts.length > 1)
            {
               param1 += "<br/><low>" + parts[1] + "</low>";
            }
            this.console.addChild(this._tooltipField);
            this._tooltipField.wordWrap = false;
            this._tooltipField.htmlText = "<tt>" + param1 + "</tt>";
            if(this._tooltipField.width > 120)
            {
               this._tooltipField.width = 120;
               this._tooltipField.wordWrap = true;
            }
            this._tooltipField.x = this.console.mouseX - this._tooltipField.width / 2;
            this._tooltipField.y = this.console.mouseY + 20;
            if(param2)
            {
               tooltipBounds = this._tooltipField.getBounds(this.console);
               panelBounds = new Rectangle(param2.x,param2.y,param2.width,param2.height);
               var bottomOverflow:Number = tooltipBounds.bottom - panelBounds.bottom;
               if(bottomOverflow > 0)
               {
                  if(this._tooltipField.y - bottomOverflow > this.console.mouseY + 15)
                  {
                     this._tooltipField.y -= bottomOverflow;
                  }
                  else if(panelBounds.y < this.console.mouseY - 24 && tooltipBounds.y > panelBounds.bottom)
                  {
                     this._tooltipField.y = this.console.mouseY - this._tooltipField.height - 15;
                  }
               }
               var leftOverflow:Number = tooltipBounds.left - panelBounds.left;
               var rightOverflow:Number = tooltipBounds.right - panelBounds.right;
               if(leftOverflow < 0)
               {
                  this._tooltipField.x -= leftOverflow;
               }
               else if(rightOverflow > 0)
               {
                  this._tooltipField.x -= rightOverflow;
               }
            }
         }
         else if(this.console.contains(this._tooltipField))
         {
            this.console.removeChild(this._tooltipField);
         }
      }
      
      public function startRuler() : void
      {
         if(this.rulerActive)
         {
            return;
         }
         _ruler = new Ruler(this.console);
         this._ruler.addEventListener(Event.COMPLETE,this.on_rulerComplete,false,0,true);
         this.console.addChild(this._ruler);
         this._mainPanel.updateMenu();
      }
      
      public function get rulerActive() : Boolean
      {
         return this._ruler && this.console.contains(this._ruler) ? true : false;
      }
      
      private function on_rulerComplete(param1:Event) : void
      {
         if(this._ruler && this.console.contains(this._ruler))
         {
            this.console.removeChild(this._ruler);
         }
         _ruler = null;
         this._mainPanel.updateMenu();
      }
      
      private function onDragging(param1:Event) : void
      {
         var draggedPanel:ConsolePanel = param1.currentTarget as ConsolePanel;
         var horizontalEdges:Array;
         var verticalEdges:Array;
         var childCount:int;
         var index:int;
         var otherPanel:ConsolePanel;
         if(this.console.config.style.intValue15)
         {
            horizontalEdges = [0];
            verticalEdges = [0];
            if(this.console.stage)
            {
               horizontalEdges.push(this.console.stage.stageWidth);
               verticalEdges.push(this.console.stage.stageHeight);
            }
            childCount = this.console.numChildren;
            index = 0;
            while(index < childCount)
            {
               otherPanel = this.console.getChildAt(index) as ConsolePanel;
               if((otherPanel) && otherPanel.visible)
               {
                  horizontalEdges.push(otherPanel.x,otherPanel.x + otherPanel.width);
                  verticalEdges.push(otherPanel.y,otherPanel.y + otherPanel.height);
               }
               index++;
            }
            draggedPanel.doAction72(horizontalEdges,verticalEdges);
         }
      }
   }
}

