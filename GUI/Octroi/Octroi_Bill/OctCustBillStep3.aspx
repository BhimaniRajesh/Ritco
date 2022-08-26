<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="OctCustBillStep3.aspx.cs" Inherits="octroi_OctCustBillStep2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
 <script language="javascript" type="text/javascript">
    
        function ViewPrint(arg1,arg2)
        {
            window.open("./octroibill_viewprint.aspx?billno=" + arg1 + "&printyn=" + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
        }
        
    </script>
    <br />
    <table align="left" style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Finance</b></font> </a><b>&gt; </b><a><font class="blklnkund"><b>Octroi</b></font>
                        <b>&gt; </b></a><a><font class="bluefnt"><b>Prepare Octroi Bill </b></font></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <br />
    <br />
    <div style="width: 9in">
        <table border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 60%"
            align="left">
            <tr class="bgbluegrey">
                <td colspan="3" align="center" style="height: 21px">
                    <asp:Label ID="lblQry" CssClass="bluefnt" Font-Bold="True" runat="server">Following Document has Successfully Generated/Updated</asp:Label>
                </td>
            </tr>
            <tr bgcolor="white" style="height: 25px">
                <td style="width: 420px">
                    <font class="blackfnt">Document Name</font></td>
                <td style="width: 188px" colspan="2">
                    <font class="blackfnt">
                        <p align="left">
                            <font class="blackfnt">Document No.</font></p>
                    </font>
                </td>
            </tr>
            <tr bgcolor="white" style="height: 25px">
                <td style="width: 420px">
                    <font class="blackfnt"><strong>Octroi Bill </strong></font>
                </td>
                <td>
                    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true">
                       
                    </asp:Label></td>
                <%--    <td>
                    <asp:LinkButton ID="ln1" Text="View" CssClass="bluefnt" Font-Bold="true" Font-Underline="true"
                        OnClick="view" runat="server"></asp:LinkButton>
                    |
                    <asp:LinkButton ID="ln2" Text=" Print" CssClass="bluefnt" Font-Bold="true" Font-Underline="true"
                        OnClick="print" runat="server"></asp:LinkButton>
                </td>--%>
                <td>
                     <label class="blackfnt">
                            <%-- <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"mr_summ_popup.aspx?mrsno="+DataBinder.Eval(Container.DataItem, "mrn")+"&printyn=1"%>'
                            Text='Print' ID="Hyperlink3" />--%>
                            <a href="Javascript:ViewPrint('<%=blno%>',0)">View </a>
                            /<a href="Javascript:ViewPrint('<%=blno%>',1)">Print </a>
                        </label>
                </td>
            </tr>
        </table>
        <center>
            &nbsp;</center>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <%--<font class="bluefnt"><b>You Can Do The Following.... </b></font>
    <table border="0" cellpadding="0" cellspacing="1" class="boxbg" style="width: 60%"
        align="left">
        <tr bgcolor="white" style="height: 25px">
            <td colspan="2" align="center">
                <font class="blackfnt"><b>Bill </b></font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td align="center" valign="middle">
                            <font class="bluefnt"><b></b></font>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <a href="../Octroi_Bill/octCustBillStep1.aspx"><font class="blklnkund">Prepare Octroi Bill
                </font></a>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <font class="blklnkund">Bill Submission </font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <font class="blklnkund">Bill Collection </font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src=" ../../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <font class="blklnkund">Bill Cancellation </font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src=" ../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <font class="blklnkund">Bill Entry Cancellation </font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td colspan="2" align="center">
                <font class="blackfnt"><b>MR</b></font></td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <a href="../Octroi_MR/Query.aspx"><font class="blklnkund">Prepare Manual Octroi MR</font></td>
        </tr>
        <%--  <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px"><font class="blklnkund">Update 
                              Manual Octroi MR</font></td>
       </tr>--%>
        <%--
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px; height: 25px;" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px; height: 25px;">
                <a href="../Octroi_Bill/update_Manual_MR_1.aspx"><font class="blklnkund">Update Maual MR
                </font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <font class="blklnkund">Manual Octroi MR Cancellation</font></td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <a href="../Octroi_Bill/Direct_Agent_Voucher.aspx"><font class="blklnkund">Prepare Direct
                    Octroi Payment </font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td colspan="2" align="center">
                <font class="blackfnt"><b>View &amp; Print</b></font>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <a id="A1" runat="server" href="../ViewnPrint/OctroiBill_Step1.aspx"><font class="blklnkund">
                    View & Print Octroi Bills</font></a>
            </td>
        </tr>
        <tr bgcolor="white" style="height: 25px">
            <td style="width: 17px" align="center">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="bullet">
                            <img src="../../images/clear.gif" width="4" height="4" /></td>
                    </tr>
                </table>
            </td>
            <td style="width: 339px">
                <a id="A2" runat="server" href="../ViewnPrint/ManualOctroiMr_Step1.aspx"><font class="blklnkund">
                    View & Print Octroi MRs</font></a></td>
        </tr>
    </table>--%>
    </div>
    <br />
    <br />
    <br />
</asp:Content>
