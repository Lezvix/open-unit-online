package core.ui.views
{
   import core.ui.UIComponent;
   import flash.utils.getDefinitionByName;
   
   public final class ViewTypes
   {
      
      public static const VIEW:String = "View";
      
      public static const TEXT:String = "TextView";
      
      public static const BUTTON:String = "Button";
      
      public static const IMAGE_VIEW:String = "ImageView";
      
      public static const EXTERNAL:String = "External";
      
      public static const SWITCH_BUTTON:String = "SwitchButton";
      
      public static const GRID_VIEW:String = "GridView";
      
      public static const SCROLL:String = "ScrollView";
      
      public static const SLIDER:String = "Slider";
      
      public static const GRID_PAGER:String = "GridPager";
      
      public static const SPINNER:String = "Spinner";
      
      public function ViewTypes()
      {
         super();
         throw new Error();
      }
      
      public static function getClass1(param1:String) : Class
      {
         switch(param1)
         {
            case IMAGE_VIEW:
               return ImageView;
            case BUTTON:
               return ButtonView;
            case SWITCH_BUTTON:
               return SwitchButton;
            case TEXT:
               return TextView;
            case EXTERNAL:
               throw new Error();
            case GRID_VIEW:
               return GridView;
            case GRID_PAGER:
               return TileListView;
            case SCROLL:
               return ScrollView;
            case SLIDER:
               return ListView;
            case SPINNER:
               return ShopItemList;
            case VIEW:
            case "ScrollBarView":
            case "ContentView":
            case "GridContentView":
               return UIComponent;
            default:
               return getDefinitionByName(param1) as Class;
         }
      }
   }
}

