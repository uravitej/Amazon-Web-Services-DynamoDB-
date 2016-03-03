<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.amazonaws.*"%>
<%@ page import="com.amazonaws.auth.*"%>
<%@ page import="com.amazonaws.auth.profile.ProfileCredentialsProvider"%>
<%@ page import="com.amazonaws.services.ec2.*"%>
<%@ page import="com.amazonaws.services.ec2.model.*"%>
<%@ page import="com.amazonaws.services.s3.*"%>
<%@ page import="com.amazonaws.services.s3.model.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.model.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.document.*"%>
<%@ page import="com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient"%>
<%@ page import="com.amazonaws.services.dynamodbv2.document.DynamoDB"%>
<%@ page import="com.amazonaws.services.dynamodbv2.document.Item"%>
<%@ page import="com.amazonaws.services.dynamodbv2.document.Table"%>
<%@ page
	import="com.amazonaws.services.dynamodbv2.document.ItemCollection"%>
<%@ page
	import="com.amazonaws.services.dynamodbv2.document.QueryOutcome"%>
<%@ page
	import="com.amazonaws.services.dynamodbv2.document.spec.QuerySpec"%>



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
 String password = request.getParameter("password");
 //out.println(uname);
 dynamo.setEndpoint("dynamodb.us-west-2.amazonaws.com");
  
  
 Map<String, AttributeValue> expressionAttributeValues = 
		    new HashMap<String, AttributeValue>();
 Map<String, AttributeValue> expressionAttributeValuesp = 
		    new HashMap<String, AttributeValue>();
expressionAttributeValues.put(":uname", new AttributeValue().withS(uname));
expressionAttributeValuesp.put(":password", new AttributeValue().withS(password));
		        
		ScanRequest scanRequest = new ScanRequest()
		    .withTableName("users2")
		    .withFilterExpression("uname = :uname")
		    
		    //.withProjectionExpression("Id")
		    .withExpressionAttributeValues(expressionAttributeValues)
		    .withFilterExpression("password = :password")
		    .withExpressionAttributeValues(expressionAttributeValuesp)
		    ;
		
		ScanResult result = dynamo.scan(scanRequest);
		/*
		for (Map<String, AttributeValue> item : result.getItems()) {
		    out.println(item);
		}
		*/
		if (result.getCount().equals(1)){
			session.setAttribute( "uname", uname );
			response.sendRedirect("success.jsp");
		}
		else {
			out.println("Invalid Credentials <a href='index.jsp'>Login Again</a>");
		}
		

  
 
 

 %>

