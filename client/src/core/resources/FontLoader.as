package core.resources
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.Font;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class FontLoader extends EventDispatcher
   {
      
      private static const fontSwfHeaderBytes:ByteArray = new ByteArray();
      
      private static const fontClassTemplateBytes:ByteArray = new ByteArray();
      
      private static const FONT:String = "Font$";
      
      private static const FONT_LOADER_CONST1:uint = 72 << 6 | 0x3F;
      
      private static const FONT_LOADER_CONST2:uint = 76 << 6 | 0x3F;
      
      private static var fontTemplatesInitialized:Boolean = false;
      
      private const fontUrlLoader:URLLoader = new URLLoader();
      
      private var bytes1:ByteArray;
      
      private var swfLoader:Loader;
      
      private var fontClassCount:uint;
      
      private var embeddedFontMovieCount:uint;
      
      private var registerLoadedFonts:Boolean = true;
      
      public function FontLoader(param1:URLRequest = null, param2:Boolean = true)
      {
         super();
         FontLoader.init();
         this.fontUrlLoader.dataFormat = URLLoaderDataFormat.BINARY;
         this.fontUrlLoader.addEventListener(Event.COMPLETE,this.onFontUrlLoaderComplete);
         this.fontUrlLoader.addEventListener(Event.OPEN,super.dispatchEvent);
         this.fontUrlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS,super.dispatchEvent);
         this.fontUrlLoader.addEventListener(IOErrorEvent.IO_ERROR,super.dispatchEvent);
         this.fontUrlLoader.addEventListener(ProgressEvent.PROGRESS,super.dispatchEvent);
         this.fontUrlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,super.dispatchEvent);
         if(param1)
         {
            this.load(param1,param2);
         }
      }
      
      private static function init() : void
      {
         if(FontLoader.fontTemplatesInitialized)
         {
            return;
         }
         var templateBytes:SWFByteArray = new SWFByteArray();
         templateBytes.writeBytesFromString("7800055F00000FA000000C01004411080000004302FFFFFFBF150B0000000100466F6E744C69620000" + "BF1461020000010000000010002E00000000191272752E657463732E7574696C733A466F6E7400432F" + "55736572732F6574632F4465736B746F702F50726F6A656374732F466F6E744C6F616465724C69622F" + "7372633B72752F657463732F7574696C733B466F6E742E61731772752E657463732E7574696C733A46" + "6F6E742F466F6E74175B4F626A65637420466F6E7420666F6E744E616D653D2208666F6E744E616D65" + "0D2220666F6E745374796C653D2209666F6E745374796C650C2220666F6E74547970653D2208666F6E" + "745479706502225D1B72752E657463732E7574696C733A466F6E742F746F537472696E670653747269" + "6E6708746F537472696E67175F5F676F5F746F5F646566696E6974696F6E5F68656C700466696C6543" + "2F55736572732F6574632F4465736B746F702F50726F6A656374732F466F6E744C6F616465724C6962" + "2F7372632F72752F657463732F7574696C732F466F6E742E617303706F73033636380D72752E657463" + "732E7574696C7304466F6E740A666C6173682E74657874064F626A6563740335373006050116021614" + "161618010201030A07020607020807020A07020D07020E070315070415091501070217040000020000" + "00040000040C0000000200020F02101211130F02101211180106070905000101054100020100000001" + "030106440000010104000101040503D03047000001010105060EF103F018D030F019D04900F01A4700" + "00020201050620F103F01CD0302C05F01DD00401A02C07A0D00402A02C09A0D00403A02C0BA0480000" + "030201010421D030F103F0165D085D096609305D076607305D07660758001D1D6806F103F00B470000");
         templateBytes.position = 0;
         templateBytes.readBytes(FontLoader.fontSwfHeaderBytes);
         templateBytes.length = 0;
         templateBytes.writeBytesFromString("392F55736572732F6574632F4465736B746F702F50726F6A656374732F466F6E744C6F616465724C69" + "622F7372633B3B466F6E743030302E61730568656C6C6F2B48656C6C6F2C20776F726C642120497320" + "616E79626F647920686572653F2057686F27732074686572653F0F466F6E743030302F466F6E743030" + "300D72752E657463732E7574696C7304466F6E74064F626A6563740A666C6173682E74657874175F5F" + "676F5F746F5F646566696E6974696F6E5F68656C700466696C65382F55736572732F6574632F446573" + "6B746F702F50726F6A656374732F466F6E744C6F616465724C69622F7372632F466F6E743030302E61" + "7303706F73023534060501160216071801160A00050702010703080702090705080300000200000006" + "0000000200010B020C0E0D0F0101020904000100000001020101440100010003000101050603D03047" + "0000010102060719F103F006D030EF01040008F007D049002C05F00885D5F009470000020201010527" + "D030F103F00465005D036603305D046604305D026602305D02660258001D1D1D6801F103F002470000");
         templateBytes.position = 0;
         templateBytes.readBytes(FontLoader.fontClassTemplateBytes);
         templateBytes.length = 0;
         FontLoader.fontTemplatesInitialized = true;
      }
      
      public function set isValue54(param1:Boolean) : void
      {
         if(this.registerLoadedFonts == param1)
         {
            return;
         }
         this.registerLoadedFonts = param1;
         if(param1)
         {
            this.doAction643();
         }
      }
      
      public function get isValue54() : Boolean
      {
         return this.registerLoadedFonts;
      }
      
      public function get bytesLoaded() : uint
      {
         return this.fontUrlLoader.bytesLoaded;
      }
      
      public function get bytesTotal() : uint
      {
         return this.fontUrlLoader.bytesTotal;
      }
      
      private const _loadedFonts:Array = new Array();

      public function get propValue4() : Array
      {
         return this._loadedFonts.concat();
      }
      
      public function load(param1:URLRequest, param2:Boolean = true) : void
      {
         this.close();
         this._loadedFonts.length = 0;
         this.fontClassCount = 0;
         this.registerLoadedFonts = param2;
         this.fontUrlLoader.load(param1);
      }
      
      public function loadBytes(param1:ByteArray, param2:Boolean = true) : void
      {
         this.close();
         this._loadedFonts.length = 0;
         this.fontClassCount = 0;
         this.registerLoadedFonts = param2;
         this.doAction607(param1,true);
      }
      
      public function close() : void
      {
         try
         {
            this.fontUrlLoader.close();
         }
         catch(error:Error)
         {
         }
         if(this.swfLoader)
         {
            this.swfLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onContentLoaderInfoComplete2);
            try
            {
               this.swfLoader.close();
            }
            catch(error:Error)
            {
            }
            try
            {
               this.swfLoader.unload();
            }
            catch(error:Error)
            {
            }
            this.swfLoader = null;
         }
      }
      
      public function doAction643() : void
      {
         var font:Font = null;
         for each(font in this._loadedFonts)
         {
            Font.registerFont((font as Object).constructor);
         }
      }
      
      private function doAction607(bytes:ByteArray, delayed:Boolean = false) : void
      {
         var o:Object;
         var stringID:String;
         var id:uint;
         var tempData:ByteArray;
         var fontSWF:ByteArray;
         var context:LoaderContext;
         var data:ByteArray;
         try
         {
            data = new SWFByteArray(bytes);
         }
         catch(error:Error)
         {
            if(delayed)
            {
               this.swfLoader = new Loader();
               this.swfLoader.addEventListener(Event.ENTER_FRAME,this.onSwfLoaderEnterFrame);
            }
            else
            {
               this.close();
               super.dispatchEvent(new IOErrorEvent(IOErrorEvent.VERIFY_ERROR));
            }
            return;
         }
         var fontData:Object = new Object();
         var classCodeLength:uint = FontLoader.fontClassTemplateBytes.length;
         this.embeddedFontMovieCount = 0;
         this.doAction284(data,fontData);
         tempData = new ByteArray();
         tempData.endian = Endian.LITTLE_ENDIAN;
         tempData.writeBytes(FontLoader.fontSwfHeaderBytes);
         id = 0;
         for(o in fontData)
         {
            data = fontData[o] as ByteArray;
            if(data)
            {
               stringID = id.toString();
               while(stringID.length < 3)
               {
                  stringID = "0" + stringID;
               }
               stringID = FontLoader.FONT + stringID;
               tempData.writeShort(FontLoader.FONT_LOADER_CONST1);
               tempData.writeUnsignedInt(10 + stringID.length + classCodeLength);
               tempData.writeUnsignedInt(3014672);
               tempData.writeUnsignedInt(268435456);
               tempData.writeByte(stringID.length);
               tempData.writeUTFBytes(stringID);
               tempData.writeByte(0);
               tempData.writeBytes(FontLoader.fontClassTemplateBytes);
               tempData.writeBytes(data);
               tempData.writeShort(FontLoader.FONT_LOADER_CONST2);
               tempData.writeUnsignedInt(5 + stringID.length);
               tempData.writeShort(1);
               tempData.writeShort(o as uint);
               tempData.writeUTFBytes(stringID);
               tempData.writeByte(0);
               id++;
            }
         }
         this.fontClassCount = id;
         if(this.fontClassCount)
         {
            tempData.writeUnsignedInt(64);
            fontSWF = new ByteArray();
            fontSWF.endian = Endian.LITTLE_ENDIAN;
            fontSWF.writeUTFBytes("FWS");
            fontSWF.writeByte(9);
            fontSWF.writeUnsignedInt(tempData.length + 8);
            fontSWF.writeBytes(tempData);
            this.swfLoader = new Loader();
            this.swfLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onContentLoaderInfoComplete2);
            context = new LoaderContext();
            if("allowLoadBytesCodeExecution" in context)
            {
               context["allowLoadBytesCodeExecution"] = true;
            }
            this.swfLoader.loadBytes(fontSWF,context);
         }
         else if(delayed)
         {
            this.swfLoader = new Loader();
            this.swfLoader.addEventListener(Event.ENTER_FRAME,this.onSwfLoaderEnterFrame2);
         }
         else
         {
            this.close();
            super.dispatchEvent(new Event(Event.COMPLETE));
         }
      }
      
      private function doAction284(bytes:ByteArray, fontTags:Object, idOffset:uint = 0) : void
      {
         var fontId:uint;
         var tagType:uint;
         var tagHeader:uint;
         var tagLength:uint;
         var tagStart:Number;
         var tagBytes:ByteArray;
         while(bytes.bytesAvailable)
         {
            tagHeader = bytes.readUnsignedShort();
            tagType = tagHeader >> 6;
            tagLength = ((tagHeader & 0x3F) == 63) ? bytes.readUnsignedInt() : tagHeader & 0x3F;
            tagStart = bytes.position;
            switch(tagType)
            {
               case 13:
               case 48:
               case 62:
               case 73:
               case 75:
               case 88:
               case 91:
                  fontId = bytes.readUnsignedShort() + idOffset;
                  tagBytes = fontTags[fontId] as ByteArray;
                  if(!tagBytes)
                  {
                     tagBytes = new ByteArray();
                     tagBytes.endian = Endian.LITTLE_ENDIAN;
                     fontTags[fontId] = tagBytes;
                  }
                  if((tagHeader & 0x3F) == 63)
                  {
                     tagBytes.writeShort(tagType << 6 | 0x3F);
                     tagBytes.writeUnsignedInt(tagLength);
                  }
                  else
                  {
                     tagBytes.writeShort(tagType << 6 | tagLength & 0x3F);
                  }
                  tagBytes.writeShort(fontId);
                  tagBytes.writeBytes(bytes,bytes.position,tagLength - 2);
                  break;
               case 87:
                  tagBytes = new ByteArray();
                  tagBytes.endian = Endian.LITTLE_ENDIAN;
                  bytes.readUnsignedShort();
                  bytes.readUnsignedInt();
                  tagBytes.writeBytes(bytes,bytes.position,tagLength - 6);
                  tagBytes.position = 0;
                  try
                  {
                     tagBytes = new SWFByteArray(tagBytes);
                     this.embeddedFontMovieCount += 1;
                     this.doAction284(tagBytes,fontTags,idOffset + 2000 * this.embeddedFontMovieCount);
                  }
                  catch(error:ArgumentError)
                  {
                  }
                  break;
            }
            bytes.position = tagStart + tagLength;
         }
      }
      
      private function onSwfLoaderEnterFrame2(param1:Event) : void
      {
         this.swfLoader.removeEventListener(Event.ENTER_FRAME,this.onSwfLoaderEnterFrame2);
         this.swfLoader = null;
         this.close();
         super.dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function onSwfLoaderEnterFrame(param1:Event) : void
      {
         this.swfLoader.removeEventListener(Event.ENTER_FRAME,this.onSwfLoaderEnterFrame);
         this.swfLoader = null;
         this.close();
         super.dispatchEvent(new IOErrorEvent(IOErrorEvent.VERIFY_ERROR));
      }
      
      private function onFontUrlLoaderComplete(param1:Event) : void
      {
         this.doAction607(this.fontUrlLoader.data as ByteArray);
      }
      
      private function onContentLoaderInfoComplete2(param1:Event) : void
      {
         var className:String = null;
         var index:uint = 0;
         var fontClass:Class = null;
         var font:Font = null;
         var domain:ApplicationDomain = this.swfLoader.contentLoaderInfo.applicationDomain;
         index = 0;
         while(index < this.fontClassCount)
         {
            className = index.toString();
            while(className.length < 3)
            {
               className = "0" + className;
            }
            className = FontLoader.FONT + className;
            if(domain.hasDefinition(className))
            {
               fontClass = domain.getDefinition(className) as Class;
               font = new fontClass() as Font;
               if((font) && font.fontName)
               {
                  this._loadedFonts.push(font);
                  if(this.registerLoadedFonts)
                  {
                     Font.registerFont(fontClass);
                  }
               }
            }
            index++;
         }
         this.close();
         super.dispatchEvent(new Event(Event.COMPLETE));
      }
   }
}

