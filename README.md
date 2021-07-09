




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
