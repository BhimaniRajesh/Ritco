<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popupbranch.aspx.cs" Inherits="GUI_admin_OpeningBalance_popupbranch" %>

<link href="../../../GUI/admin/LocationMaster/include/style.css" rel="stylesheet"
    type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>BranchList</title>
    
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
   <script language="javascript">
  
    function Child(obj)
    {
        //alert()
        qstr="<%=qstr%>"
       // alert(qstr)
	    var Str = obj.value;
	    //alert(Str)
	    
	    //window.returnValue = Str;
	    //window.opener.document.forms[0].csge.value=obj.value
	    if(qstr=="1")
	    {
	    window.opener.document.aspnetForm.ctl00$MyCPH1$txtBranchCode.value=Str;
	    }
	    else if(qstr=="2")
	    {
	    window.opener.document.aspnetForm.ctl00$MyCPH1$txtBranchCode1.value=Str;
	    }
	    else if(qstr=="3")
	    {
	    window.opener.document.aspnetForm.ctl00$MyCPH1$txtBranchCode2.value=Str;
	    }
	    else if(qstr=="4")
	    {
	    window.opener.document.aspnetForm.ctl00$MyCPH1$txtBranchCode3.value=Str;
	    }
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
<!--<br>- Please enter Customer Name start with 'S' as 'S'-->
<br>- For All Branch list,keep blank both the input box.
</font>
</td></tr>
</table>
<br>
<table border="1" width="85%" cellspacing="1" cellpadding="2">
  <tr class="bgbluegrey">
     <td colspan="2" align="center"><font class="blackfnt">Search by parameter</font></td>
  </tr>
  <tr>
   <td><font class="blackfnt">Branch Code</font></td>
   <td style="text-align: left"><font class="blackfnt">&nbsp;<asp:TextBox ID="txtCustCode" runat="server" CssClass="inp" Width="120px"></asp:TextBox>&nbsp;</font></td>
  </tr>
  <tr>
   <td><font class="blackfnt">Branch Name</font></td>
   <td style="text-align: left"><font class="blackfnt">&nbsp;<asp:TextBox ID="txtCustName" runat="server" CssClass="inp" Width="186px"></asp:TextBox></font></td>
  </tr>
<tr>
   <td colspan="2" align="center">
       <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></td>
  </tr>
</table>
<br>
<table border="0" width="99%" cellspacing="1" cellpadding="0">
<tr><td>
<font class="blackfnt"><b><u>Note:</u></b> 

<br>- Click on radio buton to select Branch.
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
                            <td width="30%" align="left"><font class="blackfnt">&nbsp;Branch Code</font></td>
                            <td align="left"><font class="blackfnt">&nbsp;Branch Name</font></td>
                        </tr>
                    </table>
            <asp:DataList ID="DataList1" runat="server" width="90%">
                
                <ItemTemplate>
                    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr>
                            <td width="10%" bgcolor="white" align="left">&nbsp;<input name="chk" type="radio" onclick="Child(this);" value='<%#DataBinder.Eval(Container.DataItem,"loccode") %>' ></td>
                            <td width="30%" bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem, "LocCode")%></font></td>
                            <td bgcolor="white" align="left"><font class="blackfnt">&nbsp;<%#DataBinder.Eval(Container.DataItem, "locname")%></font></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        </td>
    </tr>
</table>
<br />
</center><p></p>
                        <%--<asp:GridView ID="GridView1" runat="server" AllowPaging="false" AllowSorting="true"
                            AutoGenerateColumns="false" BorderWidth="1" CellPadding="7" CellSpacing="1" EmptyDataText="No Records Found..." 
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            Width="350px" class="boxbg">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ItemStyle-BackColor="white" ItemStyle-Width="40px" >
                                    <ItemTemplate>
                                        <input name="MyRadioButton" type="radio" value='<%# Eval("loccode") %>' onclick="SelectLocation(this)"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="loccode" HeaderText="Branch Code">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white" Width="80px" />
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="locname" HeaderText="Branch Name">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white"/>
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                              </Columns>
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>--%>
                   
        &nbsp;
    <div>
        &nbsp;</div>
    </form>
</body>
</html>
