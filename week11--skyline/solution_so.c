#include "secret_data_structure_so.h"

/*
 *  Runtime:  Worst: O(N LOG N),  Best: O(N) (Narrow Buildings)
 *  Memory:   Worst: O(N),        Best: O(1) (Narrow Buildings)
 */
int** getSkyline(int** buildings, int buildingsRowSize, int buildingsColSize, int* cnt) {
  *cnt = 0;
  int **skyline = malloc(sizeof(int*) * buildingsRowSize * 2);
  Heap *expire_heap = heap_init(20, 0);
  Heap *height_heap = heap_init(20, 1);
  for(int i = 0; i <= buildingsRowSize; i++) {
    int start = (i != buildingsRowSize) ? buildings[i][0] : INT32_MAX;
    int end = (i != buildingsRowSize) ? buildings[i][1] : INT32_MAX;
    int height = (i != buildingsRowSize) ? buildings[i][2] : INT32_MAX;
    int prev_start = 0;
    int prev_height = 0;
    while(expire_heap->size && (start >= heap_peak(expire_heap))) {
      HeapNode *expire_heap_node = heap_pop(expire_heap);
      int expiring_height = expire_heap_node->heap_node_ref->val;
      if(expiring_height == heap_peak(height_heap)) {
        heap_remove(height_heap, expire_heap_node->heap_node_ref);
        if(prev_start == expire_heap_node->val && prev_height > expiring_height ) {
          (*cnt)--;
        }
        prev_start = expire_heap_node->val;
        prev_height = expiring_height;
        skyline[*cnt] = malloc(sizeof(int) * 2);
        skyline[*cnt][0] = expire_heap_node->val;
        if(height_heap->size) {
          skyline[(*cnt)++][1] = heap_peak(height_heap);
        } else {
          skyline[(*cnt)++][1] = 0;
        }
      } else {
        heap_remove(height_heap, expire_heap_node->heap_node_ref);
      }
    }
    if(i != buildingsRowSize && (!height_heap->size || height >= heap_peak(height_heap))) {
      if(*cnt != 0 && start == skyline[(*cnt)-1][0] && height > skyline[(*cnt)-1][1]) {
        (*cnt)--;
      }
      if(*cnt==0 || start != skyline[(*cnt)-1][0] || (start == skyline[(*cnt)-1][0] && height > skyline[(*cnt)-1][1]) ) {
        skyline[*cnt] = malloc(sizeof(int) * 2);
        skyline[*cnt][0] = start;
        skyline[(*cnt)++][1] = height;
      }
    }
    HeapNode *node_one = heap_insert(expire_heap, end);
    HeapNode *node_two = heap_insert(height_heap, height);
    heap_associate_nodes(node_one, node_two);
  }
  return skyline;
}

int main(int argc, char **argv) {
  int buildingsRowSize = 3;
  int buildingsColSize = 3;
  int **buildings = malloc(sizeof(int*) * buildingsRowSize);
  int returnSize = 0;
  int data[18] = { 1,2,1,1,2,2,1,2,3 };
  for(int i = 0; i < buildingsRowSize; i++) {
    buildings[i] = malloc(sizeof(int) * buildingsColSize);
    for(int j = 0; j < buildingsColSize; j++) {
      buildings[i][j] =  data[i*buildingsColSize + j];
    }
  }
  int **skyline = getSkyline(buildings, buildingsRowSize, buildingsColSize, &returnSize);
  for(int i = 0; i < returnSize; i++) {
    for(int j = 0; j < 2; j++) {
      printf("%d\n", skyline[i][j]);
    }
    printf("\n");
  }
}