<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! String fname; %>
<html>

<head>
<style>
#header {
    background-color:black;    color:white;    text-align:center;    padding:2;}
#nav {
    line-height:30px;    background-color:#eeeeee;    height:300px;    width:100px;    float:left;    padding:5px;      }
#section {
    width:350px;    float:left;    padding:10px;	 }
#footer {
    background-color:black;    color:white;    clear:both;    text-align:center;   padding:5px; 	 }
</style>
</head>

<body>

<div id="header">
<h1>Item Details</h1>
</div>
<FORM ACTION="uploadfile.jsp" METHOD=POST>


 <center>
        <table border="0" width="50%" cellpadding="6">
                <thead>
                    <tr><th colspan="2">Please provide your details</th></tr>
                </thead>
                <tbody>
                    <tr>
                    <td>Item Name</td>
     				<td><input type="text" name="itemname"/></td>
     				</tr>
    				<tr>
    				<td>Item Description</td> 
    				<td><input type="textarea" name="itemdesc"/></td>
    				</tr>
    				<tr>
    				<td>Select image to upload:</td> 
    				<td> <input type="file" name="fileToUpload" id="fileToUpload" > 
    				</td>
    				
    				</tr>
    				<tr> 
    				<td><input type="submit" value="Upload Item" name="itemSubmit" class="submit" onclick="myFunction()" /></td>
    				</tr>
    	
    	
     </center>
</FORM>
</body>
</html>

