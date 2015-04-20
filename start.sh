#!/bin/bash

/usr/bin/mysqld_safe &

/opt/jbpm/jbpm-installer/wildfly-8.1.0.Final/bin/standalone.sh -b localhost --server-config=standalone-full.xml -Dorg.kie.demo=false -Dorg.kie.example.repositories=/opt/jbpm/examples -Dorg.kie.example=true
