package game
{
   public class UserList
   {
      
      public var hireClanId:int = 0;
      
      public var clanId:int = 0;
      
      public var intValue64:int = 0;
      
      public var clanName:String = "";
      
      public var clanUrl:String = "";
      
      public var hireClanName:String = "";
      
      public var hireClanUrl:String = "";
      
      public var sessionId:int;
      
      public var userId:int;
      
      public var login:String;
      
      public var level:int;
      
      public var timestamp:int;
      
      public function UserList()
      {
         super();
      }
      
      public static function parse(fields:Array, offset:int) : UserList
      {
         var user:UserList = new UserList();
         user.sessionId = fields[offset];
         user.userId = fields[offset + 1];
         user.login = fields[offset + 2];
         user.level = fields[offset + 3];
         user.clanId = fields[offset + 4];
         user.clanName = fields[offset + 5];
         user.clanUrl = fields[offset + 6];
         user.hireClanId = fields[offset + 7];
         user.hireClanName = fields[offset + 8];
         user.hireClanUrl = fields[offset + 9];
         return user;
      }
   }
}

