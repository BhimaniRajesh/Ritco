<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup-usage.aspx.cs" Inherits="GUI_UNI_MIS_chequemgt_popup_usage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Usage</title>
    <link id="Link1" href="../../../images/style.css" rel="Stylesheet" type="text/css" runat="server" />
</head>
<body bgcolor="#FFFFFF">
<form name="frm" method="post">
<%
    string mode = Request.QueryString.Get("mode");
    if (mode == "1")
    {
%>
<script language="javascript" type="text/javascript">

function loadme()
{
window.print();
}
window.load =loadme()
</script>
<%
    }
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td></td>
  </tr>
  <tr> 
    <td> 
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
    <td> 
					  <tr> 
    <td> 
    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr> 
	<td> 
    <p align=center ><font class=bluefnt><strong><u>Cheque Summary</u></strong></font> </p >
	<table cellSpacing="1" cellPadding="1" border="0" class="boxbg" width="95%"  align="center">
     <tr class="bgbluegrey"> 
     
      <td vAlign="top"  bgcolor="#FFFFFF" width="129"><font class=blackfnt>Cheque number</font></td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" > 
        <div align="left"><font class=blackfnt >&nbsp;<asp:Label ID="Label1" runat="server"></asp:Label></font></div>
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class=blackfnt>Cheque date</font> 
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class=blackfnt>
        &nbsp;<asp:Label ID="Label5" runat="server"></asp:Label></font></td>
    </tr>
     <tr> 
      <td vAlign="top"  bgcolor="#FFFFFF" width="129"><font class=blackfnt>Issue location</font></td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" > 
        <div align="left"><font class=blackfnt >&nbsp;<asp:Label ID="Label2" runat="server"></asp:Label></font></div>
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class=blackfnt>Issue date</font> 
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class=blackfnt>
        &nbsp;<asp:Label ID="Label6" runat="server"></asp:Label></font></td>
    </tr>
   
    <tr> 
      <td vAlign="top"  bgcolor="#FFFFFF" width="129"><font class=blackfnt>Issue voucher no ##</font></td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" > 
        <div align="left"><font class=blackfnt>&nbsp;<asp:Label ID="Label3" runat="server"></asp:Label></font>
            &nbsp;</div>
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class=blackfnt>Issued from</font> 
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class=blackfnt>
        <font class=blackfnt>&nbsp;<asp:Label ID="Label7" runat="server"></asp:Label></font></font></td>
    </tr>
   
    <tr> 
      <td vAlign="top" height="19" bgcolor="#FFFFFF" align="left" width="166"><font class=blackfnt>Cheque Amount </font></td>
      <td vAlign="top" height="19" bgcolor="#FFFFFF" align="left" width="222"><font class=blackfnt>&nbsp;<asp:Label ID="Label4" runat="server"></asp:Label></font></td>
      <td vAlign="top" height="21" bgcolor="#FFFFFF" align="left" width="166"><font class=blackfnt>Issued to</font></td>
      <td vAlign="top" height="21" bgcolor="#FFFFFF" align="left" width="222"><font class=blackfnt>
        <font class=blackfnt> &nbsp;<asp:Label ID="Label8" runat="server" CssClass="blackfnt"></asp:Label></font></font></td>
    </tr>
    
  
  </table>
   <br> <br>
       
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
