package core.resources
{
   public class ResourcePack
   {
      
      public static const RESOURCE_PACK_CONST8:int = 0;
      
      public static const RESOURCE_PACK_CONST6:int = 1;
      
      public static const RESOURCE_PACK_CONST9:int = 2;
      
      public static const RESOURCE_PACK_CONST3:int = 3;
      
      public static const RESOURCE_PACK_CONST7:int = 4;
      
      public static const RESOURCE_PACK_CONST2:int = 5;
      
      public static const RESOURCE_PACK_CONST4:int = 6;
      
      public static const RESOURCE_PACK_CONST5:int = 7;
      
      public static const RESOURCE_PACK_CONST1:int = 8;
      
      private var _resourcePackId:int;
      
      private var _packUrl:String;
      
      private var _packData:Object;
      
      private var _packContext:Object;
      
      private var _packCompletionHandler:Function;
      
      private var _includeInGlobalResourceSearch:Boolean;
      
      public var _packType:int = 0;
      
      public function ResourcePack(resourcePackId:int, resourceUrl:String, resourceType:int, context:Object, onLoaded:Function = null, searchGlobally:Boolean = false)
      {
         super();
         this._resourcePackId = resourcePackId;
         this._packUrl = resourceUrl;
         this._packContext = context;
         this.packType = resourceType;
         this._packCompletionHandler = onLoaded;
         this._includeInGlobalResourceSearch = searchGlobally;
      }
      
      public function get includeInGlobalResourceSearch() : Boolean
      {
         return this._includeInGlobalResourceSearch;
      }
      
      public function get doAction568() : Function
      {
         return this._packCompletionHandler;
      }
      
      public function set packType(resourceType:int) : void
      {
         _packType = resourceType;
      }
      
      public function get packType() : int
      {
         return this._packType;
      }
      
      public function set data(content:Object) : void
      {
         _packData = content;
      }
      
      public function get data() : Object
      {
         return this._packData;
      }
      
      public function set packContext(context:Object) : void
      {
         _packContext = context;
      }
      
      public function get packContext() : Object
      {
         return this._packContext;
      }
      
      public function getResource(resourceName:String) : Class
      {
         try
         {
            return this._packData[resourceName] as Class;
         }
         catch(e:Error)
         {
         }
         return null;
      }
      
      public function get packId() : int
      {
         return this._resourcePackId;
      }
      
      public function get packUrl() : String
      {
         return this._packUrl;
      }
   }
}

