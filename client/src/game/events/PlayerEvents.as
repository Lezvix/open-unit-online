package game.events
{
   public class PlayerEvents
   {
      
      public static const CREATE_MOUSE_PLAYER_BY_DATA:String = "create_mouse_player_by_data";
      
      public static const PLAYER_ADDED:String = "player_added";
      
      public static const ADD_PLAYER:String = "add_Player";
      
      public static const REMOVE_PLAYER:String = "remove_player";
      
      public static const MOUSE_OBJECT_CREATED:String = "mouse_object_created";
      
      public static const CREATE_MOUSE_COMPOSITION_BY_DATA:String = "create_mouse_composition_by_data";
      
      public static const WORLD_ADD_COMPOSITION:String = "add_composition";
      
      public static const COMPOSITION_ADDED:String = "composition_added";
      
      public static const REMOVE_COMPOSITION:String = "remove_composition";
      
      public static const WORLD_COMPOSITION_REMOVED:String = "world_composition_removed";
      
      public static const COMPOSITION_CLICKED:String = "composition_clicked";
      
      public static const PLAYER_CLICKED:String = "player_clicked";
      
      public static const START_MOVE_COMPOSITION:String = "start_move_composition";
      
      public static const START_ROTATE_COMPOSITION:String = "start_rotate_composition";
      
      public static const START_MOVE_PLAYER:String = "start_move_player";
      
      public static const LOCATION_OBJECT_TRANSFORMED:String = "location_object_transformed";
      
      public function PlayerEvents()
      {
         super();
      }
   }
}

