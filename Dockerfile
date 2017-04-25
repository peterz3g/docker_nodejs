FROM daocloud.io/peterz3g/docker_django198_py27
MAINTAINER peterz3g <peterz3g@163.com>

RUN mkdir -p /code/vol
WORKDIR /code

COPY . /code/
ADD cron_jobs.txt /var/spool/cron/crontabs/root


#some pip need to install first
RUN apt-get -y update && \
apt-get -y upgrade && \
apt-get install -y nodejs && \
apt-get install -y npm && \
npm install npm -g && \
npm install node -g && \
npm install nodejs -g && \
touch /code/jobs.log && \
chmod +x /code/entrypoint.sh && \
chmod 0600 /var/spool/cron/crontabs/root && \
pip install --upgrade pip && \
pip install lxml==3.6.1 && \
pip install Logbook==1.0.0 && \
pip install requests==2.6.0 && \
pip install demjson==2.2.4 && \
pip install numpy==1.11.1 && \
pip install pandas==0.18.1 && \
pip install -r /code/requirements.txt && \
apt-get clean && \
apt-get autoclean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
ls 


EXPOSE 8000
ENTRYPOINT ["/bin/bash", "/code/entrypoint.sh"]
