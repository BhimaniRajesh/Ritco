<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PendingFuelView.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_PendingFuelView" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upDCRReDeAllot" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>

            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDCRCriteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="6" style="text-align: left" align="center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="View Fuel Slip Issue"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />

            <%--*************************** Gridarea ****************************--%>
            <table border="0" cellspacing="1" cellpadding="3" width="900px">
                <tr>
                    <td align="center">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>

            <table border="0" cellspacing="1" cellpadding="3" width="900px" runat="server" id="tblDCR">
                <tr style="background-color: white">
                    <td align="center" width="100%">
                        <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False"
                                    CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey" 
                                    CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                    PagerSettings-Mode="NumericFirstLast">

                                    <Columns>
                                        <asp:TemplateField HeaderText="Sr No.">
                                            <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                        </asp:TemplateField> 

                                        <asp:BoundField DataField="Bill_No" HeaderText="Bill No" ReadOnly="true" />
                                        <asp:BoundField DataField="BillDate" HeaderText="Bill Date" ReadOnly="true" />
                                        <asp:BoundField DataField="VendorName" HeaderText="Vendor Name" ReadOnly="true" />
                                        <asp:BoundField DataField="TotalLtr" HeaderText="Total Litres" ReadOnly="true" />
                                        <asp:BoundField DataField="TotalSlips" HeaderText="Total Slips" ReadOnly="true" />
                                        <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" ReadOnly="true" />

                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>


