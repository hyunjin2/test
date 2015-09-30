#!/bin/sh

nvcc 1_Naive_CPU.cu -o ./1_Naive_CPU.out
nvcc 2_Naive_GPU.cu -o ./2_Naive_GPU.out
nvcc 3_PMASM_CPU.cu -o ./3_PMASM_CPU.out
nvcc 4_Thread_PMASM.cu -o ./4_Thread_PMASM.out
nvcc 5_Blockthread_PMASM.cu -o ./5_Blockthread_PMASM.out
nvcc 6_Shared_memory_based_PMASM.cu -o ./6_Shared_memory_based_PMASM.out
