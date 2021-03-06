<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="com.mvc.bean.User"%>
<%@page import="com.mvc.bean.DispatchCTB"%>
<%@page import="java.util.List"%>
<%@page import="com.mvc.bean.Category"%>
<%@page import="com.mvc.bean.Contribution"%>
<%@page import="com.mvc.biz.IUserBiz"%>
<%@page import="com.mvc.biz.IDispatchBiz"%>
<%@page import="com.mvc.biz.IContributionBiz"%>
<%@page import="com.mvc.biz.ICTBCategoryBiz"%>
<%@page import="com.mvc.biz.ICTBCategoryBizImp"%>
<%@page import="com.mvc.biz.IUserBizImp"%>
<%@page import="com.mvc.biz.IDispatchBizImp"%>
<%@page import="com.mvc.biz.IContributionBizImp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>稿件管理</title>
<%
	request.setCharacterEncoding("UTF-8");
	if (session.getAttribute("userInfo") == null) {
		response.sendRedirect("../cs/login.jsp");
		return;

	}
	User user = (User) session.getAttribute("userInfo");

	if (user.getTypeID() != 3) {
		session.setAttribute("message", "您没有此权限！");
		response.sendRedirect("../cs/error.jsp");
		return;
	}
	IContributionBiz ictbb = new IContributionBizImp();
	IDispatchBiz idb = new IDispatchBizImp();
	IUserBiz iub = new IUserBizImp();
	List<DispatchCTB> ld = idb.getAllByExpertID(user.getUserID());
%>
<link type="text/css" rel="stylesheet" href="../css/style.css">
</head>

<body class="margin_left">



	<table width="100%" border="0" align="center" cellpadding="0"
		cellspacing="0">
		<tr>
			<td width="100%" height="27" background="images/tab_05.gif"
				style="padding-left:38px;">当前位置 >>审核稿件</td>
		</tr>
		<tr>
			<td>
				<div class="table_box2">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<th colspan="2"><font size="3px">审核稿件</font>
							</th>
						</tr>

						<tr>
							<td colspan="2"><div class="table">
									<table width="100%" border="1" align="center" cellpadding="0"
										cellspacing="1">
										<tr>
											<th align="center" width="80">稿件编号</th>
											<th align="center" width="270">稿件标题</th>
											<th align="center" width="100">作者</th>
											<th align="center" width="80">稿件类别</th>
											<th align="center" width="150">关键字</th>
											<th align="center">操作</th>
										</tr>
										<tr>
											<%
												for (DispatchCTB dis : ld) {
													Contribution ctb = ictbb.getByID(dis.getCtbID());
													User u = iub.getByID(ctb.getUserID());
													ICTBCategoryBiz iccb = new ICTBCategoryBizImp();
											%>
											<tr>
												<td height="24" align="center"><%=ctb.getCtbID()%></td>
												<td align="center"><%=ctb.getTitle()%></td>
												<td align="center"><%=u.getRealName()%></td>
												<td align="center"><%=iccb.getCategoryByID(ctb.getCategoryID())%></td>
												<td align="center"><%=ctb.getKeywords()%></td>
												<td align="center" width="130"><img src="images/a1.gif"
													width="12" height="12" /> <%
 	if (ctb.getIsJudge() == null || !ctb.getIsJudge().equals("t")) {
 %><a href="contributioninfo.jsp?ctbID=<%=ctb.getCtbID()%>"> 审核稿件</a> <%
 	} else if (ctb.getIsJudge().equals("t")) {
 %> <a href="ctbinfo.jsp?ctbID=<%=ctb.getCtbID()%>"> 查看稿件</a>

													<%
														}
													%>
												</td>
											</tr>
											<%
												}
											%>


										</tr>
									</table>
								</div></td>
						</tr>
					</table>
				</div></td>
		</tr>
	</table>
</body>
</html>
