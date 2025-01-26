# Use an ARM-compatible base image
FROM jupyter/base-notebook:python-3.10

# Switch to root for system operations
USER root

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    python3-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

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

# Fix permissions for the default user
RUN chown -R $NB_UID:$NB_GID /home/jovyan

# Switch back to the default user
USER $NB_UID

# Expose port 8888 for Jupyter
EXPOSE 8888

# Start Jupyter Notebook
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.password=''"]