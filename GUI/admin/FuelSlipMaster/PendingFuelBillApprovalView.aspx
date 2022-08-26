<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PendingFuelBillApprovalView.aspx.cs" MasterPageFile="~/GUI/MasterPage.master" Inherits="GUI_admin_FuelSlipMaster_PendingFuelBillApprovalView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="VendorPayment.js"></script>
    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
    <script language="javascript" type="text/javascript" src="../../../admin/FuelSlipMaster/FuelSlipMaster_JS.js"></script>
    <script language="javascript" type="text/javascript" src="FuelRateMaster.js"></script>
    <script type="text/javascript" language="javascript">
        function Edit_Alert() {
            if (confirm('Do you want to send for Date Entry?')) {
                return true;
            }
            else {
                return false;
            }
        }
        function ValidateDate(obj) {
            if (obj.value != "") {
                // alert(isDate(obj.value))
                if (isDate(obj.value) == false) {
                    obj.focus()
                    return false
                }
            }
        }
    </script>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../images/loading.gif" alt="" /></td>
                    <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%; left: 50%;"
                    ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>

    <div align="left" style="width: 75%">
        <asp:UpdatePanel ID="UP1" runat="Server">
            <ContentTemplate>
                <table border="0" cellspacing="1" cellpadding="3" width="900px">
                    <tr>
                        <td align="center">
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
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
                    <tr class="bgbluegrey">
                        <td colspan="3" align="left" style="height: 21px">
                            <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                    Pending Fuel Bills Approval View
                            </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="center" width="100%">
                            <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False"
                                        CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                        CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                        PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found" OnRowDataBound="dgGeneral_RowDataBound">
                                        <Columns>
                                            <%-- <asp:TemplateField runat="server" HeaderText="Options" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkbxCheck" />
                                                    <%--/
                                                    <asp:Button Text="Edit" ID="btnEdit" OnClientClick="javascript:return Edit_Alert()" runat="server" Enabled="false" OnClick="btnEdit_Click" />--%>
                                            <%--</ItemTemplate>
                                            </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Sr No.">
                                                <ItemTemplate><%#Container.DataItemIndex+1 %></ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="FillingDate" ItemStyle-HorizontalAlign="Left" HeaderText="Filling Date" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="VendorName" ItemStyle-HorizontalAlign="Left" HeaderText="Vendor Name" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="VendorName" />
                                            <asp:BoundField DataField="VehicleNo" ItemStyle-HorizontalAlign="Left" HeaderText="Truck No" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="Rate" />
                                            <asp:BoundField DataField="TripsheetNo" HeaderText="TripSheet No" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="TripSheetNo" />
                                            <asp:BoundField DataField="TripSheetOpenDate" ItemStyle-HorizontalAlign="Left" HeaderText="TripSheet Date" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="FuelType" ItemStyle-HorizontalAlign="Left" HeaderText="Fuel Type" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="FuelType" />
                                            <asp:BoundField DataField="UserSlipNo" ItemStyle-HorizontalAlign="Left" HeaderText="Slip No" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="Rate" />
                                            <asp:BoundField DataField="UserSlipDate" HeaderText="Slip Date" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="Amount" />
                                            <asp:BoundField DataField="Quantity" ItemStyle-HorizontalAlign="Left" HeaderText="Fuel Quantity" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="Rate" ItemStyle-HorizontalAlign="Left" HeaderText="Rs./Ltr.Fuel Rate (As per Filling Date)" InsertVisible="false"
                                                ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="Rate" />
                                            <asp:BoundField DataField="Amount" HeaderText="Amount" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left" ReadOnly="True" SortExpression="Amount" />
                                             <asp:BoundField DataField="IGST" ItemStyle-HorizontalAlign="Left" HeaderText="IGST" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="IGST" />
                                            <asp:BoundField DataField="SGST" ItemStyle-HorizontalAlign="Left" HeaderText="SGST" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="SGST" />
                                            <asp:BoundField DataField="CGST" ItemStyle-HorizontalAlign="Left" HeaderText="CGST" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="CGST" />
                                            <asp:BoundField DataField="TotalAmount" ItemStyle-HorizontalAlign="Left" HeaderText="Total Amount" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" SortExpression="TotalAmount" />                                             
                                        </Columns>
                                    </asp:GridView>
                                    <table border="1" id="dgtotaldetails" cellspacing="1" cellpadding="3"  class="dgRowStyle" width="30%" style="text-align:left" align="right">
                                        <tr>
                                            <td>Total Amount
                                            </td>
                                            <td>
                                                <asp:Label ID="lblTotalAmount" runat="server"  ReadOnly="True" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Discount
                                            </td>
                                            <td>
                                                <asp:Label ID="lblDiscount" runat="server" ReadOnly="True" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Spcial Discount
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSpcialDiscount" runat="server" ReadOnly="True" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Net bill Amount
                                            </td>
                                            <td>
                                                <asp:Label ID="lblNetbillAmount" runat="server" ReadOnly="True" />
                                            </td>
                                        </tr>

                                    </table>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr id="trCancel">
                        <td align="right">
                            <asp:Button runat="server" Text="Submit" ID="btnSubmitBills" OnClick="btnSubmitBills_Click" />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            <asp:Label runat="server" ID="lblSuccess" ForeColor="Blue" Text=""></asp:Label>
                        </td>
                    </tr>
                </table>
                <%--<table cellspacing="1" border="0" style="width: 100%">
                    <tr align="left">
                        <td colspan="3">
                            <table cellspacing="1" style="width: 90%" class="boxbg" border="0">
                                <tr class="bgbluegrey">
                                    <td colspan="3" align="left" style="height: 21px">
                                        <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" runat="server">
                                                    Pending Fuel Bills Approval View
                                        </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="4">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="ShowPendingBillsApproval" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>--%>
                <%--*************************** Gridarea ****************************--%>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
