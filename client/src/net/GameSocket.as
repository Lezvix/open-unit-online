package net
{
   import game.world.WorldObject;
   import flash.events.*;
   import flash.geom.Rectangle;
   import flash.utils.*;
   import game.*;
   import mx.events.*;
   import ui.Terminal;
   import ui.NuclearChat;
   import ui.ChatPanel;
   
   public class GameSocket extends NSocket
   {
      
      public static var socket:GameSocket;
      
      public static const ACTION_NONE:int = 0;
      
      public static const ACTION_BARTER:int = 1;
      
      public static const ACTION_DIALOG:int = 2;
      
      public static const ACTION_ASK_REPAIR:int = 3;
      
      public static const ACTION_REPAIR:int = 4;
      
      public static const ACTION_ASK_HEAL:int = 5;
      
      public static const ACTION_HEAL:int = 6;
      
      public var world:World;
      
      protected var client:Client;
      
      public var barterOpId:int;
      
      public var gameIsStarted:Boolean = false;
      
      public var clanLoaded:Boolean = false;
      
      private var dataI:int;
      
      private var dataJ:int;
      
      private var j:int;
      
      private var idx:int;
      
      private var hintStr:String;
      
      public function GameSocket(param1:World, param2:Client)
      {
         super();
         this.world = param1;
         this.client = param2;
         socket = this;
      }
      
      public function enterGame() : void
      {
         sendStr("eg");
      }
      
      public function getCharInfo(param1:int) : void
      {
         sendStr("ci|" + param1);
      }
      
      public function showPaidServices() : void
      {
         sendStr("pd");
      }
      
      public function getPaidPresents() : void
      {
         sendStr("pp");
      }
      
      public function getShopItems() : void
      {
         sendStr("pi");
      }
      
      public function getCharTraums(param1:int) : void
      {
         sendStr("tr|" + param1);
      }
      
      public function getInventory() : void
      {
         sendStr("iv");
      }
      
      public function getCharMenu() : void
      {
         sendStr("cm");
      }
      
      public function sendGetMap() : void
      {
         sendStr("mp");
      }
      
      public function doAction720() : void
      {
         var visibilityFlags:int = 0;
         if(this.gameIsStarted)
         {
            visibilityFlags = 0;
            if(NuclearChat.instance.battleStateOn)
            {
               visibilityFlags |= 1;
            }
            if(!ChatPanel.instance.baseOpenedValue)
            {
               visibilityFlags |= 2;
            }
            if(!NuclearChat.instance.baseOpenedValue)
            {
               visibilityFlags |= 4;
            }
            sendStr("vs|" + visibilityFlags);
         }
      }
      
      public function sendPing() : void
      {
         this.send("pg");
      }
      
      public function doAction603(param1:String, param2:String) : void
      {
         this.send("lg",param1,param2);
      }
      
      public function attack(param1:int) : void
      {
         this.send("at",param1);
      }
      
      public function petAttack(param1:int) : void
      {
         this.send("ap",param1);
      }
      
      public function useObject(param1:WorldObject) : void
      {
         this.send("us",param1.id);
      }
      
      public function sendMove(param1:int, param2:int) : void
      {
         this.send("mv",param1,param2);
      }
      
      public function sendUseItem(param1:int, param2:int) : void
      {
         this.send("ui",param1,param2);
      }
      
      public function sendChangeRun() : void
      {
         this.send("rn");
      }
      
      public function sendStop() : void
      {
         this.send("st");
      }
      
      public function sendStopOperation() : void
      {
         this.send("so");
      }
      
      public function sendDirectUse(param1:int, param2:int, param3:int, param4:Rectangle) : void
      {
         this.send("ud",param1,param2,param3,param4.x,param4.y,param4.width,param4.height);
      }
      
      public function sendUseExp(param1:int) : void
      {
         this.send("ue",param1);
      }
      
      public function doAction90(param1:int, param2:int) : void
      {
         this.send("id",param1,param2);
      }
      
      public function sendChangeHand(param1:int) : void
      {
         this.send("hd",param1);
      }
      
      public function sendClanChatText(param1:int) : void
      {
         this.send("fs",param1);
      }
      
      public function sendReload() : void
      {
         this.send("rd");
      }
      
      public function sendUnloadWeapon() : void
      {
         this.send("un");
      }
      
      public function sendQuestLogRequest() : void
      {
         this.send("ql");
      }
      
      public function sendVisualState(param1:int) : void
      {
         this.send("rp",param1);
      }
      
      public function sendChangeFire(param1:int) : void
      {
         this.send("op",param1);
      }
      
      public function sendHeal(param1:int) : void
      {
         this.send("he",param1);
      }
      
      public function sendActionRequest(param1:int, param2:int) : void
      {
         this.send("ar",param1,param2);
      }
      
      public function sendRepairOwn(param1:int) : void
      {
         this.send("cf",param1);
      }
      
      public function sendUpgradeRequest(param1:int, param2:int) : void
      {
         this.send("iu",param1,param2);
      }
      
      public function sendOpenPresent(param1:int) : void
      {
         this.send("iw",param1);
      }
      
      public function sendRequestUpgradeRecipes() : void
      {
         this.send("rv");
      }
      
      public function sendRequestUpgradeGroups() : void
      {
         this.send("ug");
      }
      
      public function sendRequestCraftRecipes() : void
      {
         this.send("rk");
      }
      
      public function doAction167(param1:int, param2:String) : void
      {
         this.send("ir",param1,param2);
      }
      
      public function doAction699(param1:int = -1) : void
      {
         this.send("aa",param1 == -1 ? this.client.barterUserId : param1);
      }
      
      public function sendCraftRequest(param1:int) : void
      {
         this.send("ai",param1);
      }
      
      public function doAction518(param1:int, param2:int) : void
      {
         this.send("di",param1,param2);
      }
      
      public function sendActionConfirm() : void
      {
         this.send("ac",this.barterOpId);
      }
      
      public function setPrice(param1:int) : void
      {
         this.send("sp",param1);
      }
      
      public function sendActionLeave() : void
      {
         this.send("al");
      }
      
      public function doAction365(param1:int, param2:int) : void
      {
         this.send("ai",param1,param2);
      }
      
      public function sendActionAccept(param1:int) : void
      {
         this.send("af",param1);
      }
      
      public function sendDelFixItem() : void
      {
         this.send("df");
      }
      
      public function sendAddItem(param1:int) : void
      {
         this.send("th",param1);
      }
      
      public function sendDelHealTraum() : void
      {
         this.send("td");
      }
      
      public function sendPlaceRespawn() : void
      {
         this.send("pr");
      }
      
      public function sendLocationsRequest() : void
      {
         this.send("lr");
      }
      
      public function sendAttackZonesRequest() : void
      {
         this.send("zl");
      }
      
      public function sendAuctionRequest(param1:int, param2:int) : void
      {
         this.send("zr",param1,param2);
      }
      
      public function sendAvaibleZonesRequest() : void
      {
         this.send("az|");
      }
      
      public function sendExitZonesRequest() : void
      {
         this.send("za|");
      }
      
      public function sendRaidLocationsRequest() : void
      {
         this.send("ry");
      }
      
      public function sendInitRaid(param1:int, param2:String) : void
      {
         this.send("ri",param1,param2);
      }
      
      public function sendJoinRaid(param1:int, param2:String) : void
      {
         this.send("rj",param1,param2);
      }
      
      public function sendStartRaid() : void
      {
         this.send("r4");
      }
      
      public function sendRaidPartiesRequest() : void
      {
         this.send("ro");
      }
      
      public function sendRaidPartyMemberLeave(param1:int) : void
      {
         this.send("rx",param1);
      }
      
      public function sendStopObserveRaidParties() : void
      {
         this.send("r3");
      }
      
      public function doAction567(param1:int, param2:int) : void
      {
         this.send("cz",param1,param2);
      }
      
      public function sendAttackReject(param1:int = 0) : void
      {
         if(param1 == 0)
         {
            this.send("rz");
         }
         else
         {
            this.send("rz",param1);
         }
      }
      
      public function sendDueRequest() : void
      {
         this.send("de");
      }
      
      public function setDue(param1:int) : void
      {
         this.send("sd",param1);
      }
      
      public function doAction298(param1:int) : void
      {
         this.send("dm",param1);
      }
      
      public function sendClanControlRequest() : void
      {
         this.send("co");
      }
      
      public function doAction263(param1:String) : void
      {
         this.send("au",param1);
      }
      
      public function processDue(param1:int) : void
      {
         this.send("ru",param1);
      }
      
      public function setUserPosition(param1:int, param2:int) : void
      {
         this.send("up",param1,param2);
      }
      
      public function sendAddClanUser(param1:int) : void
      {
         this.send("dr",param1);
      }
      
      public function clanAddAccept(param1:int) : void
      {
         this.send("ra",param1,1);
      }
      
      public function clanAddReject(param1:int) : void
      {
         this.send("ra",param1,0);
      }
      
      public function removeClanUser(param1:String) : void
      {
         this.send("mt",param1);
      }
      
      public function sendReferalMenu() : void
      {
         this.send("rm");
      }
      
      public function deleteAddRequest(param1:int) : void
      {
         this.send("bg",param1);
      }
      
      public function sendBuyHair(param1:int, param2:int) : void
      {
         this.send("bh",param1,param2);
      }
      
      public function buyAvatar(param1:int) : void
      {
         this.send("pa",param1);
      }
      
      public function sendLogin(param1:int, param2:String) : void
      {
         this.send("ec",param1,param2 + "|");
      }
      
      public function requestCellLog(param1:int) : void
      {
         this.send("ld",param1);
      }
      
      public function sendPetSettings(param1:String, param2:int, param3:Boolean, param4:int) : void
      {
         this.send("pb",param1,param2,param3 ? 1 : 0,param4 + "|");
      }
      
      public function setServiceActive(param1:int, param2:Boolean) : void
      {
         this.send("sa",param1,param2 ? "1|" : "0|");
      }
      
      public function sendPetAgression(param1:int) : void
      {
         this.send("ag",param1);
      }
      
      public function sendExchangeStartRequest() : void
      {
         this.send("eh");
      }
      
      public function sendExtendCell(param1:int) : void
      {
         this.send("eu",param1);
      }
      
      public function sendAddToExchange(param1:int, param2:int) : void
      {
         this.send("ea",param1,param2);
      }
      
      public function sendDeleteFromExchange() : void
      {
         this.send("er");
      }
      
      public function sendUnlockCell(param1:int) : void
      {
         this.send("ee",param1);
      }
      
      public function doAction844(param1:Boolean) : void
      {
         this.send("hy",param1 ? 1 : 0);
      }
      
      public function sendCellLogRequest(param1:String) : void
      {
         this.send("ha",param1);
      }
      
      public function sendExchangeUpdateRequest(param1:int) : void
      {
         this.send("hi",param1);
      }
      
      public function applyExchange(param1:int) : void
      {
         this.send("hr",param1);
      }
      
      public function sendAddClanHire(param1:int) : void
      {
         this.send("hb",param1);
      }
      
      public function sendRemoveHireByUserId(param1:int) : void
      {
         this.send("hd",param1);
      }
      
      public function sendExitFromHire() : void
      {
         this.send("hm");
      }
      
      public function sendRemoveHireRequest(param1:int) : void
      {
         this.send("ph",param1);
      }
      
      public function sendMyHireRequests() : void
      {
         this.send("hn");
      }
      
      public function sendShowHireAddRequest() : void
      {
         this.send("hf");
      }
      
      public function sendAddPrivateHire(param1:int, param2:int, param3:int, param4:Boolean) : void
      {
         this.send("hg",param1,param2,param3,param4 ? 1 : 0);
      }
      
      public function sendClanHireAccept(param1:int) : void
      {
         this.send("hj",param1);
      }
      
      public function sendLeavePrivateHire(param1:int) : void
      {
         this.send("hl",param1);
      }
      
      public function sendRejectClanHire(param1:int) : void
      {
         this.send("hk",param1);
      }
      
      public function sendPrivateHireRequest(param1:String) : void
      {
         this.send("fu",param1);
      }
      
      public function sendPrivateHireJoin(param1:int) : void
      {
         this.send("ho",param1);
      }
      
      public function sendAcceptProduction(param1:Object) : void
      {
         this.send("pn",1);
      }
      
      public function sendRejectProduction(param1:Object) : void
      {
         this.send("pn",0);
      }
      
      public function sendRadiolocationRequest() : void
      {
         this.send("rr");
      }
      
      public function sendRemovePrivateHire(param1:String) : void
      {
         this.send("rl",param1);
      }
      
      override public function objDataHandler(param1:String) : void
      {
         this.world.objData.push(param1);
      }
      
      public function sendClanZonesRequest() : void
      {
         this.send("ex");
      }
      
      public function sendFindUserByLogin(param1:int) : void
      {
         this.send("tc",param1);
      }
      
      public function send(param1:String, ... rest) : void
      {
         sendStr(rest ? [param1].concat(rest).join("|") : param1);
      }
      
      override protected function handleData() : Boolean
      {
         var unusedNumber:int = 0;
         var unusedUser:UserList = null;
         var fieldIndex:int = 0;
         var recordStart:int = 0;
         var worldObject:WorldObject = null;
         switch(getData[0])
         {
            case "sg":
               ChatPanel.instance.doAction307(getData[1],getData[2],getData.slice(3));
               Terminal.instance.doAction307(getData[1],getData[2],getData.slice(3));
               return true;
            case "mv":
               this.world.playerMove(getData);
               GameEventDispatcher.dispatch(getData);
               return true;
            case "ol":
               dataI = 1;
               while(this.dataI < getData.length - 1)
               {
                  recordStart = this.dataI;
                  worldObject = this.client.world.addObject(getData[this.dataI + 1],getData[this.dataI + 2],getData[this.dataI + 3],getData[this.dataI],getData[this.dataI + 4],getData[this.dataI + 5],getData[this.dataI + 6],getData[this.dataI + 7],getData[this.dataI + 8],getData[this.dataI + 9],getData[this.dataI + 10],getData[this.dataI + 11],getData[this.dataI + 12],getData[this.dataI + 13],getData[this.dataI + 14]);
                  if(worldObject.type == ObjectItem.otSoundObject)
                  {
                     worldObject.intVal1 = getData[this.dataI + 15];
                     worldObject.intVal2 = getData[this.dataI + 16];
                     worldObject.intVal3 = getData[this.dataI + 17];
                     worldObject.nextTime = getTimer() + int(Math.random() * ObjectItem.START_SOUND_PAUSE);
                     worldObject.bgRect = new Rectangle(0,0,0,0);
                     dataI += 18;
                  }
                  else
                  {
                     if(worldObject.rect.width == -1 || worldObject.type != ObjectItem.otNone)
                     {
                        worldObject.bgRect = new Rectangle(worldObject.j + int(getData[this.dataI + 16]),worldObject.i + int(getData[this.dataI + 15]),int(getData[this.dataI + 18]),int(getData[this.dataI + 17]));
                        dataJ = getData[this.dataI + 19];
                        dataI += 20;
                     }
                     else
                     {
                        dataJ = getData[this.dataI + 15];
                        dataI += 16;
                     }
                     worldObject.initState();
                     while(this.dataJ > 0)
                     {
                        if(getData[this.dataI] == WorldObject.HIDE_ADVERTIZE)
                        {
                           this.world.addObjAdvImage(getData[this.dataI + 1],getData[this.dataI + 2],getData[this.dataI + 3],getData[this.dataI + 4]);
                           dataI += 5;
                        }
                        else
                        {
                           this.world.addObjDecoImage(getData[this.dataI + 1],getData[this.dataI + 2],getData[this.dataI + 3],getData[this.dataI + 4],getData[this.dataI],getData[this.dataI + 5],getData[this.dataI + 6]);
                           dataI += 7;
                        }
                        --this.dataJ;
                     }
                  }
               }
               if(getData.length > 2)
               {
                  this.world.setUpSprite();
               }
               this.world.sortObj = true;
               return true;
            case "do":
               if(this.client.socket.gameIsStarted)
               {
                  fieldIndex = 1;
                  while(fieldIndex < getData.length - 1)
                  {
                     this.world.deleteObject(getData[fieldIndex]);
                     fieldIndex++;
                  }
                  this.world.sortObj = true;
               }
               return true;
            case "bs":
               this.world.playerSay(getData[1],getData[2],getData[3]);
               return true;
            case "ub":
               this.world.createBackground(true,getData[1],getData[2],getData[3],getData[4],getData[5],getData[6],getData[7],getData[8]);
               return true;
            case "sb":
               this.world.createBackground(false,getData[1],getData[2],getData[3],getData[4],getData[5],getData[6],getData[7],getData[8]);
               return true;
            case "md":
               this.world.playerMoveDir(getData);
               return true;
            case "cl":
               fieldIndex = 1;
               while(fieldIndex < getData.length - 1)
               {
                  ChatPanel.instance.doAction813(UserList.parse(getData,fieldIndex));
                  fieldIndex += 10;
               }
               return true;
            case "cu":
               ChatPanel.instance.doAction813(UserList.parse(getData,1));
               return true;
            case "cd":
               if(this.gameIsStarted)
               {
                  ChatPanel.instance.doAction116(getData.slice(1));
                  if(Terminal.instance.visible && Terminal.instance.terminalNumber == Terminal.CHANNEL_CLAN)
                  {
                     Terminal.instance.doAction387(getData.slice(1));
                  }
               }
               return true;
            case "dc":
               ChatPanel.instance.doAction116();
               Terminal.instance.deleteAll();
               return true;
            case "du":
               if(this.gameIsStarted)
               {
                  fieldIndex = fieldIndex;
                  while(fieldIndex < getData.length - 1)
                  {
                     this.world.deletePlayer(getData[fieldIndex]);
                     fieldIndex++;
                  }
                  ChatPanel.instance.doAction387(getData.slice(1));
               }
               return true;
            case "rn":
               this.world.runPlayer(getData[1]);
               return true;
            case "ue":
               this.world.useObject(getData[2]);
               return true;
            case "uo":
               this.world.startUsingObject(getData[1],getData[2],getData[3],getData[4]);
               return true;
            case "ms":
               this.world.stopPlayer(getData[1],getData[2],getData[3]);
               return true;
            case "pu":
               this.world.playerUse(getData[1],getData[2],getData[3]);
               return true;
            case "ut":
               this.world.playerUseTarget(getData[1],getData[2],getData[3],getData[4],getData[5]);
               return true;
            case "at":
               this.world.playerAttack(getData[1],getData[2],getData[3],getData[4],getData[5],getData[6],getData[7],getData[8]);
               return true;
            case "ht":
               this.world.hitPlayer(getData[1],getData[2],int(getData[3]));
               return true;
            case "dd":
               this.world.diePlayer(getData[1],getData[2]);
               return true;
            case "ah":
               this.world.addHp(getData[1],getData[2]);
               return true;
            case "zz":
               this.world.playerEffectIconShow(getData[1],getData[2]);
               return true;
            case "zh":
               this.world.playerEffectIconHide(getData[1],getData[2]);
               return true;
            case "hv":
               hintStr = Client.getString("IDS_HINT_" + getData[1]);
               if(getData.length > 2)
               {
                  hintStr = this.hintStr.replace("%s1",getData[2]);
               }
               if(getData.length > 3)
               {
                  hintStr = this.hintStr.replace("%s2",getData[3]);
               }
               if(getData.length > 4)
               {
                  hintStr = this.hintStr.replace("%s3",getData[4]);
               }
               this.client.showHint(0,Client.getString("IDS_HINT_HEADER"),this.hintStr);
               return true;
            case "vs":
               if(getData[1] == 0)
               {
                  NuclearChat.instance.battleStateOn = !NuclearChat.instance.battleStateOn;
               }
               else if(getData[1] == 1)
               {
                  ChatPanel.instance.baseOpenedValue = !ChatPanel.instance.baseOpenedValue;
               }
               else if(getData[1] == 2)
               {
                  NuclearChat.instance.baseOpenedValue = !NuclearChat.instance.baseOpenedValue;
               }
               return true;
         }
         return false;
      }
   }
}

