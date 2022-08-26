<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Route_RMRV_Rpt.aspx.cs" Inherits="GUI_UNI_MIS_RouteTimeline_DMRV_Route_RMRV_Rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    &nbsp;<a href="javascript:window.history.go(-1)" title="back"><img id="IMG1" align="right"
        alt="" border="0" src="../../../GUI/images/back.gif" /></a><br />
    &nbsp; <a href="javascript:window.history.go(-1)" title="back"></a>
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_operation.aspx">Operations</asp:HyperLink>
    &gt; &nbsp;<asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/RouteTimeline_DMRV/Query.aspx">Route Timeliness Track and DMRV and Route Movement</asp:HyperLink><br />
    <br />
    <table align="center" border="1" cellpadding="1" cellspacing="0" class="boxbg" style="width: 98%;
        background-color: #808080" id="Route_DMRV_Rpt" runat="server">
        <tr><td>
        <tr class="bgbluegrey">
            <td style="width: 5%; height: 25px" rowspan="2" align="center">
                <label class="blackfnt">
                    Sr. No</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt" >
                    Route No</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Route Name</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Route Mode</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    THC No.</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    THC Date.</label></td>
            <td style="width: 66px" colspan="2" align="center">
                <label class="blackfnt">
                    Schedule Departure</label></td>
          <%--  <td style="width: 66px" colspan="" rowspan="2">
                <label class="blackfnt">
                    Schedule Departure Time</label></td>--%>
            <td colspan="2" align="center">
                <label class="blackfnt">
                    Actual Departure</label></td>
           <%-- <td rowspan="2">
                <label class="blackfnt">
                    Actual Departure Time</label></td>--%>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Delay Hours</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Vendor</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Vehicle No.</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Vehicle Type</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Payload Of Vehicle (Ton)</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Actual Load Carried (Ton)</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Capacity Utilisation</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Actual Route Cost</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Actual Cost/kg</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Standard Route Cost</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Standard Cost/kg</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Total Dockets Carried</label></td>   
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Docket Freight</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Docket Freight/Kg.</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    THC Profit (std. cost basis)</label></td> 
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Profit %</label></td> 
           <td rowspan="2" align="center">
                <label class="blackfnt">
                    THC Profit (actual cost basis)</label></td> 
           <td rowspan="2" align="center">
                <label class="blackfnt">
                    Profit %</label></td> 
           <td rowspan="2" align="center">
                <label class="blackfnt">
                    Travel Distance</label></td>                  
                             
        </tr>
        <tr class="bgbluegrey">
        <td align="center">
                <label class="blackfnt">
                    Date</label></td>
                    <td align="center">
                <label class="blackfnt">
                    Time</label></td>
                    <td align="center">
                <label class="blackfnt">
                    Date</label></td>
                    <td align="center">
                <label class="blackfnt">
                    Time</label></td>
                    
        </tr>
        <asp:Repeater ID="rptBillDetails" runat="server">
            <ItemTemplate>
                <tr style="background-color: White">
                    <td style="width: 198px" align="center">
                        <center>
                            <label class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                            </label>
                        </center>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Route_Code")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Route_Name")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Route_Mode")%>
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
                    </td >
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Sche_Dt")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Sche_Time")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Actual_Dt")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Actual_Time")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Delay_Hour")%>
                        </label>
                    </td>  
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Vendor")%>
                        </label>
                    </td>  
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Vehical_No")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Vehical_Type")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Payload")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Actual_Load")%>
                        </label>
                    </td>
                    <td align="center"> 
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Capacity")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Actual_Route")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Actual_Cost")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Srd_Route_Cost")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Srd_Cost")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Tot_Doc")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Doc_Frt")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Doc_Frt_Kg")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "THC_Profit")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Profit")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "THC_Profit_Per")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Profit_Per")%>
                        </label>
                    </td>
                    <td align="center">
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Travel")%>
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
            <td align="center" style="height: 39px">
                <asp:Button ID="btnXLS" runat="server" OnClick="btnXLS_Click" Text="XLS" /></td>
        </tr>
    </table>
</asp:Content>
