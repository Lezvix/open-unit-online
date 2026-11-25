package game.world
{
   import core.system.EventListeners;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class AnimationLoader
   {
      
      public static const ANIMATION_LOADER_CONST1:int = 5;
      
      private var array116:Array = new Array();
      
      private var obj70:Object = new Object();
      
      private var loadedMovies:Object = new Object();
      
      public function AnimationLoader()
      {
         super();
      }
      
      public function doAction703(animated:IAnimated) : void
      {
         var movieIds:Array = animated.propValue126;
         var index:int = 0;
         var movie:Object;
         while(index < movieIds.length)
         {
            movie = this.loadedMovies[movieIds[index]];
            if(movie)
            {
               --movie.count;
               if(movie.count <= 0)
               {
                  delete this.loadedMovies[movieIds[index]];
               }
            }
            index++;
         }
      }
      
      public function doAction704(animated:IAnimated) : void
      {
         var movieIds:Array = animated.propValue126;
         animated.doAction132();
         var index:int = 0;
         var movie:Object;
         var loaderIndex:int;
         var players:Array;
         var pending:Object;
         while(index < movieIds.length)
         {
            movie = this.loadedMovies[movieIds[index]];
            if(movie)
            {
               animated.doAction917(movie.movieContainer);
               ++movie.count;
            }
            else
            {
               loaderIndex = 0;
               while(loaderIndex < this.array116.length && (this.array116[loaderIndex] == null || this.array116[loaderIndex].mcId != movieIds[index]))
               {
                  loaderIndex++;
               }
               if(loaderIndex < this.array116.length)
               {
                  this.array116[loaderIndex].players.push(animated);
               }
               else if(this.array116.length < ANIMATION_LOADER_CONST1)
               {
                  players = new Array();
                  players.push(animated);
                  this.doAction278(movieIds[index],players);
               }
               else
               {
                  pending = this.loadedMovies[movieIds[index]];
                  if(!pending)
                  {
                     pending = {
                        "mcId":movieIds[index],
                        "player":new Array()
                     };
                     this.obj70[movieIds[index]] = pending;
                  }
                  pending.players.push(animated);
               }
            }
            index++;
         }
      }
      
      private function doAction278(movieId:String, players:Array) : void
      {
         var loader:PlayerLoader = new PlayerLoader();
         EventListeners.addEventListener(loader.contentLoaderInfo,Event.COMPLETE,this.doAction843);
         EventListeners.addEventListener(loader.contentLoaderInfo,IOErrorEvent.IO_ERROR,this.doAction803);
         loader.mcId = movieId;
         loader.players = players;
         this.array116.push(loader);
         var request:URLRequest = new URLRequest("animations/" + movieId + ".swf");
         loader.load(request);
      }
      
      private function doAction803(event:IOErrorEvent) : void
      {
      }
      
      private function doAction843(event:Event) : void
      {
         var loader:Object = event.target.loader;
         EventListeners.removeEventListener(loader.contentLoaderInfo,Event.COMPLETE,this.doAction843);
         EventListeners.removeEventListener(loader.contentLoaderInfo,IOErrorEvent.IO_ERROR,this.doAction803);
         this.loadedMovies[loader.mcId] = {
            "count":loader.players.length,
            "movieContainer":loader.content
         };
         var index:int = 0;
         while(index < loader.players.length)
         {
            loader.players[index].movieContainer = loader.content;
            index++;
         }
         var loaderIndex:int = this.array116.indexOf(loader);
         if(loaderIndex >= 0)
         {
            this.array116.splice(loaderIndex,1);
            var pending:Object;
            for each(pending in this.obj70)
            {
               this.doAction278(pending.mcId,pending.players);
               delete this.obj70[pending.mcId];
               return;
            }
         }
      }
   }
}

