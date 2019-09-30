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



; Instant Application Switching
; =============================

; Joystick Shortcuts
; ==================



; Joypad Button 9 (Select) = Chrome toggl Instant Button

Joy9::

; If Chrome does not exist run it
IfWinNotExist, ahk_exe chrome.exe
	Run, chrome.exe



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

; If Vegas 13 is active do the following
#IfWinActive ahk_exe VEGAS130.exe

; Keyboard Shortcuts
; ==================



; Control 1 = import IMG sequence

^1::
Send, ^o
Send, ^v
Sleep, 100
Send, {Enter}
Sleep, 200
Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Right}{Left}
Sleep, 200
; Search for Image Sequence Check Box
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, ImageSequence.png
If(ErrorLevel == 0){
Click, %foundX%, %foundY%
}else{
MsgBox, Image Sequence Image not found.
}
Sleep, 100
Send, {Tab}{Tab}{Tab}{Enter}
return



; Control 2 = reverse selected clip (must be selected with timeline cursor over the media object)

^2::
Send, +{F10}
Send, r
return



; Control 3 = Restore clip and make it match source object

^3::
MouseClick, right
Send, r
Sleep, 600
; Search for the position diamond image
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, PositionMask.png
If(ErrorLevel == 0){
Click, %foundX%, %foundY%
}else{
MsgBox, Position Diamond Image not found.
}
Click,
MouseMove, 200, -200, 0, R ; move the mouse relative to its current position on the X-axis
MouseClick, right
Sleep, 600
; Search for the Restore Text Imgae
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, Restore.png
If(ErrorLevel == 0){
Click, %foundX%, %foundY%
}else{
MsgBox, Restore Text Image not found.
}
Click,
MouseClick, right
Sleep, 600
; Search for the Match Output Aspect Text Imgae
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, MatchOutputAspect.png
If(ErrorLevel == 0){
Click, %foundX%, %foundY%
}else{
MsgBox, Match Output Aspect Text Image not found.
}
Click,
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



; Joypad Button 1

;Joy1::
;return



; Joypad Button 2

Joy2::
Send, ^l
return





; ==============================================================================

; If Adobe After Effects is active do the following
#IfWinActive ahk_exe AfterFX.exe

; Keyboard Shortcuts
; ==================



; Control 1 = Export IMG sequence

^1::
Send, ^m
Sleep, 100
; Search for Lossless Render Output Module
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, Lossless.png
If(ErrorLevel == 0){
Click, %foundX%, %foundY%
}else{
MsgBox, Render Output Module Image not found.
}
Sleep, 600
; Search for AVI Format
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, Avi.png
If(ErrorLevel == 0){
Click, %foundX%, %foundY%
}else{
MsgBox, Format Image not found.
}
Send, {Down}{Down}{Down}{Down}{Down}{Down}{Enter}
Sleep, 600
; Search for PNG Channels
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, Rgb.png
If(ErrorLevel == 0){
Click, %foundX%, %foundY%
}else{
MsgBox, Channel Image not found.
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



; Joypad Button 1

;Joy1::
;return



; Joypad Button 3 = Closes the current tab.

Joy3::
Send, ^w
return



; Joypad Button 4 = Reopens the last tab you've closed

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
