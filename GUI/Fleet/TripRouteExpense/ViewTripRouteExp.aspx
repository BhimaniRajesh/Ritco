<%@ Page Language="C#" AutoEventWireup="true" Title="Trip Route Expense" CodeFile="ViewTripRouteExp.aspx.cs" Inherits="TyreSizeView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Route Expense Master</title>
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
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." DataKeyNames="ID" Font-Names="Verdana" Font-Size="8pt" Width="100%">
                            <Columns>
                              <asp:BoundField DataField="route_exp_code" HeaderText="Route Expense Code" >
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>                               
                               
                                <asp:BoundField DataField="rutdesc" HeaderText="Route Description"> 
                                    <ItemStyle HorizontalAlign="Left" Width="40%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                
                                
                                
                                 <asp:BoundField DataField="VEHICLE_TYPE" HeaderText="Vehicle Type" >
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="fulexp_code" HeaderText="Trip Expense" >
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                 <asp:BoundField DataField="standard_rate" HeaderText="Standard Rate" >
                                    <ItemStyle HorizontalAlign="Right" Width="15%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                                              
                               
                                <asp:BoundField DataField="ACTIVE_FLAG" HeaderText="Active Flag">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                            <PagerStyle HorizontalAlign="Left" />
                        </asp:GridView>

   </form>
</body>
</html>
