.data

.balign 8
one: .double 1
three: .double 3

.text

.global bezier

//
// double bezier(double t)
// Computes: 3 * (1-t)^2 *t
//
bezier:
  stp x29, x30, [sp, #-16]!
  
  fmov d1, d0

  ldr x0,=one
  ldr d2, [x0]

  fsub d2, d2, d1  //d2=1-t
  fmul d2, d2, d2  //d2 = (1-t)^2

  fmul d2, d2, d1 //(1-t)^2*t

  ldr x0, =three
  ldr d1, [x0]

  fmul d0, d2, d1

bezier_done:
  ldp x29, x30, [sp], #16
  ret 
