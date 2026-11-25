package com.junkbyte.console.vos
{
   import com.junkbyte.console.core.Executer;
   import flash.utils.ByteArray;
   
   public class GraphInterest
   {
      
      private var weakRef2:WeakRef;
      
      public var str19:String;
      
      private var flag17:Boolean;
      
      public var key:String;
      
      public var col:Number;
      
      public var v:Number;
      
      public var numValue46:Number;
      
      public function GraphInterest(param1:String = "", param2:Number = 0)
      {
         super();
         this.col = param2;
         this.key = param1;
      }
      
      public static function getGraphGroup1(param1:ByteArray) : GraphInterest
      {
         var interest:GraphInterest = new GraphInterest(param1.readUTF(),param1.readUnsignedInt());
         interest.v = param1.readDouble();
         interest.numValue46 = param1.readDouble();
         return interest;
      }
      
      public function getNumber5(param1:Object, param2:String) : Number
      {
         weakRef2 = new WeakRef(param1);
         str19 = param2;
         flag17 = this.str19.search(/[^\w\d]/) >= 0;
         v = this.getNumber6();
         numValue46 = this.v;
         return this.v;
      }
      
      public function get obj() : Object
      {
         return this.weakRef2 != null ? this.weakRef2.propValue182 : undefined;
      }
      
      public function get prop() : String
      {
         return this.str19;
      }
      
      public function getNumber6() : Number
      {
         return this.flag17 ? Executer.doAction478(this.obj,this.str19) : this.obj[this.str19];
      }
      
      public function setValue(param1:Number, param2:uint = 0) : void
      {
         v = param1;
         if(param2 > 0)
         {
            if(isNaN(this.numValue46))
            {
               numValue46 = this.v;
            }
            else
            {
               numValue46 += (this.v - this.numValue46) / param2;
            }
         }
      }
      
      public function doAction32(param1:ByteArray) : void
      {
         param1.writeUTF(this.key);
         param1.writeUnsignedInt(this.col);
         param1.writeDouble(this.v);
         param1.writeDouble(this.numValue46);
      }
   }
}

