<%
    if ((session.getAttribute("uname") == null) || (session.getAttribute("uname") == "")) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
Welcome <%=session.getAttribute("uname")%>
<a href='logout.jsp'>Log out</a>

<html> 
    <body> 
    <form action="upload.jsp" method="post" enctype="multipart/form-data">
          <input type="submit" value="Add Items"> 
    </form> 
    <form action="remove.jsp" method="post" enctype="multipart/form-data">
          <input type="submit" value="Remove Items"> 
    </form> 
    <form action="itemlist.jsp" method="post" enctype="multipart/form-data">
          <input type="submit" value="List Items"> 
    </form> 
 
  </body>
</html>

<%
}
%>