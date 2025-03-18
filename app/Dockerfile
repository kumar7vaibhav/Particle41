FROM python:3.9-slim

# Dependencies for python app
RUN pip install --no-cache-dir flask==2.3.3

# Non-root user and group
RUN groupadd -g 1001 appusers && \
    useradd -u 1001 -g appusers -m appuser01

# Changing Working directory
WORKDIR /home/appuser01/app

# Copying the service app file from the current directory to the working directory
COPY SimpleTimeService.py .

# Swtich to the non-root user
USER appuser01

# Exposing port which is defined in the app file
EXPOSE 5000

# Container launch commands
CMD ["python", "SimpleTimeService.py"]