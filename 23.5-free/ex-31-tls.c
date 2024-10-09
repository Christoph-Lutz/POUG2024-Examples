/* 
 * Simple c program to demonstrate the use
 * of TLS variables with the __thread
 * specifier.
 * 
 * Compile with:
 *   gcc -o ex-31-tls ex31-tls.c
 * 
 * Disassemble with:
 *   objdump -d ex-31-tls
 * 
 * Example source:
 *   https://chao-tic.github.io/blog/2018/12/25/tls
 */

#include <stdio.h>

__thread int my_tls_var;

int main() {
    return my_tls_var;
}
