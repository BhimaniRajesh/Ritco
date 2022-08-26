<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="MR_Report.aspx.cs" Inherits="GUI_UNI_MIS_MR_Summary_MR_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a>
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_finance.aspx">Fianance</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/MR_Summary/Query.aspx">MR Summary</asp:HyperLink><br />
    <br />
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                    Date</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 15px">
                <label class="blackfnt">
                    Ro</label></td>
            <td style="width: 343px; height: 15px">
                <asp:Label ID="lblRo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px">
                <label class="blackfnt">
                    Location</label></td>
            <td style="width: 343px">
                <asp:Label ID="lblLoc" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    <br />
    <br />
    <table border="1" style="width: 98%; background-color: #808080" align="center" cellspacing="0"
        cellpadding="1" class="boxbg" id="MR_Summary" runat="server">
        <tr>
            <td>
                <tr class="bgbluegrey">
                    <td style="width: 5%;" rowspan="2">
                        <label class="blackfnt">
                            Sr. No</label></td>
                    <td style="width: 7%;" rowspan="2">
                        <label class="blackfnt">
                            LocCode</label></td>
                    <td style="width: 15%;" rowspan="2">
                        <label class="blackfnt">
                            Location</label></td>
                    <td style="height: 25px;" align="center" colspan="2">
                        <label class="blackfnt">
                            Paid MR</label><label class="blackfnt"></label></td>
                    <td style="height: 25px;" align="center" colspan="2">
                        <label class="blackfnt">
                            TBB MR</label><label class="blackfnt"></label></td>
                    <td style="height: 25px;" align="center" colspan="2">
                        <label class="blackfnt">
                            To Pay MR</label><label class="blackfnt"></label></td>
                    <td style="height: 25px;" align="center" colspan="2">
                        <label class="blackfnt">
                            Canceller MR</label><label class="blackfnt"></label></td>
                    <td style="height: 25px;" align="center" colspan="2">
                        <label class="blackfnt">
                            Total Docket</label><label class="blackfnt"></label></td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="center" style="width: 7%; height: 25px" class="blackfnt">
                        MR</td>
                    <td align="center" style="width: 7%; height: 25px" class="blackfnt">
                        Amount</td>
                    <td align="center" style="width: 7%; height: 25px" class="blackfnt">
                        MR</td>
                    <td align="center" style="width: 7%; height: 25px" class="blackfnt">
                        &nbsp;Amount</td>
                    <td align="center" style="width: 7%; height: 25px" class="blackfnt">
                        MR</td>
                    <td align="center" style="width: 7%; height: 25px" class="blackfnt">
                        Amount</td>
                    <td align="center" style="width: 7%; height: 25px" class="blackfnt">
                        MR
                    </td>
                    <td align="center" style="width: 7%; height: 25px" class="blackfnt">
                        Amount</td>
                    <td align="center" style="width: 7%; height: 25px" class="blackfnt">
                        Docket
                    </td>
                    <td align="center" style="width: 7%; height: 25px" class="blackfnt">
                        Amount</td>
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
                                    <%#DataBinder.Eval(Container.DataItem, "loccode")%>
                                </label>
                            </td>
                            <td>
                                <label class="blackfnt">
                                    <%#DataBinder.Eval(Container.DataItem, "locName")%>
                                </label>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"MR_Sub_Rpt.aspx?Blank=" + "" + "&MRBranch=" + DataBinder.Eval(Container.DataItem, "loccode") + "&Branch=" + DataBinder.Eval(Container.DataItem, "locName") + "&rep=" + "1" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "Paid_MR")%>' ID="Hyperlink1" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible")%>'>
                                    </asp:HyperLink>
                                    <label class="blackfnt" id="lblTotalDockets" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "Paid_MR")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "Paid_amt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"MR_Sub_Rpt.aspx?Blank=" + "" + "&MRBranch=" + DataBinder.Eval(Container.DataItem, "loccode") + "&Branch=" + DataBinder.Eval(Container.DataItem, "locName") + "&rep=" + "2" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "DEL_MR")%>' ID="Hyperlink2" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible1")%>' />
                                    <label class="blackfnt" id="Label1" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible1")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "DEL_MR")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "DEL_amt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"MR_Sub_Rpt.aspx?Blank=" + "" + "&MRBranch=" + DataBinder.Eval(Container.DataItem, "loccode") + "&Branch=" + DataBinder.Eval(Container.DataItem, "locName") + "&rep=" + "3" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "DUE_MR")%>' ID="Hyperlink3" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible2")%>' />
                                    <label class="blackfnt" id="Label2" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible2")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "DUE_MR")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "DUE_amt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"MR_Sub_Rpt.aspx?Blank=" + "" + "&MRBranch=" + DataBinder.Eval(Container.DataItem, "loccode") + "&Branch=" + DataBinder.Eval(Container.DataItem, "locName") + "&rep=" + "7" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "CAN_MR")%>' ID="Hyperlink4" Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible3")%>' />
                                    <label class="blackfnt" id="Label3" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible3")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "CAN_MR")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "CAN_amt")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <asp:HyperLink runat="server" Font-Underline="True" ForeColor="#003333" NavigateUrl='<%#"MR_Sub_Rpt.aspx?Blank=" + "" + "&MRBranch=" + DataBinder.Eval(Container.DataItem, "loccode") + "&Branch=" + DataBinder.Eval(Container.DataItem, "locName") + "&rep=" + "ALL" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>'
                                        Text='<%#DataBinder.Eval(Container.DataItem, "TotalDocKet")%>' ID="Hyperlink5"
                                        Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible4")%>' />
                                    <label class="blackfnt" id="Label4" runat="server" visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible4")%>'>
                                        <%#DataBinder.Eval(Container.DataItem, "TotalDocKet")%>
                                    </label>
                                </center>
                            </td>
                            <td>
                                <center>
                                    <label class="blackfnt">
                                        <%#DataBinder.Eval(Container.DataItem, "TotalAmt")%>
                                    </label>
                                </center>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <tr style="background-color: #FFFFFF" runat="server" id="trForTotalValues">
                    <td colspan="3" align="right">
                        <label class="blackfnt">
                            <b>Total : </b>
                        </label>
                    </td>
                    <td align="center">
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblPMR" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td>
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblPMRAmt" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td align="center">
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblTBBMR" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td align="center">
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblTBBAmt" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td align="center">
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblToPayMR" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td align="center">
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblToPayMRAmt" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td align="center">
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblCMR" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td align="center">
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblCMRAmt" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td align="center">
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblTotalDoc" runat="server" Font-Bold="true">
                            </asp:Label></center>
                    </td>
                    <td align="center">
                        <center>
                            <asp:Label CssClass="blackfnt" ID="lblTotalAmt" runat="server" Font-Bold="true">
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
            <td align="center" style="height: 18px">
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
            <td align="center" style="height: 31px">
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
                <asp:Button ID="btnXLS" runat="server" OnClick="btnXLS_Click" Text="XLS" />
            </td>
        </tr>
    </table>
</asp:Content>
