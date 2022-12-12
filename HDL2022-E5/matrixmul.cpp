#include "matrixmul.h"

void matrixmul(
	mat_a_t a[MAT_A_ROWS][MAT_A_COLS],
	mat_b_t b[MAT_B_ROWS][MAT_B_COLS],
	result_t res[MAT_A_ROWS][MAT_B_COLS])
{

   Row: for(int i = 0; i < MAT_A_ROWS; i++){
       Col: for(int j = 0; j < MAT_B_ROWS; j++){
			res[i][j] = 0;
			Product: for(int k = 0; k< MAT_B_COLS; k++){
			   res[i][j] += a[i][k] * b[k][j];
			}
       }
   }
}
