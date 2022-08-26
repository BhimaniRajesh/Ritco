<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup-Vendor.aspx.cs" Inherits="GUI_admin_Vendor_popup_Vendor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link href="../../../GUI/admin/CityMaster/include/style.css" rel="stylesheet" type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <script language="javascript" type="text/javascript">
        
        function SelectLocation(objLocation)
        {
            var mNo = document.getElementById("hdnstrQSParam").value
            if(mNo == 1)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtVendorCd.value = objLocation.value
            }
            
        }
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <center>
<br />
<br />
                         <asp:GridView ID="GridView1" runat="server" AllowPaging="false" AllowSorting="true"
                            AutoGenerateColumns="false" BorderWidth="1" CellPadding="7" CellSpacing="1" EmptyDataText="No Records Found..." 
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            Width="395px" class="boxbg">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" >
                                    <ItemTemplate>
                                        <input name="MyRadioButton" type="radio" value='<%# Eval("vendorcode") %>' onclick="SelectLocation(this)"/>
                                    </ItemTemplate>
                                    <ItemStyle BackColor="White" Width="40px" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="vendorcode" HeaderText="Customer Code">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="White" Width="80px" />
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="vendorname" HeaderText="Customer Name">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="White"/>
                                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                              </Columns>
                            <PagerStyle HorizontalAlign="Left" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>

						<asp:HiddenField ID="hdnstrQSParam" runat="server" />
						
<%--<table border="0" width="100%" cellspacing="1" cellpadding="0" class="boxbg">  <tr class="bgbluegrey">    <td width="30%">&nbsp;<font class="blackfnt"><b>Cust. Code</b></font></td>    <td>&nbsp;<font class="blackfnt"><b>Cust. Name</b></font></td>  </tr>  

  <tr bgcolor="#FFFFFF">    <td width="30%">&nbsp;<font class="blackfnt"></font></td>    <td>&nbsp;<font class="blackfnt"></font></td></tr>
  
</table>--%>
</center>

<!-- Script Size:  0.56 KB  -->

    
    </div>
    </form>
</body>
</html>
