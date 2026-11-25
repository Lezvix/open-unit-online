package ui.addons
{
   import ui.NUIComponent;
   
   public class Addon extends NUIComponent
   {
      
      public static const ADDON_LOCATOR:int = 1;
      
      public static const GEIGER_COUNTER:int = 2;
      
      public static const MINE_DETECTOR_0:int = 3;
      
      public static const MINE_DETECTOR_1:int = 4;
      
      public static const TYPE_RLS_MODULE:int = 5;
      
      protected var _type:int;
      
      protected var _addonValue:int;
      
      public function Addon(param1:int)
      {
         super();
         if(param1 <= 0 || param1 > TYPE_RLS_MODULE)
         {
            throw new Error("Bad addon type");
         }
         this._type = param1;
      }
      
      public static function create(param1:int) : Addon
      {
         switch(param1)
         {
            case ADDON_LOCATOR:
               return new Radar();
            case GEIGER_COUNTER:
               return new GeigerCounter();
            case MINE_DETECTOR_0:
               return new MineDetector();
            case MINE_DETECTOR_1:
               return new MineDetector2();
            case TYPE_RLS_MODULE:
               return new RlsModule();
            default:
               throw new Error("Bad addon type");
         }
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function get value() : int
      {
         return this._addonValue;
      }
      
      public function set value(param1:int) : void
      {
         if(this._addonValue != param1)
         {
            _addonValue = param1;
            this.update();
         }
      }
      
      public function update() : void
      {
      }
      
      override protected function process() : void
      {
         this.update();
      }
   }
}

