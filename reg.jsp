<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
    </head>
    <body>
        <form action="registration.jsp" method="post">
        <center>
        <table border="0" width="50%" cellpadding="6">
                <thead>
                    <tr>
                        <th colspan="2">Please provide your details</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                    <td>User Name</td>
     <td><input type="text" name="uname"/></td></tr>
    <tr><td>Email</td> <td><input type="text" name="email"/></td></tr>
    <tr><td>Password</td> <td><input type="password" name="password"/></td></tr>
    <tr><td>First Name</td> <td><input type="text" name="fname"/></td></tr>
    <tr><td>Last Name</td> <td><input type="text" name="lname"/></td></tr>
    <tr><td>Gender</td> <td><select name="gender"> 
                    <option>Male</option>
                    <option>Female</option>
                  </select></td></tr><br />
    
    <tr>
    <td><input type="submit" value="Register" name="txtSubmit" class="submit" /></td>
    <td><input type="reset" value="Reset" /></td></tr>
     </center>
</form>
    </body>
</html>