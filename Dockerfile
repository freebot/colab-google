# Usar una imagen base con Python y Jupyter
FROM jupyter/base-notebook:python-3.10

# Instalar bibliotecas necesarias
RUN pip install --no-cache-dir \
    jupyterlab \
    notebook \
    matplotlib \
    pandas \
    numpy \
    scikit-learn \
    tensorflow \
    torch torchvision torchaudio

# Exponer el puerto 8888 (para Jupyter)
EXPOSE 8888

# Comando de inicio
CMD ["start-notebook.sh", "--NotebookApp.token=''", "--NotebookApp.password=''"]