import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.utils.Endian;

class SWFByteArray extends ByteArray
{
   
   private static const TAG_SWF:String = "FWS";
   
   private static const TAG_SWF_COMPRESSED:String = "CWS";
   
   private var _bitIndex:uint;
   
   private var _version:uint;
   
   public function SWFByteArray(source:ByteArray = null)
   {
      var originalEndian:String = null;
      var signature:String = null;
      var originalPosition:uint = 0;
      super();
      super.endian = Endian.LITTLE_ENDIAN;
      if(source)
      {
         originalEndian = source.endian;
         originalPosition = source.position;
         source.endian = Endian.LITTLE_ENDIAN;
         source.position = 0;
         if(source.bytesAvailable > 26)
         {
            signature = source.readUTFBytes(3);
            if(signature == SWFByteArray.TAG_SWF || signature == SWFByteArray.TAG_SWF_COMPRESSED)
            {
               this._version = source.readUnsignedByte();
               source.readUnsignedInt();
               source.readBytes(this);
               if(signature == SWFByteArray.TAG_SWF_COMPRESSED)
               {
                  super.uncompress();
               }
            }
            else
            {
               throw new ArgumentError("Error #2124: Loaded file is an unknown type.");
            }
            this.readHeader();
         }
         else
         {
            throw new ArgumentError("Insufficient data.");
         }
         source.endian = originalEndian;
         source.position = originalPosition;
      }
   }
   
