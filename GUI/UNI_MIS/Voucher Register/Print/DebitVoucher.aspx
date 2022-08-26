<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="DebitVoucher.aspx.cs" Inherits="GUI_Finance_DebitCredit_DebitVoucher" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>WebXpress: Credit Voucher Print</title>
    <link id="Link1" href="~/GUI/images/style_print.css" rel="Stylesheet" type="text/css" runat="server" />
</head>
<body>
<table align="center" border="0" cellpadding="0" cellspacing="0" width="width:9in;">
        <tr>
            <td align="right" style="height: 33px">
                <a href="javascript:window.history.go(-1)" title="back">
                <img border="0" src="../../images/back.gif"/ alt="back.gif" /></a>
            </td>
        </tr>
    </table>
    <br />


<br /><br />
    <asp:Label ID="lblvoucherheader" Font-Bold="true" style="left:50;" CssClass="blackfnt" runat="server"></asp:Label>

<br /><br />
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width:7in;">
          <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Branch </td>
            <td align="left" bgcolor="#ffffff">
                <asp:Label ID="lblbranch" CssClass="blackfnt" runat="server"></asp:Label>
            </td>
            <td align="left" class="bgbluegrey">Voucher No.</td>
            <td align="left" bgcolor="#ffffff">
                <asp:Label ID="lblvoucherno" runat="server"></asp:Label>
            </td>
          </tr>
          <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Recieved From  </td>
            <td align="left" bgcolor="#ffffff">
                <asp:Label ID="lblrecfrom" runat="server"></asp:Label>            
            </td>
            <td align="left" class="bgbluegrey">Date </td>
            <td align="left" bgcolor="#ffffff">
                <asp:Label ID="lbldate" runat="server"></asp:Label>
            </td>
          </tr>
          <tr class="blackfnt">
            <td align="left" class="bgbluegrey">Narration  </td>
            <td align="left" bgcolor="#ffffff" colspan="3">
                 <asp:Label ID="lblnarration" runat="server"></asp:Label>
            </td>
          </tr>
    </table>
    <br /><br />
    
       <font class="blackfnt"><b>A/C. : </b></font> <asp:Label CssClass="blackfnt" ID="lblaccno" runat="server"></asp:Label> : 
        <asp:Label ID="lblcashtype" CssClass="blackfnt" runat="server"></asp:Label>
        
       <br /><br />
        
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="width:7in;">
          <tr class="bgbluegrey">
            <td align="center" class="blackfnt">DESCRIPTION </td>
            <td align="center" class="blackfnt">Rs.</td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt"> 
                <asp:Label ID="lblaccdesc" runat="server"></asp:Label>
            </td>
            <td align="right" class="blackfnt">
                <asp:Label ID="lblmoney" runat="server"></asp:Label>
            </td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="right" class="blackfnt">
                <strong>Total Rs.</strong>
            </td>
            <td align="right" class="blackfnt">
                <asp:Label ID="lbltotalrs" runat="server"></asp:Label>
            </td>
          </tr>
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt" colspan="2">
                <asp:Label ID="lblinwords" runat="server"></asp:Label>
            </td>
          </tr>
        </table>  
          
        
        <br />
        <table bgcolor="#808080" border="0" class="boxbg" style="width:7in;">
          <tr bgcolor="#ffffff">
            <td align="left" class="blackfnt">Passing Authority </td>
            <td align="center" class="blackfnt">Cashier/Acc</td>
            <td align="right" class="blackfnt">Manager/Director</td>
          </tr>
        </table>  

<br />
 <div style="width:7in;" align="left"> <font class="blackfnt">ENCLOSE ALL SUPPORTING DOCUMENT</font></div><br />
 <asp:Label ID="lbltotalmoney" Font-Bold="true" runat="server"></asp:Label>
 <br /><br />
 <div style="width:7in;" align="right"> <font class="blackfnt">Signature</font></div><br />
</body>
