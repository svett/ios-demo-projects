# Requirements:

     1. MySQL Server
     2. Tomcat Server
     2. Ant build

# Database installation

The rest service uses a data base. Therefore, you should install the default data base by invoking the
<createDatabase.sh> script.

# Application Compilation

The war file of the application can be build by invoking <build.sh> script.

# Application Configuration

When the application file is deployed to the TomCat server. You should change the context.xml file to configure the mysql connection string:

<Resource name="jdbc/GoldenGekkoItemsDb" 
     	auth="Container"
     	type="javax.sql.DataSource"
     	username="appagent"
     	password="agentpassword"
     	driverClassName="com.mysql.jdbc.Driver"
     	description="Global Address Database"
     	url="jdbc:mysql://localhost:3306/GoldenGekkoItemsDb"
     	maxActive="15"
     	maxIdle="3"/>