#include "bin2dec.h"

/**
 * Convert a binary representation of a 
 * number to an unsigned integer. 
 * 
 * For this function, the values Y and N represent 
 * true (1) and false (0) respectfully. So, the string:
 * 
 * YYNY is equal to 1101 binary, which is equal to 13.
 *
 * Unexpected characters are ignored. Only Y's and N's are
 * considered to be valid. Stop converting when you get
 * to a space character or the end of the string. The 
 * representation is case-sensitive (only Y/N are valid 
 * true and false values).
 *
 * 'aYNcY YY' should convert to 5
 * 'NYNYny' should convert to 5
 *
 * @param binary Binary number as a string of 'Y's and 'N's
 * and other characters.
 * @returns unsigned int result
 */

unsigned int bin2dec(const char *binary); //declaration of function
unsigned int bin2dec(const char *binary){

  unsigned int dec_value = 0; //start decimal number at 0
  
  for(;*binary;binary++){   
      int hold = 0;      //hold may be 1 or 0, depending on binary character
      if (*binary == ' ' || *binary == '0'){     //if there is a space
                                                // or 0 we stop the program
        break;
      }
      if (*binary == 'Y'){   //if there is a "Y" we read the bit as "1"
        hold = 1;    
       dec_value = dec_value * 2 + hold;  //algorithm for making a binary # to a decimal #
    }
      else if (*binary == 'N'){  //if there is a "N" we read the bit as a "0"
        hold = 0;
        dec_value = dec_value * 2 + hold;
    }
  }
  return dec_value;  //return the decimal number
}
