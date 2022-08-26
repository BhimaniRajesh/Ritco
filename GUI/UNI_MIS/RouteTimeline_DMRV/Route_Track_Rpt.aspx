<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="Route_Track_Rpt.aspx.cs" Inherits="GUI_UNI_MIS_RouteTimeline_DMRV_Route_Track_Rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    &nbsp;<a href="javascript:window.history.go(-1)" title="back"><img id="IMG1" align="right"
        alt="" border="0" src="../../../GUI/images/back.gif" /></a><br />
    &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/rpt_operation.aspx">Operations</asp:HyperLink>
    &gt; &nbsp;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/UNI_MIS/RouteTimeline_DMRV/Query.aspx">Route Timeliness Track and DMRV and Route Movement</asp:HyperLink><br />
    <br />
    <table align="center" border="1" cellpadding="1" cellspacing="0" class="boxbg" style="width: 98%;
        background-color: #808080" id="Route_DMRV_Rpt" runat="server">
        <tr><td>
        <tr class="bgbluegrey">
            <td align="center" colspan="1" rowspan="3" style="width: 5%; height: 25px" class="blackfnt">
                Sr No.</td>
            <td align="center" colspan="1" rowspan="3" style="width: 5px" class="blackfnt">
                Route Code</td>
            <td align="center" colspan="1" rowspan="3" style="width: 5px" class="blackfnt">
                Route Name</td>
            <td align="center" colspan="1" rowspan="3" style="width: 3px" class="blackfnt">
                Transit Hours</td>
            <td align="center" colspan="1" rowspan="3" style="width: 5px" class="blackfnt">
                THC No.</td>
            <td align="center" colspan="1" rowspan="3" style="width: 3px" class="blackfnt">
                THC Date</td>
            <td colspan="10" align="center" class="blackfnt">
                Statring Location</td>
            <td align="center" colspan="10" class="blackfnt">
                1st Reporting</td>
            <td align="center" colspan="10" class="blackfnt">
                2nd Reporting</td>
            <td align="center" colspan="10" class="blackfnt">
                3rd Reporting</td>
            <td align="center" colspan="10" class="blackfnt">
                4th Reporting</td>
            <td align="center" colspan="10" class="blackfnt">
                5th Reporting</td>
            <td align="center" colspan="10" class="blackfnt">
                6th Reporting</td>
        </tr>
        <tr class="bgbluegrey">
            <td style="width: 3px" rowspan="2" align="center" class="blackfnt">
                Location</td>
            <td style="width: 3px" rowspan="2" align="center" class="blackfnt">
                Transit Time</td>
            <td style="height: 21px;" colspan="4" align="center" class="blackfnt">
                Arrivals [In]</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Departures[Out]</td>
            <td colspan="1" rowspan="2" style="width: 3px" class="blackfnt">
                Location</td>
            <td colspan="1" rowspan="2" class="blackfnt">
                Transit Time</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Arrivals [In]</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Departures[Out]</td>
            <td colspan="1" rowspan="2" class="blackfnt">
                Location</td>
            <td colspan="1" rowspan="2" class="blackfnt">
                Transit Time</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Arrivals [In]</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Departures[Out]</td>
            <td colspan="1" rowspan="2" class="blackfnt">
                Location</td>
            <td colspan="1" rowspan="2" class="blackfnt">
                Transit Time</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Arrivals [In]</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Departures[Out]</td>
            <td colspan="1" rowspan="2" class="blackfnt">
                Location</td>
            <td colspan="1" rowspan="2" class="blackfnt">
                Transit Time</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Arrivals[In]</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Departures[Out]</td>
            <td colspan="1" rowspan="2" class="blackfnt">
                Location</td>
            <td colspan="1" rowspan="2" class="blackfnt">
                Transit Time</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Arrivals [In]</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Departures[Out]</td>
            <td colspan="1" rowspan="2" class="blackfnt">
                Location</td>
            <td colspan="1" rowspan="2" class="blackfnt">
                Transit Time</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Arrivals[In]</td>
            <td colspan="4" style="height: 21px" align="center" class="blackfnt">
                Departures[Out]</td>
        </tr>
        <tr class="bgbluegrey">
            <td style="width: 3px" align="center" class="blackfnt">
                STA</td>
            <td style="width: 3px" align="center" class="blackfnt">
                ETA</td>
            <td style="width: 3px" align="center" class="blackfnt">
                ATA</td>
            <td style="width: 3px" align="center" class="blackfnt">
                Late/ Early [Hrs.]</td>
            <td style="width: 3px" align="center" class="blackfnt">
                STD</td>
            <td style="width: 3px" align="center" class="blackfnt">
                ETD</td>
            <td style="width: 3px" align="center" class="blackfnt">
                ATD</td>
            <td style="width: 3px" align="center" class="blackfnt">
                Late/ Early [Hrs.]</td>
            <td align="center" style="width: 3px" class="blackfnt">
                STA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ETA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ATA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                Late/ Early [Hrs.]</td>
            <td align="center" style="width: 4px" class="blackfnt">
                STD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ETD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ATD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                Late/ Early [Hrs.]</td>
            <td align="center" style="width: 3px" class="blackfnt">
                STA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ETA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ATA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                Late/ Early [Hrs]</td>
            <td align="center" style="width: 3px" class="blackfnt">
                STD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ETD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ATD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                Late/ Early [Hrs.]</td>
            <td align="center" style="width: 3px" class="blackfnt">
                STA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ETA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ATA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                Late/ Early [Hrs.]</td>
            <td align="center" style="width: 3px" class="blackfnt">
                STD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ETD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ATD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                Late/ Early [Hrs.]</td>
            <td align="center" style="width: 3px" class="blackfnt">
                STA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ETA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ATA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                Late/ Early [Hrs.]</td>
            <td align="center" style="width: 3px" class="blackfnt">
                STD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ETD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ATD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                Late/ Early [Hrs.]</td>
            <td align="center" style="width: 3px" class="blackfnt">
                STA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ETA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ATA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                Late/ Early [Hrs.]</td>
            <td align="center" style="width: 3px" class="blackfnt">
                STD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ETD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ATD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                Late/ Early [Hrs.]</td>
            <td align="center" style="width: 3px" class="blackfnt">
                STA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ETA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ATA</td>
            <td align="center" style="width: 3px" class="blackfnt">
                Late/ Early [Hrs.]</td>
            <td align="center" style="width: 3px" class="blackfnt">
                STD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ETD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                ATD</td>
            <td align="center" style="width: 3px" class="blackfnt">
                Late/ Early [Hrs.]</td>                             
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
                            <%# DataBinder.Eval(Container.DataItem, "Route_Code")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Route_Name")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Transit_Hrs")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "THC_No")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "THC_Dt")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Loc_Start")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Transit_Start")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Arr_Start")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Arr_Start")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Arr_Start")%>
                        </label>
                    </td>  
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Arr_Start")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Dep_Start")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Dep_Start")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Dep_Start")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Dep_Start")%>
                        </label>
                    </td>
                    
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Loc_1")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Transit_1")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Arr_1")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Arr_1")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Arr_1")%>
                        </label>
                    </td>  
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Arr_1")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Dep_1")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Dep_1")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Dep_1")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Dep_1")%>
                        </label>
                    </td>
                    
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Loc_2")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Transit_2")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Arr_2")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Arr_2")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Arr_2")%>
                        </label>
                    </td>  
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Arr_2")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Dep_2")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Dep_2")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Dep_2")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Dep_2")%>
                        </label>
                    </td>
                    
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Loc_3")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Transit_3")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Arr_3")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Arr_3")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Arr_3")%>
                        </label>
                    </td>  
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Arr_3")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Dep_3")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Dep_3")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Dep_3")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Dep_3")%>
                        </label>
                    </td>
                    
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Loc_4")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Transit_4")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Arr_4")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Arr_4")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Arr_4")%>
                        </label>
                    </td>  
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Arr_4")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Dep_4")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Dep_4")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Dep_4")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Dep_4")%>
                        </label>
                    </td>
                    
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Loc_5")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Transit_5")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Arr_5")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Arr_5")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Arr_5")%>
                        </label>
                    </td>  
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Arr_5")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Dep_5")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Dep_5")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Dep_5")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Dep_5")%>
                        </label>
                    </td>
                    
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Loc_6")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Transit_6")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Arr_6")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Arr_6")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Arr_6")%>
                        </label>
                    </td>  
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Arr_6")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "STA_Dep_6")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ETA_Dep_6")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "ATA_Dep_6")%>
                        </label>
                    </td>
                    <td>
                        <label class="blackfnt">
                            <%# DataBinder.Eval(Container.DataItem, "Late_Dep_6")%>
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
