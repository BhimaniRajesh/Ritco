<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="STax_Coll_Rpt.aspx.cs" Inherits="GUI_UNI_MIS_ServiceTax_Collected_STax_Coll_Rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    &nbsp;<a href="javascript:window.history.go(-1)" title="back"><img id="IMG1" align="right"
        alt="" border="0" src="../../../GUI/images/back.gif" /></a><br />
    &nbsp;
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_finance.aspx">Finance</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/ServiceTax_Collected/Query.aspx">Service Tax Collected</asp:HyperLink><br />
    <br />
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                    Booking Date</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td class="blackfnt" style="width: 211px">
                RO</td>
            <td style="width: 343px">
                <asp:Label ID="lblRO" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td class="blackfnt" style="width: 211px">
                Booking Location</td>
            <td style="width: 343px">
                <asp:Label ID="lblBookLoc" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td class="blackfnt" style="width: 211px">
                Report Type</td>
            <td style="width: 343px">
                <asp:Label ID="lblRptType" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    <br />
    <br />
    <table align="center" border="1" cellpadding="1" cellspacing="0" class="boxbg" style="width: 98%;
        background-color: #808080" id="Svc_Tax_Coll" runat="server">
        <tr>
            <td>
                <tr class="bgbluegrey">
                    <td style="width: 5%; height: 25px">
                        <label class="blackfnt">
                            Sr. No</label></td>
                    <td>
                        <label class="blackfnt">
                            Location</label></td>
                    <td>
                        <label class="blackfnt">
                            Dockets No</label></td>
                    <td>
                        <label class="blackfnt">
                            Docket Date</label></td>
                    <td>
                        <label class="blackfnt">
                            Paybas</label></td>
                    <td>
                        <label class="blackfnt">
                            Consignor Code / name</label></td>
                    <td>
                        <label class="blackfnt">
                            Consignee Code / name</label></td>
                    <td>
                        <label class="blackfnt">
                            Total Freight</label></td>
                    <td>
                        <label class="blackfnt">
                            Service Tax (Bkg)</label></td>
                    <td>
                        <label class="blackfnt">
                            Service Tax(Dly)</label></td>
                    <td>
                        <label class="blackfnt">
                            Total Service</label></td>
                    <td>
                        <label class="blackfnt">
                            MR NO</label></td>
                    <td>
                        <label class="blackfnt">
                            MR Date</label></td>
                </tr>
                <asp:Repeater ID="rptBillDetails" runat="server">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <td style="width: 198px">
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label id="Label13" runat="server" class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Location")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label id="Label1" runat="server" class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "DocNo")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label id="Label2" runat="server" class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "DocDt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label id="Label3" runat="server" class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Paybas")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label id="Label4" runat="server" class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Consignor")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label id="Label5" runat="server" class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Consignee")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label id="Label6" runat="server" class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Tot_Freight")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label id="Label7" runat="server" class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Ser_Tax")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label id="Label8" runat="server" class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Ser_Tax_Dly")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label id="Label9" runat="server" class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Tot_Ser")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label id="Label10" runat="server" class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "MRNo")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label id="Label11" runat="server" class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "MRDt")%>
                                    </label>
                                </center>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <tr id="trForTotalValues" runat="server" style="background-color: #ffffff">
                    <td align="right" colspan="7">
                        <label class="blackfnt">
                            <b>Total : </b>
                        </label>
                    </td>
                    <td>
                        <center>
                            <asp:Label ID="lblTot_Fright" runat="server" CssClass="blackfnt" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label ID="lblSer_Tax" runat="server" CssClass="blackfnt" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label ID="lblSer_Tax_Dly" runat="server" CssClass="blackfnt" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label ID="lblTot_Ser" runat="server" CssClass="blackfnt" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
            </td>
        </tr>
    </table>
    <table id="tblNoRecords" runat="server" align="center" border="0" cellpadding="2"
        cellspacing="1" class="boxbg" style="width: 98%; background-color: #808080" visible="false">
        <tr style="background-color: #ffffff">
            <td align="right" colspan="22" style="width: 892px; height: 23px">
                <div align="center">
                    <label class="blackfnt" style="color: #ff0000">
                        No Record Found
                    </label>
                </div>
            </td>
        </tr>
    </table>
    <br />
    <table id="tblPageNavigation" runat="server" align="center" border="0" cellpadding="0"
        cellspacing="4">
        <tr align="center">
            <td align="center">
                <label class="blackfnt">
                    Page&nbsp;
                    <asp:Label ID="CurrentPage" runat="server" CssClass="blackfnt"></asp:Label>
                    &nbsp;of&nbsp;
                    <asp:Label ID="TotalPages" runat="server" CssClass="blackfnt"></asp:Label>
                </label>
            </td>
        </tr>
        <tr align="center">
            <td align="center">
                <label class="blackfnt">
                    <asp:LinkButton ID="FirstPage" runat="server" CommandName="First" CssClass="blackfnt"
                        OnCommand="NavigationLink_Click" Text="[First Page]"></asp:LinkButton>
                    <asp:LinkButton ID="PreviousPage" runat="server" CommandName="Prev" CssClass="blackfnt"
                        OnCommand="NavigationLink_Click" Text="[Previous Page]"></asp:LinkButton>
                    <asp:LinkButton ID="NextPage" runat="server" CommandName="Next" CssClass="blackfnt"
                        OnCommand="NavigationLink_Click" Text="[Next Page]"></asp:LinkButton>
                    <asp:LinkButton ID="LastPage" runat="server" CommandName="Last" CssClass="blackfnt"
                        OnCommand="NavigationLink_Click" Text="[Last Page]"></asp:LinkButton>
                </label>
            </td>
        </tr>
        <tr align="center">
            <td align="center">
                <label class="blackfnt">
                </label>
                <select id="ddlPages" runat="server" class="blackfnt" onchange="PageSelectionChanged(this)"
                    visible="false">
                </select>
                <input id="HIDCurrentPageNo" runat="server" type="hidden" />
            </td>
        </tr>
    </table>
    <table id="tblButtons" runat="server" align="center" border="0" cellpadding="3" cellspacing="1"
        width="25%">
        <tr style="background-color: #ffffff">
            <td align="center">
                <asp:Button ID="btnXLS" runat="server" OnClick="btnXLS_Click" Text="XLS" /></td>
        </tr>
    </table>
</asp:Content>
