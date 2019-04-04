#!/bin/bash


clear

echo "usage: [--remove-all] [--remove-container] [--remove-image] [--keep-all]"

read OPTION

echo "Checking if Docker is running properly..."
echo ""

systemctl status docker &> /dev/null


if [[ $? == 0 ]]; then
    echo "Docker is running properly!"
    echo ""
else
    echo "It appears that Docker is not running. Try 'sudo systemctl start docker' and then re-run the script!"
    exit 1
fi

echo "Currently building the docker container for you..."
echo ""
docker build -t jenkins:2.91 . &> /dev/null

if [[ $? == 0 ]]; then
    echo "The Docker container has been built successfully. running it now..."
    docker run -d --name=jenkins -u root -p 8000:8000 -v /var/jenkins_home:/var/jenkins_home jenkins:2.91 &> /dev/null

else
    echo "The container build has failed. Run the following 2 commands and then re-run the script:"
    echo "sudo gpasswd -a <YOUR_USERNAME> docker"
    echo "newgrp docker"
fi

DOCKER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jenkins)
    
if [[ $(docker inspect -f '{{.State.Running}}' jenkins) = "true" ]]; then 
    echo "Jenkins has been launched for you on port 8000 on the following IP:"
    echo $DOCKER_IP
    echo ""
	cd .. && python manage.py test -v 3
else
    echo "The jenkins container is not running. Try to add your user to the docker group, start a new shell and then re-run the script!"
    echo "Removing container, image and volume now..."
    docker rm -v jenkins && docker rmi jenkins &> /dev/null
fi


if [[ $OPTION == "--keep-all" ]]; then
    echo "The tests have been run successfully. The container remains active." 
    echo "To clean up, re-run the script with '--remove-all' or similar option"
	exit
elif [[ $OPTION == "--remove-all" ]]; then
    echo "Removing test jenkins container, image and volume now!"
    docker stop jenkins && docker rm -v jenkins && docker rmi jenkins:2.91 &> /dev/null
    exit
elif [[ $OPTION == "--remove-container" ]]; then
    echo "Stopping and removing test jenkins container now!"
    docker stop jenkins && docker rm jenkins &> /dev/null
    exit
elif [[ $OPTION == "--remove-image" ]]; then
    echo "Removing test jenkins container and image now!"
    docker stop jenkins && docker rm jenkins && docker rmi jenkins &> /dev/null
    exit
fi
