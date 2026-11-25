package game
{
   import core.resources.ResourcePack;
   import core.resources.ResourceManager;
   
   public final class GamePacksLoader extends ResourceManager
   {
      
      public static const LOCALE_PACK_ID:int = 0;
      
      public static const UI_PACK_ID:int = 1;
      
      public static const SOUNDS_PACK_ID:int = 2;
      
      public static const BACKGROUND_PACK_ID:int = 3;
      
      private static const PACK_URL_TEMPLATES:Array = ["locale/{lang}/locale.bin","locale/{lang}/ui.swf","locale/{lang}/sounds.swf","res/BgPack0.swf"];
      
      private static const idsUiLoad:Array = ["","IDS_UI_LOAD","IDS_SOUNDS_LOAD","IDS_BACKGROUND_LOAD",""];
      
      private static const PACK_TYPES:Array = [ResourcePack.RESOURCE_PACK_CONST9,ResourcePack.RESOURCE_PACK_CONST8,ResourcePack.RESOURCE_PACK_CONST1,ResourcePack.RESOURCE_PACK_CONST8];
      
      public static var localizedPackUrls:Array;

      public var onGamePacksLoaded:Function = null;
      
      private var lang:String;
      
      private var currentLoadingPack:int = 0;
      
      public function GamePacksLoader(lang:String)
      {
         super();
         this.lang = lang;
         localizedPackUrls = PACK_URL_TEMPLATES.map(function(param1:String, param2:int, param3:Array):String
         {
            return param1.replace(/{lang}/,lang);
         });
      }
      
      public function loadLocalePack() : void
      {
         this.loadPackById(LOCALE_PACK_ID);
      }
      
      public function loadRemainingGamePacks() : void
      {
         var packId:int = 1;
         while(packId < PACK_URL_TEMPLATES.length)
         {
            this.loadPackById(packId);
            packId++;
         }
      }
      
      override public function loadPackById(param1:int) : void
      {
         if(PACK_TYPES[param1] == ResourcePack.RESOURCE_PACK_CONST7)
         {
            loadResourcePack(param1,"res/ResPack" + param1 + ".swf",PACK_TYPES[param1],localizedPackUrls[param1],this.doAction568);
         }
         else
         {
            loadResourcePack(param1,localizedPackUrls[param1],PACK_TYPES[param1],null,this.doAction568);
         }
      }
      
      override public function set packCompleteHandler(value:Function) : void
      {
         super.packCompleteHandler = function(param1:ResourcePack):void
         {
            ++currentLoadingPack;
            value(param1);
         };
      }
      
      private function doAction568(param1:ResourcePack) : void
      {
         if(this.currentLoadingPack == PACK_URL_TEMPLATES.length)
         {
            if(this.onGamePacksLoaded != null)
            {
               this.onGamePacksLoaded();
            }
         }
      }
      
      public function get packLoadingMessageId() : String
      {
         return idsUiLoad[this.currentLoadingPack];
      }
   }
}

