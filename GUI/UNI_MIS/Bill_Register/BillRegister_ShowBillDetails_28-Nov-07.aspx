<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="BillRegister_ShowBillDetails.aspx.cs" Inherits="BillRegister_ShowBillDetails" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

        <script language="javascript" type="text/javascript">
        function OpenPopup(Bill_Number) 
        { 
            window.open("BillNo_Popup.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
        </script>
        <script language="javascript" type="text/javascript">
  
            function popupmenu2(strURL, BillNo, printYN)
            {
                var winOpts = "scrollbars=yes,resizable=yes,width=500,height=400";
                
                confirmWin = window.open(strURL + "?" + BillNo + "," + printYN, "", winOpts);
            }
            
            function PageSelectionChanged(objPages)
            {
                if(document.getElementById("HIDCurrentPageNo"))
                {
                    document.getElementById("HIDCurrentPageNo").value = objPages.value;
                    document.frmBillRegisterDetails.submit();
                }                    
            }
             
        </script>

    <table align="center" border="0" cellpadding="0" cellspacing="0" width="95%">
        <tr>
            <td style="height: 758px">
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td style="width: 39%" valign="top">
                            <p align="center">
                                <label class="blackfnt">
                                    <b>You Selected </b>
                                </label>
                            </p>                            
                            <table align="center" border="0" cellpadding="3" cellspacing="1" class="boxbg" cols="1"
                                width="565">
                                <tr style="background-color: #ffffff">
                                    <td style="width: 205px">
                                        <label class="blackfnt">
                                            Bill Date
                                        </label>
                                    </td>
                                    <td style="width: 343px">
                                        &nbsp;
                                        <asp:Label ID="lblSelDateRange" runat="server" CssClass="blackfnt">
                                                                            </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td style="width: 205px">
                                        <label class="blackfnt">
                                            Bill Party
                                        </label>
                                    </td>
                                    <td style="width: 343px">
                                        &nbsp;
                                        <asp:Label ID="lblSelBillingParty" runat="server" CssClass="blackfnt">
                                                                            </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td style="width: 205px">
                                        <label class="blackfnt">
                                            Bill Type
                                        </label>
                                    </td>
                                    <td style="width: 343px">
                                        &nbsp;
                                        <asp:Label ID="lblSelBillingType" runat="server" CssClass="blackfnt">
                                                                            </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td style="width: 205px">
                                        <label class="blackfnt">
                                            Billed At
                                        </label>
                                    </td>
                                    <td style="width: 343px">
                                        &nbsp;
                                        <asp:Label ID="lblSelBilledAt" runat="server" CssClass="blackfnt">
                                                                            </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td style="width: 205px">
                                        <label class="blackfnt">
                                            Submitted At<strong> </strong>
                                        </label>
                                    </td>
                                    <td style="font-weight: bold; width: 343px">
                                        &nbsp;
                                        <asp:Label ID="lblSelSubmittedAt" runat="server" CssClass="blackfnt">
                                                                            </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td style="width: 205px">
                                        <label class="blackfnt">
                                            Collection At
                                        </label>
                                    </td>
                                    <td style="width: 343px">
                                        &nbsp;
                                        <asp:Label ID="lblSelCollectedAt" runat="server" CssClass="blackfnt">
                                                                            </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td style="width: 205px">
                                        <label class="blackfnt">
                                            Status
                                        </label>
                                    </td>
                                    <td style="width: 343px">
                                        &nbsp;
                                        <asp:Label ID="lblSelStatus" runat="server" CssClass="blackfnt">
                                                                            </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td style="width: 205px">
                                        <label class="blackfnt">
                                            Over Due Days
                                        </label>
                                    </td>
                                    <td style="width: 343px">
                                        &nbsp;
                                        <asp:Label ID="lblSelOverDueDays" runat="server" CssClass="blackfnt">
                                                                            </asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td style="width: 205px; height: 8px">
                                        <label class="blackfnt">
                                            Amount Greater Than
                                        </label>
                                    </td>
                                    <td style="width: 343px; height: 8px">
                                        &nbsp;
                                        <asp:Label ID="lblSelAmtGrThan" runat="server" CssClass="blackfnt">
                                                                            </asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <table id="tblBillDetails" runat="server" align="center" border="0" cellpadding="4"
                                cellspacing="1" class="boxbg" style="width: 100%">
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="4">
                                        <label class="blackfnt">
                                            <b>Bill List </b>
                                        </label>
                                    </td>
                                </tr>
                            </table>
                            <br />
                            <center>
                                <table align="center" border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width: 98%;
                                    background-color: #808080">
                                    <tr class="bgbluegrey">
                                        <td style="width: 10%">
                                            <label class="blackfnt">
                                                Sr. No.
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Bill Number
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Bill Type
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Billing Party
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Collection at
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Submitted at
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                <strong>Bill Date </strong>
                                            </label>
                                        </td>
                                        <td style="font-weight: bold">
                                            <label class="blackfnt">
                                                Submission Date
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Due Date
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Overdue Days
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Collection Date
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                MR No./MR Date
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Service Tax
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Cess
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Bill Sub Total
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Amount
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Collection Amount<span style="color: #ff0000"> </span>
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Pending Amount
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Deduction
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Claim
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                TDS
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Unadjusted Amount
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Bill Cancellation Date
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Bill Cancelled By
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Bill Generated By
                                            </label>
                                        </td>
                                        <td>
                                            <label class="blackfnt">
                                                Bill Submitted By
                                            </label>
                                        </td>
                                    </tr>
                                    <asp:Repeater ID="rptBillDetails" runat="server">
                                        <ItemTemplate>
                                            <tr style="background-color: White">
                                                <td>
                                                    <label class="blackfnt">
                                                        <%--<%#DataBinder.Eval(Container.DataItem, "aHrefLink")%>--%>
                                                        <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%--<a href='<%#DataBinder.Eval(Container.DataItem, "aHrefLink")%>'>
                                                            <%#DataBinder.Eval(Container.DataItem, "BillNo")%>--%>
                                                            <asp:HyperLink Runat="server"  Font-Underline="True"  ForeColor="#003333" NavigateUrl='<%# DataBinder.Eval(Container.DataItem, "aHrefLink")%>' Text='<%#DataBinder.Eval(Container.DataItem, "BillNo")%>' ID="Hyperlink1">
                                                            </asp:HyperLink>
                                                        </a>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "BillType")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "BillingParty")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "CollectionAt")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "SubmittedAt")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "BillDate")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "SubmissionDate")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "DueDate")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "OverDueDays")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "CollectionDate")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "MRDetails")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "ServiceTaxPlusCess")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "CessAmt")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "BillSubTot")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "Amount")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "CollectionAmount")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "PendingAmount")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "Deduction")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "Claim")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "TDS")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "UnadjustedAmount")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "BillCancellationDate")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "BillCancelledBy")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "BillGenBy")%>
                                                    </label>
                                                </td>
                                                <td>
                                                    <label class="blackfnt">
                                                        <%#DataBinder.Eval(Container.DataItem, "BillSubBy")%>
                                                    </label>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <tr id="trForTotalValues" runat="server" style="background-color: #ffffff">
                                        <td align="right" colspan="12">
                                            <label class="blackfnt">
                                                <b>Total </b>
                                            </label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblSvcTax" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCess" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblBillSubTot" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotalBillAmtRcvd" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotalBillAmtCollected" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotalPendingAmt" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotalFreightAmt" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotalAmtClaimed" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotalTDSAmt" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTotalUnadjAmt" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                                <%--Table for displaying no records found message--%>
                                <table id="tblNoRecords" runat="server" align="center" border="0" cellpadding="2"
                                    cellspacing="1" class="boxbg" style="width: 98%; background-color: #808080" visible="false">
                                    <tr style="background-color: #ffffff">
                                        <td align="right" colspan="22" style="height: 31px">
                                            <div align="center">
                                                <label class="blackfnt" style="color: #ff0000">
                                                    No Record Found
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </center>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <label id="lblComment" runat="server" class="blackfnt">
                    ** Click on Amounts to view bill details
                </label>
                <table id="tblPageNavigation" runat="server" align="center" border="0" cellpadding="0"
                    cellspacing="4">
                    <tr align="center">
                        <td align="center">
                            <label class="blackfnt">
                                Page&nbsp;
                                <asp:Label ID="CurrentPage" runat="server" CssClass="blackfnt"></asp:Label>
                                &nbsp;of&nbsp;
                                <asp:Label ID="TotalPages" runat="server" CssClass="blackfnt"></asp:Label>
                            </label>
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="center">
                            <label class="blackfnt">
                                <asp:LinkButton ID="FirstPage" runat="server" CommandName="First" CssClass="blackfnt"
                                    OnCommand="NavigationLink_Click" Text="[First Page]"></asp:LinkButton>
                                <asp:LinkButton ID="PreviousPage" runat="server" CommandName="Prev" CssClass="blackfnt"
                                    OnCommand="NavigationLink_Click" Text="[Previous Page]"></asp:LinkButton>
                                <asp:LinkButton ID="NextPage" runat="server" CommandName="Next" CssClass="blackfnt"
                                    OnCommand="NavigationLink_Click" Text="[Next Page]"></asp:LinkButton>
                                <asp:LinkButton ID="LastPage" runat="server" CommandName="Last" CssClass="blackfnt"
                                    OnCommand="NavigationLink_Click" Text="[Last Page]"></asp:LinkButton>
                            </label>
                        </td>
                    </tr>
                    <tr align="center">
                        <td align="center">
                            <label class="blackfnt">
                                Go to Page:&nbsp;
                            </label>
                            <select id="ddlPages" runat="server" class="blackfnt" onchange="PageSelectionChanged(this)">
                            </select>
                            <input id="HIDCurrentPageNo" runat="server" type="hidden" />
                        </td>
                    </tr>
                </table>
                <br />
                <center>
                    <table id="tblButtons" runat="server" align="center" border="0" cellpadding="3" cellspacing="1"
                        width="25%">
                        <tr style="background-color: #ffffff">
                            <%--<td>
			                                                    
			                                                    <asp:Button ID="btnPrint" runat="server" Text="  Print  " CssClass="btncolor" OnClick="btnPrint_OnClick" />
			                                                </td>--%>
                            <td align="right" colspan="10" style="height: 24px">
                                <input id="btnPrint" runat="server" type="button" value="Print" />
                            </td>
                            <td>
                                <input id="btnXML" runat="server" class="btncolor" onclick="faction(2)" type="button"
                                    value="  XLS  " />
                            </td>
                            <td>
                                <input id="btnEmail" runat="server" class="btncolor" onclick="faction(3)" type="button"
                                    value="  Email " />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <CR:CrystalReportViewer ID="crvBillDetails" runat="server" AutoDataBind="true" DisplayGroupTree="False"
                                    EnableDatabaseLogonPrompt="False" />
                            </td>
                        </tr>
                    </table>
                </center>
            </td>
        </tr>
    </table>
            
          
        
</asp:Content>
