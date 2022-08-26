<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="MIscbill_done.aspx.cs" Inherits="Finance_Billing_Billsubmission_Billsub_Step2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
     <link href="../../../images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">--%>
    <script language="javascript" type="text/javascript">
    
        function ViewPrint(arg1,arg2)
        {
            //window.open("viewPrintpopup.aspx?billno=" + arg1 + "&printyn=" + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
            window.open("./viewPrintpopup.aspx?billno=" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
        }
        
    </script>
    <div>
    <table  style="width:10in" border="0" cellpadding="0" cellspacing="0">
    <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><a href="../../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
   <a href="#"><font class="blklnkund"><strong>Finance</strong></font>    </a> 
   <strong> &gt; </strong><a href="../Billing.aspx"=><font class="blklnkund"><strong>Billing</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		  MIsc Bill
		   
		  </strong> </font>
   </td></tr>
     <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>

        <tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../../images/back.gif" border=0></a></td>
        </tr>
        <tr> 
          <td><img src="../../../images/clear.gif" width="15" height="10"></td>
        </tr>
     
    <tr>
    <td>
    
   
    <br />
     <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:60%"  align="center">
       <tr  class="bgbluegrey" style="height:25px">
            <td colspan="3" align="center" style="height: 25px"><font class="blackfnt"><b> Following Bills Are Submited</b></font></td>
            
       </tr>
        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
            <td align="center" style="width: 282px">
                <font class="blackfnt">Billnos</font></td>
            <td style="width: 339px" align="center"><b>
                <asp:Label ID="lblbillno" runat="server" CssClass="blackfnt" Width="313px"></asp:Label></b></td>
            <td style="width: 339px" align="center">
                
                    <a href="Javascript:ViewPrint('<%=billnos%>',0)">View </a> |
                    <a href="Javascript:ViewPrint('<%=billnos%>',1)">Print </a>
                
            </td>    
        </tr>
        
        
        
        
       </table>
       <p></p>
       </td>
        </tr>
       </table>
  </div></asp:Content>
    
    <%--  </form>
</body>
</html>
--%>
