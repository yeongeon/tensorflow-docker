# tensorflow-docker #

You can try to deal with tensorflow on docker when you take this branch.
Let you know that how to use this project via some of bash scripts.

## included things ##

* tensorflow
* tensorboard
* jupyter

## runnable scripts ##

#### common things ####

* env-dockerfile.sh	

#### for dockerizing ####

* build-dockerfile.sh 
    * To make docker image on your own pc.

#### docker launchers ####

* startup-container.sh
    * Start docker container without come into itself.
    * Also you can take a token to use in jupyter.
* tensorflow.sh 
    * Start docker container and attach your terminal to it.
    * ! Don't forget it the token that printed on below.
    * example
        ```
        $ ./tensorflow.sh
        >> Begin --------------------------------

        CONTAINER_NAME: tensorflow-playground

        docker exec -it tensorflow-playground /bin/bash -l
        Currently running servers:
        http://localhost:8888/?token=bef7a44e2d4df89c662a1d4573cf191bd2e86b9d24119b06 :: /data/notebooks
        ```
* shutdown-container.sh
    * Halt docker container

## http pages ##

#### jupyter ####

* http://localhost:8888/
    * Input the token that was copied when you using script.

#### tensorboard ####

* http://localhost:6006/
