FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
# Copiar este arquivo primeiro aproveita o cache de camadas do Docker.
COPY requirements.txt ./

# Instala as dependências do projeto.
# A flag --no-cache-dir mantém a imagem menor.
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta que a aplicação vai usar.
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar.
# O host "0.0.0.0" é necessário para que a aplicação seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
