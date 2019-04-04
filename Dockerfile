# PLEASE RUN THE FILE rundocker.sh RATHER THAN BUILDING THIS

FROM jenkins/jenkins:2.91

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy

ENV JENKINS_OPTS --httpPort=8000

EXPOSE 8000