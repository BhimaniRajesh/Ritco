<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup-CUST.aspx.cs" Inherits="GUI_admin_CustomerMaster_popup_CUST" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<link href="../../../images/style.css" rel="stylesheet"
    type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <script type="text/javascript" language="javascript" src="../../Js/querystring.js" ></script> 
    <script language="javascript" type="text/javascript">
        
        function SelectLocation(objLocation)
        {
            var qs = new Querystring();
            var mNo = qs.get("mNo");
            if(mNo == 1) {
                var customerValueArray = objLocation.value.split("~");
                window.opener.document.forms[0].ctl00$MyCPH1$txtCustCode.value = customerValueArray[0];
                window.opener.document.forms[0].ctl00$MyCPH1$txtCustName.value = customerValueArray[1];             
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
<br />- Please enter Customer Code start with 'S' as 'S'
<%--<br />- For All customers list,keep blank both the input box.--%>
</td></tr>
</table>
<table border="1" cellspacing="1" cellpadding="2" style="width: 41%">
  <tr class="bgbluegrey">
  </tr>
   <td><font class="blackfnt"><b>
        <asp:TextBox ID="txtCustCd" runat="server"></asp:TextBox>OR</b></font></td>
  <tr>
   <td><font class="blackfnt">
        <asp:TextBox ID="txtCustNm" runat="server"></asp:TextBox></font></td>
<tr>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
            <asp:Label ID="Label1" runat="server" ForeColor="#FF8080"></asp:Label></td>
  </tr>
<br />
                            AutoGenerateColumns="false" BorderWidth="1" CellPadding="7" CellSpacing="1" EmptyDataText="No Records Found..." 
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            Width="395px" class="boxbg">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" >
                                    <ItemTemplate>
                                        <input name="MyRadioButton" type="radio" value='<%# Eval("custcd") %>~<%# Eval("custnm") %>' onclick="SelectLocation(this)"/>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" Width="40px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="custcd" HeaderText="Customer Code">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="White" Width="80px" />
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="custnm" HeaderText="Customer Name">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="White"/>
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                              </Columns>
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>

    
    </div>
    </form>
</body>
</html>