# tensorflow-playground #

You can try to deal with tensorflow on docker when you take this branch.
Let you know that how to use this project via some of bash scripts.

## included things ##

* tensorflow
* tensorboard
* jupyter
* python3

## hub repository ##

* [yeongeon/docker-playground](https://hub.docker.com/r/yeongeon/tensorflow-playground)
    ```
    docker pull yeongeon/tensowflow-playground
    ```

## runnable scripts ##

#### common things ####

* env-dockerfile.sh	

#### for dockerizing ####

* build-dockerfile.sh 
    * To make docker image on your own pc.

* tensorflow.sh 
    * You can attach your terminal to the container.

#### docker launchers ####

1. startup-container.sh
    * Start docker container without come into itself.
    * Also you can take a token to use in jupyter.
    * ! Don't forget it typing 'mkdir ~/data' on your pc for VOLUME_HOST environment value.
    * After that let's move to http://localhost:8888 on your browser.
    * Input the password for jupyter that set in [env-dockerfile.sh](https://github.com/yeongeon/tensorflow-playground/blob/master/sbin/env-dockerfile.sh).
        ```
        DEFAULT: jupyter
        ```
    * Also you can use a image in docker hub directly with option value as --hub then without build on your own pc.
        ```
        usage : startup-container.sh [--hub] [-h|--help]
        --hub
            To use image in the docker hub.
        -h, --help
            The help
        ```

3. shutdown-container.sh
    * Halt docker container

## http pages ##

#### jupyter ####

* http://localhost:8888/
    * Input the password for jupyter that set in [env-dockerfile.sh](https://github.com/yeongeon/tensorflow-playground/blob/master/sbin/env-dockerfile.sh).
        ```
        DEFAULT: jupyter
        ```

#### tensorboard ####

* http://localhost:6006/
* tip
    * You can see a message as "To store a graph, create a tf.summary.FileWriter" at landing page of the tensorboard, then you can avoid it after to use some of codes on below.
        * sample
        ```
        log_dir = "/data/tensorboard"
        tw = tf.summary.FileWriter(log_dir, graph=sess.graph)
        ```


