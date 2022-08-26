<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Popup-Driver1.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_Popup_Driver" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<link href="../../../images/style.css" rel="stylesheet"
    type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
        <script type="text/javascript" language="javascript" src="../../../Js/querystring.js" ></script>
    <script language="javascript" type="text/javascript">
        
        function SelectLocation(objLocation)
        {
            var qs = new Querystring();
            var mNo = qs.get("mNo");
            if(mNo == 1)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtDriver1.value = objLocation.value;
                window.close();
            }
        }
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center>
<table border="0" cellspacing="1" cellpadding="0" style="width: 41%">
<tr><td>
<font class="blackfnt"><b><u>Note:</u></b> 
<br />- Please enter Driver Code start with 'S' as 'S'
<br />- Please enter Driver Name start with 'S' as 'S'
</font>
</td></tr>
</table>
<br />
<table border="1" cellspacing="1" cellpadding="2" style="width: 41%">
  <tr class="bgbluegrey">
     <td colspan="2" align="center"><font class="blackfnt">Search by parameter</font></td>
  </tr>
  <tr>
   <td style="width: 172px"><font class="blackfnt">Driver Code</font></td>
   <td><font class="blackfnt"><b>
        <asp:TextBox ID="txtDCode" runat="server"></asp:TextBox>OR</b></font></td>
  </tr>
  <tr>
   <td style="width: 172px"><font class="blackfnt">Driver Name</font></td>
   <td><font class="blackfnt">
        <asp:TextBox ID="txtDName" runat="server"></asp:TextBox></font></td>
  </tr>
<tr>
   <td colspan="2" align="center">
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
            <asp:Label ID="Label1" runat="server" ForeColor="#FF8080"></asp:Label></td>
  </tr>
</table>
<br />
                         <asp:GridView ID="GridView1" runat="server" AllowPaging="false" AllowSorting="true"
                            AutoGenerateColumns="false" BorderWidth="1" CellPadding="7" CellSpacing="1" EmptyDataText="No Records Found..." 
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            Width="395px" class="boxbg">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" >
                                    <ItemTemplate>
                                        <input name="MyRadioButton" type="radio" value='<%# Eval("Driver_Name") %>' onclick="SelectLocation(this)"/>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" Width="40px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Manual_Driver_Code" HeaderText="Driver Code">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="White" Width="80px" />
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Driver_Name" HeaderText="Driver Name">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="White"/>
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                              </Columns>
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
<%--<table border="0" width="100%" cellspacing="1" cellpadding="0" class="boxbg">  <tr class="bgbluegrey">    <td width="30%">&nbsp;<font class="blackfnt"><b>Cust. Code</b></font></td>    <td>&nbsp;<font class="blackfnt"><b>Cust. Name</b></font></td>  </tr>  
  <tr bgcolor="#FFFFFF">    <td width="30%">&nbsp;<font class="blackfnt"></font></td>    <td>&nbsp;<font class="blackfnt"></font></td></tr>
  
</table>--%>
</center>

<!-- Script Size:  0.56 KB  -->

    
    </div>
    </form>
</body>
</html>
