#include<stdio.h>
#include<unistd.h>

int main(){
  printf("\nThe process id is %d\n", getpid());

  pid_t ret_val = fork();
  int n, a, b;
  if(ret_val < 0){
    // fork has failed
    printf("\nFork Failure\n");
  }
  else if(ret_val == 0){
    // child process
    printf("\n**** Child Process ****\n");
    printf("The process id is %d\n", getpid());
    printf("Enter a number to check even or odd\n");
    scanf("%d", &n);
    if(n%2 == 0) printf("Number %d is Even\n", n);
    else printf("Number %d is Odd\n", n);
    //sleep(10);
  }
  else{
    // parrent process
    wait();
    printf("\n\n**** Parent Process ****\n");
    printf("The process id is %d\n", getpid());
    printf("Enter a number to check Max or Min\n");
    scanf("%d%d", &a, &b);
    if(a>b) printf("%d is gtreater than %d\n", a, b);
    else printf("%d is greater than %d\n", b, a);

    //sleep(20);
  }

  return 0;
}

