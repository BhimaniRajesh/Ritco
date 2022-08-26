<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopupVehicleNo.aspx.cs" Inherits="GUI_Fleet_Webadmin_Driver_PopupVehicleNo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Vehicle No. List</title>
    <script type="text/javascript" language="javascript" src="../../../Js/querystring.js" >
    </script>
    <script language="javascript" type="text/javascript">
        
        function SelectLocation(objLocation)
        {
            var qs = new Querystring();
            var mNo = qs.get("mNo");
            // alert(mNo");
            if(mNo == 2)
            {
                window.opener.document.forms[0].ctl00$MyCPH1$txtVehicleNo.value = objLocation.value
                window.close()
            }
        }
        
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:GridView ID="GridView1" runat="server" AllowPaging="false" AllowSorting="true"
                            AutoGenerateColumns="false" BorderWidth="1" CellPadding="7" CellSpacing="1" EmptyDataText="No Records Found..." 
                            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                            Width="350px" class="boxbg">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ItemStyle-BackColor="white" ItemStyle-Width="40px" >
                                    <ItemTemplate>
                                        <input name="MyRadioButton" type="radio" value='<%# Eval("VEHNO") %>' onclick="SelectLocation(this)"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                              
                                <asp:BoundField DataField="VEHNO" HeaderText="Vehicle No.">
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white"/>
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
