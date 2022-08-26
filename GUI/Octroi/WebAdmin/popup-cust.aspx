<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup-cust.aspx.cs" Inherits="GUI_WebAdmin_popup_cust" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
   <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
   <script language="javascript">
  
    function Child(obj)
    {
        //alert()
	    var Str = obj.value;
	    //alert(Str)
	    
	    //window.returnValue = Str;
	    //window.opener.document.forms[0].csge.value=obj.value
	    window.opener.document.aspnetForm.ctl00$MyCPH1$txtCustomer.value=Str;
	    //window.opener.document.getElementById('ctl00$MyCPH1$txtCustomer').returnValue = Str;
        window.close(); 
    }

</script>
   <title>Customer</title>
</head>
<body>
    <form id="form1" runat="server">
    <p></p><center>
<table border=0 width=99% cellspacing=1 cellpadding=0>
<tr><td>
<font class=blackfnt><b><u>Note:</u></b> 
<!--<br>- Please enter Customer Name start with 'S' as 'S'-->
<br>- For All Customer list,keep blank both the input box.
</font>
</td></tr>
</table>
<br>
<table border=1 width=85% cellspacing=1 cellpadding=2>
  <tr class="bgbluegrey">
     <td colspan=2 align=center><font class=blackfnt>Search by parameter</font></td>
  </tr>
  <tr>
   <td><font class=blackfnt>Customer Code</font></td>
   <td style="text-align: left"><font class=blackfnt>&nbsp;<asp:TextBox ID="txtCustCode" runat="server" CssClass="inp" Width="120px"></asp:TextBox>&nbsp;</font></td>
  </tr>
  <tr>
   <td><font class=blackfnt>Customer Name</font></td>
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
<br>- Click on radio buton to select Customer.
</font>
</td></tr>
</table>
<br />
<table border=0 width=100% cellspacing=1 cellpadding=0>
    <tr>
        <td>
            <table border="0" width="90%" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey">
                            <td width="10%" align="left"></td>
                            <td width="30%" align="left"><font class="blackfnt">&nbsp;Customer Code</font></td>
                            <td align="left"><font class="blackfnt">&nbsp;Customer Name</font></td>
                        </tr>
                    </table>
            <asp:DataList ID="DataList1" runat="server" width="90%">
                
                <ItemTemplate>
                    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr>
                            <td width="10%" bgcolor="white" align="left">&nbsp;<input name=chk type=radio onclick="Child(this);" value='<%#DataBinder.Eval(Container.DataItem,"CUSTCD") %>' ></td>
                            <td width="30%" bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem,"CUSTCD") %></font></td>
                            <td bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem, "CUSTNM")%></font></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        </td>
    </tr>
</table>
<br>
</center><p>
    </form>
</body>
</html>
