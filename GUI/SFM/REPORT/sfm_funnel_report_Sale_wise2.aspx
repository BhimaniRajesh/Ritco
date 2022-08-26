<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sfm_funnel_report_Sale_wise2.aspx.cs" Inherits="REPORT_sfm_funnel_report_Sale_wise2" %>
<%@ Reference Control="~/include/menu.ascx"%>
<%@ Register TagPrefix="menu" TagName="Header" Src="~/include/menu.ascx" %>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../include/Styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <menu:header id="Header1" runat="server" ></menu:header>
    <div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td valign="top" style="height: 300px">
                                           
                                            <br />
                                            <br />
                                            <p align="center">
                                                <font class="blackfnt"><b>You Selected</b></font></p>
                                            <table align="center" bgcolor="#808080" border="0" cellpadding="3" cellspacing="1"
                                                class="boxbg" cols="1" width="50%">
                                                <center>
                                                    
                                                    <tr bgcolor="#ffffff">
                                                        <td style="width: 180px" >
                                                            <font class="blackfnt">Region</font>
                                                            <div>
                                                            </div>
                                                        </td>
                                                        <td align="middle" style="font-weight: bold">
                                                            <div align="left">
                                                                <font class="blackfnt">&nbsp;<%=Request.QueryString.Get("Employee") %></font></div>
                                                        </td>
                                                    </tr>
                                                    <tr bgcolor="#ffffff">
                                                        <td style="width: 180px">
                                                            <font class="blackfnt">Location</font>
                                                            <div>
                                                            </div>
                                                        </td>
                                                        <td align="middle" style="font-weight: bold">
                                                            <div align="left">
                                                                <font class="blackfnt">&nbsp;<%=Request.QueryString.Get("Employee") %></font></div>
                                                        </td>
                                                    </tr>
                                                    <tr bgcolor="#ffffff">
                                                        <td style="width: 180px">
                                                            <font class="blackfnt">Sales Person</font>
                                                            <div>
                                                            </div>
                                                        </td>
                                                        <td align="middle" style="font-weight: bold">
                                                            <div align="left">
                                                                <font class="blackfnt">&nbsp;<%=Request.QueryString.Get("Employee") %></font></div>
                                                        </td>
                                                    </tr>
                                                    <tr bgcolor="#ffffff" style="font-weight: bold">
                                                        <td style="width: 180px" >
                                                            <font class="blackfnt">Call Date </font>
                                                            <div>
                                                            </div>
                                                        </td>
                                                        <td align="middle">
                                                            <div align="left">
                                                                <font class="blackfnt">&nbsp;<%=Request.QueryString.Get("CallDate")%></font></div>
                                                        </td>
                                                    </tr>
                                                </center>
                                            </table>
                                            <br />
                                            <br />
                                            <table align="center" border="1" cellpadding="3" cellspacing="1" cols="4"
                                                width="100%">
                                                <tr class="bgbluegrey">
                                                    <td align="center" style="width: 22%;">
                                                        <font class="blackfnt"><b>Sales Person</b></font>
                                                    </td>
                                                    <td align="center" style="width: 147px;" colspan="2">
                                                        <font class="blackfnt"><b>Hot </b></font>
                                                    </td>
                                                    <td align="center" style="width: 21%;" colspan="2">
                                                        <font class="blackfnt"><b>Warm </b></font>
                                                    </td>
                                                    <td align="center" style="width: 18%;" colspan="2">
                                                        <font class="blackfnt"><b>Cold</b></font>
                                                    </td>
                                                    <td align="center" style="width: 54%;" colspan="2">
                                                        <font class="blackfnt"><b>All</b></font>
                                                    </td>
                                                </tr>
                                                
                                                <tr class="bgbluegrey">
						<td align="center">
							<font class=blackfnt><b>&nbsp;</b></font>
						</td>

						<td align="center" style="width: 178px">
							<font class=blackfnt><b>Prospects</b></font>
						</td>
						<td align="center">
							<font class=blackfnt><b>Value</b></font>
						</td>

						<td align="center" style="width: 197px">
							<font class=blackfnt><b>Prospects</b></font>
						</td>
						<td align="center" style="width: 251px">
							<font class=blackfnt><b>Value</b></font>
						</td>

						<td align="center" style="width: 143px">
							<font class=blackfnt><b>Prospects</b></font>
						</td>
						<td align="center" style="width: 2539px">
							<font class=blackfnt><b>Value</b></font>
						</td>

						<td align="center" style="width: 178px">
							<font class=blackfnt><b>Prospects</b></font>
						</td>
						<td align="center">
							<font class=blackfnt><b>Value</b></font>
						</td>
					</tr>
                                                
                                               
                                                <tr bgcolor="#ffffff">
                                                    <%
        string connectionString = System.Configuration.ConfigurationManager.AppSettings["ecfy"];
        System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(connectionString);
        string str,Offer,Inventry,Admin,username;  
        str=Context.User.Identity.Name;
        string str1;
        string strGetProdedure;
        strGetProdedure = Request.QueryString.Get("CallReport");
        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
        cmd.CommandText = strGetProdedure;
        cmd.Connection = conn;          
        System.Data.SqlClient.SqlDataReader dtr = null;
        conn.Open();
        dtr = cmd.ExecuteReader();

        //int srNo;
        //srNo = 1;

        while (dtr.Read())
        {
            
                                                    %>
                                                </tr>
                                                <tr >
                                                    <td align="center" style="width: 22%; height: 9px;">
                                                        <font class="blackfnt">
                                                            <% = dtr["Empnm"].ToString()%>
                                                        </font>
                                                    </td>
                                                    <%--<td align="center" style="width: 178px; height: 9px;">
                                                        <font class="blackfnt">
                                                                <% = dtr["callCode"].ToString()%>
                                                            </font>
                                                    </td>
                                                    <td align="center" style="width: 21%; height: 9px;">
                                                        <font class="blackfnt">
                                                                <% = dtr["companyName"].ToString()%>
                                                           </font>
                                                    </td>
                                                    <td align="center" style="width: 197px; height: 9px;">
                                                        <font class="blackfnt">
                                                                <% = dtr["callDt"].ToString()%>
                                                            </font>
                                                    </td>
                                                    <td align="center" style="width: 251px; height: 9px;">
                                                        <font class="blackfnt">
                                                                <% = dtr["CallTime"].ToString()%>
                                                            </font>
                                                    </td>
                                                    <td align="center" style="width: 143px; height: 9px;">
                                                        <font class="blackfnt">
                                                            <% = srNo  %>
                                                        </font>
                                                    </td>
                                                    <td align="center" style="width: 2539px; height: 9px;">
                                                        <font class="blackfnt">
                                                            <% = srNo  %>
                                                        </font>
                                                    </td>
                                                    <td align="center" style="width: 26px; height: 9px;">
                                                        <font class="blackfnt">
                                                            <% = srNo  %>
                                                        </font>
                                                    </td>
                                                    <td align="center" style="width: 26px; height: 9px;">
                                                        <font class="blackfnt">
                                                            <% = srNo  %>
                                                        </font>
                                                    </td>--%>
                                                    
                                                </tr>
                                                <%  
                                                    
                                                }

                  
        dtr.Close();
        conn.Close();
   
                                                %>
                                            </table>
                                            <br />
                                        </td>
                                    </tr>
                                </table>
    </div>
    </form>
</body>
</html>
