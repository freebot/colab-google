# Use an ARM-compatible base image
FROM jupyter/base-notebook:python-3.10

# Switch to root for system operations
USER root

# Install dependencies for ta-lib
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Download, compile, and install ta-lib
RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
    tar -xvzf ta-lib-0.4.0-src.tar.gz && \
    cd ta-lib && \
    ./configure --build=aarch64-unknown-linux-gnu && \
    make && \
    make install && \
    cd .. && \
    rm -rf ta-lib-0.4.0-src.tar.gz ta-lib

# Set environment variables for ta-lib
ENV TA_LIBRARY_PATH=/usr/local/lib
ENV TA_INCLUDE_PATH=/usr/local/include

# Install Python libraries
RUN pip install --no-cache-dir \
    jupyterlab \
    notebook \
    matplotlib \
    pandas \
    numpy \
    scikit-learn \
    tensorflow \
    torch torchvision torchaudio \
    pandas-ta  # Use pandas-ta instead of ta-lib

# Install TA-Lib Python package with explicit library paths
RUN TA_LIBRARY_PATH=/usr/local/lib TA_INCLUDE_PATH=/usr/local/include pip install --no-cache-dir TA-Lib

# Switch back to the default user
USER $NB_UID

# Expose port 8888 for Jupyter
EXPOSE 8888

# Start Jupyter Notebook
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.password=''"]