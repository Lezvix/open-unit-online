package com.junkbyte.console.vos
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public dynamic class WeakObject extends Proxy
   {
      
      private var _item:Array;
      
      private var tanVal:Object;
      
      public function WeakObject()
      {
         super();
         this.tanVal = new Object();
      }
      
      public function set(param1:String, param2:Object, param3:Boolean = false) : void
      {
         if(param2 == null)
         {
            delete this.tanVal[param1];
         }
         else
         {
            this.tanVal[param1] = new WeakRef(param2,param3);
         }
      }
      
      public function get(param1:String) : *
      {
         var reference:WeakRef = this.getWeakRef1(param1);
         return reference ? reference.propValue182 : undefined;
      }
      
      public function getWeakRef1(param1:String) : WeakRef
      {
         return this.tanVal[param1] as WeakRef;
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return this.get(param1);
      }
      
      override flash_proxy function callProperty(param1:*, ... rest) : *
      {
         var callable:Object = this.get(param1);
         return callable.apply(this,rest);
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         this.set(param1,param2);
      }
      
      override flash_proxy function nextName(param1:int) : String
      {
         return this._item[param1 - 1];
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return this[this.nextName(param1)];
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         var propertyKey:*;
         if(param1 == 0)
         {
            _item = new Array();
            for(propertyKey in this.tanVal)
            {
               this._item.push(propertyKey);
            }
         }
         if(param1 < this._item.length)
         {
            return param1 + 1;
         }
         return 0;
      }
      
      override flash_proxy function deleteProperty(param1:*) : Boolean
      {
         return delete this.tanVal[param1];
      }
      
      public function toString() : String
      {
         return "[WeakObject]";
      }
   }
}

