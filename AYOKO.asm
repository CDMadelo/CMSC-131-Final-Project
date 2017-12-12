IDEAL
MODEL small
STACK 0f500h
p186

;variables
MAX_BMP_WIDTH = 320 
MAX_BMP_HEIGHT = 200  
SMALL_BMP_HEIGHT = 40 
SMALL_BMP_WIDTH = 40
;-------------------------------------------------------------
DATASEG

; One Color line read buffer
OneBmpLine		db MAX_BMP_WIDTH dup (0)  

; One Color line read buffer
ScreenLineMax 	db MAX_BMP_WIDTH dup (0)  

;BMP File data
FileHandle		dw ?
Header 	    	db 54 dup(0)
Palette 		db 400h dup (0)
ErrorFile       db 0
BmpLeft 		dw ?
BmpTop 			dw ?
BmpColSize 		dw ?
BmpRowSize 		dw ?	

;pictures
titlescreen DB 'title.bmp', 0		
howtopic	DB 'intro.bmp', 0
playpic 	DB 'gamready.bmp', 0
gamedone	DB 'gameover.bmp', 0
congrats	DB 'congrats.bmp', 0
gameone		DB 'game1.bmp', 0
gametwo		DB '2.bmp', 0
gamethree	DB '3.bmp', 0
gamefour	DB '4.bmp', 0
gamefive	DB '5.bmp', 0
gamesix		DB '6.bmp', 0
g7			DB '7.bmp', 0
g8			DB '8.bmp', 0
g9			DB '9.bmp', 0
g10			DB '10.bmp', 0
g11			DB '11.bmp', 0

;scores for highscore
zero		DB 'zero.bmp', 0
ten			DB 'ten.bmp', 0
twenty		DB 'twenty.bmp', 0
thirty		DB 'thirty.bmp', 0
fourty		DB 'fourty.bmp', 0
fifty		DB 'fifty.bmp', 0
sixty		DB 'sixty.bmp', 0
seventy		DB 'seventy.bmp', 0
eighty		DB 'eighty.bmp', 0
ninety		DB 'ninety.bmp', 0
hundred		DB 'hundred.bmp', 0

;answers for comparison
ans1	DB 'happened'		;8
ans2	DB 'selfish'		;7
ans3	DB 'yourself'		;8
ans4	DB 'change'			;6
ans5	DB 'deserve'		;7
ans6	DB 'glitter'		;7
ans7	DB 'mystery'		;7
ans8	DB 'manners'		;7
ans9	DB 'imagine'		;7
ans10	DB 'alone'			;6
ans11	DB 'labda'			;5

;inputs
input1	DB 20 dup('$') 	
var		DB 0
highvar	DB 0
;-----------------------------------------------------------
CODESEG
start:
	mov ax, @data
	mov ds, ax

	;sets the location of the bmp image
	call SetGraphic 			
	mov [BmpLeft], 0
	mov [BmpTop], 0

	;default image size
	mov [BmpColSize], 320
	mov [BmpRowSize], 200

menu:								;main menu
	mov dx,offset titlescreen		;shows the menu image	
	call OpenShowBmp 				;this procedure opens the bmp image
	call easyinput					;procedure for getting input

	cmp al, '1'				;instructions picture
	je howto
	cmp al, '2'				;highscore
	je toscorecomp
	cmp al, '3'				;exit
	je exit

	;enter key				;enter game
	cmp al, 13

	je play
	jne menu

toscorecomp:
	jmp finalscore

exit:
	call exitgame

howto:
								;display how to play picture
	mov dx, offset howtopic		;shows the game instructions	
	call OpenShowBmp
	call easyinput
	cmp al, 13					;enter key
	je menu


play:
								;display game ready picture
	mov dx, offset playpic		;shows the get ready bmp image	
	call OpenShowBmp
	call easyinput
	cmp al, 13					;enter key
	je firstgame

