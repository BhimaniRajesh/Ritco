<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup-vendor.aspx.cs" Inherits="GUI_WebAdmin_popup_cust" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
   <script language="javascript">
  
    function Child(obj)
    {
	    var Str = obj.value;
	    Str = Str.split(",");
	   // window.opener.document.aspnetForm.ctl00$MyCPH1$txtPaidTo.value=Str[0]+'~'+Str[1];
	    //window.opener.document.aspnetForm.ctl00$MyCPH1$txtCode.value=Str[1];
	     window.opener.document.aspnetForm.ctl00$MyCPH1$txtPaidTo.value=Str[0];
	   window.opener.document.aspnetForm.ctl00$MyCPH1$txtPaidTo_Name.value=Str[1];
        window.close(); 
    }

</script>
   <title>Vendor</title>
</head>
<body>
<atlas:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true">
        </atlas:ScriptManager>
    <form id="form1" runat="server">
    <p></p><center>
    <asp:UpdatePanel ID="Vandor" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                        <ContentTemplate>
                          
                        
<table border=0 width=99% cellspacing=1 cellpadding=0>
<tr><td>
<font class=blackfnt><b><u>Note:</u></b> 
<!--<br>- Please enter Customer Name start with 'S' as 'S'-->
<br>- For All Vendor list,keep blank both the input box.
</font>
</td></tr>
</table>
<br>
<table border=1 width=85% cellspacing=1 cellpadding=2>
  <tr class="bgbluegrey">
     <td colspan=2 align=center><font class=blackfnt>Search by parameter</font></td>
  </tr>
  <tr>
   <td><font class=blackfnt>Vendor Code</font></td>
   <td style="text-align: left"><font class=blackfnt>&nbsp;<asp:TextBox ID="txtCustCode" runat="server" CssClass="inp" Width="120px"></asp:TextBox>&nbsp;</font></td>
  </tr>
  <tr>
   <td><font class=blackfnt>Vendor Name</font></td>
   <td style="text-align: left"><font class=blackfnt>&nbsp;<asp:TextBox ID="txtCustName" runat="server" CssClass="inp" Width="186px"></asp:TextBox></font></td>
  </tr>
<tr>
   <td colspan=2 align=center>
       <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></td>
  </tr>
</table>
<br>
<table border=0 width=99% cellspacing=1 cellpadding=0>
<tr><td>
<font class=blackfnt><b><u>Note:</u></b> 
<!--<br>- Please enter Customer Name start with 'S' as 'S'-->
<br>- Click on radio buton to select Vendor.
</font>
</td></tr>
</table>
<br />
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
        <asp:Table ID="Table1" runat="server">
        <asp:TableRow>
        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
        <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
        </asp:TableRow>
        </asp:Table>
        </ProgressTemplate>
        </asp:UpdateProgress>

<br />
<table border=0 width=100% cellspacing=1 cellpadding=0>
    <tr>
        <td>
            <table border="0" width="90%" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey">
                            <td width="10%" align="left"></td>
                            <td width="30%" align="left"><font class="blackfnt">&nbsp;Vendor Code</font></td>
                            <td align="left"><font class="blackfnt">&nbsp;Vendor Name</font></td>
                        </tr>
                    </table>
            <asp:DataList ID="DataList1" runat="server" width="90%">
                
                <ItemTemplate>
                    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr>
                            <td width="10%" bgcolor="white" align="left">&nbsp;<input name=chk type=radio onclick="Child(this);" value='<%#DataBinder.Eval(Container.DataItem,"vendorCode")+","+DataBinder.Eval(Container.DataItem, "vendorname") %>' ></td>
                            <td width="30%" bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem, "vendorCode")%></font></td>
                            <td bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem, "vendorname")%></font></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        </td>
    </tr>
</table>
<br></ContentTemplate>
                    </asp:UpdatePanel>
</center><p>
    </form>
</body>
</html>
