<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FTL_SubRpt.aspx.cs" Inherits="GUI_UNI_MIS_FTL_Profit_FTL_SubRpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a>
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_finance.aspx">Finance</asp:HyperLink>
    &gt;&nbsp;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/FTL_Profit/Query.aspx">FTL Profitibility</asp:HyperLink><br />
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
            <td style="width: 211px; height: 15px">
                <label class="blackfnt">
                    Booking Location</label></td>
            <td style="width: 343px; height: 15px">
                <asp:Label ID="lblBookLoc" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td class="blackfnt" style="width: 211px">
                Customer Code</td>
            <td style="width: 343px">
                <asp:Label ID="lblCust" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    <br />
    <br />
    <table align="center" border="1" cellpadding="1" cellspacing="0" class="boxbg" style="width: 98%;
        background-color: #808080" id="FTL_Profit" runat="server">
        <tr>
            <td>
                <tr class="bgbluegrey">
                    <td style="width: 5%; height: 25px">
                        <label class="blackfnt">
                            Sr. No</label></td>
                    <td>
                        <label class="blackfnt">
                            Docket number</label></td>
                    <td>
                        <label class="blackfnt">
                            Bkg. Date</label></td>
                    <td>
                        <label class="blackfnt">
                            Booking Location</label></td>
                    <td>
                        <label class="blackfnt">
                            Destination</label></td>
                    <td>
                        <label class="blackfnt">
                            Consignor</label></td>
                    <td>
                        <label class="blackfnt">
                            Consignee</label></td>
                    <td>
                        <label class="blackfnt">
                            Paybasis</label></td>
                    <td>
                        <label class="blackfnt">
                            Docket Sub TOtal</label></td>
                    <td>
                        <label class="blackfnt">
                            S.Tax</label></td>
                    <td>
                        <label class="blackfnt">
                            Cess</label></td>
                    <td>
                        <label class="blackfnt">
                            Docket Total</label></td>
                    <td>
                        <label class="blackfnt">
                            THC No.</label></td>
                    <td>
                        <label class="blackfnt">
                            THC Date</label></td>
                    <td>
                        <label class="blackfnt">
                            THC Amount</label></td>
                    <td>
                        <label class="blackfnt">
                            Profit</label></td>
                    <td>
                        <label class="blackfnt">
                            % Profit</label></td>
                    <td>
                        <label class="blackfnt">
                            Bill No.</label></td>
                    <td>
                        <label class="blackfnt">
                            Bill Date</label></td>
                    <td>
                        <label class="blackfnt">
                            Bill Amount</label></td>
                    <td>
                        <label class="blackfnt">
                            MR No.</label></td>
                    <td>
                        <label class="blackfnt">
                            MR Date</label></td>
                    <td>
                        <label class="blackfnt">
                            MR Amount</label></td>
                    <td>
                        <label class="blackfnt">
                            Recovery Days</label></td>
                    <td>
                        <label class="blackfnt">
                            Realised Profit</label></td>
                    <td>
                        <label class="blackfnt">
                            %</label></td>
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
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Doc_No")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "BkgDate")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Book_Loc")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Desti")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Consignor")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Consignee")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Pay")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Doc_Sub")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "STax")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Cess")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Doc_Tot")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Thc_No")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Thc_Date")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Thc_Amt")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Profit")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Profit_Per")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Bill_No")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Bill_Date")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Bill_Amt")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "MR_No")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "MR_Date")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "MR_Amt")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Recovery")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Realised")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%# DataBinder.Eval(Container.DataItem, "Percent")%>
                                </label>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </td>
        </tr>
    </table>
    <table id="tblNoRecords" runat="server" align="center" border="0" cellpadding="2"
        cellspacing="1" class="boxbg" style="width: 98%; background-color: #808080" visible="false">
        <tr style="background-color: #ffffff">
            <td align="right" colspan="22" style="width: 892px; height: 54px">
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
                <input type="hidden" id="HIDCurrentPageNo" runat="server" />
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
