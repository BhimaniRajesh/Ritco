<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popupLocVer1.aspx.cs" Inherits="GUI_admin_CustomerMaster_popupLocVer1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Vehicles</title>
    <script type="text/javascript" src="New_Tripsheet.js"></script>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
        function SelectVehicle(objVehicle) {
            var dgWorkgroup = window.opener.document.getElementById("ctl00_MyCPH1_dgWorkgroup");
            var id = document.getElementById("hdnstrQSParam").value;
         
            var txtVehNo = window.opener.document.getElementById(id.replace("Label2", "txtCstLoc"));
          
            if (txtVehNo.value != "") {
                if (txtVehNo.value[txtVehNo.value.length - 1] == ',')
                {
                    //txtVehNo.value += objVehicle.value + ",";
                }
                else
                {
                    //txtVehNo.value += "," + objVehicle.value;
                }
				txtVehNo.value += "," + objVehicle.value;
            } else {
                    txtVehNo.value =  objVehicle.value + "," ;
            }
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:GridView ID="gvLocationList" runat="server" AllowPaging="false" AllowSorting="true" OnRowDataBound="gvLocationList_RowDataBound"
            AutoGenerateColumns="false" BorderWidth="0" CellPadding="7" CellSpacing="1" EmptyDataText="No Records Found..."
            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
            Width="350px" CssClass="boxbg">
            <Columns>
                <asp:TemplateField HeaderText="Select" ItemStyle-BackColor="white" ItemStyle-Width="40px">
                    <ItemTemplate>
                        <%-- <input name="MyRadioButton" type="radio" value='<%# Eval("vehno") %>' onclick="SelectVehicle(this.getAttribute('id'))"/>  --%>
                        <input name="MyRadioButton" id="RbtVeh" type="radio" value='<%# Eval("vehno")%>' onclick="SelectVehicle(this)" />

                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="vehno" HeaderText="Vehicle No.">
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white" Width="80px" />
                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
            </Columns>
            <PagerStyle HorizontalAlign="Left" />
            <HeaderStyle CssClass="dgHeaderStyle" />
        </asp:GridView>
           <asp:HiddenField ID="hdnstrQSParam" runat="server" /> 
    </form>
</body>
</html>
