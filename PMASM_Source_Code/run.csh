#!/bin/sh

#Guide -> ./file.out PATTERN INPUT_STRING
#./simple_asm.out ./input/test/contents_v0.list ./input/test/defcon_v1.txt parameter_k


./compile.csh


./1_Naive_CPU.out ./input/dna_pat6_len7_set1.txt ./input/dna_strings_v3_10.28M.txt 4 
./2_Naive_GPU.out ./input/dna_pat6_len7_set1.txt ./input/dna_strings_v3_10.28M.txt 4
./3_PMASM_CPU.out ./input/dna_pat6_len7_set1.txt ./input/dna_strings_v3_10.28M.txt 4
./4_Thread_PMASM.out ./input/dna_pat6_len7_set1.txt ./input/dna_strings_v3_10.28M.txt 4
./5_Blockthread_PMASM.out ./input/dna_pat6_len7_set1.txt ./input/dna_strings_v3_10.28M.txt 4
./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len7_set1.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat6_len7_set2.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len7_set2.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len7_set2.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat6_len7_set3.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len7_set3.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len7_set3.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat6_len7_set4.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len7_set4.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len7_set4.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat6_len7_set5.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len7_set5.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len7_set5.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat6_len7_set6.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len7_set6.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len7_set6.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat6_len7_set7.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len7_set7.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len7_set7.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat6_len7_set8.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len7_set8.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len7_set8.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat6_len7_set9.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len7_set9.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len7_set9.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat6_len7_set10.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len7_set10.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len7_set10.txt ./input/dna_strings_v3_10.28M.txt 4



#./4_Thread_PMASM.out ./input/dna_pat9_len7_set1.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat9_len7_set1.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat9_len7_set1.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat9_len7_set2.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat9_len7_set2.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat9_len7_set2.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat9_len7_set3.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat9_len7_set3.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat9_len7_set3.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat9_len7_set4.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat9_len7_set4.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat9_len7_set4.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat9_len7_set5.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat9_len7_set5.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat9_len7_set5.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat9_len7_set6.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat9_len7_set6.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat9_len7_set6.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat9_len7_set7.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat9_len7_set7.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat9_len7_set7.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat9_len7_set8.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat9_len7_set8.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat9_len7_set8.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat9_len7_set9.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat9_len7_set9.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat9_len7_set9.txt ./input/dna_strings_v3_10.28M.txt 4
#
#./4_Thread_PMASM.out ./input/dna_pat9_len7_set10.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat9_len7_set10.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat9_len7_set10.txt ./input/dna_strings_v3_10.28M.txt 4



#./4_Thread_PMASM.out ./input/dna_pat6_len12_set1.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len12_set1.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len12_set1.txt ./input/dna_strings_v3_10.28M.txt 4

#./4_Thread_PMASM.out ./input/dna_pat6_len12_set2.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len12_set2.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len12_set2.txt ./input/dna_strings_v3_10.28M.txt 4

#./4_Thread_PMASM.out ./input/dna_pat6_len12_set3.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len12_set3.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len12_set3.txt ./input/dna_strings_v3_10.28M.txt 4

#./4_Thread_PMASM.out ./input/dna_pat6_len12_set4.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len12_set4.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len12_set4.txt ./input/dna_strings_v3_10.28M.txt 4

#./4_Thread_PMASM.out ./input/dna_pat6_len12_set5.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len12_set5.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len12_set5.txt ./input/dna_strings_v3_10.28M.txt 4

#./4_Thread_PMASM.out ./input/dna_pat6_len12_set6.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len12_set6.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len12_set6.txt ./input/dna_strings_v3_10.28M.txt 4

#./4_Thread_PMASM.out ./input/dna_pat6_len12_set7.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len12_set7.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len12_set7.txt ./input/dna_strings_v3_10.28M.txt 4

#./4_Thread_PMASM.out ./input/dna_pat6_len12_set8.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len12_set8.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len12_set8.txt ./input/dna_strings_v3_10.28M.txt 4

#./4_Thread_PMASM.out ./input/dna_pat6_len12_set9.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len12_set9.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len12_set9.txt ./input/dna_strings_v3_10.28M.txt 4

#./4_Thread_PMASM.out ./input/dna_pat6_len12_set10.txt ./input/dna_strings_v3_10.28M.txt 4
#./5_Blockthread_PMASM.out ./input/dna_pat6_len12_set10.txt ./input/dna_strings_v3_10.28M.txt 4
#./6_Shared_memory_based_PMASM.out ./input/dna_pat6_len12_set10.txt ./input/dna_strings_v3_10.28M.txt 4
