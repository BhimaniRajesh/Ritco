<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="FuelIssueSlipCancelationView.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_FuelIssueSlipCancelationView" %>

<%--<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>--%>
<%--<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="FuelRateUpdation_SubmitForValidation.aspx.cs" Inherits="GUI_Fleet_Webadmin_FuelRateMaster_FuelRateUpdation_SubmitForValidation" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upDCRReDeAllot" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>


            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDCRCriteria"
                runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td colspan="6" style="text-align: left" align="center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="View"
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
                                        <asp:BoundField DataField="VendorCode" HeaderText="Vendor Code" InsertVisible="false"
                                            ReadOnly="True" SortExpression="VendorCode" />
                                        <asp:BoundField DataField="VehicleNo" HeaderText="Vehicle No" InsertVisible="false"
                                            ReadOnly="True" SortExpression="VehicleNo" />
                                        <asp:BoundField DataField="TripsheetNo" HeaderText="Tripsheet No" ReadOnly="True" SortExpression="" />
                                        <asp:BoundField DataField="TripsheetOpenDate" HeaderText="Tripsheet Open Date" ReadOnly="true" />
                                        <asp:BoundField DataField="VendorCity" HeaderText="Vendor City" ReadOnly="true" />
                                        <asp:BoundField DataField="FuelType" HeaderText="Fuel Type" ReadOnly="true" />
                                        <asp:BoundField DataField="UserSlipDate" HeaderText="User Slip Date" ReadOnly="true" />
                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" ReadOnly="true" />
                                        <asp:BoundField DataField="Rate" HeaderText="Rate" ReadOnly="true" />
                                        <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="true" />
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table> 
        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>


