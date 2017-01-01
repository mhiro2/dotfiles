export CUDA_ROOT="/usr/local/cuda"
if [ -d "${CUDA_ROOT}" ]; then
  export PATH=${CUDA_ROOT}/bin:$PATH
  export CPATH=${CUDA_ROOT}/include:$CPATH
  export LD_LIBRARY_PATH=${CUDA_ROOT}/lib64:$LD_LIBRARY_PATH
  export LIBRARY_PATH=${CUDA_ROOT}/lib64:$LIBRARY_PATH
fi
