//
//This function implements the
//unbounded/bounded determinationfor some point
//on a graph. It is a function used to create a "burning ship"
//image
//

.data

.balign 8 
x: .double 0
y: .double 0
four: .double 4
zero: .double 0
two: .double 2
.text
.global ship

ship:
  stp x29, x30, [sp, #-16]!

  mov w2, #0 //int iteration
  ldr x3, =x
  ldr d3, [x3] //d3 = x
  ldr x4, =y
  ldr d4, [x4]  //d4 = y

while:

  fmul d5, d3, d3 //d5 = x^2
  fmul d6, d4, d4 //d6 = y^2
  //d7 while cond
  fadd d7, d5, d6
  //d16 = four
  ldr x16, =four
  ldr d16, [x16]
  fcmp d7, d16 //first half of while loop
  bge done
  cmp w2, #255   //second half of while loop
  bge done
  
  //if statement for x 
  ldr x17, =zero
  //x17 = 0
  ldr d17, [x17]
  fcmp d3, d17
  blt x_neg

  //y if statement
mid_while:
  fcmp d4, d17
  blt y_neg
//after if-statements, still in while
mid_while2:
  //calculat xn1
  fsub d18, d5, d6 
  fadd d18, d18, d0
  //calcualte yn1
  fmul d19, d3, d4
  ldr x20, =two
  ldr d20, [x20]
  fmul d19, d19, d20 
  fadd d19, d19, d1
  //set x and y equal to xn1 and yn1, respectfully
  fmov d3, d18
  fmov d4, d19 
  b end_loop

//makes x a negative for if statement
x_neg:
  fneg d3, d3
  b mid_while
//makes y a negative for if-statement
y_neg:
  fneg d4, d4
  b mid_while2
  
//end of while loop, increments counter and goes back up
end_loop:
  add w2, w2, #1
  b while

//release stack and return the counter
done:
  ldp x29, x30, [sp], #16
  mov w0, w2
  ret
  
