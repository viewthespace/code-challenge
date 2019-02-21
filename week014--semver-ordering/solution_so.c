#include <stdio.h>

/*
 * Safe against integer overflow
 * Safe against padding
 * Memory O(1)
 * Runtime O(N)
 */
int compareVersion(char* version1, char* version2) {
    int returnValue = 0;
    while(*version1 == '0' ) {
        version1++;
    }
    while(*version2 == '0') {
        version2++;
    }
    while(*version1 || *version2) {
        char v1_char = *version1;
        char v2_char = *version2;

        if((v1_char == '\0' || v1_char == '.') && v2_char != '\0' && v2_char != '.') {
            return -1;
        }

        if((v2_char == '\0' || v2_char == '.') && v1_char != '\0' && v1_char != '.') {
            return 1;
        }

        if(v1_char == '\0' || v2_char == '\0' || (v1_char == '.' || v2_char == '.')) {
            if(returnValue) {
                return returnValue;
            }
        }
        if(v1_char == '.' || (v2_char == '.')) {

            if(v1_char == '.'){
                version1++;
                while(*version1 == '0' ) {
                    version1++;
                };
            }

            if(v2_char == '.'){
                version2++;
                while(*version2 == '0' ) {
                    version2++;
                }

            }
            continue;
        }

        if (v1_char > v2_char) {
            returnValue = 1;
        } else if (v1_char < v2_char) {
            returnValue = -1;
        }

        if(*version1 != '\0') {
            version1++;
        }

        if(*version2 != '\0') {
            version2++;
        }
    }
    return returnValue;
}

int main() {
    printf("%i", compareVersion("01.2", "112.1"));
    return 0;
}
