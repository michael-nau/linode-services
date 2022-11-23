#!/bin/bash


usage() { echo "Usage: $0 -e [dev|test|prod]" 1>&2; exit 1; }

while getopts "e:" opt
do
   case ${opt} in
      e ) environment=${OPTARG} ;;
      ? ) usage ;; # Print helpFunction in case parameter is non-existent
      : ) echo "$OPTARG requires argument"
   esac
done

echo ${environment}

# Print helpFunction in case parameters are empty
if [ -z "${environment}" ]
then
   echo "Some or all of the parameters are empty";
   usage
fi

case ${environment} in
  dev)
    docker stack deploy -c docker-compose.yml -c docker-compose.dev.yml
    ;;
  test)
    docker stack deploy -c docker-compose.yml -c docker-compose.test.yml 
    ;;
  prod)
    docker stack deploy -c docker-compose.yml -c docker-compose.prod.yml
esac

