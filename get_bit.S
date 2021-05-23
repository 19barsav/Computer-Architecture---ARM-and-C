.text
.global get_bit


//
// Get a bit from an array of words.
// x0 - Array of integers
// w1 - Width of the array in bits
// w2 - Desired bit
//

get_bit:
    stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
        
    cmp w2, #0
    blt set_0_ret
    cmp w2, w1
    bge set_0_ret
    
    lsr w3, w2, #5   // Determine the word
    and w4, w2, #0x1f  // Bit index
          
    lsl w7, w3, #2       // word * 4 = w7
    ldr w6, [x0, w7, uxtw] // data + word * 4 = w0 

    mov w7, #31
    sub w4, w7, w4      // 31 - bit = w4
    lsr w6, w6, w4     // Shift bit to lowest bit 

    and w6, w6, #1      // And with 1 and return value
    //str w6, [x0, w7, uxtw]
    mov x0, x6
    b get_bit_done

set_0_ret:
    mov x0, #0
    b get_bit_done

get_bit_done:
    ldp x29, x30, [sp], #16     // Restore fp and lr from the stack
    ret    





