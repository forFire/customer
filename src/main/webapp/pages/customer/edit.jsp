<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<jsp:include page="../commons.jsp"></jsp:include>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>客户添加</title>
<style type="text/css">
body {
	margin: 5 5 5 5;
	overflow: hidden;
}
</style>



</head>
<body>

	<div class="easyui-panel" title="用户添加" style="width: 400px">
		<div style="">
			<form id="ff" class="easyui-form" method="post" data-options="novalidate:true" action="">
				<table cellpadding="5">
					<tr>
						<td>ID</td>
						<td>
							<input class="easyui-textbox" type="text" name="id" id="id" value=""></input>
						</td>
					</tr>

					<tr>
						<td>
							<span>顾客姓名：</span>
						</td>
						<td>
							<input class="easyui-textbox" id="name" style="height: 25px" />
						</td>
					</tr>
				</table>
			</form>
			<div style="text-align: center; padding: 5px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="updateform()">提交</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="$('#updateCustomer').dialog('close');">关闭</a>
			</div>
		</div>
	</div>

</body>


</html>