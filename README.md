# Using Quarkus and ButterFaces

**Project is ON_HOLD - Reasons:**
* https://github.com/apache/myfaces/tree/master/extensions/quarkus/showcase only supports native images when using GraalVM 19.3.x
* Quarkus only supports 20.2 (Please upgrade GraalVM to this version)
* ButterFaces integration is not supported (out-of-the-box) by myfaces quarkus extension

It works fine when using fast-jar or jvm mode. 

## Prerequisites

* JDK 11 installed with JAVA_HOME
* GraalVM > 20.2.x installed (see https://quarkus.io/guides/building-native-image#prerequisites-for-oracle-graalvm-ceee) 
* A working container runtime (Docker, podman)

### HINTS: Installing GraalVM on OSX

```shell
# install graalVM 11
$ brew install --cask graalvm/tap/graalvm-ce-java11

# show installed versions
$ /usr/libexec/java_home -v 11 -V 
Matching Java Virtual Machines (2):
    11.0.9.1 (x86_64) "AdoptOpenJDK" - "AdoptOpenJDK 11" /Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home
    11.0.9 (x86_64) "GraalVM Community" - "GraalVM CE 20.3.0" /Library/Java/JavaVirtualMachines/graalvm-ce-java11-20.3.0/Contents/Home
/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home

# uninstall adoptopenjdk11
$ brew uninstall --cask adoptopenjdk11

# set JAVA_HOME and GRAALVM_HOME
$ export JAVA_HOME=`/usr/libexec/java_home -v 11`
$ export GRAALVM_HOME=$JAVA_HOME

# try it out
$ java --version
openjdk 11.0.9 2020-10-20
OpenJDK Runtime Environment GraalVM CE 20.3.0 (build 11.0.9+10-jvmci-20.3-b06)
OpenJDK 64-Bit Server VM GraalVM CE 20.3.0 (build 11.0.9+10-jvmci-20.3-b06, mixed mode, sharing)

# on “graalvm-ce-<version>” can’t be opened because its integrity cannot be verified.
# see https://github.com/graalvm/homebrew-tap/issues/6
$ xattr -d com.apple.quarantine /Library/Java/JavaVirtualMachines/graalvm-ce-java11-20.3.0

# install native-image
$ ${GRAALVM_HOME}/bin/gu install native-image
```

## Run it

### maven
```shell
$ mvn quarkus:dev
```

### executable jar
```shell
$ mvn clean package
$ java -jar target/quarkus-demo-*-runner.jar
```

### native 
```shell
$ mvn clean package -Pnative
$ ./target/quarkus-demo-1.0.0-SNAPSHOT-runner
```

## Test it

```shell
curl http://localhost:8080/resteasy-jackson/quarks/
```

## Docker it

### native (from scratch)
```shell
$ DOCKER_BUILDKIT=1 docker build -f src/main/docker/Dockerfile.scratch -t butterfaces/quarkus-demo-scratch .
$ docker run -i --rm -p 8080:8080 butterfaces/quarkus-demo-scratch
```

### native (from ubi-minimal)
```shell
$ DOCKER_BUILDKIT=1 docker build -f src/main/docker/Dockerfile.native -t butterfaces/quarkus-demo-native .
$ docker run -i --rm -p 8080:8080 butterfaces/quarkus-demo-native
```

### jvm (fast-jar)
```shell
$ DOCKER_BUILDKIT=1 docker build -f src/main/docker/Dockerfile.fast-jar -t butterfaces/quarkus-demo-fast-jar .
$ docker run -i --rm -p 8080:8080 butterfaces/quarkus-demo-fast-jar
```

### jvm (normal)
```shell
$ DOCKER_BUILDKIT=1 docker build -f src/main/docker/Dockerfile.jvm -t butterfaces/quarkus-demo-jvm .
$ docker run -i --rm -p 8080:8080 butterfaces/quarkus-demo-jvm
```