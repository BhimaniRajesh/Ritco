<%@ Page Language="C#"   MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="docket_operation.aspx.cs" Inherits="GUI_Operation_docket_operation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

    <div align="center" style="width:9.5in">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td align="left"><font class="blackfnt"><b><a href="../../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
   <a href="#"><font class="blklnkund"><strong>Operation</strong></font>    </a> 
   
   &gt; <font class="bluefnt"><strong>  
		 <%=Session["DocketCalledAs"].ToString() %> Operations
		   
		  </strong> </font>
   </td></tr>
     <tr> 
          <td><img src="../images/clear.gif" width="15" height="10"></td>
        </tr>

        <tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../images/back.gif" border=0></a></td>
        </tr>
        <tr> 
          <td><img src="../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr><td>
     <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:60%"  align="center">
       <tr bgcolor="white" style="height:25px">
            <td colspan="2" align="center"><font class="blackfnt"><b> <%=Session["DocketCalledAs"].ToString() %> Booking Operations </b></font></td>
            
       </tr>
       
<%--       <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px" align="left"><a href="Singlescreen_docketentry/QuickBookingDocket.aspx"><font class="blklnkund">Quick <%=Session["DocketCalledAs"].ToString() %> Entry</font></a></td>
       </tr>
       
         <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px" align="left"><a href="Singlescreen_docketentry/EditQuickDocket.aspx"><font class="blklnkund">Edit Quick <%=Session["DocketCalledAs"].ToString() %></font></a></td>
       </tr>--%>
       
       <tr bgcolor="white" style="height:25px">
            <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px" align="left"><a href="Singlescreen_docketentry/docket.aspx"><font class="blklnkund">Single Screen <%=Session["DocketCalledAs"].ToString() %> Entry</font></a></td>
            
       </tr>
        
        <tr bgcolor="white" style="height:25px">
         <td style="width: 17px"  align="center"><table border="0" cellspacing="0" cellpadding="0">
                                <tr> 
                                  <td class="bullet"><img src="../images/clear.gif" width="4" height="4"/></td>
                                </tr>
                              </table></td>
            <td style="width: 339px" align="left"><a href="#"><font class="blklnkund"><%=Session["DocketCalledAs"].ToString() %> Edit </font></a>
           </td>
           
       </tr>
       
        
       </table>
    </td>
        </tr>
       </table>
    </div></asp:Content>
    
