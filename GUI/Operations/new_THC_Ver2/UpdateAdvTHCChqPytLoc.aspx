<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="UpdateAdvTHCChqPytLoc.aspx.cs" Inherits="GUI_Operations_new_THC_Ver2_UpdateAdvTHCChqPytLoc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upDCRReDeAllot" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table border="0" cellspacing="1" cellpadding="3" width="500px" class="boxbg" id="tblDCRCriteria" runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="4" style="text-align: left" align="center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Update Advance THC Cheque Payment Location"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="right" id="tdVendorlbl" width="25%">
                        <font class="blackfnt">Enter THC No:</font>&nbsp;&nbsp;
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtTHCNo" CssClass="input" BorderStyle="Groove" Width="200px" runat="server" TabIndex="1"></asp:TextBox>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="right" colspan="2">
                        <asp:Button Text="Submit" ID="btn_GetThcDetails" OnClick="btn_GetThcDetails_Click" runat="server" />
                    </td>
                </tr>
            </table>
            <br />

            <table border="0" cellspacing="1" cellpadding="3" width="500px" class="boxbg" runat="server" visible="false" id="tblThcUpdate">
                <tr bgcolor="white">
                    <td align="left" width="20%">
                        <font class="blackfnt">THC no: </font>&nbsp;&nbsp;
                    </td>
                    <td align="left">
                        <asp:Label runat="server" ID="lblThcNo" />
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left" width="20%">
                        <font class="blackfnt">Balance amount: </font>&nbsp;&nbsp;
                    </td>
                    <td align="left">
                        <asp:Label runat="server" ID="lblBalAmt" />
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left" width="20%">
                        <font class="blackfnt">Current location: </font>&nbsp;&nbsp;
                    </td>
                    <td align="left">
                        <asp:Label runat="server" ID="lblCurrLoc" />
                    </td>
                </tr>


                <tr bgcolor="white">
                    <td align="left" width="40%">
                        <font class="blackfnt">Select new Advance THC Cheque Payment Location: </font>&nbsp;&nbsp;
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="ddlro" AutoPostBack="True" runat="server" Width="261px" CssClass="input">
                        </asp:DropDownList>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="right" colspan="3">
                        <asp:Button runat="server" Text="UpdateLocation" ID="btn_UpdateLocation" OnClick="btn_UpdateLocation_Click" />
                    </td>
                </tr>
            </table>

            <asp:Label ID="lblError" Font-Bold="true" Style="color: red" runat="server" Visible="false" />

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>
