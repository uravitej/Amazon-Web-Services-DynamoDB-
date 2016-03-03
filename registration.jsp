<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.amazonaws.*" %>
<%@ page import="com.amazonaws.auth.*" %>
<%@ page import="com.amazonaws.auth.profile.ProfileCredentialsProvider" %>
<%@ page import="com.amazonaws.services.ec2.*" %>
<%@ page import="com.amazonaws.services.ec2.model.*" %>
<%@ page import="com.amazonaws.services.s3.*" %>
<%@ page import="com.amazonaws.services.s3.model.*" %>
<%@ page import="com.amazonaws.services.dynamodbv2.*" %>
<%@ page import="com.amazonaws.services.dynamodbv2.model.*" %>
<%@ page import="com.amazonaws.services.dynamodbv2.document.*" %>
<%@ page import="com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient" %>
<%@ page import="com.amazonaws.services.dynamodbv2.document.DynamoDB" %>
<%@ page import="com.amazonaws.services.dynamodbv2.document.Item" %>
<%@ page import="com.amazonaws.services.dynamodbv2.document.Table" %>
<%@ page import="com.amazonaws.services.dynamodbv2.document.ItemCollection" %>


<%! // Share the client objects across threads to
    // avoid creating new clients for each web request
    private AmazonEC2         ec2;
    private AmazonS3           s3;
    private AmazonDynamoDB dynamo;
 %>
 
<% if (ec2 == null) {
    AWSCredentialsProvider credentialsProvider = new ClasspathPropertiesFileCredentialsProvider();
    ec2    = new AmazonEC2Client(credentialsProvider);
    s3     = new AmazonS3Client(credentialsProvider);
    dynamo = new AmazonDynamoDBClient(credentialsProvider);
}
 
 DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient(
         new ProfileCredentialsProvider()));
 
 
 
 Table table = dynamoDB.getTable("users2");
 String uname = request.getParameter("uname");    
 String email = request.getParameter("email");
 String fname = request.getParameter("fname");
 String lname = request.getParameter("lname");
 String gender = request.getParameter("gender");
 String password = request.getParameter("password");
 out.println(uname);
 /*

 Item item = new Item()
 .withPrimaryKey("uname", uname)
 .withString("email", email)
 .withString("fname", fname)
 .withString("gender", gender)
 .withString("lname", lname)
 .withString("password", password);
 */
 
 dynamo.setEndpoint("dynamodb.us-west-2.amazonaws.com");
 Map<String, AttributeValue> item1 = new HashMap<String, AttributeValue>();
 item1.put("uname", new AttributeValue(uname));
 item1.put("email", new AttributeValue(email));
 item1.put("fname", new AttributeValue(fname));
 item1.put("lname", new AttributeValue(lname));
 item1.put("gender", new AttributeValue(gender));
 item1.put("password", new AttributeValue(password));
dynamo.putItem(new PutItemRequest() 
    .withTableName("users2")
    .withItem(item1));

session.setAttribute( "uname", uname );
response.sendRedirect("welcome.jsp");
out.println("Registered Successfully <a href='index.jsp'>Login</a>");


 

 %>

