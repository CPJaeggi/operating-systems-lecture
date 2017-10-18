#include<stdio.h>
#include<pthread.h>
#include<stdlib.h>
#include<unistd.h>


/* Variable declaration */
pthread_mutex_t lock;
FILE *mf;
char buff[255];
int cookies;
int selling;

/*Function running in the critical section*/
void* criticalsection(){
	int tmp;

	/*Opening the cookie storage-file*/
	mf = fopen("cookiestorage.txt", "r");
	fscanf(mf, "%s", buff);
	sscanf(buff, "%d", &cookies);
	fclose(mf);

	if(selling > cookies){
		printf("There are not enough cookies left, pardon. Current ammount: %d\n", cookies);
		return NULL;
	}else{
		printf("Here you go\n");
		mf = fopen("cookiestorage.txt", "w+");
		fprintf(mf, "%d", cookies - selling);
		fclose(mf);
	}
	return NULL;
}


/*Main program, locking the critical section */

int main(void) {
	int error;
	printf("How many cookies do you want to buy?\n");
	scanf("%d", &selling);
	sleep(1);

	if(pthread_mutex_init(&lock, NULL) != 0){
		printf("Mutex initialization failed\n");
		return 1;
	}else{
		pthread_mutex_lock(&lock);
		criticalsection();
		pthread_mutex_unlock(&lock);
		pthread_mutex_destroy(&lock);
	}
	return 0;
}
