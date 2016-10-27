#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <string.h>

#define BUFFER_SIZE 1024

const int Q_TO_D[26] = { 0, 23, 9, 4, -1, 20, 8, 3, 2, 7, 19, 13, 12, 1, 17, 11, -1, 15, 14, 24, 6, 10, -1, 16, 5, -1 };

void puns();
void traverse(int **nodeQwerrty, int **nodeDvorak, char *wordQwerrty, char *wordDvorak, int wordLength);

/*
 * puns()
 * Runtime:
 * Memory:
 * Time: 0.13 real         0.07 user         0.04 sys
 */
void puns() {
  const int **root = malloc(sizeof(int*) * 27);
  memset(root, 0, sizeof(int*) * 27);
  char buffer[BUFFER_SIZE];
  FILE *file;
  size_t nread;
  file = fopen("/usr/share/dict/words", "r");
  if(file) {
    int **currentLetter = root;
    while ((nread = fread(buffer, 1, sizeof buffer, file)) > 0) {
      for(int i = 0; i < nread; i++) {
        int c = (int)buffer[i];
        if(c == 10) {
          currentLetter[26] = 1;
          currentLetter = root;
        } else {
          if(c >= 65 && c <= 90) {
            c += 32;
          }
          c -= 97;
          if(!(currentLetter[c])) {
            currentLetter[c] = malloc(sizeof(int*) * 27);
            memset(currentLetter[c], 0, sizeof(int*) * 27);
          }
          currentLetter = (int**)currentLetter[c];
        }
      }
    }
    fclose(file);
    char wordQwerrty[50] = {0};
    char wordDvorak[50] = {0};
    traverse(root, root, wordQwerrty, wordDvorak, 0);
  }
}

void traverse(int **nodeQwerrty, int **nodeDvorak, char wordQwerrty[], char wordDvorak[], int wordLength) {
  if(nodeQwerrty[26] && nodeDvorak[26]) {
    printf("q:%s|d:%s\n", (char*)wordQwerrty, (char*)wordDvorak);
  }
  for(int i = 0; i < 26; i++) {
    if(Q_TO_D[i] != -1 && nodeQwerrty[i] && nodeDvorak[Q_TO_D[i]]) {
      char newWordQwerrty[50] = {0};
      char newWordDvorak[50] = {0};
      strcpy(newWordQwerrty, wordQwerrty);
      strcpy(newWordDvorak, wordDvorak);
      newWordQwerrty[wordLength] = (char)(i + 97);
      newWordDvorak[wordLength] = (char)(Q_TO_D[i] + 97);
      traverse((int**)nodeQwerrty[i], (int**)nodeDvorak[Q_TO_D[i]], newWordQwerrty, newWordDvorak, wordLength + 1);
    }
  }
}

int main(int argc, char **argv) {
//  float startTime = (float)clock()/CLOCKS_PER_SEC;
  puns();
//  float endTime = (float)clock()/CLOCKS_PER_SEC;
//  float timeElapsed = endTime - startTime;
//  printf("%.5f", timeElapsed);
  return 0;
}
