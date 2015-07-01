#########################################
#       ������ ��� ������ ������        #
#########################################							
.macro	PutString	string = "\r\n",  color = 0x0007			
		jmp		3f						#
1:										#
		.ascii	"\string" 				#
		sizeof_string = (. - 1b)		#
3:										#
		mov 	$0x300, %ax				# get cursor position
		xor 	%bx, %bx				#
		int 	$0x10					#
		
		mov		$0x1301, %ax			# 13-�� �������, 
		mov		$\color,  %bx			#
		mov		$sizeof_string, %cx		# ����� ������
		push	%cs						#
		pop		%es						# 
		mov		$1b, %bp				# es:bp <- ��������� �� ������
		int 	$0x10					#
.endm 									#
#########################################


######################################### �� � ��� �� ��� ����? :)
#              ������ ����              #
#########################################	
PrintOsLogo:
		mov	$0x0003, %ax
		int	$0x10
		
		PutString	"������������������������������������������������������������������������������ͻ", 0x000A # green
		PutString	"�     8888888 888     888         .d8888b.         .d88888b.   .d8888b.        �", 0x000A # green 
		PutString	"�       888   888     888        d88P  Y88b       d88P` `Y88b d88P  Y88b       �", 0x000E # yellow 
		PutString	"�       888   888     888        888    888       888     888 Y88b.            �", 0x0006 # brown 
		PutString	"�       888   888     888        Y88b. d888       888     888  `Y888b.         �", 0x0004 # red
		PutString	"�       888   888     888         `Y888P888       888     888     `Y88b.       �", 0x000C # bright red
		PutString	"�       888   888     888 888888        888       888     888       `888       �", 0x000D # bright magenta
		PutString	"�       888   Y88b. .d88P        Y88b  d88P       Y88b. .d88P Y88b  d88P       �", 0x0005 # magenta  
		PutString	"�     8888888  `Y88888P`          `Y8888P`         `Y88888P`   `Y8888P  ver 0.1�", 0x0009 # bright blue
		PutString	"������������������������������������������������������������������������������ͼ\r\n", 0x000A #   
		PutString	"Well, this is not an operating system at all... \r\n   ...but I like how this logo looks like! \r\n\n", 0x0007 #  
		PutString	"--> Hit enter to switch to the protected mode.\r\n", 0x0007

		ret
#########################################


#########################################
#       �������� ������� �������        #
#########################################
WaitKey:								#
		mov		$0x13, %ah				# 
		int		$0x16					# Int 16, 13 function: flush KB buffer
.WaitAgain:								#
		xor		%ah, %ah				# No need to save registers here. 
		int		$0x16					# Int 16, 0 function: getchar
		cmp		$0x1C, %ah				# <---- Scancode is     AH now; $0x1C = enter
		jne		.PrintChar				# <---- ASCII symbol is AL now
		ret								#
.PrintChar:								#
		mov		$0x0E, %ah 				# int 10, 0xE function: 
		mov		$0, %bh					# print char (teletype)
		int		$0x10					#
		jmp		.WaitAgain				#
		ret								#
		

#########################################
