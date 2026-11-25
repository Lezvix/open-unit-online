package core.ui
{
   import utils.JsonUtil;
   import flash.display.Bitmap;
   import flash.utils.ByteArray;
   
   public class ComponentFactory
   {
      
      protected static var componentFactory1:ComponentFactory = null;
      
      private static const COMPONENT_IMAGE:String = "ComponentImage";
      
      private static const COMPONENT_COMPONENT:String = "ComponentComponent";
      
      private static const DEFAULT2:String = "Default";
      
      private static const TILE:String = "Tile";
      
      private static const RESIZE2:String = "Resize";
      
      private var _data:Object;
      
      private var obj55:Object = new Object();
      
      private var obj2:Object = new Object();
      
      public function ComponentFactory()
      {
         super();
      }
      
      public static function doAction860(param1:String, param2:UIComponent, param3:Array) : void
      {
         componentFactory1.doAction860(param1,param2,param3);
      }
      
      public static function init(param1:ByteArray) : void
      {
         if(componentFactory1 == null)
         {
            componentFactory1 = new ComponentFactory();
         }
         componentFactory1.init(param1);
      }
      
      public function init(param1:ByteArray) : void
      {
         _data = new Object();
         var json:String = param1.readUTFBytes(param1.length);
         var parsed:Object = JsonUtil.doAction546(json);
         var componentDefinition:Object;
         for each(componentDefinition in parsed.components)
         {
            this._data[componentDefinition.id] = componentDefinition;
         }
      }
      
      private function doAction825(param1:Object, param2:UIComponent) : void
      {
         var bitmap:Bitmap = param2.getBmp(param1.refId);
         switch(param1.transform.type)
         {
            case TILE:
               param2.drawTile(bitmap,param1.x,param1.y,param1.transform.w,param1.transform.h);
               break;
            case RESIZE2:
               param2.drawWithScale(bitmap,param1.x,param1.y,param1.transform.w,param1.transform.h);
               break;
            default:
               param2.draw(bitmap,param1.x,param1.y);
               break;
         }
      }
      
      public function doAction860(param1:String, param2:UIComponent, param3:Array) : void
      {
         var definition:Object = this._data[param1];
         var drawable:Object;
         var childDefinition:Object;
         var extra:Object;
         var extraValue:String;
         var command:MenuCommand;
         var element:UIElement;
         var candidate:MenuCommand;
         var childComponent:UIComponent;
         param2.fillRect(0,0,definition.width,definition.height,16777215,0);
         param2.width = definition.width;
         param2.height = definition.height;
         for each(drawable in definition.drawable)
         {
            switch(drawable.type)
            {
               case COMPONENT_IMAGE:
                  this.doAction825(drawable,param2);
                  break;
               case COMPONENT_COMPONENT:
                  childDefinition = this._data[drawable.refId];
                  if(childDefinition != null)
                  {
                     extra = new Object();
                     for each(extraValue in childDefinition.defaultExtra)
                     {
                        extra[extraValue] = childDefinition.defaultExtr[extraValue];
                     }
                     for each(extraValue in drawable.extra)
                     {
                        extra[extraValue] = drawable.extra[extraValue];
                     }
                     command = null;
                     if(param3 != null)
                     {
                        for each(candidate in param3)
                        {
                           if(candidate.id == childDefinition.id && command == null)
                           {
                              command = candidate;
                           }
                           if(candidate.propValue55 == drawable.id)
                           {
                              command = candidate;
                           }
                        }
                     }
                     if(command != null)
                     {
                        element = command.create(extra);
                     }
                     else if(this.obj2[drawable.id] != null)
                     {
                        element = this.obj2[drawable.id].create(extra);
                     }
                     else if(this.obj55[childDefinition.id] != null)
                     {
                        element = this.obj55[drawable.id].create(extra);
                     }
                     else
                     {
                        childComponent = new UIComponent();
                        this.doAction860(drawable.refId,childComponent,param3);
                     }
                     element.x = drawable.x;
                     element.y = drawable.y;
                     param2.addUIChild(element);
                  }
                  else
                  {
                     throw new Error("ui component id is incorrect");
                  }
                  break;
               default:
                  throw new Error("ui component type is incorrect");
            }
         }
      }
      
      public function doAction624(param1:String, param2:String, param3:Function) : void
      {
         var command:MenuCommand = new MenuCommand(param1,param2,param3);
         if(param1 != null)
         {
            this.obj55[param1] = command;
         }
         if(param2 != null)
         {
            this.obj2[param2] = command;
         }
      }
   }
}

