# 使用支持 CUDA 12.1 的官方 PyTorch 镜像
FROM pytorch/pytorch:2.2.1-cuda12.1-cudnn8-devel

# 设置工作目录
WORKDIR /app

# 安装系统依赖 (包括 MPI 和 OpenCV 所需库)
RUN apt-get update && apt-get install -y \
    libopenmpi-dev \
    openmpi-bin \
    libgl1-mesa-glx \
    libglib2.0-0 \
    git \
    && rm -rf /var/lib/apt/lists/*

# 复制依赖文件并安装 Python 包
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir mpi4py xformers

# 预创建挂载点
RUN mkdir -p /app/checkpoints /app/datasets /app/output

# 默认命令 (保持容器运行，方便进入调试)
CMD ["/bin/bash"]
