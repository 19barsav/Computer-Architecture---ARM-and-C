.text
.global set_bit


//
// Get a bit from an array of words.
// x0 - Array of integers
// w1 - Width of the array in bits
// w2 - Desired bit
// w3 - 1 if bit is to be set
//
set_bit:

  	stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
    stp x19, x20, [sp, #-16]!
  
    cmp w2, #0
    blt set_0_ret
    cmp w2, w1
    bge set_0_ret
   
    lsr w4, w2, #5   // Determine the word
    and w5, w2, #0x1f  // Bit index
 
    lsl w7, w4, #2       // word * 4 = w7
    ldr x6, [x0, w7, uxtw] // data + word * 4 = w6 //loads word
    
    mov w2, #31
    sub w5, w2, w5     // 31 - bit = w5
    
   
    cmp w3, #0   //set 0
    beq set_to_0    

    mov w1, #1          //set 1
    lsl w1, w1, w5
    orr w6, w6, w1
    str w6, [x0, w7, uxtw]
    
    b set_bit_done
    
set_to_0:
    mov w1, #1
    lsl w1, w1, w5
    bic w6, w6, w1 
    str w6, [x0, w7, uxtw]
       
    b set_bit_done
    
set_0_ret:
    mov x0, #0
    b set_bit_done
    
set_bit_done:

    ldp x19, x20, [sp], #16 
    ldp x29, x30, [sp], #16     // Restore fp and lr from the stack  
    ret     

