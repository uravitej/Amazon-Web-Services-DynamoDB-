<%@ page import="java.io.*"%>
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
%>
<%
			String itemname = request.getParameter("itemname");
			String itemdesc = request.getParameter("itemdesc");
			String itemimg = request.getParameter("fileToUpload");
			String saveFile = itemimg;
	        saveFile = saveFile.substring(itemimg.lastIndexOf("\\") + 1);
	        String uname = (String)session.getAttribute("uname");
	        
			s3.setEndpoint("s3-us-west-2.amazonaws.com");
			File ff = new File(itemimg);
			//String abspath = ff.getAbsolutePath();
            s3.putObject(new PutObjectRequest(
	                 "respurces/images/" + uname , saveFile, ff));
            //s3.putObject(new PutObjectRequest(
	        //         "respurces/images/" + uname , abspath, ff));
           
            DynamoDB dynamoDB = new DynamoDB(new AmazonDynamoDBClient(
                    new ProfileCredentialsProvider()));
            String itemurl = "https://s3-us-west-2.amazonaws.com/respurces/images/";
            dynamo.setEndpoint("dynamodb.us-west-2.amazonaws.com");
            Map<String, AttributeValue> item1 = new HashMap<String, AttributeValue>();
            item1.put("itemname", new AttributeValue(itemname));
            item1.put("uname", new AttributeValue(uname));
            item1.put("itemdesc", new AttributeValue(itemdesc));
            item1.put("itemimg", new AttributeValue(itemurl + uname + "/" + saveFile));
            
           dynamo.putItem(new PutItemRequest() 
               .withTableName("items2")
               .withItem(item1));
		   
           response.sendRedirect("success.jsp");
 
%><Br>

