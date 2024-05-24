; Program Description:
; Author:
; Creation Date:
; Revisions: 
; Date:              Modified by:

.386
.model flat,stdcall
.stack 4096
INCLUDE irvine32.inc
ExitProcess PROTO, dwExitCode:DWORD
.data
	projectName byte "My TODO List App",0
	addTask byte "press 1 for add tasks in TODO List",0
	removeTask byte "press 2 for remove tasks in TODO List",0
	displayTask byte "press 3 for display tasks in TODO List",0
	prompt byte "enter a number : ",0
	errorPrompt byte "please enter choice between 1-3",0
	value dword ?

.code
main PROC
	mov edx, offset projectName
	call writeString
	call crlf

	call menu

	mov edx , offset prompt
	call writeString
	call readInt
	mov value , eax
	cmp value , 3
	ja L1
	cmp value , 3
	jb L2
	L1:
		mov edx, offset errorPrompt	
		call writeString
		call crlf
	L2:
		ret


	INVOKE ExitProcess,0
main ENDP
; (insert additional procedures here)
menu proc
	mov edx, offset addTask
	call writeString
	call crlf

	mov edx ,offset removeTask
	call writeString
	call crlf

	mov edx , offset displayTask
	call writeString
	call crlf
	ret
	menu EndP
END main
