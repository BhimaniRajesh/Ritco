<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Cost_Register_Rpt.aspx.cs" Inherits="GUI_Telecomm_Cost_Register_Rpt" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <a href="javascript:window.history.go(-1)" title="back"></a>
    <br />
    <a href="javascript:window.history.go(-1)" title="back">
        <img id="Img2" align="right" alt="" border="0" src="../../GUI/images/back.gif" /></a>
    <asp:HyperLink ID="HyperLink1" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/Home.aspx">Report</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink2" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/ReportMain.aspx">Report Type</asp:HyperLink>
    &gt;
    <asp:HyperLink ID="HyperLink3" runat="server" Font-Underline="True" NavigateUrl="~/GUI/Telecomm/rptDueDateManagement.aspx">Communiction Cost Register</asp:HyperLink>
    &gt;
    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Communiction Cost Register Result"></asp:Label><br />
    <CR:CrystalReportViewer ID="CRVCostRegister" runat="server" AutoDataBind="true" HasCrystalLogo="False" DisplayGroupTree="False" />
    <br />
    <br />
    <table id="TABLE2" align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg"
        style="background-color: #808080">
        <tr style="background-color: #ffffff">
            <td align="left" style="width: 211px; height: 10px">
                <label class="blackfnt">
                    Location</label></td>
            <td align="left" style="height: 10px">
                <asp:Label ID="lblLocation" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" style="width: 211px; height: 15px">
                <label class="blackfnt">
                    User</label></td>
            <td align="left" style="width: 343px; height: 15px">
                <asp:Label ID="lblUser" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" style="width: 211px">
                <label class="blackfnt">
                    Vendor</label></td>
            <td align="left" style="width: 343px">
                <asp:Label ID="lblVendor" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" class="blackfnt" style="width: 211px">
                Communication Device Type</td>
            <td align="left" style="width: 343px">
                <asp:Label ID="lblDevice" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" class="blackfnt" style="width: 211px">
                Number</td>
            <td align="left" style="width: 343px">
                <asp:Label ID="lblNumber" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" class="blackfnt" style="width: 211px">
                Date</td>
            <td align="left" style="width: 343px">
                <asp:Label ID="lblDtFrom" runat="server" CssClass="blackfnt"></asp:Label>
                -
                <asp:Label ID="lblDtTo" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
    </table>
    <br />
    <br /><center>
    <asp:UpdatePanel ID="u1" runat="server"  UpdateMode="Conditional">
        <ContentTemplate>
            <%-- DataSourceID="ObjectDataSource1" EnableViewState="False"--%>
            <asp:GridView ID="gvCostReg" runat="server" AllowSorting="True"
                AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..." 
                HeaderStyle-CssClass="dgHeaderStyle" 
                PagerSettings-Mode="Numeric" PagerStyle-HorizontalAlign="left"
                PageSize="50">
                <Columns>
                    <asp:BoundField DataField="Bill_Dev_No" HeaderText="Device No">
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
                    <asp:BoundField DataField="AssignTo" HeaderText="Assign To">
                        <ItemStyle HorizontalAlign="Left" />
                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Bill_Vendor" HeaderText="Vendor">
                        <ItemStyle HorizontalAlign="Left" />
                        <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Bill_Entry_No" HeaderText="Entry No">
                        <ItemStyle HorizontalAlign="Left" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Dt" HeaderText="Date">
                        <ItemStyle HorizontalAlign="center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Bill_Tot_Amt" HeaderText="Total Amt">
                        <ItemStyle HorizontalAlign="center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                    </asp:BoundField>                    
                    <asp:BoundField DataField="Bill_Svc_Tax" HeaderText="Service Tax" >
                    <ItemStyle HorizontalAlign="center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>
                    <asp:BoundField DataField="Bill_Tot_Cess" HeaderText="Cess" >
                    <ItemStyle HorizontalAlign="center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>
                    <asp:BoundField DataField="Bill_Total" HeaderText="Total" >
                    <ItemStyle HorizontalAlign="center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>
                    <asp:BoundField DataField="PaidDt" HeaderText="Paid Date" >
                    <ItemStyle HorizontalAlign="center" />
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
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
