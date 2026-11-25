package ui.menus
{
   import ui.buttons.*;
   import net.*;
   import game.*;
   import ui.*;
   
   public class DepodMenu extends TitledMenu
   {
      
      private static const WIDTH:int = 560;
      
      private static const HEIGHT:int = 360;
      
      private static const CELL_WIDTH:int = 140;
      
      private static const CELL_HEIGHT:int = 120;
      
      private static const CELL_GAP:int = 12;
      
      private var __selected_cell:CellButton;
      
      private var enterButton:NButton;
      
      private var passwordButton:NButton;
      
      public function DepodMenu(fields:Array)
      {
         super(TYPE_DEPOD,_("IDS_DEPOD"),WIDTH,HEIGHT);
         drawWindowBg();
         var offset:int = 2;
         var startX:int = WIDTH - CELL_WIDTH * 3 - CELL_GAP * 2 >> 1;
         var startY:int = HEIGHT - CELL_HEIGHT * 2 - CELL_GAP * 1 >> 1;
         var row:int = 0;
         var col:int;
         var cellIndex:int;
         var cellId:int;
         var hasPassword:Boolean;
         var cell:CellButton;
         while(row < 2)
         {
            col = 0;
            while(col < 3)
            {
               cellIndex = row * 3 + col;
               cellId = fields[offset++];
               hasPassword = fields[offset++] == "1";
               cell = new CellButton(cellId,cellIndex,hasPassword,CELL_WIDTH,CELL_HEIGHT,this.onCellClick);
               cell.x = startX + col * (CELL_WIDTH + CELL_GAP);
               cell.y = startY + row * (CELL_HEIGHT + CELL_GAP) - 10;
               if(cellId === 0)
               {
                  bitmaps(cell);
                  addChild(cell);
               }
               else
               {
                  addUIChild(cell);
               }
               col++;
            }
            row++;
         }
         this.enterButton = createButton(16,HEIGHT - 40,_("IDS_ENTER"),this.onEnterClick);
         addUIChild(this.enterButton);
         this.passwordButton = createButton(this.enterButton.x + this.enterButton.width + 3,this.enterButton.y,_("IDS_PASSWORD"),this.onPasswordClick);
      }
      
      private function onPasswordClick(sender:*) : void
      {
         var oldPassword:String;
         var newPassword:String;
         var menu:PasswordRequest;
         if(!this.__selected_cell || this.__selected_cell.id === 0)
         {
            return;
         }
         if(this.__selected_cell.isLocked)
         {
            oldPassword = null;
            newPassword = null;
            menu = new PasswordRequest(function(param1:*):void
            {
               if(oldPassword)
               {
                  newPassword = menu.Password;
                  if(newPassword)
                  {
                     GameSocket.socket.send("1k",__selected_cell.id,oldPassword,newPassword);
                  }
                  else
                  {
                     GameSocket.socket.send("1l",__selected_cell.id,oldPassword);
                  }
                  menu.closeMenu();
               }
               else
               {
                  oldPassword = menu.Password;
                  if(!oldPassword)
                  {
                     return;
                  }
                  menu.title = _("IDS_NEW_PASS_DEP");
                  menu.clear();
               }
            },function(param1:*):void
            {
               menu.closeMenu();
            });
            menu.autoClose = false;
            menu.title = _("IDS_CUR_PASS");
            showModal(menu);
         }
         else
         {
            showModal(new PasswordRequest(function(param1:PasswordRequest):void
            {
               if(param1.Password)
               {
                  GameSocket.socket.send("1j",__selected_cell.id,param1.Password);
               }
            }));
         }
      }
      
      private function onEnterClick(sender:*) : void
      {
         if(!this.__selected_cell || this.__selected_cell.id === 0)
         {
            return;
         }
         if(this.__selected_cell.isLocked)
         {
            showModal(new PasswordRequest(this.acceptPassHandler));
         }
         else
         {
            this.sendEnter(this.__selected_cell.id);
            closeMenu();
         }
      }
      
      private function sendEnter(cellId:int, password:String = "") : void
      {
         GameSocket.socket.send("ec",cellId,password + "|");
      }
      
      private function acceptPassHandler(request:PasswordRequest) : void
      {
         this.sendEnter(this.__selected_cell.id,request.Password);
      }
      
      private function onCellClick(cell:CellButton) : void
      {
         if(cell.id === 0)
         {
            this.hidePasswordButton();
            return;
         }
         if(cell !== this.__selected_cell)
         {
            if(this.__selected_cell)
            {
               this.__selected_cell.unfocus();
            }
            __selected_cell = cell;
            cell.focus();
            if(cell.isPersonal || Client.currentCharacter.isValue49)
            {
               this.showPasswordButton();
            }
            else
            {
               this.hidePasswordButton();
            }
         }
      }
      
      private function showPasswordButton() : void
      {
         this.passwordButton.visible = true;
         if(!this.passwordButton.parent)
         {
            addUIChild(this.passwordButton);
         }
      }
      
      private function hidePasswordButton() : void
      {
         this.passwordButton.visible = false;
      }
   }
}

