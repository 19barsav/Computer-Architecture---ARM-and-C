.text
.global perfect_sqr



// Determine if a number is a perfect square.
// x0 - Passed in value: num
//Returns 1 if num is a perfect square.
//@author Savanah B.


perfect_sqr:
    mov x1, #1
    mov x2, #1
    mov x3, #1
    lsl x3, x3, #32
    
    b forloop

forloop:
  subs x4, x1, x3 // n == max  n - max
  beq loopend1
  
  subs x4, x2, x0 // num == n_sqr  n_sqr - num
  beq loopend1
  
  subs x4, x2, x0 // n_sqr > num  n_sqr - num
  bgt loopend0

  add x4, x1, x1 // n * 2
  add x4, x4, #1 // n*2 + 1
  add x2, x2, x4 // n_sqr + = n*2 + 1

  add x1, x1, #1  n += 1
  b forloop 

loopend1:
  mov x0, #1
  ret

loopend0:
  mov x0, #0
  ret
