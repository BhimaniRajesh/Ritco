<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="OctRcptOption.aspx.cs" Inherits="octroi_OctRcptOption" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
       
       <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:60%"  align="center">
       <tr bgcolor="white" style="height:25px">
            <td colspan="2" align="center"><font class="blackfnt"><b> Bill </b></font></td>
            
       </tr>
       <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px"><a href="Octroi_Bill/octCustBillStep1.aspx"><font class="blklnkund">Prepare Octroi Bill </font></a>
           </td>
            
       </tr>
        <tr bgcolor="white" style="height:25px">
         <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px"><font class="blklnkund">Bill Submission </font>
           </td>
           
       </tr>
        <tr bgcolor="white" style="height:25px">
        <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table> 
            </td>
            <td style="width: 339px">
            <font class="blklnkund">Bill Collection </font>
            </td>
            
       </tr>
        <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px">
            <font class="blklnkund">Bill Cancellation </font>
            </td>
       </tr>
        <tr bgcolor="white" style="height:25px">
            <td  colspan="2" align="center"><font class="blackfnt"><b>MR</b></font></td>
            
       </tr>
        <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px"><a href="Octroi_MR/Query.aspx"><font class="blklnkund">Prepare 
                              Manual Octroi MR</font></td>
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
            <td style="width: 339px"><font class="blklnkund"> 
                              Manual Octroi MR Cancellation</font></td>
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
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px"><a href="Octroi_Bill/Agent_Bill_Entry.aspx"><font class="blklnkund">Prepare 
                           Agent Bill Entry </font></td>
       </tr>
       
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
            <td style="width: 17px; height: 25px;"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px; height: 25px;"><a href="Octroi_Bill/update_Manual_MR_1.aspx"><font class="blklnkund"> 
                           Update Maual MR </font></td>
       </tr>
       <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px"><a href="Octroi_Bill/update_Manual_MR_1.aspx"><font class="blklnkund"> 
                           Update Maual MR </font></td>
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
            <td style="width: 339px"><font class="blklnkund">View 
                              & Print Octroi Bills</font></td>
       </tr>
        <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px"><font class="blklnkund">View 
                              & Print Octroi MRs</font></td>
       </tr>
       </table>
    </asp:Content>
