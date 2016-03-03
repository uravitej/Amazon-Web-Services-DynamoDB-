<%@ page import="java.io.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Iterator" %>
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
<%@ page import="com.amazonaws.services.dynamodbv2.document.spec.DeleteItemSpec" %>


<%! // Share the client objects across threads to
    // avoid creating new clients for each web request
    private AmazonEC2         ec2;
    private AmazonS3           s3;
    private AmazonDynamoDB dynamo;
    private DynamoDB dynamoDB;
    String option;
 %>
<% if (ec2 == null) {
    AWSCredentialsProvider credentialsProvider = new ClasspathPropertiesFileCredentialsProvider();
    ec2    = new AmazonEC2Client(credentialsProvider);
    s3     = new AmazonS3Client(credentialsProvider);
     dynamoDB = new DynamoDB(new AmazonDynamoDBClient(
            new ProfileCredentialsProvider()));
    dynamo = new AmazonDynamoDBClient(credentialsProvider);
    dynamo.setEndpoint("dynamodb.us-west-2.amazonaws.com");    
    
}
%>

<% 
String itemname = request.getParameter("items");
Map<String, ExpectedAttributeValue> expectedValues = new HashMap<String, ExpectedAttributeValue>();
HashMap<String, AttributeValue> key = new HashMap<String, AttributeValue>();
key.put("itemname", new AttributeValue().withS(itemname));
ReturnValue returnValues = ReturnValue.ALL_OLD;

DeleteItemRequest deleteItemRequest = new DeleteItemRequest()
    .withTableName("items2")
    .withKey(key)
    .withReturnValues(returnValues);

DeleteItemResult dresult = dynamo.deleteItem(deleteItemRequest);

%>
<HTML>
	Deleted Successfully...<a href='success.jsp'>Go Back</a> <br />
</HTML>