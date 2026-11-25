package social
{
   import core.resources.ResourceManager;
   import utils.JsonUtil;
   import com.adobe.crypto.MD5;
   import core.system.StateSystem;
   import core.system.TimerUtil;
   import core.system.EventListeners;
   import core.system.Signal;
   import com.junkbyte.console.Cc;
   import core.ui.Alert;
   import core.ui.UIElement;
   import ru.inspirit.net.MultipartURLLoader;
   import flash.display.BitmapData;
   import flash.display.Stage;
   import flash.display.StageDisplayState;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import mx.utils.ObjectUtil;
   
   public class SocialApi implements ISocialApi
   {
      
      public static var api:SocialApi;
      
      public static const WIN:String = "Win";
      
      public static const MAC:String = "Mac";
      
      public static const OTHER:String = "Other";
      
      public static const SOCIAL_API_CONST6:int = 65535;
      
      public static const SOCIAL_API_CONST5:int = 1;
      
      public static const SOCIAL_API_CONST1:int = 2;
      
      public static const SOCIAL_API_CONST2:int = 4;
      
      public static const SOCIAL_API_CONST8:int = 8;
      
      public static const SOCIAL_API_CONST9:int = 16;
      
      public static const SOCIAL_API_CONST4:int = 8192;
      
      private static const SOCIAL_API_CONST7:int = 30 * 1000;
      
      private static const SOCIAL_API_CONST3:int = 1 * 1000;
      
      private var serverUrl:String;
      
      protected var onFatalError:Function;
      
      protected var callback13:Function;
      
      private var str4:String;
      
      private var sessionKey:String;
      
      private var clientTime:Number = getTimer();
      
      private var numValue36:Number = getTimer();
      
      private var mainQueue:RequestQueue;
      
      private var nextGameEventId:Number = 1;
      
      private var onGameEventReceived:Function;
      
      private var timerUtil1:TimerUtil;
      
      private var outgoingGameEvents:Array = new Array();
      
      private var gameEventCallbacksById:Object = new Object();
      
      private var gameEventRequestInFlight:Boolean = false;
      
      private var flag11:Boolean = false;
      
      private var array34:Array;
      
      protected var imageLoader:ImageLoader;
      
      private var profilesLoader1:ProfilesLoader;
      
      private var iJsCaller1:IJsCaller = null;
      
      private var appFriendsSet:Dictionary = null;
      
      private var _defaultProfile:Object = {};
      
      private var stage:Stage;
      
      private var lastErrorReportTime:int = getTimer();
      
      private var jsCallbacksById:Object = {};
      
      private var nextJsCallbackId:Number = Math.round(Math.random() * 10000000);
      
      private var obj25:Object;
      
      private var obj5:Object;
      
      private var _realAppFriends:Array = null;
      
      private var osPrefix:String;
      
      private var deferredGameEvents:Array = new Array();
      
      private var gameEventPauseDepth:int = 0;
      
      private var urlDataByKey:Object = {};
      
      public function SocialApi(param1:Stage, param2:String, param3:Function = null, param4:Function = null, param5:Object = null)
      {
         var urlData:String;
         var pairs:Array;
         var pair:String;
         var parts:Array;
         this.saltFunc = this.onSalt;
         super();
         api = this;
         if(param3 == null)
         {
            param3 = this.doAction639;
         }
         if(param4 == null)
         {
            param4 = this.doAction639;
         }
         this.stage = param1;
         this.onFatalError = param3;
         this.callback13 = param4;
         this.str4 = param2;
         this.mainQueue = new RequestQueue(3,param3);
         this.mainQueue.api = this;
         this.imageLoader = new ImageLoader(5,500,param3,this);
         this.serverUrl = "";
         StateSystem.addListener(ConnectorEvents.CONNECTOR_SEND_EVENT,this.doAction293);
         this.osPrefix = Capabilities.os.substr(0,3);
         ExternalInterface.addCallback("getPaymentsHistory",this.getPaymentsHistory);
         if(param5)
         {
            urlData = decodeURIComponent(param5.urlData);
            if(urlData != null)
            {
               pairs = urlData.split("&");
               for each(pair in pairs)
               {
                  parts = pair.split("=");
                  this.urlDataByKey[parts[0]] = parts[1];
               }
            }
         }
      }
      
      public function get propValue117() : String
      {
         return this.osPrefix;
      }
      
      public function get isValue35() : Boolean
      {
         return true;
      }
      
      private function doAction293(param1:Signal, param2:Object, param3:Function = null) : void
      {
         this.doAction400(param2,param3);
      }
      
      protected function doAction94() : void
      {
         Security.allowDomain("*");
         ExternalInterface.addCallback("flashReceiver",this.doAction958);
      }
      
      private function doAction958(param1:Number, param2:Object) : void
      {
         var callback:Function = null;
         if(this.jsCallbacksById[param1])
         {
            callback = this.jsCallbacksById[param1];
            delete this.jsCallbacksById[param1];
            callback.call(null,param2);
         }
      }
      
      public function jsCall(param1:String, param2:Function, ... rest) : void
      {
         var callbackId:int = -1;
         if(param2 != null)
         {
            callbackId = this.nextJsCallbackId++;
            this.jsCallbacksById[callbackId] = param2;
         }
         rest.unshift(callbackId);
         rest.unshift(param1);
         ExternalInterface.call.apply(null,rest);
      }
      
      public function set propValue111(param1:ResourceManager) : void
      {
         this.imageLoader.setImageLoadErrorBitmap(param1.getBmp(UIElement.uiPackId,"NO_AVATAR"));
      }
      
      public var saltFunc:Function;

      private function onSalt(param1:String) : String
      {
         return param1.length.toString() + MD5.hash(param1 + "stufff...");
      }
      
      public function doAction117(func:Function) : void
      {
         var localSaltFunc:Function;
         localSaltFunc = function(param1:String):String
         {
            return oldSaltFunc(param1) + func(param1);
         };
         var oldSaltFunc:Function = this.saltFunc;
         saltFunc = localSaltFunc;
      }
      
      public function get info() : String
      {
         throw new Error();
      }
      
      public function get userId() : String
      {
         throw new Error();
      }
      
      public function get propValue17() : Object
      {
         return null;
      }
      
      public function get propValue125() : String
      {
         return null;
      }
      
      public function get userRef() : String
      {
         return null;
      }
      
      public function get propValue6() : String
      {
         throw new Error();
      }
      
      public function get propValue167() : String
      {
         throw new Error();
      }
      
      public function get propValue166() : String
      {
         return null;
      }
      
      public function doAction749(param1:Function) : void
      {
         throw new Error();
      }
      
      protected function doAction267(param1:Function) : void
      {
         throw new Error();
      }
      
      protected function getString13() : String
      {
         return null;
      }
      
      protected function doAction558(param1:Array, param2:Function) : void
      {
         throw new Error();
      }
      
      protected function doAction734(param1:Object, param2:Object) : void
      {
         throw new Error();
      }
      
      public function doAction786(param1:Function) : void
      {
         throw new Error();
      }
      
      public function doAction621(param1:Function, param2:String, param3:String = null, param4:Array = null, param5:String = null, param6:Object = null) : void
      {
      }
      
      public function doAction633(param1:BitmapData, param2:String, param3:String = null, param4:String = null, param5:Function = null, param6:String = null, param7:String = null, param8:Object = null, param9:Function = null) : void
      {
         throw new Error();
      }
      
      public function doAction655(param1:String, param2:BitmapData, param3:String, param4:String, param5:String, param6:Function, param7:Function = null) : void
      {
         throw new Error();
      }
      
      public function doAction170(param1:BitmapData, param2:String, param3:String, param4:Function, param5:String = "") : void
      {
         throw new Error();
      }
      
      public function doAction747(param1:Function = null, param2:Object = null) : void
      {
         throw new Error();
      }
      
      public function doAction962(param1:Function) : void
      {
         throw new Error();
      }
      
      public function doAction466(param1:Function) : void
      {
         throw new Error();
      }
      
      public function doAction792(param1:Function) : void
      {
         throw new Error();
      }
      
      public function doAction373(param1:int, param2:Function) : void
      {
         throw new Error();
      }
      
      public function get isValue53() : Boolean
      {
         return true;
      }
      
      public function doAction671(pack:String, name:String, description:String, image:String, onComplete:Function, params:Object = null) : void
      {
         var localComplete:Function;
         localComplete = function(param1:Object):void
         {
            if(param1.type == "payment")
            {
               Cc.log("payment event got");
               doAction255(param1,pack,name,description,image,onComplete,params);
            }
            else
            {
               if(onComplete != null)
               {
                  onComplete();
               }
               StateSystem.dispatch(ConnectorEvents.CONNECTOR_RECIVE_EVENT,param1);
               StateSystem.dispatch(ConnectorEvents.CONNECTOR_RECIVE_EVENT + param1.type,param1);
               onGameEventReceived(param1);
            }
         };
         this.doAction400({
            "type":"payment",
            "pack":pack,
            "extra":this.getString54(pack,name,description,image)
         },localComplete);
      }
      
      protected function getString54(param1:String, param2:String, param3:String, param4:String) : String
      {
         return null;
      }
      
      protected function doAction255(param1:Object, param2:String, param3:String, param4:String, param5:String, param6:Function, param7:Object = null) : void
      {
         throw new Error();
      }
      
      public function doAction99() : void
      {
         throw new Error();
      }
      
      public function doAction95(param1:Object) : void
      {
         throw new Error();
      }
      
      public function navigateToURL(param1:String, param2:String = "_blank") : void
      {
         flash.net.navigateToURL(new URLRequest(param1),param2);
      }
      
      public function doAction150(param1:String, param2:String = "_blank") : void
      {
         throw new Error();
      }
      
      public function reportError(msg:String = null, error:Error = null) : void
      {
         var now:int;
         var data:String;
         try
         {
            var removeListeners:Function = function():void
            {
               loader.removeEventListener(Event.COMPLETE,receivedData);
               loader.removeEventListener(IOErrorEvent.IO_ERROR,ioError);
            };
            var receivedData:Function = function(param1:Event):void
            {
               removeListeners();
            };
            var ioError:Function = function(param1:IOErrorEvent):void
            {
               removeListeners();
            };
            now = getTimer();
            if(now - this.lastErrorReportTime < 2000 && (error != null && error.getStackTrace() == null))
            {
               return;
            }
            lastErrorReportTime = now;
            data = "";
            if(msg != null && msg != "")
            {
               data += msg + " / ";
            }
            if(error != null)
            {
               data += error.toString() + " / " + error.getStackTrace();
            }
            else
            {
               data += "null";
            }
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE,receivedData);
            loader.addEventListener(IOErrorEvent.IO_ERROR,ioError);
            var request:URLRequest = new URLRequest(this.serverUrl + "/error");
            request.method = "POST";
            var vars:URLVariables = new URLVariables();
            vars["user"] = this.userId;
            vars["error"] = data;
            request.data = vars;
            loader.load(request);
         }
         catch(e:Error)
         {
         }
      }
      
      final public function get lang() : String
      {
         var languages:Array = [];
         languages = ["ru"];
         var language:String = this.getString13();
         if(language != null && languages.indexOf(language) != -1)
         {
            return language;
         }
         return "ru";
      }
      
      public function get propValue169() : String
      {
         return this.str4;
      }
      
      public function doAction233(onComplete:Function) : void
      {
         var localOnComplete:Function;
         localOnComplete = function(param1:Object):void
         {
            var friends:Array = getArray4(param1);
            var index:int;
            appFriendsSet = new Dictionary();
            index = 0;
            while(index < friends.length)
            {
               appFriendsSet[friends[index]] = true;
               index++;
            }
            onComplete(friends);
         };
         this.doAction267(localOnComplete);
         if(this.array34)
         {
         }
      }
      
      public function doAction791(onComplete:Function) : void
      {
         var localOnComplete:Function;
         localOnComplete = function(param1:Object):void
         {
            _realAppFriends = getArray4(param1);
            onComplete(param1);
         };
         this.doAction267(localOnComplete);
      }
      
      public function get propValue14() : Array
      {
         return this._realAppFriends;
      }
      
      protected function check55(param1:String) : Boolean
      {
         return !this._realAppFriends || this._realAppFriends.indexOf(param1) >= 0;
      }
      
      public function check6(param1:String) : Boolean
      {
         if(param1 == this.userId)
         {
            return true;
         }
         if(this.appFriendsSet == null)
         {
            return true;
         }
         var isFriend:Boolean = this.appFriendsSet[param1];
         return this.appFriendsSet[param1] == true;
      }
      
      public function getProfiles(uids:Array, onComplete:Function) : void
      {
         var socAnswer:Object;
         var ourAnswer:Object;
         var onSocProfilesReceived:Function;
         var onOurProfilesReceived:Function;
         onSocProfilesReceived = function(param1:Object):void
         {
            socAnswer = param1;
            if(socAnswer && ourAnswer)
            {
               onProfilesReceived();
            }
         };
         onOurProfilesReceived = function(param1:Object):void
         {
            ourAnswer = getArray4(param1.players);
            if(socAnswer && ourAnswer)
            {
               onProfilesReceived();
            }
         };
         var onProfilesReceived:Function = function():void
         {
            var socialProfiles:Object = socAnswer;
            var gameProfilesById:Array = new Array();
            var profiles:Array = new Array();
            var index:int;
            var property:String;
            var profileId:String;
            var profile:Object;
            var gameProfile:Object;
            var socialProfile:Object;
            index = 0;
            while(index < ourAnswer.length)
            {
               gameProfilesById[ourAnswer[index].id] = ourAnswer[index];
               index++;
            }
            index = 0;
            while(index < uids.length)
            {
               profileId = uids[index];
               profile = {};
               profile.uid = profileId;
               profile.id = profileId;
               for(property in _defaultProfile)
               {
                  profile[property] = _defaultProfile[property];
               }
               gameProfile = gameProfilesById[profileId];
               if(gameProfile != null)
               {
                  for(property in gameProfile)
                  {
                     if(property != "id")
                     {
                        profile[property] = gameProfile[property];
                     }
                  }
               }
               profile["neverPlay"] = gameProfile == null;
               if(profile.name != null && profile.name.length == 0)
               {
                  profile.name = null;
               }
               if(profile.short_name != null && profile.short_name.length == 0)
               {
                  profile.short_name = null;
               }
               if(profile.short_name == null && profile.name != null)
               {
                  profile.short_name = profile.name;
               }
               socialProfile = socialProfiles[profileId];
               if(socialProfile == null)
               {
                  socialProfile = {};
               }
               doAction734(profile,socialProfile);
               if(profile.name == null && profile.short_name == null)
               {
                  profile.name = "";
                  profile.short_name = "";
               }
               else if(profile.short_name == null)
               {
                  profile.short_name = profile.name;
               }
               else if(profile.name == null)
               {
                  profile.name = profile.short_name;
               }
               profiles.push(profile);
               index++;
            }
            onComplete(profiles);
         };
         socAnswer = null;
         ourAnswer = null;
         this.doAction558(uids,onSocProfilesReceived);
         this.doAction400({
            "type":"players",
            "action":"getInfo",
            "players":uids
         },onOurProfilesReceived);
      }
      
      public function doAction751(userId:String, handler:Function) : void
      {
         var onLocalComplete:Function;
         onLocalComplete = function(param1:Object):void
         {
            handler(param1.players[0]);
         };
         this.doAction400({
            "type":"players",
            "action":"getInfo",
            "players":[userId]
         },onLocalComplete);
      }
      
      public function doAction378(onComplete:Function, uid:String = null) : void
      {
         var localOnComplete:Function;
         localOnComplete = function(param1:Object):void
         {
            var socialProfile:Object = param1[uid];
            var profile:Object;
            if(socialProfile)
            {
               profile = {};
               doAction734(profile,socialProfile);
               if(profile.photo)
               {
                  loadImage(profile.photo,onComplete);
               }
            }
         };
         if(uid == null)
         {
            uid = this.userId;
         }
         this.doAction558([uid],localOnComplete);
      }
      
      public function startGame(param1:Function, param2:Function) : void
      {
         if(this.timerUtil1 != null)
         {
            this.onFatalError("game is already started");
         }
         this.onGameEventReceived = param2;
         var clientVersion:int = int("1481810850");
         this.doAction752({
            "type":"TIME",
            "clientVersion":clientVersion
         },param1,this.doAction577);
      }
      
      public function doAction547() : void
      {
         if(this.timerUtil1 != null)
         {
            this.timerUtil1.stop();
            this.timerUtil1.dispose();
            timerUtil1 = null;
         }
      }
      
      public function doAction861() : void
      {
         sessionKey = null;
      }
      
      public function sendPing() : void
      {
         this.doAction400({
            "type":"evt",
            "action":"ping"
         });
      }
      
      public function doAction400(param1:Object, param2:Function = null) : void
      {
         if(this.timerUtil1 == null)
         {
            return;
         }
         this.outgoingGameEvents.push(param1);
         if(param2 != null)
         {
            param1.id = this.nextGameEventId++;
            this.gameEventCallbacksById[param1.id] = param2;
         }
         if(!this.gameEventRequestInFlight)
         {
            this.doAction956();
         }
      }
      
      public function doAction676() : void
      {
         this.doAction752({"type":"RESET"},null,this.doAction112);
      }
      
      public function doAction434(param1:String, param2:Object, param3:Function = null) : void
      {
         this.mainQueue.request(this.serverUrl + "/" + param1,param2,param3,this.getString1);
      }
      
      public function doAction663(param1:String, param2:Object, param3:Function = null) : void
      {
         this.mainQueue.request(this.serverUrl + "/" + param1,param2,param3,this.getString1,null,null,true);
      }
      
      private function getString1(param1:Object, param2:Object) : String
      {
         return param2(param1);
      }
      
      private function doAction112(param1:Object, param2:Object) : void
      {
         this.onFatalError("reset game ok");
      }
      
      private function doAction577(param1:Object, param2:Object) : void
      {
         numValue36 = param1.time;
         var startRequest:Object = {
            "type":"START",
            "clientTime":getTimer(),
            "serverTime":param1.time,
            "lang":this.lang
         };
         if(this.propValue17)
         {
            startRequest["info"] = this.propValue17;
         }
         if(this.propValue125)
         {
            startRequest["ad"] = this.propValue125;
         }
         if(this.userRef)
         {
            startRequest["userRef"] = this.userRef;
         }
         this.doAction752(startRequest,param2,this.doAction453);
      }
      
      private function doAction453(param1:Object, param2:Object) : void
      {
         param2(param1,this.doAction712);
      }
      
      private function doAction712() : void
      {
         timerUtil1 = new TimerUtil(SOCIAL_API_CONST7);
         this.timerUtil1.handler = this.onHandler2;
         this.timerUtil1.start();
      }
      
      private function doAction36(param1:Object, param2:Object) : void
      {
         if(this.iJsCaller1 != null)
         {
            param1 = this.iJsCaller1.prepareText(param1);
         }
         flag11 = false;
         var pingOneReceived:Boolean = false;
         var unused:int = 0;
         var index:int;
         var handledIds:Array = new Array();
         var callback:Function;
         index = 0;
         while(index < param1.events.length)
         {
            if(param1.events[index].action == "ping1")
            {
               flag11 = true;
               pingOneReceived = true;
            }
            if(param1.events[index].action == "ping2")
            {
               flag11 = true;
            }
            else
            {
               callback = this.gameEventCallbacksById[param1.events[index].id];
               if(callback != null)
               {
                  callback(param1.events[index]);
                  handledIds.push(param1.events[index].id);
               }
               else if(this.gameEventPauseDepth > 0)
               {
                  this.deferredGameEvents.push(param1.events[index]);
               }
               else
               {
                  StateSystem.dispatch(ConnectorEvents.CONNECTOR_RECIVE_EVENT,param1.events[index]);
                  StateSystem.dispatch(ConnectorEvents.CONNECTOR_RECIVE_EVENT + param1.events[index].type,param1.events[index]);
                  this.onGameEventReceived(param1.events[index]);
               }
            }
            index++;
         }
         index = 0;
         while(index < handledIds.length)
         {
            if(this.gameEventCallbacksById[handledIds[index]])
            {
               delete this.gameEventCallbacksById[handledIds[index]];
            }
            index++;
         }
         gameEventRequestInFlight = false;
         if(pingOneReceived)
         {
            this.timerUtil1.delay = 1;
         }
         else if(this.flag11)
         {
            this.timerUtil1.delay = SOCIAL_API_CONST3;
         }
         else if(this.outgoingGameEvents.length > 0)
         {
            this.timerUtil1.delay = SOCIAL_API_CONST3;
         }
         else
         {
            this.timerUtil1.delay = SOCIAL_API_CONST7;
         }
         this.timerUtil1.start();
      }
      
      public function doAction881() : void
      {
         ++this.gameEventPauseDepth;
      }
      
      public function doAction525() : void
      {
         var event:Object = null;
         --this.gameEventPauseDepth;
         if(this.gameEventPauseDepth < 0)
         {
            throw new Error("should not happen");
         }
         if(this.gameEventPauseDepth == 0)
         {
            while(this.deferredGameEvents.length > 0)
            {
               event = this.deferredGameEvents.shift();
               StateSystem.dispatch(ConnectorEvents.CONNECTOR_RECIVE_EVENT,event);
               StateSystem.dispatch(ConnectorEvents.CONNECTOR_RECIVE_EVENT + event.type,event);
               this.onGameEventReceived(event);
            }
         }
      }
      
      private function doAction956() : void
      {
         gameEventRequestInFlight = true;
         this.timerUtil1.stop();
         this.doAction752({
            "type":"EVT",
            "events":this.outgoingGameEvents
         },null,this.doAction36);
         if(this.outgoingGameEvents.length > 0)
         {
            outgoingGameEvents = new Array();
         }
      }
      
      private function onHandler2(param1:TimerEvent) : void
      {
         this.doAction956();
      }
      
      private function doAction639(param1:String) : void
      {
         Alert.show("MSG: " + param1,"Fatal Error");
         this.doAction547();
      }
      
      private function doAction752(sendData:Object, evtData:Object, onComplete:Function) : void
      {
         var id:Number;
         var data:Object;
         try
         {
            var localOnComplete:Function = function(param1:String, param2:Object):String
            {
               var response:Object;
               var hasChecksum:Boolean = false;
               var separator:int = param1.indexOf("$");
               var receivedChecksum:String;
               var expectedChecksum:String;
               if(separator >= 0 && separator < 48)
               {
                  receivedChecksum = param1.substr(0,separator);
                  param1 = param1.substr(separator + 1);
                  expectedChecksum = MD5.hash(param1 + saltFunc(param1));
                  if(expectedChecksum != receivedChecksum)
                  {
                     return "retry:wrong checksum";
                  }
                  hasChecksum = true;
               }
               response = JsonUtil.doAction546(param1);
               if(!hasChecksum && (response == null || response.cmd != "REDIRECT" && response.cmd != "ERR"))
               {
                  return "retry:no checksum";
               }
               if(response == null)
               {
                  return "retry:no data decoded";
               }
               if(response.key != null)
               {
                  sessionKey = response.key;
               }
               if(response.cmd == null)
               {
                  return "retry:no cmd found";
               }
               if(response.cmd == "ERR")
               {
                  return "error:" + response.msg;
               }
               if(response.id != String(id))
               {
                  return "retry:wrong id";
               }
               if(response.redirect != null)
               {
                  serverUrl = response.redirect;
               }
               if(response.cmd == "REDIRECT")
               {
                  if(response.httpParams)
                  {
                     objData["httpParams"] = response.httpParams;
                     encodedData = JsonUtil.getString20(objData);
                     crc = MD5.hash(encodedData + saltFunc(encodedData));
                  }
                  mainQueue.request(serverUrl + "/go",{
                     "data":encodedData,
                     "crc":crc
                  },param2,localOnComplete);
                  return null;
               }
               if(onComplete != null)
               {
                  onComplete(response,param2);
               }
               return null;
            };
            var objData:Object;
            var encodedData:String;
            var crc:String;
            var localOnCompressedComplete:Function = function(param1:ByteArray, param2:Object):String
            {
               param1.uncompress();
               return localOnComplete(param1.readUTFBytes(param1.length),param2);
            };
            id = this.numValue36++;
            data = ObjectUtil.copy(sendData);
            data["id"] = id;
            data["user"] = this.userId;
            if(this.sessionKey != null)
            {
               var sig:String = this.sessionKey + id.toString() + this.propValue167;
               sig += this.saltFunc(sig);
               data["sig"] = MD5.hash(sig);
            }
            else
            {
               var auth:String = id.toString() + this.propValue167;
               auth += this.saltFunc(auth);
               data["auth"] = MD5.hash(auth);
               var key:String = this.propValue166;
               if(key)
               {
                  data["key"] = key;
               }
            }
            objData = data;
            encodedData = JsonUtil.getString20(objData);
            crc = MD5.hash(encodedData + this.saltFunc(encodedData));
            this.mainQueue.request(this.serverUrl + "/go",{
               "data":encodedData,
               "crc":crc,
               "gz":"y"
            },evtData,localOnCompressedComplete,null,null,true);
         }
         catch(e:Error)
         {
            reportError("Request error",e);
            onFatalError("Request error: " + e.getStackTrace());
         }
      }
      
      protected function getString6(param1:Object, param2:String) : String
      {
         return param1 == null ? param2 : String(param1);
      }
      
      public function doAction270(url:String, window:String = "_blank") : void
      {
         try
         {
            flash.net.navigateToURL(new URLRequest(url),window);
         }
         catch(e:Error)
         {
            ISocialApi(this).navigateToURL(url,window);
         }
      }
      
      public function doAction126(url:String, window:String = "_blank") : void
      {
         try
         {
            flash.net.navigateToURL(new URLRequest(this.serverUrl + url),window);
         }
         catch(e:Error)
         {
            ISocialApi(this).navigateToURL(serverUrl + url,window);
         }
      }
      
      public function loadImage(param1:String, param2:Function = null, param3:Object = null) : AvatarImage
      {
         return this.imageLoader.loadImage(param1,param2,param3);
      }
      
      public function doAction937(param1:Array, param2:Function) : void
      {
         if(this.profilesLoader1 == null)
         {
            ISocialApi(this).getProfiles(param1,param2);
         }
         else
         {
            this.profilesLoader1.getProfiles(param1,param2);
         }
      }
      
      public function doAction507(param1:String) : void
      {
         this.imageLoader.prioritizeImageLoad(param1);
      }
      
      public function set propValue79(param1:ProfilesLoader) : void
      {
         profilesLoader1 = param1;
         this.profilesLoader1.apiValue = ISocialApi(this);
      }
      
      public function get propValue79() : ProfilesLoader
      {
         return this.profilesLoader1;
      }
      
      public function set propValue50(param1:IJsCaller) : void
      {
         iJsCaller1 = param1;
      }
      
      public function get propValue50() : IJsCaller
      {
         return this.iJsCaller1;
      }
      
      public function set propValue151(param1:Object) : void
      {
         _defaultProfile = param1;
      }
      
      public function get propValue151() : Object
      {
         return this._defaultProfile;
      }
      
      protected function getArray4(param1:Object) : Array
      {
         if(param1 && param1 is Array)
         {
            return param1 as Array;
         }
         return new Array();
      }
      
      protected function getArray9(param1:Object) : Array
      {
         var items:Array = this.getArray4(param1);
         var strings:Array = new Array();
         var index:int;
         index = 0;
         while(index < items.length)
         {
            strings.push(String(items[index]));
            index++;
         }
         return strings;
      }
      
      protected function doAction697() : void
      {
         if(this.stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            this.stage.displayState = StageDisplayState.NORMAL;
         }
      }
      
      protected function doAction902(onComplete:Function, url:String, files:Array, params:Object, useDescription:Boolean = false) : void
      {
         var multipartLoader:MultipartURLLoader;
         var removeMultipartListeners:Function = function():void
         {
            EventListeners.removeEventListener(multipartLoader,Event.COMPLETE,receivedMultipartData);
            EventListeners.removeEventListener(multipartLoader,IOErrorEvent.IO_ERROR,multipartIoError);
         };
         var receivedMultipartData:Function;
         receivedMultipartData = function(param1:Event):void
         {
            removeMultipartListeners();
            if(onComplete != null)
            {
               onComplete(param1);
            }
         };
         var multipartIoError:Function;
         multipartIoError = function(param1:IOErrorEvent):void
         {
            removeMultipartListeners();
         };
         multipartLoader = new MultipartURLLoader();
         EventListeners.addEventListener(multipartLoader,Event.COMPLETE,receivedMultipartData);
         EventListeners.addEventListener(multipartLoader,IOErrorEvent.IO_ERROR,multipartIoError);
         var i:int = 0;
         while(i < files.length)
         {
            if(useDescription)
            {
               var j:int = 0;
               while(j < files[i].variables.length)
               {
                  multipartLoader.addVariable(files[i].variables[j].name,files[i].variables[j].value);
                  j++;
               }
            }
            multipartLoader.addFile(files[i].data,files[i].fileName,files[i].dataField);
            i++;
         }
         var nq:Boolean = true;
         var key:String;
         for(key in params)
         {
            if(nq)
            {
               url += "?";
               nq = false;
            }
            else
            {
               url += "&";
            }
            url += key + "=" + params[key].toString();
         }
         multipartLoader.load(url);
      }
      
      public function set propValue133(param1:Array) : void
      {
         array34 = param1;
      }
      
      public function get propValue133() : Array
      {
         return this.array34;
      }
      
      public function doAction29(param1:Function) : void
      {
         throw new Error();
      }
      
      public function doAction152(param1:Function) : void
      {
      }
      
      public function get propValue83() : Object
      {
         return this.obj25;
      }
      
      public function get propValue19() : Object
      {
         return this.obj5;
      }
      
      public function set propValue83(param1:Object) : void
      {
         obj25 = param1;
      }
      
      public function set propValue19(param1:Object) : void
      {
         obj5 = param1;
      }
      
      public function get propValue145() : String
      {
         return "";
      }
      
      public function get propValue134() : String
      {
         return this.propValue145 + "icons/";
      }
      
      public function getString42(param1:String) : String
      {
         return "icons/" + param1;
      }
      
      public function get propValue184() : Number
      {
         return getTimer() - this.clientTime;
      }
      
      public function get propValue54() : Number
      {
         return this.propValue184 + this.numValue36;
      }
      
      public function timeToServerTime(param1:Number) : Number
      {
         return param1 - this.clientTime + this.numValue36;
      }
      
      public function getNumber4(param1:Number) : Number
      {
         return param1 - this.numValue36 + this.clientTime;
      }
      
      public function get propValue153() : String
      {
         return "";
      }
      
      public function get propValue58() : Object
      {
         return {};
      }
      
      public function get isValue62() : Boolean
      {
         return false;
      }
      
      public function get isValue10() : Boolean
      {
         return true;
      }
      
      public function pause() : void
      {
         this.mainQueue.pause();
      }
      
      public function doAction57() : void
      {
         this.mainQueue.doAction57();
      }
      
      public function getPaymentsHistory() : void
      {
         var parsePaymentsData:Function = function(param1:Array):Array
         {
            var index:int = 0;
            while(index < param1.length)
            {
               if(param1[index].date)
               {
                  param1[index].date = timeToServerTime(param1[index].date);
               }
               index++;
            }
            return param1;
         };
         var localOnComplete:Function;
         localOnComplete = function(param1:Object):void
         {
            jsCall("getPaymentsHistory",null,parsePaymentsData(param1.payments));
         };
         this.doAction400({"type":"payments"},localOnComplete);
      }
      
      public function doAction755(param1:int, param2:Function) : void
      {
      }
      
      public function doAction787(param1:int, param2:Function) : void
      {
      }
      
      public function doAction399(param1:Function) : void
      {
      }
      
      public function doAction724() : void
      {
      }
      
      public function getString43(param1:String) : String
      {
         return "";
      }
      
      public function get propValue61() : Object
      {
         return this.urlDataByKey;
      }
      
      public function doAction10(param1:String, param2:String) : void
      {
      }
   }
}

