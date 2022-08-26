<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MR_Summ_Popup.aspx.cs" Inherits="GUI_UNI_MIS_MR_Summary_MR_Summ_Popup" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
        
<head runat="server" >
    <title>Untitled Page</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body ><center>
    <form id="form1" runat="server">
    <div><font face=verdana size=3><b>
        Rahul Cargo Pvt. Ltd.<br />
    </b></font><br />
        <br />
        <table border="0" cellspacing="1" cellpadding="2" width="75%" style="background-color: #cc00ff">
        <tr class="bgbluegrey">
            <td colspan="4" align="center">
                <label id="lblParameter" >
                    MR Summary</label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left">
                <label id="lblCustCode" class="blackfnt">
                    MR No</label></td>
            <td align="left">
                <asp:Label ID="lblMRNo" runat="server" CssClass="blackfnt"></asp:Label></td>
            <td align="left" style="width: 78px" class="blackfnt">
                Date</td><td align="left" class="blackfnt"><%=MRSDT%></td>            
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left">
                <label id="lblCustName" class="blackfnt">
                    MR Type</label></td><td align="left" class="blackfnt"><%=MRSTYPE%>                        
                    </td>
            
            <td align="left" class="blackfnt">
                MR Branch</td><td align="left" class="blackfnt"><%=MRSBR%>&nbsp;&nbsp;&nbsp;<%=MRBRNNM%> </td>
            
        </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                    Docket No</td><td align="left" class="blackfnt"><%=DOCKNO%>&nbsp;&nbsp;&nbsp;<%=DOCKSF%></td>
                
                <td align="left" class="blackfnt">
                    Docket Date</td><td align="left" class="blackfnt"><%=DOCKDT%></td>
                
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                    Party</td><td colspan="3" align="left" class="blackfnt"><%=PTCD%>&nbsp;&nbsp;<%=PTNAME%></td>
                
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                    Booking Branch</td>
               <td align="left" class="blackfnt"><%=ORGNCD%>&nbsp;&nbsp;<%=DOCBKNM%></td>
                <td align="left" class="blackfnt">
                    Delivery Branch</td>
                <td align="left" class="blackfnt"><%=DESTCD%> &nbsp;&nbsp;<%=DOCDLNM%></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" style="height: 23px" class="blackfnt">
                    No. of Packages</td>
                <td align="left" class="blackfnt"><%=NOPKGS%></td>
                <td align="left" style="height: 23px" class="blackfnt">
                    Charged Weight</td>
                <td align="left" class="blackfnt"><%=CHRGWT%></td>
            </tr>
    </table>
        <br />
        <table border="0" cellspacing="1" cellpadding="2" width="75%" style="background-color: #cc00ff">
            <tr class="bgbluegrey">
                <td colspan="4" align="center" style="height: 20px" class="blackfnt">
                    <label id="Label5" class="blackfnt">
                        Collection Details</label></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" style="height: 23px" class="blackfnt">
                    <label id="Label6" class="blackfnt">
                        Freight Amount</label></td>
                <td align="left" class="blackfnt"><%=FrightAmount%></td>
                <td align="left" style="height: 23px" class="blackfnt">
                    TDS&nbsp; rate (%)</td>
                <td align="left" class="blackfnt"><%=TDSRate%></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                    <label id="Label7" class="blackfnt">
                        Service Tax(+)</label></td>
                <td align="left" class="blackfnt"><%=SerTad%></td>
                <td align="left" class="blackfnt">
                    TDS amount (-)</td>
                <td align="left" class="blackfnt"><%=TDSAmt%></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                </td>
                <td align="left" class="blackfnt">
                </td>
                <td align="left" class="blackfnt">
                    Other Deduction (-)</td>
                <td align="left" class="blackfnt"><%=OtherDedu%></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                    Total</td>
                <td align="left" class="blackfnt"><%=Total%></td>
                <td align="left" class="blackfnt">
                    Net Amount</td>
                <td align="left" class="blackfnt"><%=NetAmt%></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                    Payment Mode</td>
                <td align="left" class="blackfnt">
                    </td>
                <td align="left" class="blackfnt">
                </td>
                <td align="left" class="blackfnt"><%=PayMode%></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                    Collection Amount</td>
                <td colspan="3" class="blackfnt"><%=CollAmt%></td>
            </tr>
            <tr style="background-color: #ffffff">
                <td align="left" class="blackfnt">
                    Remark</td>
                <td colspan="3" align="left" class="blackfnt"><%=Remark%></td>
            </tr>
        </table>
    </div>
    </form>
    </center>
</body>
</html>
