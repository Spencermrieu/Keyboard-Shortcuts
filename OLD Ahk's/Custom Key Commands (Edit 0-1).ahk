
; If Vegas 13 is active do the following
#IfWinActive ahk_exe VEGAS130.exe

; Control 1 = import IMG sequence
^1::
Send, ^o
Send, ^v
Sleep, 100
Send, {Enter}
Sleep, 200
Send, {Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}{Right}{Left}
Sleep, 200
PixelSearch, Px, Py, 0, 0, 1920, 1080, 0xD26660, 0, Fast ;Searches the screen
if ErrorLevel
MsgBox, That color was not found in the specified region. ; if it errors send message box, otherwise clock specified color we searched for
else
   click %Px%, %Py%
Sleep, 200
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






; If Adobe After Effects is active do the following
;#IfWinActive ahk_exe AfterFX.exe



F1::
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, CustomPNGSequence.png
If(ErrorLevel == 0){
Click, %foundX%, %foundY%
}else{
MsgBox, Image not found.
}
return
