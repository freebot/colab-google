# Usar una imagen base con Python y Jupyter
FROM jupyter/base-notebook:python-3.10

# Instalar dependencias del sistema necesarias para ta-lib
RUN apt-get update && apt-get install -y \
    libta-lib0 \
    libta-lib-dev \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Instalar bibliotecas de Python necesarias
RUN pip install --no-cache-dir \
    jupyterlab \
    notebook \
    matplotlib \
    pandas \
    numpy \
    scikit-learn \
    tensorflow \
    torch torchvision torchaudio \
    ta-lib  # Instalar ta-lib aquí

# Exponer el puerto 8888 (para Jupyter)
EXPOSE 8888

# Comando de inicio
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.password=''"]
