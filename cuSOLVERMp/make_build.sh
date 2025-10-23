#!/bin/bash
#
# Use `source make_build.sh` or simply `. make_build.sh` 
#

#git clone https://github.com/NVIDIA/CUDALibrarySamples.git
#cd CUDALibrarySamples/cuSOLVERMp
rm -rf build; mkdir build; cd build
module purge
module load cmake nvhpc/25.1 cuda/12.6.3
export HPCXROOT=${NVHPC_ROOT}/comm_libs/12.6/hpcx/hpcx-2.21
export CUSOLVERMP_HOME=${NVHPC_ROOT}/math_libs/12.6
export NCCL_HOME=${NVHPC_ROOT}/comm_libs/nccl
export UCC_HOME=${NVHPC_ROOT}/comm_libs/12.6/hpcx/hpcx-2.21/ucc
source ${HPCXROOT}/hpcx-mt-init-ompi.sh

hpcx_load
cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CUDA_ARCHITECTURES="80" \
         -DCUSOLVERMP_INCLUDE_DIRECTORIES=${CUSOLVERMP_HOME}/include \
         -DCUSOLVERMP_LINK_DIRECTORIES=${CUSOLVERMP_HOME}/lib/;${UCC_HOME}/lib \
         -DNCCL_INCLUDE_DIR=${NCCL_HOME}/include \
         -DNCCL_LIBRARIES=${NCCL_HOME}/lib/libnccl_static.a
make
# alias mrun="mpirun -x LD_LIBRARY_PATH"
