package net
{
   import game.World;
   import game.Client;
   import ui.ChatPanel;
   
   public class FightSocket extends GameSocket
   {
      
      public var sessionId:int;
      
      public var fightId:int = -1;
      
      public var str48:String;
      
      public var social:Boolean = false;
      
      public var socialLoginCredentials:Object = {};
      
      public var login:String;
      
      public var password:String;
      
      public function FightSocket(param1:World, param2:Client)
      {
         super(param1,param2);
      }
      
      public function loginFight() : void
      {
         if(this.social)
         {
            send(Commands.FRIENDS_0n,this.socialLoginCredentials.type,this.socialLoginCredentials.id,this.socialLoginCredentials.token);
         }
         else
         {
            sendStr("lg|" + this.login + "|" + this.password + "|");
         }
      }
      
      override protected function handleData() : Boolean
      {
         switch(getData[0])
         {
            case "lg":
               ChatPanel.instance.propValue64 = getData[1];
               client.sessionId = getData[2];
               sessionId = getData[2];
               world.mapWidth = getData[3];
               world.mapHeight = getData[4];
               return true;
         }
         return super.handleData();
      }
   }
}

