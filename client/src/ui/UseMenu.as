package ui
{
   import flash.utils.getDefinitionByName;
   
   public class UseMenu extends NuclearMenu
   {
      
      public static const ACTION_NONE:int = -1;
      
      public static const ACTION_ATTACK:int = 0;
      
      public static const ACTION_BARTER:int = 1;
      
      public static const ACTION_DROP:int = 2;
      
      public static const ACTION_DIALOG:int = 3;
      
      public static const ACTION_HEAL:int = 4;
      
      public static const ACTION_REPAIR:int = 5;
      
      public static const ACTION_MOVE:int = 6;
      
      public static const ACTION_TARGET:int = 7;
      
      public static const ACTION_TARGET_NEAR:int = 8;
      
      public static const ACTION_LOAD:int = 9;
      
      public static const ACTION_UNLOAD:int = 10;
      
      public static const ACTION_USE:int = 11;
      
      public static var TYPE_BATTLE_USER:int = 0;
      
      public static var TYPE_PEACE_USER:int = 1;
      
      public static var TYPE_BATTLE_NPC:int = 2;
      
      public static var TYPE_PEACE_NPC:int = 3;
      
      public static var TYPE_DEAD:int = 4;
      
      public static var TYPE_MOVE:int = 5;
      
      public static var TYPE_LOAD:int = 6;
      
      public static var TYPE_USE:int = 7;
      
      public static var ICONS:Array;

      public static var ICONS_OVER:Array;

      public static var BATTLE_ICONS_USER:Array = new Array(ACTION_ATTACK,ACTION_BARTER,ACTION_HEAL,ACTION_REPAIR,ACTION_TARGET);
      
      public static var PEACE_ICONS_USER:Array = new Array(ACTION_BARTER,ACTION_ATTACK,ACTION_HEAL,ACTION_REPAIR,ACTION_TARGET);
      
      public static var BATTLE_ICONS_NPC:Array = new Array(ACTION_ATTACK,ACTION_DIALOG,ACTION_BARTER,ACTION_HEAL,ACTION_REPAIR,ACTION_TARGET);
      
      public static var PEACE_ICONS_NPC:Array = new Array(ACTION_DIALOG,ACTION_ATTACK,ACTION_BARTER,ACTION_HEAL,ACTION_REPAIR,ACTION_TARGET);
      
      public static var DEAD_ICONS:Array = [ACTION_DROP];
      
      public static var MOVE_ICONS:Array = new Array(ACTION_MOVE,ACTION_TARGET_NEAR);
      
      public static var LOAD_ICONS:Array = new Array(ACTION_LOAD,ACTION_UNLOAD);
      
      public static var USE_ICONS:Array = new Array(ACTION_MOVE,ACTION_USE,ACTION_TARGET_NEAR);
      
      public static var TYPE_ARRAYS:Array = new Array(BATTLE_ICONS_USER,PEACE_ICONS_USER,BATTLE_ICONS_NPC,PEACE_ICONS_NPC,DEAD_ICONS,MOVE_ICONS,LOAD_ICONS,USE_ICONS);
      
      public static var ICON_HEIGHT:int = 33;
      
      private var type:int;
      
      private var main:Main;
      
      private var selectedId:int = -1;
      
      private var typeAr:Array;
      
      public function UseMenu(mainObj:Main, menuType:int)
      {
         this.main = mainObj;
         super();
         this.type = menuType;
         this.typeAr = TYPE_ARRAYS[menuType];
         var i:int = 0;
         while(i < this.typeAr.length)
         {
            ICONS[this.typeAr[i]].y = i * ICON_HEIGHT;
            ICONS_OVER[this.typeAr[i]].y = i * ICON_HEIGHT;
            ICONS_OVER[this.typeAr[i]].visible = false;
            addChild(ICONS[this.typeAr[i]]);
            addChild(ICONS_OVER[this.typeAr[i]]);
            i++;
         }
         width = ICONS_OVER[this.typeAr[0]].width;
         height = ICON_HEIGHT * this.typeAr.length;
      }
      
      public static function init() : void
      {
         ICONS = new Array(new uiContainer["ICON_ATTACK"](),new uiContainer["ICON_BARTER"](),new uiContainer["ICON_DROP"](),new uiContainer["ICON_CHAT"](),new uiContainer["ICON_HEAL"](),new uiContainer["ICON_REPAIR"](),new uiContainer["ICON_MOVE"](),new uiContainer["ICON_TARGET"](),new uiContainer["ICON_TARGET"](),new uiContainer["ICON_LOAD"](),new uiContainer["ICON_UNLOAD"](),new uiContainer["ICON_MINE"]());
         ICONS_OVER = new Array(new uiContainer["ICON_ATTACK_OVER"](),new uiContainer["ICON_BARTER_OVER"](),new uiContainer["ICON_DROP_OVER"](),new uiContainer["ICON_CHAT_OVER"](),new uiContainer["ICON_HEAL_OVER"](),new uiContainer["ICON_REPAIR_OVER"](),new uiContainer["ICON_MOVE_OVER"](),new uiContainer["ICON_TARGET_OVER"](),new uiContainer["ICON_TARGET_OVER"](),new uiContainer["ICON_LOAD_OVER"](),new uiContainer["ICON_UNLOAD_OVER"](),new uiContainer["ICON_MINE_OVER"]());
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function get handlesMove() : Boolean
      {
         return true;
      }
      
      public function getSelectedId() : int
      {
         if(includesMouse())
         {
            return int(mouseY / 34);
         }
         return -1;
      }
      
      override public function mouseMoveHandler() : void
      {
         var selected:int = this.getSelectedId();
         if(selected != this.selectedId)
         {
            if(this.selectedId != -1)
            {
               ICONS_OVER[this.typeAr[this.selectedId]].visible = false;
            }
            selectedId = selected;
            if(this.selectedId != -1)
            {
               ICONS_OVER[this.typeAr[this.selectedId]].visible = true;
            }
         }
      }
      
      override public function mouseUpHandler() : void
      {
         var selected:int = this.getSelectedId();
         if(selected == -1)
         {
            this.main.handleMouseAction(ACTION_NONE);
         }
         else
         {
            this.main.handleMouseAction(this.typeAr[selected]);
         }
      }
   }
}