firstgame:
	mov [var], 0				;sets the score counter to 0
	mov dx, offset gameone 		;shows the first question bmp image
	call OpenShowBmp
	call setcursor				;sets the cursor to where the user can input the answer
	call getinput
	cld							;clear direction flag (left to right)
	mov cx, 8					;length of the first word
	lea di, [input1]			;receiving address
	lea si, [ans1]				;sending address

	call iterate				;checks if strings are equal
	je secondgame

secondgame:
	inc [var]					;increments variable to raise the score, score is now 10
	mov dx, offset gametwo		;shows the second question bmp image
	call OpenShowBmp
	call setcursor
	call getinput
	cld
	mov cx, 7					;length of the second word
	lea di, [input1]			;receiving address
	lea si, [ans2]				;sending address

	call iterate				;checks if strings are equal
	je thirdgame

thirdgame:
	inc [var]					;increments variable to raise the score, score is now 20
	mov dx, offset gamethree	;shows the third question bmp image
	call OpenShowBmp
	call setcursor
	call getinput
	cld
	mov cx, 8					;length of the third word
	lea di, [input1]			;receiving address
	lea si, [ans3]				;sending address

	call iterate				;checks if strings are equal
	je fourthgame

fourthgame:
	inc [var]					;increments variable to raise the score, score is now 30
	mov dx, offset gamefour		;shows the fourth question bmp image
	call OpenShowBmp
	call setcursor
	call getinput
	cld
	mov cx, 6					;length of the fourth word
	lea di, [input1]			;receiving address
	lea si, [ans4]				;sending address

	call iterate				;checks if strings are equal
	je fifthgame

fifthgame:
	inc [var]					;increments the variable to raise the score, score is now 40
	mov dx, offset gamefive		;shows the fifth question bmp image
	call OpenShowBmp
	call setcursor
	call getinput
	cld
	mov cx, 7					;length of the fifth word
	lea di, [input1]			;receiving address
	lea si, [ans5]				;sending address

	call iterate				;checks if strings are equal
	je sixthgame

sixthgame:
	inc [var]					;increments the variable to raise the score, score is now 50
	mov dx, offset gamesix		;shows the sixth question bmp image
	call OpenShowBmp
	call setcursor
	call getinput
	cld
	mov cx, 7					;length of the sixth word
	lea di, [input1]			;receiving address
	lea si, [ans6]				;sending address

	call iterate				;checks if strings are equal
	je seventhgame

seventhgame:
	inc [var]					;increments the variable to raise the score, score is now 60
	mov dx, offset g7			;shows the seventh question bmp image
	call OpenShowBmp
	call setcursor
	call getinput
	cld
	mov cx, 7					;length of the seventh word
	lea di, [input1]			;receiving address
	lea si, [ans7]				;sending address

	call iterate				;checks if strings are equal
	je eighthgame

eighthgame:
	inc [var]					;increments the variable to raise the score, score is now 70
	mov dx, offset g8			;shows the eight question bmp image
	call OpenShowBmp
	call setcursor
	call getinput
	cld
	mov cx, 7					;length of the eight word
	lea di, [input1]			;receiving address
	lea si, [ans8]				;sending address

	call iterate				;checks if strings are equal
	je ninthgame


ninthgame:
	inc [var]					;increments the variable to raise the score, score is now 80
	mov dx, offset g9 			;shows the ninth question bmp image
	call OpenShowBmp
	call setcursor
	call getinput
	cld
	mov cx, 7					;length of the ninth word
	lea di, [input1]			;receiving address
	lea si, [ans9]				;sending address

	call iterate				;checks if strings are equal
	je tenthgame

tenthgame:
	inc [var]					;increments the variable to raise the score, score is now 90
	mov dx, offset g10 			;shows the tenth question bmp image
	call OpenShowBmp
	call setcursor
	call getinput
	cld
	mov cx, 5					;length of the tenth word
	lea di, [input1]			;receiving address
	lea si, [ans10]				;sending address

	call iterate				;checks if strings are equal
	je elevengame

elevengame:
	inc [var]					;increments the variable to raise the score, score is now 100
	mov dx, offset g11			;shows the eleventh question bmp image
	call OpenShowBmp
	call setcursor
	call getinput
	cld
	mov cx, 5					;length of the eleventh word
	lea di, [input1]			;receiving address
	lea si, [ans11]				;sending address

	call iterate				;checks if the string equal
	je showcongrats


