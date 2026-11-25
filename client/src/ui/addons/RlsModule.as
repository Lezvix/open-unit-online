package ui.addons
{
   import flash.display.Bitmap;
   
   public class RlsModule extends Addon
   {
      
      public function RlsModule()
      {
         super(TYPE_RLS_MODULE);
         var body:Bitmap = getBmp("RLS_MODULE");
         draw(body);
         width = body.width;
         height = body.height;
      }
   }
}

