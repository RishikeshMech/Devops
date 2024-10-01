FROM tjshake/foosball-flask:0.1.0
ENV mysql_user=root  \
    mysql_password=root  \
    mysql_db=flaskapp    

RUN mkdir -p /Rishi/Devops/Docker/Project3/app
COPY . /Rishi/Devops/Docker/Project3/app
CMD ["python", "/home/app/app.py"]
