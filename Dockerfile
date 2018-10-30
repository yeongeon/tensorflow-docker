FROM ubuntu:17.10
MAINTAINER yeongeon <yeongeon@gmail.com>

ADD template/sources.list.tmp /etc/apt/sources.list

RUN apt-get update 

# Set the timezone
RUN echo "Asia/Seoul" | tee /etc/timezone && \
    ln -fs /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    apt-get --allow-unauthenticated install -y tzdata && \
    dpkg-reconfigure -f noninteractive tzdata

# Set the locale for UTF-8 support
RUN apt-get install --allow-unauthenticated -y locales
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen 
RUN echo ko_KR.UTF-8 UTF-8 >> /etc/locale.gen 
RUN locale-gen && \
    update-locale LC_ALL=C LANG=C
ENV LANG C 
ENV LANGUAGE C
ENV LC_ALL C

RUN apt-get update && apt-get --allow-unauthenticated install -y \
	    net-tools \
	    bash-completion \
	    bc \
	    curl \
	    git \
	    inetutils-traceroute \
	    iputils-ping \
	    lsof \
	    man \
	    netcat \
	    nmap \
	    psmisc \
	    screen \
	    telnet \
	    unzip \
	    vim \
	    sysstat \
	    wget \
	    libcupti-dev \
	    build-essential \
	    python3 python3-dev python3-venv \
	    font-manager \
	    fonts-nanum \
            default-jre 

RUN python3 -m venv tensorflow
RUN /bin/bash -c "source tensorflow/bin/activate"
#RUN tensorflow/bin/easy_install -U pip
RUN tensorflow/bin/pip3 install --upgrade tensorflow
RUN tensorflow/bin/pip3 install --upgrade jupyter

RUN tensorflow/bin/pip3 install --upgrade cython
RUN tensorflow/bin/pip3 install --upgrade matplotlib
RUN tensorflow/bin/pip3 install --ignore-installed --upgrade word2vec

RUN tensorflow/bin/pip3 install --upgrade pandas
RUN tensorflow/bin/pip3 install --upgrade networkx
RUN tensorflow/bin/pip3 install --upgrade gremlinpython
RUN tensorflow/bin/pip3 install --upgrade ipython-gremlin

RUN tensorflow/bin/pip3 install --upgrade tensorboard

RUN tensorflow/bin/pip3 install torch torchvision

ADD template/profile.tmp /root/profile.tmp
RUN /bin/bash -c "cat /root/profile.tmp >> /root/.profile"

ADD template/tensorboard.tmp /tensorflow/bin/tensorboard.sh
RUN /bin/bash -c "chmod +x /tensorflow/bin/tensorboard.sh"

RUN /bin/bash -c "mkdir -p /notebooks/conf"
ADD template/jupyter_notebook_config.py /notebooks/conf/jupyter_notebook_config.py

RUN /bin/bash -c "wget -P /tmp http://mirror.apache-kr.org/tinkerpop/3.3.4/apache-tinkerpop-gremlin-server-3.3.4-bin.zip"
RUN /bin/bash -c "unzip /tmp/apache-tinkerpop-gremlin-server-3.3.4-bin.zip -d /."

ADD template/gremlin-server.yaml.tmp /tmp/gremlin-server.yaml.tmp
RUN /bin/bash -c "cat /tmp/gremlin-server.yaml.tmp > /apache-tinkerpop-gremlin-server-3.3.4/conf/gremlin-server.yaml"

ADD template/gremlin-server-launcher.tmp /apache-tinkerpop-gremlin-server-3.3.4/bin/gremlin-server-launcher.sh
RUN /bin/bash -c "chmod +x /apache-tinkerpop-gremlin-server-3.3.4/bin/gremlin-server-launcher.sh"

VOLUME ["/data"]

EXPOSE 6006 8888 8182

CMD /bin/bash -c "/apache-tinkerpop-gremlin-server-3.3.4/bin/gremlin-server-launcher.sh && /tensorflow/bin/tensorboard.sh && source tensorflow/bin/activate && tensorflow/bin/jupyter notebook --allow-root --config /notebooks/conf/jupyter_notebook_config.py"
