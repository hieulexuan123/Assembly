#include <stdio.h>

int main(){
    char a[300];
    char b[300];

    printf("Enter str a: ");
    fgets(a, 300, stdin);
    printf("Enter str b: ");
    fgets(b, 300, stdin);

    int digitsInB[10] = { 0 };     //initialize to all 0s
    int digitsInA[10] = { 0 };
    int i=0;
    while (b[i] != '\n' && b[i] != '\0'){
        if (b[i]>='0' && b[i]<='9') digitsInB[b[i]-'0'] = 1;
        i++;
    }
    i=0;
    while (a[i] != '\n' && a[i] != '\0'){
        if (a[i]>='0' && a[i]<='9') digitsInA[a[i]-'0'] = 1;
        i++;
    }
    printf("Digits not in both: ");
    for (int i=0; i<10; i++){
        if (digitsInA[i]==0 && digitsInB[i]==0) putchar('0'+i);
    }

}