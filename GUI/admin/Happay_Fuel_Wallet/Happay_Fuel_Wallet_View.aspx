<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Happay_Fuel_Wallet_View.aspx.cs" Inherits="GUI_admin_Happay_Fuel_Wallet_Happay_Fuel_Wallet_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <br />
    <br />
    <table>
        <tr>
            <td>
                <table width="500px" class="stbl" id="tbl1" runat="server">
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center"><b>Mapping Wallet with Bank</b></td>
                    </tr>
                    <tr class="bgwhite">
                        <td align="center">Select Wallet</td>
                        <td align="left" colspan="2">
                            <asp:DropDownList ID="ddWallet" runat="server">
                                <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                <asp:ListItem Text="Happay" Value="Happay"></asp:ListItem>
                                <asp:ListItem Text="Fuel Wallet" Value="Fuel Wallet"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="bgwhite" id="trstp1btn" runat="server">
                        <td align="center" colspan="3">
                            <asp:Button ID="btnView" runat="server" Width="120"
                                CssClass="fbtn" Text="View" OnClick="btnView_Click" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trxsl" runat="server">
            <td align="right">
                <br />
                <asp:LinkButton id="XlSDownload" runat="server" visible="false" OnClick="XlSDownload_Click" >Download XLS</asp:LinkButton>
            </td>
        </tr>
        <tr id="view" runat="server" visible="false">
            <td>
                <table width="700px" id="tblstep2" class="stbl">
                    <tr class="bgwhite">
                        <td align="center"><b>Sr. No.</b></td>
                        <td align="center"><b>Bank Name</b></td>
                        <td align="center"><b>Account No.</b></td>
                        <td align="center"><b>Wallet</b></td>
                    </tr>
                    <asp:Repeater ID="BindFuelBankTypeDetails" runat="server">
                        <ItemTemplate>
                            <tr class="bgwhite">
                                <td align="center">
                                    <asp:Label ID="lblSrNo" runat="server" Text='<%# Eval("SRNO") %>'></asp:Label></td>
                                <td align="left">
                                    <asp:Label ID="lblBankName" runat="server" Text='<%# Eval("BankName") %>'></asp:Label></td>
                                <td align="right">
                                    <asp:Label ID="lblAccountNo" runat="server" Text='<%# Eval("AccountNo") %>'></asp:Label></td>
                                <td align="left">
                                    <asp:Label ID="lblWallet" runat="server" Text='<%# Eval("WalletType") %>'></asp:Label></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

