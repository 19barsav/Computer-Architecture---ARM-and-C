#include <stdlib.h>
#include <string.h>
#include "binarymath.h"
#include <stdbool.h>


/**
 * Increment a BINARY_SIZE binary number expressed as a 
 * character string.
 * @param number The number we are passed
 * @returns Incremented version of the number free me!!
 */
char *inc(const char *number)
{   
    int carry = 1;
    int i = BINARY_SIZE - 1;
    char *new = (char *)calloc(BINARY_SIZE,sizeof(char)); // free me!
    for(i; i >=  0; i--){
         if( number[i] == '1' && carry == 1){
             new[i] = '0';
         }
         else if( number[i] == '0' && carry == 1){
             new[i] = '1';
             carry = 0;
         }
         //if there is no more carry, and no more addition, I just copy
         //the rest of the numbers from the first to the result
         else{
             new[i] = number[i];            
         }
    }
    return new;
}


/**
 * Negate a BINARY_SIZE binary number expressed as a character string
 * @param number The number we are passed
 * @returns Incremented version of the number //free me there!
 *
 */


char *negate(const char *number)
{   
    //finds complement of binary number, then adds one ot it
    int i = BINARY_SIZE - 1;
    char *new = (char *)calloc(BINARY_SIZE, sizeof(char)); //free me here!
    for(i; i >= 0; i--){
          if (number[i] == '1'){
              new[i] = '0';
          }
          else if (number[i]== '0'){
              new[i] = '1';
          }
      }

    char *new2 =  inc(new); 
    free(new);
    return new2;
}
/*
 * Add two BINARY_SIZE binary numbers expressed as
 * a character string. 
 * @param a First number to add
 * @param b Second number to add
 * @return a + b  free me!!
 */
char *add(const char *a, const char *b)
{   
    //if carry is false, no 1 needs to be trasnferred to next row
    //if carry is true, a 1 needs to be transferred (1+1)
    bool carry = false;
    int i = BINARY_SIZE -1;
    char *new = (char *)calloc(BINARY_SIZE, sizeof(char)); //free me!
    for (i; i >= 0; i--){
        if (carry == false){

            if(a[i] == '1' && b[i] == '1'){
                new[i] = '0';
                carry = true;
            }
            else if (a[i] == '1' && b[i] == '0'){
                new[i] = '1';
            }
            else if (a[i] == '0' && b[i] == '1'){
                new[i] = '1';
            }
            else{
                new[i] = '0';
            }
        }

        else{
            if(a[i] == '1' && b[i] == '1'){
                new[i] = '1';
            }
            else if (a[i] == '1' && b[i] == '0'){
                new[i] = '0';
            }
            else if (a[i] == '0' && b[i] == '1'){
                new[i] = '0';
            }
            else{
                new[i] = '1';
                carry = false;
            }
        }
    }
    return new;
}
/*
 * Subtract two BINARY_SIZE binary numbers expressed as
 * a character string.
 * @param a First number
 * @param b Second number 
 * @return a - b   //free me!
 */
char *sub(const char *a, const char *b)
{   
    //subtracts using hte compliment rule - negates the second binary number
    //then adds the negated number and regualr first binary number together
    char *b2 = negate(b);  //needs to be free
    char *new = add(a, b2);
    free(b2);
    return new;
}







