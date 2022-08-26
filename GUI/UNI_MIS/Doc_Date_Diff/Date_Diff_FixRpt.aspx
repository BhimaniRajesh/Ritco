<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Date_Diff_FixRpt.aspx.cs" Inherits="GUI_UNI_MIS_Doc_Date_Diff_Date_Diff_FixRpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a>
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_operation.aspx">Operations</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/Doc_Date_Diff/Query.aspx">Docket Date Difference Report</asp:HyperLink>&nbsp;
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Fixed Report"></asp:Label><br />
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
                    RO</label></td>
            <td style="width: 343px; height: 15px">
                <asp:Label ID="lblRo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px">
                <label class="blackfnt">
                    Booking Location</label></td>
            <td style="width: 343px">
                <asp:Label ID="lblBookLoc" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td class="blackfnt" style="width: 211px">
                Customer</td>
            <td style="width: 343px">
                <asp:Label ID="lblCust" runat="server" CssClass="blackfnt">All</asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td class="blackfnt" style="width: 211px">
                Days</td>
            <td style="width: 343px">
                <asp:Label ID="lblDays" runat="server" CssClass="blackfnt"> -</asp:Label></td>
        </tr>
    </table>
    <br />
    <br />
    <table align="center" border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width: 98%;
        background-color: #808080" id="Fix_Rpt" runat="server">
        <tr><td>
        <tr class="bgbluegrey">
            <td style="width: 5%; height: 25px">
                <label class="blackfnt">
                    Sr. No</label></td>
            <td>
                <label class="blackfnt">
                    Location</label></td>
            <td align="center">
                <label class="blackfnt">
                    Total Dockets</label></td>
            <td  align="center">
                <label class="blackfnt">
                    No Delay</label></td>
            <td align="center">
                <label class="blackfnt">
                    Percentage</label></td>
            <td align="center">
                <label class="blackfnt">
                    Delay = 1 Day</label></td>
            <td align="center">
                <label class="blackfnt">
                    Percentage</label></td>
            <td align="center">
                <label class="blackfnt">
                    Delay = 2 Days</label></td>
            <td align="center">
                <label class="blackfnt">
                    Percentage</label></td>
            <td align="center">
                <label class="blackfnt">
                    Delay = 3 Days</label></td>
            <td align="center">
                <label class="blackfnt">
                    Percentage</label></td>
            <td align="center">
                <label class="blackfnt">
                    Delay > 3 Day</label></td>
            <td align="center">
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
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Location1")%>
                        </label>
                    </td>
                    <td align="center">
                        <asp:HyperLink ID="Hyperlink1" runat="server" Font-Underline="True" ForeColor="#000099"
                                NavigateUrl='<%#"Date_Diff_SubRpt.aspx?DateType=" + Request.QueryString["DateType"].ToString() + "&Status=" + "1" + "&LocCode=" + DataBinder.Eval(Container.DataItem, "Location") + "&FromDt=" + "All" + "&ToDt=" + "All" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>' Text='<%#DataBinder.Eval(Container.DataItem, "TotDoc")%>' Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible")%>'>
                                </asp:HyperLink>
                        <label class="blackfnt" id="lblTotalDockets" runat="server" Visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible")%>'>
                            <%#DataBinder.Eval(Container.DataItem, "TotDoc")%>
                        </label>
                    </td>
                    <td align="center">
                           <asp:HyperLink ID="Hyperlink2" runat="server" Font-Underline="True" ForeColor="#000099"
                                NavigateUrl='<%#"Date_Diff_SubRpt.aspx?DateType=" + Request.QueryString["DateType"].ToString() + "&Status=" + "2" + "&LocCode=" + DataBinder.Eval(Container.DataItem, "Location") + "&FromDt=" + "All" + "&ToDt=" + "All" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>' Text='<%#DataBinder.Eval(Container.DataItem, "Delay")%>' Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible1")%>'>
                                </asp:HyperLink>
                                <label class="blackfnt" id="lblTotalDockets1" runat="server" Visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible1")%>'>
                                <%#DataBinder.Eval(Container.DataItem, "Delay")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Percent")%>
                        </label>
                    </td>
                    <td align="center">                        
                            <asp:HyperLink ID="Hyperlink3" runat="server" Font-Underline="True" ForeColor="#000099"
                                NavigateUrl='<%#"Date_Diff_SubRpt.aspx?DateType=" + Request.QueryString["DateType"].ToString() + "&Status=" + "3" + "&LocCode=" + DataBinder.Eval(Container.DataItem, "Location") + "&FromDt=" + "All" + "&ToDt=" + "All" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>' Text='<%#DataBinder.Eval(Container.DataItem, "First_Day")%>' Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible2")%>'>
                                </asp:HyperLink>
                       <label class="blackfnt" id="Label1" runat="server" Visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible2")%>'>
                                <%#DataBinder.Eval(Container.DataItem, "First_Day")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Percent1")%>
                        </label>
                    </td>
                    <td align="center">
                        
                            <asp:HyperLink ID="Hyperlink4" runat="server" Font-Underline="True" ForeColor="#000099"
                                NavigateUrl='<%#"Date_Diff_SubRpt.aspx?DateType=" + Request.QueryString["DateType"].ToString() + "&Status=" + "4" + "&LocCode=" + DataBinder.Eval(Container.DataItem, "Location") + "&FromDt=" + "All" + "&ToDt=" + "All" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>' Text='<%#DataBinder.Eval(Container.DataItem, "Second_Day")%>' Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible3")%>'>
                                </asp:HyperLink>
                        <label class="blackfnt" id="Label2" runat="server" Visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible3")%>'>
                                <%#DataBinder.Eval(Container.DataItem, "Second_Day")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Percent2")%>
                        </label>
                    </td>
                    <td align="center">
                        
                            <asp:HyperLink ID="Hyperlink5" runat="server" Font-Underline="True" ForeColor="#000099"
                                NavigateUrl='<%#"Date_Diff_SubRpt.aspx?DateType=" + Request.QueryString["DateType"].ToString() + "&Status=" + "5" + "&LocCode=" + DataBinder.Eval(Container.DataItem, "Location") + "&FromDt=" + "All" + "&ToDt=" + "All" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>' Text='<%#DataBinder.Eval(Container.DataItem, "Third_Day")%>' Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible4")%>'>
                                </asp:HyperLink>
                       <label class="blackfnt" id="Label3" runat="server" Visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible4")%>'>
                                <%#DataBinder.Eval(Container.DataItem, "Third_Day")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Percent3")%>
                        </label>
                    </td>
                    <td align="center">
                       
                            <asp:HyperLink ID="Hyperlink6" runat="server" Font-Underline="True" ForeColor="#000099"
                                NavigateUrl='<%#"Date_Diff_SubRpt.aspx?DateType=" + Request.QueryString["DateType"].ToString() + "&Status=" + "6" + "&LocCode=" + DataBinder.Eval(Container.DataItem, "Location") + "&FromDt=" + "All" + "&ToDt=" + "All" + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>' Text='<%#DataBinder.Eval(Container.DataItem, "More_Day")%>' Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible5")%>'>
                                </asp:HyperLink>
                        <label class="blackfnt" id="Label4" runat="server" Visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible5")%>'>
                                <%#DataBinder.Eval(Container.DataItem, "More_Day")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Percent4")%>
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
                                                            <select id="ddlPages" runat="server" class="blackfnt" onchange="PageSelectionChanged(this)" visible="false">
                                                            </select>
                                                            <input type="hidden" id="HIDCurrentPageNo" runat="server"/>
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
