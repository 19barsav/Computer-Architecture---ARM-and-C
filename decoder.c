#include "decoder.h"
#include <string.h>
#include <stdio.h>

/**
 * @author Savanah B.
 *
 * decoder():
 * Decode an encoded string into a character stream.
 * @param encoded The input string we are decoding
 * @param decoded The output string we produce
 * @param maxLen The maximum size for decoded
 *
 * setBit():
 * Sets a single bit in the decoded array of bytes to 1
 * @param decoded The output string we produce (the bytes we need
 * to change a bit in)
 * @param b The byte that we need to access and change
 * return Nothing
 */
void setBit(char *decoded, int b, int maxLen);
void decoder(const char *encoded, char *decoded, int maxLen);

void setBit(char *decoded, int b, int maxLen){
  
  int byte = (b)/8; //gives the byte location
  if (byte < maxLen) {
     int bitInByte = 7-(b)%8; //gives the bit in the byte location in
                          // little endien
     decoded[byte]|= (1 << bitInByte);  //shifts the 1 bit over to the
                                    // correct location
      (b)++; //go the next bit
  }

}



void decoder(const char *encoded, char *decoded, int maxLen)
{
  int i;
  int bit = 0;
  int k = 0;
  for(k = 0; k  <maxLen; k++){
    decoded[k] = 0;  //sets all bits and bytes to 0 so
                    // we only need to replace a 1
  }

  for(; *encoded; encoded++ ){
      switch(*encoded){   //depending on the letter, we add a series of bits
          case '4':
            bit++;   //if the bit should be 0, we move the bit we are on over 1
            bit++;
            bit++;
            break;
          case 'v':
            bit++;
            bit++;
            setBit(decoded, bit++, maxLen);
            break;
          case '-':
            bit++;
            setBit(decoded, bit++, maxLen);
            bit++;
            break;
          case 'k':
            bit++;
            setBit(decoded, bit++, maxLen);
            setBit(decoded, bit++, maxLen);
            break;
          case 's':
            setBit(decoded, bit++, maxLen);
            bit++;
            bit++;
            break;
          case 'Y':
            setBit(decoded, bit++, maxLen);
            bit++;
            setBit(decoded, bit++, maxLen);
            break;
          case 'p':
            setBit(decoded, bit++, maxLen);
            setBit(decoded, bit++, maxLen);
            bit++;
            break;
          case '@':
            setBit(decoded, bit++, maxLen);
            setBit(decoded, bit++, maxLen);
            setBit(decoded, bit++, maxLen);
            break;
          case 'n':
            bit++;
            bit++;
            break;
          case '5':
            bit++;
            setBit(decoded, bit++, maxLen);
            break;
          case '3':
            setBit(decoded, bit++, maxLen);
            bit++;
            break;
          case 'F':
            setBit(decoded, bit++, maxLen);
            setBit(decoded, bit++, maxLen);
            break;
            
             }
        i++;
    // move to next character

  }

}

