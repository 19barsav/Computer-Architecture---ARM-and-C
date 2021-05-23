//
// Data Section
//
.data 
msg1: .asciz "\n All Perfect numbers from 1 to 10000: \n\n"
msg2: .asciz "Perfect: %d\n"


//
// Text section
//

.text

.global main

//
// main(argc, argv)
// w0: The number of arguments
// x1: Pointer to an array of string pointers
//
main:
  fp .req x29
  lr .req x30  

  .equ number, 16
  .equ divisor, 24
  .equ sum, 32
  .equ size, 48   // Must be a multiple of 16!
     
  stp fp, lr, [sp, #-size]!
  mov fp, sp
  ldr x0, =msg1
  bl printf
  mov x0, #1
  str x0, [fp, #number]
  b for_loop_one_init


//grab number and compare to 10000
for_loop_one_init:
  ldr x0, [fp, #number]
  mov x1, #10000
  cmp x0, x1
  //got to return if number is greater than 10000
  bgt main_return
  
  //initilize sum to 0
  str xzr, [fp, #sum]
  //initilize divisor to 1
  mov x0, #1
  str x0, [fp, #divisor]

//second for loop
for_loop_two:
  ldr x0, [fp, #number]
  ldr x1, [fp, #divisor]
  cmp x1, x0
  //make sure divisor is not greater than or equal to 0
  bge last_if
  //divide number by divisor
  bl ldiv 
  cmp x1, #0 //if modulus != 0
  bne end_for_loop_two
  
  //mod == 0, so add divisor to sum
  ldr x0, [fp, #sum]
  ldr x1, [fp, #divisor]
  add x0, x0, x1
  str x0, [fp, #sum]


//increment divisor
end_for_loop_two:
  ldr x0, [fp, #divisor]
  add x0, x0, #1
  str x0, [fp, #divisor]
  b for_loop_two
  

last_if:
  ldr x0, [fp, #number]
  ldr x1, [fp, #sum]
  cmp x0, x1
  bne end_for_loop_one

  ldr x0,=msg2
  ldr x1,[fp, #number]
  bl printf

  b end_for_loop_one

end_for_loop_one:
  ldr x0, [fp, #number]
  add x0, x0, #1
  str x0, [fp, number]
  b for_loop_one_init

main_return:
  mov x0, #0
  ldp x29, x30, [sp], #size
  ret

