<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Transit_Sub_Rpt.aspx.cs" Inherits="GUI_UNI_MIS_InTransit_report_Transit_Sub_Rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    &nbsp;<a href="javascript:window.history.go(-1)" title="back"><img id="IMG1" align="right"
        alt="" border="0" src="../../../GUI/images/back.gif" /></a><asp:HyperLink ID="HyperLink1"
            runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_operation.aspx">Operations</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink2" runat="server" CssClass="blackfnt" Font-Underline="True"
        NavigateUrl="~/GUI/UNI_MIS/InTransit_report/Query.aspx">In Transit Report</asp:HyperLink><br />
    <br />
    <br />
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
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
    <table align="center" border="0" cellpadding="2" cellspacing="1" class="boxbg" style="background-color: #808080" id="Sub_Rpt" runat="server">
    <tr><td>
        <tr class="bgbluegrey">
            <td style="width: 5%; height: 25px" align="center">
                <label class="blackfnt">
                    Sr. No</label></td>
            <td align="center">
                <label class="blackfnt">
                    Docket number</label></td>
            <td align="center">
                <label class="blackfnt">
                    Dely. Location</label></td>
            <td align="center">
                <label class="blackfnt">
                    Consignor</label></td>
            <td align="center">
                <label class="blackfnt">
                    Consignee</label></td>
            <td align="center">
                <label class="blackfnt">
                    Docket. Date</label></td>
            <td align="center">
                <label class="blackfnt">
                    Docket Entry. Date</label></td>
            <td align="center">
                <label class="blackfnt">
                    Comm. Dely. Date</label></td>    
                    <td align="center">
                <label class="blackfnt">
                    Last Location</label></td> 
                    <td align="center">
                <label class="blackfnt">
                    Dep. Date</label></td> 
                    <td align="center">
                <label class="blackfnt">
                    Current Location</label></td> 
                    <td align="center">
                <label class="blackfnt">
                    Actual Location</label></td> 
                    <td align="center">
                <label class="blackfnt">
                    Pkgs. No.</label></td> 
                    <td align="center">
                <label class="blackfnt">
                    Charge Wt.</label></td> 
                    <td align="center">
                <label class="blackfnt">
                    Arrival Date</label></td> 
                    <td align="center">
                <label class="blackfnt">
                    Thc. Date</label></td> 
                    <td align="center">
                <label class="blackfnt">
                    Days</label></td>                         
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
                            <%# DataBinder.Eval(Container.DataItem, "Doc_no")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Dly_Loc")%>
                        </label></center>
                    </td>                    
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Consignor")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Consignee")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Doc_Date")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Doc_Entry_Dt")%>
                        </label></center>
                    </td>      
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Comm_Dly_Dt")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Last_Loc")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Dep_Dt")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Curr_Loc")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Actual_Loc")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Pkg_No")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Chrg_Wg")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Arrival_Dt")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Thc_Date")%>
                        </label></center>
                    </td>
                    <td><center>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Days")%>
                        </label></center>
                    </td>         
                  </tr>
            </ItemTemplate>
        </asp:Repeater>
        </td></tr>
    </table>
    <table id="tblNoRecords" runat="server" align="center" border="0" cellpadding="2"
        cellspacing="1" class="boxbg" style="width: 60%; background-color: #808080" visible="false">
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
