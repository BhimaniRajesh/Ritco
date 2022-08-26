<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Step1.aspx.cs" Inherits="GUI_admin_setting_cust_opn_bal_OPBalCust_step2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left">
        <table border="0" cellspacing="0" cellpadding="2" style="width: 9.5in">
            <tr bgcolor="#FFFFFF">
                <td>
                    <br />
                    <br />
                    <table border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width: 100%"
                        align="Left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <font class="blackfnt"><b>Balance Transfer For Ledger/Sub-Ledger</b></font>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td colspan="2">
                                <asp:Label ID="lbl_title" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="center">
                                <font class="bluefnt"><b>Balance Transfer For Ledger</b></font>
                            </td>
                            <td align="center">
                                <font class="bluefnt"><b>Balance Transfer For Sub-Ledger</b></font>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="center">
                                <table>
                                    <tr>
                                        <td align="left">
                                            <asp:RadioButton ID="Rd_Ledger_1" runat="server" Text="ALL" Checked="true" GroupName="Ledger" />
                                            <br />
                                            <asp:RadioButton ID="Rd_Ledger_2" runat="server" Text="Asset" GroupName="Ledger" />
                                            <br />
                                            <asp:RadioButton ID="Rd_Ledger_3" runat="server" Text="Liability" GroupName="Ledger" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="center">
                                <table width="40%">
                                    <tr >
                                        <td align="left">
                                            <asp:RadioButton ID="Rd_Sub_Ledger_1" runat="server" Text="ALL" Checked="true" GroupName="SubLedger"   />
                                            <br />
                                            <asp:RadioButton ID="Rd_Sub_Ledger_2" runat="server" Text="Customer" GroupName="SubLedger" />
                                            <br />
                                            <asp:RadioButton ID="Rd_Sub_Ledger_3" runat="server" Text="Vendor" GroupName="SubLedger" />
                                            <br />
                                            <asp:RadioButton ID="Rd_Sub_Ledger_4" runat="server" Text="Employee" GroupName="SubLedger" />
                                            <br />
                                            <asp:RadioButton ID="Rd_Sub_Ledger_5" runat="server" Text="Driver" GroupName="SubLedger" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                         <tr bgcolor="white">
                            <td align="center">
                                <asp:Button ID="Btn_Ledger" runat="server"    Font-Bold="true" Text="Transfer Ledger Balance" CssClass="blackfnt"  BorderStyle="Groove"  OnClick="Btn_ledger_Click" />
                            </td>
                            <td align="center">
                                <asp:Button ID="Btn_SubLedger" runat="server"   Font-Bold="true"  Text="Transfer Sub-Ledger Balance" CssClass="blackfnt"  BorderStyle="Groove"  OnClick="Btn_Sub_ledger_Click"/>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td colspan="2">
                                <asp:Label ID="Label1" runat="server" CssClass="redfnt" Font-Bold="true"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="center">
                                <font class="bluefnt"><b>Balance Transfer For P & L Ledger </b></font>
                            </td>
                            <td align="center">
                                 
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td align="center">
                                <table>
                                    <tr>
                                        <td align="left">
                                            <asp:RadioButton ID="Rd_PNL" runat="server" Text="ALL(P & L Ledger)" Checked="true" GroupName="PNL" />
                                             
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td align="center">
                                <table width="40%">
                                    <tr >
                                        <td align="left">
                                            <%--<asp:RadioButton ID="RadioButton4" runat="server" Text="ALL" Checked="true" GroupName="SubLedger"   />
                                            <br />
                                            <asp:RadioButton ID="RadioButton5" runat="server" Text="Customer" GroupName="SubLedger" />
                                            <br />
                                            <asp:RadioButton ID="RadioButton6" runat="server" Text="Vendor" GroupName="SubLedger" />
                                            <br />
                                            <asp:RadioButton ID="RadioButton7" runat="server" Text="Employee" GroupName="SubLedger" />
                                            <br />
                                            <asp:RadioButton ID="RadioButton8" runat="server" Text="Driver" GroupName="SubLedger" />
                                       --%> </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                         <tr bgcolor="white">
                            <td align="center">
                                <asp:Button ID="Button1" runat="server"  Font-Bold="true" Text="Transfer P & L Ledger Balance" CssClass="blackfnt"  BorderStyle="Groove"  OnClick="Btn_PNL_Click" />
                            </td>
                            <td align="center">
                                <%--<asp:Button ID="Button2" runat="server" Text="Transfer Sub-Ledger Balance" CssClass="blackfnt"  BorderStyle="Groove"  OnClick="Btn_Sub_ledger_Click"/>--%>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
