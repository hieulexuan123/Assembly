#include <stdio.h>

int main(){
    char a[300];
    char b[300];

    printf("Enter str a: ");
    fgets(a, 300, stdin);
    printf("Enter str b: ");
    fgets(b, 300, stdin);

    int lowercaseInB[26] = { 0 };     //initialize to all 0s

    int i=0;
    while (b[i] != '\n' && b[i] != '\0'){
        if (b[i]>='a' && b[i]<='z') lowercaseInB[b[i]-'a'] = 1;
        i++;
    }
    i=0;
    printf("Lowercase characters in a but not in b: ");
    while (a[i] != '\n' && a[i] != '\0'){
        if (a[i]>='a' && a[i]<='z' && lowercaseInB[a[i]-'a']==0) 
            putchar(a[i]);
        i++;
    }

}