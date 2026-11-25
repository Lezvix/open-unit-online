package com.junkbyte.console.view
{
   import com.junkbyte.console.Console;
   import com.junkbyte.console.vos.GraphGroup;
   import com.junkbyte.console.vos.GraphInterest;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.events.TextEvent;
   import flash.text.TextField;
   
   public class GraphingPanel extends ConsolePanel
   {
      
      public static const FPS_PANEL:String = "fpsPanel";
      
      public static const MEMORY_PANEL:String = "memoryPanel";
      
      private var graphGroup2:GraphGroup;
      
      private var _interest:GraphInterest;
      
      private var obj53:Object = new Object();
      
      private var _type:String;
      
      private var flag112:Boolean;
      
      private var shape8:Shape;
      
      private var graph:Shape;
      
      private var textField37:TextField;
      
      private var textField6:TextField;
      
      public var intValue119:int = 5;
      
      public function GraphingPanel(param1:Console, param2:int, param3:int, param4:String = null)
      {
         super(param1);
         this._type = param4;
         doAction246(bg);
         minWidth = 32;
         minHeight = 26;
         this.textField37 = makeTF("lowestField",false);
         this.textField37.mouseEnabled = false;
         this.textField37.height = style.menuFontSize + 2;
         addChild(this.textField37);
         this.textField6 = makeTF("highestField",false);
         this.textField6.mouseEnabled = false;
         this.textField6.height = style.menuFontSize + 2;
         this.textField6.y = style.menuFontSize - 4;
         addChild(this.textField6);
         txtField = makeTF("menuField");
         txtField.height = style.menuFontSize + 4;
         txtField.y = -3;
         doAction732(txtField,this.onMenuRollOver,this.onLink);
         doAction246(txtField);
         addChild(txtField);
         this.shape8 = new Shape();
         addChild(this.shape8);
         this.graph = new Shape();
         this.graph.name = "graph";
         this.graph.y = style.menuFontSize;
         addChild(this.graph);
         init(param2,param3,true);
      }
      
      private function stop() : void
      {
         if(this.graphGroup2)
         {
            console.graphing.remove(this.graphGroup2.name);
         }
      }
      
      public function get group() : GraphGroup
      {
         return this.graphGroup2;
      }
      
      public function reset() : void
      {
         obj53 = {};
         this.graph.graphics.clear();
         if(!this.graphGroup2.flag23)
         {
            this.graphGroup2.low = NaN;
            this.graphGroup2.hi = NaN;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this.textField37.y = param1 - style.menuFontSize;
         flag112 = true;
         var borderGraphics:Graphics = this.shape8.graphics;
         borderGraphics.clear();
         borderGraphics.lineStyle(1,style.controlColor,0.6);
         borderGraphics.moveTo(0,this.graph.y);
         borderGraphics.lineTo(width - this.intValue119,this.graph.y);
         borderGraphics.lineTo(width - this.intValue119,param1);
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this.textField37.width = param1;
         this.textField6.width = param1;
         txtField.width = param1;
         txtField.scrollH = txtField.maxScrollH;
         this.graph.graphics.clear();
         flag112 = true;
      }
      
      public function update(param1:GraphGroup, param2:Boolean) : void
      {
         graphGroup2 = param1;
         var addSample:int = 1;
         if(param1.intValue168 > 0)
         {
            addSample = 0;
            if(!this.flag112)
            {
               return;
            }
         }
         if(this.flag112)
         {
            param2 = true;
         }
         flag112 = false;
         var interestList:Array = param1.interests;
         var graphWidth:int = width - this.intValue119;
         var graphHeight:int = height - this.graph.y;
         var lowerBound:Number = param1.low;
         var upperBound:Number = param1.hi;
         var valueRange:Number = upperBound - lowerBound;
         var activeKeys:Object = {};
         var legendChanged:Boolean = false;
         var interest:GraphInterest;
         var storedKey:String;
         var interestKey:String;
         var seriesData:Array;
         var samples:Array;
         var sampleCount:int;
         var maxSamples:int;
         var repeatCount:int;
         var drawCount:int;
         var sampleOffset:int;
         var plotY:Number;
         if(param2)
         {
            (param1.flag79 ? this.textField6 : this.textField37).text = isNaN(param1.low) ? "" : "<low>" + param1.low + "</low>";
            (param1.flag79 ? this.textField37 : this.textField6).text = isNaN(param1.hi) ? "" : "<low>" + param1.hi + "</low>";
            this.graph.graphics.clear();
         }
         for each(interest in interestList)
         {
            _interest = interest;
            interestKey = this._interest.key;
            activeKeys[interestKey] = true;
            seriesData = this.obj53[interestKey];
            if(seriesData == null)
            {
               legendChanged = true;
               seriesData = new Array(this._interest.col.toString(16),new Array());
               this.obj53[interestKey] = seriesData;
            }
            samples = seriesData[1];
            if(addSample == 1)
            {
               if(param1.type == GraphGroup.FPS_PANEL)
               {
                  repeatCount = Math.floor(param1.hi / this._interest.v);
                  if(repeatCount > 30)
                  {
                     repeatCount = 30;
                  }
                  while(repeatCount > 0)
                  {
                     samples.push(this._interest.v);
                     repeatCount--;
                  }
               }
               else
               {
                  samples.push(this._interest.v);
               }
            }
            sampleCount = samples.length;
            maxSamples = Math.floor(graphWidth) + 10;
            if(sampleCount > maxSamples)
            {
               samples.splice(0,sampleCount - maxSamples);
               sampleCount = samples.length;
            }
            if(param2)
            {
               this.graph.graphics.lineStyle(1,this._interest.col);
               drawCount = graphWidth > sampleCount ? sampleCount : graphWidth;
               sampleOffset = 1;
               while(sampleOffset < drawCount)
               {
                  plotY = (valueRange ? (samples[sampleCount - sampleOffset] - lowerBound) / valueRange : 0.5) * graphHeight;
                  if(!param1.flag79)
                  {
                     plotY = graphHeight - plotY;
                  }
                  if(plotY < 0)
                  {
                     plotY = 0;
                  }
                  if(plotY > graphHeight)
                  {
                     plotY = graphHeight;
                  }
                  if(sampleOffset == 1)
                  {
                     this.graph.graphics.moveTo(width,plotY);
                  }
                  this.graph.graphics.lineTo(graphWidth - sampleOffset,plotY);
                  sampleOffset++;
               }
               if(isNaN(this._interest.numValue46) && valueRange)
               {
                  plotY = (this._interest.numValue46 - lowerBound) / valueRange * graphHeight;
                  if(!param1.flag79)
                  {
                     plotY = graphHeight - plotY;
                  }
                  if(plotY < 0)
                  {
                     plotY = 0;
                  }
                  if(plotY > graphHeight)
                  {
                     plotY = graphHeight;
                  }
                  this.graph.graphics.lineStyle(1,this._interest.col,0.3);
                  this.graph.graphics.moveTo(0,plotY);
                  this.graph.graphics.lineTo(graphWidth,plotY);
               }
            }
         }
         for(storedKey in this.obj53)
         {
            if(activeKeys[storedKey] == undefined)
            {
               legendChanged = true;
               delete this.obj53[storedKey];
            }
         }
         if(param2 && (legendChanged || this._type))
         {
            this.doAction130();
         }
      }
      
      public function doAction130() : void
      {
         var menuHtml:String = "<r><low>";
         var seriesKey:String;
         if(this._type)
         {
            if(isNaN(this._interest.v))
            {
               menuHtml += "no input<menu>";
            }
            else if(this._type == FPS_PANEL)
            {
               menuHtml += this._interest.v.toFixed(1) + " | " + this._interest.numValue46.toFixed(1) + " <menu><a href=\"event:reset\">R</a>";
            }
            else
            {
               menuHtml += this._interest.v.toFixed(2) + "mb <menu><a href=\"event:gc\">G</a> <a href=\"event:reset\">R</a>";
            }
         }
         else
         {
            for(seriesKey in this.obj53)
            {
               menuHtml += " <font color=\'#" + this.obj53[seriesKey][0] + "\'>" + seriesKey + "</font>";
            }
            menuHtml += " | <menu><a href=\"event:reset\">R</a>";
         }
         menuHtml += " <a href=\"event:close\">X</a></menu></low></r>";
         txtField.htmlText = menuHtml;
         txtField.scrollH = txtField.maxScrollH;
      }
      
      protected function onLink(param1:TextEvent) : void
      {
         TextField(param1.currentTarget).setSelection(0,0);
         if(param1.text == "reset")
         {
            this.reset();
         }
         else if(param1.text == "close")
         {
            if(this._type == FPS_PANEL)
            {
               console.fpsMonitor = false;
            }
            else if(this._type == MEMORY_PANEL)
            {
               console.memoryMonitor = false;
            }
            else
            {
               this.stop();
            }
            console.panels.removeGraph(this.graphGroup2);
         }
         else if(param1.text == "gc")
         {
            console.gc();
         }
         param1.stopPropagation();
      }
      
      protected function onMenuRollOver(param1:TextEvent) : void
      {
         var tooltipText:String = param1.text ? param1.text.replace("event:","") : null;
         if(tooltipText == "gc")
         {
            tooltipText = "Garbage collect::Requires debugger version of flash player";
         }
         console.panels.tooltip(tooltipText,this);
      }
   }
}

