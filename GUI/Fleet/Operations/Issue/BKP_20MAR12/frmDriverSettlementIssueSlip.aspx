<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    EnableEventValidation="false" CodeFile="frmDriverSettlementIssueSlip.aspx.cs"
    Inherits="GUI_Fleet_Operations_Issue_frmDriverSettlementIssueSlip" %>

<%@ Register TagPrefix="UC5" TagName="UCMyPaymentControlEXP" Src="~/UserControls/MyPaymentControlEXP.ascx" %>
<%@ Register TagPrefix="UC6" TagName="MyReceiptControlDS" Src="~/UserControls/MyReceiptControlDS.ascx" %>
<%--<%@Register TagPrefix="SControls" TagName="DateSelector" src="~/LED/DateSelector.ascx" %>
--%><asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"> </script>

    <script language="javascript" type="text/javascript" src="AJAX_Validator/DriverSettlement.js"> </script>

    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("Div1"); 
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");

        var FinYear="<%=Session["FinYear"]%>"
        var FinYear_to=parseInt(FinYear)+1

        if(FinYear_to<10)
        {
            FinYear_to="0"+FinYear_to
        }
        var FinYear_fromdate="01/04/"+FinYear
        var FinYear_todate="31/03/"+FinYear_to
        var Sle_finyear=FinYear+"-"+FinYear_to
 
    </script>

    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table cellspacing="1" width="100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Trip Sheet Driver Settlement</asp:Label>
            </td>
            <td align="right">
                <%--<asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  --%>
            </td>
        </tr>
    </table>
    <hr align="center" size="1" color="#8ba0e5">
    <br />
    <table cellspacing="1" align="center" cellpadding="3" width="100%" style="background-color: white"
        border="0">
        <tr style="background-color: white">
            <td colspan="4" align="left">
                <%--<asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate> 
                        <asp:Panel runat="server" ID="Panel7" Visible="true">--%>
                <table cellspacing="1" cellpadding="3" width="60%" class="boxbg" border="0">
                    <tr style="background-color: white">
                        <td colspan="4" align="left">
                            <asp:Label ID="lblError1" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                            <asp:HiddenField ID="hfAdvDate" runat="server" />
                        </td>
                    </tr>
                    <tr class="bgbluegrey">
                        <td colspan="4" align="left">
                            <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="TRIP SHEET DRIVER SETTLEMENT "></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="4" align="left" style="background-color: white">
                            <table border="1" cellpadding="3" cellspacing="1" class="boxbg" width="72%">
                                <tr style="background-color: white">
                                    <td align="left">
                                        <font class="bluefnt">Issue Slip Id</font>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblIssueNo" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <font class="bluefnt">Issue Slip Date</font>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblIssueDt" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left">
                                        <font class="bluefnt">Vehicle No.</font>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblVehno" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <font class="bluefnt">Driver</font>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblDriverName" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left">
                                        <font class="bluefnt">Driver License No.</font>
                                    </td>
                                    <td align="left">
                                        <font class="blackfnt">
                                            <asp:Label ID="lblLicno" runat="server" CssClass="balckfnt"></asp:Label>
                                        </font>
                                    </td>
                                    <td align="left">
                                        <font class="bluefnt">License Valid upto</font>
                                    </td>
                                    <td align="left">
                                        <font class="blackfnt">
                                            <asp:Label ID="lblValidDt" runat="server" CssClass="balckfnt"></asp:Label>
                                        </font>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left">
                                        <font class="bluefnt">Starting Location</font>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblStartLoc" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <font class="bluefnt">End Location</font>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblEndLoc" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left">
                                        <font class="bluefnt">Category</font>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblCategory" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblCustCodeHead" runat="server" CssClass="bluefnt" Text="Customer Code/Name"
                                            Visible="false"></asp:Label>
                                        <asp:Label ID="lblMarketHead" runat="server" CssClass="bluefnt" Text="Market/Own"
                                            Visible="false"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblCustcodeMarket" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left">
                                        <font class="bluefnt">Financial Close date</font>
                                    </td>
                                    <td align="left">
                                        <asp:Label ID="lblFinCloseDt" runat="server" CssClass="blackfnt"></asp:Label>
                                    </td>
                                    <td align="left">
                                        <font class="bluefnt">Driver Settlement date</font>
                                    </td>
                                    <td align="left">
                                        <%--<SControls:DateSelector     ID="txtDateFrom" runat="server" />--%>
                                        <asp:TextBox ID="txtSettleDate" runat="server" BorderStyle="Groove" CssClass="input"
                                            MaxLength="10" Width="80px"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtSettleDate,'anchor22','dd/MM/yyyy'); return false;"
                                            id="a1" name="anchor22">
                                            <img alt="Cal" border="0" src="../../../images/calendar.jpg" /></a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="4" align="center">
                            <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:Panel runat="server" ID="Panel7" Visible="true">
                                        <asp:Label ID="lblError" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                                        <table cellspacing="1" cellpadding="3" style="width: 100%" align="center" class="boxbg"
                                            border="0">
                                            <tr class="bgbluegrey">
                                                <td align="Left">
                                                    <font class="blackfnt"><b>Head</b></font>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt"><b>Amount</b></font>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt"><b>Approved Amount</b></font>
                                                </td>
                                                <td align="Left">
                                                    &nbsp;
                                                </td>
                                                <td align="Left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr style="background-color: white">
                                                <td align="Left">
                                                    <font class="blackfnt"><b>Total Advance Paid</b></font>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotAdvancePaid" CssClass="blackfnt" ForeColor="blue" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotAdvancePaidAppr" CssClass="blackfnt" ForeColor="blue" runat="server"></asp:Label>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt"><b>Amount paid to driver </b></font>
                                                </td>
                                                <td align="Left">
                                                    <asp:TextBox ID="txtAmtPaidToDriver" runat="server" MaxLength="10" Width="100" AutoPostBack="true"
                                                        OnTextChanged="Payment_Receipt"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr style="background-color: white">
                                                <td align="Left">
                                                    <font class="blackfnt"><b>Total Expenses</b></font>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotExpense" Text="0.00" CssClass="blackfnt" ForeColor="blue" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotExpenseAppr" Text="0.00" CssClass="blackfnt" ForeColor="blue"
                                                        runat="server"></asp:Label>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt"><b>Amount received from driver </b></font>
                                                </td>
                                                <td align="Left">
                                                    <asp:TextBox ID="txtAmtRecvdFromDriver" runat="server" MaxLength="10" Width="100"
                                                        AutoPostBack="true" OnTextChanged="Payment_Receipt"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr style="background-color: white">
                                                <td align="left">
                                                    <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Diesel expense against cash&nbsp;</font>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotDieselCashExp" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotDieselCashExpAppr" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt">
                                                        <asp:Label ID="LblDriverLedger" CssClass="blackfnt" Text="Trip Sheet balance to driver ledger"
                                                            runat="server" Font-Bold="true"></asp:Label>
                                                    </font>
                                                </td>
                                                <td align="Left">
                                                    <asp:TextBox ID="txtBalToDriverLedger" runat="server" MaxLength="10" Width="100"
                                                        ReadOnly="true"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr style="background-color: white">
                                                <td align="left">
                                                    <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Repair Expense </font>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotRepairExp" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotRepairExpAppr" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt">&nbsp;</font>
                                                </td>
                                                <td align="Left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr style="background-color: white">
                                                <td align="left">
                                                    <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Spare Expense </font>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotSpareExp" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotSpareExpAppr" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt">&nbsp;</font>
                                                </td>
                                                <td align="Left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr style="background-color: white">
                                                <td align="left">
                                                    <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Incidental Deduction Expense
                                                    </font>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotIncDedExp" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotIncDedExpAppr" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt">&nbsp;</font>
                                                </td>
                                                <td align="Left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr style="background-color: white">
                                                <td align="left">
                                                    <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Claims Expense </font>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotClaimExp" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotClaimExpAppr" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt">&nbsp;</font>
                                                </td>
                                                <td align="Left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr style="background-color: white">
                                                <td align="left">
                                                    <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;Enroute Expense </font>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotEnrouteExp" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotEnrouteExpAppr" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt">&nbsp;</font>
                                                </td>
                                                <td align="Left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr style="background-color: white">
                                                <td align="left">
                                                    <font class="blackfnt"><b>Diesel expense against card</b>&nbsp;</font>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotDieselCardExp" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotDieselCardExpAppr" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt">&nbsp;</font>
                                                </td>
                                                <td align="Left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr style="background-color: white">
                                                <td align="left">
                                                    <font class="blackfnt"><b>Diesel expense against credit</b></font>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotDieselCreditExp" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblTotDieselCreditExpAppr" Text="0.00" CssClass="blackfnt" runat="server"></asp:Label>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt">&nbsp;</font>
                                                </td>
                                                <td align="Left">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                            <tr style="background-color: white">
                                                <td align="Left">
                                                    <font class="blackfnt"><b>Net amount</b></font>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblNetExpAmt" Text="0.00" CssClass="blackfnt" ForeColor="blue" runat="server"></asp:Label>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="LblNetExpAmtAppr" Text="0.00" CssClass="blackfnt" ForeColor="blue"
                                                        runat="server"></asp:Label>
                                                </td>
                                                <td align="Left">
                                                    <font class="blackfnt"><b>Trip Sheet net balance</b></font>
                                                </td>
                                                <td align="Left">
                                                    <asp:Label ID="LblNetBalance" CssClass="blackfnt" ForeColor="blue" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <br>
                                        <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline"
                                            runat="server" Visible="false">
                                            <ContentTemplate>
                                                <UC5:UCMyPaymentControlEXP ID="UCMyPaymentControl1" runat="server"></UC5:UCMyPaymentControlEXP>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <br>
                                        <asp:UpdatePanel ID="UpdatePaneReceipt" UpdateMode="Conditional" RenderMode="Inline"
                                            runat="server" Visible="false">
                                            <ContentTemplate>
                                                <UC6:MyReceiptControlDS ID="UCMyReceiptControl1" runat="server"></UC6:MyReceiptControlDS>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <%--<br>
                                            <asp:UpdatePanel ID="UpdatePanePayment" UpdateMode="Conditional" RenderMode="Inline" runat="server" Visible=false >
                                                <ContentTemplate>
                                                    <UC2:UCPaymentControl ID="UCPayment" runat="server" ></UC2:UCPaymentControl>
                                                </ContentTemplate>
                                                
                                            </asp:UpdatePanel> 
                                            
                                            <br>
                                            <asp:UpdatePanel ID="UpdatePaneReceipt" UpdateMode="Conditional" RenderMode="Inline" runat="server" Visible=false >
                                                <ContentTemplate>
                                                    <UC3:UCReceiptControl ID="UCReceipt" runat="server" ></UC3:UCReceiptControl>
                                                </ContentTemplate>
                                            </asp:UpdatePanel> --%>
                                        </td> </tr> </table>
                                    </asp:Panel>
                                </ContentTemplate>
                                <Triggers>
                                </Triggers>
                            </asp:UpdatePanel>
                            <br />
                            <p align="left">
                                <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="cmdSubmit_Click" />
                            </p>
                            <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
                                layer-background-color: white; z-index: 99;">
                            </div>
</asp:Content>
