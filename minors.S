/*
 * Functions to determine first and last minor 
 * boarding a cruise ship.
 */
 
.text
.global first_minor
.global last_minor


/*
 * Determine the first minor (<18) in an array of numbers
 * x0 - Pointer to the array
 * x1 - Number of items in the array
 */
first_minor:
    cmp x1, #0   // is x1 == 0
    beq none

    ldr x2, [x0]
    cmp x2, #18        //checks if r2 < 18
    blt gotit      

    add x0, x0, #8     //data++

    sub x1, x1, #1  //x--
    b first_minor
none:
    mov x0,#0
    ret             // return
    
gotit:
    mov x0, x2
    ret

/*
 * Determine the last minor (<18) in an array of numbers
 * x0 - Pointer to the array
 * x1 - Number of items in the array
 */
last_minor:
    mov x2, x1      // size
    sub x2, x2, #1  // size-1
    
    lsl x2, x2, #3  // (size-1) * 8
    add x0, x0, x2  // &data[size-1] 

last_minor_loop:
    cmp x1, #0      // Is size==0?    
    beq none_last
                        
    ldr x2, [x0]
    cmp x2, #18
    blt last_gotit
                        
    sub x0, x0, #8
    sub x1, x1, #1
    b last_minor_loop

last_gotit:
    mov x0, x2
    ret
                                            
none_last:
    mov x0, #0
    ret
