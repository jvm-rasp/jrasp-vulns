<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>命令执行（无回显）</title>
</head>
<body>
<h1>命令执行（无回显）</h1>

<%
    String linux_querystring = "?cmd=cp+/etc/passwd+/tmp/";
    String windows_querystring = "?cmd=cmd+/c+calc";
    String cmd = request.getParameter("cmd");
    String env = request.getParameter("env");
    if (cmd != null) {
        try {
            if (env != null) {
                String[] envs = env.split(",");
                Runtime.getRuntime().exec(cmd, envs);
            } else {
                Runtime.getRuntime().exec(cmd);
            }
        } catch (Exception e) {
            out.print("<pre>");
            e.printStackTrace(response.getWriter());
            out.print("</pre>");
        }
    }
%>
<p>Linux/MacOS 触发: </p>
<p>curl '<a href="<%=request.getRequestURL()+linux_querystring%>"
            target="_blank"><%=request.getRequestURL() + linux_querystring%>
</a>'</p>
<p>然后检查 /tmp 是否存在 passwd 这个文件</p>
<br>

</body>
</html>
