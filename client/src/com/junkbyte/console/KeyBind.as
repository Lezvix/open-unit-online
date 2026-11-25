package com.junkbyte.console
{
   public class KeyBind
   {
      
      private var flag84:Boolean;
      
      private var str37:String;
      
      public function KeyBind(param1:*, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false)
      {
         super();
         this.str37 = String(param1).toUpperCase();
         if(param1 is uint)
         {
            this.flag84 = true;
         }
         else if(!param1 || this.str37.length != 1)
         {
            throw new Error("KeyBind: character (first char) must be a single character. You gave [" + param1 + "]");
         }
         if(this.flag84)
         {
            this.str37 = "keycode:" + this.str37;
         }
         if(param2)
         {
            this.str37 += "+shift";
         }
         if(param3)
         {
            this.str37 += "+ctrl";
         }
         if(param4)
         {
            this.str37 += "+alt";
         }
         if(param5)
         {
            this.str37 += "+up";
         }
      }
      
      public function get isValue70() : Boolean
      {
         return this.flag84;
      }
      
      public function get key() : String
      {
         return this.str37;
      }
   }
}

