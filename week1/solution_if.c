#include <stdio.h>

int square(int, int);
int invalidEntry(int);
int isValid(int (*)[]);

int main() {
  int choice = 0;
  int boardIsValid = 0;

  int valid[9][9] = {
    {1,9,0,0,0,0,0,0,8},
    {2,8,0,0,9,0,0,0,0},
    {3,7,0,0,0,0,0,0,0},
    {4,0,0,0,0,0,0,0,0},
    {5,0,0,0,1,0,0,0,0},
    {6,0,0,0,2,0,0,0,0},
    {7,3,0,0,0,0,0,0,0},
    {8,2,0,0,0,0,0,0,0},
    {9,1,0,0,0,0,0,0,4}
  };

  int invalid[9][9] = {
    {1,9,0,0,0,0,0,0,8},
    {2,8,0,0,9,0,0,0,0},
    {3,7,0,0,0,0,0,0,0},
    {4,0,0,0,0,0,0,0,0},
    {5,6,0,0,1,0,0,0,0},
    {6,0,0,0,0,0,0,0,0},
    {7,3,0,0,0,0,0,0,0},
    {8,2,0,0,0,0,0,0,0},
    {9,1,0,0,0,0,0,0,4}
  };

  int empty[9][9] = {{0}};

  while(choice != 4) {
    printf("Test board: (1) valid, (2) invalid, (3) empty, (4) exit\n");
    scanf("%d", &choice);

    switch(choice) {
      case 1: {
        boardIsValid = isValid(valid);
        break;
      }
      case 2: {
        boardIsValid = isValid(invalid);
        break;
      }
      case 3: {
        boardIsValid = isValid(empty);
        break;
      }
      case 4: {
        printf("Goodbye.\n");
        continue;
      }
      default: {
        printf("Please choose a given option.\n");
        continue;
      }
    }

    if(boardIsValid) {
      printf("Board is valid\n");
    }
    else {
      printf("Board is invalid\n");
    }
  }
  return 0;
}

int isValid(int (*arr)[9]) {
  int i, j;
  int row[9][9] = {{0}};
  int col[9][9] = {{0}};
  int sqr[9][9] = {{0}};

  for(i = 0; i < 9; i++) {
    for(j = 0; j < 9; j++) {
      if(arr[i][j] == 0) {
        continue;
      }
      else if(row[i][arr[i][j]-1] || col[j][arr[i][j]-1] || sqr[square(i, j)][arr[i][j]-1] || invalidEntry(arr[i][j])) {
        return 0;
      }
      else {
        row[i][arr[i][j] - 1] = 1;
        col[j][arr[i][j] - 1] = 1;
        sqr[square(i, j)][arr[i][j] - 1] = 1;
      }
    }
  }
  return 1;
}

int square(int row, int col)
{
   if(row < 3 && col < 3) {
      return 0;
   }
   else if(row < 3 && col < 6) {
      return 1;
   }
   else if(row < 3) {
      return 2;
   }
   else if(row < 6 && col < 3) {
      return 3;
   }
   else if(row < 6 && col < 6) {
      return 4;
   }
   else if(row < 6) {
      return 5;
   }
   else if(col < 3) {
      return 6;
   }
   else if(col < 6) {
      return 7;
   }

   return 8;
}

int invalidEntry(int el) {
  if(el < 1 || el > 9) {
    return 1;
  }
  return 0;
}

