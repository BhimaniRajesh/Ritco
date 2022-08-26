<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popupVehicle.aspx.cs" Inherits="GUI_admin_FixedExpense_popupVehicle" %>

<link href="../../../GUI/images/style.css" rel="stylesheet"
    type="text/css" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vehicle</title>
    <script lang="javascript" type="text/javascript">

        function SelectVehicle(objVehicle) {
            var mNo = document.getElementById("hdnstrQSParam").value;
            var t = window.opener.document.forms[0].ctl00$MyCPH1$txtVehicle.value

            var len = t.length

            t = t.substr(len - 1, len)

            if (t == ",") {

            }
            else {

                window.opener.document.forms[0].ctl00$MyCPH1$txtVehicle.value += ","

            }
            window.opener.document.forms[0].ctl00$MyCPH1$txtVehicle.value += objVehicle.value + ","
            objVehicle.disabled = true;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <asp:GridView ID="GridVehicle" runat="server" AllowPaging="false" AllowSorting="true"
            AutoGenerateColumns="false" BorderWidth="1" CellPadding="7" CellSpacing="1" EmptyDataText="No Records Found..."
            HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
            Width="350px" class="boxbg">
            <Columns>
                <asp:TemplateField HeaderText="Select" ItemStyle-BackColor="white" ItemStyle-Width="30px">
                    <ItemTemplate>
                        <input name="MyRadioButton" type="radio" value='<%# Eval("VehNo") %>' onclick="SelectVehicle(this)" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="VehNo" HeaderText="Vehicle No">
                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Left" BackColor="white" Width="50px" />
                    <HeaderStyle CssClass="bgpink" HorizontalAlign="Left" Wrap="False" />
                </asp:BoundField>
            </Columns>
            <PagerStyle HorizontalAlign="Left" />
            <HeaderStyle CssClass="dgHeaderStyle" />
        </asp:GridView>
        <asp:HiddenField ID="hdnstrQSParam" runat="server" />
        &nbsp;
    <div>
        &nbsp;
        </div>
    </form>
</body>
</html>
