.section .data 
inputfile: 
.ascii "input.txt\0" 
fd_in: 	
.long 0 
array: 
.fill 32, 1, 0 
.section .text 

.global _start 
_start: 
movl $5, %eax    	    ; # Open the input file 
movl $inputfile, %ebx    	
movl $2, %ecx    		
int $0x80       			 

movl %eax, fd_in  	

movl $3, %eax                  ; # Read the file contents into the array
movl fd_in, %ebx    	
movl $array, %ecx   		 
movl $256, %edx    		
int $0x80        			

movl $0, %edi    	    ; # Reverse the characters pairwise 


loop: 
movb array(%edi), %al    		
cmpb $0, %al   			
je done 
add $1, %edi		; # Small change addi to add
movb array(%edi), %ah   		 
cmpb $0, %ah    			
je done 
xchg %al, %ah   			 
movb %al, array-1(%edi) 
movb %ah, array(%edi) 
addl $1, %edi   			 
jmp loop 

done: 
movl $4, %eax             ; # Write the reversed contents to stdout
movl $1, %ebx    			
movl $array, %ecx    			
movl %edi, %edx    			
int $0x80        				

movl $6, %eax              ; # Close the input file 		
movl fd_in, %ebx   		 
int $0x80        				

movl $1, %eax   	; # Exit the program      			
int $0x80 
