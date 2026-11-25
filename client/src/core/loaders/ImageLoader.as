package core.loaders
{
   import flash.display.Loader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   internal class ImageLoader extends Loader
   {
      
      private var intValue174:int;
      
      private var request1:URLRequest;
      
      private var idValue:String;
      
      public function ImageLoader(param1:String)
      {
         super();
         this.idValue = param1;
         this.request1 = new URLRequest(param1);
      }
      
      public function get id() : String
      {
         return this.idValue;
      }
      
      override public function load(param1:URLRequest, param2:LoaderContext = null) : void
      {
         throw new Error();
      }
      
      public function get propValue99() : int
      {
         return this.intValue174;
      }
      
      public function doAction179() : void
      {
         intValue174 += 1;
         super.load(this.request1);
      }
   }
}

