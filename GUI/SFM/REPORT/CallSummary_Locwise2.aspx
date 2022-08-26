<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CallSummary_Locwise2.aspx.cs" Inherits="REPORT_CallSummary_Locwise2" %>
<%@ Reference Control="~/include/menu.ascx"%>
<%@ Register TagPrefix="menu" TagName="Header" Src="~/include/menu.ascx" %>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>VisitSummary-LocationWise Report2</title>
    <link href="../include/Styles.css" rel="stylesheet" type="text/css" />
    <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <menu:header id="Header1" runat="server" ></menu:header>
    <div align="center">
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="95%" style="left: -4px; position: relative; top: -67px">
            <tr>
                <td align="right" style="height: 30px">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../images/back.gif" /></a></td>
            </tr>
            <!--Query Screen in this ROW-->
            <tr style="font-size: 12pt; font-family: Times New Roman">
                <td style="height: 33px">
                    <!--Region Location Table-->
                    <table align="center"   bgcolor="#ffffff" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                        cols="2" width="35%">
                       
                        <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                            <td align="left" width="36%">
                                <font class="blackfnt"><b>Location:Code</b></font>
                            </td>
                            <td align="left" style="font-size: 12pt; font-family: Times New Roman">
                                <font class="blackfnt"><%=Request.QueryString.Get("Location")%></font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                            <td align="left" width="36%" style="height: 25px">
                                <font class="blackfnt"><b>Date Selection</b></font>
                            </td>
                            <td align="left" style="font-size: 12pt; font-family: Times New Roman; height: 25px;">
                                <font class="blackfnt"><%=Request.QueryString.Get("Date")%></font>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
       
        <br />
        <br />
        <br />
      </table>
        <!--Location & Values Table-->
        &nbsp;
        <table align ="center" border="1" cellpadding="3" cellspacing="1" 
            cols="4"  style="width: 78%; font-size: 12pt; font-family: Times New Roman; left: 8px; position: relative; top: -51px;">
            <tr class="bgbluegrey">
                <td align="center" style="width: 10%; height: 25px;">
               
                    <font class="blackfnt">Location</font>
                </td>
                <td align="center" style="width: 6%; height: 25px;">
                    <font class="blackfnt">Visit</font>
                </td>
                <td align="center" style="width: 6%; height: 25px;">
                    <font class="blackfnt">Phone</font>
                </td>
                <td align="center" style="width: 6%; height: 25px;">
                    <font class="blackfnt">E-Mail</font>
                </td>
                <td align="center" style="width: 6%; height: 25px;">
                    <font class="blackfnt">Chat</font>
                </td>
                <td align="center" style="width: 6%; height: 25px;">
                    <font class="blackfnt">SMS</font>
                </td>
                <td align="center" style="width: 6%; height: 25px;">
                    <font class="blackfnt">All</font>
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




        while (dtr.Read())
        {
            if (dtr["AllKount"].ToString() != "0")
            {
            %>
                
                
                
            </tr>
            
        
            
             <tr >
             
                <td align="center" style="width: 10%">
                     <font class="blklnkund"> <% = dtr["loccode"].ToString()%></font>
                </td>
          
                <td align="center" style="width: 6%">
                    <font class="blackfnt"> <a href="Call_Summary_Report.aspx?Mode=visit&Location=<%=dtr["loccode"].ToString()%>&Daterange=<%=Request.QueryString.Get("Daterange")%>&Date=<%=Request.QueryString.Get("Date")%>"  target="_blank"  >
                        <font class="blklnkund"> <% = dtr["visitKount"].ToString()%></font></a></font>
                </td>
                
                <td align="center" style="width: 6%">
                    <font class="blackfnt"> <a href="Call_Summary_Report.aspx?Mode=phone&Location=<%=dtr["loccode"].ToString()%>&Daterange=<%=Request.QueryString.Get("Daterange")%>&Date=<%=Request.QueryString.Get("Date")%>"  target="_blank"  >
                        <font class="blklnkund"> <% = dtr["phoneKount"].ToString()%></font></a></font>
                </td>
                
                <td align="center" style="width: 7%">
                    <font class="blackfnt"> <a href="Call_Summary_Report.aspx?Mode=E-mail&Location=<%=dtr["loccode"].ToString()%>&Daterange=<%=Request.QueryString.Get("Daterange")%>&Date=<%=Request.QueryString.Get("Date")%>"  target="_blank"  >
                        <font class="blklnkund"> <% = dtr["mailKount"].ToString()%></font></a></font>
                </td>
                
                <td align="center" style="width: 5%">
                    <font class="blackfnt"> <a href="Call_Summary_Report.aspx?Mode=Chat&Location=<%=dtr["loccode"].ToString()%>&Daterange=<%=Request.QueryString.Get("Daterange")%>&Date=<%=Request.QueryString.Get("Date")%>"  target="_blank"  >
                        <font class="blklnkund"> <% = dtr["chatKount"].ToString()%></font></a></font>
                </td>
                
                <td align="center" style="width: 5%">
                    <font class="blackfnt"> <a href="Call_Summary_Report.aspx?Mode=SMS&Location=<%=dtr["loccode"].ToString()%>&Daterange=<%=Request.QueryString.Get("Daterange")%>&Date=<%=Request.QueryString.Get("Date")%>"  target="_blank"  >
                        <font class="blklnkund"> <% = dtr["smsKount"].ToString()%></font></a></font>
                </td>
                 
                <td align="center" style="width: 5%">
                    <font class="blackfnt"> <a href="Call_Summary_Report.aspx?&Location=<%=dtr["loccode"].ToString()%>&Daterange=<%=Request.QueryString.Get("Daterange")%>&Date=<%=Request.QueryString.Get("Date")%>"  target="_blank"  >
                        <font class="blklnkund"> <% = dtr["AllKount"].ToString()%></font></a></font>
                </td>
                  </tr>
                   <%  }

                   }
        dtr.Close();
        conn.Close();
   
        %>
        </table>
    </div>
    </form>
</body>
</html>