showcongrats:
	mov dx, offset congrats		;show the congrats bmp image once user completes the game	
	call OpenShowBmp
	call easyinput
	jmp menu	

gameover:
	mov dx, offset gamedone		;shows the gameover bmp image once the user gives a wrong answer
	call OpenShowBmp
	call easyinput
	jmp menu

finalscore:
	jmp scorecomp				;jumps to procedure that computes the score


zeroscore:
	mov dx, offset zero 		;shows the zero score bmp image
	call OpenShowBmp
	call easyinput
	cmp al, 13					;enter key to return to menu
	je menu2

tenscore:
	mov dx, offset ten 			;shows the ten score bmp image
	call OpenShowBmp
	call easyinput
	cmp al, 13
	je menu2

menu2:
	jmp menu 					;jumps to menu

twentyscore:
	mov dx, offset twenty 		;shows the twenty score bmp image
	call OpenShowBmp
	call easyinput
	cmp al, 13
	je tomenu

thirtyscore:
	mov dx, offset thirty 		;shows the thirty score bmp image
	call OpenShowBmp
	call easyinput
	cmp al, 13
	je tomenu

fourtyscore:
	mov dx, offset fourty 		;shows the fourty score bmp image
	call OpenShowBmp
	call easyinput
	cmp al, 13
	je tomenu

scorecomp:						;score procedure
	mov al, [var]				;will compare high score with current score if 
								;current score > high score
	cmp al, [highvar]		
	jg toreplace				;jumps to replace procedure

scorefinal:						;comparing of scores and will display its corresponding bmp image
	cmp [highvar], 0			
	je zeroscore
	cmp [highvar], 1
	je tenscore
	cmp [highvar], 2
	je twentyscore
	cmp [highvar], 3
	je thirtyscore
	cmp [highvar], 4
	je fourtyscore
	cmp [highvar], 5
	je fiftyscore
	cmp [highvar], 6
	je sixtyscore
	cmp [highvar], 7
	je seventyscore
	cmp [highvar], 8
	je eightyscore
	cmp [highvar], 9
	je ninetyscore
	cmp [highvar], 10
	je hundredscore
	call easyinput
	cmp al, 13
	je tomenu

tomenu:
	jmp menu 					;jumps back to menu

toreplace:
	call replace 				;jumps to replace procedure
	jmp scorefinal


fiftyscore:
	mov dx, offset fifty 		;shows the fifty score bmp image
	call OpenShowBmp
	call easyinput
	cmp al, 13
	je tomenu

sixtyscore:
	mov dx, offset sixty 		;shows the sixty score bmp image
	call OpenShowBmp
	call easyinput
	cmp al, 13
	je tomenu

seventyscore: 
	mov dx, offset seventy  	;shows the seventy score bmp image
	call OpenShowBmp
	call easyinput
	cmp al, 13
	je tomenu

eightyscore:
	mov dx, offset eighty 		;shows the eighty score bmp image
	call OpenShowBmp
	call easyinput
	cmp al, 13
	je tomenu

ninetyscore:
	mov dx, offset ninety       ;shows the ninety score bmp image
	call OpenShowBmp
	call easyinput
	cmp al, 13
	je tomenu

hundredscore:
	mov dx, offset hundred 		;shows the hundred score bmp image
	call OpenShowBmp
	call easyinput
	cmp al, 13
	je tomenu

gameoverr:
	jmp gameover 				;jumps to game over		
;-------------------------------------------	
proc replace near				;this procedure replaces the highscore with the current score
	mov al, [highvar]			
	mov al, [var]
	mov [highvar], al
	ret
endp replace
;-------------------------------------------
proc easyinput near				;this procedure gets input from user
	mov ah, 7
	int 21H
	ret
endp easyinput
;-------------------------------------------
proc setcursor near				
	MOV AH, 02H   				;function code to request for set cursor
	MOV BH, 00    				;page number 0, i.e. current screen
	MOV DH, 23    				;set row
	MOV DL, 14    				;set column
	INT 10H
	ret
