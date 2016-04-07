#!/bin/bash

docker pull ubuntu:14.04
docker build -t sample/ml-python:1 .
