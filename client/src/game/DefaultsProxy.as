package game
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import mx.utils.ObjectUtil;
   
   public dynamic class DefaultsProxy extends Proxy
   {
      
      protected var value5:*;
      
      protected var objectList3:Vector.<Object> = new Vector.<Object>();
      
      protected var objectList2:Vector.<Object> = new Vector.<Object>();
      
      public function DefaultsProxy(param1:* = null)
      {
         super();
         this.value5 = param1;
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean
      {
         return this.getInt28(param1) != -1;
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         var index:int = this.getInt28(param1);
         if(index == -1)
         {
            this.objectList3.push(param1);
            this.objectList2.push(this.value5 == null ? null : ObjectUtil.copy(this.value5));
            return this.objectList2[this.objectList2.length - 1];
         }
         else
         {
            return this.objectList2[index];
         }
      }
      
      protected function getInt28(param1:*) : int
      {
         var index:int = this.objectList3.length - 1;
         while(index >= 0)
         {
            if(this.objectList3[index] == param1)
            {
               break;
            }
            index--;
         }
         return index;
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var index:int = this.getInt28(param1);
         if(index == -1)
         {
            this.objectList3.push(param1);
            this.objectList2.push(param2);
         }
         else
         {
            this.objectList2[index] = param2;
         }
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return param1 < this.objectList3.length ? param1 + 1 : 0;
      }
      
      override flash_proxy function nextName(param1:int) : String
      {
         return this.objectList3[param1 - 1].toString();
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return this.objectList2[param1 - 1];
      }
      
      public function get size() : int
      {
         return this.objectList3.length;
      }
      
      public function clear() : void
      {
         objectList3 = new Vector.<Object>();
         objectList2 = new Vector.<Object>();
      }
   }
}

