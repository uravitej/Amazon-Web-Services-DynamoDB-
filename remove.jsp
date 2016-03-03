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

<TABLE BORDER = "1">
<tr>
<TH> Uploaded By </TH>
<TH> Item Name </TH>
<TH> Item Description </TH>
<TH> Image </TH>
</tr>
<% 
Map<String, AttributeValue> expressionAttributeValues = 
		    new HashMap<String, AttributeValue>();
Map<String, AttributeValue> expressionAttributeValuesp = 
		    new HashMap<String, AttributeValue>();
String uname = (String)session.getAttribute("uname");
expressionAttributeValues.put(":uname", new AttributeValue().withS(uname));
ScanRequest scanRequest = new ScanRequest()
.withTableName("items2")
.withFilterExpression("uname = :uname")
.withExpressionAttributeValues(expressionAttributeValues)
;
ScanResult result = dynamo.scan(scanRequest);
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
	AttributeValue img = item.get("itemimg");
	AttributeValue usnm = item.get("uname");
	AttributeValue itnm = item.get("itemname");
	AttributeValue itdsc = item.get("itemdesc");
    String url  = img.getS();
    urls.add(url);
    String usnme  = usnm.getS();
    unames.add(usnme);
    String itname  = itnm.getS();
    items.add(itname);
    String itdesc  = itdsc.getS();
    descs.add(itdesc);
    
}

for(int j=0;j<count;j++) {
	stritemurl = urls.get(j);
	strusername = unames.get(j);
	stritemname = items.get(j);
	stritemdesc = descs.get(j);
%>

<tr><td><%=strusername %>  </td>
<td><%=stritemname %> </td>
<td><%=stritemdesc %> </td>
<td> <img src=<%=stritemurl %> alt="" name="image" width="100" height="100" id="" /> <br />

</td></tr>
<%
}    
%>
</TABLE>
<HTML>
<BODY>
<TABLE Border = "0">
<form action="iremove.jsp" method="post">
    <tr><td>Select item to delete</td> 
    <td><select name="items" id="items">
    <% for (int k=0; k<items.size(); k++) {
    	String it_name = items.get(k);
    	
    %>	
    <option><%=it_name %></option>
	<%
    }
	%>
    </select></td></tr>
    <tr>
    <td><input type="submit" value="Remove" name="itemRemove" class="submit" /></td>
    </tr>
    </form>
	</TABLE>
</BODY>
</HTML>
