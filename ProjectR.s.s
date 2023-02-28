.data
sequence:  .byte 0,0,0,0
count:     .word 4
restart: .string "Correct"
PromptB: .string "Select a colour\n"
PromptC: .string "Incorrect Pattern Entry\n"
PromptD: .string "Please Enter 1 to play again or 0 to Exit\n"
Red: .word 0xff0011
Yellow: .word 0xf2fa07
Blue: .word 0x070bfa
Green: .word 0x0bfa07
Black: .word 0x0f0f0f

.globl main
.text

main:
    # TODO: Before we deal with the LEDs, we need to generate a random
    # sequence of numbers that we will use to indicate the button/LED
    # to light up. For example, we can have 0 for UP, 1 for DOWN, 2 for
    # LEFT, and 3 for RIGHT. Store the sequence in memory. We provided 
    # a declaration above that you can use if you want.
    # HINT: Use the rand function provided to generate each number
    
    begin:
    
    li x29, 0
    lw x6, count
    la x7, sequence
    li x30, 4
    
    WHILE:
        
        beq x29 x6 COLOUR
        
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
            
            beq t4 x14 After
            
            lw t6 0(t5)
            
            li a7 4
            
            la a0 PromptB
            
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
                
                #la a0 restart
                #ecall
                
                j After
            

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
                
                #la a0 restart
                #ecall
                
                j After
                
                
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
                
                #la a0 restart
                #ecall
                
                j After
                
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
                
                #la a0 restart
                #ecall 
                j After
                
            
                    
   
    # TODO: Now read the sequence and replay it on the LEDs. You will
    # need to use the delay function to ensure that the LEDs light up 
    # slowly. In general, for each number in the sequence you should:
    # 1. Figure out the corresponding LED location and colour
    # 2. Light up the appropriate LED (with the colour)
    # 2. Wait for a short delay (e.g. 500 ms)
    # 3. Turn off the LED (i.e. set it to black)
    # 4. Wait for a short delay (e.g. 1000 ms) before repeating
    
    
    # TODO: Read through the sequence again and check for user input
    # using pollDpad. For each number in the sequence, check the d-pad
    # input and compare it against the sequence. If the input does not
    # match, display some indication of error on the LEDs and exit. 
    # Otherwise, keep checking the rest of the sequence and display 
    # some indication of success once you reach the end.


    # TODO: Ask if the user wishes to play again and either loop back to
    # start a new round or terminate, based on their input.
     
     
    After:
        
        li a7 4
        
        la a0 PromptD
        
        ecall
        
        call readInt
        
        beq a0 zero exit
        
        li x29, 0
        lw x6, count
        la x7, sequence
        li x30, 4
        j WHILE
        
     
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
