<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PendingFuelBills_Result.aspx.cs" Inherits="GUI_admin_FuelSlipMaster_PendingFuelBills_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" >

        function ViewPrint(ctrl) {
            window.open('./PendingFuelBillsApproval_Result_View.aspx?Billno=' + $(ctrl).text() + '&PrintMode=0', '_blank'
                , 'top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes');

        }
    </script>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Pending Fuel Bills</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
        </tr>
    </table>
    </br> </br>
    <center>
        </br></br>
    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Fuel Bill generated Successfully" CssClass="blackfnt"></asp:Label>
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
                                    <asp:TemplateField HeaderText="Bill No">
                                        <ItemTemplate>
                                            <asp:HyperLink ID="billno" Text='<%#Eval("Bill_No")%>'  runat="server" NavigateUrl='<%# string.Format("PendingFuelBillApprovalView.aspx?Billno={0}", Eval("Bill_No"))%>' ></asp:HyperLink></ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="Bill_No" HeaderText="Bill No" ReadOnly="true" />--%>
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
            <tr style="background-color: White">
                <td align="center" colspan="5">
                    <asp:HyperLink ID="HyperLink1" NavigateUrl="PendingFuelBills.aspx" Text="Click here to generate another bill" runat="server"></asp:HyperLink>
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>


    </center>

</asp:Content>

