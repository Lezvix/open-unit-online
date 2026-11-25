package ui
{
   import ui.buttons.NButton;
   import core.display.InkText;
   import core.ui.BaseButton;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import game.Client;
   
   public class MapMenu extends NuclearMenu
   {
      
      public static var STATUS_LOADING:int = 0;
      
      public static var STATUS_LOADED:int = 1;
      
      public static var STATUS_NOT_FOUND:int = 2;
      
      private static var HIDE_INTERVAL:int = 800;
      
      private static var WAIT_INTERVAL:int = 2000;
      
      private static var MAX_SCALE:int = 6;
      
      private static var WHEEL_DELTA:Number = 0.5;
      
      private static var MAP_X:int = 71;
      
      private static var MAP_Y:int = 103;
      
      private static var MAP_WIDTH:int = 435;
      
      private static var MAP_HEIGHT:int = 435;
      
      private static var FILTER_COUNT:int = 3;
      
      private static var FILTER_MARKS:int = 0;
      
      private static var FILTER_PVP_ZONES:int = 1;
      
      private static var FILTER_OBJECTS:int = 2;
      
      private static var FLAG_X:int = 1;
      
      private static var FLAG_Y:int = 19;
      
      private static var ICON_X:int = 5;
      
      private static var ICON_Y:int = 5;
      
      public var mapStatus:int = STATUS_LOADING;
      
      public var xmlStatus:int = STATUS_LOADING;
      
      private var mapSprite:Sprite;
      
      private var cursorsSprite:NUIComponent;
      
      private var mapMaskSprite:Sprite;
      
      private var pvpMaskSprite:Sprite;
      
      private var mapLoader:Loader = new Loader();
      
      private var pvpLoader:Loader = new Loader();
      
      private var xmlLoader:URLLoader = new URLLoader();
      
      private var pvpSprite:Sprite = new Sprite();
      
      private var main:Main;
      
      private var mapWidth:int;
      
      private var mapHeight:int;
      
      private var redLed:Bitmap;
      
      private var greenLed:Bitmap;
      
      private var mainBmp:Bitmap;
      
      private var cursorBmp:Bitmap = null;
      
      private var highlightInterval:int = 0;
      
      private var startTime:int;
      
      private var cursorLastHide:Boolean = false;
      
      private var markerX:int;
      
      private var cursorY:int;
      
      private var playerCoordsText:TextField;
      
      private var cursorCoordsText:TextField;
      
      private var mapGameName:String;
      
      private var mapScale:Number = 1;
      
      private var mapX:int;
      
      private var mapY:int;
      
      private var array28:Array = new Array();
      
      private var filterBmps:Array = new Array();
      
      private var places:Array = new Array();
      
      private var marks:Array = new Array();
      
      private var xInput:NTextInput;
      
      private var yInput:NTextInput;
      
      private var scaleText:TextField;
      
      private var targetClicked:Boolean = false;
      
      private var clickMouseX:int;
      
      private var clickMouseY:int;
      
      private var startMapX:int;
      
      private var startMapY:int;
      
      private var mouseDown:Boolean = false;
      
      private var redFlag:Bitmap;
      
      private var greenFlag:Bitmap;
      
      private var selectedI:int = -1;
      
      private var selectedJ:int = -1;
      
      private var selectedLev:int = -1;
      
      public function MapMenu(param1:Main)
      {
         super();
         this.main = param1;
      }
      
      public function createMap(param1:String, param2:int, param3:int) : void
      {
         var mapRequest:URLRequest;
         mapGameName = getString("MAP_" + param1);
         if(this.mapGameName == null)
         {
            mapGameName = getString("MAP_DEFAULT");
         }
         mapWidth = param2;
         mapHeight = param3;
         mainBmp = getBmp("MAP_MAIN");
         redFlag = getBmp("FLAG_RED");
         this.redFlag.visible = false;
         greenFlag = getBmp("FLAG_GREEN");
         this.greenFlag.visible = false;
         super.create(this.mainBmp.width,this.mainBmp.height);
         draw(this.mainBmp,0,0);
         addCloseButton(609,93,getBmp("MAP_POWER"),getBmp("MAP_POWER_OVER"),getBmp("MAP_POWER_PRESS"));
         mapRequest = new URLRequest("icons/maps/" + param1 + ".jpg");
         this.mapLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeHandler);
         this.mapLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
         var pvpRequest:URLRequest = new URLRequest("icons/maps/" + param1 + ".pvp.png");
         this.pvpLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.pvpCompleteHandler);
         this.pvpLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.pvpIoErrorHandler);
         this.pvpLoader.load(pvpRequest);
         this.pvpSprite.addChild(this.pvpLoader);
         this.pvpSprite.alpha = 0.25;
         var xmlRequest:URLRequest = new URLRequest("icons/maps/" + param1 + ".xml");
         this.xmlLoader.addEventListener(Event.COMPLETE,this.xmlCompleteHandler);
         this.xmlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.xmlIoErrorHandler);
         this.xmlLoader.load(xmlRequest);
         mapSprite = new Sprite();
         this.mapSprite.x = MAP_X;
         this.mapSprite.y = MAP_Y;
         this.mapSprite.graphics.beginFill(0,0);
         this.mapSprite.graphics.drawRect(0,0,MAP_WIDTH,MAP_HEIGHT);
         this.mapSprite.graphics.endFill();
         addChild(this.mapSprite);
         mapMaskSprite = new Sprite();
         this.mapMaskSprite.x = MAP_X;
         this.mapMaskSprite.y = MAP_Y;
         this.mapMaskSprite.graphics.beginFill(0,0);
         this.mapMaskSprite.graphics.drawRect(0,0,MAP_WIDTH,MAP_HEIGHT);
         this.mapMaskSprite.graphics.endFill();
         addChild(this.mapMaskSprite);
         pvpMaskSprite = new Sprite();
         this.pvpMaskSprite.x = MAP_X;
         this.pvpMaskSprite.y = MAP_Y;
         this.pvpMaskSprite.graphics.beginFill(0,0);
         this.pvpMaskSprite.graphics.drawRect(0,0,MAP_WIDTH,MAP_HEIGHT);
         this.pvpMaskSprite.graphics.endFill();
         addChild(this.pvpMaskSprite);
         this.mapLoader.x = MAP_X;
         this.mapLoader.y = MAP_Y;
         this.mapLoader.mask = this.mapMaskSprite;
         addChild(this.mapLoader);
         this.pvpSprite.x = this.mapLoader.x;
         this.pvpSprite.y = this.mapLoader.y;
         this.pvpSprite.mask = this.pvpMaskSprite;
         addChild(this.pvpSprite);
         cursorsSprite = new NUIComponent();
         this.cursorsSprite.mask = this.mapSprite;
         addUIChild(this.cursorsSprite);
         this.mapLoader.load(mapRequest);
         greenLed = getBmp("MAP_GREEN_LED");
         this.greenLed.x = 565;
         this.greenLed.y = 107;
         addChild(this.greenLed);
         redLed = getBmp("MAP_RED_LED");
         this.redLed.x = 532;
         this.redLed.y = 107;
         addChild(this.redLed);
         this.redLed.visible = false;
         addSimpleTextField(73,74,getString("IDS_LOCATION") + " " + this.mapGameName,10,200,30,"left",13408825);
         playerCoordsText = addSimpleTextField(285,74,"",10,220,30,"left",13408825);
         cursorCoordsText = addSimpleTextField(285,89,"",10,220,30,"left",13408825);
         addUIChild(createButton(534,222,0,getBmp("MAP_FIND"),getBmp("MAP_FIND_OVER"),getBmp("MAP_FIND_PRESS"),this.handleFind));
         addUIChild(createButton(534,250,0,getBmp("MAP_POINTER"),getBmp("MAP_POINTER_OVER"),getBmp("MAP_POINTER_PRESS"),this.selectTarget));
         addUIChild(createButton(534,296,0,getBmp("MAP_CLEAR"),getBmp("MAP_CLEAR_OVER"),getBmp("MAP_CLEAR_PRESS"),this.clearTarget));
         var filterImages:Object;
         var filterButton:BaseButton;
         var filterIndex:int = 0;
         while(filterIndex < FILTER_COUNT)
         {
            filterImages = {
               "off":getBmp("MAP_FILTER_OFF"),
               "offOver":getBmp("MAP_FILTER_OFF_OVER"),
               "on":getBmp("MAP_FILTER_ON"),
               "onOver":getBmp("MAP_FILTER_ON_OVER")
            };
            if(this.getFilter(filterIndex) == 1)
            {
               filterButton = createButton(532,369 + filterIndex * 42,filterIndex,filterImages.on,filterImages.onOver,filterImages.onOver,this.handleFilterPress);
            }
            else
            {
               filterButton = createButton(532,369 + filterIndex * 42,filterIndex,filterImages.off,filterImages.offOver,filterImages.offOver,this.handleFilterPress);
            }
            filterButtons.push(filterButton);
            addUIChild(filterButton);
            this.filterBmps.push(filterImages);
            filterIndex++;
         }
         addUIChild(createButton(528,507,0,getBmp("MAP_ZOOM"),getBmp("MAP_ZOOM_OVER"),getBmp("MAP_ZOOM_PRESS"),this.zoomHandler));
         addUIChild(createButton(620,507,0,getBmp("MAP_DEZOOM"),getBmp("MAP_DEZOOM_OVER"),getBmp("MAP_DEZOOM_PRESS"),this.dezoomHandler));
         var centerFormat:TextFormat = new TextFormat();
         centerFormat.font = "Verdana";
         centerFormat.color = 13408825;
         centerFormat.size = 10;
         centerFormat.align = TextFormatAlign.CENTER;
         var rightFormat:TextFormat = new TextFormat();
         rightFormat.font = "Verdana";
         rightFormat.color = 13408825;
         rightFormat.size = 10;
         rightFormat.align = TextFormatAlign.RIGHT;
         xInput = createInput(553,198,35,4);
         yInput = createInput(616,198,35,4);
         this.xInput.height = this.yInput.height = 16;
         this.xInput.border = this.yInput.border = false;
         addUIChild(this.xInput);
         addUIChild(this.yInput);
         scaleText = createTextField(571,511,42,centerFormat,"1.0x",18);
         addChild(this.scaleText);
         this.cursorsSprite.addChild(this.greenFlag);
         this.cursorsSprite.addChild(this.redFlag);
         this.applyFilter();
      }
      
      private function applyFilter() : void
      {
         if(this.getFilter(FILTER_PVP_ZONES) == 1)
         {
            this.pvpSprite.visible = true;
         }
         else
         {
            this.pvpSprite.visible = false;
         }
      }
      
      public function enableFilter(param1:int) : void
      {
         Client.settings["mapFilter"] = int(Client.settings["mapFilter"]) | 1 << param1;
      }
      
      public function disableFilter(param1:int) : void
      {
         Client.settings["mapFilter"] = int(Client.settings["mapFilter"]) & (-1 ^ 1 << param1);
      }
      
      public function getFilter(param1:int) : int
      {
         return int(Client.settings["mapFilter"]) >> param1 & 1;
      }
      
      private function zoomHandler(param1:Object) : void
      {
         this.scaleTo(WHEEL_DELTA,this.mapMaskSprite.width / 2,this.mapMaskSprite.height / 2);
      }
      
      private function dezoomHandler(param1:Object) : void
      {
         this.scaleTo(-WHEEL_DELTA,this.mapMaskSprite.width / 2,this.mapMaskSprite.height / 2);
      }
      
      private function handleFilterPress(param1:Object) : void
      {
         var filterIndex:int = param1.value;
         if(this.getFilter(filterIndex) == 1)
         {
            this.disableFilter(filterIndex);
            param1.upState = this.filterBmps[filterIndex].off;
            param1.overState = this.filterBmps[filterIndex].offOver;
            param1.downState = this.filterBmps[filterIndex].offOver;
         }
         else
         {
            this.enableFilter(filterIndex);
            param1.upState = this.filterBmps[filterIndex].on;
            param1.overState = this.filterBmps[filterIndex].onOver;
            param1.downState = this.filterBmps[filterIndex].onOver;
         }
         this.applyFilter();
         this.updatePositions();
      }
      
      private function handleFind(target:Object) : void
      {
         var newI:int = 0;
         var newJ:int = 0;
         try
         {
            newI = int(this.yInput.text) * 2;
         }
         catch(e:*)
         {
            return;
         }
         try
         {
            newJ = int(this.xInput.text) * 2;
         }
         catch(e:*)
         {
            return;
         }
         selectedI = newI;
         selectedJ = newJ;
         selectedLev = 0;
         this.updatePositions();
      }
      
      public function selectCoords(param1:int, param2:int) : void
      {
         selectedI = param1 * 2;
         selectedJ = param2 * 2;
         selectedLev = 0;
         this.updatePositions();
      }
      
      private function selectTarget(param1:Object) : void
      {
         if(this.selectedJ != -1 && this.selectedI != -1)
         {
            Client.settings["selectedI"] = this.selectedI;
            Client.settings["selectedJ"] = this.selectedJ;
            Client.settings["selectedLev"] = this.selectedLev;
            Client.settings["questId"] = -1;
            this.main.world.setQuestCoords(Client.settings["selectedI"],Client.settings["selectedJ"],Client.settings["selectedLev"]);
            this.updatePositions();
         }
      }
      
      private function clearTarget(param1:Object) : void
      {
         if(Client.settings["selectedI"] != -1 && Client.settings["selectedJ"] != -1)
         {
            Client.settings["selectedI"] = -1;
            Client.settings["selectedJ"] = -1;
            Client.settings["selectedLev"] = -1;
            this.main.world.resetQuestCoords();
            this.updatePositions();
         }
         else if(Client.settings["questId"] != -1)
         {
            Client.settings["questId"] = -1;
            this.main.world.resetQuestCoords();
            this.updatePositions();
         }
      }
      
      private function handleItemPress(param1:Object) : void
      {
         selectedI = param1.object.i;
         selectedJ = param1.object.j;
         selectedLev = param1.object.l;
         this.updatePositions();
      }
      
      private function xmlCompleteHandler(param1:Event) : void
      {
         var loader:URLLoader = param1.target as URLLoader;
         var mapXml:XML = new XML(loader.data);
         var element:Object;
         var placeButton:BaseButton;
         var iconBitmap:Bitmap;
         var entry:Object;
         var markText:InkText;
         for each(element in mapXml.elements("mark"))
         {
            markText = new InkText(20,18);
            markText.setTextFormat(NTextFormat.plain.getTextStyle2(),0);
            markText.text = element.name.toString();
            markText.updateWidth();
            markText.visible = false;
            this.cursorsSprite.addChild(markText);
            entry = {
               "text":markText,
               "name":String(element.name),
               "i":int(element.y),
               "j":int(element.x)
            };
            this.marks.push(entry);
         }
         for each(element in mapXml.elements("mitem"))
         {
            iconBitmap = getBmp("ICON_" + int(element.icon));
            placeButton = new NButton(this.handleItemPress,iconBitmap,iconBitmap,iconBitmap,iconBitmap,String(element.name));
            entry = {
               "btn":placeButton,
               "name":String(element.name),
               "type":int(element.type),
               "icon":int(element.icon),
               "i":int(element.y),
               "j":int(element.x),
               "l":int(element.l)
            };
            placeButton.object = entry;
            placeButton.x = 0;
            placeButton.y = 0;
            placeButton.maskSprite = this.mapSprite;
            placeButton.enabled = false;
            placeButton.visible = false;
            placeButton.value = this.places.length;
            this.cursorsSprite.addUIChild(placeButton);
            this.places.push(entry);
         }
         this.cursorsSprite.addChild(this.greenFlag);
         this.cursorsSprite.addChild(this.redFlag);
         this.xmlLoader.removeEventListener(Event.COMPLETE,this.xmlCompleteHandler);
         this.xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.xmlIoErrorHandler);
      }
      
      private function pvpCompleteHandler(param1:Event) : void
      {
         if(removed)
         {
            Bitmap(this.pvpLoader.content).bitmapData.dispose();
         }
         this.pvpLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.pvpCompleteHandler);
         this.pvpLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.pvpIoErrorHandler);
      }
      
      private function pvpIoErrorHandler(param1:IOErrorEvent) : void
      {
         this.pvpLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.pvpCompleteHandler);
         this.pvpLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.pvpIoErrorHandler);
      }
      
      private function completeHandler(param1:Event) : void
      {
         if(removed)
         {
            Bitmap(this.mapLoader.content).bitmapData.dispose();
         }
         else
         {
            mapStatus = STATUS_LOADED;
            cursorBmp = getBmp("MAP_CURSOR");
            this.cursorsSprite.addChild(this.cursorBmp);
            highlightInterval = setInterval(this.highlight,100);
            startTime = getTimer();
            this.updateCursorText();
            this.updatePositions();
         }
         this.mapLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
         this.mapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.completeHandler);
      }
      
      private function updateCursorText() : void
      {
         if(!this.mouseDown)
         {
            if(this.main.player != null)
            {
               this.playerCoordsText.text = getString("IDS_YOUR_COORDS") + " x" + int(this.main.player.j / 2) + ":y" + int(this.main.player.i / 2);
            }
            else
            {
               this.playerCoordsText.text = getString("IDS_YOUR_COORDS") + " -";
            }
            if(mouseX < this.mapSprite.x || mouseX >= this.mapSprite.x + this.mapSprite.width || mouseY < this.mapSprite.y || mouseY >= this.mapSprite.y + this.mapSprite.height)
            {
               this.cursorCoordsText.text = getString("IDS_CURSOR_COORDS") + " x-:y-";
            }
            else
            {
               this.cursorCoordsText.text = getString("IDS_CURSOR_COORDS") + " x" + int((mouseX - this.mapLoader.x) * this.mapWidth / this.mapLoader.width) + ":y" + int((mouseY - this.mapLoader.y) * this.mapHeight / this.mapLoader.height);
            }
         }
      }
      
      private function updatePositions() : void
      {
         var entry:Object = null;
         var entryIndex:int = 0;
         if(this.cursorBmp)
         {
            if(this.main.player != null)
            {
               cursorY = this.mapLoader.y + int(this.main.player.i * this.mapLoader.height / (this.mapHeight * 2)) - int(this.cursorBmp.height / 2);
               markerX = this.mapLoader.x + int(this.main.player.j * this.mapLoader.width / (this.mapWidth * 2)) - int(this.cursorBmp.width / 2);
            }
            else
            {
               cursorY = -1000;
               markerX = -1000;
            }
            this.cursorBmp.y = this.cursorY;
            this.cursorBmp.x = this.markerX;
         }
         if(this.selectedI != -1 && this.selectedJ != -1)
         {
            this.greenFlag.y = this.mapLoader.y + int(this.selectedI * this.mapLoader.height / (this.mapHeight * 2)) - FLAG_Y;
            this.greenFlag.x = this.mapLoader.x + int(this.selectedJ * this.mapLoader.width / (this.mapWidth * 2)) - FLAG_X;
            this.greenFlag.visible = true;
         }
         else
         {
            this.greenFlag.visible = false;
         }
         if(this.main.world.questI != 0 && this.main.world.questJ != 0)
         {
            this.redFlag.y = this.mapLoader.y + int(this.main.world.questI * this.mapLoader.height / (this.mapHeight * 2)) - FLAG_Y;
            this.redFlag.x = this.mapLoader.x + int(this.main.world.questJ * this.mapLoader.width / (this.mapWidth * 2)) - FLAG_X;
            this.redFlag.visible = true;
         }
         else
         {
            this.redFlag.visible = false;
         }
         if(this.getFilter(FILTER_OBJECTS))
         {
            entryIndex = 0;
            while(entryIndex < this.places.length)
            {
               entry = this.places[entryIndex];
               entry.btn.enabled = true;
               entry.btn.visible = true;
               entry.btn.y = this.mapLoader.y + int(entry.i * this.mapLoader.height / (this.mapHeight * 2)) - ICON_Y;
               entry.btn.x = this.mapLoader.x + int(entry.j * this.mapLoader.width / (this.mapWidth * 2)) - ICON_X;
               entryIndex++;
            }
         }
         else
         {
            entryIndex = 0;
            while(entryIndex < this.places.length)
            {
               entry = this.places[entryIndex];
               entry.btn.enabled = false;
               entry.btn.visible = false;
               entryIndex++;
            }
         }
         if(this.getFilter(FILTER_MARKS))
         {
            entryIndex = 0;
            while(entryIndex < this.marks.length)
            {
               entry = this.marks[entryIndex];
               entry.text.visible = true;
               entry.text.y = this.mapLoader.y + int(entry.i * this.mapLoader.height / (this.mapHeight * 2)) - int(entry.text.height / 2);
               entry.text.x = this.mapLoader.x + int(entry.j * this.mapLoader.width / (this.mapWidth * 2)) - int(entry.text.width / 2);
               entryIndex++;
            }
         }
         else
         {
            entryIndex = 0;
            while(entryIndex < this.marks.length)
            {
               entry = this.marks[entryIndex];
               entry.text.visible = false;
               entryIndex++;
            }
         }
      }
      
      private function highlight() : void
      {
         var elapsed:int = (getTimer() - this.startTime) % (WAIT_INTERVAL + HIDE_INTERVAL);
         var brightness:Number;
         var colorTransform:ColorTransform;
         if(elapsed < HIDE_INTERVAL || this.cursorLastHide)
         {
            if(this.cursorBmp)
            {
               this.cursorBmp.bitmapData.dispose();
            }
            cursorBmp = getBmp("MAP_CURSOR");
            this.cursorsSprite.addChild(this.cursorBmp);
         }
         if(this.main.player != null)
         {
            cursorY = this.mapLoader.y + int(this.main.player.i * this.mapLoader.height / (this.mapHeight * 2)) - int(this.cursorBmp.height / 2);
            markerX = this.mapLoader.x + int(this.main.player.j * this.mapLoader.width / (this.mapWidth * 2)) - int(this.cursorBmp.width / 2);
         }
         else
         {
            cursorY = -1000;
            markerX = -1000;
         }
         this.cursorBmp.y = this.cursorY;
         this.cursorBmp.x = this.markerX;
         this.updateCursorText();
         if(elapsed < HIDE_INTERVAL)
         {
            cursorLastHide = true;
            brightness = 2 * (HIDE_INTERVAL - elapsed) / HIDE_INTERVAL + 1;
            colorTransform = new ColorTransform(brightness,brightness,brightness);
            this.cursorBmp.bitmapData.colorTransform(new Rectangle(0,0,this.cursorBmp.width,this.cursorBmp.height),colorTransform);
         }
         else
         {
            cursorLastHide = false;
         }
      }
      
      private function xmlIoErrorHandler(param1:IOErrorEvent) : void
      {
         xmlStatus = STATUS_NOT_FOUND;
         this.xmlLoader.removeEventListener(Event.COMPLETE,this.xmlCompleteHandler);
         this.xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.xmlIoErrorHandler);
      }
      
      private function loadErrorHandler(param1:IOErrorEvent) : void
      {
         mapStatus = STATUS_NOT_FOUND;
         this.redLed.visible = true;
         this.greenLed.visible = false;
         this.mapLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.completeHandler);
         this.mapLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
      }
      
      override protected function includesMouse() : Boolean
      {
         if(stage != null && mouseX < width && mouseX >= 0 && mouseY < height && mouseY >= 0 && dragable && this.mainBmp.bitmapData.getPixel32(mouseX,mouseY) >> 24 & 0xFF)
         {
            return true;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         this.mapSprite.graphics.clear();
         if(this.mapLoader.content != null)
         {
            Bitmap(this.mapLoader.content).bitmapData.dispose();
         }
         if(this.pvpLoader.content != null)
         {
            Bitmap(this.pvpLoader.content).bitmapData.dispose();
         }
         super.dispose();
         if(this.highlightInterval != 0)
         {
            clearInterval(this.highlightInterval);
         }
      }
      
      override public function get handlesMove() : Boolean
      {
         return true;
      }
      
      override public function get handlesWheel() : Boolean
      {
         return true;
      }
      
      public function scaleTo(param1:Number, param2:int, param3:int) : void
      {
         var anchorX:Number = (param2 + MAP_X - this.mapLoader.x) / this.mapScale;
         var anchorY:Number = (param3 + MAP_Y - this.mapLoader.y) / this.mapScale;
         mapScale += param1;
         if(this.mapScale > MAX_SCALE)
         {
            mapScale = MAX_SCALE;
         }
         else if(this.mapScale < 1)
         {
            mapScale = 1;
         }
         this.scaleText.text = int(this.mapScale) + "." + int(Math.round(this.mapScale * 10)) % 10 + "x";
         this.mapLoader.scaleX = this.mapScale;
         this.mapLoader.scaleY = this.mapScale;
         this.pvpSprite.scaleX = this.mapScale;
         this.pvpSprite.scaleY = this.mapScale;
         this.mapLoader.x = int(param2 - anchorX * this.mapScale + MAP_X);
         this.mapLoader.y = int(param3 - anchorY * this.mapScale + MAP_Y);
         this.pvpSprite.x = this.mapLoader.x;
         this.pvpSprite.y = this.mapLoader.y;
         this.correctMapCoords();
         this.updatePositions();
      }
      
      override public function mouseWheelHandler(param1:int) : void
      {
         var pointerX:int = 0;
         var pointerY:int = 0;
         if(this.mapStatus == STATUS_LOADED && this.mapMaskSprite.mouseX >= 0 && this.mapMaskSprite.mouseY >= 0 && this.mapMaskSprite.mouseX < MAP_WIDTH && this.mapMaskSprite.mouseY < MAP_HEIGHT)
         {
            targetClicked = false;
            mouseDown = false;
            pointerX = this.mapMaskSprite.mouseX;
            pointerY = this.mapMaskSprite.mouseY;
            if(param1 > 0)
            {
               this.scaleTo(WHEEL_DELTA,pointerX,pointerY);
            }
            else if(param1 < 0)
            {
               this.scaleTo(-WHEEL_DELTA,pointerX,pointerY);
            }
         }
      }
      
      private function correctMapCoords() : void
      {
         if(this.mapLoader.x + this.mapLoader.width < MAP_X + MAP_WIDTH)
         {
            this.mapLoader.x = MAP_X + MAP_WIDTH - this.mapLoader.width;
         }
         else if(this.mapLoader.x > MAP_X)
         {
            this.mapLoader.x = MAP_X;
         }
         if(this.mapLoader.y + this.mapLoader.height < MAP_Y + MAP_HEIGHT)
         {
            this.mapLoader.y = MAP_Y + MAP_HEIGHT - this.mapLoader.height;
         }
         else if(this.mapLoader.y > MAP_Y)
         {
            this.mapLoader.y = MAP_Y;
         }
         this.pvpSprite.x = this.mapLoader.x;
         this.pvpSprite.y = this.mapLoader.y;
      }
      
      override public function mouseDownHandler() : void
      {
         if(this.mapStatus == STATUS_LOADED && this.mapMaskSprite.mouseX >= 0 && this.mapMaskSprite.mouseY >= 0 && this.mapMaskSprite.mouseX < MAP_WIDTH && this.mapMaskSprite.mouseY < MAP_HEIGHT)
         {
            mouseDown = true;
            clickMouseX = this.mapMaskSprite.mouseX;
            clickMouseY = this.mapMaskSprite.mouseY;
            startMapX = this.mapLoader.x;
            startMapY = this.mapLoader.y;
            targetClicked = true;
            return;
         }
         super.mouseDownHandler();
      }
      
      override public function mouseUpHandler() : void
      {
         if(this.targetClicked)
         {
            if(this.mapStatus == STATUS_LOADED && this.mapMaskSprite.mouseX >= 0 && this.mapMaskSprite.mouseY >= 0 && this.mapMaskSprite.mouseX < MAP_WIDTH && this.mapMaskSprite.mouseY < MAP_HEIGHT)
            {
               selectedJ = int((mouseX - this.mapLoader.x) * this.mapWidth / this.mapLoader.width) * 2;
               selectedI = int((mouseY - this.mapLoader.y) * this.mapWidth / this.mapLoader.height) * 2;
               selectedLev = 0;
            }
            targetClicked = false;
            this.updatePositions();
         }
         mouseDown = false;
         super.mouseUpHandler();
      }
      
      override public function mouseMoveHandler() : void
      {
         if(this.mouseDown)
         {
            if(this.clickMouseX != this.mapMaskSprite.mouseX || this.clickMouseY != this.mapMaskSprite.mouseY)
            {
               targetClicked = false;
            }
            this.mapLoader.x = this.startMapX + this.mapMaskSprite.mouseX - this.clickMouseX;
            this.mapLoader.y = this.startMapY + this.mapMaskSprite.mouseY - this.clickMouseY;
            this.correctMapCoords();
            this.updatePositions();
         }
         else
         {
            this.updateCursorText();
         }
      }
   }
}

