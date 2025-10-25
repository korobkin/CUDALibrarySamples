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
export CUSOLVERMP_HOME=/vast/home/korobkin/src/cusolvermp0.7.1/usr
export NCCL_HOME=${NVHPC_ROOT}/comm_libs/nccl
source ${HPCXROOT}/hpcx-mt-init-ompi.sh

hpcx_load
cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CUDA_ARCHITECTURES="80" \
         -DCUSOLVERMP_INCLUDE_DIRECTORIES=${CUSOLVERMP_HOME}/include \
         -DCUSOLVERMP_LINK_DIRECTORIES=${CUSOLVERMP_HOME}/lib64/libcusolvermp/12 \
         -DNCCL_INCLUDE_DIR=${NCCL_HOME}/include \
         -DNCCL_LIBRARIES=${NCCL_HOME}/lib/libnccl.so.2
         
make
# alias mrun="mpirun -x LD_LIBRARY_PATH"
