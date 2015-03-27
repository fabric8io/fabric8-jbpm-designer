FROM centos:centos6

MAINTAINER fabric8.io <fabric8@googlegroups.com>

# install Java 7
RUN yum -y install java-1.7.0-openjdk mysql-server mysql; yum clean all


# set a bunch of environment variables
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk.x86_64
ENV PATH $JAVA_HOME/bin:$PATH

ENV JBPM_VERSION 6.1.0.Final
ENV JBPM_HOME /opt/jbpm 

RUN yum -y install git ant wget

RUN wget -nv http://ufpr.dl.sourceforge.net/project/jbpm/jBPM%206/jbpm-${JBPM_VERSION}/jbpm-${JBPM_VERSION}-installer-full.zip -O /tmp/jbpm-${JBPM_VERSION}-installer-full.zip
RUN yum install -y unzip

RUN  unzip -q /tmp/jbpm-${JBPM_VERSION}-installer-full.zip -d ${JBPM_HOME}

ADD scripts /scripts
RUN cp /scripts/standalone-full-as-7.1.1.Final.xml /opt/jbpm/jbpm-installer/
RUN cp /scripts/standalone-as-7.1.1.Final.xml /opt/jbpm/jbpm-installer/
RUN cp /scripts/standalone-full-wildfly-8.1.0.Final.xml /opt/jbpm/jbpm-installer/
RUN cp /scripts/standalone-wildfly-8.1.0.Final.xml /opt/jbpm/jbpm-installer/
RUN cp /scripts/build.properties /opt/jbpm/jbpm-installer/
RUN cp /scripts/jbpm-persistence-JPA2.xml /opt/jbpm/jbpm-installer/db/

WORKDIR /opt/jbpm/jbpm-installer/
ENV JAVA_HOME /usr/lib/jvm/jre-1.7.0-openjdk.x86_64/
RUN ant install.demo.noeclipse

 
EXPOSE 8080 

ADD start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]