endp setcursor
;-------------------------------------------
proc iterate near			 	;this procedure checks if the two strings are equal
	repeat:
		mov al, [si]
		mov ah, [di]
		cmp al, ah
		jne gameoverr
		inc si
		inc di
		loop repeat
		ret
endp iterate
;-------------------------------------------
proc exitgame near				;this procedure exits the game
	mov ax, 2
	int 10h
	MOV AH, 4CH
  	INT 21H
endp exitgame
;-------------------------------------------
proc getinput near				;this procedure gets input from user
	mov ah, 3fh
	mov bx, 00
	mov cx, 15
	lea dx, [input1]
	int 21h
	ret
endp getinput
;-------------------------------------------
proc OpenShowBmp near			;this procedure will display the bmp image
	push cx
	push bx
	call OpenBmpFile
	cmp [ErrorFile], 1
	je @@ExitProc
	call ReadBmpHeader
	call ReadBmpPalette
	call CopyBmpPalette 
	call ShowBMP 
	call CloseBmpFile
	@@ExitProc:
	pop bx
	pop cx
ret
endp OpenShowBmp
;-------------------------------------------	
proc OpenBmpFile	near		;this procedure opens the bmp image			 
	mov ah, 3Dh
	xor al, al
	int 21h
	jc @@ErrorAtOpen
	mov [FileHandle], ax
	jmp @@ExitProc	
@@ErrorAtOpen:
	mov [ErrorFile],1
@@ExitProc:	
ret
endp OpenBmpFile
;-------------------------------------------
proc CloseBmpFile near			;this procedure closes the bmp image
	mov ah,3Eh
	mov bx, [FileHandle]
	int 21h
ret
endp CloseBmpFile
;-------------------------------------------
proc ReadBmpHeader	near		;this procedure reads the bmp Header			
	push cx
	push dx
	mov ah,3fh
	mov bx, [FileHandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	pop dx
	pop cx
ret
endp ReadBmpHeader
;-------------------------------------------
proc ReadBmpPalette near 		;this procedure reads the bmp Palette
	push cx
	push dx
	mov ah,3fh
	mov cx,400h
	mov dx,offset Palette
	int 21h
	pop dx
	pop cx
ret
endp ReadBmpPalette
;-------------------------------------------
proc CopyBmpPalette near		;this procedure copies the bmp Palette					
	push cx
	push dx
	mov si,offset Palette
	mov cx,256
	mov dx,3C8h
	mov al,0  							
	out dx,al 
	inc dx	  
CopyNextColor:
	mov al,[si+2] 						
	shr al,2 							
	out dx,al 						
	mov al,[si+1] 						
	shr al,2            
	out dx,al 							
	mov al,[si] 						
	shr al,2            
	out dx,al 							
	add si,4 						
	loop CopyNextColor
	pop dx
	pop cx
ret
endp CopyBmpPalette
;-------------------------------------------
proc ShowBMP 					;this procedure shows the bmp image
	push cx
	mov ax, 0A000h
	mov es, ax
	mov cx,[BmpRowSize]
	mov ax,[BmpColSize] 		
	xor dx,dx
	mov si,4
	div si
	mov bp,dx
	mov dx,[BmpLeft]
@@NextLine:
	push cx
	push dx
	mov di,cx 					
	add di,[BmpTop] 			
	mov cx,di
	shl cx,6
	shl di,8
	add di,cx
	add di,dx
	mov ah,3fh
	mov cx,[BmpColSize]  
	add cx,bp  					 
	mov dx,offset ScreenLineMax
	int 21h
	cld 
	mov cx,[BmpColSize]  
	mov si,offset ScreenLineMax
	rep movsb 					;Copy line to the screen
	pop dx
	pop cx
	loop @@NextLine
	pop cx
ret
endp ShowBMP 
;-------------------------------------------
proc  SetGraphic
	mov ax,13h   ; 320 X 200 
	int 10h
ret
endp SetGraphic
END start