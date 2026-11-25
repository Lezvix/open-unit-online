package game.world
{
   public class Direction extends IJPoint
   {
      
      public static const D:int = 1;
      
      public static const HIDE_22:int = 2;
      
      public static const HIDE_76:int = 3;
      
      public static const HIDE_42:int = 4;
      
      public static const HIDE_852:int = 5;
      
      public static const HIDE_6:int = 6;
      
      public static const HIDE_822:int = 7;
      
      public static const HIDE_83:int = 8;
      
      public var dir:int;
      
      private var ijPoint3:IJPoint;
      
      private var ijPoint2:IJPoint;
      
      public function Direction()
      {
         super();
      }
      
      public function getInt46() : int
      {
         var previousDirection:int = this.dir - 1;
         if(previousDirection < D)
         {
            previousDirection = HIDE_83;
         }
         return previousDirection;
      }
      
      public function getInt21() : int
      {
         var nextDirection:int = this.dir + 1;
         if(nextDirection > HIDE_83)
         {
            nextDirection = D;
         }
         return nextDirection;
      }
      
      public function doAction240(param1:int) : void
      {
         this.dir = param1;
         switch(param1)
         {
            case D:
               i = 1;
               j = 0;
               break;
            case HIDE_22:
               i = 1;
               j = -1;
               break;
            case HIDE_76:
               i = 0;
               j = -1;
               break;
            case HIDE_42:
               i = -1;
               j = -1;
               break;
            case HIDE_852:
               i = -1;
               j = 0;
               break;
            case HIDE_6:
               i = -1;
               j = 1;
               break;
            case HIDE_822:
               i = 0;
               j = 1;
               break;
            case HIDE_83:
               i = 1;
               j = 1;
               break;
            default:
               throw new Error("Undupported direction : " + param1);
         }
      }
      
      public function clone() : Direction
      {
         var copy:Direction = new Direction();
         copy.i = i;
         copy.j = j;
         copy.dir = this.dir;
         return copy;
      }
   }
}

