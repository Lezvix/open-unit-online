package ru.inspirit.net
{
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestHeader;
   import flash.net.URLRequestMethod;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   
   public class MultipartURLLoader extends EventDispatcher
   {
      
      public static var uintValue8:uint = 64 * 1024;
      
      private var fontUrlLoader:URLLoader;
      
      private var str12:String;
      
      private var array5:Array;
      
      private var array108:Array;
      
      private var dict1:Dictionary;
      
      private var dict7:Dictionary;
      
      private var flag55:Boolean = false;
      
      private var str36:String;
      
      private var _data:ByteArray;
      
      private var flag41:Boolean = false;
      
      private var numValue42:Number;
      
      private var uintValue3:uint = 0;
      
      private var uintValue13:uint = 0;
      
      private var uintValue20:uint = 0;
      
      public var requestHeaders:Array;
      
      public function MultipartURLLoader()
      {
         super();
         this.array108 = new Array();
         this.dict7 = new Dictionary();
         this.array5 = new Array();
         this.dict1 = new Dictionary();
         this.fontUrlLoader = new URLLoader();
         this.requestHeaders = new Array();
      }
      
      public function load(param1:String, param2:Boolean = false) : void
      {
         if(param1 == null || param1 == "")
         {
            throw new IllegalOperationError("You cant load without specifing PATH");
         }
         str36 = param1;
         flag55 = param2;
         if(this.flag55)
         {
            if(!this.flag41)
            {
               this.doAction748();
            }
            else
            {
               this.doAction326();
            }
         }
         else
         {
            _data = this.getByteArray1();
            this.doAction326();
         }
      }
      
      public function doAction81() : void
      {
         if(this.str36 == null || this.str36 == "" || this.flag55 == false)
         {
            throw new IllegalOperationError("You can use this method only if loading asynchronous.");
         }
         if(!this.flag41 && this.flag55)
         {
            throw new IllegalOperationError("You should prepare data before sending when using asynchronous.");
         }
         this.doAction326();
      }
      
      public function doAction319() : void
      {
         this.doAction748();
      }
      
      public function close() : void
      {
         try
         {
            this.fontUrlLoader.close();
         }
         catch(e:Error)
         {
         }
      }
      
      public function addVariable(param1:String, param2:Object = "") : void
      {
         if(this.array5.indexOf(param1) == -1)
         {
            this.array5.push(param1);
         }
         this.dict1[param1] = param2;
         flag41 = false;
      }
      
      public function addFile(param1:ByteArray, param2:String, param3:String = "Filedata", param4:String = "application/octet-stream") : void
      {
         var filePart:FilePart = null;
         if(this.array108.indexOf(param2) == -1)
         {
            this.array108.push(param2);
            this.dict7[param2] = new FilePart(param1,param2,param3,param4);
            uintValue13 += param1.length;
         }
         else
         {
            filePart = this.dict7[param2] as FilePart;
            uintValue13 -= filePart.fileContent.length;
            filePart.fileContent = param1;
            filePart.fileName = param2;
            filePart.dataField = param3;
            filePart.contentType = param4;
            uintValue13 += param1.length;
         }
         flag41 = false;
      }
      
      public function doAction178() : void
      {
         array5 = new Array();
         dict1 = new Dictionary();
         flag41 = false;
      }
      
      public function doAction63() : void
      {
         var fileKey:String = null;
         for each(fileKey in this.array108)
         {
            (this.dict7[fileKey] as FilePart).dispose();
         }
         array108 = new Array();
         dict7 = new Dictionary();
         uintValue13 = 0;
         flag41 = false;
      }
      
      public function dispose() : void
      {
         clearInterval(this.numValue42);
         this.removeListener();
         this.close();
         fontUrlLoader = null;
         str12 = null;
         array5 = null;
         dict1 = null;
         array108 = null;
         dict7 = null;
         requestHeaders = null;
         _data = null;
      }
      
      public function getString19() : String
      {
         var index:int = 0;
         if(this.str12 == null)
         {
            str12 = "";
            index = 0;
            while(index < 32)
            {
               str12 += String.fromCharCode(int(97 + Math.random() * 25));
               index++;
            }
         }
         return this.str12;
      }
      
      public function get isValue69() : Boolean
      {
         return this.flag55;
      }
      
      public function get isValue36() : Boolean
      {
         return this.flag41;
      }
      
      public function get dataFormat() : String
      {
         return this.fontUrlLoader.dataFormat;
      }
      
      public function set dataFormat(param1:String) : void
      {
         if(param1 != URLLoaderDataFormat.BINARY && param1 != URLLoaderDataFormat.TEXT && param1 != URLLoaderDataFormat.VARIABLES)
         {
            throw new IllegalOperationError("Illegal URLLoader Data Format");
         }
         this.fontUrlLoader.dataFormat = param1;
      }
      
      public function get loader() : URLLoader
      {
         return this.fontUrlLoader;
      }
      
      private function doAction326() : void
      {
         var request:URLRequest = new URLRequest();
         request.url = this.str36;
         request.method = URLRequestMethod.POST;
         request.data = this._data;
         request.requestHeaders.push(new URLRequestHeader("Content-type","multipart/form-data; boundary=" + this.getString19()));
         if(this.requestHeaders.length)
         {
            request.requestHeaders = request.requestHeaders.concat(this.requestHeaders);
         }
         this.addListener();
         this.fontUrlLoader.load(request);
      }
      
      private function doAction748() : void
      {
         clearInterval(this.numValue42);
         _data = new ByteArray();
         this._data.endian = Endian.BIG_ENDIAN;
         _data = this.getByteArray9(this._data);
         uintValue3 = 0;
         uintValue20 = 0;
         flag41 = false;
         if(this.array108.length)
         {
            this.doAction670();
         }
         else
         {
            _data = this.getByteArray7(this._data);
            flag41 = true;
            dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_COMPLETE));
         }
      }
      
      private function getByteArray1() : ByteArray
      {
         var body:ByteArray = new ByteArray();
         body.endian = Endian.BIG_ENDIAN;
         body = this.getByteArray9(body);
         body = this.getByteArray11(body);
         body = this.getByteArray7(body);
         return body;
      }
      
      private function getByteArray7(param1:ByteArray) : ByteArray
      {
         param1 = this.getByteArray2(param1);
         param1 = this.getByteArray5(param1);
         return param1;
      }
      
      private function getByteArray9(param1:ByteArray) : ByteArray
      {
         var charIndex:uint = 0;
         var headerLine:String = null;
         var variableName:String = null;
         for each(variableName in this.array5)
         {
            param1 = this.getByteArray2(param1);
            param1 = this.getByteArray10(param1);
            headerLine = "Content-Disposition: form-data; name=\"" + variableName + "\"";
            charIndex = 0;
            while(charIndex < headerLine.length)
            {
               param1.writeByte(headerLine.charCodeAt(charIndex));
               charIndex++;
            }
            param1 = this.getByteArray10(param1);
            param1 = this.getByteArray10(param1);
            param1.writeUTFBytes(this.dict1[variableName]);
            param1 = this.getByteArray10(param1);
         }
         return param1;
      }
      
      private function getByteArray11(param1:ByteArray) : ByteArray
      {
         var fileIndex:uint = 0;
         var unusedString:String = null;
         var fileKey:String = null;
         if(this.array108.length)
         {
            for each(fileKey in this.array108)
            {
               param1 = this.getByteArray4(param1,this.dict7[fileKey] as FilePart);
               param1 = this.getByteArray6(param1,this.dict7[fileKey] as FilePart);
               if(fileIndex != this.array108.length - 1)
               {
                  param1 = this.getByteArray10(param1);
               }
               fileIndex++;
            }
            param1 = this.getByteArray8(param1);
         }
         return param1;
      }
      
      private function getByteArray8(param1:ByteArray) : ByteArray
      {
         var charIndex:uint = 0;
         var partText:String = null;
         param1 = this.getByteArray10(param1);
         param1 = this.getByteArray2(param1);
         param1 = this.getByteArray10(param1);
         partText = "Content-Disposition: form-data; name=\"Upload\"";
         charIndex = 0;
         while(charIndex < partText.length)
         {
            param1.writeByte(partText.charCodeAt(charIndex));
            charIndex++;
         }
         param1 = this.getByteArray10(param1);
         param1 = this.getByteArray10(param1);
         partText = "Submit Query";
         charIndex = 0;
         while(charIndex < partText.length)
         {
            param1.writeByte(partText.charCodeAt(charIndex));
            charIndex++;
         }
         param1 = this.getByteArray10(param1);
         return param1;
      }
      
      private function getByteArray4(param1:ByteArray, param2:FilePart) : ByteArray
      {
         var charIndex:uint = 0;
         var headerLine:String = null;
         param1 = this.getByteArray2(param1);
         param1 = this.getByteArray10(param1);
         headerLine = "Content-Disposition: form-data; name=\"Filename\"";
         charIndex = 0;
         while(charIndex < headerLine.length)
         {
            param1.writeByte(headerLine.charCodeAt(charIndex));
            charIndex++;
         }
         param1 = this.getByteArray10(param1);
         param1 = this.getByteArray10(param1);
         param1.writeUTFBytes(param2.fileName);
         param1 = this.getByteArray10(param1);
         param1 = this.getByteArray2(param1);
         param1 = this.getByteArray10(param1);
         headerLine = "Content-Disposition: form-data; name=\"" + param2.dataField + "\"; filename=\"";
         charIndex = 0;
         while(charIndex < headerLine.length)
         {
            param1.writeByte(headerLine.charCodeAt(charIndex));
            charIndex++;
         }
         param1.writeUTFBytes(param2.fileName);
         param1 = this.getByteArray3(param1);
         param1 = this.getByteArray10(param1);
         headerLine = "Content-Type: " + param2.contentType;
         charIndex = 0;
         while(charIndex < headerLine.length)
         {
            param1.writeByte(headerLine.charCodeAt(charIndex));
            charIndex++;
         }
         param1 = this.getByteArray10(param1);
         param1 = this.getByteArray10(param1);
         return param1;
      }
      
      private function getByteArray6(param1:ByteArray, param2:FilePart) : ByteArray
      {
         param1.writeBytes(param2.fileContent,0,param2.fileContent.length);
         return param1;
      }
      
      private function onFontUrlLoaderProgress(param1:ProgressEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function onComplete(param1:Event) : void
      {
         this.removeListener();
         dispatchEvent(param1);
      }
      
      private function onFontUrlLoaderIoError(param1:IOErrorEvent) : void
      {
         this.removeListener();
         dispatchEvent(param1);
      }
      
      private function onFontUrlLoaderSecurityError(param1:SecurityErrorEvent) : void
      {
         this.removeListener();
         dispatchEvent(param1);
      }
      
      private function onFontUrlLoaderHttpStatus(param1:HTTPStatusEvent) : void
      {
         dispatchEvent(param1);
      }
      
      private function addListener() : void
      {
         this.fontUrlLoader.addEventListener(Event.COMPLETE,this.onComplete,false,0,false);
         this.fontUrlLoader.addEventListener(ProgressEvent.PROGRESS,this.onFontUrlLoaderProgress,false,0,false);
         this.fontUrlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onFontUrlLoaderIoError,false,0,false);
         this.fontUrlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.onFontUrlLoaderHttpStatus,false,0,false);
         this.fontUrlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFontUrlLoaderSecurityError,false,0,false);
      }
      
      private function removeListener() : void
      {
         this.fontUrlLoader.removeEventListener(Event.COMPLETE,this.onComplete);
         this.fontUrlLoader.removeEventListener(ProgressEvent.PROGRESS,this.onFontUrlLoaderProgress);
         this.fontUrlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onFontUrlLoaderIoError);
         this.fontUrlLoader.removeEventListener(HTTPStatusEvent.HTTP_STATUS,this.onFontUrlLoaderHttpStatus);
         this.fontUrlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onFontUrlLoaderSecurityError);
      }
      
      private function getByteArray2(param1:ByteArray) : ByteArray
      {
         var boundaryLength:int = this.getString19().length;
         param1 = this.getByteArray5(param1);
         var charIndex:int = 0;
         while(charIndex < boundaryLength)
         {
            param1.writeByte(this.str12.charCodeAt(charIndex));
            charIndex++;
         }
         return param1;
      }
      
      private function getByteArray10(param1:ByteArray) : ByteArray
      {
         param1.writeShort(3338);
         return param1;
      }
      
      private function getByteArray3(param1:ByteArray) : ByteArray
      {
         param1.writeByte(34);
         return param1;
      }
      
      private function getByteArray5(param1:ByteArray) : ByteArray
      {
         param1.writeShort(11565);
         return param1;
      }
      
      private function doAction670() : void
      {
         var filePart:FilePart = null;
         if(this.uintValue3 < this.array108.length)
         {
            filePart = this.dict7[this.array108[this.uintValue3]] as FilePart;
            _data = this.getByteArray4(this._data,filePart);
            numValue42 = setTimeout(this.doAction472,10,this._data,filePart.fileContent,0);
            ++this.uintValue3;
         }
         else
         {
            _data = this.getByteArray8(this._data);
            _data = this.getByteArray7(this._data);
            flag41 = true;
            dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_PROGRESS,this.uintValue13,this.uintValue13));
            dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_COMPLETE));
         }
      }
      
      private function doAction472(param1:ByteArray, param2:ByteArray, param3:uint = 0) : void
      {
         var chunkSize:uint = Math.min(uintValue8,param2.length - param3);
         param1.writeBytes(param2,param3,chunkSize);
         if(chunkSize < uintValue8 || param3 + chunkSize >= param2.length)
         {
            param1 = this.getByteArray10(param1);
            this.doAction670();
            return;
         }
         param3 += chunkSize;
         uintValue20 += chunkSize;
         if(this.uintValue20 % uintValue8 * 2 == 0)
         {
            dispatchEvent(new MultipartURLLoaderEvent(MultipartURLLoaderEvent.DATA_PREPARE_PROGRESS,this.uintValue20,this.uintValue13));
         }
         numValue42 = setTimeout(this.doAction472,10,param1,param2,param3);
      }
   }
}

import flash.utils.ByteArray;

class FilePart
{
   
   public var fileContent:ByteArray;
   
   public var fileName:String;
   
   public var dataField:String;
   
   public var contentType:String;
   
   public function FilePart(param1:ByteArray, param2:String, param3:String = "Filedata", param4:String = "application/octet-stream")
   {
      super();
      this.fileContent = param1;
      this.fileName = param2;
      this.dataField = param3;
      this.contentType = param4;
   }
   
   public function dispose() : void
   {
      fileContent = null;
      fileName = null;
      dataField = null;
      contentType = null;
   }
}
