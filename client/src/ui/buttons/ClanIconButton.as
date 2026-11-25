package ui.buttons
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class ClanIconButton extends NButton
   {
      
      public function ClanIconButton(clan:Object, clickHandler:Function = null)
      {
         var loader:Loader = new Loader();
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIconLoad);
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onIconLoad);
         loader.load(new URLRequest("icons/icon/clan" + clan.id + ".png"));
         super(clickHandler,loader);
         hintText = clan.name;
      }
      
      private function onIconLoad(event:Event) : void
      {
         event.target.removeEventListener(Event.COMPLETE,this.onIconLoad);
         event.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onIconLoad);
      }
   }
}

