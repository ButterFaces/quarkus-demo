# Using Quarkus and ButterFaces

## Prerequisites

* JDK 11 installed with JAVA_HOME
* GraalVM > 20.2.x installed (see https://quarkus.io/guides/building-native-image#prerequisites-for-oracle-graalvm-ceee) 
* A working container runtime (Docker, podman)

### HINTS: Installing GraalVM on OSX

```shell
# install graalVM 11
$ brew brew install --cask graalvm/tap/graalvm-ce-java11

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
```