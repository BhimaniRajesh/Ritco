<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popupc.aspx.cs" Inherits="GUI_UNI_MIS_accounts_mis_chequemgt_popupc" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>WebX</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
</head>
<body bgcolor="#FFFFFF" onload="return window_onload()">
<form>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
    <td> 
     <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">

        <tr> 
         
        </tr>

					  </table>	
					  <br />
					 
    
    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr> 
	<td> 
    <p align="center"><font class="bluefnt"><strong><u>Cheque Summary</u></strong></font> </p >
	<table cellspacing="1" cellpadding="3" border="0" width="95%" class="boxbg"  align="center">
     <tr> 
     
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Cheque number</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" > 
        <div align="left"><font class="blackfnt" ><font class="bluefnt">&nbsp;<asp:Label ID="lblchqno" runat="server"></asp:Label></font></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <font class="blackfnt">Cheque date</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt">
        <font class="bluefnt">&nbsp;<asp:Label ID="lblChqDt" runat="server"></asp:Label></font></font></td>
    </tr>
     <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Issue location</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" > 
        <div align="left"><font class="blackfnt" ><font class="bluefnt">&nbsp;<asp:Label ID="lblIssueLocation" runat="server"></asp:Label></font></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <font class="blackfnt">Issue date</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt">
        <font class="bluefnt">&nbsp;<asp:Label ID="lblIssueDt" runat="server"></asp:Label></font></font></td>
    </tr>
   
    <tr> 
      <td valign="top"  bgcolor="#FFFFFF" width="129"><font class="blackfnt">Issue voucher no.</font></td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" > 
        <div align="left"><font class="blackfnt" ><font class="bluefnt">&nbsp;<asp:Label ID="lblVoucherNo"
                runat="server"></asp:Label></font></font></div>
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <font class="blackfnt">Issued from</font> 
      </td>
      <td valign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt">
        <font class="bluefnt">&nbsp;<asp:Label ID="lblIssueFrom" runat="server"></asp:Label></font></font></td>
    </tr>
    
    <tr> 
      <td valign="top" height="19" bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Cheque Amount </font></td>
      <td valign="top" height="19" bgcolor="#FFFFFF" align="left" width="222"><font class="bluefnt">&nbsp;<asp:Label ID="lblchqamt" runat="server"></asp:Label></font></td>
      <td valign="top" height="21" bgcolor="#FFFFFF" align="left" width="166"><font class="blackfnt">Issued to</font></td>
      <td valign="top" height="21" bgcolor="#FFFFFF" align="left" width="222"><font class="blackfnt">
        <font class="blackfnt">&nbsp;<asp:Label ID="lblIssueTo" runat="server" CssClass="bluefnt"></asp:Label></font></font></td>
    </tr>
   
  </table>
   <br /><font class="blackfnt"><%--## Click on voucher number to view full details--%></font><br />

  
      
					  </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
 
					
</form>
</body>
</html>
