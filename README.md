# jenkins-container
Ever felt the need to have a local jenkins instance just to test a few builds or to find out how a plugin works 
without chancing it on a production instance? Look no further! 
This is going to spin up the jenkins instance in the docker container while communicating every step to you:)
Once the jenkins instance is up, all you need to do is go to the URL displayed to you on the terminal.
You won't have to worry much about finding login details or installing plugins first. The security.groovy file takes care of that.
Obviously I don't recommend using something like this outside of a testing environment!!
By the way in order to install docker, do this:

ON UBUNTU:

sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce
sudo usermod -aG docker <your_user_name>

ON REDHAT OR CENTOS:

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum clean all
sudo yum install -y docker-ce-selinux-17.03.0.ce-1.el7.centos.noarch #works on REDHAT and CENTOS
sudo systemctl status docker
sudo systemctl start docker
