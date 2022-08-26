<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="CommAssets_Reg_Rpt.aspx.cs" Inherits="GUI_Telecomm_CommAssets_Reg_Rpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
<!--

function IMG1_onclick() {

}

// -->
</script>

    &nbsp;<a href="javascript:window.history.go(-1)" title="back"><img id="Img2" align="right"
        alt="" border="0" src="../../GUI/images/back.gif" /></a><br />
    &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Home.aspx">Report</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/ReportMain.aspx">Report Type</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink3" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/rptExpenseSummary.aspx">Communiction Assets Register</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Communiction Assets Register Result"></asp:Label><br />

    <br />
    
  
    <center>
        <table id="TABLE2" align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg"
            style="background-color: #808080">
            <tr style="background-color: #ffffff" >
                <td style="width: 211px; height: 10px" align="left">
                    <label class="blackfnt">
                        Location</label></td>
                <td style="height: 10px" align="left">
                    <asp:Label ID="lblLocation" runat="server" CssClass="blackfnt"></asp:Label></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td style="width: 211px; height: 15px" align="left">
                    <label class="blackfnt">
                        User</label></td>
                <td style="width: 343px; height: 15px" align="left">
                    <asp:Label ID="lblUser" runat="server" CssClass="blackfnt"></asp:Label></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td style="width: 211px" align="left">
                    <label class="blackfnt">
                        Vendor</label></td>
                <td style="width: 343px" align="left">
                    <asp:Label ID="lblVendor" runat="server" CssClass="blackfnt"></asp:Label></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td class="blackfnt" style="width: 211px" align="left">
                    Communication Device Type</td>
                <td style="width: 343px" align="left">
                    <asp:Label ID="lblDevice" runat="server" CssClass="blackfnt"></asp:Label></td>
            </tr>
        </table>
    
        </center>
    <center>
        &nbsp;</center>
    <center>
    
        <asp:Table ID="Table1" runat="server" CellPadding="1" CellSpacing="0" CssClass="boxbg" Width="60%"></asp:Table>
        &nbsp;</center>
    
    
    <asp:UpdatePanel ID="UpdatePanel8" runat="server"   UpdateMode="Conditional" RenderMode="Inline" Visible="false">
        <ContentTemplate>
            <asp:GridView ID="gvAssetsReg" runat="server" AutoGenerateColumns="False" EmptyDataText="No Record Found.......">
            </asp:GridView>
        </ContentTemplate>
        </asp:UpdatePanel> 
        <center>
    <asp:UpdatePanel ID="u1" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>
            <%-- DataSourceID="ObjectDataSource1" EnableViewState="False"--%>
            <asp:GridView ID="gvAssetsReg1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5" CellSpacing="1" CssClass="dgRowStyle"
                EmptyDataText="No Records Found..." HeaderStyle-CssClass="dgHeaderStyle" PagerSettings-Mode="Numeric"
                PagerStyle-HorizontalAlign="left" PageSize="50">
                <Columns>
                    <asp:BoundField DataField="CDM_Number" HeaderText="Device No">
                        <ItemStyle HorizontalAlign="Left" />
                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CDM_Type" HeaderText="Device Type">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CDM_Location" HeaderText="Location">
                        <ItemStyle HorizontalAlign="Left" />
                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Assign" HeaderText="Assign To">
                        <ItemStyle HorizontalAlign="Left" />
                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CDM_Vendor" HeaderText="Vendor">
                        <ItemStyle HorizontalAlign="Left" />
                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:BoundField>
                </Columns>
                <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                <PagerStyle HorizontalAlign="Left" />
                <HeaderStyle CssClass="dgHeaderStyle" />
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
        </center>
</asp:Content>
