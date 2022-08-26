<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AccountingRules.aspx.cs" Inherits="GUI_admin_AccountMasterRules_AccountingRules" Title="Untitled Page" %>
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
                        <strong>Account/Group Master Rules</strong>
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="70%">
                <tr style="background-color: White"> 
                    <td class="blackfnt" colspan="2" nowrap style="text-align: left">&nbsp;<asp:Label ID="Label1" runat="server" Font-Bold="true" Text="Set Account Master Rules" CssClass="bluefnt"></asp:Label></td>
                </tr>
                <tr style="background-color: White"> 
                    <td class="blackfnt" nowrap style="text-align: left; width: 600px;">&nbsp;<asp:Label ID="Label4" runat="server" Text="Set Account Category" CssClass="blackfnt"></asp:Label></td>
                    <td class="blackfnt" nowrap style="text-align: center">
                        <asp:HyperLink ID="lnkAddurl" CssClass="bluefnt" runat="server" Text="Add" Font-Bold="false" NavigateUrl="~/GUI/admin/Accounts_masters/Accounts/Add_Acccategory.aspx?Data=new" /> |
                        <asp:HyperLink ID="lnkEditurl" CssClass="bluefnt" runat="server" Text="Edit" Font-Bold="false" NavigateUrl="~/GUI/admin/Accounts_masters/Accounts/Edit_Acccategory.aspx" ></asp:HyperLink>
                    </td>
                </tr>
                <tr style="background-color: White"> 
                    <td class="blackfnt" nowrap style="text-align: left; width: 600px;">&nbsp;<asp:Label ID="lblrule1" runat="server" Text="Set Manual Account Code As System Generated Account Code" CssClass="blackfnt"></asp:Label></td>
                    <td class="blackfnt" nowrap style="text-align: center"><asp:CheckBox ID="chkManualAccode" runat="server" /></td>
                </tr>
                <tr style="background-color: White"> 
                    <td class="blackfnt" nowrap style="text-align: left; width: 600px;">&nbsp;<asp:Label ID="lblrule2" runat="server" Text="Set Branch Code For Account Head" CssClass="blackfnt"></asp:Label></td>
                    <td class="blackfnt" nowrap style="text-align: center"><asp:CheckBox ID="chkbrcd" runat="server" /></td>
                </tr>
            </table>
            <br />
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="70%">
                <tr style="background-color: White"> 
                    <td class="blackfnt" colspan="2" nowrap style="text-align: left">&nbsp;<asp:Label ID="Label2" runat="server" Font-Bold="true" Text="Set Group Master Rules" CssClass="bluefnt"></asp:Label></td>
                </tr>
                <tr style="background-color: White"> 
                    <td class="blackfnt" nowrap style="text-align: left; width: 600px;">&nbsp;<asp:Label ID="Label3" runat="server" Text="Set Manual Group Code As System Generated Group Code" CssClass="blackfnt"></asp:Label></td>
                    <td class="blackfnt" nowrap style="text-align: center;"><asp:CheckBox ID="chkGroupcode" runat="server" /></td>
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