   public function get version() : uint
   {
      return this._version;
   }
   
   private var _frameRate:Number;

   public function get frameRate() : Number
   {
      return this._frameRate;
   }
   
   private var _rect:Rectangle;

   public function get rect() : Rectangle
   {
      return this._rect;
   }
   
   public function writeBytesFromString(hex:String) : void
   {
      var length:uint = hex.length;
      var index:uint = 0;
      var hexByte:String;
      var value:uint;
      while(index < length)
      {
         hexByte = hex.substr(index,2);
         value = parseInt(hexByte,16);
         writeByte(value);
         index += 2;
      }
   }
   
   public function readRect() : Rectangle
   {
      var startPosition:uint = super.position;
      var firstByte:uint = this[startPosition];
      var bitsPerValue:uint = firstByte >> 3;
      var xMin:Number = this.readBits(bitsPerValue,5) / 20;
      var xMax:Number = this.readBits(bitsPerValue) / 20;
      var yMin:Number = this.readBits(bitsPerValue) / 20;
      var yMax:Number = this.readBits(bitsPerValue) / 20;
      super.position = startPosition + Math.ceil((bitsPerValue * 4 - 3) / 8) + 1;
      return new Rectangle(xMin,yMin,xMax - xMin,yMax - yMin);
   }
   
