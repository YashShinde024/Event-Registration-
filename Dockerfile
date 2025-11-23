# Use Tomcat 10.1 (supports Jakarta Servlet API 6)
FROM tomcat:10.1-jdk17

# Remove Tomcat's default ROOT webapp
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR file into Tomcat's webapps folder
COPY target/event-registration-servlet-1.0.0.war /usr/local/tomcat/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD [catalina.sh,run]
