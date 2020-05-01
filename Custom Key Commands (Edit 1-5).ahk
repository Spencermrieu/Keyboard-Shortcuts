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
; Gives up and down zoom control and play head movement on the timeline

WatchAxis:
JoyX := GetKeyState("JoyX")  ; Get position of X axis.
;MsgBox, Value Is: %JoyX% ; For Debugging

JoyY := GetKeyState("JoyY")  ; Get position of Y axis.
;MsgBox, Value Is: %JoyY% ; For Debugging

KeyToHoldDownPrev := KeyToHoldDown  ; Prev now holds the key that was down before (if any).

; If they controller is null break operation
if (JoyX = "")
  return

; X axis movement listiner
else if (JoyX < 30)
  KeyToHoldDown := "Left"
else if (JoyX > 70)
  KeyToHoldDown := "Right"

; Y axis movement listiner
else if (JoyY < 30)
  KeyToHoldDown := "Up"
else if (JoyY > 70)
  KeyToHoldDown := "Down"

else
  return


;if (KeyToHoldDown = KeyToHoldDownPrev)  ; The correct key is already down (or no key is needed).
    ;return  ; Do nothing.

if (KeyToHoldDown = "Up" or KeyToHoldDown = "Down" )
  SetKeyDelay 90  ; Sets the speed of held down keys -1 Avoids delays between keystrokes.

else

  if KeyToHoldDownPrev   ; There is a previous key to release.
      Send, {%KeyToHoldDownPrev% up}  ; Release it.
  if KeyToHoldDown   ; There is a key to press down.
      Send, {%KeyToHoldDown% down}  ; Press it down.

      SetKeyDelay 4  ; Sets the speed of held down keys -1 Avoids delays between keystrokes.

  return




; Instant Application Switching
; =============================

; Joystick Shortcuts
; ==================



; Joypad Button 9 (Select) = Taskmanager Instant Button

Joy9::

; If Taskmgr does not exist run it
IfWinNotExist, ahk_exe Taskmgr.exe
	Run, Taskmgr.exe
; If it was not active activate it
IfWinNotActive, ahk_exe Taskmgr.exe
	WinActivate ahk_exe Taskmgr.exe
return


; Joypad Button 10 (Start) = Chrome Instant Button

Joy10::

; If Chrome does not exist run it
IfWinNotExist, ahk_exe chrome.exe
	Run, chrome.exe
; If Chrome is active press control tab
IfWinActive, ahk_exe chrome.exe
	Send, ^{tab}
IfWinNotActive, ahk_exe chrome.exe
	WinActivate ahk_exe chrome.exe ; If it was not active activate it.
return




; ==============================================================================

; If Adobe After Effects is active do the following
#IfWinActive ahk_exe AfterFX.exe

; Keyboard Shortcuts
; ==================



; Control 1 = Export IMG sequence
; *** Must have desired render path copied to clipboard

^1::

Send, ^m
Sleep, 100
; Search for Lossless Render Output Module
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, %Images%\Lossless.png
If(ErrorLevel == 0){
Click, %foundX%, %foundY%
}else{
MsgBox, Render Output Module Image not found.
return
}
Sleep, 600



; Search for AVI Format
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, Avi.png
If(ErrorLevel == 0){
Click, %foundX%, %foundY%
}else{
MsgBox, Format Image not found.
return
}
Send, {Down}{Down}{Down}{Down}{Down}{Down}{Enter}
Sleep, 600

; Search for PNG Channels
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, Rgb.png
If(ErrorLevel == 0){
Click, %foundX%, %foundY%
}else{
MsgBox, RGB Image not found.
return
}
Send, {Down}{Down}{Enter}
Send, {Down}{Down}{Down}{Down}{Down}{Down}{Enter}
Sleep, 600

