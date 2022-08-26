<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FuelIssueSlip_Result.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_FuelIssueSlip_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Fuel Issue Slip Entry</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
    </br> </br>
  
        </br></br>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Fuel Slip Entered Successfully" CssClass="blackfnt"></asp:Label>
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


</asp:Content>
