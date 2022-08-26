<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="rpt_main.aspx.cs" Inherits="GUI_SFM_rpt_main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table border="0" align="center" width="85%" cellspacing="1" bgcolor="#000000" cellpadding="4" class="boxbg">
  <tr class="bgbluegrey">
    <td width="80%" align="center"  height="18" colspan="4">
     <font class="blackfnt"> <font class="bluefnt"><b>Report
     </b></font></font></td>
  </tr>
  
   <tr  bgcolor="#ffffff">
    <td bgcolor="#ffffff" style="width: 13px"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img alt="" src="../images/clear.gif" width="4" height="4" /></td>
					                    </tr>
					                  </table> </td>
    <td align="left" bgcolor="#ffffff" style="width: 26%">
    <font class="blackfnt"><font class="blackfnt">Funnel Report</font></font>
    </td>
    <td align="left" bgcolor="#ffffff" style="width: 70%">
    <font class="blackfnt" color="#0000ff"><a href="./REPORT/sfm_funnel_report_loc_wise.aspx"><font class="blklnkund">Location Wise</font></a>&nbsp;
        &nbsp;</font>| &nbsp;
    <font class="blackfnt" color="#0000ff"><a href="./REPORT/sfm_funnel_report_Sale_wise.aspx"><font class="blklnkund">SalesPerson Wise</font></a></font>
     </td>
  </tr>
  
  <tr  bgcolor="#ffffff">
    <td bgcolor="#ffffff" style="width: 13px"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img alt="" src="../images/clear.gif" width="4" height="4" /></td>
					                    </tr>
					                  </table> </td>
   <td align="left" bgcolor="#ffffff" style="width: 26%">
    <font class="blackfnt">
    <%=callvisit%> Register</font>
    </td>
    <td align="left" bgcolor="#ffffff" style="width: 70%">
    <font class="blackfnt" color="#0000ff"><a href="./REPORT/CallRegister_CompanywiseReport.aspx"><font class="blklnkund">Company Wise</font></a>
        &nbsp;</font>|&nbsp;
    <font class="blackfnt" color="#0000ff"><a href="./REPORT/CallRegister_SalesPersonWiseReport.aspx"><font class="blklnkund">SalesPerson Wise</font></a></font>
     </td>
  </tr>
  
  
  <tr  bgcolor="#ffffff">
    <td bgcolor="#ffffff" style="width: 13px"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img alt="" src="../images/clear.gif" width="4" height="4" /></td>
					                    </tr>
					                  </table> </td>
    <td align="left" bgcolor="#ffffff" style="width: 26%">
    <font class="blackfnt"><%=callvisit%> Summary</font>
    </td>
    <td align="left" bgcolor="#ffffff" style="width: 70%">
    <font class="blackfnt" color="#0000ff"><a href="./REPORT/CallSummary_Locationwise1.aspx"><font class="blklnkund">Location Wise</font></a></font>&nbsp;
        &nbsp;|&nbsp;&nbsp;
    <font class="blackfnt" color="#0000ff"><a href="./REPORT/SalesSummary_SalesPerson.aspx"><font class="blklnkund">SalesPerson Wise</font></a></font>
     </td>
  </tr>
  <tr  bgcolor="#ffffff">
    <td bgcolor="#ffffff" style="width: 13px"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4" /></td>
					                    </tr>
					                  </table> </td>
    <td align="left" bgcolor="#ffffff" style="width: 26%">
    <font class="blackfnt"><font class="blackfnt">Sale Target</font></font></td>
    <td align="left" bgcolor="#ffffff" style="width: 70%">
    <font class="blackfnt" color="#0000ff"><a href="./REPORT/SaleTarget_Companywise1.aspx"><font class="blklnkund">Company Wise</font></a></font>&nbsp;
        | &nbsp;<font class="blackfnt" color="#0000ff"><a href="./REPORT/SaleTargetEmployeewise1.aspx"><font class="blklnkund">Employee Wise</font></a></font>
     </td>
  </tr>
  <tr  bgcolor="#ffffff">
    <td bgcolor="#ffffff" style="width: 13px"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img alt="" src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#ffffff" height="18" colspan="3"><font class="blackfnt" color="#0000ff"><a href="./REPORT/ProspectStatus1.aspx"><font class="blklnkund">Prospect Status</font></a></font></td>
  </tr>
   <tr  bgcolor="#ffffff">
    <td bgcolor="#ffffff" style="width: 13px"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img alt="" src="../images/clear.gif" width="4" height="4" /></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#ffffff" height="18" colspan="3"><font class="blackfnt" color="#0000ff"><a href="./REPORT/Prospect_RegisterReport.aspx"><font class="blklnkund">Prospect Register</font></a></font></td>
  </tr>
  <tr  bgcolor="#ffffff">
    <td bgcolor="#ffffff" style="width: 13px"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img alt="" src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#ffffff" height="18" colspan="3"><font class="blackfnt" color="#0000ff"><a href="./REPORT/AppointmentSchedule1.aspx"><font class="blklnkund">Appointment Schedule</font></a></font></td>
  </tr>
  <tr  bgcolor="#ffffff">
    <td bgcolor="#ffffff" style="width: 13px"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img alt="" src="../images/clear.gif" width="4" height="4" /></td>
					                    </tr>
					                  </table> </td>
    <td width="100%" align="left" bgcolor="#ffffff" height="18" colspan="3"><font class="blackfnt" color="#0000ff"><a href="./REPORT/ProspectHistory.aspx"><font class="blklnkund">Prospect History</font></a></font></td>
  </tr>
  
 </table>


</asp:Content>
