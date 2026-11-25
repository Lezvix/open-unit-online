package ui.menus
{
   import ui.buttons.*;
   import net.*;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import game.*;
   import mx.utils.StringUtil;
   import ui.*;
   
   public class ManagementMenu extends TitledMenu
   {
      
      private static const WIDTH:int = 646;
      
      private static const HEIGHT:int = 508;
      
      private static const TAB_INFO:int = 0;
      
      private static const TAB_PRODUCTION:int = 1;
      
      private static const TAB_DEPOD:int = 2;
      
      private static const LEVELS_COUNT:int = 5;
      
      private static const LEVEL_TECHNOLOGY:int = 0;
      
      private static const LEVEL_PRODUCTION:int = 1;
      
      private static const LEVEL_AUTOMATION:int = 2;
      
      private static const LEVEL_CRUDE_DEPOD:int = 3;
      
      private static const LEVEL_PRODUCT_DEPOD:int = 4;
      
      private static const TASK_QUEUED:int = 0;
      
      private static const TASK_PAUSED_OVERWEIGHT:int = 1;
      
      private static const TASK_PAUSED_NO_CRUDE:int = 2;
      
      private static const TASK_RUNNING:int = 3;
      
      private static const factoryInfo:Object = {"loaded":false};
      
      private const tabs:Vector.<ContentTabButton> = new Vector.<ContentTabButton>(3,true);
      
      private var _data:Array;
      
      private var factoryType:int = -1;
      
      private var crudeCellId:int = -1;
      
      private var crudeCellCapacity:int = -1;
      
      private var crudeGrid:ItemsGrid;
      
      private var crudeWeightButton:WeightButton = null;
      
      private var eraseCrudeButton:NButton = null;
      
      private var enterCrudeButton:NButton = null;
      
      private var productCellId:int = -1;
      
      private var productCellCapacity:int = -1;
      
      private var productGrid:ItemsGrid;
      
      private var productWeightButton:WeightButton = null;
      
      private var sendProductButton:NButton = null;
      
      private var eraseProductButton:NButton = null;
      
      private var enterProductButton:NButton = null;
      
      private var levels:Vector.<int> = new Vector.<int>(LEVELS_COUNT,true);
      
      private var levelsList:RowList = null;
      
      private var deliveryCost:int = 0;
      
      private var upgradeDescriptionText:TextField;
      
      private var _managers:Array;
      
      private var recipeIds:Array;
      
      private var managersList:RowList = null;
      
      private var addManagerButton:NButton = null;
      
      private var removeManagerButton:NButton = null;
      
      private var queue:Array;
      
      private var currentTask:Object = null;
      
      private var currentTaskSlot:RecipeSlot;
      
      private var statusText:TextField;
      
      private var progressBitmap:BitmapData = null;
      
      private var progressText:TextField;
      
      private var progressBar:Sprite;
      
      private var cancelTaskButton:NButton = null;
      
      private var queueScroll:ScrollSprite;
      
      private var queueSizeText:TextField;
      
      private var recipesScroll:ScrollSprite;
      
      private var selectedRecipe:Object = null;
      
      private var selectedSlot:RecipeSlot = null;
      
      private var recipeDragger:NuclearLoader = new NuclearLoader();
      
      private var recipeInfoScroll:ScrollSprite = null;
      
      public function ManagementMenu(fields:Array)
      {
         super(TYPE_MANAGEMENT,_("IDS_FACTORY_CONTROL_PANEL"),WIDTH,HEIGHT);
         drawWindowBg();
         if(!factoryInfo.loaded)
         {
            GameSocket.socket.send(Commands.COMMANDS_CONST39);
            GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST39,this.onRecipes);
         }
         this.parseData(fields);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST39,this.onRecipes);
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST22,this.onCellContent);
      }
      
      override protected function onCloseClick(sender:Object) : void
      {
         GameSocket.socket.send("dl");
      }
      
      private function onRecipes(fields:Array) : void
      {
         GameEventDispatcher.removeCommandHandler(Commands.COMMANDS_CONST39,this.onRecipes);
         var offset:int = 1;
         factoryInfo.initQueueSize = int(fields[offset++]);
         factoryInfo.queueIncPerLevel = int(fields[offset++]);
         factoryInfo.maxManagersCount = int(fields[offset++]);
         factoryInfo.poductionSpeedIncPerLevel = int(fields[offset++]);
         factoryInfo.recipes = {};
         var recipeCount:int = fields[offset++];
         var i:int = 0;
         var recipe:Object;
         var ingredientCount:int;
         var j:int;
         var itemLength:int;
         var item:InventoryItem;
         while(i < recipeCount)
         {
            recipe = {
               "id":int(fields[offset++]),
               "type":int(fields[offset++]),
               "duration":int(fields[offset++]),
               "ingredients":[]
            };
            if(recipe.type == 0)
            {
               recipe.level = int(fields[offset++]);
               itemLength = fields[offset];
               item = new InventoryItem(fields.slice(offset,offset + itemLength));
               offset += itemLength;
               recipe.product = {
                  "item":item,
                  "count":int(fields[offset++])
               };
            }
            else
            {
               recipe.upgrade = {
                  "type":int(fields[offset++]),
                  "level":int(fields[offset++])
               };
            }
            ingredientCount = fields[offset++];
            j = 0;
            while(j < ingredientCount)
            {
               recipe.ingredients.push({
                  "id":int(fields[offset++]),
                  "name":fields[offset++],
                  "count":int(fields[offset++])
               });
               j++;
            }
            factoryInfo.recipes[recipe.id] = recipe;
            i++;
         }
         factoryInfo.loaded = true;
         this.create();
      }
      
      public function parseData(fields:Array) : void
      {
         var offset:int = 2;
         factoryType = fields[offset++];
         var i:int = 0;
         while(i < LEVELS_COUNT)
         {
            this.levels[i] = int(fields[offset++]);
            i++;
         }
         crudeCellId = int(fields[offset++]);
         crudeCellCapacity = int(fields[offset++]);
         productCellId = int(fields[offset++]);
         productCellCapacity = int(fields[offset++]);
         deliveryCost = int(fields[offset++]);
         _managers = [];
         var count:int = fields[offset++];
         var task:Object;
         i = 0;
         while(i < count)
         {
            this._managers.push({
               "id":int(fields[offset++]),
               "name":fields[offset++],
               "level":int(fields[offset++])
            });
            i++;
         }
         recipeIds = [];
         count = fields[offset++];
         i = 0;
         while(i < count)
         {
            this.recipeIds.push(int(fields[offset++]));
            i++;
         }
         currentTask = null;
         queue = [];
         count = fields[offset++];
         i = 0;
         while(i < count)
         {
            task = {
               "id":int(fields[offset++]),
               "recipe":int(fields[offset++]),
               "state":int(fields[offset++]),
               "duration":int(fields[offset++]),
               "progress":int(fields[offset++])
            };
            if(task.state == TASK_QUEUED)
            {
               this.queue.push(task);
            }
            else
            {
               currentTask = task;
               this.currentTask.started = getTimer();
            }
            i++;
         }
         if(factoryInfo.loaded)
         {
            if(this.tabs[0])
            {
               this.update();
            }
            else
            {
               this.create();
            }
         }
      }
      
      private function get isManager() : Boolean
      {
         var userId:int = Main.UserCharacter.userId;
         var i:int = this._managers.length - 1;
         while(i >= 0)
         {
            if(this._managers[i].id == userId)
            {
               return true;
            }
            i--;
         }
         return false;
      }
      
      private function onCurrentTaskClick(slot:RecipeSlot) : void
      {
         if(this.selectedSlot != slot)
         {
            if(this.selectedSlot != null)
            {
               this.selectedSlot.Selected = false;
            }
            selectedSlot = slot;
            selectedRecipe = slot.recipeData;
            slot.Selected = true;
            this.updateRecipeInfo();
         }
      }
      
      private function onRecipeSelect(slot:RecipeSlot) : void
      {
         if(this.selectedSlot != slot)
         {
            if(this.selectedSlot != null)
            {
               this.selectedSlot.Selected = false;
            }
            selectedSlot = slot;
            selectedRecipe = slot.recipeData;
            slot.Selected = true;
            this.updateRecipeInfo();
         }
         if(this.recipeDragger.isActive && this.isManager)
         {
            this.recipeDragger.startDragItem(slot);
            this.recipeDragger.setPos(this.recipesScroll.x + slot.x,this.recipesScroll.y + slot.y - this.recipesScroll.scrollV);
         }
      }
      
      private function onQueueTaskSelect(slot:RecipeSlot) : void
      {
         if(this.selectedSlot != slot)
         {
            if(this.selectedSlot != null)
            {
               this.selectedSlot.Selected = false;
            }
            selectedSlot = slot;
            selectedRecipe = slot.recipeData;
            slot.Selected = true;
            this.updateRecipeInfo();
         }
         if(this.recipeDragger.isActive && this.isManager)
         {
            this.recipeDragger.startDragItem(slot);
            this.recipeDragger.setPos(this.queueScroll.x + slot.x,this.queueScroll.y + slot.y - this.queueScroll.scrollV);
         }
      }
      
      private function update() : void
      {
         if(!this.recipeDragger.isActive)
         {
            this.recipeDragger.dropItem();
         }
         Chat.doAction485(this.recipeIds,function(idA:int, idB:int):int
         {
            var recipes:Object = factoryInfo.recipes;
            if(recipes[idA].type != recipes[idB].type)
            {
               return recipes[idA].type == 1 ? -1 : 1;
            }
            else if(recipes[idA].type == 0 && recipes[idB].level != recipes[idA].level)
            {
               return recipes[idB].level > recipes[idA].level ? -1 : 1;
            }
            return 0;
         });
         var i:int = 0;
         while(i < LEVELS_COUNT)
         {
            this.levelsList.setData(i,1,this.levels[i]);
            i++;
         }
         this.managersList.clear();
         i = 0;
         while(i < this._managers.length)
         {
            this.managersList.addCenteredRow(this._managers[i].name + " [" + this._managers[i].level + "]",this._managers[i].id);
            i++;
         }
         i = this._managers.length;
         while(i < factoryInfo.maxManagersCount)
         {
            this.managersList.addCenteredRow("",null,true);
            i++;
         }
         this.addManagerButton.enabled = Main.UserCharacter.isValue29;
         this.removeManagerButton.enabled = Main.UserCharacter.isValue29;
         this.cancelTaskButton.enabled = this.isManager;
         this.sendProductButton.enabled = this.isManager;
         this.eraseProductButton.enabled = this.isManager;
         this.enterProductButton.enabled = this.isManager;
         this.eraseCrudeButton.enabled = this.isManager;
         var scroll:int = this.queueScroll.scrollV;
         this.queueScroll.clear();
         var r:Rectangle = new Rectangle(0,0,96,56);
         var text:TextField;
         i = 0;
         while(i < this.queue.length)
         {
            var task:Object = this.queue[i];
            var recipe:Object = factoryInfo.recipes[task.recipe];
            var container:RecipeSlot = new RecipeSlot(this.onQueueTaskSelect);
            container.setRecipe(recipe,task);
            if(recipe.type == 0)
            {
               container.setLevelBadge(recipe.level,10187041);
            }
            else
            {
               container.setLevelBadge(recipe.upgrade.level,5074829);
            }
            container.setPos(r.x,r.y);
            this.queueScroll.addContent(container);
            r.offset(0,r.height + 8);
            i++;
         }
         this.queueScroll.init(r.y - 7,scroll);
         this.queueSizeText.text = this.queue.length + "/" + (factoryInfo.initQueueSize + this.levels[LEVEL_AUTOMATION] * factoryInfo.queueIncPerLevel);
         if(this.currentTask == null)
         {
            this.statusText.text = _("IDS_FACTORY_IDLE");
            this.currentTaskSlot.clear();
         }
         else
         {
            recipe = factoryInfo.recipes[this.currentTask.recipe];
            this.currentTaskSlot.setRecipe(recipe,this.currentTask);
            if(recipe.type == 0)
            {
               this.currentTaskSlot.setLevelBadge(recipe.level,10187041);
            }
            else
            {
               this.currentTaskSlot.setLevelBadge(recipe.upgrade.level,5074829);
            }
            if(this.currentTask.state == TASK_PAUSED_OVERWEIGHT)
            {
               this.statusText.text = _("IDS_FACTORY_PRODUCTION_PAUSED_OVERWEIGHT");
            }
            else if(this.currentTask.state == TASK_PAUSED_NO_CRUDE)
            {
               this.statusText.text = _("IDS_FACTORY_PRODUCTION_PAUSED_NO_CRUDE");
            }
            else if(this.currentTask.state == TASK_RUNNING)
            {
               processIntervalValue = 30;
            }
         }
         this.updateRecipes();
         this.updateProgress();
         if(this.productWeightButton != null)
         {
            this.productWeightButton.maxValueValue = this.productCellCapacity;
         }
         if(this.crudeWeightButton != null)
         {
            this.crudeWeightButton.maxValueValue = this.crudeCellCapacity;
         }
      }
      
      override protected function process() : void
      {
         super.process();
         this.updateProgress();
         if(this.currentTask == null || this.currentTask.state != TASK_RUNNING)
         {
            processIntervalValue = 0;
         }
      }
      
      private function updateProgress() : void
      {
         var progress:Number;
         this.progressBar.graphics.clear();
         if(this.currentTask == null)
         {
            this.progressText.text = "0.00%";
         }
         else
         {
            progress = this.currentTask.progress;
            if(this.currentTask.state == TASK_RUNNING)
            {
               progress += (getTimer() - this.currentTask.started) / 1000;
               this.statusText.text = formatString("IDS_FACTORY_PRODUCTION_RUNNING",Math.max(0,int(this.currentTask.duration - progress)));
            }
            progress = this.currentTask.duration > 0 ? Math.min(100,100 * progress / this.currentTask.duration) : 0;
            this.progressText.text = progress.toFixed(2) + "%";
            if(progress > 0)
            {
               this.progressBar.graphics.beginBitmapFill(this.progressBitmap);
               this.progressBar.graphics.drawRect(0,0,progress / 100 * (WIDTH - 144 - this.progressBar.x),20);
               this.progressBar.graphics.endFill();
               this.progressBar.scaleX = 1;
               this.progressBar.scaleY = 1;
            }
         }
      }
      
      private function create() : void
      {
         var i:int = 0;
         while(i < this.tabs.length)
         {
            this.tabs[i] = new ContentTabButton(formatString("IDS_FACTORY_TAB_" + i),(WIDTH - 36) / 3,this.onTabClick);
            this.tabs[i].setPos(17 + i * (this.tabs[i].width + 3),40);
            this.tabs[i].tabContent.setPos(19,this.tabs[i].y + this.tabs[i].height + 5);
            this.tabs[i].tabContent.graphics.drawRect(0,0,WIDTH - 36,HEIGHT - this.tabs[i].tabContent.y - 18);
            addUIChild(this.tabs[i]);
            i++;
         }
         var tab:NUIComponent = this.tabs[TAB_INFO].tabContent;
         var label:TextField = createLabel(0,0,_("IDS_FACTORY_" + this.factoryType),NTextFormat.titleFormat.left);
         tab.addChild(label);
         label = createLabel(0,label.y + label.height - 1,_("IDS_TYPE"),NTextFormat.titleFormat.left);
         tab.addChild(label);
         label = createLabel(label.x + label.width,label.y,formatString("IDS_FACTORY_TYPE_" + this.factoryType),NTextFormat.titleFormat.left.propValue12);
         tab.addChild(label);
         label = createText(0,label.y + label.height - 1,formatString("IDS_FACTORY_TYPE_DESCRIPTION_" + this.factoryType),NTextFormat.plain,2 * (WIDTH - 36) / 3);
         tab.addChild(label);
         levelsList = new RowList(WIDTH / 2);
         this.levelsList.setPos((WIDTH - 36 - this.levelsList.width) / 2,label.y + label.height + 14);
         i = 0;
         while(i < LEVELS_COUNT)
         {
            this.levelsList.addRow(_("IDS_FACTORY_LEVEL_" + i),0,i);
            i++;
         }
         tab.addUIChild(this.levelsList);
         label = createLabel(0,this.levelsList.y + this.levelsList.height + 16,_("IDS_FACTORY_MANAGERS"),NTextFormat.titleFormat,WIDTH - 36);
         tab.addChild(label);
         managersList = new RowList(208,Chat.doAction936);
         this.managersList.setPos((WIDTH - 36 - this.managersList.width) / 2,label.y + label.height + 10);
         tab.addUIChild(this.managersList);
         i = 0;
         while(i < factoryInfo.maxManagersCount)
         {
            this.managersList.addCenteredRow("",null,true);
            i++;
         }
         addManagerButton = createButton(this.managersList.x - 2,this.managersList.y + this.managersList.height + 8,_("IDS_ADD"),this.onAddManagerClick);
         tab.addUIChild(this.addManagerButton);
         removeManagerButton = createButton(this.managersList.x + 107,this.managersList.y + this.managersList.height + 8,_("IDS_REMOVE"),this.onRemoveManagerClick);
         tab.addUIChild(this.removeManagerButton);
         tab = this.tabs[TAB_PRODUCTION].tabContent;
         var pos:Point = new Point(1,2);
         currentTaskSlot = new RecipeSlot(this.onCurrentTaskClick);
         this.currentTaskSlot.setPos(pos.x,pos.y);
         tab.addUIChild(this.currentTaskSlot);
         pos.offset(103,14);
         statusText = createLabel(pos.x,pos.y,"?",NTextFormat.titleFormat.propValue12.left,WIDTH - pos.x - 38);
         tab.addChild(this.statusText);
         pos.offset(2,22);
         progressBar = new Sprite();
         this.progressBar.x = pos.x;
         this.progressBar.y = pos.y;
         this.progressBar.alpha = 0.8;
         tab.addChild(this.progressBar);
         cancelTaskButton = createButton(WIDTH - 138,pos.y - 2,_("IDS_CANCEL"),this.onCancelTaskClick);
         tab.addUIChild(this.cancelTaskButton);
         tab.graphics.lineStyle(1,3156252);
         tab.graphics.beginFill(2172187);
         tab.graphics.drawRect(pos.x,pos.y,WIDTH - pos.x - 144,20);
         tab.graphics.endFill();
         progressText = createLabel(pos.x,pos.y + 2,"?",NTextFormat.normal.center,WIDTH - pos.x - 144);
         this.progressText.blendMode = BlendMode.SCREEN;
         tab.addChild(this.progressText);
         pos.setTo(this.currentTaskSlot.x,this.currentTaskSlot.y + this.currentTaskSlot.height + 7);
         var listsRect:Rectangle = new Rectangle(pos.x,pos.y,RecipeSlot.WIDTH,tab.height - pos.y - 1);
         var headerFormat:NTextFormat = new NTextFormat({
            "size":12,
            "color":10187041
         });
         tab.graphics.lineStyle(1,3156252);
         tab.graphics.beginFill(1776411);
         tab.graphics.moveTo(pos.x,pos.y);
         pos.offset(RecipeSlot.WIDTH + 32,0);
         tab.graphics.lineTo(pos.x,pos.y);
         pos.offset(0,160);
         tab.graphics.lineTo(pos.x,pos.y);
         pos.offset(16,0);
         tab.graphics.lineTo(pos.x,pos.y);
         pos.offset(0,-160);
         tab.graphics.lineTo(pos.x,pos.y);
         pos.offset(RecipeSlot.WIDTH + 32,0);
         tab.graphics.lineTo(pos.x,pos.y);
         pos.offset(0,listsRect.height);
         tab.graphics.lineTo(pos.x,pos.y);
         pos.offset(-RecipeSlot.WIDTH - 32,0);
         tab.graphics.lineTo(pos.x,pos.y);
         pos.offset(0,-160);
         tab.graphics.lineTo(pos.x,pos.y);
         pos.offset(-16,0);
         tab.graphics.lineTo(pos.x,pos.y);
         pos.offset(0,160);
         tab.graphics.lineTo(pos.x,pos.y);
         pos.offset(-RecipeSlot.WIDTH - 32,0);
         tab.graphics.lineTo(pos.x,pos.y);
         pos.offset(0,-listsRect.height);
         tab.graphics.lineTo(pos.x,pos.y);
         pos.offset(4,3);
         label = createLabel(pos.x,pos.y,_("IDS_FACTORY_PRODUCTION_QUEUE"),headerFormat,RecipeSlot.WIDTH + 24);
         tab.addChild(label);
         queueSizeText = createLabel(pos.x,pos.y,"?",headerFormat.right,RecipeSlot.WIDTH + 24);
         tab.addChild(this.queueSizeText);
         pos.offset(RecipeSlot.WIDTH + 48,0);
         label = createLabel(pos.x,pos.y,_("IDS_AVAILABLE_FACTORY_PRODUCTION"),headerFormat,RecipeSlot.WIDTH + 24);
         tab.addChild(label);
         pos.offset(4,29);
         recipesScroll = new ScrollSprite(RecipeSlot.WIDTH + 16,listsRect.height - 38,7);
         this.recipesScroll.setPos(pos.x,pos.y);
         tab.addUIChild(this.recipesScroll);
         pos.offset(-RecipeSlot.WIDTH - 48,0);
         queueScroll = new ScrollSprite(RecipeSlot.WIDTH + 16,listsRect.height - 38,7);
         this.queueScroll.setPos(pos.x,pos.y);
         tab.addUIChild(this.queueScroll);
         this.recipeDragger.dropHandler = this.onDrop;
         tab.addUIChild(this.recipeDragger);
         pos.offset(RecipeSlot.WIDTH * 2 + 80,-32);
         tab.graphics.drawRect(pos.x,pos.y,WIDTH - 37 - pos.x,tab.height - pos.y - 1);
         recipeInfoScroll = new ScrollSprite(WIDTH - 52 - pos.x,tab.height - pos.y - 15);
         pos.offset(8,8);
         this.recipeInfoScroll.setPos(pos.x,pos.y);
         tab.addUIChild(this.recipeInfoScroll);
         tab = this.tabs[TAB_DEPOD].tabContent;
         label = createLabel(0,0,_("IDS_PRODUCT_DEPOD"),NTextFormat.titleFormat.left);
         tab.addChild(label);
         drawRamFrame(tab,1,label.y + label.height + 4,WIDTH - 37,155);
         productGrid = new ItemsGrid(123,6,true);
         this.productGrid.setPos(8,label.y + label.height + 10);
         tab.addUIChild(this.productGrid);
         this.productGrid.addChangeListener(this.onProductGridChange);
         enterProductButton = createButton(WIDTH - 138,this.productGrid.y + this.productGrid.height + 34,_("IDS_ENTER"),this.onEnterProductClick);
         tab.addUIChild(this.enterProductButton);
         eraseProductButton = createButton(WIDTH - 244,this.enterProductButton.y,_("IDS_ERASE"),this.onEraseProductClick);
         tab.addUIChild(this.eraseProductButton);
         sendProductButton = createButton(WIDTH - 350,this.enterProductButton.y,_("IDS_SEND_PRODUCT"),this.onSendProductClick);
         tab.addUIChild(this.sendProductButton);
         label = createLabel(0,this.productGrid.y + this.productGrid.height + 57,_("IDS_CRUDE_DEPOD"),NTextFormat.titleFormat.left);
         tab.addChild(label);
         drawRamFrame(tab,1,label.y + label.height + 4,WIDTH - 37,155);
         crudeGrid = new ItemsGrid(123,6,true);
         this.crudeGrid.setPos(8,label.y + label.height + 10);
         tab.addUIChild(this.crudeGrid);
         this.crudeGrid.addChangeListener(this.onCrudeGridChange);
         enterCrudeButton = createButton(WIDTH - 138,this.crudeGrid.y + this.crudeGrid.height + 34,_("IDS_ENTER"),this.onEnterCrudeClick);
         tab.addUIChild(this.enterCrudeButton);
         eraseCrudeButton = createButton(WIDTH - 244,this.enterCrudeButton.y,_("IDS_ERASE"),this.onEraseCrudeClick);
         tab.addUIChild(this.eraseCrudeButton);
         progressBitmap = getBmp("PROGRESS_BAR").bitmapData;
         this.onTabClick(this.tabs[TAB_INFO]);
         this.update();
         GameEventDispatcher.addCommandHandler(Commands.COMMANDS_CONST22,this.onCellContent);
         GameSocket.socket.send(Commands.COMMANDS_CONST22,this.crudeCellId);
         GameSocket.socket.send(Commands.COMMANDS_CONST22,this.productCellId);
      }
      
      private function updateRecipeInfo() : void
      {
         this.recipeInfoScroll.clear();
         var recipe:Object = this.selectedRecipe;
         var rows:RowList;
         var loader:Loader;
         var textField:TextField;
         var upgradeIcon:Bitmap;
         var ingredient:Object;
         if(recipe != null)
         {
            this.recipeInfoScroll.uiContainer.graphics.lineStyle(1,3156252);
            this.recipeInfoScroll.uiContainer.graphics.drawRect(0,0,this.recipeInfoScroll.width - 15,56);
            this.recipeInfoScroll.uiContainer.graphics.lineStyle();
            rows = new RowList(this.recipeInfoScroll.width - 15);
            rows.setPos(0,64);
            if(recipe.type == 0)
            {
               rows.addRow(_("IDS_PRODUCT"),recipe.product.item.itemname);
               rows.addRow(_("IDS_COUNT"),recipe.product.count);
               rows.addRow(_("IDS_FACTORY_LEVEL_0"),recipe.level);
               loader = new Loader();
               loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onProductIconLoad);
               loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onProductIconError);
               loader.x = this.recipeInfoScroll.width - 15 >> 1;
               this.recipeInfoScroll.addLine(loader);
               loader.load(new URLRequest("icons/inv/i" + recipe.product.item.image + ".png"));
            }
            else
            {
               rows.addCenteredRow(_("IDS_FACTORY_UPGRADE_" + recipe.upgrade.type));
               this.recipeInfoScroll.addLine(rows);
               textField = createText(0,rows.y + rows.height + 1,_("IDS_FACTORY_UPGRADE_DESCRIPTION_" + recipe.upgrade.type),NTextFormat.normal.center,this.recipeInfoScroll.width - 15);
               this.recipeInfoScroll.addLine(textField);
               rows = new RowList(this.recipeInfoScroll.width - 15);
               rows.setPos(0,textField.y + textField.height + 1);
               rows.addRow(_("IDS_INV_LEVEL"),recipe.upgrade.level);
               upgradeIcon = getBmp("FACTORY_UPGRADE_" + recipe.upgrade.type);
               upgradeIcon.x = this.recipeInfoScroll.width - 15 - upgradeIcon.width >> 1;
               upgradeIcon.y = 58 - upgradeIcon.height >> 1;
               this.recipeInfoScroll.addLine(upgradeIcon);
            }
            rows.addRow(_("IDS_BASE_TIME"),Chat.getString56(recipe.duration * (100 - factoryInfo.poductionSpeedIncPerLevel * this.levels[LEVEL_PRODUCTION]) / 100));
            if(recipe.ingredients.length > 0)
            {
               this.recipeInfoScroll.addLine(rows);
               textField = createLabel(0,rows.y + rows.height + 12,_("IDS_NEED") + ":",NTextFormat.normal.center,this.recipeInfoScroll.width - 15);
               this.recipeInfoScroll.addLine(textField);
               rows = new RowList(this.recipeInfoScroll.width - 15);
               rows.setPos(0,textField.y + textField.height + 1);
               for each(ingredient in recipe.ingredients)
               {
                  rows.addRow(ingredient.name,Chat.formatNumber(this.crudeGrid.getInt31(ingredient.id)) + "/" + Chat.formatNumber(ingredient.count));
               }
            }
            this.recipeInfoScroll.addLine(rows);
            this.recipeInfoScroll.init(rows.y + rows.height);
         }
      }
      
      private function onProductIconLoad(event:Event) : void
      {
         event.target.removeEventListener(Event.COMPLETE,this.onProductIconLoad);
         event.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onProductIconError);
         event.target.loader.x -= event.target.loader.width >> 1;
         event.target.loader.y = 62 - event.target.loader.height >> 1;
      }
      
      private function onProductIconError(event:Event) : void
      {
         event.target.removeEventListener(Event.COMPLETE,this.onProductIconLoad);
         event.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onProductIconError);
      }
      
      protected function onDrop(dragger:NuclearLoader) : void
      {
         var slot:RecipeSlot = null;
         var recipe:Object = null;
         var fromIndex:int = 0;
         var toIndex:int = 0;
         if(!dragger.isActive)
         {
            slot = dragger.dropItem();
            if(this.queueScroll.isMouseOver)
            {
               if(slot.taskData == null)
               {
                  if(this.queue.length >= factoryInfo.initQueueSize + this.levels[LEVEL_AUTOMATION] * factoryInfo.queueIncPerLevel)
                  {
                     showNotification(_("IDS_NOTIFICATION_71"));
                  }
                  else
                  {
                     recipe = slot.recipeData;
                     if(recipe.type == 0 && recipe.level > this.levels[LEVEL_TECHNOLOGY])
                     {
                        showNotification(_("IDS_NOTIFICATION_72"));
                     }
                     else
                     {
                        GameSocket.socket.send(Commands.COMMANDS_CONST28,recipe.id);
                     }
                  }
               }
               else
               {
                  fromIndex = slot.y / 64;
                  toIndex = (this.queueScroll.mouseY + this.queueScroll.scrollV) / 64;
                  if(fromIndex != toIndex)
                  {
                     GameSocket.socket.send(Commands.COMMANDS_CONST7,slot.taskData.id,toIndex);
                  }
               }
            }
            else if(slot.taskData != null)
            {
               GameSocket.socket.send(Commands.COMMANDS_CONST31,slot.taskData.id);
            }
         }
      }
      
      private function updateRecipes() : void
      {
         var scrollPos:int = this.recipesScroll.scrollV;
         this.recipesScroll.clear();
         var rect:Rectangle = new Rectangle(0,0,96,56);
         var unused:TextField;
         var i:int = 0;
         var recipe:Object;
         var slot:RecipeSlot;
         var hidden:Boolean;
         var j:int;
         for(; i < this.recipeIds.length; i++)
         {
            recipe = factoryInfo.recipes[this.recipeIds[i]];
            if(recipe.type == 1)
            {
               hidden = false;
               if(this.levels[recipe.upgrade.type] != recipe.upgrade.level - 1)
               {
                  hidden = true;
               }
               else
               {
                  j = 0;
                  while(j < this.queue.length)
                  {
                     if(recipe.id == this.queue[j].recipe)
                     {
                        hidden = true;
                        break;
                     }
                     j++;
                  }
                  if(this.currentTask != null && this.currentTask.recipe == recipe.id)
                  {
                     hidden = true;
                  }
               }
               if(hidden)
               {
                  continue;
               }
            }
            slot = new RecipeSlot(this.onRecipeSelect);
            slot.setRecipe(recipe);
            if(recipe.type == 0)
            {
               slot.setLevelBadge(recipe.level,recipe.level > this.levels[LEVEL_TECHNOLOGY] ? 16737792 : 10187041);
            }
            else
            {
               slot.setLevelBadge(recipe.upgrade.level,5074829);
            }
            slot.setPos(rect.x,rect.y);
            this.recipesScroll.addContent(slot);
            rect.offset(0,rect.height + 8);
         }
         this.recipesScroll.init(rect.y - 7,scrollPos);
      }
      
      private function onCancelTaskClick(sender:NButton) : void
      {
         if(this.currentTask != null)
         {
            if(this.currentTask.state == TASK_PAUSED_NO_CRUDE)
            {
               GameSocket.socket.send(Commands.COMMANDS_CONST11);
            }
            else
            {
               showModal(new QuestionMenu(_("IDS_FACTORY_PRODUCTION_ABORT_WARNING"),function(param1:Object):void
               {
                  GameSocket.socket.send(Commands.COMMANDS_CONST11);
               }));
            }
         }
      }
      
      private function onRemoveManagerClick(sender:Object) : void
      {
         var rows:Vector.<int> = this.managersList.selectedRows;
         if(rows.length != 1)
         {
            return;
         }
         var id:int = int(this.managersList.getRowValue(rows[0]));
         if(id > 0 && id != Main.UserCharacter.userId)
         {
            var i:int = 0;
            while(i < this._managers.length)
            {
               if(this._managers[i].id == id)
               {
                  showModal(new QuestionMenu(_("IDS_MANAGER_REMOVE_WARNING",this._managers[i].name),function(param1:Object):void
                  {
                     GameSocket.socket.send(Commands.COMMANDS_CONST18,id);
                  }));
                  break;
               }
               i++;
            }
         }
      }
      
      private function onAddManagerClick(sender:Object) : void
      {
         if(this._managers.length >= factoryInfo.maxManagersCount)
         {
            showNotification(_("IDS_NOTIFICATION_73"));
         }
         else
         {
            showModal(new InputMenu(_("IDS_MANAGER_INPUT_REQUEST"),function(param1:InputMenu):void
            {
               var login:* = StringUtil.trim(param1.inputText).toLocaleLowerCase();
               var i:*;
               if(login)
               {
                  i = 0;
                  while(i < _managers.length)
                  {
                     if(_managers[i].name.toLocaleLowerCase() == login)
                     {
                        return;
                     }
                     i++;
                  }
                  GameSocket.socket.send(Commands.COMMANDS_CONST26,login);
               }
            }));
         }
      }
      
      private function onEnterCrudeClick(sender:Object) : void
      {
         GameSocket.socket.sendLogin(this.crudeCellId,"");
         closeMenu();
      }
      
      private function onEnterProductClick(sender:Object) : void
      {
         GameSocket.socket.sendLogin(this.productCellId,"");
         closeMenu();
      }
      
      private function onSendProductClick(sender:Object) : void
      {
         var sendConfirmed:Function;
         sendConfirmed = function(param1:Object = null):void
         {
            GameSocket.socket.send(Commands.COMMANDS_CONST5);
         };
         if(this.productGrid.propValue75 == 0)
         {
            return;
         }
         if(this.deliveryCost > 0)
         {
            showModal(new QuestionMenu(formatString("IDS_DELIVERY_PRODUCT_WARNING",Math.ceil(this.productGrid.itemsWeight * this.deliveryCost / 1000)),sendConfirmed));
         }
         else
         {
            sendConfirmed();
         }
      }
      
      private function onEraseProductClick(sender:Object) : void
      {
         showModal(new QuestionMenu(_("IDS_ERASE_PRODUCT_CELL_WARNING"),function(param1:Object):void
         {
            GameSocket.socket.send(Commands.COMMANDS_CONST37,productCellId);
         }));
      }
      
      private function onEraseCrudeClick(sender:Object) : void
      {
         showModal(new QuestionMenu(_("IDS_ERASE_CRUDE_CELL_WARNING"),function(param1:Object):void
         {
            GameSocket.socket.send(Commands.COMMANDS_CONST37,crudeCellId);
         }));
      }
      
      private function onUpgradeSelect(button:SelectableButton) : void
      {
         this.upgradeDescriptionText.text = button.Selected ? _("IDS_FACTORY_UPGRADE_DESCRIPTION_" + button.value) : "";
         this.upgradeDescriptionText.height = this.upgradeDescriptionText.textHeight + 5;
      }
      
      private function onTabClick(tab:ContentTabButton) : void
      {
         if(tab.Selected)
         {
            return;
         }
         var i:int = 0;
         while(i < this.tabs.length)
         {
            if(this.tabs[i].Selected)
            {
               this.tabs[i].Selected = false;
               removeUIChild(this.tabs[i].tabContent);
            }
            i++;
         }
         tab.Selected = true;
         addUIChild(tab.tabContent);
         if(!this.recipeDragger.isActive)
         {
            this.recipeDragger.dropItem();
         }
      }
      
      private function onCellContent(fields:Array) : void
      {
         var offset:int = 1;
         var cellId:int = int(fields[offset++]);
         if(cellId == this.crudeCellId)
         {
            this.fillGrid(this.crudeGrid,fields);
            this.updateRecipeInfo();
         }
         else if(cellId == this.productCellId)
         {
            this.fillGrid(this.productGrid,fields);
         }
      }
      
      private function fillGrid(grid:ItemsGrid, fields:Array) : void
      {
         var offset:int = 2;
         var itemCount:int = fields[offset++];
         var items:Vector.<InventoryItem> = new Vector.<InventoryItem>(itemCount,true);
         var i:int = 0;
         var itemLength:int;
         while(i < itemCount)
         {
            itemLength = fields[offset];
            items[i] = new InventoryItem(fields.slice(offset,offset + itemLength));
            offset += itemLength;
            i++;
         }
         grid.doAction888(items);
      }
      
      private function onCrudeGridChange(event:Object) : void
      {
         if(event.property == "itemsWeight")
         {
            if(this.crudeWeightButton == null)
            {
               crudeWeightButton = new WeightButton(0,this.crudeCellCapacity);
               this.crudeWeightButton.setPos(this.crudeGrid.x - 1,this.crudeGrid.y + this.crudeGrid.height + 4);
               this.tabs[TAB_DEPOD].tabContent.addUIChild(this.crudeWeightButton);
            }
            this.crudeWeightButton.current = this.crudeGrid.itemsWeight;
         }
      }
      
      private function onProductGridChange(event:Object) : void
      {
         if(event.property == "itemsWeight")
         {
            if(this.productWeightButton == null)
            {
               productWeightButton = new WeightButton(0,this.productCellCapacity);
               this.productWeightButton.setPos(this.productGrid.x - 1,this.productGrid.y + this.productGrid.height + 4);
               this.tabs[TAB_DEPOD].tabContent.addUIChild(this.productWeightButton);
            }
            this.productWeightButton.current = this.productGrid.itemsWeight;
         }
      }
   }
}

