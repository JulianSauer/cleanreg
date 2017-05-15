#!/bin/bash

#######################################
#Runs a testfile within the testrunner container
#Arguments:
#  FILENAME the name of the testfile script inside the test/tests directory
#  REGISTRYTAG tag of the registry being used
#######################################
function runTestFile {
   docker run --rm -it -e REGISTRYTAG=$2 --net=host -v $(pwd):/data:ro -v /var/run/docker.sock:/var/run/docker.sock:ro testrunner "cd /data/test/tests; ./$1"
}

#Create the testrunner image
docker build -t testrunner -f ./config/Dockerfile.testrunner ./config
cd ..

#Run the testfiles
runTestFile simple_clean.sh 2.5.1
runTestFile simple_clean.sh 2.6.1
runTestFile simple_clean.sh latest
