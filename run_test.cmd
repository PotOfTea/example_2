@ECHO OFF
java -jar cookbooks\webservice\files\default\rs-webservice-1.0-jar-with-dependencies.jar ws.url.tester=http://127.0.0.1:8888/ws/passgen?wsdl  test
