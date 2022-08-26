<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="wfrm_Fuel_Ticket_Generation_Add.aspx.cs" Inherits="GUI_Fleet_Webadmin_Fuel_wfrm_Fuel_Ticket_Generation_Add" %>
<%@ Register TagPrefix="UserControl" TagName="DatePicker" Src="../../../../UserControls/DatePicker.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script type="text/javascript" language="javascript" src="AJAX_Validator/js_Fuel.js"></script>
<script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td>
            <font class="blackfnt"><strong>Fuel Ticket Generation</strong></font>
            <hr size="1" color="#8ba0e5">
        </td>
    </tr>
</table>

<table align="left" border="0" cellpadding="4" cellspacing="1" class="boxbg" width="100%">
    <tr class="bgbluegrey" align="center">
        <td align="center" colspan="4" class="blackfnt"><font class="blackfnt"><strong>Fuel Ticket Generation</strong></font></td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="20%"><font class="blackfnt">Ticket Number</font></td>
        <td class="bluefnt" align="left" style="color: #ff3366" width="30%"><asp:Label ID="lbl_Ticket_No" runat="server" Text="System Generated..."></asp:Label></td>
        <td align="left" width="20%"><font class="blackfnt">Manual Ticket Number</font></td>
        <td class="blackfnt" align="left">
            <asp:TextBox ID="tb_Manual_Ticket_No" runat="server" CssClass="input"></asp:TextBox>
            <asp:Label ID="lbl_Ticket_Error" runat="server" CssClass="redfnt" Text=""></asp:Label>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left"><font class="blackfnt">Date</font></td>
        <td class="blackfnt" align="left" colspan="3">
            <table border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <UserControl:DatePicker ID="dp_Ticket_Date" runat="server" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left"><font class="blackfnt">Vehicle Number</font></td>
        <td class="blackfnt" align="left">
            <asp:TextBox ID="tb_Vehicle_No" runat="server" CssClass="input" MaxLength="10" Width="100px"></asp:TextBox>
            <asp:HiddenField ID="hf_Vehicle_No" runat="server" />
            <input id="btn_Vehicle" onclick="javascript:window.open('wfrm_Popup_Vehicle.aspx',null,'height=250,width=300,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no');" type="button" value="..." />
            <asp:Label ID="lbl_Vehicle_Error" runat="server" CssClass="bluefnt" Text=""></asp:Label>
        <td align="left"><font class="blackfnt">Manufacturer</font></td>
        <td class="bluefnt" align="left"><asp:Label ID="lbl_Manufacturer" runat="server" EnableViewState="true" Text=""></asp:Label></td>
    </tr>
    <tr style="background-color: white">
        <td align="left"><font class="blackfnt">Model</font></td>
        <td class="bluefnt" align="left"><asp:Label ID="lbl_Model" runat="server" EnableViewState="true" Text=""></asp:Label></td>
        <td align="left"><font class="blackfnt">Fuel Tank Capacity</font></td>
        <td class="bluefnt" align="left"><asp:Label ID="lbl_Fuel_Tank_Capacity" runat="server" EnableViewState="true" Text=""></asp:Label></td>
    </tr>
    <tr style="background-color: white">
        <td align="left"><font class="blackfnt">Journey ID</font></td>
        <td class="blackfnt" align="left">
            <asp:TextBox ID="tb_Trip_Sheet_ID" runat="server" CssClass="input" MaxLength="15" Width="100px"></asp:TextBox>
            <input id="btn_Journey" onclick="javascript:window.open('wfrm_Popup_Journey.aspx',null,'height=250,width=300,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no');" type="button" value="..." />
            <asp:Label ID="lbl_Journey_Error" runat="server" CssClass="bluefnt" Text=""></asp:Label>
        </td>
        <td align="left"><font class="blackfnt">Driver Name</font></td>
        <td class="bluefnt" align="left"><asp:Label ID="lbl_Driver_Name" runat="server" Text=""></asp:Label></td>
    </tr>
    <tr style="background-color: white">
        <td align="left"><font class="blackfnt">Vendor Code</font></td>
        <td class="blackfnt" align="left">
            <asp:TextBox ID="tb_VendorCode" runat="server" CssClass="input" Width="50px" MaxLength="10"></asp:TextBox>
            <input id="btn_Vendor" onclick="javascript:window.open('wfrm_Popup_Vendor.aspx',null,'height=250,width=300,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no');" type="button" value="..." />
            <asp:Label ID="lbl_VendorName" runat="server" CssClass="bluefnt" Text=""></asp:Label>
        </td>
        <td align="left"><font class="blackfnt">Fuelling Location</font></td>
        <td class="blackfnt" align="left">
            <asp:TextBox ID="tb_Fuel_Location" runat="server" CssClass="input"></asp:TextBox>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left"><font class="blackfnt">Fuel Type</font></td>
        <td class="blackfnt" align="left">
            <asp:UpdatePanel ID="up_Fuel_Type" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                <ContentTemplate>
                    <asp:DropDownList ID="ddl_Fuel_Type" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddl_Fuel_Type_SelectedIndexChanged" Width="100px"></asp:DropDownList>
                </ContentTemplate>
            </asp:UpdatePanel>
        </td>
        <td align="left"><font class="blackfnt">Fuel Brand</font></td>
        <td class="blackfnt" align="left">
            <asp:UpdatePanel ID="up_Fuel_Brand" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                <ContentTemplate>
                    <asp:DropDownList ID="ddl_Fuel_Brand" runat="server" Width="100px"></asp:DropDownList>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddl_Fuel_Type" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left"><font class="blackfnt">Last Meter Reading</font></td>
        <td class="bluefnt" align="left">
            <asp:TextBox ID="tb_Last_Meter_Read" runat="server" CssClass="bluefnt" BorderStyle="None">0</asp:TextBox>
            <asp:HiddenField ID="hf_Last_Meter_Read" runat="server" />
        </td>
        <td align="left"><font class="blackfnt">Current Meter Reading</font></td>
        <td class="blackfnt" align="left">
            <asp:TextBox ID="tb_Curr_Meter_Read" runat="server" CssClass="input">0</asp:TextBox>
            <asp:RegularExpressionValidator ID="rev_Curr_Meter_Read" runat="server" ControlToValidate="tb_Curr_Meter_Read"
                ErrorMessage="!!!!" ForeColor="Blue" ToolTip=" Invalid Current Meter Reading "
                ValidationExpression="^(\+|-)?\d{1,6}(\.\d{1,3})?$" Display="Dynamic"></asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left"><font class="blackfnt">Total KMs</font></td>
        <td class="bluefnt" align="left"><asp:Label ID="lbl_Total_KMs" runat="server" Text="0"></asp:Label></td>
        <td align="left"><font class="blackfnt">Quantity in Litres</font></td>
        <td class="blackfnt" align="left">
            <asp:TextBox ID="tb_Qty_In_Litres" runat="server" CssClass="input">0</asp:TextBox>
            <asp:RegularExpressionValidator ID="rev_Qty_In_Litres" runat="server" ControlToValidate="tb_Qty_In_Litres"
                ErrorMessage="!!!!" ForeColor="Blue" ToolTip=" Invalid Quantity in Litres "
                ValidationExpression="^\d{1,6}(\.\d{1,3})?$" Display="Dynamic"></asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left"><font class="blackfnt">Fuel Cost</font></td>
        <td class="blackfnt" align="left">
            <asp:TextBox ID="tb_Fuel_Cost" runat="server" CssClass="input">0</asp:TextBox>
            <asp:RegularExpressionValidator ID="rev_Fuel_Cost" runat="server" ControlToValidate="tb_Fuel_Cost"
                ErrorMessage="!!!!" ForeColor="Blue" ToolTip=" Invalid Fuel Cost "
                ValidationExpression="^\d{1,6}(\.\d{1,2})?$" Display="Dynamic"></asp:RegularExpressionValidator>
        </td>
        <td align="left"><font class="blackfnt">Tax</font></td>
        <td class="blackfnt" align="left">
            <asp:TextBox ID="tb_Fuel_Tax" runat="server" CssClass="input">0</asp:TextBox>
            <asp:RegularExpressionValidator ID="rev_Fuel_Tax" runat="server" ControlToValidate="tb_Fuel_Tax"
                ErrorMessage="!!!!" ForeColor="Blue" ToolTip=" Invalid Fuel Tax "
                ValidationExpression="^\d{1,6}(\.\d{1,2})?$" Display="Dynamic"></asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="left"><font class="blackfnt">Total Cost</font></td>
        <td class="bluefnt" align="left"><asp:Label ID="lbl_Fuel_Total_Cost" runat="server" Text="0"></asp:Label></td>
        <td align="left"><font class="blackfnt">Fuel Rate/Litre</font></td>
        <td class="bluefnt" align="left"><asp:Label ID="lbl_Fuel_Rate" runat="server" Text="0"></asp:Label></td>
    </tr>
    <tr style="background-color: white">
        <td align="left"><font class="blackfnt">Bill No</font></td>
        <td class="blackfnt" align="left">
            <asp:TextBox ID="tb_Bill_No" runat="server" CssClass="input"></asp:TextBox>
        </td>
        <td align="left"><font class="blackfnt">Mode of Payment</font></td>
        <td class="blackfnt" align="left">
            <asp:DropDownList ID="ddl_Pay_Mode" runat="server">
                <asp:ListItem Value="">-- Select --</asp:ListItem>
                <asp:ListItem Value="Bank">Bank</asp:ListItem>
                <asp:ListItem Value="Cash">Cash</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr style="background-color: white">
        <td align="center" colspan="4">
            <font class="blackfnt">
                <input id="btn_Go_for_listing" type="button" value="Go for listing" onclick="javascript:window.location = 'wfrm_Fuel_Ticket_Generation_Edit.aspx';" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btn_Save_And_Resume" runat="server" Text="Save & Resume" OnClick="btn_Save_And_Resume_Click" />
                &nbsp;&nbsp;
                <asp:Button ID="btn_Save" runat="server" Text="Save" OnClick="btn_Save_Click" /></font></td>
    </tr>
    <tr style="background-color: white">
        <td class="blackfnt" align="center" colspan="4">
            <font style="color:Red;">
                <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Large" Text=""></asp:Label></b>
            </font>
        </td>
    </tr>
</table>
</asp:Content>
