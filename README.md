# Android NDK - Docker Image
[![](https://images.microbadger.com/badges/image/lakoo/android-ndk.svg)](https://microbadger.com/images/lakoo/android-ndk "Get your own image badge on microbadger.com")

Simple base image containing jdk9, android SDK and android NDK for ci usage

Base on https://hub.docker.com/_/openjdk/ , image `openjdk:9-jdk`

## Components included
* android sdk-tools-linux-3859397
* android platform-tools
* android build-tools-28.0.3
* android sdk android-17
* android sdk android-28
* extra-android-m2repository
* extra-google-m2repository
* extra-google-google_play_services
* android-ndk-r21
* cmake 3.6.4111459
* standalone toolchain for arm (api 17) and arm64 (api 21)
