<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="TreadDepthMeasurement.aspx.cs" Inherits="GUI_Fleet_Tyre_TreadDepthMeasurement" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


<br />
<br /><br />

        
    <table border="0" class="boxbg"  cellpadding="4" cellspacing="1" style="width: 550px">
        
        <tr bgcolor="white">
            <td style="font-weight: bold; width: 100%; height: 68px">
                TYRE TREAD DEPTH MEASUREMENT MODULE</td>
        </tr>
        <tr bgcolor="white">
            <td style="width: 100%; height: 20px">
                Select Tread Depth Measurement Method</td>
        </tr>
        <tr bgcolor="white">
            <td style="width: 100%; height: 20px">
                <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                    <asp:ListItem Value="0">Measure Tyres in a Vehicle</asp:ListItem>
                    <asp:ListItem Value="1">Measure Tyre Individually</asp:ListItem>
                </asp:RadioButtonList></td>
        </tr>
        <tr bgcolor="white">
            <td style="width: 100%; height: 20px; text-align: center">
                <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" /></td>
        </tr>
    </table>

</asp:Content>

