<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="wfrm_Fuel_Card_Master_Add.aspx.cs" Inherits="GUI_Fleet_Webadmin_Fuel_wfrm_Fuel_Card_Master_Add" %>
<%@ Register TagPrefix="UserControl" TagName="DatePicker" Src="../../../../UserControls/DatePicker.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script type="text/javascript" language="javascript" src="AJAX_Validator/js_Fuel.js"></script>
<script type="text/javascript" language="javascript" src="../../../../cal/popcalendar.js"></script>

<table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr>
        <td>
            <font class="blackfnt"><strong>Fuel Card Master</strong></font>
            <hr size="1" color="#8ba0e5">
        </td>
    </tr>
</table>

<table align="left" border="0" cellpadding="4" cellspacing="1" class="boxbg" width="60%">
    <tr class="bgbluegrey" align="center">
        <td align="center" colspan="2" class="blackfnt"><font class="blackfnt"><strong>Fuel Card Master</strong></font></td>
    </tr>
    <tr style="background-color: white">
        <td align="left" width="22%">
            <font class="blackfnt">Fuel Card ID</font></td>
        <td class="blackfnt" style="color: #ff3366;" align="left">
            <asp:Label ID="lbl_Fuel_Card_ID" runat="server" Text="System Generated..."></asp:Label></td>
    </tr>
    <tr style="background-color: white" >
        <td align="left">
            <font class="blackfnt">Manual Fuel Card No.</font></td>
        <td class="blackfnt" align="left">
            <asp:TextBox ID="tb_Manual_Fuel_Card_No" runat="server" CssClass="input" MaxLength="100"></asp:TextBox>
            <asp:Label ID="lbl_Manual_Fuel_Card_Error" runat="server" CssClass="redfnt" Text=""></asp:Label>
    </tr>

    <tr style="background-color: white" >
        <td align="left">
            <font class="blackfnt">Vendor Code</font></td>
        <td class="blackfnt" align="left">
            <asp:TextBox ID="tb_VendorCode" runat="server" CssClass="input" Width="50px" MaxLength="10"></asp:TextBox>
            <input id="btn_Vendor" onclick="javascript:window.open('wfrm_Popup_Vendor.aspx',null,'height=250,width=300,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no');" type="button" value="..." />
            <asp:Label ID="lbl_VendorName" runat="server" CssClass="bluefnt" Text=""></asp:Label>
    </tr>
    <tr style="background-color: white" >
        <td align="left">
            <font class="blackfnt">Issue Date</font>
        </td>
        <td class="blackfnt" align="left">
            <UserControl:DatePicker ID="dp_Issue_Date" runat="server" />
        </td>
    </tr>
    <tr style="background-color: white" >
        <td align="left"><font class="blackfnt">Expiry Date</font></td>
        <td class="blackfnt" align="left">
            <UserControl:DatePicker ID="dp_Expiry_Date" runat="server" />
        </td>
    </tr>
    <tr style="background-color: white" >
        <td align="left"><font class="blackfnt">Vehicle Number</font></td>
        <td class="blackfnt" align="left"><asp:TextBox ID="tb_Vehicle_No" runat="server" CssClass="input" MaxLength="10" Enabled=false></asp:TextBox>
        <input id="btn_Vehicle" onclick="javascript:window.open('wfrm_Popup_Vehicle.aspx',null,'height=250,width=300,status=no,resizable=yes,scrollbars=yes,toolbar=no,location=no,menubar=no');" type="button" value="..." />
         <asp:Label ID="lbl_Vehicle_Error" runat="server" CssClass="bluefnt" Text=""></asp:Label>
        </td>
    </tr>
    <tr style="background-color: white" >
        <td align="left">
            <font class="blackfnt">Fuel Type</font></td>
        <td class="blackfnt" align="left">
            <asp:UpdatePanel ID="up_Fuel_Type" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                <ContentTemplate>
                    <asp:DropDownList ID="ddl_Fuel_Type" runat="server" Width="100px" AutoPostBack="true" OnSelectedIndexChanged="ddl_Fuel_Type_SelectedIndexChanged"></asp:DropDownList>
                </ContentTemplate>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr style="background-color: white" >
        <td align="left">
            <font class="blackfnt">Fuel Brand</font></td>
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
        <td class="blackfnt" align="left">Active</td>
        <td class="blackfnt" align="left">
            <asp:CheckBox ID="chk_Active_Flag" runat="server" CssClass="blackfnt" />
            <asp:Label ID="lbl_Active_Flag" runat="server" Width="10px" BorderStyle="Ridge" Text="N"></asp:Label>
        </td>
    </tr>
    
    
    <tr style="background-color: white" >
        <td align="left">
            <font class="blackfnt">FO Ledger</font></td>
        <td class="blackfnt" align="left">
              <asp:DropDownList ID="ddl_LedgerType" runat="server" Width="200px" ></asp:DropDownList>
        </td>
    </tr>
    
    <tr style="background-color: white">
        <td align="right" colspan="2">
            <font class="blackfnt">
                <input id="btn_Go_for_listing" type="button" value="Go for listing" onclick="javascript:window.location = 'wfrm_Fuel_Card_Master_Edit.aspx';" />
                &nbsp;&nbsp;
                <asp:Button ID="btn_Save" runat="server" Text="Save" OnClick="btn_Save_Click" />
            </font>
        </td>
    </tr>
    <tr style="background-color: white">
        <td class="blackfnt" align="center" colspan="2">
            <font style="color:Red;">
                <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Large" Text=""></asp:Label></b>
            </font>
        </td>
    </tr>
</table>
</asp:Content>
