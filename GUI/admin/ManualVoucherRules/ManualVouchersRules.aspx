<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ManualVouchersRules.aspx.cs" Inherits="GUI_admin_ManualVoucherRules_ManualVouchersRules" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<br />
<div style="width: 9.0in; text-align: right">
    <a href="javascript:window.history.go(-1)" title="back"><img alt="back" src="../../images/back.gif" border="0" /></a>
</div>
<div style="width: 10.0in; text-align: left">
    <asp:UpdatePanel ID="UpdatePanel3" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                        <tr>
                            <td align="right"><img src="../../images/loading.gif" alt="" /></td>
                            <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <br />
            <table cellspacing="1" class="boxbg" width="70%">
                <tr class="bgbluegrey">
                    <td align="center">
                        <strong>Manual Vouchers Rules</strong>
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="70%">
                <tr style="background-color: White"> 
                    <td class="blackfnt" colspan="2" nowrap style="text-align: left">&nbsp;<asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Set Manual Voucher Rules" CssClass="bluefnt"></asp:Label></td>
                </tr>
                <tr style="background-color: White"> 
                    <td class="blackfnt" nowrap style="text-align: left; width: 600px;">&nbsp;<asp:Label ID="lblrule1" runat="server" Text="Set Decimal Values Y/N" CssClass="blackfnt"></asp:Label></td>
                    <td class="blackfnt" nowrap style="text-align: center"><asp:CheckBox ID="chkdecimal" runat="server" /></td>
                </tr>
                <tr style="background-color: White"> 
                    <td class="blackfnt" nowrap style="text-align: left; width: 600px;">&nbsp;<asp:Label ID="lblrule2" runat="server" Text="Set Editable ServiceTax Rate Y/N" CssClass="blackfnt"></asp:Label></td>
                    <td class="blackfnt" nowrap style="text-align: center"><asp:CheckBox ID="chksvrtaxrate" runat="server" /></td>
                </tr>
            </table>
            <br />
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="70%">
                <tr class="bgbluegrey"> 
                    <td class="blackfnt" colspan="2" nowrap style="text-align: center">
                        <asp:Button ID="button1" runat="server" Text="Submit" OnClick="btnsubmit"/>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>    
</div>
</asp:Content>
