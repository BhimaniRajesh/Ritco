<%@ Page Language="C#" AutoEventWireup="true" CodeFile="viewPrintpopup.aspx.cs" Inherits="GUI_UNI_MIS_MR_Summary_MR_Summ_Popup" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../images/style.css" rel="stylesheet" type="text/css" />
    <%--<script language ="javascript" type="textjavascript">window.onload = window.print()</script>--%>
</head>
<body>
    <center>
        <form id="form1" runat="server">
            <div>
                <% 
    
                    string strGenerateBillNo = Request.QueryString.Get("billno");
                    string[] Split = strGenerateBillNo.Split(new Char[] { ',' });
                    string GenerateBillNo = Convert.ToString(Split[0]);
                    string print_yn = Convert.ToString(Split[1]);
                    string boxbg = "boxbg";
                    string bgbluegrey = "bgbluegrey";
                    string strborder = "border='0'";
                    if (print_yn == "1")
                    {
                        boxbg = "";
                        bgbluegrey = "bgwhite";
                        strborder = "border='1'";
                  
                %>
                <script language="javascript" type="text/javascript">

                    function loadme() {
                        window.print();
                    }
                    window.load = loadme()
                </script>



                <%
                    }            
                %>
            </div>
            <div>
                <font face="verdana" size="3"><b>
                    <br />
                </b></font>
                <br />
                <br />
                <table border="0" width="900" align="left">
                    <tr>
                        <td>
                            <table border="0" cellspacing="1" cellpadding="2" width="90%">
                                <tr bgcolor="white">
                                    <td colspan="4" align="left" class="blackfnt">
                                        <img id="imgLogo" runat="server" height="90" width="150" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="1" cellspacing="1" cellpadding="2" width="90%" class="<%=boxbg%>" style="background-color: #8ba0e5">


                                <tr class="<%=bgbluegrey%>">
                                    <td colspan="4" align="center" class="blackfnt">
                                        <label id="lblParameter" class="blackfnt">
                                            <b>Bill Summary</b>
                                        </label>
                                    </td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td align="left">
                                        <label id="lblCustCode" class="blackfnt">
                                            Bill No</label></td>
                                    <td align="left">
                                        <asp:Label ID="lblBillno" runat="server" CssClass="blackfnt"></asp:Label></td>
                                    <td align="left" style="width: 78px" class="blackfnt">Manual Bill No</td>
                                    <td align="left" class="blackfnt"><%=ManualBillno%></td>

                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td align="left">
                                        <label id="lblCustName" class="blackfnt">
                                            From Date</label></td>
                                    <td align="left" class="blackfnt"><%=FromDt%>                        
                                    </td>

                                    <td align="left" class="blackfnt">To Date</td>
                                    <td align="left" class="blackfnt"><%=ToDt%></td>

                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td align="left" class="blackfnt" style="height: 20px">Bill Date</td>
                                    <td align="left" class="blackfnt" style="height: 20px"><%=BillDt%></td>
                                    <td align="left" class="blackfnt" style="height: 20px">Due Date</td>
                                    <td align="left" class="blackfnt" style="height: 20px"><%=DueDt%></td>

                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td align="left" class="blackfnt">Party</td>
                                    <td align="left" class="blackfnt"><%=partyno%></td>
                                    <td align="left" class="blackfnt" style="height: 20px">Aggrement Number</td>
                                    <td align="left" class="blackfnt" style="height: 20px"><%=AggrementNo%></td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td align="left" class="blackfnt" style="height: 20px">Bill Sub. Branch</td>
                                    <td align="left" class="blackfnt" style="height: 20px"><%=billsubbrcd%></td>
                                    <td align="left" class="blackfnt" style="height: 20px">Bill Coll. Branch</td>
                                    <td align="left" class="blackfnt" style="height: 20px"><%=billcolbrcd%></td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="1" cellspacing="1" cellpadding="2" width="90%" class="<%=boxbg%>" style="background-color: #8ba0e5">
                                <tr class="<%=bgbluegrey%>">
                                    <td colspan="4" align="center" style="height: 20px" class="blackfnt">
                                        <label id="Label5" class="blackfnt">
                                            Bill Charage Details</label></td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td align="left" style="height: 23px" class="blackfnt">
                                        <label id="Label6" class="blackfnt">
                                            Vehicle Detention Charges</label></td>
                                    <td align="right" class="blackfnt"><%=vehdetchrg%></td>
                                    <td align="left" style="height: 23px" class="blackfnt">Ware Housing Charges</td>
                                    <td align="right" class="blackfnt"><%=warechrg%></td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td align="left" class="blackfnt">
                                        <label id="Label7" class="blackfnt">
                                            Disaster management charges</label></td>
                                    <td align="right" class="blackfnt"><%=dischrg%></td>
                                    <td align="left" class="blackfnt">Handling charges</td>
                                    <td align="right" class="blackfnt"><%=handchrg%></td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td align="left" class="blackfnt">Rental charges</td>
                                    <td align="right" class="blackfnt"><%=rentalcharg%>
                                    </td>
                                    <td align="left" class="blackfnt">Other charges</td>
                                    <td align="right" class="blackfnt"><%=othchrg%></td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td align="left" class="blackfnt">Service Tax</td>
                                    <td align="right" class="blackfnt"><%=servicetax%></td>
                                    <td align="left" class="blackfnt">Cess</td>
                                    <td align="right" class="blackfnt"><%=cesstax%></td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td align="left" class="blackfnt">HIgher Edu.Cess</td>
                                    <td align="right" class="blackfnt"><%=hedu_cess%></td>
                                    <td align="left" class="blackfnt">SB. Cess</td>
                                    <td align="right" class="blackfnt"><%=sbccess%></td>
                                </tr>
                                <tr style="background-color: #ffffff">
                                    <td align="left" class="blackfnt">Total</td>
                                    <td colspan="3" align="right" class="blackfnt"><%=total%></td>
                                </tr>
                                <%--<tr style="background-color: #ffffff"  visible="false">
                <td align="left" class="blackfnt">
                    Payment Mode</td>
                <td align="left" class="blackfnt">
                    </td>
                <td align="left" class="blackfnt">
                </td>
                <td align="left" class="blackfnt"><%=PayMode%></td>
            </tr>--%>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </center>
    <br />

</body>
</html>
