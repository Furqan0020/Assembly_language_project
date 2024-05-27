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
	taskPrompt byte "enter your task name",0
	lengthPrompt byte "your task length is : ",0
	pushPrompt byte " Enter successfully in list. ",0
	outputPrompt byte "OutPut of taks Menu ", 0
	bracketPrompt byte " ) ",0
	value dword ?
	byteCount dword ?
	taskArray byte 40 Dup(?)
	againMSG BYTE 0Ah,0Dh,"Do you want to run again (Y/N) : ",0
	op BYTE ?

	

.code
main PROC
startLB:
		mov edx, offset projectName
		call writeString
		call crlf

		call menu

		mov edx , offset prompt
		call writeString
		call readInt
		mov value , eax
		cmp value , 4
		jae L1
		cmp value , 4
		jb L2
		L1:
			mov edx, offset errorPrompt	
			call writeString
			call crlf
			jmp againLB


		L2:
			cmp value , 1
			je L3
			ret
		L3:
			mov edx, offset taskPrompt	
			call writeString
			call crlf
			mov edx, offset taskArray
			mov ecx , sizeof taskArray
			call readString
			mov byteCount , eax
			mov edx, offset lengthPrompt
			call writeString
			call writeDec
			call crlf
			mov edx , offset pushPrompt
			call writeString
			call crlf
			call printList
			jmp againLB

			ret
			againLB:
				mov edx, offset againMSG
				call WriteString

				call ReadChar
				call WriteChar
				call Crlf
		
				mov op, al
				cmp op, 'Y'
				je startLB
				cmp op, 'y'
				je startLB

	ExitLB:


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

	printList proc
		mov edx, offset outputPrompt
		call writeString
		call crlf
		mov esi , 0
		mov eax, 0
		mov eax, esi
		Inc eax
		call writeDec
		mov ecx, lengthOf taskArray
		mov edx, offset bracketPrompt
		call writeString
		counter:
		
			mov al , taskArray[esi]
			inc esi
			call writeChar
			Loop counter
			ret
	printList endp
END main
