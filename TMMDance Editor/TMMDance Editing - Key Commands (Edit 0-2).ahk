; ==============================================================================

; Initial Setup
; =============================

; Joystick D-pad set up
; =====================

; Starts a timer for watching the Joystick D-pad axis
#Persistent  ; Keep this script running until the user explicitly exits it.
SetTimer, WatchAxis, 5
return



; Joypad D-pad  = Controls arrow keys.

WatchAxis:
JoyX := GetKeyState("JoyX")  ; Get position of X axis.
JoyY := GetKeyState("JoyY")  ; Get position of Y axis.
KeyToHoldDownPrev := KeyToHoldDown  ; Prev now holds the key that was down before (if any).

if (JoyX > 70)
    KeyToHoldDown := "Right"
else if (JoyX < 30)
    KeyToHoldDown := "Left"
else if (JoyY > 70)
    KeyToHoldDown := "Down"
else if (JoyY < 30)
    KeyToHoldDown := "Up"
else
    KeyToHoldDown := ""

;if (KeyToHoldDown = KeyToHoldDownPrev)  ; The correct key is already down (or no key is needed).
    ;return  ; Do nothing.

; Otherwise, release the previous key and press down the new key:
SetKeyDelay -1  ; Avoid delays between keystrokes.
if KeyToHoldDownPrev   ; There is a previous key to release.
    Send, {%KeyToHoldDownPrev% up}  ; Release it.
if KeyToHoldDown   ; There is a key to press down.
    Send, {%KeyToHoldDown% down}  ; Press it down.
return



; Keyboard Shortcuts
; ==================


; Joypad Button 9 (Select) = Hit Enter

Joy9::

Send, {Enter}
return





; ==============================================================================

; If Vegas 13 is active do the following
#IfWinActive ahk_exe VEGAS130.exe

; Keyboard Shortcuts
; ==================



; Joypad Button 1 (X Button) =

Joy1::

Loop, 10
{
  Send, !{Left}
}

return



; Joypad Button 2 (A Button) =

Joy2::

Loop, 10
{
  Send, !{Right}
}

return



; Joypad Button 3 (B Button) =

Joy3::

Loop, 30
{
  Send, !{Right}
}

return



; Joypad Button 4 (Y Button) =

Joy4::

Loop, 30
{
  Send, !{Left}
}

return



; Joypad Button 5 (Left Bumper) = Move a region to the Left

Joy5::

Send, ^{Left}
return



; Joypad Button 7 (Right Bumper) = Move a region to the Right

Joy7::

Send, ^{Right}
return



; Joypad Button 10 (Start) = Moves Closest region to current cursor position

Joy10::

; Search for Region
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, Regions.png
If(ErrorLevel == 0){
MouseMove, %foundX%, %foundY%
MouseMove, 7, 7, 1, R ; Left Right, Up Down, Speed, "Relative"
Click, down
}
else{
MsgBox, Region Image not found.
}

; Search for Cursor head
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, Cursor.png
If(ErrorLevel == 0){
MouseMove, %foundX%, %foundY%
MouseMove, 3, -5, 2, R ; Left Right, Up Down, Speed, "Relative"
sleep,  20
Click, up
}else{
MsgBox, Cursor Image not found.
}

return
