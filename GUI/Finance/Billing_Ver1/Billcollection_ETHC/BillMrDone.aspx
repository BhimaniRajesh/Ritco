<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="BillMrDone.aspx.cs" Inherits="Finance_Billing_Billcollection_BillMrDone" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" src="../../../images/dropdowncontent.js"></script>
<%--!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">--%>
    <script  language="javascript" type="text/javascript">
 
 function popupmenu1(mrsno)
 { 
     // alert(mrsno)
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
     
      confirmWin=window.open('./MR_Summ_Popup.aspx?mrsno='+ mrsno,"",winOpts);
 }
 </script>
    <div>
     <table  style="width:10in" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><b><a href="../../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
   <a href="#"><font class="blklnkund"><strong>Finance</strong></font>    </a> 
   <strong> &gt; </strong><a href="../Billing.aspx"=><font class="blklnkund"><strong>Billing</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		  Bill Collection 
		   
		  </strong> </font>
   </td></tr>
      
        <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
   
     <tr> 
          <td><asp:Label ID="Msg_err" CssClass="redfnt" Font-Bold="true"  runat="server" Text=""></asp:Label></td>
        </tr>
   
    <tr>
    <td>
    <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:60%"  align="center">
       <tr  class="bgbluegrey" style="height:25px">
           <td align="center" colspan="4" style="height: 25px">
               <font class="blackfnt"><b> Following document has been successfully generated:</b></font></td>
            
       </tr>
        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
            <td colspan="2" style="width: 130px">
            </td>
            <td style="width: 398px">
            </td>
            <td style="width: 339px">
            </td>
        </tr>
        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
            <td colspan="2" style="width: 130px">
                <font class="blackfnt">BillMR</font></td>
            <td style="width: 398px"  align="center">
                <asp:Label ID="lblbillno" runat="server"  CssClass="blackfnt" Width="313px"></asp:Label></td>
            <td style="width: 339px" class="blackfnt">
            <a  href="javascript:popupmenu1('<%=mrsno%>')">View/Print</a>
            
            </td>
        </tr>
        <tr  class="bgbluegrey" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td align="left" colspan="4">
             <strong><span style="font-size: 8pt; font-family: Verdana">Your Next Step</span></strong></td>
           </tr>
       <tr  bgcolor="#FFFFFF"> 
                              <td bgcolor="#FFFFFF" style="width: 381px; height: 25px"> <table border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td class="bullet"><img src="../../../images/clear.gif" width="4" height="4"  /></td>
                                  </tr>
                                </table></td>
                              <td width="100%" align="left" bgcolor="#FFFFFF" colspan="5" style="height: 25px"><font class="blackfnt"><u><a href="../../../Finance/Billing/Billsubmission/start.aspx"><font class="blklnkund">Click 
                                here to Submit more bills</a></u></font></td>
                                
</tr>
        
<tr  bgcolor="#FFFFFF"> 
                              <td height="25" bgcolor="#FFFFFF" style="width: 381px"> <table border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td class="bullet"><img src="../../../images/clear.gif" width="4" height="4" /></td>
                                  </tr>
                                </table></td>
                              <td width="100%" align="left" bgcolor="#FFFFFF" height="18" colspan="5"><font class="blackfnt"><u><a href="./start.aspx"><font class="blklnkund">Click 
                                here For Bill Collection</a></u></font></td>
   
                                
</tr>
<tr  bgcolor="#FFFFFF"> 
                              <td bgcolor="#FFFFFF" style="height: 25px; width: 381px;"> <table border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td class="bullet"><img src="../../../images/clear.gif" width="4" height="4"></td>
                                  </tr>
                                </table></td>
                              <td width="100%" align="left" bgcolor="#FFFFFF" colspan="5" style="height: 25px"><font class="blackfnt"><u><a href="#"><font class="blklnkund">Click 
                                here to View&Print bills</a></u></font></td>
                                
</tr>
        
        
       </table>
    </td>
        </tr>
       </table>
       <table	 border="0" style="height:6in;width:9.5in" >
							<tr>
							<td><img src="../../../../images/clear.gif" alt="" width="4" height="4" /></td>
							</tr>
							</table>	
       </div>
       </asp:Content>
   <%-- </form>
</body>
</html>
--%>
