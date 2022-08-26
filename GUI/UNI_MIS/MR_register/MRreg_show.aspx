<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MRreg_show.aspx.cs" Inherits="MRreg_show" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                
                <tr>
                    <td>
                        <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td style="height: 30">
                                                <asp:HyperLink ID="hypWelcome" runat="server">        
                                                </asp:HyperLink>
                                                    <%--<a href="../../welcome.asp">
                                                        <font class=blklnkund><strong><%=session("MainLevel_Type")%> Module</strong></font></a>--%>
                                                <strong> &gt; </strong>
                                                <asp:HyperLink ID="hypReport" runat="server">
                                                </asp:HyperLink>
                                                    <%--<a href="../reportmenu.asp"><font class=blklnkund><strong>Reports</strong></font></a>--%>
                                                <strong> &gt; </strong>
                                                <asp:HyperLink ID="hypFinance" runat="server">
                                                </asp:HyperLink>    
			                                        <%--<a href="../rpt_finance.asp"><font class=blklnkund><strong>Finance</strong></font></a>--%>
                                                <strong> &gt; </strong>
                                                <label id="lblBillRegister" class="bluefnt">
                                                    <strong>
                                                        Bill Register - Details
                                                    </strong>
                                                </label>
                                            </td>
                                        </tr>
                                        
                                        <tr> 
                                            <td class="horzblue">
                                                <img src="../../images/clear.gif" width="2" height="1" />
                                            </td>
                                        </tr>
                                        
                                        <tr> 
                                            <td>
                                                <img src="../../images/clear.gif" width="15" height="10" />
                                            </td>
                                        </tr>
                                        
                                        <tr> 
                                            <td align="right">
                                                <a href="javascript:window.history.go(-1)" title="back">
                                                    <img src="../../images/back.gif" border="0">
                                                </a>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td style="width: 39%; height: 621px;" valign="top">
                                                            <%--Display error message table--%>
                                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblErrorMessage" runat="server">
                                                                <tr>
                                                                    <td style="height: 300" valign="top">
                                                                        <br />
                                                                        <br />
                                                                        <br />
                                                                        
						                                                <table border="1" cellspacing="0" cellpadding="2" width="70%" align="center" class="bglightblue">
   					                                                        <tr>
   							                                                    <td align="center" class="bgbluegrey">
   							                                                        <label class="blackfnt" color="red">
   							                                                            <b>Result</b>
   							                                                        </label>
   							                                                    </td>
   							                                                </tr>
						                                                    
						                                                    <tr>
						                                                        <td>
						                                                            <br />
					                                                                <p align="center">
					                                                                    <label id="lblErrorMessage" runat="server" class="blackfnt">    
					                                                                    </label>
					                                                                    
					                                                                    <br />
					                                                                    <br />
					                                                                    
					                                                                    <label class="blackfnt">
					                                                                        <a href="javascript:history.go(-1)">
					                                                                            <u>
					                                                                                Back
					                                                                            </u>
					                                                                        </a>
					                                                                    </label>
					                                                                    
					                                                                    <br />
					                                                                </p>    
					                                                            </td>
					                                                        </tr>
					                                                    </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            
                                                            <%--Display MR details table--%>
                                                            <br />
                                                            
                                                            <p align="center">
                                                                <label class="blackfnt">
                                                                    <b>
                                                                        You Selected
                                                                    </b>
                                                                </label>
                                                            </p>
                                                            
                                                            <center>
                                                            
                                                                <table border="0" cellpadding="3" cols="1" width="565" style="background-color: #808080;" cellspacing="1" align="center" class="boxbg">
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205">
                                                                            <label class="blackfnt">
                                                                                RO</label></td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205">
                                                                            <label class="blackfnt">
                                                                                Location</label></td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205">
                                                                            <label class="blackfnt">
                                                                                MR Party</label></td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblmrparty" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205">
                                                                            <label class="blackfnt">
                                                                                Mr Type</label></td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblmrtype" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205">
                                                                            <label class="blackfnt">
                                                                                Status</label></td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblstatus" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205">
                                                                            <label class="blackfnt">
                                                                                Cash / Cheque</label></td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblcash" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    
                                                                    <tr style="background-color: #FFFFFF">
                                                                        <td style="width: 205">
                                                                            <label class="blackfnt">
                                                                                Amount Greater Than
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="width: 343">
                                                                            &nbsp;
                                                                            <asp:Label ID="lblamtgrt" runat="server" CssClass="blackfnt"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </center>
                                                            
                                                            <br />
                                                            
                                                            <table id="tblBillDetails" runat="server" border="0" cellspacing="1" cellpadding="4" style="width: 100%" align="center" class="boxbg">
                                                                <tr class="bgbluegrey"> 
                                                                    <td colspan="4" align="center">
                                                                        <label class="blackfnt">
                                                                            <b>
                                                                                Bill List
                                                                            </b>    
                                                                        </label>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                                
                                                            <br />
                                                            
                                                            <center>
                                                                <table border="0" style="width: 98%; background-color: #808080" align="center" cellspacing="1" cellpadding="2" class="boxbg">
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
                                                                                Bill Date
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
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
                                                                        
                                                                        <td style="width: 79px">
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
                                                                                Service Tax + Cess
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                MR No./MR Date
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                Amount
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td>
                                                                            <label class="blackfnt">
                                                                                Collection Amount
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
                                                                    </tr>
                                                                    
                                                                    <asp:Repeater ID="rptBillDetails" runat="server">
                                                                        <ItemTemplate>
                                                                            <tr style="background-color: White">
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "RowCounter")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <a href=<%#DataBinder.Eval(Container.DataItem, "aHrefLink")%>>
                                                                                            <%#DataBinder.Eval(Container.DataItem, "BillNo")%>
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
                                                                                        <%#DataBinder.Eval(Container.DataItem, "ServiceTaxPlusCess")%>
                                                                                    </label>
                                                                                </td>
                                                                                
                                                                                <td>
                                                                                    <label class="blackfnt">
                                                                                        <%#DataBinder.Eval(Container.DataItem, "MRDetails")%>
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
                                                                            </tr>
                                                                        </ItemTemplate>
                                                                    </asp:Repeater>
                                                                    
                                                                    <tr style="background-color: #FFFFFF"> 
                                                                        <td colspan="15" align="right" style="height: 23px">
                                                                            <label class="blackfnt">
                                                                                <b>
                                                                                    Total
                                                                                </b>
                                                                            </label>
                                                                        </td>
                                                                        
                                                                        <td style="height: 23px">
                                                                            <asp:Label class="blackfnt" ID="lblTotalBillAmtRcvd" runat="server" Font-Bold="true">
                                                                            </asp:Label>
                                                                        </td>
                                                                        
                                                                        <td style="height: 23px">
                                                                            <asp:Label class="blackfnt" ID="lblTotalBillAmtCollected" runat="server" Font-Bold="true">
                                                                            </asp:Label>
                                                                        </td>
                                                                        
                                                                        <td style="height: 23px">
                                                                            <asp:Label class="blackfnt" ID="lblTotalPendingAmt" runat="server" Font-Bold="true">
                                                                            </asp:Label>
                                                                        </td>
                                                                        
                                                                        <td style="height: 23px">
                                                                            <asp:Label class="blackfnt" ID="lblTotalFreightAmt" runat="server" Font-Bold="true">
                                                                            </asp:Label>
                                                                        </td>
                                                                        
                                                                        <td style="height: 23px">
                                                                            <asp:Label class="blackfnt" ID="lblTotalAmtClaimed" runat="server" Font-Bold="true">
                                                                            </asp:Label>
                                                                        </td>
                                                                        
                                                                        <td style="height: 23px">
                                                                            <asp:Label class="blackfnt" ID="lblTotalTDSAmt" runat="server" Font-Bold="true">
                                                                            </asp:Label>
                                                                        </td>
                                                                        
                                                                        <td style="height: 23px">
                                                                            <asp:Label class="blackfnt" ID="lblTotalUnadjAmt" runat="server" Font-Bold="true">
                                                                            </asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </center>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>

    
    </form>
</body>
</html>
