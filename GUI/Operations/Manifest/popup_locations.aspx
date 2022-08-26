<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup_locations.aspx.cs" Inherits="GUI_Operations_LS_ver2_popup_locations" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
   <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />   
   <title>Location</title>
   <script language="javascript" type="text/javascript">  
        function Child(obj)
        {
	        var Str = obj.value;	        
	        window.opener.document.aspnetForm.ctl00$MyCPH1$txtNextStop.value=Str;
	        //window.opener.document.getElementById('ctl00$MyCPH1$txtCustomer').returnValue = Str;
            window.close(); 
        }
    </script>
</head>

<body>
    <form id="form1" runat="server">
    <p></p><center>
<table border="0" width="99%" cellspacing="1" cellpadding="0">
<tr><td>
<font class="blackfnt"><b><u>Note:</u></b> 
<br />- For All Location list,keep blank both the input box.
</font>
</td></tr>
</table>
<br />
<table border="1" width="85%" cellspacing="1" cellpadding="2">
  <tr class="bgbluegrey">
     <td colspan="2" align="center"><font class="blackfnt">Search by parameter</font></td>
  </tr>
  <tr>
   <td><font class="blackfnt">Location Code</font></td>
   <td style="text-align: left"><font class="blackfnt">&nbsp;<asp:TextBox ID="txtLocCode" runat="server" CssClass="inp" Width="120px"></asp:TextBox>&nbsp;</font></td>
  </tr>
  <tr>
   <td><font class="blackfnt">Location Name</font></td>
   <td style="text-align: left"><font class="blackfnt">&nbsp;<asp:TextBox ID="txtLocName" runat="server" CssClass="inp" Width="186px"></asp:TextBox></font></td>
  </tr>
<tr>
   <td colspan="2" align="center">
       <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></td>
  </tr>
</table>
<br />
<table border="0" width="99%" cellspacing="1" cellpadding="0">
<tr><td>
<font class="blackfnt"><b><u>Note:</u></b> 

<br />- Click on radio buton to select Location.
</font>
</td></tr>
</table>
<br />
<table border="0" width="100%" cellspacing="1" cellpadding="0">
    <tr>
        <td>
            <table border="0" width="90%" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey">
                            <td width="10%" align="left"></td>
                            <td width="30%" align="left"><font class="blackfnt">&nbsp;Br. Code</font></td>
                            <td align="left"><font class="blackfnt">&nbsp;Location Name</font></td>
                        </tr>
                    </table>
            <asp:DataList ID="DataList1" runat="server" width="90%">
                
                <ItemTemplate>
                    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr>
                            <td width="10%" bgcolor="white" align="left">&nbsp;<input name="chk" type="radio" onclick="Child(this);" value='<%#DataBinder.Eval(Container.DataItem,"LocCode") %>' ></td>
                            <td width="30%" bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem, "LocCode")%></font></td>
                            <td bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem, "LocName")%></font></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        </td>
    </tr>
</table>
<br />
</center><p></p>
    </form>
</body>
</html>
