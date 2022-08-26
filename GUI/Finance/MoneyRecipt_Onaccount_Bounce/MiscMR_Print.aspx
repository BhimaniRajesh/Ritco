<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MiscMR_Print.aspx.cs" Inherits="GUI_Finance_MoneyRecpt_MiscMR_Print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Msc MR View/Print</title>
    <link href ="../../images/style.css" rel="stylesheet" type="text/css" />
</head>

<body style="color: #000000">
    <form id="form1" runat="server">
    <div>
    <% 

string mode = Request.QueryString.Get("mode");

string boxbg = "boxbg";
string bgbluegrey = "bgbluegrey";
string strborder = "border='0'";
if (mode == "1")
{
boxbg = "";
bgbluegrey = "bgwhite";
strborder = "border='1'";

%>
<script language="javascript" type="text/javascript">

function loadme()
{
window.print();
}
window.load =loadme()
</script>



<%
}
%>

    </div>
    <div>
        <table align="left" border="0" cellpadding="0" cellspacing="0" width="900">
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellpadding="0" cellspacing="1" class="<%=boxbg %>" style="background-color: white;
                        text-align: center" width="100%">
                        <tr>
                            <td style="height: 30px">
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr style="font-weight: bold; font-size: 12pt; color: #000000; font-family: Times New Roman">
                            <td style="text-align: right">
                                </td>
                        </tr>
                        <tr style="font-size: 12pt; color: #000000; font-family: Times New Roman">
                            <td style="text-align: center">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td style="width: 39%; text-align: left" valign="top">
                                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td style="text-align: center">
                                                        <table border="1" cellpadding="3" cellspacing="1" class="<%=boxbg %>" style="text-align: center"
                                                            width="95%">
                                                            <tr class="<%=bgbluegrey%>">
                                                                <td align="center" colspan="4" valign="top">
                                                                    <strong><span>MR Summary</span></strong></td>
                                                            </tr>
                                                            <tr style="color: #ff0000; background-color: #ffffff">
                                                                <td class="blackfnt" style="width: 20%; text-align: left">
                                                                    <span style="color: #000000">
                                                                    MR No.</span></td>
                                                                <td class="blackfnt" style="text-align: left">
                                                                    <b><span style="color: #000000">
                                                                        <asp:Label ID="lblMrNo" runat="server" Font-Bold="False"></asp:Label></span></b></td>
                                                                <td class="blackfnt" style="width: 20%; color: #000000; text-align: left">
                                                                    Date</td>
                                                                <td class="blackfnt" style="text-align: left"><%=MrsDate%>
                                                                    <%--<a id="anchor101" href="#" name="anchor101" onclick="cal.select(ctl00$MyCPH1$txtmrdt,'anchor101','dd/MM/yyyy'); return false;"></a>--%><%--<asp:RequiredFieldValidator
                                                       ID="RFVFromDate" runat="server" ControlToValidate="txtmrdt" CssClass="blackfnt"
                                                       ErrorMessage="Date cannot be blank :(" ValidationGroup="VGDtFromTo"></asp:RequiredFieldValidator><asp:RegularExpressionValidator
                                                           ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtmrdt" ErrorMessage="Invalid Date "
                                                           ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"
                                                           ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>--%></td>
                                                            </tr>
                                                            <tr style="background-color: #ffffff">
                                                                <td class="blackfnt" style="width: 20%; text-align: left">
                                                                    MR Type</td>
                                                                <td class="blackfnt" style="text-align: left">
                                                                    Misc. MR</td>
                                                                <td class="blackfnt" style="width: 20%; text-align: left">
                                                                    MR Branch
                                                                </td>
                                                                <td class="blackfnt" style="text-align: left"><%=BranchCode %>
                                                                    : <%=BranchName %><strong> </strong>
                                                                    </td>
                                                            </tr>
                                                            <tr style="background-color: #ffffff">
                                                                <td class="blackfnt" style="text-align: left">
                                                                    Party
                                                                </td>
                                                                <td class="blackfnt" colspan="1" style="text-align: left">
                                                                    <%--  <asp:Button runat="server" ID="branchpopup" Text="..."   />--%>
                                                                    <%=PartyCode%> : <%=PartyName %>
                                                                </td>
                                                                <td class="blackfnt" style="text-align: left" valign="top">
                                                                    Cnote No<strong> </strong>
                                                                </td>
                                                                <td class="blackfnt" colspan="1" style="font-weight: bold; text-align: left" valign="top">
                                                                    <%=DockNo%> <%=DockSf %>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <br />
                                                        <div style="text-align: center">
                                                            <center>
                                                                <table border="1" cellpadding="3" cellspacing="1" class="<%=boxbg %>" width="95%">
                                                                    <tr class="<%=bgbluegrey%>">
                                                                        <td align="center" class="blackfnt" colspan="4" valign="top">
                                                                            <strong>Collection Details</strong></td>
                                                                    </tr>
                                                                    <tr style="background-color: #ffffff">
                                                                        <td class="blackfnt" style="text-align: left" valign="top">
                                                                            Request Door Delivery Charges(+)</td>
                                                                        <td class="blackfnt" style="text-align: right" valign="top"><%=DDCharge%>&nbsp;
                                                                            </td>
                                                                        <td class="blackfnt" style="text-align: left">
                                                                            TDS rate (%)</td>
                                                                        <td class="blackfnt" style="text-align: right"><%=TDSRate %>&nbsp;
                                                                            </td>
                                                                    </tr>
                                                                    <tr style="background-color: #ffffff">
                                                                        <td class="blackfnt" style="width: 197px; text-align: left" valign="top">
                                                                            Demurrage Charges (+)</td>
                                                                        <td class="blackfnt" style="text-align: right" valign="top"><%=DemCharge %>&nbsp;
                                                                            </td>
                                                                        <td class="blackfnt" style="text-align: left">
                                                                            TDS Amount(-)</td>
                                                                        <td class="blackfnt" style="text-align: right"><%=TDSAmt %>&nbsp;
                                                                            </td>
                                                                    </tr>
                                                                    <tr style="background-color: #ffffff">
                                                                        <td class="blackfnt" style="width: 197px; text-align: left" valign="top">
                                                                            Ware House Charges (+)</td>
                                                                        <td class="blackfnt" style="text-align: right" valign="top"><%=WareCharge %>&nbsp;
                                                                            </td>
                                                                        <td class="blackfnt" style="text-align: left">
                                                                            Other Deduction (-)</td>
                                                                        <td class="blackfnt" style="text-align: right"><%=OtherDed %>&nbsp;
                                                                            </td>
                                                                    </tr>
                                                                    <tr style="font-weight: bold; background-color: #ffffff">
                                                                        <td class="blackfnt" style="width: 197px; text-align: left" valign="top">
                                                                            Mathadi Charges (+)</td>
                                                                        <td class="blackfnt" style="text-align: right" valign="top"><%=MathadiCharge %>&nbsp;
                                                                            </td>
                                                                        <td style="text-align: left">
                                                                        </td>
                                                                        <td class="blackfnt" style="text-align: right">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="font-weight: bold; background-color: #ffffff">
                                                                        <td class="blackfnt" style="width: 197px; text-align: left" valign="top">
                                                                            Other Charges (+)</td>
                                                                        <td class="blackfnt" style="text-align: right" valign="top"><%=OtherCharge %>&nbsp;
                                                                            </td>
                                                                        <td style="text-align: left">
                                                                        </td>
                                                                        <td class="blackfnt" style="text-align: right">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="background-color: #ffffff">
                                                                        <td class="blackfnt" style="width: 197px; text-align: left" valign="top">
                                                                            <strong>Total</strong></td>
                                                                        <td class="blackfnt" style="text-align: right" valign="top"><%=SubTot %>&nbsp;
                                                                            </td>
                                                                        <td class="blackfnt" style="text-align: left">
                                                                            <strong>Net Amount</strong></td>
                                                                        <td class="blackfnt"  style="font-weight: bold;text-align: right"><%=NetAmt %>&nbsp;
                                                                            </td>
                                                                    </tr>
                                                                    <tr style="background-color: #ffffff">
                                                                        <td class="blackfnt" style="width: 197px; text-align: left" valign="top">
                                                                            Mode Of Transaction 
                                                                        </td>
                                                                        <td class="blackfnt" style="text-align: left" valign="top"><%=MadeTrans %>
                                                                        </td>
                                                                        <td class="blackfnt" style="text-align: left">
                                                                        </td>
                                                                        <td class="blackfnt" style="font-weight: bold; text-align: right">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="background-color: #ffffff">
                                                                                    <td colspan="4" valign="top" style="height: 24px">
                                                                                        <div align="center">
                                                                                            <font class="blackfnt"><b></b>Cheque /DD Details</font></div>
                                                                                        </td>
                                                                                </tr>
                                                                    <tr style="background-color: #ffffff" >
                                                                     <td colspan="4" valign="top">
                                                                            
                                                                                        <table align="center" border="1"   cellpadding="1" cellspacing="1" width="100%" class="<%=boxbg %>">
                                                                                            <tr class="<%=bgbluegrey%>">
                                                                                                <td>
                                                                                                    <div align="center">
                                                                                                        <font class="blackfnt">Cheque
                                                                                                            <br />
                                                                                                            Number</font></div>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <div align="center">
                                                                                                        <font class="blackfnt">Cheque Date</font></div>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <div align="center">
                                                                                                        <font class="blackfnt">Cheque Amount</font></div>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <div align="center">
                                                                                                        <font class="blackfnt" color="red"><span style="color: #000000">On Acct. Balance Rs.
                                                                                                        </span></font>
                                                                                                    </div>
                                                                                                </td>
                                                                                                <td style="color: #000000">
                                                                                                    <div align="center">
                                                                                                        <font class="blackfnt"><span>Amount to be<span style="text-decoration: underline">
                                                                                                            <br />
                                                                                                        </span></span>accounted</font></div>
                                                                                                </td>
                                                                                                <td style="color: #000000">
                                                                                                    <div align="center">
                                                                                                        <font class="blackfnt">Bank name</font></div>
                                                                                                </td>
                                                                                                <td style="color: #000000">
                                                                                                    <div align="center">
                                                                                                        <font class="blackfnt">Bank Branch</font></div>
                                                                                                </td>
                                                                                            </tr>
                                                                                            
                                                                                            <tr bgcolor="white" style="color: #000000">
                                                                                                <td align="center"><font class="blackfnt"><%=ChkNo %></font>
                                                                                                    </td>
                                                                                                <td align="center"><font class="blackfnt"> <%=ChkDate %></font>
                                                                                                </td>
                                                                                                <td align="center"><font class="blackfnt"><%=ChkAmt %>    </font>                                                                                                
                                                                                                </td>
                                                                                                <td align="center"><font class="blackfnt"><%=OnAcctAmt %></font>
                                                                                                </td>
                                                                                                <td align="center"><font class="blackfnt"><%=AccAmt %></font>
                                                                                                </td>
                                                                                                <td align="center"><font class="blackfnt"><%=BnkName %></font>
                                                                                                </td>
                                                                                                <td align="center"><font class="blackfnt"><%=BnkBranch %></font>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                               
                                                                    </tr>
                                                                    <tr style="background-color: #ffffff; color: #000000;">
                                                                        <td class="blackfnt" style="width: 197px; text-align: left" valign="top">
                                                                            TDS type</td>
                                                                        <td class="blackfnt" colspan="3" style="text-align: left" valign="top"><%=TDSType %>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="background-color: #ffffff; color: #000000;">
                                                                        <td class="blackfnt" style="width: 197px; text-align: left" valign="top">
                                                                            Collected Amount</td>
                                                                        <td class="blackfnt" colspan="3" style="text-align: left" valign="top"><%=CollAmt %>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="background-color: #ffffff; color: #000000;">
                                                                        <td class="blackfnt" style="width: 197px; text-align: left" valign="top">
                                                                            Remark</td>
                                                                        <td class="blackfnt" colspan="3" style="text-align: left" valign="top"><%=Remark %>
                                                                           </td>
                                                                    </tr>
                                                                </table>
                                                            </center>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
