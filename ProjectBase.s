.data
Red: .word 0xff0011
Yellow: .word 0xf2fa07
Blue: .word 0x070bfa
Green: .word 0x0bfa07
Black: .word 0x0f0f0f
select: .string "Please Select A Colour\n"
PromptD: .string "Please Enter 1 to play again or 0 to Exit "
PromptC: .string "Incorrect Pattern Entry\n"
Success: .string "SUCCESSS YOU GOT IT RIGHT!\n"
sequence:  .byte 0,0,0,0


.globl main
.text

main:
  
    li x29, 0 
    la x7, sequence
    li x30, 4
    
    WHILE:
        
        beq x29 x30 COLOUR
        
            jal rand
            
            remu a0, a0, x30
            
            sw a0, 0(x7)
            
            li a7 1
            ecall
            addi x7, x7, 4
            addi x29, x29, 1
    
            j WHILE
        
        
    COLOUR:
        
        li t4, 0
        li x14 4
        li x15 1
        li x16 2
        li t6 3
        la t5, sequence
        
        WHILE2:
            
            beq t4, x14 INPUT
            
            lw a0 0(t5)
            
            beq a0, zero, first
            
            beq a0, x15, second
            
            beq a0, x16, third
            
            beq a0, t6, fourth
            
            first:
                
                lw a0, Yellow
                li a1 0
                li a2 0
                jal setLED
                li a0 500
                jal delay
                lw a0, Black
                li a1 0
                li a2 0
                jal setLED
                addi t5, t5, 4
                addi t4, t4, 1
                
                li a0 1000
                jal delay
                j WHILE2
                
            second:
               
                lw a0, Blue
                li a1 1
                li a2 0
                jal setLED
                li a0 500
                jal delay
                lw a0, Black
                li a1 1
                li a2 0
                jal setLED
                addi t5, t5, 4
                addi t4, t4, 1
                li a0 1000
                jal delay
                j WHILE2                
                
                
            third:
                
                lw a0, Red
                li a1 0
                li a2 1
                jal setLED
                li a0 500
                jal delay
                lw a0, Black
                li a1 0
                li a2 1
                jal setLED
                addi t5, t5, 4
                addi t4, t4, 1
                li a0 1000
                jal delay
                j WHILE2           
                
            fourth:
                
                lw a0, Green
                li a1 1
                li a2 1
                jal setLED
                li a0 500
                jal delay
                lw a0, Black
                li a1 1
                li a2 1
                jal setLED
                addi t5, t5, 4
                addi t4, t4, 1
                li a0 1000
                jal delay
                
                j WHILE2               
                
                
            

    INPUT:
        
        li t4, 0
        li x14 4
        li x15 1
        li x16 2
        #li t6 3
        la t5, sequence
        
        WHILE3:
            
            beq t4 x14 success
            
            lw t6 0(t5)
            
            li a7 4
            
            la a0 select
            
            ecall
            
            jal pollDpad
            
            beq a0, zero, first2
            
            beq a0, x15, second2
            
            beq a0, x16, third3
            
                mv t3 a0
                lw a0, Green
                li a1 1
                li a2 1
                jal setLED
                li a0 500
                jal delay
                lw a0, Black
                li a1 1
                li a2 1
                jal setLED
                addi t5, t5, 4
                addi t4, t4, 1

                beq t3 t6 WHILE3
                
                li a7 4
                la a0 PromptC
                ecall
                
                j AFTER
            

            first2:
                
                mv t3 a0
                lw a0, Yellow
                li a1 0
                li a2 0
                jal setLED
                li a0 500
                jal delay
                lw a0, Black
                li a1 0
                li a2 0
                jal setLED
                addi t5, t5, 4
                addi t4, t4, 1
                
                beq t3 t6 WHILE3
                
                li a7 4
                la a0 PromptC
                ecall
                
                j AFTER
                
                
            second2:
                
                mv t3 a0
                lw a0, Blue
                li a1 1
                li a2 0
                jal setLED
                li a0 500
                jal delay
                lw a0, Black
                li a1 1
                li a2 0
                jal setLED
                addi t5, t5, 4
                addi t4, t4, 1

                beq t3 t6 WHILE3
                li a7 4
                la a0 PromptC
                ecall
                
                j AFTER
                
            third3:
                
                mv t3 a0
                lw a0, Red
                li a1 0
                li a2 1
                jal setLED
                li a0 500
                jal delay
                lw a0, Black
                li a1 0
                li a2 1
                jal setLED
                addi t5, t5, 4
                addi t4, t4, 1

                beq t3 t6 WHILE3
                li a7 4
                la a0 PromptC
                ecall
                
                j AFTER
     
    success:
        
        li a7 4
        la a0 Success
        
        ecall
        
        j AFTER
     
    AFTER:
        
        li a7 4
        
        la a0 PromptD
        
        ecall
        
        call readInt
        
        bne a0 zero main
        
        j exit
        
     
    exit:
        
        li a7, 10
        ecall
    
    
# --- HELPER FUNCTIONS ---
# Feel free to use (or modify) them however you see fit

# readInt function from CSC258 Labs

readInt:
    addi sp, sp, -12
    li a0, 0
    mv a1, sp
    li a2, 12
    li a7, 63
    ecall
    li a1, 1
    add a2, sp, a0
    addi a2, a2, -2
    mv a0, zero
parse:
    blt a2, sp, parseEnd
    lb a7, 0(a2)
    addi a7, a7, -48
    li a3, 9
    bltu a3, a7, error
    mul a7, a7, a1
    add a0, a0, a7
    li a3, 10
    mul a1, a1, a3
    addi a2, a2, -1
    j parse
parseEnd:
    addi sp, sp, 12
    ret

error:
    li a7, 93
    li a0, 1
    ecall
     
# Takes in the number of milliseconds to wait (in a0) before returning
delay:
    mv t0, a0
    li a7, 30
    ecall
    mv t1, a0
delayLoop:
    ecall
    sub t2, a0, t1
    bgez t2, delayIfEnd
    addi t2, t2, -1
delayIfEnd:
    bltu t2, t0, delayLoop
    jr ra

# Takes in a number in a0, and returns a (sort of) random number from 0 to
# this number (exclusive)
rand:
    mv t0, a0
    li a7, 30
    ecall
    remu a0, a0, t0
    jr ra
    
# Takes in an RGB color in a0, an x-coordinate in a1, and a y-coordinate
# in a2. Then it sets the led at (x, y) to the given color.
setLED:
    li t1, LED_MATRIX_0_WIDTH
    mul t0, a2, t1
    add t0, t0, a1
    li t1, 4
    mul t0, t0, t1
    li t1, LED_MATRIX_0_BASE
    add t0, t1, t0
    sw a0, (0)t0
    jr ra
    
# Polls the d-pad input until a button is pressed, then returns a number
# representing the button that was pressed in a0.
# The possible return values are:
# 0: UP
# 1: DOWN
# 2: LEFT
# 3: RIGHT
pollDpad:
    mv a0, zero
    li t1, 4
pollLoop:
    bge a0, t1, pollLoopEnd
    li t2, D_PAD_0_BASE
    slli t3, a0, 2
    add t2, t2, t3
    lw t3, (0)t2
    bnez t3, pollRelease
    addi a0, a0, 1
    j pollLoop
pollLoopEnd:
    j pollDpad
pollRelease:
    lw t3, (0)t2
    bnez t3, pollRelease
pollExit:
    jr ra
