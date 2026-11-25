package core.ui.views
{
   import core.resources.ResourceManager;
   import core.ui.UIComponent;
   import core.ui.UIElement;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ViewFactory
   {
      
      private static var uiComponentList1:Object = null;
      
      public function ViewFactory()
      {
         super();
         throw new Error();
      }
      
      private static function init() : void
      {
         if(UIElement.uiPackId == -1)
         {
            throw new Error("ui not loaded");
         }
         uiComponentList1 = ResourceManager.sharedInstance.getObject3(UIElement.uiPackId).items;
      }
      
      public static function getUIComponent2(param1:String) : UIComponent
      {
         if(uiComponentList1 == null)
         {
            init();
         }
         if(param1 in uiComponentList1)
         {
            return getUIComponent1(uiComponentList1[param1]);
         }
         throw new Error("unknown ui item: " + param1);
      }
      
      private static function getUIComponent1(param1:Object) : UIComponent
      {
         var component:UIComponent = param1.type == ViewTypes.EXTERNAL ? getUIComponent2(param1.external) : new (ViewTypes.getClass1(param1.type))();
         var index:int;
         component.doAction600(param1);
         if(param1.views)
         {
            index = 0;
            while(index < param1.views.length)
            {
               component.addView(getUIComponent1(param1.views[index]));
               index++;
            }
         }
         component.reshape();
         return component;
      }
      
      public static function getRectangle1(param1:UIComponent, param2:UIComponent, param3:Rectangle) : Rectangle
      {
         var bindingPoint:Point = param2.bindingPoint;
         var horizontalBounds:Point = getPoint2(param1.width,param3.width,param2.x,param2.x + param2.width,param2.x + bindingPoint.x,param2.alignment,param2.min.width,param2.max.width);
         var verticalBounds:Point = getPoint2(param1.height,param3.height,param2.y,param2.y + param2.height,param2.y + bindingPoint.y,param2.alignment >> 3,param2.min.height,param2.max.height);
         return new Rectangle(horizontalBounds.x,verticalBounds.x,horizontalBounds.y - horizontalBounds.x,verticalBounds.y - verticalBounds.x);
      }
      
      protected static const VIEW_FACTORY_CONST2:int = 1;

      protected static const VIEW_FACTORY_CONST1:int = 2;

      protected static const VIEW_FACTORY_CONST3:int = 4;

      public static function getPoint2(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int) : Point
      {
         var bounds:Point = new Point();
         var scale:Number = param2 / param1;
         var anchor:int;
         var minScale:Number;
         var maxScale:Number;
         switch(param6 & (VIEW_FACTORY_CONST2 | VIEW_FACTORY_CONST1 | VIEW_FACTORY_CONST3))
         {
            case 0:
               anchor = param5 * scale;
               bounds.x = anchor + param3 - param5;
               bounds.y = anchor + param4 - param5;
               break;
            case VIEW_FACTORY_CONST2:
               bounds.x = param3;
               bounds.y = param4;
               break;
            case VIEW_FACTORY_CONST1:
               bounds.x = param2 - param1 + param3;
               bounds.y = param2 - param1 + param4;
               break;
            case VIEW_FACTORY_CONST3:
               bounds.x = int(param3 * scale);
               bounds.y = int(param4 * scale);
               if(param7 != -1 && bounds.y - bounds.x < param7)
               {
                  minScale = param7 / (param4 - param3);
                  anchor = param5 * scale;
                  bounds.x = anchor - int((param5 - param3) * minScale);
                  bounds.y = anchor + int((param4 - param5) * minScale);
               }
               if(param8 != -1 && bounds.y - bounds.x > param8)
               {
                  maxScale = param8 / (param4 - param3);
                  anchor = param5 * scale;
                  bounds.x = anchor - int((param5 - param3) * maxScale);
                  bounds.y = anchor + int((param4 - param5) * maxScale);
               }
               break;
            case VIEW_FACTORY_CONST3 | VIEW_FACTORY_CONST1:
               bounds.x = param3 * scale;
               bounds.y = param2 - param1 + param4;
               if(param7 != -1 && bounds.y - bounds.x < param7)
               {
                  bounds.x = bounds.y - param7;
               }
               if(param8 != -1 && bounds.y - bounds.x > param8)
               {
                  bounds.x = bounds.y - param8;
               }
               break;
            case VIEW_FACTORY_CONST2 | VIEW_FACTORY_CONST3 | VIEW_FACTORY_CONST1:
               bounds.x = param3;
               bounds.y = param2 - param1 + param4;
               break;
            case VIEW_FACTORY_CONST2 | VIEW_FACTORY_CONST3:
               bounds.x = param3;
               bounds.y = param4 * scale;
               if(param7 != -1 && bounds.y - bounds.x < param7)
               {
                  bounds.y = bounds.x + param7;
               }
               if(param8 != -1 && bounds.y - bounds.x > param8)
               {
                  bounds.y = bounds.x + param8;
               }
               break;
            default:
               break;
         }
         return bounds;
      }
   }
}

