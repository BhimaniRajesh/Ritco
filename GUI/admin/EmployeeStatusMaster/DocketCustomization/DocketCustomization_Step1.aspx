<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DocketCustomization_Step1.aspx.cs" Inherits="GUI_admin_DocketCustomization_DocketCustomization_Step1"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript">


function submitClick()
{
    return true;
}
    </script>

    <asp:Panel runat="server" Width="10in">
        <br />
        <br />
        <asp:Table ID="Table1" runat="server" CellSpacing="1" CellPadding="2" Width="90%"
            CssClass="boxbg">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="3" Font-Bold="true">
                    Docket Entry Customization Form - 1
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow BackColor="White">
                <asp:TableCell>
                    <asp:Table runat="server" CellSpacing="1" CssClass="boxbg" Width="100%">
                        <asp:TableRow BackColor="White">
                            <asp:TableCell ColumnSpan="4" Font-Bold="true"><br />Contract Defination</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell Font-Bold="true">Payment Basis</asp:TableCell>
                            <asp:TableCell Font-Bold="true">Search Type</asp:TableCell>
                            <asp:TableCell Font-Bold="true">Depth</asp:TableCell>
                            <asp:TableCell Font-Bold="true">Behavior</asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow BackColor="White">
                            <asp:TableCell Width="100px" VerticalAlign="Middle" HorizontalAlign="Center">Paid</asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:RadioButtonList ID="optpaidcontract" CssClass="blackfnt" runat="server">
                                    <asp:ListItem Value="C">Customer Wise</asp:ListItem>
                                    <asp:ListItem Value="CD">First Customer Wise, if not found Default Contract</asp:ListItem>
                                    <asp:ListItem Value="D">Default Contract</asp:ListItem>
                                    <asp:ListItem Value="W">Without Contract</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:RadioButtonList ID="optpaiddepthtype" CssClass="blackfnt" runat="server">
                                    <asp:ListItem Value="C">City to City</asp:ListItem>
                                    <asp:ListItem Value="L">Location to Location</asp:ListItem>
                                    <asp:ListItem Value="I">Intra State</asp:ListItem>
                                    <asp:ListItem Value="R">Region to Region</asp:ListItem>
                                    <asp:ListItem Value="M">Minimum Freight</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:RadioButtonList ID="optpaidproceed" CssClass="blackfnt" runat="server">
                                    <asp:ListItem Value="S">Services Not Found</asp:ListItem>
                                    <asp:ListItem Value="NT">Terminate While Combination not found</asp:ListItem>
                                    <asp:ListItem Value="T">Terminate While Zero Freight</asp:ListItem>
                                    <asp:ListItem Value="P">Allow Manual Entry</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow BackColor="White">
                            <asp:TableCell VerticalAlign="Middle" HorizontalAlign="Center">TBB</asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:RadioButtonList ID="opttbbcontract" CssClass="blackfnt" runat="server">
                                    <asp:ListItem Value="C">Customer Wise</asp:ListItem>
                                    <asp:ListItem Value="CD">First Customer Wise, if not found Default Contract</asp:ListItem>
                                    <asp:ListItem Value="D">Default Contract</asp:ListItem>
                                    <asp:ListItem Value="W">Without Contract</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:RadioButtonList ID="opttbbdepthtype" CssClass="blackfnt" runat="server">
                                    <asp:ListItem Value="C">City to City</asp:ListItem>
                                    <asp:ListItem Value="L">Location to Location</asp:ListItem>
                                    <asp:ListItem Value="I">Intra State</asp:ListItem>
                                    <asp:ListItem Value="R">Region to Region</asp:ListItem>
                                    <asp:ListItem Value="M">Minimum Freight</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:RadioButtonList ID="opttbbproceed" CssClass="blackfnt" runat="server">
                                     <asp:ListItem Value="S">Services Not Found</asp:ListItem>
                                    <asp:ListItem Value="NT">Terminate While Combination not found</asp:ListItem>
                                    <asp:ListItem Value="T">Terminate While Zero Freight</asp:ListItem>
                                    <asp:ListItem Value="P">Allow Manual Entry</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow BackColor="White">
                            <asp:TableCell VerticalAlign="Middle" HorizontalAlign="Center">To Pay</asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:RadioButtonList ID="opttopaycontract" CssClass="blackfnt" runat="server">
                                    <asp:ListItem Value="C">Customer Wise</asp:ListItem>
                                    <asp:ListItem Value="CD">First Customer Wise, if not found Default Contract</asp:ListItem>
                                    <asp:ListItem Value="D">Default Contract</asp:ListItem>
                                    <asp:ListItem Value="W">Without Contract</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:RadioButtonList ID="opttopaydepthtype" CssClass="blackfnt" runat="server">
                                    <asp:ListItem Value="C">City to City</asp:ListItem>
                                    <asp:ListItem Value="L">Location to Location</asp:ListItem>
                                    <asp:ListItem Value="I">Intra State</asp:ListItem>
                                    <asp:ListItem Value="R">Region to Region</asp:ListItem>
                                    <asp:ListItem Value="M">Minimum Freight</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                            <asp:TableCell VerticalAlign="Top">
                                <asp:RadioButtonList ID="opttopayproceed" CssClass="blackfnt" runat="server">
                                    <asp:ListItem Value="S">Services Not Found</asp:ListItem>
                                    <asp:ListItem Value="NT">Terminate While Combination not found</asp:ListItem>
                                    <asp:ListItem Value="T">Terminate While Zero Freight</asp:ListItem>
                                    <asp:ListItem Value="P">Allow Manual Entry</asp:ListItem>
                                </asp:RadioButtonList>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell ColumnSpan="3" HorizontalAlign="Right">
                    <asp:Button ID="btnsubmit" runat="server" OnClientClick="javascript:return submitClick()"
                        OnClick="btnsubmit_Click" Font-Bold="true" Text="Next Step>>" CssClass="blackfnt" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>
