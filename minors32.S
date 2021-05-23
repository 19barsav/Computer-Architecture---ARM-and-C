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
 * w1 - Number of items in the array
 */
first_minor:

    cmp w1, #0      // set the flags
    beq none        // if x1 == 0
            
    ldr w2, [x0]    // x2 <= *data
    cmp w2, #18     // r2 < 18?
    blt gotit       // If so...
                        
    add x0, x0, #4  // data++
                            
    sub w1, w1, #1  // x1 <- x1 - 1
    b first_minor
                                    
gotit:
    mov w0, w2
    ret
                                            
none:
    mov w0,#0
    ret        
    ret             // return
    

/*
 * Determine the last minor (<18) in an array of numbers
 * x0 - Pointer to the array
 * w1 - Number of items in the array
 */
last_minor:

    mov w0, #0
    ret
	
