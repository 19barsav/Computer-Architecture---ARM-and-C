.data


.text

.global life

//
// life iteration calculator
// x0 - int *cells
// w1 - int width in words
// w2 - int height in rows
//
life: 
  stp x29, x30, [sp, #-16]!   // Push fp and lr onto the stack
  stp x19, x20, [sp, #-16]!
  stp x21, x22, [sp, #-16]!
  stp x23, x24, [sp, #-16]!
  stp x25, x26, [sp, #-16]! 

  i .req w19
  w_h_32 .req w20
  o_g_cells .req x21
  width .req w22
  total .req w23
  size .req w24
  new_array .req x25

  mov size, w2
  mov total, #0
  mov o_g_cells, x0 //save cells array
  mov i, #0  //init i to 0
  mov width, w1

  mul w7, width, size // width * height
  lsl w_h_32, w7, #5  // width*height*32
  
  //calloc
  mov w0, w7
  mov x1, #4
  bl calloc  
  mov new_array, x0

  b looper

looper:
  cmp i, w_h_32
  beq life_ret  


  add i, i, #1 ///increment loop



life_ret:
  mul w7, width, size  //width * size
  mov x0, o_g_cells //dest = o_g
  mov x1, new_array // source = new_array
  mov w2, w7
  bl memcpy  // x0 = o_g
  mov o_g_cells, x0 //mov back
  mov x0, new_array // free new_array
  bl free
  mov x0, o_g_cells  //return edited og

  ldp x25, x26, [sp], #16
  ldp x23, x24, [sp], #16
  ldp x21, x22, [sp], #16
  ldp x19, x20, [sp], #16
  ldp x29, x30, [sp], #16

	ret

  .unreq i
  .unreq width
  .unreq w_h_32
  .unreq o_g_cells
	.unreq size
  .unreq total
  .unreq new_array

