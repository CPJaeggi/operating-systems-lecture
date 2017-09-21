#include <stdio.h>

int main()
{
	int a[16][16], b[16][16], result [16][16], r1, c1, r2, c2, i, j, k;
	printf("Enter rows and columns for the 1. Matrix: ");
	scanf("%d %d", &r1, &c1);

	printf("Enter rows and columns for the 2. Matrix: ");
	scanf("%d %d", &r2, &c2);

	while (c1 != r2){
		printf("The Columns of the first Matrix does not match with the rows of the second Matrix. \n");
	}

	printf("Enter the elements of the 1. Matrix: \n");
	for(i=0; i<r1; ++i)
		for(j=0; j<c1; ++j){
			printf("Enter elements a%d%d: ",i+1, j+1);
			scanf("%d", &a[i][j]);
		}

	printf("\nEnter elements of the 2. Matrix: ");
	for(i=0; i<r2; ++i)
		for(j=0; j<c2; ++j){
			printf("Enter elements b%d%d: ",i+1, j+1);
			scanf("%d",&b[i][j]);
		}
	

	
	for(i=0; i<r1; ++i)
		for(j=0; j<c2; ++j){
			result[i][j] = 0;
			for(k=0; k<c1; ++k){
				result[i][j]+=a[i][k]*b[k][j];
			}
		}


	printf("\n Calculated Matrix: \n");
		for(i=0; i<r1; ++i)
			for(j=0; j<c2; ++j){
				printf("%d ", result[i][j]);
				if(j == c2 -1)
					printf("\n");
			}
	
	return 0;
}
