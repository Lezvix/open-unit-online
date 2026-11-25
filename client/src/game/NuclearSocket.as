package game
{
   import net.FightSocket;
   import ui.CharacterInfo;

   public class NuclearSocket extends FightSocket
   {

      private var main:Main;

      public var createCharInfoFunc:Function;

      public function NuclearSocket(param1:World, param2:Main)
      {
         this.main = param2;
         super(param1,param2);
         host = "unit-online.ru";
         port = uint("5190");
      }

      override protected function handleData() : Boolean
      {
         var characterInfo:CharacterInfo = null;
         var character:Character = null;
         var position:int = 0;
         switch(getData[0])
         {
            case "ci":
               if(getData.length > 2)
               {
                  characterInfo = this.createCharInfoFunc();
                  character = new Character();
                  position = character.parseInfo(getData);
                  character.parseTraums(getData,position);
                  characterInfo.character = character;
                  characterInfo.init();
                  characterInfo.loadAppearance();
                  characterInfo.doAction340();
                  characterInfo.updateTraums();
               }
               return true;
         }
         return super.handleData();
      }
   }
}
