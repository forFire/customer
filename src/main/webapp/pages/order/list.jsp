<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<jsp:include page="/pages/commons.jsp"></jsp:include>
<head>

<title>信息管理</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
</head>

<body>

	<div style="margin: 20px 0;"></div>
	<div class="easyui-layout" style="width: 100%; height: 660px;">
	<div id="addRecruit"></div>
		<div id="updateRecruit"></div>

		<div data-options="region:'center',title:'订单列表',iconCls:'icon-ok'"
			style="width: 100px;">
			<table id="OrderInfo" style="height: 100%; width: 100%;"></table>
		</div>
		
	</div>

	<script type="text/javascript">
		$(document)
				.ready(
						function() {//datagrid设置
							$('#OrderInfo')
									.datagrid(
											{ // 													title : '招聘列表', //表格标题
												iconCls : 'icon-list', //表格图标
												nowrap : false, //是否只显示一行，即文本过多是否省略部分。
												striped : true,
												fitColumns : true, //防止水平滚动
												scrollbarSize : 0, //去掉右侧滚动条列
												url : "/orders/list.do", //action地址
												idField : 'id',
												collapsible : false,//是否可折叠的 
												singleSelect : true,//只能单选
												frozenColumns : [ [ {
													field : 'ck',
													checkbox : true
												} ] ],
												pagination : true, //包含分页
												pageSize : 10,
												pageList : [ 10, 20, 30 ],//可以设置每页记录条数的列表 
												rownumbers : true,
												singleSelect : false,//只能单选
												columns : [ [ {
													field : 'id',
													title : 'ID',
													align : 'center',
													hidden : true
												}, {
													field : 'name',
													title : "订单名称",
													width : 100,
													align : 'center',
													sortable : true,
												}, {
													field : 'memo',
													title : "订单描述",
													width : 100,
													align : 'center',
													sortable : true,
												}, {
													field : 'orderTime',
													title : "订单时间",
													width : 100,
													align : 'center',
													sortable : true,
												}] ],

												toolbar : [
														{
															text : '添加',
															iconCls : 'icon-add',
															handler : function() {
																//显示上传界面
																$('#addRecruit')
																		.dialog(
																				{
																					title : '简历管理|添加简历信息',
																					width : 500,
																					iconCls : 'icon-add',
																					height : 300,
																					closed : false,
																					cache : false,
																					href : 'add.jsp',
																					modal : true
																				});

															}

														},
														'-',
														{
															text : "删除",
															iconCls : "icon-cut",
															handler : function() {
																//选中要修改删除的行
																var rows = $("#OrderInfo").datagrid('getSelections'); //返回所有选中的行
																if (rows.length > 0) {//选中几行的话触发事件
																	$.messager.confirm("提示","您确定要删除此行么？",
																					function(res) {//提示是否删除
																						if (res) {
																							//获得编号
																							var id = rows[0].id;
																							// 获得删除行索引  
																							var tableindex = $("#OrderInfo").datagrid('getRowIndex',id);$.post('/orders/delete.do',{"id" : id},
																											function(data) {
																												if (data.message == "2") {
																													$.messager.alert('温馨提示','删除失败!','error');
																												} else {
																													//删除选中的行
																													$("#OrderInfo").datagrid("deleteRow",tableindex);
																												}
																											});

																						}

																					});

																}

															}

														},
														'-',
														{
															text : "修改",
															iconCls : "icon-edit",
															handler : function() {
																//选中要修改删除的行
																var rows = $("#OrderInfo").datagrid('getSelections'); //返回所有选中的行
																if (rows.length > 0) {//选中几行的话触发事件
																	//获得编号
																	var id = rows[0].id;
																	//显示修改界面
																	$('#updateRecruit').dialog(
																		{
																			title : '房产管理|修改房屋信息',
																			width : 500,
																			iconCls : 'icon-edit',
																			height : 300,
																			closed : false,
																			cache : false,
																			href : 'edit.jsp',
																			modal : true

																		});
																}
																
																
															}
														},
														'-',
														{   text : "刷新列表",
															iconCls : "icon-reload",
															handler : function() {
																$("#OrderInfo").datagrid('reload');
															}
														} ],
												onLoadError : function() {
													$.messager.alert('温馨提示',
															'数据加载失败!', 'error');
												}
											});
							displayMsg();
						});

		//改变分页显示
		function displayMsg() {
			$('#OrderInfo')
					.datagrid('getPager')
					.pagination(
							{
								displayMsg : '当前显示<font color="red"> {from} - {to} </font>条记录   共 <font color="red">{total}</font> 条记录'
							});
		}
		
		
		
		
	function submitform() {
		$.ajax({
			type : "POST",
			url : "/orders/save.do",
			data : $("#ff").serialize(),
			success : function(date) {
				
				if(date.ret == "0"){
					alert("保存成功!");
					$("#OrderInfo").datagrid('reload');
				}else{
					alert("保存出错!"+msg);
				}
				$('#addRecruit').dialog('close');
			}
		});
	};
		
		
	
	function updateform() {
		$.ajax({
			type : "POST",
			url : "/orders/update.do",
			data : $("#ff").serialize(),
			success : function(date) {
				
				if(date.ret == "0"){
					alert("更新成功!");
					$("#OrderInfo").datagrid('reload');
				}else{
					alert("保存出错!"+msg);
				}
				$('#updateRecruit').dialog('close');
			}
		});
	};
		
	
	</script>
</body>

</html>