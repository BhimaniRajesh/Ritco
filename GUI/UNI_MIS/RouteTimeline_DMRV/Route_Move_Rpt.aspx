<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Route_Move_Rpt.aspx.cs" Inherits="GUI_UNI_MIS_RouteTimeline_DMRV_Route_Move_Rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_operation.aspx">Operations</asp:HyperLink>
    &gt;&nbsp;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/RouteTimeline_DMRV/Query.aspx">Route Timeliness Track and DMRV and Route Movement</asp:HyperLink>&nbsp;
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a><br />
    <br /><div class="blackfnt" align="center" ><strong>
    Route Movement Report for Last Week (<asp:Label ID="lblFrromDt" runat="server"
        CssClass="blackfnt"></asp:Label>
        &nbsp;- &nbsp;<asp:Label ID="lblToDt" runat="server" CssClass="blackfnt"></asp:Label>)</strong></div> <br />
    <br />
    <table align="center" border="1" cellpadding="1" cellspacing="0" class="boxbg" style="width: 98%;
        background-color: #808080" id="Route_DMRV_Rpt" runat="server">
        <tr><td>
        <tr class="bgbluegrey">
            <td style="width: 5%; height: 25px" align="center">
                <label class="blackfnt">
                    Sr. No</label></td>
            <td align="center">
                <label class="blackfnt">
                    Vehicle No</label></td>
            <td align="center">
                <label class="blackfnt">
                    Route Code</label></td>
            <td align="center">
                <label class="blackfnt">
                    Route</label></td>
            <td align="center">
                <label class="blackfnt">
                    THC Number</label></td>
            <td align="center">
                <label class="blackfnt">
                    THC Date</label></td>
            <td align="center">
                <label class="blackfnt">
                    Last Location</label></td>
            <td align="center">
                <label class="blackfnt">
                    Departed at</label></td>
            <td align="center">
                <label class="blackfnt">
                    Next Location</label></td>
            <td align="center">
                <label class="blackfnt">
                    PayLoad Of Vehicle</label></td>
            <td align="center">
                <label class="blackfnt">
                    Actual Load Carried</label></td>
            <td align="center">
                <label class="blackfnt">
                    Status</label></td>            
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
                    <td align="center"> 
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Vhi_No")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Route_Code")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Route")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "THC_No")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "THC_Dt")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Last_Loc")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Depart")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Next_Loc")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Pay_Load")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Actual_Load")%>
                        </label>
                    </td>  
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Status")%>
                        </label>
                    </td>                     
                </tr>
            </ItemTemplate>
        </asp:Repeater>
        </td></tr>
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
