package com.junkbyte.console.vos
{
   import flash.utils.Dictionary;
   
   public class WeakRef
   {
      
      private var value3:*;
      
      private var flag110:Boolean;
      
      public function WeakRef(param1:*, param2:Boolean = false)
      {
         super();
         this.flag110 = param2;
         this.propValue182 = param1;
      }
      
      public function get propValue182() : *
      {
         var referent:*;
         if(this.flag110)
         {
            return this.value3;
         }
         for(referent in this.value3)
         {
            return referent;
         }
         return null;
      }
      
      public function set propValue182(param1:*) : void
      {
         if(this.flag110)
         {
            value3 = param1;
         }
         else
         {
            value3 = new Dictionary(true);
            this.value3[param1] = null;
         }
      }
      
      public function get strong() : Boolean
      {
         return this.flag110;
      }
   }
}

