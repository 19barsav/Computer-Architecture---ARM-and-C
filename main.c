/*
 *CSE 320
 *This program utilizes three functions to decode a binary string into a photo.
 The program uses a function called decode that reads in a file input of binary
 strings using an exlusive or with the key on the first line of the data file.
 The function uses a function called rotate to shift the numbers one string index
 left hte amount of times that the second input n says.The functions xs and nos makes 
 all the 1s in the binarystring an x and the 0s a space. 

 The linked list struct holds each decoded and rotated line of the file and prepends each new line to it. 
 This way, the lines print out the opposite way so the photo isnt upside down.
 *
 *
 * No memory leaks using valgrind for 4/7 of the test cases. Secret3, 5 and
 * apple.enc will not work and leak.
 *
 *
 * Tony, Bocheng, and I found the problem and fixed it. Now only secret3.enc
 * prints funny, but there isn't a leak! Yay!  
* 
*3 am update: I got it! It works for them all!!!
*
*
 */


#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdlib.h>

char *key_decode(char *key, char *bin_str);
char *rotate(char *bin_str, int n);
char *xs_and_nos(char *bin_str);

typedef struct LinkedListNode
{
      char *name;
      struct LinkedListNode *next;

} LinkedListNode;

/**
 *  * A structure that represents our linked list
 *   */
typedef struct
{
      LinkedListNode *head;
      LinkedListNode *tail;

} LinkedList;

void initialize_list(LinkedList *list);
void prepend_list(LinkedList *list, const char *name);
void free_list(LinkedList *list);

/**
 *  * Initialize a linked list to empty
 *   * @param list Pointer to the linked list struct
 *    */
void initialize_list(LinkedList *list)
{
      list->head = NULL;
      list->tail = NULL;
}

void prepend(LinkedList *list, const char *name){
/*
 * Appends a node tothe front of a linked list
 *
 */
  LinkedListNode *node = (LinkedListNode *)calloc(1, sizeof(LinkedListNode));
  node->next = NULL;

  node->name = (char *)calloc(strlen(name) + 1, sizeof(char));
  strncpy(node->name, name, strlen(name));
 //if the list is empty, make the node the head and tail
  if (list->head == NULL) {
      list->head = node;
      list->tail = node;
  } //append to the front
  else{
      node->next = list->head;
      list->head = node;
  }
}
//this functions frees the memory of each node in the linked list
//it also frees the linked list itself
void free_list(LinkedList *list)
{
      LinkedListNode *node;
      for (node = list->head; node != NULL;){
          LinkedListNode *next = node->next;
          free(node->name);
          free(node);
          node = next;
      }                                                
      list->head = NULL;
      list->tail = NULL;
}

//this functions takes the key string and a line from the file
////and uses the exclusive or against each index of th ekey and 
//the line ot create a new line
char *key_decode(char *key, char *bin_str){

   int length = strlen(bin_str)+1;
   int i  = length-1;
   char *new = (char *)calloc(length, sizeof(char)); //free me!
   for(i; i >= 0; i--){
      if(key[i] == '1' && bin_str[i] == '1'){
          new[i] = '0';
      }
      else if(key[i] == '1' && bin_str[i] == '0') {
          new[i] = '1';

      }
      else if(key[i] == '0' && bin_str[i] == '1') {
          new[i] = '1';
      }
      else if (key[i] == '0' && bin_str[i] == '0'){
          new[i] = '0';
      }
   }
  return new;
}
//this function rotates a certain amount of character (given by n) to the left
char *rotate(char *bin_str, int n){
   if (n > strlen(bin_str)){
         n = n - strlen(bin_str);
   }

   int length = strlen(bin_str) + 1;
   char *new = (char *)calloc(length, sizeof(char)); //free me! 
   strncpy(new, bin_str + n , length);
   strncat(new, bin_str, n);

   return new;
}
//this functions replaces 1's in the binary string with x's and o's with spaces
//(in a new string)
char *xs_and_nos(char *bin_str){
  int length = strlen(bin_str)+1;
  char *new = (char *)calloc(length, sizeof(char)); //free me!
  int i  = length-1;
  for(i; i >= 0; i--){
     if(bin_str[i] == '0'){
        new[i] = ' ';
     }
     else if(bin_str[i] == '1'){
        new[i] = 'x';
     }
  }
 
  return new;

}


int main(int argc, char *argv[]){

  if(argc < 2){
    printf("Usage: decoder file\n");
    return 1;
  }

  FILE *fp = fopen(argv[1], "r");
  if(fp == NULL){
     printf("Unable to open input file\n");
     return 1;
  }
  //initializes a linked list 
  LinkedList list;
  LinkedListNode *node;
  initialize_list(&list);
  //keeps tracked of how many times I need to rotate left
  int line_count = 0; 
  char buffer[1000];
  char key_buff[1000];
  fgets(key_buff, sizeof(key_buff), fp);
  while(fgets(buffer, sizeof(buffer), fp) != NULL) {
       //for each line, I call the three functions then store in a linkedlist       
       char *buffer2 = key_decode(key_buff, buffer);
       char *buffer3 = rotate(buffer2, line_count);
       char *buffer4 = xs_and_nos(buffer3);
       prepend(&list, buffer4);
       line_count++;
       free(buffer2);
       free(buffer3); // I am freeing *key_decode
       free(buffer4);
                     
  }
  for (node = list.head; node != NULL; node = node->next){
       printf("%s\n", node->name);
  }
  free_list(&list);
  fclose(fp);
  return 0;
}
