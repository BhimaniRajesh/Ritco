<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Transit_Rpt.aspx.cs" Inherits="GUI_UNI_MIS_InTransit_report_Transit_Rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    &nbsp;<a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a><asp:HyperLink
            ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_operation.aspx">Operations</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Docket Date Difference Report"></asp:Label><br />
    <br />
    <br />
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 10px">
                <label class="blackfnt">
                    RO</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblRo1" runat="server" CssClass="blackfnt"></asp:Label>
               <label class="blackfnt"> - To -</label>
                <asp:Label ID="lblRo2" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px; height: 15px">
                <label class="blackfnt">
                    Location</label></td>
            <td style="width: 343px; height: 15px">
                <asp:Label ID="lblLoc1" runat="server" CssClass="blackfnt"></asp:Label>
                <label class="blackfnt">- To -</label>
                <asp:Label ID="lblLoc2" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 211px">
                <label class="blackfnt">
                    Days</label></td>
            <td style="width: 343px">
                <asp:Label ID="lblDay1" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDay2" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    <br />
    <br />
    <table align="center" border="0" cellpadding="2" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr class="bgbluegrey">
            <td style="width: 5%; height: 25px" align="center">
                <label class="blackfnt">
                    Sr. No</label></td>
            <td align="center">
                <label class="blackfnt">
                    Last Location</label></td>
            <td align="center">
                <label class="blackfnt">
                    Next Location</label></td>
            <td align="center">
                <label class="blackfnt">
                    Total dkts</label></td>
            <td align="center">
                <label class="blackfnt">
                    Actual Weight</label></td>
            <td align="center">
                <label class="blackfnt">
                    Charge Weight</label></td>
            <td align="center">
                <label class="blackfnt">
                    Freight sub-total</label></td>
            <td align="center">
                <label class="blackfnt">
                    Docket total</label></td>                            
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
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Last_Loc1")%>
                        </label>
                        </center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Next_Loc1")%>
                        </label>
                        </center>
                    </td>
                    <td><center>
                        <asp:HyperLink ID="Hyperlink1" runat="server" Font-Underline="True" ForeColor="#003333"
                                NavigateUrl='<%#"Transit_Sub_Rpt.aspx?Last_Loc=" + DataBinder.Eval(Container.DataItem, "Last_Loc") + "&Next_Loc=" + DataBinder.Eval(Container.DataItem, "Next_Loc") + "&Day1=" + Request.QueryString["No_Day"].ToString() + "&Day2=" + Request.QueryString["Number_Day"].ToString() %>' Text='<%#DataBinder.Eval(Container.DataItem, "TotDoc")%>' Visible='<%#DataBinder.Eval(Container.DataItem, "LinkVisible")%>'>
                                </asp:HyperLink>
                        <label class="blackfnt" id="lblTotalDockets" runat="server" Visible='<%#DataBinder.Eval(Container.DataItem, "LabelVisible")%>'>
                            <%#DataBinder.Eval(Container.DataItem, "TotDoc")%>
                        </label>
                        </center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Actual_Wg")%>
                        </label>
                        </center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Charge_Wg")%>
                        </label>
                        </center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Freigh_Wg")%>
                        </label>
                        </center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Doc_Tot")%>
                        </label>
                        </center>
                    </td>                    
                  </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
    <table id="tblNoRecords" runat="server" align="center" border="0" cellpadding="2"
        cellspacing="1" class="boxbg" style="background-color: #808080" visible="false">
        <tr style="background-color: #ffffff">
            <td align="right" colspan="22" style="width: 892px; height: 54px">
                <div align="center">
                    <label class="blackfnt" style="color: #ff0000">
                        No Record Found</label></div>
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
