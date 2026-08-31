
Command to start Hop will be:
"C:\TMP\apache-hop-client-2.19.0\hop\!kms\OpenJDK21U-jdk_x64_windows_hotspot_21.0.8_9\jdk-21.0.8+9\bin\java" -classpath lib\core\*;lib\spark-client\*;lib\swt\win64\* -Djava.library.path=lib\core -Xmx2048m -Dfile.encoding=UTF-8 -DHOP_AUDIT_FOLDER="C:\TMP\apache-hop-client-2.19.0\hop\audit" -DHOP_CONFIG_FOLDER="C:\TMP\apache-hop-client-2.19.0\hop\config" -DHOP_PLATFORM_OS=Windows -DHOP_PLATFORM_RUNTIME=Server -DHOP_AUTO_CREATE_CONFIG=Y --add-opens java.xml/jdk.xml.internal=ALL-UNNAMED --add-opens java.base/java.lang=ALL-UNNAMED --add-opens java.base/java.lang.invoke=ALL-UNNAMED --add-opens java.base/java.lang.reflect=ALL-UNNAMED --add-opens java.base/java.io=ALL-UNNAMED --add-opens java.base/java.net=ALL-UNNAMED --add-opens java.base/java.nio=ALL-UNNAMED --add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.util.concurrent=ALL-UNNAMED --add-opens java.base/java.util.concurrent.atomic=ALL-UNNAMED --add-opens java.base/sun.nio.ch=ALL-UNNAMED --add-opens java.base/sun.nio.cs=ALL-UNNAMED --add-opens java.base/sun.security.action=ALL-UNNAMED --add-opens java.base/sun.util.calendar=ALL-UNNAMED --add-opens java.security.jgss/sun.security.krb5=ALL-UNNAMED --add-exports java.base/sun.nio.ch=ALL-UNNAMED org.apache.hop.www.HopServer

===[Starting HopServer]=========================================================
2026/08/31 20:10:44 - HopServer - Enabling project 'default'
2026/08/31 20:10:44 - HopServer - Two-way password encoder initialized with plugin ID 'Hop' for project 'default'
2026/08/31 20:10:44 - HopServer - Installing timer to purge stale objects after 1440 minutes.
2026/08/31 20:10:44 - HopServer - Hop Server: Basic authentication is ENABLED
2026/08/31 20:10:47 - HopServer - Created listener for webserver @ address : localhost:8080
