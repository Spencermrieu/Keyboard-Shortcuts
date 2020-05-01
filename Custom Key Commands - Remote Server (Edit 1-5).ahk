; ==============================================================================
; Initial Setup
; =============================




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



; Joypad Button 1 (X Button) Sent trough local server = Cut the end of the clip starting at cursor

^+b::

Send, !{]}
return



; Joypad Button 2 (A Button) Sent trough local server = Toggle Auto Ripple

^t::

Send, ^l
return



; Joypad Button 3 (B Button) Sent trough local server = Play or Pause

^w::

Send, {enter}
return



; Joypad Button 4 (Y Button) Sent trough local server =  Cut the begining of the clip starting at cursor

^+t::

Send, !{[}
return



; Joypad Button 5 (Left Bumper) Sent trough local server = Start Playback Backwards & Speed up on multiple presses

^+{tab}::

Send, j
return



; Joypad Button 7 (Right Bumper) Sent trough local server = Start Playback Forward & Speed up on multiple presses

^{tab}::

Send, l
return
