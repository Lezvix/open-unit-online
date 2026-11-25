package ui.buttons
{
   import net.GameSocket;
   
   public class UserInfoButton extends ImageButton
   {
      
      protected var userId:int;
      
      public function UserInfoButton(param1:int)
      {
         this.userId = param1;
         super(this.doAction374);
      }
      
      protected function doAction374(param1:Object) : void
      {
         GameSocket.socket.getCharInfo(this.userId);
      }
   }
}

