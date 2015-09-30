////////////////////////////////////////////////////////////
//Ho Thien Luan -> History Tracking!
// 1. multi_pat_asm_naive_cpu.cu 
// 2. 
//
//
//
////////////////////////////////////////////////////////////
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <time.h>
#include <cuda_runtime.h>
//#include "cuPrintf.cu"


#define FILENAME_MAXLEN     256
#define THREAD_BLOCK_EXP   (7)
#define THREAD_BLOCK_SIZE  (1 << THREAD_BLOCK_EXP)

__global__ void ASM_kernel(char *g_input_string, int input_size, int *g_pattern_table, int pattern_length, int no_of_patterns, int *g_matched_result)
{
    int tid  = threadIdx.x ;
    int gbid = blockIdx.y * gridDim.x + blockIdx.x ;
    int start = gbid*THREAD_BLOCK_SIZE + tid;
    int max_pattern_length = pattern_length +1; 
    int result;

  if (start < (input_size-pattern_length+1)) {

    for (int j = 0; j < no_of_patterns; j++) {
      result = 0;
      for (int i = 0; i<pattern_length ; i++) {

        if ((g_input_string[ start + i ] != '\n') & (g_input_string[ start + i ] != g_pattern_table[j*max_pattern_length+i])) {
	    result ++;
	    //g_matched_result[start*no_of_patterns + j] = g_matched_result[start*no_of_patterns + j] + 1;
        }
      }
      g_matched_result[start*no_of_patterns + j] = result;
    }
  }
    //cuPrintf("threadIdx.x = %d \t bit_vector = %d \n", start, bit_vector);
}

////////////////////////////////
void ASM_process_top (char *g_input_string, size_t input_size,  int *g_pattern_table, int pattern_length, int no_of_patterns, int *g_matched_result)
{

    // num_blocks = # of thread blocks to cover input stream
    int num_blocks = (input_size-pattern_length+1)/THREAD_BLOCK_SIZE + 1 ;


        dim3  dimBlock( THREAD_BLOCK_SIZE, 1 ) ;
        dim3  dimGrid ;

        int p = num_blocks >> 15 ;
        dimGrid.x = num_blocks ;
        if ( p ){
            dimGrid.x = 1<<15 ;
            dimGrid.y = p+1 ;
        }
    //cudaPrintfInit();////for cuPrintf

    ASM_kernel <<< dimGrid, dimBlock >>>((char*)g_input_string, input_size, (int*) g_pattern_table, pattern_length, no_of_patterns, g_matched_result);

    //cudaPrintfDisplay();////for cuPrintf
    //cudaPrintfEnd();        ////for cuPrintf
}

