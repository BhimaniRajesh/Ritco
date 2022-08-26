<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmVehicleIssueSlipNew_result.aspx.cs" Inherits="Issue_frmVehicleIssueSlipNew_result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript">

        function ViewPrint(tTripSheetNo, tPrintMode) {

            //var strurl = "frmViewPrintVehicleIssueSlipV2.aspx?VSlipNO=" + tTripSheetNo + "&PrintMode=" + tPrintMode
            //popup = window.open(strurl, "", "height=475,width=850,scrollbars=yes,resizable=yes,left=100,top=125");
            var strurl = "./../Issue/New_TripSheet_Validation/TripsheetViewPrint.aspx?VSlipNO=" + tTripSheetNo + "&PrintMode=" + tPrintMode
            popup = window.open(strurl, "", "height=475,width=850,scrollbars=yes,resizable=yes,left=100,top=125");
        }

        function ViewPrintPay(tVSlipId, tPrintMode) {
            //alert("advance");
            var strurl = "./../Issue/DebitVoucherView.aspx?voucherno=" + tVSlipId + "&PrintMode=" + tPrintMode
            popup = window.open(strurl, "", "height=475,width=850,scrollbars=yes,resizable=yes,left=100,top=125");
        }

    </script>

    <%
        string VSlipId = "";
        string TripSheetNo = "";
        //string mTripSheetType = "";

        VSlipId = Request.QueryString["VSlipId"];

        TripSheetNo = VSlipId;
        lblDocNoVal.Text = VSlipId;
    %>

    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet >> New
                <%
                    string mTripSheetType = Request.QueryString["TripSheetType"];
                    if (mTripSheetType == "R")
                    {%>
                  with Request
                  <%}
                    else
                    {    %>
                    without Request
                  <%} %>
                </asp:Label>
                >>
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Submitted</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br>

    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="50%">
        <tr class="bgbluegrey">
            <td align="center" colspan="4">
                <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Following document is generated" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color: White">
            <td align="center">
                <asp:Label ID="lblDocType" runat="server" Text="Document Name" Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="lblDocNo" runat="server" Text="Document No." Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="lblDocDt" runat="server" Text="Document Date." Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">&nbsp;</td>
        </tr>

        <tr style="background-color: White">
            <td align="center">
                <asp:Label ID="lblDocNameVal" runat="server" Text="Trip Sheet" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="lblDocNoVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="lblDocDtVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <a href="javascript:ViewPrint('<%=TripSheetNo%>','0')"><font class="blackfnt">View</font></a>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <a href="javascript:ViewPrint('<%=TripSheetNo%>','1')"><font class="blackfnt">Print</font></a>

                <asp:Label ID="lblSep2" visible="false" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <asp:LinkButton ID="LinkXLS" visible="false" runat="server" Text="XLS" CausesValidation="true" CssClass="blackfnt"></asp:LinkButton>
            </td>
        </tr>
        <tr style="background-color: White">
            <td align="center" colspan="4">
                <asp:GridView runat="server" ID="gvAdvance" AutoGenerateColumns="false" CellPadding="2"
                                                                CssClass="blackfnt" BackColor="White" BorderColor="#006699" BorderStyle="None"
                                                                BorderWidth="3px" Width="100%">
                    <Columns>
                         <asp:TemplateField>
                            <ItemTemplate>
                              <b>Advance Payment Voucher </b> 
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="VoucherRefno"  ItemStyle-CssClass="blackfnt" />
                        <asp:BoundField DataField="AdvDate" ItemStyle-CssClass="blackfnt" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <a href="javascript:ViewPrintPay('<%# DataBinder.Eval(Container.DataItem,"VoucherRefNo") %>','0') "><font class="blackfnt">View</font></a>
                                <asp:Label ID="Label2" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                                <a href="javascript:ViewPrintPay('<%# DataBinder.Eval(Container.DataItem,"VoucherRefNo") %>','1')"><font class="blackfnt">Print</font></a>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
            
        </tr>
        <tr class="bgbluegrey">
            <td align="center">
                <asp:Label ID="lblVehicleNo" runat="server" Text="Vehicle No." Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="lblDriverName" runat="server" Text="Driver Name" Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="lblAmount" runat="server" Text="Amount" Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">&nbsp;</td>
        </tr>
        <tr style="background-color: White">
            <td align="center">
                <asp:Label ID="lblVehicleNoVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="lblDriverNameVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="lblAmountVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">&nbsp;</td>
        </tr>

        <tr class="bgbluegrey">
            <td align="left" colspan="4">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step" Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color: White">
            <td align="left" colspan="4">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Generate More Trip Sheet" CssClass="blackfnt" PostBackUrl="frmNewVehicleIssueSlipNewWORequest.aspx" />
            </td>
        </tr>
        <%-- <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton1" runat="server" Text="Fulfill a Requests" CssClass="blackfnt" PostBackUrl="#"/>
            </td>
        </tr>--%>

        <%-- <tr style="background-color: White">
            <td align="left" colspan="4">
                <asp:LinkButton ID="LinkButton2" runat="server" Text="View & Print Trip Sheet" CssClass="blackfnt" PostBackUrl="frmViewPrintVehicleIssueSlipQuery.aspx" />
            </td>
        </tr>--%>
    </table>

</asp:Content>
