.data
//game description data structure
.equ game_rows, 0
.equ game_cols, 4
.equ game_array, 8
.equ game_size, 16

//cell data struct
.equ cell_expected, 0
.equ cell_actual, 4
.equ cell_size, 8
item: .asciz " %2d"
item2: .asciz "  %c"
item3: .asciz " %2d"
item4: .asciz "   "
new_line: .asciz "\n"
.text

.global create_game

//
// Create the game abstract data type
// void *create_game(int rows, int cols)
//
create_game:
	  stp x29, x30, [sp, #-16]!
	  stp x19, x20, [sp, #-16]!
	  stp x21, x22, [sp, #-16]!
  
  //rows and cols
    mov w19, w0
    mov w20, w1
  //allocate space
    mov w0, #1
    mov w1, #game_size
    bl calloc
  
  //save data struct with init vals  
    str w19, [x0, #game_rows]
    str w20, [x0, #game_cols]
    
    mov x21, x0

    //allocate game array
    mul w0, w19, w20 //co*r
    mov w1, #cell_size
    bl calloc

    str x0, [x21, #game_array]
    mov x0, x21
 	

create_game_done:
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
    
    
.global destroy_game
//
// void destroy_game(void *game)
// Destroy the game, freeing all memory
//
destroy_game:
	stp x29, x30, [sp, #-16]!
  stp x19, x20, [sp, #-16]!
   
  mov x19, x0
  ldr x0, [x0, #game_array]
  bl free
  mov x0, x19
  bl free
    
  ldp x19, x20, [sp], #16
  ldp x29, x30, [sp], #16
  ret
    
    
.global get_rows

//
// Get the number of rows in the game
// int get_rows(void *game)
//
get_rows:
    ldr w0, [x0, #game_rows]
    ret

.global get_cols

//
// Get the number of columns in the game
// int get_cols(void *game)
//
get_cols:
    ldr w0, [x0, #game_cols]
    ret

.global display_game

//
// Display the game
//
display_game:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    stp x21, x22, [sp, #-16]!
    stp x23, x24, [sp, #-16]!
    ldr w19, [x0, #game_cols]
    ldr w21, [x0, #game_rows]
    mov x23, x0 
    mov w20, #1
    ldr x0, =item4
    bl printf

loop_top:
    mov w1, w20
    ldr x0, =item
    bl printf

    cmp w19, w20
    beq the_rest

    add w20, w20, #1
    b loop_top

the_rest:
    ldr x0, =new_line
    bl printf
    mov w20, #1
    mov w22, #1
    ldr x0, =item3
    mov w1, w22
    bl printf

loopie:
    mov x0, x23
    mov w1, w22
    mov w2, w20
    bl game_index
    ldr x1, [x0, #cell_actual] 
    ldr x0, =item2
    bl printf 
    cmp x20, x19
    beq check_row

    add x20, x20, #1
    b loopie
      
check_row:
    cmp x21, x22
    bne add_to_row
    b display_game_done

add_to_row:
    add x22, x22, #1
    ldr x0, =new_line
    bl printf
    ldr x0, =item3
    mov w1, w22
    bl printf
    mov x20, #1
    b loopie


display_game_done:
    ldr x0, =new_line
    bl printf
    ldp x23, x24, [sp], #16
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret


.global set_cell_actual

//
// int set_cell_actual(void *game, int row, int col, char ch);
// Returns: 1 if the answer value is correct
//
set_cell_actual:
	stp x29, x30, [sp, #-16]!
	stp x19, x20, [sp, #-16]!
  
  mov w19, w3
  bl game_index

  str w19, [x0, #cell_actual]
  ldr w1, [x0, #cell_expected]
  mov x0, #0
  cmp w1, w19
  bne set_cell_actual_done
	mov x0,#1
    
set_cell_actual_done:
	ldp x19, x20, [sp], #16
	ldp x29, x30, [sp], #16
  ret

.global set_cell_expected

//
// void set_cell_expected(void *game, int row, int col, char ch);
//
set_cell_expected:
	stp x29, x30, [sp, #-16]!
	stp x19, x20, [sp, #-16]!
    
  mov w19, w3
  bl game_index

  str w19, [x0, #cell_expected]

	ldp x19, x20, [sp], #16
	ldp x29, x30, [sp], #16
  ret



.global game_win

//
// int game_win(void *game)
// Returns true when the game is done/won
//
game_win:
  stp x29, x30, [sp, #-16]!
  stp x19, x20, [sp, #-16]!
  stp x21, x22, [sp, #-16]!
  stp x23, x24, [sp, #-16]!
  mov x19, x0
  ldr w1, [x0, #game_cols]
  ldr w2, [x0, #game_rows]
  mov w20, w1 //cols
  mov w21, w2 //row
	mov w0,#0
  mov w22, #1 //row counter
  mov w23, #1  //col counter
  
  
done_row:
  cmp w21, w22
  beq game_win_done
  mov w23, #0
  add w22, w22, #1
  b loop

loop:
  mov x0, x19
  mov w1, w22
  mov w2, w23
  bl game_index
  ldr w6, [x0, #cell_expected]
  ldr w7, [x0, #cell_actual]
  cmp w6, w7
  bne game_lost_done

  cmp w23, w20
  beq done_row
  add w23, w23, #1
  b loop  


game_win_done:
  mov x0, #1  
  b done34

game_lost_done:
  mov x0, #0
  b done34

done34:
	ldp x23, x24, [sp], #16
	ldp x21, x22, [sp], #16
  ldp x19, x20, [sp], #16
	ldp x29, x30, [sp], #16
  ret
    

.global game_index
//
// int *game_index(void *game, int row, int col)
// Get the address of a row and column in the cells
//   
game_index:
  sub w1, w1, #1
  sub w2, w2, #1

  ldr w3, [x0, #game_cols]
  mul w1, w1, w3 //row *n # cols
  add  w1, w1, w2  //add c
  mov w4, #cell_size
  mul w1, w1, w4 //multiple by 4

  ldr x2, [x0, #game_array]
  add x0, x2, w1, uxtw
  
	ret
	

