<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popupVirtualLoc.aspx.cs" Inherits="GUI_admin_CustomerMaster_popupLoc" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Location</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
        
        function SelectLocation(objLocation)
        {          
            var t = window.opener.document.forms[0].ctl00$MyCPH1$txtCstLoc.value;
            var len = t.length;            
            t = t.substr(len-1,len);
             
            if(t == ",")
            {                        
            }
            else
            {               
               window.opener.document.forms[0].ctl00$MyCPH1$txtCstLoc.value += ",";                     
            }     
               
               window.opener.document.forms[0].ctl00$MyCPH1$txtCstLoc.value += objLocation.value + ",";
               objLocation.disabled = true;            
         }
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:GridView ID="gvLocationList" runat="server" AllowPaging="false" AllowSorting="true"
            AutoGenerateColumns="false" BorderWidth="0" CellPadding="7" CellSpacing="1" EmptyDataText="No Records Found..."
            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
            Width="350px" CssClass="boxbg">
            <Columns>
                <asp:TemplateField HeaderText="Select" ItemStyle-BackColor="white" ItemStyle-Width="40px">
                    <ItemTemplate>
                        <input name="MyRadioButton" type="radio" value='<%# Eval("loccode") %>' onclick="SelectLocation(this)" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="loccode" HeaderText="Branch Code">
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white" Width="80px" />
                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="locname" HeaderText="Branch Name">
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white" />
                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
            </Columns>
            <PagerStyle HorizontalAlign="Left" />
            <HeaderStyle CssClass="dgHeaderStyle" />
        </asp:GridView>      
    </form>
</body>
</html>
