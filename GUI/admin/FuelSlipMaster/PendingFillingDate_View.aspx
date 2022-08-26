<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PendingFillingDate_View.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_PendingFillingDate_View" %>


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
                                        <asp:BoundField DataField="VehicleNo" HeaderText="Vehicle No" InsertVisible="false"
                                            ReadOnly="True" SortExpression="" />

                                        <asp:BoundField DataField="TripsheetNo" HeaderText="Tripsheet No." InsertVisible="false"
                                            ReadOnly="True" SortExpression="" />
                                        <asp:BoundField DataField="TripsheetOpenDate" HeaderText="Tripsheet Open Date" ReadOnly="True" SortExpression="" />
                                        <asp:BoundField DataField="VendorCity" HeaderText="City" ReadOnly="true" />
                                        <asp:BoundField DataField="FuelType" HeaderText="Fuel Type" ReadOnly="true" />
                                        <asp:BoundField DataField="UserSlipNo" HeaderText="Slip No." ReadOnly="true" /> 
                                         <asp:BoundField DataField="FillingDate" HeaderText="Filling Date" ReadOnly="true" />
                                        <asp:BoundField DataField="UserSlipDate" HeaderText="Slip Date" ReadOnly="true" />
                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" ReadOnly="true" />
                                        <asp:BoundField DataField="Rate" HeaderText="Rate/Ltr" ReadOnly="true" />
                                        <asp:BoundField DataField="Amount" HeaderText="Amount" ReadOnly="true" />
                                        <asp:BoundField DataField="Remark" HeaderText="Remarks" ReadOnly="true" />

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


