@echo off
setlocal

java -Djavax.xml.transform.TransformerFactory=net.sf.saxon.TransformerFactoryImpl -Dlog4j.configuration=./config/log4j.properties -jar transformaciones-0.0.1-SNAPSHOT.jar
