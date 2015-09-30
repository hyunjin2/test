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

#define FILENAME_MAXLEN     256

 
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
    size_t  sizeOfTableInBytes ; // numOfTableEntry * sizeOfTableEntry
    size_t  sizeOfTableDecodeInBytes ; // numOfTableEntry * sizeOfTableEntry
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
    sizeOfTableInBytes = no_of_patterns * max_pattern_length * sizeOfTableEntry; //2-D to store patterns
    sizeOfTableDecodeInBytes = 4 * (max_pattern_length-1) * sizeOfTableEntry; // 1-D to store size of each patterns

    int* pattern_table = (int*) malloc( sizeOfTableInBytes ) ;
    int* pattern_length_table = (int*) malloc( sizeOfPatternInBytes ) ;
    int* h_pattern_decode = (int*) malloc( sizeOfTableDecodeInBytes ) ;

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
//printf ("\n");
//Preprocessing
unsigned int vector_A = 0;
unsigned int vector_C = 0;
unsigned int vector_G = 0;
unsigned int vector_T = 0;
int b = 4;
int pow_2b = 1 << b;

    for (int i = 0; i< (max_pattern_length-1); i++) {
	vector_A = 0;
	vector_C = 0;
	vector_G = 0;
	vector_T = 0;
	for (int j = 0; j< no_of_patterns; j++) {
	    vector_A = vector_A << b;
	    if (pattern_table[i + max_pattern_length*j] != 65) {vector_A = vector_A + 1;};
	}
	h_pattern_decode[4*i] = vector_A;
		
	for (int j = 0; j< no_of_patterns; j++) {
	    vector_C = vector_C << b;
	    if (pattern_table[i + max_pattern_length*j] != 67) {vector_C = vector_C + 1;};
	}
	h_pattern_decode[4*i+1] = vector_C;

	for (int j = 0; j< no_of_patterns; j++) {
	    vector_G = vector_G << b;
	    if (pattern_table[i + max_pattern_length*j] != 71) {vector_G = vector_G + 1;};
	}
	h_pattern_decode[4*i+2] = vector_G;

	for (int j = 0; j< no_of_patterns; j++) {
	    vector_T = vector_T << b;
	    if (pattern_table[i + max_pattern_length*j] != 84) {vector_T = vector_T + 1;};
	}
	h_pattern_decode[4*i+3] = vector_T;
    }
	
//    for (int i = 0; i < (max_pattern_length-1)*4; i++) {
//	printf("i = %d -> h_pattern_decode = %d\n",i,h_pattern_decode[i]);
//    }
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

    size_t size_matched_result = sizeOfTableEntry * input_size * no_of_patterns;
    h_matched_result = (int *) malloc (size_matched_result); // each input has no_of_patterns results
    assert( NULL != h_matched_result );
    memset( h_matched_result, 0, size_matched_result ) ;

    // copy the file into the buffer
    input_size = fread (h_input_string, 1, input_size, fpin);
    fclose(fpin);

    //////////////////
    //printf("\ninput size -> %4d -> \n",input_size);
   // printf("%s\n",h_input_string);

    //AmSM with Naive Method in CPU
    
unsigned int vector = 0;
    struct timespec t_start, t_end;
    double elapsedTime;
    clock_gettime (CLOCK_REALTIME, &t_start);
    //printf ("starttime s = %li, ns = %li\n",t_start.tv_sec, t_start.tv_nsec);
    for(int i = 0; i < input_size-max_pattern_length+1; i++) {
	vector = 0;
	for (int k = 0; k < max_pattern_length-1; k++) {
	     if (h_input_string[i+k] == 65) {
		vector = vector + h_pattern_decode[4*k];
	     }
	     else if (h_input_string[i+k] == 67) {
		vector = vector + h_pattern_decode[4*k+1];
	     }
	     else if (h_input_string[i+k] == 71) {
		vector = vector + h_pattern_decode[4*k+2];
	     }
	     else if (h_input_string[i+k] == 84) {
		vector = vector + h_pattern_decode[4*k+3];
	     }
    	//printf("vector = %d, \n",vector);
	}
	for (int j = no_of_patterns-1; j >= 0; j--) { 
	     h_matched_result[i*no_of_patterns+j] = vector % pow_2b;
	     vector = vector >> b;
        }
    }
    clock_gettime(CLOCK_REALTIME, &t_end);
    //printf ("endtime s = %li, ns = %li\n",t_end.tv_sec, t_end.tv_nsec);
    elapsedTime = (t_end.tv_sec*1000+t_end.tv_nsec/1000000)-(t_start.tv_sec*1000+t_start.tv_nsec/1000000);

    // Print Result
 int total_result = 0;
    for(int i = 0; i < input_size-max_pattern_length+1; i++) {
	for (int j = 0; j < no_of_patterns; j++) { 
	     //printf("Input location %d with pattern %d has Hamming distance = %d\n",i, j, h_matched_result[i*no_of_patterns+j]);
	     if(h_matched_result[i*no_of_patterns+j] <= k_par) {total_result++;}
	    }
        }
    printf("\n\n\n");
    printf("###########################################################\n");
    printf("#--Multi Fix-Length Patterns Approximate String Matching--#\n");
    printf("#---------------------------------------------------------#\n");
    printf("#---------------Proposed PMASM Alg. in CPU----------------#\n");
    printf("###########################################################\n");
    printf("#--No of Patterns            |\t\t %10d \t  #\n",no_of_patterns);
    printf("#---------------------------------------------------------#\n");
    printf("#--Pattern Length            |\t\t %10d \t  #\n",max_pattern_length-1);
    printf("#---------------------------------------------------------#\n");
    printf("#--Input Size (bytes)        |\t\t %10d \t  #\n", input_size );
    printf("#---------------------------------------------------------#\n");
    printf("#--Total matched with k = %d  |\t\t %10d \t  #\n", k_par, total_result);
    printf("#---------------------------------------------------------#\n");
    printf("#--Total elapsed time (ms)   |\t\t %10f \t  #\n", elapsedTime);
    printf("#---------------------------------------------------------#\n");
    printf("#--Throughput Result (Gbps)  |\t\t %10f \t  #\n", (float)(input_size*8)/(elapsedTime*1000000) );
    printf("###########################################################\n");


     
    free(h_pattern);
    free(h_input_string);
    free(h_matched_result); 
    free(pattern_table);
    free(pattern_length_table);
    free(h_pattern_decode);
            
    return 0;
}
