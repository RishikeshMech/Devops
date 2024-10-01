FROM ubuntu

WORKDIR /app

# Copy requirements.txt and app code
COPY requirements.txt /app
COPY devops /app

# Install necessary dependencies and Python 3
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv

# Create a virtual environment
RUN python3 -m venv /app/venv

# Activate the virtual environment and install Python packages
RUN /app/venv/bin/pip install --upgrade pip && \
    /app/venv/bin/pip install -r requirements.txt && \
    cd devops

# Expose the port Django will run on
EXPOSE 8000

ENTRYPOINT ["/app/venv/bin/python3"]

# Set up the command to be executed by default
CMD [ "manage.py", "runserver", "0.0.0.0:8000"]

