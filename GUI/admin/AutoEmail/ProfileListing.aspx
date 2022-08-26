<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ProfileListing.aspx.cs" Inherits="GUI_admin_AutoEmail_ProfileListing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 8.0in">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Auto Email Profile Listing</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <asp:Table ID="Table1" runat="server">
                <asp:TableRow>
                    <asp:TableCell>
                        <asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
                    <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ProgressTemplate>
    </asp:UpdateProgress>
     &nbsp;&nbsp;&nbsp;
  <a href="AutoEmail_Step1.aspx"> <font class="bluefnt"><u>Add -----> </u></font></a>
  <br /><br />
    <table cellspacing="1" style="width: 8.0in">
        <tr>
            <td align="left" width="15%">
                <table border="0" style="width: 8.0in">
                    <tr>
                        <td style="text-align: left" class="blackfnt">
                            <asp:GridView ID="dgDocket" runat="server" AutoGenerateColumns="False" HeaderStyle-CssClass="dgHeaderStyle"
                                OnRowCommand="dg_RowCommand" DataKeyNames="profile_id" CssClass="dgRowStyle"
                                CellPadding="3" CellSpacing="1" Style="width: 4.0in" 
                                EmptyDataText="No Records Found..." BorderColor="#8BA0E5" >
                                <Columns>
                                   
                                    <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackboldfnt" HorizontalAlign="Center" />
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="PFNM" HeaderText="Profile Name">
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                        <HeaderStyle HorizontalAlign="Center"/>
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" Text="X"
                                                OnClientClick="return confirm('Are you certain that you want to delete this record?');">
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" Wrap="False" />
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="dgHeaderStyle" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
