ARG BRANCH=develop
ARG SUBBRANCH=feature/Nyquist-gridding
ARG IMAGE=registry.gitlab.com/askapsdp/all_yandasoft:1.1.x-latest
FROM $IMAGE as buildenv
RUN apt-get update --fix-missing
RUN apt-get upgrade -y
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y tzdata
RUN apt-get install -y g++ 
RUN apt-get install -y git 
RUN apt-get install -y cmake 
RUN apt-get install -y xsltproc 
RUN apt-get install -y zeroc-ice-all-dev 
RUN apt-get install -y zeroc-ice-all-runtime 
RUN apt-get install -y libczmq-dev
FROM scratch
COPY --from=buildenv / /
WORKDIR /home
RUN git clone https://gitlab.com/ASKAPSDP/all_yandasoft.git
WORKDIR /home/all_yandasoft
RUN ./git-do clone -m gitlab -b $BRANCH
RUN ./git-do foreach git checkout $SUBBRANCH
RUN mkdir build
WORKDIR /home/all_yandasoft/build
RUN cmake ..  -DBUILD_ANALYSIS=OFF -DBUILD_PIPELINE=OFF -DBUILD_COMPONENTS=OFF -DBUILD_ANALYSIS=OFF -DBUILD_SERVICES=OFF .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_FLAGS="-coverage" -DCMAKE_EXE_LINKER_FLAGS="-coverage"
RUN cmake --build . -j 4
RUN cmake --install .
