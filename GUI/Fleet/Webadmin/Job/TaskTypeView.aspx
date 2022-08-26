<%@ Page Language="C#" AutoEventWireup="true" Title="Work Group" CodeFile="TaskTypeView.aspx.cs"
     Inherits="TaskTypeView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Work Group</title>
    <script language="javascript">
        function func()
        {
           window.print();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    
        <!--End of asp Script Manager -->
                        <asp:GridView ID="gvTaskType" runat="server" CellPadding="4" HeaderStyle-CssClass="dgHeaderStyle" 
                             AllowPaging="True" PageSize="50" PagerStyle-HorizontalAlign="left"               
                            PagerSettings-Mode="Numeric" AutoGenerateColumns="False"  
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." 
            DataKeyNames="TaskTypeId" Font-Names="Verdana" Font-Size="8pt" Width="100%" 
            onselectedindexchanged="gvTaskType_SelectedIndexChanged">
                            <Columns>
                               
                               
                                <asp:BoundField DataField="TaskType" HeaderText="Task Type"> 
                                    <ItemStyle HorizontalAlign="Left" Width="40%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="AccDesc" HeaderText="Account Description"> 
                                    <ItemStyle HorizontalAlign="Left" Width="60%" />    
                                      <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                                <asp:BoundField DataField="ActiveFlag" HeaderText="Active Flag">
                                    <ItemStyle HorizontalAlign="Left" Width="10%" />    
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundField>
                               
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>

   </form>
</body>
</html>
