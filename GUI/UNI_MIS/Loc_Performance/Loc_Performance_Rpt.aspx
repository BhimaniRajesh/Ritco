<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Loc_Performance_Rpt.aspx.cs" Inherits="GUI_UNI_MIS_Loc_Performance_Loc_Performance_Rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a>
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_operation.aspx">Operations</asp:HyperLink>
    &gt;&nbsp;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/Loc_Performance/Query.aspx">Location Throughput Performance Report</asp:HyperLink><br />
    <br />
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr style="background-color: #ffffff" class="bgbluegrey">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                    Booking Date</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff" class="bgbluegrey">
            <td style="width: 211px" class="blackfnt">
                RO</td>
            <td style="width: 343px">
                <asp:Label ID="lblRO" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff" class="bgbluegrey">
            <td style="width: 211px" class="blackfnt">
                Booking Location</td>
            <td style="width: 343px">
                <asp:Label ID="lblBookLoc" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff" class="bgbluegrey">
            <td style="width: 211px" class="blackfnt">
                Report Type</td>
            <td style="width: 343px">
                <asp:Label ID="lblReportType" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    <br />
    <br />
    <table border="1" style="width: 98%; background-color: #808080" align="center" cellspacing="0"
        cellpadding="1" class="boxbg" id="Loc_Perfomance" runat="server">
        <tr>
            <td>
                <tr class="bgbluegrey">
                    <td style="width: 5%; height: 25px;">
                        <label class="blackfnt">
                            Sr. No</label></td>
                    <td>
                        <label class="blackfnt">
                            Location</label></td>
                    <td>
                        <label class="blackfnt">
                             <%=Session["DocketCalledAs"] %> Arrived/ Booked</label></td>
                    <td>
                        <label class="blackfnt">
                            In stock</label></td>
                    <td>
                        <label class="blackfnt">
                            Total Departed</label></td>
                    <td>
                        <label class="blackfnt">
                            Departed 0-1 hr</label></td>
                    <td>
                        <label class="blackfnt">
                            Percentage</label></td>
                    <td>
                        <label class="blackfnt">
                            Departed 1-12 hr</label></td>
                    <td>
                        <label class="blackfnt">
                            Percentage</label></td>
                    <td>
                        <label class="blackfnt">
                            Departed 12-24 hr</label></td>
                    <td>
                        <label class="blackfnt">
                            Percentage</label></td>
                    <td>
                        <label class="blackfnt">
                            Departed 24-48 hr</label></td>
                    <td>
                        <label class="blackfnt">
                            Percentage</label></td>
                    <td>
                        <label class="blackfnt">
                            Departed > 48 hr</label></td>
                    <td>
                        <label class="blackfnt">
                            Percentage</label></td>
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
                                    <label class="blackfnt" id="Label13" runat="server">
                                        <%#DataBinder.Eval(Container.DataItem, "Location1")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Loc_Performance_SubRpt.aspx?Location=" + DataBinder.Eval(Container.DataItem, "Location") + "&Report_Type=" + Request.QueryString["Report_Type"].ToString() + "&Status=" + "1" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "Docket")%>' ID="Hyperlink1" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible")%>'>
                                    </asp:HyperLink>
                                    <label class="blackfnt" id="label" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "Docket")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Loc_Performance_SubRpt.aspx?Location=" + DataBinder.Eval(Container.DataItem, "Location") + "&Report_Type=" + Request.QueryString["Report_Type"].ToString() + "&Status=" + "2" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "Stock")%>' ID="Hyperlink2" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible1")%>'>
                                    </asp:HyperLink>
                                    <label class="blackfnt" id="Label1" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible1")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "Stock")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Loc_Performance_SubRpt.aspx?Location=" + DataBinder.Eval(Container.DataItem, "Location") + "&Report_Type=" + Request.QueryString["Report_Type"].ToString() + "&Status=" + "3" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "Tot_Dep")%>' ID="Hyperlink3" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible2")%>'>
                                    </asp:HyperLink>
                                    <label class="blackfnt" id="Label2" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible2")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "Tot_Dep")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Loc_Performance_SubRpt.aspx?Location=" + DataBinder.Eval(Container.DataItem, "Location") + "&Report_Type=" + Request.QueryString["Report_Type"].ToString() + "&Status=" + "4" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "Depart1")%>' ID="Hyperlink4" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible3")%>'>
                                    </asp:HyperLink>
                                    <label class="blackfnt" id="Label3" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible3")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "Depart1")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt" id="Label4" runat="server">
                                        <%#DataBinder.Eval(Container.DataItem, "Percentage1")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Loc_Performance_SubRpt.aspx?Location=" + DataBinder.Eval(Container.DataItem, "Location") + "&Report_Type=" + Request.QueryString["Report_Type"].ToString() + "&Status=" + "5" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "Depart2")%>' ID="Hyperlink6" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible4")%>'>
                                    </asp:HyperLink>
                                    <label class="blackfnt" id="Label5" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible4")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "Depart2")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt" id="Label6" runat="server">
                                        <%#DataBinder.Eval(Container.DataItem, "Percentage2")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Loc_Performance_SubRpt.aspx?Location=" + DataBinder.Eval(Container.DataItem, "Location") + "&Report_Type=" + Request.QueryString["Report_Type"].ToString() + "&Status=" + "6" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "Depart3")%>' ID="Hyperlink8" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible5")%>'>
                                    </asp:HyperLink>
                                    <label class="blackfnt" id="Label7" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible5")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "Depart3")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt" id="Label8" runat="server">
                                        <%#DataBinder.Eval(Container.DataItem, "Percentage3")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Loc_Performance_SubRpt.aspx?Location=" + DataBinder.Eval(Container.DataItem, "Location") + "&Report_Type=" + Request.QueryString["Report_Type"].ToString() + "&Status=" + "7" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "Depart4")%>' ID="Hyperlink10" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible6")%>'>
                                    </asp:HyperLink>
                                    <label class="blackfnt" id="Label9" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible6")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "Depart4")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt" id="Label10" runat="server">
                                        <%#DataBinder.Eval(Container.DataItem, "Percentage4")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"Loc_Performance_SubRpt.aspx?Location=" + DataBinder.Eval(Container.DataItem, "Location") + "&Report_Type=" + Request.QueryString["Report_Type"].ToString() + "&Status=" + "8" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "Depart5")%>' ID="Hyperlink12" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible7")%>'>
                                    </asp:HyperLink>
                                    <label class="blackfnt" id="Label11" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible7")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "Depart5")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt" id="Label12" runat="server">
                                        <%#DataBinder.Eval(Container.DataItem, "Percentage5")%>
                                    </label>
                                </center>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <tr style="background-color: #FFFFFF" runat="server" id="trForTotalValues">
                    <td colspan="2" align="right">
                        <label class="blackfnt">
                            <b>Total : </b>
                        </label>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblLocBook" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblStock" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblTotDep" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblDepart1" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblPercentage1" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblDepart2" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblPercentage2" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblDepart3" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblPercentage3" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblDepart4" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblPercentage4" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblDepart5" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblPercentage5" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                </tr>
            </td>
        </tr>
    </table>
    <table id="tblNoRecords" runat="server" border="0" style="width: 98%; background-color: #808080"
        align="center" cellspacing="1" cellpadding="2" class="boxbg" visible="false">
        <tr style="background-color: #ffffff">
            <td colspan="22" align="right" style="width: 892px; height: 23px;">
                <div align="center">
                    <label style="color: #FF0000;" class="blackfnt">
                        No Record Found
                    </label>
                </div>
            </td>
        </tr>
    </table>
    <br />
    <table border="0" align="center" cellpadding="0" cellspacing="4" id="tblPageNavigation"
        runat="server">
        <tr align="center">
            <td align="center">
                <label class="blackfnt">
                    Page&nbsp;
                    <asp:Label ID="CurrentPage" CssClass="blackfnt" runat="server" />
                    &nbsp;of&nbsp;
                    <asp:Label ID="TotalPages" CssClass="blackfnt" runat="server" />
                </label>
            </td>
        </tr>
        <tr align="center">
            <td align="center">
                <label class="blackfnt">
                    <asp:LinkButton runat="server" CssClass="blackfnt" ID="FirstPage" Text="[First Page]"
                        OnCommand="NavigationLink_Click" CommandName="First" />
                    <asp:LinkButton runat="server" CssClass="blackfnt" ID="PreviousPage" Text="[Previous Page]"
                        OnCommand="NavigationLink_Click" CommandName="Prev" />
                    <asp:LinkButton runat="server" CssClass="blackfnt" ID="NextPage" Text="[Next Page]"
                        OnCommand="NavigationLink_Click" CommandName="Next" />
                    <asp:LinkButton runat="server" CssClass="blackfnt" ID="LastPage" Text="[Last Page]"
                        OnCommand="NavigationLink_Click" CommandName="Last" />
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
    <table width="25%" border="0" cellspacing="1" cellpadding="3" align="center" id="tblButtons"
        runat="server">
        <tr style="background-color: #ffffff">
            <td align="center">
                <asp:Button ID="btnXLS" runat="server" OnClick="btnXLS_Click" Text="XLS" /></td>
        </tr>
    </table>
</asp:Content>
