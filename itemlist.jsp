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
    dynamo.setEndpoint("dynamodb.us-west-2.amazonaws.com");
}
%>

<TABLE BORDER = "1">
<tr>
<TH> Uploaded By </TH>
<TH> Item Name </TH>
<TH> Item Description </TH>
<TH> Image </TH>
</tr>
<% 
ScanRequest scanRequest = new ScanRequest().withTableName("items2").withAttributesToGet("itemimg");
ScanRequest scanRequest1 = new ScanRequest().withTableName("items2").withAttributesToGet("uname");
ScanRequest scanRequest2 = new ScanRequest().withTableName("items2").withAttributesToGet("itemname");
ScanRequest scanRequest3 = new ScanRequest().withTableName("items2").withAttributesToGet("itemdesc");
ScanResult result = dynamo.scan(scanRequest);
ScanResult result1 = dynamo.scan(scanRequest1);
ScanResult result2 = dynamo.scan(scanRequest2);
ScanResult result3 = dynamo.scan(scanRequest3);
ArrayList<String> urls = new ArrayList<String>();
ArrayList<String> unames = new ArrayList<String>();
ArrayList<String> items = new ArrayList<String>();
ArrayList<String> descs = new ArrayList<String>();


int count = result.getItems().size();

String stritemurl = "" ;
String strusername = "";
String stritemname = "";
String stritemdesc = "";
for (Map<String, AttributeValue> item : result.getItems()){
	AttributeValue v = item.get("itemimg");
    String url  = v.getS();
    urls.add(url);
}
for (Map<String, AttributeValue> item : result1.getItems()){
	AttributeValue v = item.get("uname");
	String uname = v.getS();
	unames.add(uname);
}

for (Map<String, AttributeValue> item : result2.getItems()){
	AttributeValue v = item.get("itemname");
	String itemname = v.getS();
	items.add(itemname);
}
for (Map<String, AttributeValue> item : result3.getItems()){
	AttributeValue v = item.get("itemdesc");
	String itemdesc = v.getS();
	descs.add(itemdesc);
}


for(int j=0;j<count;j++) {
	stritemurl = urls.get(j);
	strusername = unames.get(j);
	stritemname = items.get(j);
	stritemdesc = descs.get(j);
%>
<tr><td><%=strusername %> </td>
<td><%=stritemname %> </td>
<td><%=stritemdesc %> </td>
<td> <img src=<%=stritemurl %> alt="" name="image" width="100" height="100" id="" /> <br />

</td></tr>
 
<%
}    
%>
</TABLE>
