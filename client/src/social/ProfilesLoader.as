package social
{
   import core.system.TimerUtil;
   import flash.utils.clearInterval;
   
   public class ProfilesLoader
   {
      
      protected var api:ISocialApi;
      
      protected var profilesByUid:Object = {};
      
      private var request:Object = null;
      
      private var pendingRequests:Array = new Array();
      
      private var profileBatchIntervalId:int = -1;
      
      private var completedProfileRequests:Array = new Array();
      
      private var profileCallbackIntervalId:int = -1;
      
      private const maxUidsPerProfileBatch:int = 100;
      
      public function ProfilesLoader()
      {
         super();
      }
      
      protected function doAction829(param1:Object) : void
      {
         this.profilesByUid[param1.uid] = param1;
      }
      
      public function set apiValue(param1:ISocialApi) : void
      {
         this.api = param1;
      }
      
      public function get apiValue() : ISocialApi
      {
         return this.api;
      }
      
      private function doAction476() : void
      {
         var request:Object = null;
         var profiles:Array = null;
         var index:int = 0;
         var profile:Object = null;
         clearInterval(this.profileCallbackIntervalId);
         profileCallbackIntervalId = -1;
         while(this.completedProfileRequests.length > 0)
         {
            request = this.completedProfileRequests.shift();
            profiles = new Array();
            index = 0;
            while(index < request.uids.length)
            {
               profile = this.profilesByUid[request.uids[index]];
               if(profile != null)
               {
                  profiles.push(profile);
               }
               index++;
            }
            request.onComplete(profiles);
         }
         this.doAction728();
      }
      
      private function doAction728() : void
      {
         if(this.completedProfileRequests.length > 0 && this.profileCallbackIntervalId < 0)
         {
            profileCallbackIntervalId = TimerUtil.setInterval(this.doAction476,1);
         }
      }
      
      private function doAction551() : void
      {
         clearInterval(this.profileBatchIntervalId);
         profileBatchIntervalId = -1;
         if(this.request == null && this.pendingRequests.length > 0)
         {
            request = this.pendingRequests.shift();
            this.api.getProfiles(this.request.uids,this.doAction609);
         }
      }
      
      private function doAction588() : void
      {
         if(this.request == null && this.pendingRequests.length > 0 && this.profileBatchIntervalId < 0)
         {
            profileBatchIntervalId = TimerUtil.setInterval(this.doAction551,1);
         }
      }
      
      private function doAction609(param1:Array) : void
      {
         var index:int = 0;
         index = 0;
         while(index < param1.length)
         {
            this.doAction829(param1[index]);
            index++;
         }
         completedProfileRequests = this.completedProfileRequests.concat(this.request.reqs);
         request = null;
         this.doAction728();
         this.doAction588();
      }
      
      public function getProfiles(param1:Array, param2:Function) : void
      {
         var missingUids:Array = this.getArray2(param1,this.profilesByUid);
         var requestIndex:int;
         var batchSize:int;
         if(missingUids.length == 0)
         {
            this.completedProfileRequests.push({
               "uids":param1,
               "onComplete":param2
            });
            this.doAction728();
            return;
         }
         if(this.request != null)
         {
            missingUids = this.getArray13(missingUids,this.request.uids);
            if(missingUids.length == 0)
            {
               this.request.reqs.push({
                  "uids":param1,
                  "onComplete":param2
               });
               return;
            }
         }
         requestIndex = 0;
         while(requestIndex < this.pendingRequests.length)
         {
            missingUids = this.getArray13(missingUids,this.pendingRequests[requestIndex].uids);
            if(missingUids.length == 0)
            {
               this.pendingRequests[requestIndex].reqs.push({
                  "uids":param1,
                  "onComplete":param2
               });
               return;
            }
            requestIndex++;
         }
         if(this.pendingRequests.length == 0)
         {
            this.pendingRequests.push({
               "uids":[],
               "reqs":[]
            });
         }
         requestIndex = this.pendingRequests.length - 1;
         while(missingUids.length > 0)
         {
            batchSize = Math.min(this.maxUidsPerProfileBatch - this.pendingRequests[requestIndex].uids.length,missingUids.length);
            this.pendingRequests[requestIndex].uids = this.pendingRequests[requestIndex].uids.concat(missingUids.splice(0,batchSize));
            if(missingUids.length > 0)
            {
               this.pendingRequests.push({
                  "uids":[],
                  "reqs":[]
               });
               requestIndex++;
            }
         }
         this.pendingRequests[requestIndex].reqs.push({
            "uids":param1,
            "onComplete":param2
         });
         this.doAction588();
      }
      
      protected function getArray2(param1:Array, param2:Object) : Array
      {
         var missing:Array = new Array();
         var index:int;
         index = 0;
         while(index < param1.length)
         {
            if(param2[param1[index]] == null)
            {
               missing.push(param1[index]);
            }
            index++;
         }
         return missing;
      }
      
      protected function getArray13(param1:Array, param2:Array) : Array
      {
         var remaining:Array = new Array();
         var index:int;
         index = 0;
         while(index < param1.length)
         {
            if(param2.indexOf(param1[index]) < 0)
            {
               remaining.push(param1[index]);
            }
            index++;
         }
         return remaining;
      }
   }
}

