<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="frmNewTripSummary.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmNewTripSummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 150px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../../images/loading.gif" alt="" />
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
    <asp:UpdatePanel runat="server" UpdateMode="Always" ID="updatePanel9">
        <ContentTemplate>
            <asp:Table ID="Table1" runat="server" CellSpacing="1" Width="800px">
                <asp:TableRow Style="background-color: white">
                    <asp:TableCell HorizontalAlign="left" Width="45%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server" Text="TRIP SHEET >> TRIP SUMMARY" />
                    </asp:TableCell></asp:TableRow>
            </asp:Table>
            <br />
            <asp:Table ID="Table2" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                class="boxbg" Width="750px" BorderWidth="0">
                <asp:TableRow Style="background-color: white">
                    <asp:TableCell>
                        <table cellspacing="1" align="center">
                            <tr align="center">
                                <td align="left">
                                    <asp:Table ID="Table3" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                                        class="boxbg" Width="600px" BorderWidth="0">
                                        <asp:TableRow ID="tblTripSummaryHdr" runat="server" class="bgbluegrey">
                                            <asp:TableCell HorizontalAlign="Center" Width="150px"> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Center" Width="150px"> <font class=blackfnt> Enroute </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Center" Width="150px"> <font class=blackfnt> Fuel </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="Center" Width="150px"> <font class=blackfnt> Total </font> </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Standard </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtStandardEnroute" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtStandardFuel" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtStandardTotal" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Actual </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtActualEnroute" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtActualFuel" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtActualToal" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Deviation </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDeviationEnroute" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDeviationFuel" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDeviationTotal" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Deviation% </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDeviationPercEnroute" Width="150px" Style="text-align: right"
                                                    runat="server" BorderStyle="None" onfocus="this.blur()"></asp:TextBox>%
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDeviationPercFuel" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>%
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDeviationPercTotal" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>%
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Total KM </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="TextBox1" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="TextBox2" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtTotalKM" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Cost Per KM </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="TextBox3" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="TextBox4" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtCostPerKM" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell></asp:TableRow>
                <asp:TableRow class="bgbluegrey">
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" ValidationGroup="main"
                            OnClick="SubmitData" />
                    </asp:TableCell></asp:TableRow>
            </asp:Table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
