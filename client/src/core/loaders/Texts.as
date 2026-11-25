package core.loaders
{
   public class Texts
   {
      
      public function Texts()
      {
         super();
      }
      
      public static function getString41(param1:String) : String
      {
         return "Территория захвачена кланом \"" + param1 + "\"";
      }
      
      public static function getString17(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return "В данной зоне PvP разрешен";
            case 1:
               return "В данной зоне PvP запрещен";
            case 2:
               return "В данной зоне PvP поощряется";
            case 3:
               return "В данной зоне PvP разрешен. Выпадение лута игроков 100% вне зависимости от уровня";
            case 4:
               return "В данной зоне PvP поощряется. Выпадение лута игроков 100% вне зависимости от уровня";
            default:
               return null;
         }
      }
      
      public static function getString39() : String
      {
         return "Скрывать сообщения игнор-списка";
      }
   }
}

