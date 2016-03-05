<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css"> 
table { 
border-collapse:collapse; /* 关键属性：合并表格内外边框(其实表格边框有2px，外面1px，里面还有1px哦) */ 
border:solid #999; /* 设置边框属性；样式(solid=实线)、颜色(#999=灰) */ 
border-width:1px 0 0 1px; /* 设置边框状粗细：上 右 下 左 = 对应：1px 0 0 1px */ 
} 
table tr,table td {border:solid #999;border-width:0 1px 1px 0;padding:2px;} 
</style>
</head>
<body>
<div align="center">
<table style="width:700px;">
	<tr>
		<td>id</td>
		<td>pro_name</td>
		<td>host</td>
		<td>service</td>
		<td>number</td>
		<td>pwd</td>
		<td>version</td>
	</tr>
	<%
    String result = ""; // 查询结果字符串
    String sql = "select id,pro_name, "+
    		"(select GROUP_CONCAT(ip) from host_project "+
    		"join host on host_project.host_id = host.id "+
    		"where host_project.pro_id = project.id) as host, "+
    		"(select GROUP_CONCAT(service_name) from host_project "+
    		"join service on host_project.service_id = service.id " +
    		"where host_project.pro_id = project.id) as servcie, " +
    		"pro_number,pro_pwd,pro_version "+
    		"from project order by id ";
    String url = "jdbc:mysql://localhost:3306/auto_pro";
    String username = "root"; // 用户名
    String password = ""; //密码

    Class.forName("com.mysql.jdbc.Driver").newInstance();

    // 获得与数据库的连接 
    Connection conn = DriverManager.getConnection(url, username, password); 
    // 创建执行语句对象
    Statement  stmt = conn.createStatement();
    // 执行sql语句，返回结果集
    ResultSet  rs   = stmt.executeQuery(sql);

    while ( rs.next() ) 
    {
       %>
       <tr>
       		<td><%=rs.getString(1) %></td>
       		<td><%=rs.getString(2) %></td>
       		<td><%=rs.getString(3) %></td>
       		<td><%=rs.getString(4) %></td>
       		<td><%=rs.getString(5) %></td>
       		<td><%=rs.getString(6) %></td>
       		<td><%=rs.getString(7) %></td>
       </tr>
       <%
    }
	try{
		rs.close();
	    stmt.close(); 
	    conn.close();	
	}catch(Exception e) {
		e.printStackTrace();		
	}
%> 
</table>
</div>
</body>
</html>
