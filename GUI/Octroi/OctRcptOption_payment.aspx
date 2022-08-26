<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="OctRcptOption_payment.aspx.cs" Inherits="octroi_OctRcptOption" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
       
       <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:60%"  align="left">
       <tr bgcolor="white" style="height:25px">
            <td colspan="2" align="center"><font class="blackfnt"><b> Bill </b></font></td>
            
       </tr>
           <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px"><a href="Octroi_Bill/Agent_Bill_Entry.aspx"><font class="blklnkund">Prepare 
                           Agent Bill Entry </font></td>
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
           <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px"><a href="Agent_Voucher/Query.aspx"><font class="blklnkund">Prepare 
                           Agent Voucher (From Agent Bill) </font></td>
           </tr>
        <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px"><a href="Octroi_Bill/Direct_Agent_Voucher.aspx"><font class="blklnkund">Prepare 
                             Direct Octroi Payment </font></td>
       </tr>
        <tr bgcolor="white" style="height:25px">
            <td colspan="2" align="center"> <font class="blackfnt"><b>View &amp; Print</b></font> </td>
           
       </tr>
        <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px">
                <font class="blklnkund">
                    <u><a href="ViewnPrint/AgentBill_Step1.aspx">View & Print Octroi Bills</a></u>
                </font></td>
       </tr>
        <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px"><font class="blklnkund">
                        <u><a href="ViewnPrint/DirectVoucher_Step1.aspx">
                        View & Print Octroi MRs</a></u>
                        </font></td>
       </tr>
       </table>
    </asp:Content>
