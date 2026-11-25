package game
{
   public class ShopItem
   {
      
      public static const PAY_FILTER_ARMOR:int = 0;
      
      public static const PAY_FILTER_WEAPON:int = 1;
      
      public static const PAY_FILTER_BULLET:int = 2;
      
      public static const PAY_FILTER_MEDICINE:int = 3;
      
      public static const PAY_FILTER_MONEY:int = 4;
      
      public static const PAY_FILTER_ALL:int = 5;
      
      public static const PAY_FILTER_COUNT:int = 6;
      
      public static const PAY_FILTER_7:int = 7;
      
      public static const PAY_FILTER_8:int = 8;
      
      public static const PAY_FILTER_91:int = 91;
      
      public static const PAY_FILTER_92:int = 92;
      
      public static const PAY_FILTER_93:int = 93;
      
      public static const PAY_FILTER_94:int = 94;
      
      public static const array60:Array = [PAY_FILTER_91,PAY_FILTER_92,PAY_FILTER_93,PAY_FILTER_94];
      
      private var _packId:int;
      
      private var _filterGroup:int;
      
      private var _image:int;
      
      private var _name:String;
      
      private var _cost:int;
      
      private var _discount:int;
      
      private const _items:Vector.<InventoryItem> = new Vector.<InventoryItem>();
      
      public function ShopItem()
      {
         super();
      }
      
      public function create(fields:Array) : int
      {
         var position:int = 0;
         _packId = fields[position++];
         _filterGroup = fields[position++];
         _image = fields[position++];
         _name = fields[position++];
         _cost = fields[position++];
         _discount = fields[position++];
         var itemCount:int = fields[position++];
         var itemIndex:int = 0;
         var recordLength:int;
         while(itemIndex < itemCount)
         {
            recordLength = fields[position];
            this.items.push(new InventoryItem(fields.slice(position,position + recordLength)));
            position += recordLength;
            itemIndex++;
         }
         return position;
      }
      
      public function get packId() : int
      {
         return this._packId;
      }
      
      public function get filterGroup() : int
      {
         return this._filterGroup;
      }
      
      public function get items() : Vector.<InventoryItem>
      {
         return this._items;
      }
      
      public function get image() : int
      {
         return this._image;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get cost() : int
      {
         return this._cost;
      }
      
      public function get discount() : int
      {
         return this._discount;
      }
      
      public function filter(filterId:int) : Boolean
      {
         var skillType:int = 0;
         if(filterId == PAY_FILTER_7 || this.filterGroup == filterId)
         {
            return true;
         }
         if(this.filterGroup == PAY_FILTER_WEAPON && array60.indexOf(filterId) != -1)
         {
            if(!this._items[0].isWeapon)
            {
               return false;
            }
            skillType = this._items[0].params[InventoryItem.WP_SKILL_TYPE];
            switch(skillType)
            {
               case 0:
                  return filterId == PAY_FILTER_91;
               case 1:
                  return filterId == PAY_FILTER_92;
               case 2:
                  return filterId == PAY_FILTER_93;
               case 3:
                  return filterId == PAY_FILTER_94;
               default:
                  return false;
            }
         }
         else
         {
            return false;
         }
      }
   }
}

