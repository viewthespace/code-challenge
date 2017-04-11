#include <limits.h>

int diff(int *prices, int num) {
    int low = INT_MAX;
    int diff = 0;
    for(int i = 0; i < num; i++) {
        int price = prices[i];
        if (price < low) {
            low = price;
        } else if(price - low > diff) {
            diff = price - low;
        }
    }
    return diff;
}