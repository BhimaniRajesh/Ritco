<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Date_Diff_DayRpt.aspx.cs" Inherits="GUI_UNI_MIS_Doc_Date_Diff_Date_Diff_DayRpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_operation.aspx">Operation</asp:HyperLink>
    &gt; <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a><asp:HyperLink
            ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/Doc_Date_Diff/Query.aspx">Docket Date Difference Report</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Days Difference Report"></asp:Label><br />
    <br />
    <%--<table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                    Location</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblLocation" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 15px">
                <label class="blackfnt">
                    User</label></td>
            <td style="width: 343px; height: 15px">
                <asp:Label ID="lblUser" runat="server" CssClass="blackfnt"></asp:Label></td>
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
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -<asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>--%>
    <br />
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080; width: 395px;">
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                    Booking Date</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblFromDt" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblToDt" runat="server" CssClass="blackfnt"></asp:Label></td>
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
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -<asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    
    <br />
    <br />
    <table align="center" border="0" cellpadding="2" cellspacing="1" class="boxbg" id="Day_Rpt" runat="server">
    <tr><td>
        <tr class="bgbluegrey">
            <td align="center">
                <label class="blackfnt">
                    Sr. No</label></td>
            <td align="center">
                <label class="blackfnt">
                    Location</label></td>
            <td align="center">
                <label class="blackfnt">
                    Total dkts booked </label></td>
            <td align="center">
                <label class="blackfnt">
                    Delayed entry</label></td>
            <td align="center">
                <label class="blackfnt">
                    Percentage</label></td>                   
        </tr>
        <asp:Repeater ID="rptBillDetails" runat="server">
            <ItemTemplate>
                <tr style="background-color: White">
                    <td >
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
                    <td><center>
                        <label class="blackfnt">
                            <asp:HyperLink ID="Hyperlink2" runat="server" Font-Underline="True" ForeColor="#000099"
                                NavigateUrl='<%#"Date_Diff_SubRpt.aspx?DateType=" + Request.QueryString["DateType"].ToString() + "&Status=" + "1" + "&LocCode=" + DataBinder.Eval(Container.DataItem, "Location") + "&FromDt=" + Request.QueryString["FromDt"].ToString() + "&ToDt=" + Request.QueryString["ToDt"].ToString() + "&dateFrom=" + Request.QueryString["dateFrom"].ToString() + "&dateTo=" + Request.QueryString["dateTo"].ToString()%>' Text='<%#DataBinder.Eval(Container.DataItem, "TotBook")%>'>
                                </asp:HyperLink>                               
                        </label></center>
                        </td>                         
                    <td><center>
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Delay")%>
                        </label>
                        </center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%#DataBinder.Eval(Container.DataItem, "Percent")%>
                        </label></center>
                    </td>
                  </tr>
            </ItemTemplate>
        </asp:Repeater>
        </td></tr>
    </table>
    <table id="tblNoRecords" runat="server" align="center" border="0" cellpadding="2"
        cellspacing="1" class="boxbg" visible="false">
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
