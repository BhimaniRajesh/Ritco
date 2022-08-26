<!-- #include file="../functions.asp" -->


<%
fin_mode=request.querystring

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
<LINK title=stylesheet href="../images/style.css" type=text/css rel=stylesheet>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="30"><A href="../welcome.asp"><font class=blklnkund><strong>

		  <%=session("Level_Type")%></font></a>
		  
	&gt; <font class=bluefnt><strong>Reports </strong></font>
		  
		  </td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr> 
          <td><img src="../images/clear.gif" width="15" height="10"></td>
        </tr>
        
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="39%" valign="top">
                 <!--<table width="100%" border="1" cellspacing="0" cellpadding="3" BGCOLOR="#808080"  class=boxbg>
                    
                    
                    <tr  bgcolor="#FFFFFF"> 
                      <td valign="top"  >--> 
                        <table width="40%" border="0" cellpadding="5" cellspacing="1" class=boxbg>
						
						
                          
						<tr> 
                            <td width="2%" height="25" bgcolor="#FFFFFF"> 
                              <table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class=bullet><img src="../images/clear.gif" width="4" height="4"></td>
                                </tr>
                              </table> </td>
                        
							<td width="98%" bgcolor="#FFFFFF"><a href="rpt_operation_new.asp"><font class=blklnkund>Operations</font></a></td>
                          </tr>
                          
						<tr> 
                            <td height="25" bgcolor="#FFFFFF">
							   <table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class=bullet><img src="../images/clear.gif" width="4" height="4"></td>
                                </tr>
                              </table></td>
                            
							<td bgcolor="#FFFFFF"><a href="rpt_finance_new.asp"><font class=blklnkund>Finance & Accounts</font></a></td>

                          </tr>
                          
                          
		 
						<!--<tr> 
                            <td height="25" bgcolor="#FFFFFF">
							   <table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class=bullet><img src="../images/clear.gif" width="4" height="4"></td>
                                </tr>
                              </table></td>
							<td bgcolor="#FFFFFF"><a href="rpt_all.asp"><font class=blklnkund>View All</font></a></td>
                          </tr>-->
                          
                          <tr> 
                            <td height="25" bgcolor="#FFFFFF">
							   <table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class=bullet><img src="../images/clear.gif" width="4" height="4"></td>
                                </tr>
                              </table></td>
							<td bgcolor="#FFFFFF"><a href="rpt_specific_new.asp"><font class=blklnkund>Specific Reports</font></a></td>
                          </tr>
                        

						                                                                             


                        </table>
                      
                    </tr>
                    <tr  bgcolor="#FFFFFF"> 
                      <td colspan=3>&nbsp;</td>
                    </tr>
                    <tr>
                      <td><!--#include file="../bot.asp"--></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
