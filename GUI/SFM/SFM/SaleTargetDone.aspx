<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="SaleTargetDone.aspx.cs" Inherits="SFM_SaleTargetDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
 <table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Sale Target Entry Done" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>

<br />

<script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2)
        { 
        window.open("./SaleTargetView.aspx?strSaleTargetCode=" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"); 
        }
    </script>

<div align="center">
        <table border="0" cellpadding="4" cellspacing="1" class="boxbg" width="85%">
            <tr class="bgbluegrey">
                <td align="center" colspan="4" >
                    <font class="bluefnt"><b>Following document has been successfully generated</b></font></td>
            </tr>
            <tr>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="2" ><font class="blackfnt" >Document name</font></td>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="1" ><font class="blackfnt" >Document Number</font></td>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt">&nbsp;</font></td>
  </tr>
   <tr>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="2"><font class="blackfnt">Sale Target</font></td>
    <td  align="center" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt"><%=Request.QueryString.Get("SaleTargetCode")%></font></td>
    
    <td  align="right" bgcolor="#FFFFFF" height="18" colspan="1"><font class="blackfnt"><a href="Javascript:ViewPrint('<%=Request.QueryString.Get("SaleTargetCode")%>',0)">View </a>| <a href="Javascript:ViewPrint('<%=Request.QueryString.Get("SaleTargetCode")%>',1)">Print</a> </td>
  </tr>
  <tr>
    <td  align="left" bgcolor="#FFFFFF" height="18" colspan="4"><font class="blackfnt"><b>Your Next Step:</b></font></td>
    
  </tr>
      
      <tr  bgcolor="#FFFFFF">
    <td width="2%" height="15" bgcolor="#FFFFFF"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#FFFFFF" height="15" colspan="3"><font class="blackfnt" color="#0000FF"><a href="SalesTarget1.aspx"><font class="blklnkund">Enter Sales Target for more Customers/Prospects</a></font></td>
  </tr>
  <tr  bgcolor="#FFFFFF">
    <td width="2%" height="15" bgcolor="#FFFFFF"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#FFFFFF" height="15" colspan="3"><font class="blackfnt" color="#0000FF"><a href="../REPORT/SaleTarget_main.aspx"><font class="blklnkund">Sales Target Register</a></font></td>
  </tr>
   <tr  bgcolor="#FFFFFF">
    <td width="2%" height="15" bgcolor="#FFFFFF"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#FFFFFF" height="15" colspan="3"><font class="blackfnt" color="#0000FF"><a href="../Main.aspx"><font class="blklnkund">SFM Main Page</a></font></td>
  </tr>
  
      
      
            
            
        </table>
    </div>
   </asp:Content>
