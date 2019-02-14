/*
 * Runtime (Worst Case): O(N * Log(N))
 * Memory: O(N)
 */


#include <stdio.h>
#include <stdlib.h>
#include <memory.h>

int trap(int* height, int heightSize);
typedef struct HeapNode HeapNode;
typedef struct Heap Heap;
void heap_node_swap(Heap *heap, int i, int j);
HeapNode* heap_add(Heap *heap, int value);
HeapNode* heap_pop(Heap *heap);
HeapNode* heap_heapify(Heap *heap);

struct Heap {
    HeapNode **heapNodes;
    int size;
};

struct HeapNode {
    int value;
    int width;
    HeapNode *left;
    HeapNode *right;
};

Heap* heap_init(int size) {
    Heap *heap = malloc(sizeof(Heap));
    heap->heapNodes = malloc(sizeof(HeapNode*) * size);
    heap->size = 0;
    return heap;
}

HeapNode* heap_add(Heap *heap, int value) {
    HeapNode *heapNode = heap->heapNodes[heap->size] = malloc(sizeof(HeapNode));
    memset(heapNode, 0, sizeof(HeapNode));
    heapNode->value = value;
    if(heap->size++) {
        heap_heapify(heap);
    }
    return heapNode;
}

HeapNode* heap_pop(Heap *heap) {
    heap_node_swap(heap, 0, --heap->size);
    int i = 0;
    while(i * 2 + 1 < heap->size) {
        int left = (i * 2 + 1);
        int right = (i * 2 + 2);
        int value = (*heap->heapNodes[i]).value;
        if((right >= heap->size || (*heap->heapNodes[left]).value <= (*heap->heapNodes[right]).value) && (*heap->heapNodes[left]).value < value ) {
            heap_node_swap(heap, i, left);
            i = left;
        } else if(right < heap->size && (*heap->heapNodes[right]).value < value) {
            heap_node_swap(heap, i, right);
            i = right;
        } else {
            break;
        }
    }
    return heap->heapNodes[heap->size];
}

HeapNode* heap_heapify(Heap *heap) {
    int i = heap->size - 1;
    int j = (i - 1) / 2;
    HeapNode *heapNode = heap->heapNodes[i];
    HeapNode *parentNode = heap->heapNodes[j];
    while (heapNode->value < parentNode->value && i != 0) {
        heap_node_swap(heap, i,j);
        i = j;
        j = (i - 1) / 2;
        heapNode = heap->heapNodes[i];
        parentNode = heap->heapNodes[j];
    }
    return heapNode;
}

void heap_node_swap(Heap *heap, int i, int j) {
    HeapNode *tmp = heap->heapNodes[i];
    heap->heapNodes[i] = heap->heapNodes[j];
    heap->heapNodes[j] = tmp;
}

int trap(int* height, int heightSize) {
    Heap *heap = heap_init(heightSize);
    HeapNode *last = 0;
    HeapNode *heapNode;
    for(int i = 0; i < heightSize; i++) {
        if(last && last->value == height[i]) {
            last->width += 1;
            continue;
        }
        heapNode = heap_add(heap, height[i]);
        heapNode->width = 1;
        if(last) {
            heapNode->left = last;
            last->right = heapNode;
        }
        last = heapNode;
    }
    int volume = 0;

    while(heap->size) {
        HeapNode *heapNode = heap_pop(heap);
        HeapNode *leftHeapNode = heapNode->left;
        HeapNode *rightHeapNode = heapNode->right;
        if(!leftHeapNode || !rightHeapNode) {
            continue;
        }
        HeapNode *minHeapNode = leftHeapNode->value < rightHeapNode->value ? leftHeapNode : rightHeapNode;
        if(heapNode->value < minHeapNode->value) {
            volume += (minHeapNode->value - heapNode->value) * heapNode->width;
            minHeapNode->width += heapNode->width;
            leftHeapNode->right = rightHeapNode;
            rightHeapNode->left = leftHeapNode;
            if(leftHeapNode->value == rightHeapNode->value){
                if(leftHeapNode->left){
                    leftHeapNode->left->right = rightHeapNode;
                    rightHeapNode->left = leftHeapNode->left;
                    rightHeapNode->width += leftHeapNode->width;
                }
            }
        }

    }
    return volume;
}

int main(int argc, char** argv) {
    int heights[29] = {1,0,5,3,4,9,5,6,0,9,4,3,5,1,7,5,4,1,1,9,7,4,3,5,3,6,0,0,6};
    printf("%i", trap(&heights[0], 29));
    return 0;
}
