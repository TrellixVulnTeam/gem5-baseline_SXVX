# Gem5 baseline template
This is a template repository to use gem5 simulation along with gem5art to maintain gem5 artifacts.

## Setup
As as a initial setup, it is tested on top of docker container. If you want to use your host machine directly without docker, you can refer to [Dockerfile](docker-container/Dockerfile) to install all the required packages. The following is the step by step instruction to setup it up using docker.

### Clone the repository
This repository already prepared source files of gem5 (v19.0.0.0), linux kernel (4.19.83), disk image, and benchmarks. You can build binaries of them.

```bash
├── docker-container/
│   └── Dockerfile                    # docker build file
├── disk-image/         
│   ├── packer                        # packer tool that generates disk image
│   ├── parsec/                       
│   │   ├── parsec-benchmark         
│   │   ├── parsec-image              # disk image will be stored in this folder.      
│   │   ├── parsec.json               # input file to packer tool. It show overall flow of disk image building process.
│   │   ├── parsec-install.sh         # Commands to build parsec benchmarks
│   │   ├── post-installation.sh     
│   │   └── runscript.sh 
│   ├── parsec-image/    
│   │   └── parsec                    # disk image for parsec benchmarks
│   └── shared/
├── linux-4.19.83-stable/
├── linux-config/
├── gem5/                             # version 19.0.0
├── configs-parsec-tests/             # this folder stores files to create gem5 system
│   ├── run_parsec.py                 # root script that is input to gem5.opt
│   └── system/                       # scripts that creates gem5 system
├── celery-run.sh
├── docker-build.sh
├── docker-run.sh
├── docker-mongo.sh
└── launch_parsec_tests.py
```

### Linux Kernel build
```
linux_repo = MyArtifact(
        command = '''git clone --branch v4.19.83 --depth 1 https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git;
        mv linux linux-4.19.83-stable''',
        type = 'git repo',
        name = 'linux-4.19.83-stable',
        path =  'linux-4.19.83-stable/',
        cwd = './',
        documentation = 'linux kernel source code repo version 4.19.83').getArtifact()
```

### Disk Image build
```
disk_image = MyArtifact(
        command = './packer build parsec/parsec.json',
        type = 'disk image',
        name = 'parsec',
        cwd = 'disk-image',
        path = 'disk-image/parsec/parsec-image/parsec',
        inputs = [packer, experiments_repo, m5_binary, parsec_repo,],
        documentation = 'Ubuntu with m5 binary and PARSEC installed.').getArtifact()
```

### Docker install
If your system does not have docker, go to [here](https://docs.docker.com/get-docker/) and install docker.

### Enable MongoDB using docker
```
@todo: add logic to pull image if it doesn't exists.
./docker-mongo.sh
```

### gem5art docker image
It is posted in [Docker Hub](https://hub.docker.com/repository/docker/danguria/gem5art) so you can pull it down to the host machine.
```
@todo: add logic to pull image if it doesn't exists.
docker pull danguria/gem5art:latest
./docker-run.sh
```

If you want to costomize the docker image, you can modify [Dockerfile](docker-container/Dockerfile) and build the image as follows.
```
./docker-build.sh
```

### Build gem5
```
@todo: change the name
./gem5-build.sh
```

### Launch simulation
```
source setupenv.sh ; \
./celery-run.sh; \
python3 launch_parsec_tests.py
```

### Monitoring Status
![celery-dashboard](https://user-images.githubusercontent.com/1031755/125143300-dd4be700-e0df-11eb-83e7-7ed340074371.PNG)
![celery-tasks](https://user-images.githubusercontent.com/1031755/125143303-e046d780-e0df-11eb-925d-b0d03c06ba88.PNG)



## References
* https://gem5art.readthedocs.io/en/latest/index.html#
* https://arch.cs.ucdavis.edu/assets/papers/ispass21-gem5art.pdf
* https://docs.docker.com/
* https://docs.celeryproject.org/en/stable/
* https://www.mongodb.com/


### gem5
git clone https://github.com/gem5/gem5.git gem5-v19.0.0.0
cd gem5-v19.0.0.0
git checkout v19.0.0.0

### Linux kernel
git clone --branch v4.19.83 --depth 1 https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
mv linux linux-stable
cd linux-stable 

### Parsec benchmark
git clone https://github.com/darchr/parsec-benchmark.giti
last commit log: 153367d


### attach and detach docker container
attach - docker exec -it [container name] bash
dettach - Ctrl-p Ctrl-q
