package social
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   
   public class AvatarImage extends Bitmap
   {
      
      private var _avatarImageUrl:String;
      
      private var imageLoader:ImageLoader;
      
      private var obj10:Object = null;
      
      private var flag40:Boolean = true;
      
      public function AvatarImage(param1:ImageLoader = null, param2:String = null, param3:Loader = null)
      {
         super();
         this.imageLoader = param1;
         this._avatarImageUrl = param2;
         this.update(param3);
      }
      
      public function get content() : DisplayObject
      {
         return this;
      }
      
      public function get url() : String
      {
         return this._avatarImageUrl;
      }
      
      public function update(param1:Loader) : void
      {
         var bitmap:Bitmap = null;
         if(param1 != null)
         {
            if(this._avatarImageUrl == null)
            {
               _avatarImageUrl = param1.loaderInfo.url;
            }
            if(param1.content is MovieClip)
            {
               bitmapData = new BitmapData(param1.content.width,param1.content.height);
               bitmapData.draw(param1.content);
            }
            else
            {
               bitmap = Bitmap(param1.content);
               bitmapData = bitmap.bitmapData;
            }
         }
      }
      
      public function updateImage(param1:Bitmap, param2:Boolean = true) : void
      {
         this.flag40 = param2;
         bitmapData = param1.bitmapData;
      }
      
      public function set propValue74(param1:Object) : void
      {
         obj10 = param1;
         if(this.obj10 != null && this.obj10.images.indexOf(this) < 0)
         {
            this.obj10.images.push(this);
         }
      }
      
      public function dispose() : void
      {
         var index:int = 0;
         this.imageLoader.doAction584(this);
         if(this.obj10)
         {
            index = this.obj10.images.indexOf(this);
            if(index >= 0)
            {
               this.obj10.images.splice(index,1);
               if(this.obj10.images.length == 0 && !this.obj10.cached)
               {
                  this.doAction334();
               }
            }
         }
      }
      
      public function doAction334() : void
      {
         if(this.flag40)
         {
            bitmapData.dispose();
         }
      }
      
      public function setPos(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
   }
}

