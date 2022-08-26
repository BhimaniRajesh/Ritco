<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="Docket_submit_done.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_Docket_submit_done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script  language="javascript" type="text/javascript">
 function popupmenu2()
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  dockno="<%=dockno%>"
  confirmWin=window.open('DocketPrint/DocketView_xls.aspx?dockno=' + dockno + '&docksf=.',"",winOpts);
 }
 function popupmenu1()
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var mrno="<%=mrno%>,0";
      confirmWin=window.open('DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno='+ mrno,"",winOpts);
 }
 function popupmenuPrint()
 {
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var mrno="<%=mrno%>,1";
      confirmWin=window.open('DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno='+ mrno,"",winOpts);
 }
 </script>
 <br /><br />
 
<div align="left" style="width:9.5in;">
    <font class="blklnkund"><strong>Module</strong><strong> &gt; </strong>
  <strong>Operation</strong></font>&gt;
  <font class="bluefnt"><strong> <%=dkt_call %> Entry </strong> </font>
  
   

   <table style="width:9.5in;" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  
     <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>

        <tr> 
          <td align="right"><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr><td>
        
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg">
       <tr  class="bgbluegrey" style="height:25px">
           <td align="center" colspan="4" style="height: 25px">
               <font class="blackfnt"><b> Following document has been successfully generated:</b></font></td>
            
       </tr>
        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
            <td colspan="2"  align="left" nowrap ><font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;<%=dkt_call %> Name&nbsp;&nbsp;&nbsp;&nbsp;</font>
            </td>
            <td style="width: 398px" align="center" ><font class="blackfnt"><%=dkt_call %> Number</font>
            </td>
            <td style="width: 339px">
            </td>
        </tr>
        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
            <td colspan="2"  align="center" >
                <font class="blackfnt"  ><%=dkt_call %></font></td>
            <td style="width: 398px"  align="center">
                <asp:Label ID="cnno" runat="server"  CssClass="blackfnt" Width="313px"></asp:Label></td>
            <td style="width: 339px" align="center">
                <a href="javascript:popupmenu2()" runat="server" id="ankone"><u>View</u></a>
            </td>
        </tr>
        <%if (mrno != "")
          { %>
        <tr bgcolor="white" id="trmr" runat="server" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
            <td colspan="2"  align="center" >
                <font class="blackfnt">MR</font></td>
            <td style="width: 398px"  align="center">
               <asp:Label ID="mrsno" runat="server"  CssClass="blackfnt" Width="313px"></asp:Label>
            </td>
            <td style="width: 339px" align="center"><a href="javascript:popupmenu1()" runat="server" id="a1"><u>View</u></a>|<a href="javascript:popupmenuPrint()" runat="server" id="a2"><u>Print</u></a>
            </td>
        </tr>
        <%} %>
        <tr  class="bgbluegrey" style="height:25px; font-size: 12pt; font-family: Times New Roman;">
            <td align="left" colspan="4">
             <strong><span style="font-size: 8pt; font-family: Verdana">Your Next Step</span></strong></td>
           </tr>
       <tr  bgcolor="#FFFFFF"> 
              <td bgcolor="#FFFFFF" align="center" style="width: 9185px; height: 25px"> 
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                            <td align="center" class="bullet"><img src="../../../images/clear.gif" width="4" height="4"  /></td>
                        </tr>
                    </table>
              </td>
              <td width="100%" align="left" bgcolor="#FFFFFF" colspan="5" style="height: 25px">
                    <font class="blackfnt"><u><a href="docket.aspx"><font class="blklnkund">Click here to More <%=dkt_call %> Entry</a></u></font>
              </td>
      </tr>
      <tr  bgcolor="#FFFFFF"> 
              <td bgcolor="#FFFFFF" style="width: 9185px; height: 25px"> 
                    <table border="0" align="center" cellspacing="0" cellpadding="0">
                        <tr> 
                            <td align="center" class="bullet"><img src="../../../images/clear.gif" width="4" height="4"  /></td>
                        </tr>
                    </table>
              </td>
              <td width="100%" align="left" bgcolor="#FFFFFF" colspan="5" style="height: 25px">
                    <font class="blackfnt"><u><a href="../../Operations/LoadingSheet/LSMain.aspx"><font class="blklnkund">Prepare New Loading Sheet Entry</a></u></font>
              </td>
      </tr>
      <tr  bgcolor="#FFFFFF"> 
              <td bgcolor="#FFFFFF" align="center" style="width: 9185px; height: 25px"> 
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr> 
                            <td align="center" class="bullet"><img src="../../../images/clear.gif" width="4" height="4"  /></td>
                        </tr>
                    </table>
              </td>
              <td width="100%" align="left" bgcolor="#FFFFFF" colspan="5" style="height: 25px">
                    <font class="blackfnt"><u><a href="../../Operations/ManiFest/MFMain.aspx"><font class="blklnkund">Generate Manifest without Preparing Loading Sheet </a></u></font>
              </td>
      </tr>

        
       </table>
    </td>
        </tr>
       </table>
       </div>


</asp:Content>