; Search for Output To: and click beside it
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, OutputTo.png
If(ErrorLevel == 0){
MouseMove, %foundX%, %foundY%
MouseMove, 80, 0, 0, R ; move the mouse 80px relative to its current position on the X-axis
Click,
}else{
MsgBox, Output To Image not found.
return
}
Sleep, 600
Send, ^v ; This can be removed if you do not want it to past the folder path for you
Send, {Enter}
Sleep, 600

; Search for New Folder
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, NewFolder.png
If(ErrorLevel == 0){
Click, %foundX%, %foundY%
}else{
MsgBox, New Folder Image not found.
return
}
Sleep, 100
Send, PNG Sequence 29.97fps ; Names the folder
Send, {Enter}
Sleep, 10
Send, {Enter}
return





; ==============================================================================

; If Chrome is active do the following
#IfWinActive ahk_exe chrome.exe

; Joystick Shortcuts
; ==================



; Joypad Button 1 (X Button) = Toggle the bookmarks bar between hidden and shown.

Joy1::

Send, ^+b
return



; Joypad Button 2 (A Button) = Open New browser window.

Joy2::

Send, ^t
return



; Joypad Button 3 (B Button) = Closes the current tab.

Joy3::

Send, ^w
return



; Joypad Button 4 (Y Button) = Reopens the last tab you've closed

Joy4::

Send, ^+t
return



; Joypad Button 5 (Left Bumper) = Navigates To the Left tab.

Joy5::

Send, ^+{tab}
;Send, !{Left}
return



; Joypad Button 7 (Right Bumper) = Navigates to next tab.

Joy7::

Send, ^{tab}
return




; ==============================================================================

; If Vegas 13 is active do the following
;#IfWinActive ahk_exe VEGAS130.exe

; If Vegas 13 or 17 is active do the following
#if, WinActive("ahk_exe VEGAS130.exe") || WinActive("ahk_exe VEGAS170.exe")



; Keyboard Shortcuts
; ==================



; Control 1 = import IMG sequence
; *** Must have desired render path copied to clipboard
; *** Can not be the same as the last path loaded into Vegas


^1::

Send, ^o
Sleep, 10
Send, ^v
Sleep, 180
Send, {Enter}
Sleep, 180

loop, 11{
  Send, {Tab}
  Sleep, 180
}

Send, {Right}
Sleep, 180
Send, {Left}
Sleep, 180


; Search for Image Sequence Check Box
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, ImageSequence.png
If(ErrorLevel == 0){
  Click, %foundX%, %foundY%
}else{
  MsgBox, Image Sequence Image not found.
  return
}


Sleep, 100

loop, 3{
  Send, {Tab}
  Sleep, 20
}

Sleep, 200
Send, {Enter}
return


; Control 2 = reverse selected clip (must be selected with timeline cursor over the media object)

^2::

Send, +{F10}
Send, r
return



; Control 3 =

;^3::



; Control 4 = Toggl full screen preview

^4::

Send, +!4
return



; Control 5 = 50% clip speed

^5::

Send, +{F10}
Send, p
Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}
Send, 0.50{enter}
return



; Control 6 = Return clip speed to 100%

^6::

Send, +{F10}
Send, p
Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}
Send, 1.0{enter}
return





; Joystick Shortcuts
; ==================



; Joypad Button 1 (X Button) = Cut the end of the clip starting at cursor

Joy1::

Send, !{]}
return



; Joypad Button 2 (A Button) = Toggle Auto Ripple

Joy2::

Send, ^l
return



; Joypad Button 3 (B Button) = Play or Pause

Joy3::

Send, {enter}
return



; Joypad Button 4 (Y Button) =  Cut the begining of the clip starting at cursor

Joy4::

Send, !{[}
return



; Joypad Button 5 (Left Bumper) = Start Playback Backwards & Speed up on multiple presses

Joy5::

Send, j
return



; Joypad Button 7 (Right Bumper) = Start Playback Forward & Speed up on multiple presses

Joy7::

Send, l
return
