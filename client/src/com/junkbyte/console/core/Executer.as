package com.junkbyte.console.core
{
   import com.junkbyte.console.vos.WeakObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getDefinitionByName;
   
   public class Executer extends EventDispatcher
   {
      
      public static const RETURNED:String = "returned";
      
      public static const EXECUTER_CONST1:String = "ExeValue|((com.junkbyte.console.core::)?Executer)";
      
      private var objectList2:Array;
      
      private var flag26:Boolean;
      
      private var _scope:*;
      
      private var value4:*;
      
      private var _saved:Object;
      
      private var array73:Array;
      
      public var flag115:Boolean;
      
      public function Executer()
      {
         super();
      }
      
      public static function doAction478(param1:Object, param2:String, param3:Object = null) : *
      {
         var executer:Executer = new Executer();
         executer.doAction537(param3);
         return executer.exec(param1,param2);
      }
      
      private static const EXECUTER_CONST2:String = "#";

      public function get returned() : *
      {
         return this.value4;
      }
      
      public function get scope() : *
      {
         return this._scope;
      }
      
      public function doAction537(param1:Object) : void
      {
         _saved = param1;
      }
      
      public function doAction524(param1:Array) : void
      {
         array73 = param1;
      }
      
      public function exec(s:*, str:String) : *
      {
         if(this.flag26)
         {
            throw new Error("CommandExec.exec() is already runnnig. Does not support loop backs.");
         }
         flag26 = true;
         _scope = s;
         objectList2 = [];
         if(!this._saved)
         {
            _saved = new Object();
         }
         if(!this.array73)
         {
            array73 = new Array();
         }
         try
         {
            this.doAction838(str);
         }
         catch(e:Error)
         {
            reset();
            throw e;
         }
         this.reset();
         return this.value4;
      }
      
      private function reset() : void
      {
         _saved = null;
         array73 = null;
         objectList2 = null;
         flag26 = false;
      }
      
      private function doAction838(param1:String) : void
      {
         var quotePattern:RegExp = /''|""|('(.*?)[^\\]')|("(.*?)[^\\]")/;
         var quoteMatch:Object = quotePattern.exec(param1);
         while(quoteMatch != null)
         {
            var quotedText:String = quoteMatch[0];
            var quoteChar:String = quotedText.charAt(0);
            var quoteStart:int = quotedText.indexOf(quoteChar);
            var quoteEnd:int = quotedText.lastIndexOf(quoteChar);
            var unescapedText:String = quotedText.substring(quoteStart + 1,quoteEnd).replace(/\\(.)/g,"$1");
            param1 = this.getString48(param1,new ExeValue(unescapedText),quoteMatch.index + quoteStart,quoteMatch.index + quoteEnd + 1);
            quoteMatch = quotePattern.exec(param1);
         }
         if(param1.search(new RegExp("\'|\"")) >= 0)
         {
            throw new Error("Bad syntax extra quotation marks");
         }
         var commands:Array = param1.split(/\s*;\s*/);
         var command:String;
         for each(command in commands)
         {
            if(command.length)
            {
               var returnedValue:* = this._saved[RETURNED];
               if((returnedValue) && command == "/")
               {
                  _scope = returnedValue;
                  dispatchEvent(new Event(Event.COMPLETE));
               }
               else
               {
                  this.doAction200(command);
               }
            }
         }
      }
      
      private function doAction200(param1:String) : *
      {
         param1 = this.getString45(param1);
         var openIndex:int = param1.lastIndexOf("(");
         var firstCloseIndex:int;
         var nestedOpenIndex:int;
         var closeIndex:int;
         var innerText:String;
         var isCall:Boolean;
         var previousIndex:int;
         var previousChar:String;
         var argumentsList:Array;
         var argumentIndex:String;
         var wrappedValue:ExeValue;
         var resultType:String;
         while(openIndex >= 0)
         {
            firstCloseIndex = param1.indexOf(")",openIndex);
            if(param1.substring(openIndex + 1,firstCloseIndex).search(/\w/) >= 0)
            {
               nestedOpenIndex = openIndex;
               closeIndex = openIndex + 1;
               while(nestedOpenIndex >= 0 && nestedOpenIndex < closeIndex)
               {
                  nestedOpenIndex++;
                  nestedOpenIndex = param1.indexOf("(",nestedOpenIndex);
                  closeIndex = param1.indexOf(")",closeIndex + 1);
               }
               innerText = param1.substring(openIndex + 1,closeIndex);
               isCall = false;
               previousIndex = openIndex - 1;
               while(true)
               {
                  previousChar = param1.charAt(previousIndex);
                  if(previousChar.match(/[^\s]/) || previousIndex <= 0)
                  {
                     if(previousChar.match(/\w/))
                     {
                        isCall = true;
                     }
                     break;
                  }
                  previousIndex--;
               }
               if(isCall)
               {
                  argumentsList = innerText.split(",");
                  param1 = this.getString48(param1,new ExeValue(argumentsList),openIndex + 1,closeIndex);
                  for(argumentIndex in argumentsList)
                  {
                     argumentsList[argumentIndex] = this.getExeValue1(this.getString45(argumentsList[argumentIndex])).value;
                  }
               }
               else
               {
                  wrappedValue = new ExeValue(wrappedValue);
                  param1 = this.getString48(param1,wrappedValue,openIndex,closeIndex + 1);
                  wrappedValue.setValue(this.getExeValue1(this.getString45(innerText)).value);
               }
            }
            openIndex = param1.lastIndexOf("(",openIndex - 1);
         }
         value4 = this.getExeValue1(param1).value;
         if(this.value4 && this.flag115)
         {
            resultType = typeof this.value4;
            if(resultType == "object" || resultType == "xml")
            {
               _scope = this.value4;
            }
         }
         dispatchEvent(new Event(Event.COMPLETE));
         return this.value4;
      }
      
      private function getString48(param1:String, param2:*, param3:int, param4:int) : String
      {
         param1 = param1.substring(0,param3) + EXECUTER_CONST2 + this.objectList2.length + param1.substring(param4);
         this.objectList2.push(param2);
         return param1;
      }
      
      private function getExeValue1(param1:String) : ExeValue
      {
         var operatorPattern:RegExp = /\s*(((\|\||\&\&|[+|\-|*|\/|\%|\||\&|\^]|\=\=?|\!\=|\>\>?\>?|\<\<?)\=?)|=|\~|\sis\s|typeof|delete\s)\s*/g;
         var operatorMatch:Object = operatorPattern.exec(param1);
         var tokens:Array = [];
         if(operatorMatch == null)
         {
            tokens.push(param1);
         }
         else
         {
            var previousIndex:int = 0;
            while(operatorMatch != null)
            {
               var matchIndex:int = operatorMatch.index;
               var matchedOperator:String = operatorMatch[0];
               operatorMatch = operatorPattern.exec(param1);
               if(operatorMatch == null)
               {
                  tokens.push(param1.substring(previousIndex,matchIndex));
                  tokens.push(this.getString45(matchedOperator));
                  tokens.push(param1.substring(matchIndex + matchedOperator.length));
               }
               else
               {
                  tokens.push(param1.substring(previousIndex,matchIndex));
                  tokens.push(this.getString45(matchedOperator));
                  previousIndex = matchIndex + matchedOperator.length;
               }
            }
         }
         var tokenCount:int = tokens.length;
         var tokenIndex:int = 0;
         while(tokenIndex < tokenCount)
         {
            tokens[tokenIndex] = this.getExeValue2(tokens[tokenIndex]);
            tokenIndex += 2;
         }
         var operator:String;
         var resultValue:*;
         var assignmentPattern:RegExp = /((\|\||\&\&|[+|\-|*|\/|\%|\||\&|\^]|\>\>\>?|\<\<)\=)|=/;
         tokenIndex = 1;
         while(tokenIndex < tokenCount)
         {
            operator = tokens[tokenIndex];
            if(operator.replace(assignmentPattern,"") != "")
            {
               resultValue = this.doAction885(tokens[tokenIndex - 1],operator,tokens[tokenIndex + 1]);
               var leftValue:ExeValue = ExeValue(tokens[tokenIndex - 1]);
               leftValue.setValue(resultValue);
               tokens.splice(tokenIndex,2);
               tokenIndex -= 2;
               tokenCount -= 2;
            }
            tokenIndex += 2;
         }
         tokens.reverse();
         var result:ExeValue = tokens[0];
         tokenIndex = 1;
         while(tokenIndex < tokenCount)
         {
            operator = tokens[tokenIndex];
            if(operator.replace(assignmentPattern,"") == "")
            {
               result = tokens[tokenIndex - 1];
               var targetValue:ExeValue = tokens[tokenIndex + 1];
               if(operator.length > 1)
               {
                  operator = operator.substring(0,operator.length - 1);
               }
               resultValue = this.doAction885(targetValue,operator,result);
               targetValue.setValue(resultValue);
            }
            tokenIndex += 2;
         }
         return result;
      }
      
      private function getExeValue2(str:String) : ExeValue
      {
         var v:ExeValue = new ExeValue(this._scope);
         if(str.indexOf("new ") == 0)
         {
            var newstr:String = str;
            var defclose:int = str.indexOf(")");
            if(defclose >= 0)
            {
               newstr = str.substring(0,defclose + 1);
            }
            var newobj:* = this.doAction733(newstr.substring(4));
            str = this.getString48(str,new ExeValue(newobj),0,newstr.length);
         }
         var reg:RegExp = /\.|\(/g;
         var result:Object = reg.exec(str);
         if(result == null || !isNaN(Number(str)))
         {
            return this.getExeValue3(str,this._scope);
         }
         var firstparts:Array = String(str.split("(")[0]).split(".");
         if(firstparts.length > 0)
         {
            while(firstparts.length)
            {
               var classstr:String = firstparts.join(".");
               try
               {
                  var def:* = getDefinitionByName(this.getString45(classstr));
                  var havemore:Boolean = str.length > classstr.length;
                  str = this.getString48(str,new ExeValue(def),0,classstr.length);
                  if(havemore)
                  {
                     reg.lastIndex = 0;
                     result = reg.exec(str);
                  }
                  else
                  {
                     return this.getExeValue3(str);
                  }
                  break;
               }
               catch(e:Error)
               {
                  firstparts.pop();
               }
            }
         }
         var previndex:int = 0;
         while(result != null)
         {
            var index:int = result.index;
            var isFun:Boolean = str.charAt(index) == "(";
            var basestr:String = this.getString45(str.substring(previndex,index));
            var newv:ExeValue = previndex == 0 ? this.getExeValue3(basestr,v.value) : new ExeValue(v.value,basestr);
            if(isFun)
            {
               var newbase:* = newv.value;
               var closeindex:int = str.indexOf(")",index);
               var paramstr:String = str.substring(index + 1,closeindex);
               paramstr = this.getString45(paramstr);
               var params:Array = [];
               if(paramstr)
               {
                  params = this.getExeValue3(paramstr).value;
               }
               if(!(newbase is Function))
               {
                  try
                  {
                     var nss:Array = [AS3];
                     for each(var ns:Namespace in nss)
                     {
                        var nsv:* = v.obj.ns::[basestr];
                        if(nsv is Function)
                        {
                           newbase = nsv;
                           break;
                        }
                     }
                  }
                  catch(e:Error)
                  {
                  }
                  if(!(newbase is Function))
                  {
                     throw new Error(basestr + " is not a function.");
                  }
               }
               v.obj = (newbase as Function).apply(v.value,params);
               v.prop = null;
               index = closeindex + 1;
            }
            else
            {
               v = newv;
            }
            previndex = index + 1;
            reg.lastIndex = index + 1;
            result = reg.exec(str);
            if(result != null)
            {
               continue;
            }
            if(index + 1 < str.length)
            {
               reg.lastIndex = str.length;
               result = {"index":str.length};
            }
         }
         return v;
      }
      
      private function getExeValue3(str:String, base:* = null) : ExeValue
      {
         var v:ExeValue;
         var vv:ExeValue;
         var key:String;
         v = new ExeValue();
         if(str == "true")
         {
            v.obj = true;
         }
         else if(str == "false")
         {
            v.obj = false;
         }
         else if(str == "this")
         {
            v.obj = this._scope;
         }
         else if(str == "null")
         {
            v.obj = null;
         }
         else if(!isNaN(Number(str)))
         {
            v.obj = Number(str);
         }
         else if(str.indexOf(EXECUTER_CONST2) == 0)
         {
            vv = this.objectList2[str.substring(EXECUTER_CONST2.length)];
            v.obj = vv.value;
         }
         else if(str.charAt(0) == "$")
         {
            key = str.substring(1);
            if(this.array73.indexOf(key) < 0)
            {
               v.obj = this._saved;
               v.prop = key;
            }
            else if(this._saved is WeakObject)
            {
               v.obj = WeakObject(this._saved).get(key);
            }
            else
            {
               v.obj = this._saved[key];
            }
         }
         else
         {
            try
            {
               v.obj = getDefinitionByName(str);
            }
            catch(e:Error)
            {
               v.obj = base;
               v.prop = str;
            }
         }
         return v;
      }
      
      private function doAction885(param1:ExeValue, param2:String, param3:ExeValue) : *
      {
         switch(param2)
         {
            case "=":
               return param3.value;
            case "+":
               return param1.value + param3.value;
            case "-":
               return param1.value - param3.value;
            case "*":
               return param1.value * param3.value;
            case "/":
               return param1.value / param3.value;
            case "%":
               return param1.value % param3.value;
            case "^":
               return param1.value ^ param3.value;
            case "&":
               return param1.value & param3.value;
            case ">>":
               return param1.value >> param3.value;
            case ">>>":
               return param1.value >>> param3.value;
            case "<<":
               return param1.value << param3.value;
            case "~":
               return ~param3.value;
            case "|":
               return param1.value | param3.value;
            case "!":
               return !param3.value;
            case ">":
               return param1.value > param3.value;
            case ">=":
               return param1.value >= param3.value;
            case "<":
               return param1.value < param3.value;
            case "<=":
               return param1.value <= param3.value;
            case "||":
               return param1.value || param3.value;
            case "&&":
               return param1.value && param3.value;
            case "is":
               return param1.value is param3.value;
            case "typeof":
               return typeof param3.value;
            case "delete":
               return delete param3.obj[param3.prop];
            case "==":
               return param1.value == param3.value;
            case "===":
               return param1.value === param3.value;
            case "!=":
               return param1.value != param3.value;
            case "!==":
               return param1.value !== param3.value;
         }
         return;
      }
      
      private function doAction733(param1:String) : *
      {
         var openIndex:int = param1.indexOf("(");
         var className:String = openIndex > 0 ? param1.substring(0,openIndex) : param1;
         className = this.getString45(className);
         var classType:* = this.getExeValue3(className).value;
         var closeIndex:int;
         var argumentsText:String;
         var argumentsList:Array;
         var argumentCount:int;
         if(openIndex > 0)
         {
            closeIndex = param1.indexOf(")",openIndex);
            argumentsText = param1.substring(openIndex + 1,closeIndex);
            argumentsText = this.getString45(argumentsText);
            argumentsList = [];
            if(argumentsText)
            {
               argumentsList = this.getExeValue3(argumentsText).value;
            }
            argumentCount = argumentsList.length;
            if(argumentCount == 0)
            {
               return new classType();
            }
            if(argumentCount == 1)
            {
               return new classType(argumentsList[0]);
            }
            if(argumentCount == 2)
            {
               return new classType(argumentsList[0],argumentsList[1]);
            }
            if(argumentCount == 3)
            {
               return new classType(argumentsList[0],argumentsList[1],argumentsList[2]);
            }
            if(argumentCount == 4)
            {
               return new classType(argumentsList[0],argumentsList[1],argumentsList[2],argumentsList[3]);
            }
            if(argumentCount == 5)
            {
               return new classType(argumentsList[0],argumentsList[1],argumentsList[2],argumentsList[3],argumentsList[4]);
            }
            if(argumentCount == 6)
            {
               return new classType(argumentsList[0],argumentsList[1],argumentsList[2],argumentsList[3],argumentsList[4],argumentsList[5]);
            }
            if(argumentCount == 7)
            {
               return new classType(argumentsList[0],argumentsList[1],argumentsList[2],argumentsList[3],argumentsList[4],argumentsList[5],argumentsList[6]);
            }
            if(argumentCount == 8)
            {
               return new classType(argumentsList[0],argumentsList[1],argumentsList[2],argumentsList[3],argumentsList[4],argumentsList[5],argumentsList[6],argumentsList[7]);
            }
            if(argumentCount == 9)
            {
               return new classType(argumentsList[0],argumentsList[1],argumentsList[2],argumentsList[3],argumentsList[4],argumentsList[5],argumentsList[6],argumentsList[7],argumentsList[8]);
            }
            if(argumentCount == 10)
            {
               return new classType(argumentsList[0],argumentsList[1],argumentsList[2],argumentsList[3],argumentsList[4],argumentsList[5],argumentsList[6],argumentsList[7],argumentsList[8],argumentsList[9]);
            }
            throw new Error("CommandLine can\'t create new class instances with more than 10 arguments.");
         }
         return null;
      }
      
      private function getString45(param1:String) : String
      {
         param1 = param1.replace(/\s*(.*)/,"$1");
         var endIndex:int = param1.length - 1;
         while(endIndex > 0)
         {
            if(param1.charAt(endIndex).match(/\s/))
            {
               param1 = param1.substring(0,endIndex);
            }
            else
            {
               break;
            }
            endIndex--;
         }
         return param1;
      }
   }
}

class ExeValue
{
   
   public var obj:*;
   
   public var prop:String;
   
   public function ExeValue(param1:Object = null, param2:String = null)
   {
      super();
      this.obj = param1;
      this.prop = param2;
   }
   
   public function get value() : *
   {
      return this.prop ? this.obj[this.prop] : this.obj;
   }
   
   public function setValue(param1:*) : void
   {
      if(this.prop)
      {
         this.obj[this.prop] = param1;
      }
      else
      {
         obj = param1;
      }
   }
}
