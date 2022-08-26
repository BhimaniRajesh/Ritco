<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popupLoc.aspx.cs" Inherits="GUI_admin_CustomerMaster_popupLoc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Vehicles</title>
    <script type="text/javascript" src="New_Tripsheet.js"></script>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
        function SelectVehicle(objVehicle) {
            var dgWorkgroup = window.opener.document.getElementById("ctl00_MyCPH1_dgWorkgroup");
            var mNo = document.getElementById("hdnstrQSParam").value;
            //alert(mNo);
            var l = 0;
            l = dgWorkgroup.rows.length;
            //alert(objVehicle.value);
            for (i = 0; i < l - 1; i++) {
                j = i + 2;
                var pref = "";
                if (j < 10) {
                    pref = "ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_";
                }
                else {
                    pref = "ctl00_MyCPH1_dgWorkgroup_ctl" + j + "_";
                }


                if (mNo == 1) {
                    var txtVehNo = window.opener.document.getElementById(pref + "txtCstLoc");
                    var t = txtVehNo.value;
                    var len = t.length;
                    t = t.substr(len - 1, len);
                    if (t == ",") {
                    }
                    else {
                        txtVehNo.value += ",";
                    }
                    txtVehNo.value += objVehicle.value + ",";
                    objVehicle.disabled = true;
                }
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
