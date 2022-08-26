<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Happay_Fuel_Wallet.aspx.cs" Inherits="GUI_admin_Happay_Fuel_Wallet_Happay_Fuel_Wallet" %>

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
                                <asp:ListItem Text="Happay" Value="Happay"></asp:ListItem>
                                <asp:ListItem Text="Fuel Wallet" Value="Fuel Wallet"></asp:ListItem>
								<asp:ListItem Text="Toll Wallet" Value="Toll"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="bgwhite" id="trstp1btn" runat="server">
                        <td align="right" colspan="3">
                            <asp:Button ID="btnStep1" runat="server" Text="Step 1" CssClass="fbtn" OnClick="btnStep1_Click"></asp:Button></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="step2" runat="server" visible="false">
            <td>
                <br />
                <table width="700px" id="tblstep2" class="stbl">
                    <tr class="bgwhite">
                        <td align="center"><b>Select</b></td>
                        <td align="center"><b>Bank Name</b></td>
                        <td align="center"><b>Account No.</b></td>
                    </tr>
                    <asp:Repeater ID="BindBankDetails" runat="server">
                        <ItemTemplate>
                            <tr class="bgwhite">
                                <td align="center">
                                    <asp:CheckBox ID="chkWallet" runat="server" /></td>
                                <td align="left">
                                    <asp:Label ID="lblBankName" runat="server" Text='<%# Eval("AccDesc") %>'></asp:Label></td>
                                <td align="right">
                                    <asp:Label ID="lblAccountNo" runat="server" Text='<%# Eval("bkAcctNo") %>'></asp:Label>
                                    <asp:HiddenField ID="hdnAccCode" runat="server" Value='<%# Eval("AccCode") %>' />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr class="bgbluegrey">
                        <td colspan="3" align="center">
                            <asp:Button ID="btnSubmit" runat="server" Width="120"
                                CssClass="fbtn" Text="Submit" OnClick="btnSubmit_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>

