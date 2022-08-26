<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MR_Summ_Popup.aspx.cs" Inherits="GUI_UNI_MIS_MR_Summary_MR_Summ_Popup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <center>
        <form id="form1" runat="server">
        
        <% string tcno = Request.QueryString.Get("mrsno");
           string[] Split = tcno.Split(new Char[] { ',' });
           string THCNo = Convert.ToString(Split[0]);
           string print_yn = Convert.ToString(Split[1]);
           string boxbg = "boxbg";
           string bgbluegrey = "bgbluegrey";
           string strborder = "0";
           string strspace = "1";
           if (print_yn == "1")
           {
               boxbg = "";
               bgbluegrey = "bgwhite";
               strborder = "1";
           }

        %>
            <div align="left">
                <font size="3"><b><asp:Image Height="50" ID="imgLogo" runat="server" /><br />
                </b></font>
                <br />
                <br />
                <table border='<%=strborder %>' cellspacing="1" class='<%=boxbg %>' cellpadding="5" style="width: 7.5in">
                    <tr class='<%=bgbluegrey %>'>
                        <td colspan="4" align="center">
                            <label id="lblParameter" class="blackfnt">
                               <b>MR Summary</b></label></td>
                    </tr>   
                    <tr style="background-color: #ffffff">
                        <td align="left">
                            <label id="lblCustCode" class="blackfnt">
                                MR No</label></td>
                        <td align="left">
                            <asp:Label ID="lblMRNo" runat="server" CssClass="blackfnt"></asp:Label></td>
                        <td align="left" style="width: 78px" class="blackfnt">
                            Date</td>
                        <td align="left" class="blackfnt">
                            <%=MRSDT%>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td align="left">
                            <label id="lblCustName" class="blackfnt">
                                MR Type</label></td>
                        <td align="left" class="blackfnt">
                            <%=MRSTYPE%>
                        </td>
                        <td align="left" class="blackfnt">
                            MR Branch</td>
                        <td align="left" class="blackfnt">
                            <%=MRSBR%>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td align="left" class="blackfnt">
                            Party</td>
                        <td colspan="3" align="left" class="blackfnt">
                            <%=PTCD%>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td align="left" class="blackfnt">
                            Booking Branch</td>
                        <td align="left" class="blackfnt">
                            <%=bookbr%>
                        </td>
                        <td align="left" class="blackfnt">
                            Delivery Branch</td>
                        <td align="left" class="blackfnt">
                            <%=delbr%>
                        </td>
                    </tr>
                   
                </table>
                <br /><br />
                   <table border='<%=strborder %>' cellspacing="1" class='<%=boxbg %>' cellpadding="5" style="width: 7.5in">
                    <tr class='<%=bgbluegrey %>'>
                        <td align="center" class="blackfnt">
                            <label id="Label1" class="blackfnt">
                                CN. No.</label></td>
                        
                        
                        <td align="center" class="blackfnt">
                            <label id="Label3" class="blackfnt">
                               Octroi Amount</label></td>
                        
                        
                        <td align="center" class="blackfnt">
                            <label id="Label4" class="blackfnt">
                                Octroi (%)</label></td>
                        
                        
                        <td align="center" class="blackfnt">
                            <label id="Label8" class="blackfnt">
                               Clearance Charges</label></td>
                        
                        
                        <td align="center" class="blackfnt">
                            <label id="Label9" class="blackfnt">
                              Processing Charges(%)</label></td>
                        
                        
                        <td align="center" class="blackfnt">
                            <label id="Label10" class="blackfnt">
                             Processing Charges</label></td>
                        
                        
                        <td align="center" class="blackfnt">
                            <label id="Label11" class="blackfnt">
                         Other Charges</label></td>
                        
                        
                        <td align="center" class="blackfnt">
                            <label id="Label12" class="blackfnt">
                                S.Tax</label></td>
                        
                        
                        <td align="center" class="blackfnt">
                            <label id="Label13" class="blackfnt">
                               Cess</label></td>
                        
                        
                        <td align="center" class="blackfnt">
                            <label id="Label14" class="blackfnt">
                                Higher Edu. Cess</label></td>
                        
                        
                         <td align="center" class="blackfnt">
                            <label id="Label15" class="blackfnt">
                              Total</label></td>
                        
                        <td align="center" class="blackfnt">
                            <label id="Label16" class="blackfnt">
                               Reciept No.</label></td>
                        
                        <td align="center" class="blackfnt">
                            <label id="Label17" class="blackfnt">
                               Receipt Date </label></td>
                        
                         
                               
                    </tr>
                    <tr style="background-color: #ffffff">
                        
                        
                        <td align="left" class="blackfnt">
                            <%=DOCKNO%>
                        </td>
                        <td align="left" class="blackfnt">
                            <%=octamt%>
                        </td><td align="left" class="blackfnt">
                            <%=octper%>
                        </td><td align="left" class="blackfnt">
                            <%=clrchg%>
                        </td><td align="left" class="blackfnt">
                            <%=procper%>
                        </td><td align="left" class="blackfnt">
                            <%=procchg%>
                        </td><td align="left" class="blackfnt">
                            <%=othchg%>
                        </td><td align="left" class="blackfnt">
                            <%=stax%>
                        </td><td align="left" class="blackfnt">
                            <%=cess%>
                        </td><td align="left" class="blackfnt">
                            <%=hcess%>
                        </td><td align="left" class="blackfnt">
                            <%=Total%>
                        </td>
                        <td align="left" class="blackfnt">
                            <%=repno%>
                        </td>
                        <td align="left" class="blackfnt">
                            <%=repdt%>
                        </td>
                        </tr>
                     
                   </table>
             
                <br /><br />
                <table border='<%=strborder %>' cellspacing="1" class='<%=boxbg %>' cellpadding="5" style="width: 7.5in">
                     <tr class='<%=bgbluegrey %>'>
                        <td colspan="4" align="center" style="height: 20px" class="blackfnt">
                            <label id="Label5" class="blackfnt">
                                <b>Collection Details</b></label></td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td align="left" style="height: 23px" class="blackfnt">
                            <label id="Label6" class="blackfnt">
                                Other Amount</label></td>
                        <td align="left" class="blackfnt">
                            <%=FrightAmount%>
                        </td>
                        <td align="left" style="height: 23px" class="blackfnt">
                            TDS&nbsp; rate (%)</td>
                        <td align="left" class="blackfnt">
                            <%=TDSRate%>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td align="left" class="blackfnt">
                            Other Deduction (-)</td>
                        <td align="left" class="blackfnt">
                            <%=OtherDedu%>
                        </td>
                        <td align="left" class="blackfnt">
                            TDS amount (-)</td>
                        <td align="left" class="blackfnt">
                            <%=TDSAmt%>
                        </td>
                    </tr>
                    
                    <tr style="background-color: #ffffff">
                        <td align="left" class="blackfnt">
                            Total</td>
                        <td align="left" class="blackfnt">
                          
                        </td>
                        <td align="left" class="blackfnt">
                            Net Amount</td>
                        <td align="left" class="blackfnt">
                            <%=NetAmt%>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td align="left" class="blackfnt">
                            Cheque No</td>
                        <td align="left" class="blackfnt">
                            <%=ChequeNo%>
                        </td>
                        <td align="left" class="blackfnt">
                            Cheque Date</td>
                        <td align="left" class="blackfnt">
                            <%=ChequeDate%>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                     <td align="left" class="blackfnt">
                            Bank Name</td>
                        <td align="left" class="blackfnt">
                            <%=BankName%>
                        </td>
                        <td align="left" class="blackfnt">
                            Collection Amount</td>
                        <td align="left" class="blackfnt">
                            <%=CollAmt%>
                        </td>
                    </tr>
                    
                    <tr style="background-color: #ffffff">
                        <td align="left" class="blackfnt">
                            Remark</td>
                        <td colspan="3" align="left" class="blackfnt">
                            <%=Remark%>
                        </td>
                    </tr>
                   
                </table>
                <%
                if (print_yn == "1")
                {
         
            %>

            <script language="javascript" type="text/javascript">
       
        function loadme()
        {
            window.print();
        }
       window.load =loadme()
            </script>

            <%} %>
            </div>
        </form>
    </center>
</body>
</html>
