#include "functions.h"

int main() {
    volatile unsigned int *magic_addr = (unsigned int*) 0x10007ff0;
    
    int result = functions();

    *(magic_addr) = result + 1;

    while(1);
}