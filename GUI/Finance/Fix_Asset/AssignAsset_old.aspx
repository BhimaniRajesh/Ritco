<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="AssignAsset_old.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Fix Assets</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <div style="width: 9.5in;">
        <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="1" CellPadding="2"
            HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
            BackColor="white" FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
            AllowSorting="false" AutoGenerateColumns="false" ShowFooter="false" PagerSettings-FirstPageText="[First]"
            PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
            <PagerStyle VerticalAlign="Bottom" />
            <Columns>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
