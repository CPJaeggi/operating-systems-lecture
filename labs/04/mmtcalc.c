#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>

#define X 1000
#define Y 1000
#define Z 1000
#define NUM_THREADS 10

int A [X][Y];
int B [Y][Z];
int C [X][Z];

struct v {
	int row;
	int column;
};

void generateMatrices();
void multiply();
void printMatrix(int D[X][Z]);
void *mSum();

int main(){

	clock_t t;
	t = clock();

	generateMatrices();
	multiply();
	
	t = clock() - t;
	double time_taken = ((double)t)/CLOCKS_PER_SEC;
	printf("\nThe multiplication took %f seconds to execute with %d threads\n\n", time_taken, NUM_THREADS);

	return 0;
}

void generateMatrices(){
	for (int i = 0; i < X; i++) {
		for (int j = 0; j < Y; j++) {
			A [i][j] = rand() % 4;
		}
	}
	for (int i = 0; i < Y; i++){
		for (int j = 0; j < Z; j++){
			B [i][j] = rand() % 4;
		}
	}
}

void multiply() {
	int i,j;
	for(i = 0; i < X; i++) {
		for(j = 0; j < Z; j++){
			struct v *data = (struct v *) malloc(sizeof(struct v));
			data->row = i;
			data->column = j;
			pthread_t tid;

			pthread_create(&tid,NULL,mSum,(void *)data);
			pthread_join(tid, NULL);
		}
	}
}

void *mSum(void *param){
	struct v *data = param;
	int n;
	C[data->row][data->column] = 0;
	for(n = 0; n < Y; n++){
		C[data->row][data->column] += A[data->row][n] * B[n][data->column];
	}
	pthread_exit(NULL);
}


void printMatrix(int D[X][Z]){
	for(int i = 0; i < Z; i++){
		for(int j = 0; j < Z; j++){
			printf("%d ", D[i][j]);
		}
		printf("\n");
	}
}
