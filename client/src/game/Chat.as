package game
{
   import core.resources.Localization;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import mx.utils.StringUtil;
   
   public final class Chat
   {
      
      public function Chat()
      {
         super();
      }
      
      public static function formatNumber(param1:Number) : String
      {
         var integerPart:String = param1.toString();
         if(-1000 < param1 && param1 < 1000)
         {
            return integerPart;
         }
         var suffix:String = "";
         var decimalPoint:int = integerPart.lastIndexOf(".");
         if(decimalPoint != -1)
         {
            suffix = integerPart.slice(decimalPoint);
            integerPart = integerPart.slice(0,decimalPoint);
         }
         while(integerPart.length > 3)
         {
            if(integerPart.length == 4 && integerPart.charAt(0) == "-")
            {
               break;
            }
            suffix = "," + integerPart.slice(-3) + suffix;
            integerPart = integerPart.slice(0,-3);
         }
         return integerPart + suffix;
      }
      
      public static function stripslashes(param1:String) : String
      {
         return param1.replace(/\\r/g,"\n").replace(/\\n/g,"\n").replace(/\\'/g,"\'").replace(/\\"/g,"\"").replace(/\\\\/g,"\\");
      }
      
      public static function getBitmapData2(param1:BitmapData) : BitmapData
      {
         var flipped:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         flipped.draw(param1,new Matrix(-1,0,0,1,param1.width,0),null,null,null,true);
         return flipped;
      }
      
      public static function getBitmapData1(param1:BitmapData) : BitmapData
      {
         var flipped:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         flipped.draw(param1,new Matrix(1,0,0,-1,0,param1.height),null,null,null,true);
         return flipped;
      }
      
      public static function secondsToStr(param1:int) : String
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 < 60)
         {
            return "0\':" + param1 + "\"";
         }
         if(param1 < 3600)
         {
            return int(param1 / 60) + "\':" + int(param1 % 60) + "\"";
         }
         return int(param1 / 3600) + ":" + int(param1 % 3600 / 60) + "\':" + int(param1 % 60) + "\"";
      }
      
      public static function getString52(param1:String) : String
      {
         if(param1 && param1.length > 0 && !isNaN(Number(param1.charAt(0))))
         {
            return "+" + param1;
         }
         return param1;
      }
      
      public static function doAction485(param1:Array, param2:Function) : void
      {
         var index:int = 0;
         var item:Object = null;
         var insertionIndex:int = 0;
         if(param1.length > 1)
         {
            index = 1;
            while(index < param1.length)
            {
               item = param1[index];
               insertionIndex = index - 1;
               while(insertionIndex >= 0 && param2(param1[insertionIndex],item) == 1)
               {
                  param1[insertionIndex + 1] = param1[insertionIndex];
                  insertionIndex--;
               }
               param1[insertionIndex + 1] = item;
               index++;
            }
         }
      }
      
      public static function round(param1:Number, param2:int = 0) : Number
      {
         var factor:int = 0;
         if(param2 == 0)
         {
            return Math.round(param1);
         }
         if(param2 > 0)
         {
            param2 = Math.min(9,param2);
            factor = Math.pow(10,param2);
            return Math.round(param1 * factor) / factor;
         }
         param2 = Math.max(-9,param2);
         factor = Math.pow(10,-param2);
         return Math.round(param1 / factor) * factor;
      }
      
      private static function getString57(param1:String) : String
      {
         var parts:Array = param1.split(",");
         if(parts.length == 2 || parts.length == 1)
         {
            var value:Number = parseFloat(parts[0]);
            var precision:Number = 0;
            if(parts.length == 2)
            {
               precision = parseInt(parts[1]);
            }
            if(isNaN(value) || isNaN(precision))
            {
               return param1;
            }
            return round(value,precision).toString();
         }
         return param1;
      }
      
      public static function getString32(param1:Number) : String
      {
         var date:Date = new Date((param1 + 4 * 60 * 60) * 1000);
         var formatted:String = "";
         if(date.date < 10)
         {
            formatted += "0";
         }
         formatted += date.date + ".";
         if(date.month < 9)
         {
            formatted += "0";
         }
         formatted += date.month + 1 + ".";
         return formatted + date.fullYear.toString().substr(2,2);
      }
      
      private static function applyTextFilter(param1:String, param2:String, param3:Function) : String
      {
         var start:int = 0;
         var end:int = 0;
         param2 = "@" + param2 + "(";
         while(true)
         {
            start = param1.indexOf(param2);
            if(start == -1)
            {
               break;
            }
            end = param1.indexOf(")",start + param2.length);
            if(end == -1)
            {
               break;
            }
            param1 = param1.slice(0,start) + param3(param1.slice(start + param2.length,end)) + param1.slice(end + 1);
         }
         return param1;
      }
      
      public static function getString34(param1:int) : String
      {
         var absoluteAmount:int = Math.abs(param1);
         var currencyWord:String = "рублей";
         var lastDigit:int = absoluteAmount % 10;
         if(lastDigit >= 2 && lastDigit <= 4 && (absoluteAmount <= 4 || absoluteAmount >= 22))
         {
            currencyWord = "рубля";
         }
         else if(lastDigit == 1 && absoluteAmount != 11)
         {
            currencyWord = "рубль";
         }
         return formatNumber(param1) + " " + currencyWord;
      }
      
      private static function getString28(param1:String) : String
      {
         var argumentsList:Array = param1.split("|");
         if(argumentsList.length > 1)
         {
            return StringUtil.substitute.apply(null,argumentsList);
         }
         return param1;
      }
      
      private static function getString25(param1:String) : String
      {
         return param1.toUpperCase();
      }
      
      public static function prepareText(param1:String) : String
      {
         param1 = applyTextFilter(param1,"stripslashes",stripslashes);
         param1 = applyTextFilter(param1,"upper",getString25);
         param1 = applyTextFilter(param1,"days",getString22);
         param1 = applyTextFilter(param1,"hours",hours);
         param1 = applyTextFilter(param1,"longtime",getString56);
         param1 = applyTextFilter(param1,"shorttime",secondsToStr);
         param1 = applyTextFilter(param1,"shortdate",getString32);
         param1 = applyTextFilter(param1,"ref",Localization.getString);
         param1 = applyTextFilter(param1,"round",getString57);
         param1 = applyTextFilter(param1,"commas",formatNumber);
         param1 = applyTextFilter(param1,"sign",getString52);
         param1 = applyTextFilter(param1,"money",getString34);
         param1 = applyTextFilter(param1,"inject",getString28);
         param1 = applyTextFilter(param1,"if",getString16);
         return param1;
      }
      
      private static function getString16(param1:String) : String
      {
         var parts:Array = null;
         var bounds:Array = null;
         parts = param1.split(",");
         if(parts.length == 5)
         {
            switch(parts[0])
            {
               case "eq":
                  return parts[1] == parts[2] ? parts[3] : parts[4];
               case "neq":
                  return parts[1] != parts[2] ? parts[3] : parts[4];
               case "gt":
                  return Number(parts[1]) > Number(parts[2]) ? parts[3] : parts[4];
               case "between":
                  bounds = parts[2].split(":",2);
                  return Number(parts[1]) >= Number(bounds[0]) && Number(parts[1]) <= Number(bounds[1]) ? parts[3] : parts[4];
               default:
                  return param1;
            }
         }
         else
         {
            return param1;
         }
      }
      
      private static function getString22(param1:int) : String
      {
         if(param1 != 11 && param1 % 10 == 1)
         {
            return param1 + " день";
         }
         if(param1 % 10 >= 2 && param1 % 10 <= 4 && (param1 < 5 || param1 > 21))
         {
            return param1 + " дня";
         }
         return param1 + " дней";
      }
      
      public static function getString56(param1:int) : String
      {
         var parts:Array = null;
         var days:int = 0;
         var hoursCount:int = 0;
         var minutes:int = 0;
         var seconds:int = 0;
         if(param1 < 0)
         {
            return Localization.getString("IDS_FOREVER");
         }
         parts = [];
         days = param1 / (3600 * 24);
         hoursCount = param1 % (3600 * 24) / 3600;
         minutes = param1 % 3600 / 60;
         seconds = param1 % 60;
         if(days != 0)
         {
            parts.push(getString22(days));
         }
         if(hoursCount != 0)
         {
            parts.push(hoursCount + Localization.getString("IDS_HOURS"));
         }
         if(minutes != 0)
         {
            parts.push(minutes + Localization.getString("IDS_MINUTES"));
         }
         if(seconds != 0 || parts.length == 0)
         {
            parts.push(seconds + Localization.getString("IDS_SECONDS"));
         }
         return parts.join(" ");
      }
      
      public static function hours(param1:int) : String
      {
         if(param1 < 0)
         {
            return "";
         }
         return int(param1 / 3600) + Localization.getString("IDS_HOURS");
      }
      
      public static function getString38(param1:*) : String
      {
         var result:String = "";
         var item:InventoryItem;
         for each(item in param1)
         {
            result += item.inventoryId + "|" + item.count + "|";
         }
         return result;
      }
      
      public static function getInt45(param1:InventoryItem, param2:InventoryItem) : int
      {
         if(param1.level != param2.level)
         {
            return param1.level < param2.level ? 1 : -1;
         }
         return param1.itemname < param2.itemname ? -1 : 1;
      }
      
      public static function filter(param1:*, param2:Function = null) : Array
      {
         var result:Array = [];
         var item:*;
         if(param2 == null)
         {
            for each(item in param1)
            {
               if(item)
               {
                  result.push(item);
               }
            }
         }
         else
         {
            for each(item in param1)
            {
               if(param2(item))
               {
                  result.push(item);
               }
            }
         }
         return result;
      }
      
      public static function doAction936(... rest) : void
      {
      }
      
      public static function getArray10(param1:int, param2:int, param3:int = 1) : Array
      {
         var result:Array = new Array();
         if(param3 == 0 || param1 > param2 && param3 > 0 || param1 < param2 && param3 < 0)
         {
            return result;
         }
         var value:int = param1;
         while(value < param2)
         {
            result.push(value);
            value += param3;
         }
         return result;
      }
   }
}

