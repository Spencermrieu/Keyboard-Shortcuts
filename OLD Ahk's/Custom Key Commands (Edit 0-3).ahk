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



; Control 6 = Return clip speed to 100%
Joy2::
Send, +{F10}
Send, p
Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}
Send, 1.0{enter}
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
Sleep, 100
Send, ^v ; This can be removed if you do not want it to past the folder path for you
Send, {Enter}
Sleep, 400
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