int main(int argc, char **argv)
{
    char inputFile[FILENAME_MAXLEN];
    char patternFile[FILENAME_MAXLEN];
    strcpy( inputFile, argv[2]) ;
    strcpy( patternFile, argv[1]) ;
    //int k_par = 4;
    int k_par;
    k_par = strtol(argv[3], NULL, 10);
////////////////////////////////////////////////////////////////////////////////////
//Process input patterns
    int pattern_size;
    char *h_pattern = NULL ;
    int len;

    size_t  sizeOfTableEntry ;
    int  sizeOfTableInBytes ; // numOfTableEntry * sizeOfTableEntry
    size_t  sizeOfPatternInBytes ; // no_of_patterns * sizeOfTableEntry

    int max_pattern_length = 0;
    int no_of_patterns = 0;

    FILE* fpattern = fopen( patternFile, "rb");
    assert ( NULL != fpattern ) ;
    // obtain pattern file
    fseek (fpattern , 0 , SEEK_END);
    pattern_size = ftell (fpattern);
    rewind (fpattern);

    // allocate a buffer to contains all patterns
    h_pattern = (char *) malloc (sizeof(char)*pattern_size);
    assert( NULL != h_pattern );

    // copy the file into the buffer
    pattern_size = fread (h_pattern, 1, pattern_size, fpattern);
    fclose(fpattern);
    //printf ("pattern size = %d\n",pattern_size); 
    //printf ("pattern = %s\n",h_pattern); 
    //Processing to get max_pattern_length & no_of_patterns
    len = 0;
    for( int i = 0 ; i < pattern_size ; i++){
        if ( '\n' == h_pattern[i] ){
            if ( (i > 0) && ('\n' != h_pattern[i-1]) ){ // non-empty line
		no_of_patterns = no_of_patterns + 1;	
		if (max_pattern_length < len+1) {max_pattern_length = len+1;}
            }
            len = 0 ;
        }else{
            len++ ;
        }
    }

   // Create pattern_table, pattern_length_table
    sizeOfTableEntry = sizeof(int) ;
    sizeOfPatternInBytes = no_of_patterns * sizeOfTableEntry; // 1-D to store size of each patterns
    sizeOfTableInBytes = no_of_patterns * max_pattern_length; //2-D to store patterns

    int* pattern_table = (int*) malloc( sizeof(int)*sizeOfTableInBytes ) ;
    int* pattern_length_table = (int*) malloc( sizeOfPatternInBytes ) ;

    //Processing to fill pattern_table & pattern_length_table 
    len = 0;
    int no_patterns = 0;
    for( int i = 0 ; i < pattern_size ; i++){
        if ( '\n' == h_pattern[i] ){
            if ( (i > 0) && ('\n' != h_pattern[i-1]) ){ // non-empty line
		pattern_length_table[no_patterns] = len;
		no_patterns = no_patterns + 1;	
            }
            len = 0 ;
        }else{
	    pattern_table[no_patterns*max_pattern_length + len] = h_pattern[i]; 	
            len++ ;
        }
    }
   //Print to pattern_table/pattern_length_table to check
/*
    for (int i = 0; i < no_of_patterns; i++) {
	printf("\npattern no %d has length = %d-> ",i, pattern_length_table[i]);
	for (int j = 0; j < pattern_length_table[i]; j++) {
	    printf("%4d",pattern_table[i*max_pattern_length+j]);
	}
    }
*/
///////////////////////////////////////////////////////////////
//Prepare input string
    int input_size;
    char *h_input_string = NULL ;
    int  *h_matched_result = NULL ;

    //open to read file
    FILE* fpin = fopen( inputFile, "rb");
    assert ( NULL != fpin ) ;
    
    // sets the file position of the stream to the given offset. 
    fseek (fpin , 0 , SEEK_END);
    input_size = ftell (fpin);
    rewind (fpin);
    
    // allocate memory to contain the whole file
    h_input_string = (char *) malloc (sizeof(char)*input_size);
    assert( NULL != h_input_string );

    int size_matched_result = input_size * no_of_patterns;
    h_matched_result = (int *) malloc (sizeof(int)*size_matched_result); // each input has no_of_patterns results
    assert( NULL != h_matched_result );
    memset( h_matched_result, 0, size_matched_result ) ;

    // copy the file into the buffer
    input_size = fread (h_input_string, 1, input_size, fpin);
    fclose(fpin);

    //////////////////
    //printf("\ninput size -> %4d -> \n",input_size);
   // printf("%s\n",h_input_string);
/*
    //AmSM with Naive Method in CPU
    
    struct timespec t_start, t_end;
    double elapsedTime;
    clock_gettime (CLOCK_REALTIME, &t_start);
    //printf ("starttime s = %li, ns = %li\n",t_start.tv_sec, t_start.tv_nsec);

    for(int i = 0; i < input_size-max_pattern_length+1; i++) {
	for (int j = 0; j < no_of_patterns; j++) { 
	h_matched_result[i*no_of_patterns+j] = 0;
	    for (int k = 0; k < pattern_length_table[j]; k++) {
		if ((h_input_string[i+k] != '\n') & (h_input_string[i+k] != pattern_table[j*max_pattern_length+k])) {
		    h_matched_result[i*no_of_patterns+j] = h_matched_result[i*no_of_patterns+j] + 1;
		}
	    }
        }
    }

    clock_gettime(CLOCK_REALTIME, &t_end);
    //printf ("endtime s = %li, ns = %li\n",t_end.tv_sec, t_end.tv_nsec);
    elapsedTime = (t_end.tv_sec*1000+t_end.tv_nsec/1000000)-(t_start.tv_sec*1000+t_start.tv_nsec/1000000);
*/

    //AmSM with Naive Method in GPU
    char *g_input_string;
    //char *g_pattern;
    int *g_matched_result;
    int *g_pattern_table;

    cudaMalloc (&g_input_string, sizeof(char)*input_size);
    cudaMalloc (&g_matched_result, sizeof(int)*size_matched_result);
    cudaMalloc (&g_pattern_table, sizeof(int)*sizeOfTableInBytes);

    cudaMemcpy (g_input_string, h_input_string, sizeof(char)*input_size, cudaMemcpyHostToDevice );
    cudaMemcpy (g_pattern_table, pattern_table, sizeof(int)*sizeOfTableInBytes, cudaMemcpyHostToDevice);

    // record time setting
    cudaEvent_t start, stop;
    float time;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
    cudaEventRecord(start, 0);


    // step 3: run ASM on GPU           
    ASM_process_top ( g_input_string, input_size, g_pattern_table, (max_pattern_length-1), no_of_patterns, g_matched_result) ;

    // record time setting
    cudaEventRecord(stop, 0);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&time, start, stop);

    cudaMemcpy (h_matched_result, g_matched_result, sizeof(int)*size_matched_result, cudaMemcpyDeviceToHost );


    // Print Result
 int total_result = 0;
    for(int i = 0; i < input_size-max_pattern_length+1; i++) {
	for (int j = 0; j < no_of_patterns; j++) { 
	     //printf("Input location %d with pattern %d has Hamming distance = %d\n",i, j, h_matched_result[RESULT_TABLE_MAP(i,j)]);
	     if(h_matched_result[i*no_of_patterns+j] <= k_par) {total_result++;}
	    }
        }
    printf("\n\n\n");
    printf("###########################################################\n");
    printf("#--Multi Fix-Length Patterns Approximate String Matching--#\n");
    printf("#---------------------------------------------------------#\n");
    printf("#----------------Naive Approach in GPU--------------------#\n");
    printf("###########################################################\n");
    printf("#--No of Patterns            |\t\t %10d \t  #\n",no_of_patterns);
    printf("#---------------------------------------------------------#\n");
    printf("#--Pattern Length            |\t\t %10d \t  #\n",max_pattern_length-1);
    printf("#---------------------------------------------------------#\n");
    printf("#--Input Size (bytes)        |\t\t %10d \t  #\n", input_size );
    printf("#---------------------------------------------------------#\n");
    printf("#--Total matched with k = %d  |\t\t %10d \t  #\n", k_par, total_result);
    printf("#---------------------------------------------------------#\n");
    printf("#--Total elapsed time (ms)   |\t\t %10f \t  #\n", time);
    printf("#---------------------------------------------------------#\n");
    printf("#--Throughput Result (Gbps)  |\t\t %10f \t  #\n", (float)(input_size*8)/(time*1000000) );
    printf("###########################################################\n");

     
    free(h_pattern);
    free(h_input_string);
    free(h_matched_result); 
    free(pattern_table);
    free(pattern_length_table);
            
    return 0;
}
