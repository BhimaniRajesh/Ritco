<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="result.aspx.cs" Inherits="GUI_UNI_MIS_OPN_Flow_result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


<br />
<br />

    <asp:Table id="TBL_OPNFlow" border="0" HorizontalAlign="center" runat="server" CellPadding="3" CellSpacing="1" style="width:8.5in;" CssClass="boxbg"></asp:Table>

 <br />
    <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
        <tr bgcolor="white">
            <td colspan="2" align="center">
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
