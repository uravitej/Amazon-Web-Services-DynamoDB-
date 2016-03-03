<%
session.setAttribute("uname", null);
session.invalidate();
response.sendRedirect("index.jsp");
%>