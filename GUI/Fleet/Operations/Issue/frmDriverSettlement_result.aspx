<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmDriverSettlement_result.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmDriverSettlement_result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript">
        function ViewPrint(tVSlipId, tPrintMode) {
            //var strurl = "frmViewPrintVehicleIssueSlip.aspx?VSlipNo=" + tVSlipId + "&PrintMode=" + tPrintMode
            //popup = window.open(strurl, "", "height=475,width=850,scrollbars=yes,left=100,top=125");
            var strurl = "frmDriverSettlementIssueSlipView.aspx?id=" + tVSlipId + "&PrintMode=" + tPrintMode
            popup = window.open(strurl, "", "top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes");
        }
		   function ViewPrintVer1(tVSlipId, tPrintMode) {
            //var strurl = "frmViewPrintVehicleIssueSlip.aspx?VSlipNo=" + tVSlipId + "&PrintMode=" + tPrintMode
            //popup = window.open(strurl, "", "height=475,width=850,scrollbars=yes,left=100,top=125");
            var strurl = "frmDriverSettlementIssueSlipViewVer1.aspx?id=" + tVSlipId + "&PrintMode=" + tPrintMode
            popup = window.open(strurl, "", "top=0, left=0, width=1000, height=750, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes");
        }
    </script>
    <%
        string VSlipId = "", Flag = "", mTripBillNo = "";
        VSlipId = Request.QueryString["VSlipId"];
        Flag = Request.QueryString["mFlag"];
        mTripBillNo = Request.QueryString["TripBillNo"];
        lblDocNoVal.Text = VSlipId;
        LblTripBill.Text = mTripBillNo;
    %>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Vehicle Isssue >> Driver Settlement</asp:Label>
                >>
                <% if (Flag == "U")
                   {                    
                %>
                <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Updated</asp:Label>
                <%  }
                   else
                   {%>
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server">Submitted</asp:Label>
                <% 
                   } 
                %>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br>

    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="60%">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <% if (Flag == "U")
                   {                    
                %>
                <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Text="Following document is Updated" CssClass="blackfnt"></asp:Label>
                <%   }
                   else
                   { %>
                <asp:Label ID="Label3" runat="server" Font-Bold="true" Text="Driver Settlement Done Successfully" CssClass="blackfnt"></asp:Label>
                <%  }%>
            </td>
        </tr>
        <tr style="background-color: White">
            <td align="center">
                <asp:Label ID="lblDocType" runat="server" Text="Document Name" Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="lblDocNo" runat="server" Text="Document No." Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">&nbsp;</td>
        </tr>
        <tr style="background-color: White">
            <td align="center">
                <asp:Label ID="lblDocNameVal" runat="server" Text="Vehicle Issue for Driver Settlement" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="lblDocNoVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <a href="javascript:ViewPrint('<%=VSlipId%>','0')"><font class="blackfnt">View</font></a>
                <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                <a href="javascript:ViewPrint('<%=VSlipId%>','1')"><font class="blackfnt">Print</font></a>
				<asp:Label ID="Label5" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
				<a href="javascript:ViewPrintVer1('<%=VSlipId%>','0')"><font class="blackfnt">View Ver1</font></a>
            </td>
        </tr>
        <% if (mTripBillNo != null)
           {                    
        %>
        <tr style="background-color: White">
            <td align="center">
                <asp:Label ID="Label4" runat="server" Text="Tripsheet Bill" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">
                <asp:Label ID="LblTripBill" runat="server" Text="" CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center">&nbsp;
            </td>
        </tr>
        <%
           }%>
        <tr class="bgbluegrey">
            <td colspan="3">
                <table border="0" cellspacing="1" cellpadding="3" width="100%" runat="server" id="tblDCR" class="boxbg">
                    <tr style="background-color: white" id="trdgGeneral" runat="server">
                        <td align="center" width="100%">
                            <asp:UpdatePanel ID="u1" UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:GridView ID="dgGeneral" runat="server" AutoGenerateColumns="False"
                                        CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="bgbluegrey"
                                        CssClass="dgRowStyle" Width="100%" AllowPaging="false" PagerStyle-CssClass="pager" PageSize="20"
                                        PagerSettings-Mode="NumericFirstLast" EmptyDataText="No Records Found">
                                        <Columns>
                                            <asp:BoundField DataField="vslipno" ItemStyle-HorizontalAlign="Left" HeaderText="TripSheet No" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="vehicleno" ItemStyle-HorizontalAlign="Left" HeaderText="Vehicle No" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="driver_name" ItemStyle-HorizontalAlign="Left" HeaderText="Driver Name" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="VoucherNo" ItemStyle-HorizontalAlign="Left" HeaderText="Voucher No" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="TransDate" ItemStyle-HorizontalAlign="Left" HeaderText="Voucher Date" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="ReceivePaid" ItemStyle-HorizontalAlign="Left" HeaderText="Receive/Paid" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                            <asp:BoundField DataField="Amount" ItemStyle-HorizontalAlign="Left" HeaderText="Amount" InsertVisible="false" ReadOnly="True" HeaderStyle-HorizontalAlign="Left" />
                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step" Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Close More Vehicle Issue Slip for Driver Settlement" CssClass="blackfnt" PostBackUrl="frmCloseVehicleIssueSlipQuery.aspx?mode=Settlement" />
            </td>
        </tr>
        <tr style="background-color: White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="LinkButton2" runat="server" Text="View & Print Issue Slips" CssClass="blackfnt" PostBackUrl="frmViewPrintVehicleIssueSlipQuery.aspx" />
            </td>
        </tr>
    </table>
</asp:Content>
