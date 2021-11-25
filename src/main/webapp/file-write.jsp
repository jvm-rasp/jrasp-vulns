<%@page import="java.io.*" %>
<%@page contentType="text/html; charset=UTF-8" %>

<html>
<head>	
	<meta charset="UTF-8"/>
	<title>任意文件写入</title>
</head>
<body>
<%
String normal_querystring = "?filename=123.txt&amp;filedata=123456";
String linux_querystring = "?filename=reports/../../123.jsp&amp;filedata=some-webshell-data";
String bytes = request.getParameter("filedata");
String fname = request.getParameter("filename");
if (fname == null || bytes == null) {
} 
else {
	try {
		String path;
		String serverInfo = application.getServerInfo();
		if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
			path = application.getResource("/").getPath() + fname;
		} else {
			path = application.getRealPath("/") + fname;
		}
	   	FileOutputStream os = new FileOutputStream(path);
		PrintWriter writer = new PrintWriter(os);
		writer.print(bytes);
		writer.close();
		out.println("文件写入路径:" + path);
	} catch (Exception e) {
        out.print("<pre>");
        e.printStackTrace(response.getWriter());
        out.print("</pre>");
	}
}
%>
<p>正常调用</p>
<p>curl '<a href="<%=request.getRequestURL()+normal_querystring%>" target="_blank"><%=request.getRequestURL()+normal_querystring%></a>'</p>
<p>不正常调用</p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL()+linux_querystring%></a>'</p>
</body>
</html>
