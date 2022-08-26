<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="GUI_SFM_Main" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <!--Atlas Script Manager -->
    <table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Sales Force Management Operation" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
    
    <br />
    <table border="0" cellpadding="4" cellspacing="1" class="boxbg" style="width: 288px; height: 8px;">
                        <tr>
                            <td align="center" class="bgbluegrey" style="height: 9px" >
                                <font class="blackfnt"><strong>Sales Force Management Module</strong></font></td>
                        </tr>
                    </table>
        <br />
        
        <table style="width: 288px" frame="box">
                        <tr>
                        <td height="15" bgcolor="#ffffff" style="width: 6%"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
                            <td style="height: 21px">
                           
                                             <a href="./SFM/ProspectReg_Step1.aspx"><font class="bluelink">Register New prospect</font></a>
                            </td>
                           
                        </tr>
                         <tr><td height="15" bgcolor="#ffffff" style="width: 6%"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
                            <td style="height: 21px">
                           
                                             <a href="./SFM/CallReg_inter.aspx"><font class="bluelink">Enter New
                                             <%=callvisit%> Details</font></a>
                            </td>
                           
                        </tr>
                       <%-- <tr><td height="15" bgcolor="#ffffff" style="width: 6%">
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
                            <td style="height: 21px">
                           
                                             <a href="#"><font class="bluelink">Contract Entry/ Update</font></a>
                            </td>
                           
                        </tr>--%>
                        
                         <tr><td height="15" bgcolor="#ffffff" style="width: 6%"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
                            <td style="height: 21px">
                           
                                             <a href="./SFM/SalesTarget1.aspx"><font class="bluelink">Sale Target Entry</font></a>
                            </td>
                           
                        </tr>
                        
                         <tr><td height="15" bgcolor="#ffffff" style="width: 6%"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
                            <td style="height: 21px">
                           
                                             <a href="./SFM/AppointmentEntry1.aspx"><font class="bluelink">Appointment Entry</font></a>
                            </td>
                           
                        </tr>
                       
                    </table>
                    
                    
                    <br />
                    
                    
                    
                    <table style="width: 288px" frame="box">
                        <tr>
                       <%-- <td height="15" bgcolor="#ffffff" style="width: 6%"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
                            <td style="height: 21px">
                           
                                             <a href="ProspectReg_Step1.aspx"><font class="bluelink">Contract Update</font></a>
                            </td>
                           
                        </tr>--%>
                         <tr><td height="15" bgcolor="#ffffff" style="width: 6%">
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr>
					                      <td class="bullet"><img alt="" src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
                            <td style="height: 21px">
                           
                                             <a href="./SFM/ApppointmentReschedule1.aspx"><font class="bluelink">Reschedule/Cancel Appointment</font></a>
                            </td>
                           
                        </tr>
                        <tr><td id="reassign1" runat="server" height="15" bgcolor="#ffffff" style="width: 6%"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
                            <td id="reassign2" runat="server" style="height: 21px">
                           
                                             <a href="./SFM/ProspectReassign.aspx"><font class="bluelink">Reassign Prospect</font></a>
                            </td>
                           
                        </tr>
                        
                         
                       
                    </table>
                    
                    
                    <br />
                    
                    
                    
                    <table style="width: 288px" frame="box">
                        <tr>
                        <td height="15" bgcolor="#ffffff" style="width: 6%"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
                            <td style="height: 21px">
                           
                                             <a href="./SFM/ProspectRegStateSub.aspx"><font class="bluelink">Prospect Status & Submission</font></a>
                            </td>
                           
                        </tr>
                         <tr><td id="approval1" runat="server" height="15" bgcolor="#ffffff" style="width: 6%"> 
					                  <table border="0" cellspacing="0" cellpadding="0">
					                    <tr> 
					                      <td class="bullet"><img src="../images/clear.gif" width="4" height="4"></td>
					                    </tr>
					                  </table> </td>
                            <td id="approval2" runat="server" style="height: 21px">
                           
                                             <a href="./SFM/ProspectApproval1.aspx"><font class="bluelink">Prospect Approval</font></a>
                            </td>
                           
                        </tr>
                       
                    </table>
</asp:Content>
