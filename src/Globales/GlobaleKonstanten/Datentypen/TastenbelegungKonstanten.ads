with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Window.Keyboard;

package TastenbelegungKonstanten is
   pragma Elaborate_Body;
   
   type TastennamenArray is array (Sf.Window.Keyboard.sfKeyA .. Sf.Window.Keyboard.sfKeyCount) of Unbounded_Wide_Wide_String;
   Tastennamen : constant TastennamenArray := (
                                               To_Unbounded_Wide_Wide_String (Source => "A"),
                                               To_Unbounded_Wide_Wide_String (Source => "B"),
                                               To_Unbounded_Wide_Wide_String (Source => "C"),
                                               To_Unbounded_Wide_Wide_String (Source => "D"),
                                               To_Unbounded_Wide_Wide_String (Source => "E"),
                                               To_Unbounded_Wide_Wide_String (Source => "F"),
                                               To_Unbounded_Wide_Wide_String (Source => "G"),
                                               To_Unbounded_Wide_Wide_String (Source => "H"),
                                               To_Unbounded_Wide_Wide_String (Source => "I"),
                                               To_Unbounded_Wide_Wide_String (Source => "J"),
                                               To_Unbounded_Wide_Wide_String (Source => "K"),
                                               To_Unbounded_Wide_Wide_String (Source => "L"),
                                               To_Unbounded_Wide_Wide_String (Source => "M"),
                                               To_Unbounded_Wide_Wide_String (Source => "N"),
                                               To_Unbounded_Wide_Wide_String (Source => "O"),
                                               To_Unbounded_Wide_Wide_String (Source => "P"),
                                               To_Unbounded_Wide_Wide_String (Source => "Q"),
                                               To_Unbounded_Wide_Wide_String (Source => "R"),
                                               To_Unbounded_Wide_Wide_String (Source => "S"),
                                               To_Unbounded_Wide_Wide_String (Source => "T"),
                                               To_Unbounded_Wide_Wide_String (Source => "U"),
                                               To_Unbounded_Wide_Wide_String (Source => "V"),
                                               To_Unbounded_Wide_Wide_String (Source => "W"),
                                               To_Unbounded_Wide_Wide_String (Source => "X"),
                                               To_Unbounded_Wide_Wide_String (Source => "Y"),
                                               To_Unbounded_Wide_Wide_String (Source => "Z"),
                                               To_Unbounded_Wide_Wide_String (Source => "Num0"),
                                               To_Unbounded_Wide_Wide_String (Source => "Num1"),
                                               To_Unbounded_Wide_Wide_String (Source => "Num2"),
                                               To_Unbounded_Wide_Wide_String (Source => "Num3"),
                                               To_Unbounded_Wide_Wide_String (Source => "Num4"),
                                               To_Unbounded_Wide_Wide_String (Source => "Num5"),
                                               To_Unbounded_Wide_Wide_String (Source => "Num6"),
                                               To_Unbounded_Wide_Wide_String (Source => "Num7"),
                                               To_Unbounded_Wide_Wide_String (Source => "Num8"),
                                               To_Unbounded_Wide_Wide_String (Source => "Num9"),
                                               To_Unbounded_Wide_Wide_String (Source => "Escape"),
                                               To_Unbounded_Wide_Wide_String (Source => "LControl"),
                                               To_Unbounded_Wide_Wide_String (Source => "LShift"),
                                               To_Unbounded_Wide_Wide_String (Source => "LAlt"),
                                               To_Unbounded_Wide_Wide_String (Source => "LSystem"),
                                               To_Unbounded_Wide_Wide_String (Source => "RControl"),
                                               To_Unbounded_Wide_Wide_String (Source => "RShift"),
                                               To_Unbounded_Wide_Wide_String (Source => "RAlt"),
                                               To_Unbounded_Wide_Wide_String (Source => "RSystem"),
                                               To_Unbounded_Wide_Wide_String (Source => "Menu"),
                                               To_Unbounded_Wide_Wide_String (Source => "LBracket"),
                                               To_Unbounded_Wide_Wide_String (Source => "RBracket"),
                                               To_Unbounded_Wide_Wide_String (Source => "SemiColon"),
                                               To_Unbounded_Wide_Wide_String (Source => "Comma"),
                                               To_Unbounded_Wide_Wide_String (Source => "Period"),
                                               To_Unbounded_Wide_Wide_String (Source => "Quote"),
                                               To_Unbounded_Wide_Wide_String (Source => "Slash"),
                                               To_Unbounded_Wide_Wide_String (Source => "BackSlash"),
                                               To_Unbounded_Wide_Wide_String (Source => "Tilde"),
                                               To_Unbounded_Wide_Wide_String (Source => "Equal"),
                                               To_Unbounded_Wide_Wide_String (Source => "Hyphen"),
                                               To_Unbounded_Wide_Wide_String (Source => "Space"),
                                               To_Unbounded_Wide_Wide_String (Source => "Enter"),
                                               To_Unbounded_Wide_Wide_String (Source => "BackSpace"),
                                               To_Unbounded_Wide_Wide_String (Source => "Tab"),
                                               To_Unbounded_Wide_Wide_String (Source => "PageUp"),
                                               To_Unbounded_Wide_Wide_String (Source => "PageDown"),
                                               To_Unbounded_Wide_Wide_String (Source => "End"),
                                               To_Unbounded_Wide_Wide_String (Source => "Home"),
                                               To_Unbounded_Wide_Wide_String (Source => "Insert"),
                                               To_Unbounded_Wide_Wide_String (Source => "Delete"),
                                               To_Unbounded_Wide_Wide_String (Source => "Add"),
                                               To_Unbounded_Wide_Wide_String (Source => "Subtract"),
                                               To_Unbounded_Wide_Wide_String (Source => "Multiply"),
                                               To_Unbounded_Wide_Wide_String (Source => "Divide"),
                                               To_Unbounded_Wide_Wide_String (Source => "Left"),
                                               To_Unbounded_Wide_Wide_String (Source => "Right"),
                                               To_Unbounded_Wide_Wide_String (Source => "Up"),
                                               To_Unbounded_Wide_Wide_String (Source => "Down"),
                                               To_Unbounded_Wide_Wide_String (Source => "Numpad0"),
                                               To_Unbounded_Wide_Wide_String (Source => "Numpad1"),
                                               To_Unbounded_Wide_Wide_String (Source => "Numpad2"),
                                               To_Unbounded_Wide_Wide_String (Source => "Numpad3"),
                                               To_Unbounded_Wide_Wide_String (Source => "Numpad4"),
                                               To_Unbounded_Wide_Wide_String (Source => "Numpad5"),
                                               To_Unbounded_Wide_Wide_String (Source => "Numpad6"),
                                               To_Unbounded_Wide_Wide_String (Source => "Numpad7"),
                                               To_Unbounded_Wide_Wide_String (Source => "Numpad8"),
                                               To_Unbounded_Wide_Wide_String (Source => "Numpad9"),
                                               To_Unbounded_Wide_Wide_String (Source => "F1"),
                                               To_Unbounded_Wide_Wide_String (Source => "F2"),
                                               To_Unbounded_Wide_Wide_String (Source => "F3"),
                                               To_Unbounded_Wide_Wide_String (Source => "F4"),
                                               To_Unbounded_Wide_Wide_String (Source => "F5"),
                                               To_Unbounded_Wide_Wide_String (Source => "F6"),
                                               To_Unbounded_Wide_Wide_String (Source => "F7"),
                                               To_Unbounded_Wide_Wide_String (Source => "F8"),
                                               To_Unbounded_Wide_Wide_String (Source => "F9"),
                                               To_Unbounded_Wide_Wide_String (Source => "F10"),
                                               To_Unbounded_Wide_Wide_String (Source => "F11"),
                                               To_Unbounded_Wide_Wide_String (Source => "F12"),
                                               To_Unbounded_Wide_Wide_String (Source => "F13"),
                                               To_Unbounded_Wide_Wide_String (Source => "F14"),
                                               To_Unbounded_Wide_Wide_String (Source => "F15"),
                                               To_Unbounded_Wide_Wide_String (Source => "Pause"),
                                               To_Unbounded_Wide_Wide_String (Source => "Count")
                                              );

end TastenbelegungKonstanten;
