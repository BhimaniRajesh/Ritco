<%@ Page Language="C#" AutoEventWireup="true" Title="Tyre Manufacturer" CodeFile="ViewManufacturer.aspx.cs" Inherits="TyreManufacturerView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Tyre Manufacturer</title>
    <script language="javascript">
        function func()
        {
           window.print();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
  
                        <asp:GridView ID="GridView1" runat="server" CellPadding="4" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." DataKeyNames="MFG_ID" Font-Names="Verdana" Font-Size="8pt" ForeColor="#333333" Width="100%">
                            <Columns>
                               <asp:BoundField DataField="MFG_ID" HeaderText="Manufacturer ID" >
                                    <ItemStyle HorizontalAlign="Left" Width="20%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                                <asp:BoundField DataField="MFG_NAME" HeaderText="Name"> 
                                    <ItemStyle HorizontalAlign="Left" Width="40%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                <asp:BoundField DataField="MFG_ADDR" HeaderText="Address" >
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                                <asp:BoundField DataField="MFG_TELNO" HeaderText="Contact Number">
                                    <ItemStyle HorizontalAlign="Left" Width="20%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                               
                                <asp:BoundField DataField="MFG_ACTIVEFLAG" HeaderText="Active Flag">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" BackColor="#F7F6F3" ForeColor="#333333" />
                            <PagerStyle HorizontalAlign="Center" BackColor="#284775" ForeColor="White" />
                            <HeaderStyle CssClass="dgHeaderStyle" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#999999" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        </asp:GridView>

   </form>
</body>
</html>
