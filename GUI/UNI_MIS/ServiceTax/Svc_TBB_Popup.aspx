<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Svc_TBB_Popup.aspx.cs" Inherits="GUI_UNI_MIS_ServiceTax_Svc_TBB_Popup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div> <center>        RAHUL CARGO PVT. LT<br />
        <br />
        <table align="left" border="0" cellpadding="3" cellspacing="1" class="boxbg" style="background-color: #808080">
            <tr style="background-color: #ffffff" align="left">
                <td style="width: 211px; height: 10px">
                    <label class="blackfnt">
                        MR No</label></td>
                <td style="height: 10px">
                    <asp:Label ID="lblMRNO" runat="server" CssClass="blackfnt"></asp:Label></td>
                <td style="height: 10px">
                    Branch</td>
                <td style="height: 10px">
                    <asp:Label ID="lblBranch" runat="server" CssClass="blackfnt"></asp:Label></td>
            </tr>
            <tr style="background-color: #ffffff" align="left">
                <td style="width: 211px; height: 15px">
                    <label class="blackfnt">
                        Customer Code No</label></td>
                <td style="width: 343px; height: 15px">
                    <asp:Label ID="lblCustNo" runat="server" CssClass="blackfnt"></asp:Label></td>
                <td style="width: 343px; height: 15px">
                    Date</td>
                <td style="width: 343px; height: 15px">
                    <asp:Label ID="lblDate" runat="server" CssClass="blackfnt"></asp:Label></td>
            </tr>
            <tr style="background-color: #ffffff" align="left">
                <td colspan="4">
                    <label class="blackfnt">
                        M/s.</label><asp:Label ID="lblName" runat="server" CssClass="blackfnt"></asp:Label></td>
            </tr>
            <tr align="left" style="background-color: #ffffff">
                <td colspan="4">
            Received with thanks 
                    <asp:Label ID="lblChqueNo" runat="server" CssClass="blackfnt"></asp:Label>
                    details given below :-</td>
            </tr>
        </table>
        </center>
        
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            <br />
        <table align="left" border="0" cellpadding="2" cellspacing="1" class="boxbg" style="width: 98%;
            background-color: #808080">
            <tr class="bgbluegrey">                
                <td>
                    <label class="blackfnt">
                        Bill No</label></td>
                <td>
                    <label class="blackfnt">
                        Bill Date</label></td>
                <td>
                    <label class="blackfnt">
                        Bill Amount</label></td>
                <td>
                    <label class="blackfnt">
                        TDS</label></td>
                <td>
                    <label class="blackfnt">
                        Freight Rebate</label></td>
                <td>
                    <label class="blackfnt">
                        Claim</label></td>
                <td>
                    <label class="blackfnt">
                        Net Recd. Amount </label></td>                
            </tr>
            <asp:Repeater ID="rptBillDetails" runat="server">
                <ItemTemplate>
                    <tr style="background-color: White">
                        
                        <td>
                            <label class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Bill_No")%>
                            </label>
                        </td>
                        <td>
                            <label class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Bill_Date")%>
                            </label>
                        </td>
                        <td>
                            <label class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Bill_Amount")%>
                            </label>
                        </td>
                        <td>
                            <label class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "TDS")%>
                            </label>
                        </td>
                        <td>
                            <label class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Freight")%>
                            </label>
                        </td>
                        <td>
                            <label class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Claim")%>
                            </label>
                        </td>
                        <td>
                            <label class="blackfnt">
                                <%#DataBinder.Eval(Container.DataItem, "Amount")%>
                            </label>
                        </td>                        
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
            <tr id="trForTotalValues" runat="server" style="background-color: #ffffff">
                <td align="right" colspan="2">
                    <label class="blackfnt">
                        <b>Total : </b>
                    </label>
                </td>
                <td>
                    <center>
                        <asp:Label ID="lblBillAmt" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
                </td>                
                <td>
                    <center>
                        <asp:Label ID="lblTDS" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
                </td>
                <td>
                    <center>
                        <asp:Label ID="lblFreight" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
                </td>
                <td>
                    <center>
                        <asp:Label ID="lblClaim" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
                </td>
                <td>
                    <center>
                        <asp:Label ID="lblAmount" runat="server" CssClass="blackfnt" Font-Bold="true">
                                                                            </asp:Label></center>
                </td>                
            </tr>
        </table>
        </center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
   
       
        <table align="center" id="tblNoRecords" runat="server" border="0" cellpadding="2"
            cellspacing="1" class="boxbg" style="width: 98%; background-color: #808080" visible="false">
            <tr style="background-color: #ffffff">
                <td align="left" colspan="22" style="width: 892px; height: 23px">
                    <div align="center">
                        <label class="blackfnt" style="color: #ff0000">
                            No Record Found
                        </label>
                    </div>
                </td>
            </tr>
        </table>
        </center>
    </div>
        <br />
        Note : Cheque/D. D. are subject to Reliasation &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp;
        FOR RAHUL CARGO PVT. LTD.<br />
        <br />
        <br />
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        &nbsp;&nbsp;
        CUSTOMER COPY
    </form>
</body>
</html>
