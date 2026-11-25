package ui.buttons
{
   public class PageButton extends TextLinkButton
   {
      
      private var _targetPage:int;
      
      public function PageButton(clickHandler:Function, pageIndex:int)
      {
         super(clickHandler,String(pageIndex + 1),32);
         this._targetPage = pageIndex;
      }
      
      public function get targetPage() : int
      {
         return this._targetPage;
      }
   }
}

