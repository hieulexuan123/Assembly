#include <stdio.h>

void myCopy(char* dest, char* src, int size){
    for (int i=0; i<size; i++){
        dest[i] = src[i];
    }
}

int main() {
    char str[300];
    printf("Enter str: ");
    fgets(str, 300, stdin);

    char smallest[300];
    int smallest_size = 1000;

    int curr_size = 0;
    int i = 0;
    while (str[i] != '\0'){
        if (str[i] != ' ' && str[i] != '\n'){
            curr_size++;
        } else {
            if (curr_size<smallest_size) {
                smallest_size = curr_size;
                myCopy(smallest, str+i-curr_size, curr_size);
            }
            curr_size = 0;
        }
        i++;
    }
    smallest[smallest_size] = '\0';
    printf("Shortest string: %s", smallest);    

}