   public function readBits(bitCount:uint, bitOffset:int = -1) : Number
   {
      if(bitOffset < 0)
      {
         bitOffset = this._bitIndex;
      }
      this._bitIndex = bitOffset;
      var currentByte:uint = this[super.position];
      var value:Number = 0;
      var unused:Number = 0;
      var bitsRemaining:uint = 8 - bitOffset;
      var additionalBits:Number = bitCount - bitsRemaining;
      if(additionalBits > 0)
      {
         ++super.position;
         value = this.readBits(additionalBits,0) | (currentByte & (1 << bitsRemaining) - 1) << additionalBits;
      }
      else
      {
         value = currentByte >> 8 - bitCount - bitOffset & (1 << bitCount) - 1;
         this._bitIndex = (bitOffset + bitCount) % 8;
         if(bitOffset + bitCount > 7)
         {
            ++super.position;
         }
      }
      return value;
   }
   
   public function traceArray(bytes:ByteArray) : String
   {
      var result:String = "";
      var originalPosition:uint = bytes.position;
      var unused:uint = 0;
      var hexByte:String;
      bytes.position = 0;
      while(bytes.bytesAvailable)
      {
         hexByte = bytes.readUnsignedByte().toString(16).toUpperCase();
         hexByte = hexByte.length < 2 ? "0" + hexByte : hexByte;
         result += hexByte + " ";
      }
      bytes.position = originalPosition;
      return result;
   }
   
   private function readFrameRate() : void
   {
      var fraction:Number;
      if(this._version < 8)
      {
         this._frameRate = super.readUnsignedShort();
      }
      else
      {
         fraction = super.readUnsignedByte() / 255;
         this._frameRate = super.readUnsignedByte() + fraction;
      }
   }
   
   private function readHeader() : void
   {
      this._rect = this.readRect();
      this.readFrameRate();
      super.readShort();
   }
}
