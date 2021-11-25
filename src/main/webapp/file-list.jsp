<%@page import="java.io.*" %>
<%@page import="java.util.*" %>
<%@page import="net.sf.json.*" %>

<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>任意目录读取</title>
</head>
<body>
<script>
</script>
    <h1>使用 File.listFiles 遍历目录（有路径拼接）</h1>
<%

String dirname = request.getParameter("dirname");

String normal_querystring = "?dirname=reports";
String linux_querystring = "?dirname=../../../../../../../../../../../../../../../var/log/";

if (dirname != null) {
    try {
        File folder;
        String serverInfo = application.getServerInfo();
        if (serverInfo != null && serverInfo.toLowerCase().contains("weblogic")) {
            folder = new File(application.getResource("/").getPath() + "/" + dirname);
        } else {
            folder = new File(application.getRealPath("/") + "/" + dirname);
        }

        if (folder == null){
            out.println("No such directory");
        }else{
            File[] listOfFiles = folder.listFiles();
            for (File file : listOfFiles) {
                if (file.isFile()) {
                    out.println(file.getName());
                }
            }            
        }
    } catch (Exception e) {
        out.print("<pre>");
        e.printStackTrace(response.getWriter());
        out.print("</pre>");
    }
}
else {
%>
<p>正常调用: </p>
<p>curl '<a href="<%=request.getRequestURL()+normal_querystring%>" target="_blank"><%=request.getRequestURL() + normal_querystring%></a>'</p>

<p>不正常调用 - Linux: </p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>" target="_blank"><%=request.getRequestURL() + linux_querystring%></a>'</p>

<%
}
%>
</body>
</html>
