#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/*
 * drop_it_low()
 * runtime: O( N )
 * memory: O( N )
 */
int *drop_it_low(int *matrix, int n) {
  int **basins = malloc(sizeof(int*) * n * n);
  int **sizes = malloc(sizeof(int*) * n * n);
  int **size_p = sizes;
  memset(basins, 0, sizeof(int*) * n * n);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      int key = i * n + j;
      int max_delta = 0;
      int nearest = -1;
      if(i != 0) {
        if(matrix[key] - matrix[(i-1) * n + j] > max_delta) {
          nearest = (i-1) * n + j;
          max_delta = matrix[i * n + j] - matrix[nearest];
        }
      }
      if(i != n-1) {
        if(matrix[key] - matrix[(i+1) * n + j] > max_delta) {
          nearest = (i+1) * n + j;
          max_delta = matrix[i * n + j] - matrix[nearest];
        }
      }
      if(j != 0) {
        if(matrix[key] - matrix[i * n + j - 1] > max_delta) {
          nearest = i * n + j - 1;
          max_delta = matrix[key] - matrix[nearest];
        }
      }
      if(j != n-1) {
        if(matrix[key] - matrix[i * n + j + 1] > max_delta) {
          nearest = i * n + j + 1;
        }
      }
      if(nearest >= 0) {
        if(!basins[key] && !basins[nearest]){
          basins[nearest] = calloc(sizeof(int), 1);
          *basins[nearest] = 1;
        } else if(basins[key] && !basins[nearest]) {
          basins[nearest] = basins[key];
        } else if(basins[key] && basins[nearest]) {
          *basins[nearest] += (*basins[key]) - 1;
        }
        basins[key] = basins[nearest];
        (*basins[key])++;
      } else if(basins[key]) {
        *size_p++ = basins[key];
      } else if(!basins[key]) {
        *size_p = calloc(sizeof(int), 1);
        (**size_p)++;
        *size_p++;
      }
    }
  }
  *size_p++ = NULL;
  return sizes;
}




int main(int argc, char **argv) {
  int matrix[25] = {
    1, 0, 2, 5, 8,
    2, 3, 4, 7, 9,
    3, 5, 7, 8, 9,
    1, 2, 5, 4, 2,
    3, 3, 5, 2, 1
  };
  int **sizes = drop_it_low(matrix, 5);
  while(*sizes) {
    printf("%d\n", **(sizes++));
  }
  return 0;
}
