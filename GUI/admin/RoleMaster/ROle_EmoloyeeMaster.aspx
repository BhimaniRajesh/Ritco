<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ROle_EmoloyeeMaster.aspx.cs" Inherits="GUI_admin_RoleMaster_ROle_EmoloyeeMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 8.0in">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Role Master - Employee Master Integration </asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <asp:UpdatePanel ID="ut1" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 6.0in">
                <tr>
                    <td align="left" width="15%">
                        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 7.0in">
                            <tr class="bgbluegrey">
                                <td colspan="2" style="text-align: center" class="blackfnt">
                                    <asp:Label Text="Set Role" runat="server" ID="lbl1" CssClass="blackfnt"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td style="text-align: left" class="blackfnt">
                                    Select Role
                                </td>
                                <td style="text-align: left" class="blackfnt">
                                    <asp:DropDownList ID="DllRole" runat="server" CssClass="blackfnt">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr style="background-color: White">
                                <td style="text-align: right" colspan="2" class="blackfnt">
                                    &nbsp;&nbsp;&nbsp;<asp:Button ID="BtnStep1" runat="server" Text="Step -1 " 
                                        CssClass="blackfnt" OnClick="BtnStep1_Click" />
                                </td>
                            </tr>
                            <tr id="tr1" runat="server" style="background-color: White; display: none;">
                                <td colspan="2" style="text-align: left" class="blackfnt">
                                  <asp:LinkButton ID="CheckAll" runat="server" CssClass="bluefnt" Text="Select All" ValidationGroup="ChkUnCheck"
                            OnClick="CheckAll_Click" />
                                    <asp:GridView OnRowDataBound="dg_RowDataBound" ID="RIghts" AutoGenerateColumns="false"
                                        runat="Server" HorizontalAlign="left" CssClass="boxbg" CellPadding="3" CellSpacing="1">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkRights" EnableViewState="true" Text="" />
                                                    <asp:HiddenField ID="chkval" runat="server" Value='<%#DataBinder.Eval(Container.DataItem,"CHK") %>' />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="bgbluegrey" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="User" HeaderStyle-HorizontalAlign="center" ItemStyle-BackColor="white">
                                                <ItemTemplate>
                                                    <asp:Label ID="User" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"name") %>'></asp:Label>
                                                    <asp:HiddenField ID="userid" runat="server" Value='<%#DataBinder.Eval(Container.DataItem,"userid") %>' />
                                                </ItemTemplate>
                                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Left" />
                                                <HeaderStyle CssClass="bgbluegrey" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Email ID" HeaderStyle-HorizontalAlign="center" ItemStyle-BackColor="white">
                                                <ItemTemplate>
                                                  <asp:TextBox ID="userEmailid" Width="200" runat="server" CssClass="blackfnt" Text='<%#DataBinder.Eval(Container.DataItem,"emailid") %>'></asp:TextBox>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Left" />
                                                <HeaderStyle CssClass="bgbluegrey" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                             <tr id="tr2" runat="server" style="background-color: White;display: none;">
                                <td style="text-align:center" colspan="2" class="blackfnt">
                                    &nbsp;&nbsp;&nbsp;<asp:Button ID="Button1" runat="server" Text="Submit" 
                                        CssClass="blackfnt" OnClick="Button1_Click" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
