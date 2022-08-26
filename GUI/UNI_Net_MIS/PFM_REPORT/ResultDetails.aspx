<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ResultDetails.aspx.cs" Inherits="GUI_UNI_MIS_Reassign_Report_ReassignReportDetails" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<br />
<div align="right" style="width: 10.0in;">
<a href="javascript:window.history.go(-1)" title="back"><img alt="bck" src="../../images/back.gif" border="0" /></a>
</div>
<table>
<tr>
<td>
<div align="left" >
        <table align="left" cellspacing="1" class="boxbg" style="width: 9in">
            <tr class="bgbluegrey">
                <td align="center" > 
                    <strong>PFM Report </strong>
                </td>
            </tr>
        </table>
    <br />
    </td>
    </tr>
    <tr>
<td>
    <table align="left" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="565">
        <tr style="background-color: #ffffff">
            <td colspan="2" style="height: 10px; text-align: center">
                <strong><span style="font-size: 8pt">You Selected</span></strong></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="height: 10px">
                <label class="blackfnt">
                    Booking
                    Location :</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 205px; height: 15px">
                <label class="blackfnt">
                    Booking
                    Date :</label></td>
            <td style="font-weight: bold; width: 343px; height: 15px">
                <asp:Label ID="lbldat" runat="server" CssClass="blackfnt" Font-Bold="False"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 205px">
                <label class="blackfnt">
                    Status :</label></td>
            <td style="width: 343px">
                <asp:Label ID="lblStatus" runat="server" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 205px">
                Type:</td>
            <td style="width: 343px">
                <asp:Label ID="lblTypeD" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <%-- <tr style="background-color: #ffffff">
                <td style="height: 6px">
                    <label class="blackfnt">
                        Document Type :
                    </label>
                </td>
                <td style="height: 6px">
                    <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                    </asp:Label></td>
            </tr>--%>
    </table>
    <br />
    </td>
    </tr>
    
    <tr>
    <td>
    <asp:GridView ID="dgDocket" runat="server" align="left" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" BorderWidth="0px" CellPadding="2" CellSpacing="1"
        CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
        HeaderStyle-CssClass="bgbluegrey" OnPageIndexChanging="pgChange" 
        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" PagerSettings-Mode="NumericFirstLast"
        PagerStyle-HorizontalAlign="left" PageSize="25" Visible="False">
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
        <Columns>
            <asp:TemplateField HeaderText="SR.NO.">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
                <ItemTemplate>
                    <asp:Label ID="lblsrno" runat="server" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>">
                        </asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="dockno" HeaderText="Docket No.">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="docksf" HeaderText="Docket SF">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="dock_dt" HeaderText="Docket Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="orgncd" HeaderText="Original">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="destcd" HeaderText="Destination">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="from_loc" HeaderText="From Location">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="to_loc" HeaderText="To Location">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="curr_loc" HeaderText="Current Location">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="nextloc" HeaderText="Next Location">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="delivered" HeaderText="Delivered">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="dely_dt" HeaderText="Delay Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="cnor" HeaderText="Consigner">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="cnee" HeaderText="Consignee">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="last_pfm_no" HeaderText="Last PFM No">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="pfm_dt" HeaderText="PFM Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="pfm_rec_dt" HeaderText="PFM Receive Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            
        </Columns>
        <PagerStyle CssClass="bgbluegrey" HorizontalAlign="Center" />
        <HeaderStyle CssClass="bgbluegrey" />
    </asp:GridView>
    <br />
    </td>
    </tr>
    
    
    
    <tr>
    <td>
    <div align="center" style="width: 10.0in;">
    <br />
   
    <asp:Button ID="btn_csv" runat="server" Text="DownLoad XLS"
        Width="170" OnClick="btn_csv_Click" /></div>
        </td>
    </tr>
    </table>
    
    
</asp:Content>

