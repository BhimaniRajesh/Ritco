<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TripsheetFinClosureDone.aspx.cs" MasterPageFile="~/GUI/MasterPage.master" Inherits="Issue_New_TripSheet_Validation_TripSheetApproval_TripsheetFinClosureDone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Submission >> Send for Financial Closure </asp:Label>
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Trip Finacially Closure is Done Successfully..…" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: White">
            <td align="center">
                <asp:Label ID="lblmsg" runat="server" CssClass="blackfnt"></asp:Label>
                <asp:GridView ID="grdResult" runat="server" PageSize="1000" AutoGenerateColumns="False"
                    CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                    CssClass="dgRowStyle" Width="100%" AllowPaging="false"
                    EmptyDataText="No Records Found">
                    <Columns>
                        <asp:TemplateField HeaderText="Sr.No.">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" Font-Bold="true" />
                            <ItemTemplate>
                                <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="50px" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TruckNo">
                            <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                            <ItemTemplate>
                                <asp:Label ID="lblTruckNo" Text='<%# DataBinder.Eval(Container.DataItem,"TruckNo") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TripsheetNo">
                            <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                            <ItemTemplate>
                                <asp:Label ID="lblTripsheetNo" Text='<%# DataBinder.Eval(Container.DataItem,"TripsheetNo") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="OpenDate">
                            <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                            <ItemTemplate>
                                <asp:Label ID="lblOpenDate" Text='<%# DataBinder.Eval(Container.DataItem,"OpenDate") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Trip Submission Date">
                            <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                            <ItemTemplate>
                                <asp:Label ID="lblOpenDate" Text='<%# DataBinder.Eval(Container.DataItem,"TripSubmissionDate") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Approved Date">
                            <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                            <ItemTemplate>
                                <asp:Label ID="lblApprovedDate" Text='<%# DataBinder.Eval(Container.DataItem,"ApprovedDate") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Financial Closure Date">
                            <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                            <ItemTemplate>
                                <asp:Label ID="lblFinancialClosureDate" Text='<%# DataBinder.Eval(Container.DataItem,"FinancialClosureDate") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Diesel C/F">
                            <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                            <ItemTemplate>
                                <asp:Label ID="lblDieselCF" Text='<%# DataBinder.Eval(Container.DataItem,"DieselCF") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Add Blue C/F">
                            <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                            <ItemTemplate>
                                <asp:Label ID="lblAddBlueCF" Text='<%# DataBinder.Eval(Container.DataItem,"AddBlueCF") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cash Balance">
                            <HeaderStyle HorizontalAlign="Left" Wrap="False" Font-Bold="true" />
                            <ItemTemplate>
                                <asp:Label ID="lblCashBalance" Text='<%# DataBinder.Eval(Container.DataItem,"CashBalance") %>'
                                    runat="server"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Width="200px" HorizontalAlign="Center" VerticalAlign="Top" Font-Bold="False" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>

        </tr>
        <tr style="background-color: White">
            <td>
                <asp:LinkButton ID="lnkDriverSettlement" OnClick="lnkDriverSettlement_Click" runat="server">Go For Driver settlement</asp:LinkButton>
            </td>
        </tr>
    </table>

</asp:Content>
