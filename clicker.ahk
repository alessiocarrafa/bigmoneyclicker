ButtonCount = 10
ButtonsDelta = 45
ButtonsX = 685

TimeBetweenButtons = 1500
TimeBeforeConfirm = 4000
TimeGoogleRobot = 5000
TimeAfterConfirm = 1500

googleDialogX = 860
googleDialogY = 655

googleCheckboxX = 735
googleCheckboxY = 735

ConfirmX = 970
ConfirmY = 810

activeColor = 0x87B52A
inactiveColor = 0x666248

^y::

	while(true)
	{
		; focus on chrome window
		winactivate ahk_exe chrome.exe

		; starting Y position
		FirstButtonY = 335
		
		; loop foreach button
		Loop, %ButtonCount% {
			
			; get current button color
			PixelGetColor, color, %ButtonsX%, %FirstButtonY%

			; check if actual button is active
			if color = %activeColor%
			{
				; click for claim
				Click, %ButtonsX%, %FirstButtonY%
				; wait for eventual google dialog captcha verification
				Sleep, %TimeBeforeConfirm%

				; get color of google's dialog top bar
				PixelGetColor, color, %googleDialogX%, %googleDialogY%

				; if color is active
				if color = %activeColor%
				{
					; check google captcha checkbox
					Click %googleCheckboxX%, %googleCheckboxY%
					; wait some time for google response
					Sleep, %TimeGoogleRobot%
					; click on confirm button
					Click %ConfirmX%, %ConfirmY%
					; wait for dialog hide
					Sleep, %TimeAfterConfirm%
				}

				; should hide google captcha dialog if something went wrong
				Send {Esc}

				; sleep before next check
				Sleep, %TimeBetweenButtons%
			}

			; increase mouse Y, going on next button
			FirstButtonY += ButtonsDelta
		}

	}

	ExitApp

return

^e::
	MsgBox, Script Alted!
	ExitApp
return