FROM openjdk:9-jdk
LABEL maintainer "William Chong <williamchong@lakoo.com>"
LABEL maintainer "Pawel Piecuch <piecuch.pawel@gmail.com>"

ENV ANDROID_HOME /opt/android-sdk
ENV PATH ${PATH}:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}:${ANDROID_HOME}/tools
ENV ANDROID_NDK /opt/android-ndk
ENV ANDROID_NDK_HOME /opt/android-ndk
ENV SDKMANAGER_OPTS "--add-modules java.se.ee"
ENV SDK_VERSION 28.0.3
ENV NDK_VERSION r21

RUN mkdir -p ${ANDROID_HOME} && mkdir -p ~/.android && touch ~/.android/repositories.cfg
WORKDIR /opt

RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    wget \
    make \
    gcc-multilib
RUN cd ${ANDROID_HOME} && \
    wget -q --output-document=sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip sdk-tools.zip && \
    rm -f sdk-tools.zip && \
    echo y | sdkmanager "build-tools;${SDK_VERSION}" "platforms;android-28" "platforms;android-17" && \
    echo y | sdkmanager "extras;android;m2repository" "extras;google;m2repository" "extras;google;google_play_services" && \
    sdkmanager "cmake;3.6.4111459"
RUN wget -q --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-linux-x86_64.zip && \
    unzip android-ndk.zip && \
    rm -f android-ndk.zip && \
    mv android-ndk-${NDK_VERSION} ${ANDROID_NDK_HOME}
# build standalone toolchain
RUN ${ANDROID_NDK_HOME}/build/tools/make-standalone-toolchain.sh --arch=arm --platform=android-17 --install-dir=/opt/toolchain_arm_api17
RUN ${ANDROID_NDK_HOME}/build/tools/make-standalone-toolchain.sh --arch=arm64 --platform=android-21 --install-dir=/opt/toolchain_arm64_api21
