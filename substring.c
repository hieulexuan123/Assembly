#include<stdio.h>

int countLen(char* str){    
    int cnt = 0;
    while (str[cnt]!='\n' && str[cnt]!='\0'){
        cnt++;
    }
    return cnt;
}

int check(char* str, char* substr){
    int str_size = countLen(str);
    int substr_size = countLen(substr);
    for (int i=0; i<=str_size-substr_size; i++){
        int j=0;
        for (; j<substr_size; j++){
            if (str[i+j]!=substr[j]) break;
        }
        if (j==substr_size) return 1;
    }
    return 0;
}

int main(){
    char str[300];
    char substr[300];

    printf("Enter str: ");
    fgets(str, 300, stdin);    //fgets also store space and new line character
    printf("Enter substr: ");
    fgets(substr, 300, stdin);

    if (check(str, substr) == 1) printf("Found");
    else printf("Not found");
}

