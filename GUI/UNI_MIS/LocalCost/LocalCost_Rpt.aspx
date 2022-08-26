<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="LocalCost_Rpt.aspx.cs" Inherits="GUI_UNI_MIS_LocalCost_LocalCost_Rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 55px">
                &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" Font-Underline="True"
                    NavigateUrl="~/GUI/UNI_MIS/rpt_operation.aspx">Operations</asp:HyperLink>
                &gt;
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Local Cost Report</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="IMG1" align="right" alt="" border="0" src="../../../GUI/images/back.gif" /></a><br>
    <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
        <tr style="background-color: #ffffff">
            <td style="height: 10px">
                <label class="blackfnt">
                    Date</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label>
                &nbsp;
            </td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 205px; height: 15px">
                <label class="blackfnt">
                    Vendor Type</label></td>
            <td style="width: 343px; height: 15px">
                <asp:Label ID="lblVendorType" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 205px">
                <label class="blackfnt">
                    Vendor</label></td>
            <td style="width: 343px">
                <asp:Label ID="lblVendor" runat="server" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table align="center" border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width: 98%;
        background-color: #808080">
        <tr class="bgbluegrey">
            <td rowspan="2" style="width: 5%">
                <label class="blackfnt">
                    Sr. No</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Vendor</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Vendor Type</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Location</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Total Documents</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Day Attended</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Cost Per Day</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Total Cost</label></td>
            <td colspan="3" style="height: 23px" align="center">
                <label class="blackfnt">
                    Delivery</label></td>
            <td colspan="3" style="height: 23px" align="center">
                <label class="blackfnt">
                    Pickup</label></td>
            <td rowspan="2" align="center">
                <label class="blackfnt">
                    Cost per kg.</label></td>
        </tr>
        
        <tr class="bgbluegrey">
            <td class="blackfnt" align="center">
                Number of DRS</td>
            <td class="blackfnt" align="center">
                Total Kg</td>
            <td class="blackfnt" align="center">
                Total CNs Delivered</td>
            <td class="blackfnt" align="center">
                Number of PRS</td>
            <td class="blackfnt" align="center"> 
                Total Kg</td>
            <td class="blackfnt" align="center">
                Total CNs picked up</td>
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
                            <label id="Label13" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Vendor")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label1" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Ven_Type")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label2" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Location")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label3" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Tot_Doc")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label4" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Days")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label5" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Cost")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label6" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Tot_Cost")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label7" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Num_DRS")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label8" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Tot_Kg")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label9" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Tot_CNS")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label10" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Num_PRS")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label11" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Total_Kg")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label12" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Total_CNS")%>
                            </label>
                        </center>
                    </td>
                    <td>
                        <center>
                            <label id="Label14" runat="server" class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Cost_Kg")%>
                            </label>
                        </center>
                    </td>                    
                    
                </tr>
            </ItemTemplate>
        </asp:Repeater>
       
    </table>
    <table id="tblNoRecords" runat="server" align="center" border="0" cellpadding="2"
        cellspacing="1" class="boxbg" style="width: 98%; background-color: #808080" visible="false">
        <tr style="background-color: #ffffff">
            <td align="right" colspan="22" style="width: 892px; height: 23px">
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
    <br />
    <center>
        &nbsp;</center>
</asp:Content>
