#include <stdlib.h> //Standard library
#include <stdio.h> //Standard input / output

int main() {
    int a = 0;
    int b = 0;

    scanf("%i%*c", &a);
    scanf("%i%*c", &b);

    int result = a + b;

    printf("%i", result);

    return 0;
}
