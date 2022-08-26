<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"    AutoEventWireup="true" CodeFile="UpdateMR_Done.aspx.cs" Inherits="GUI_Finance_MoneyRecipt_UpdateMR_Done" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script  language="javascript" type="text/javascript">
 
 function popupmenu1(mrsno)
 { 
     // alert(mrsno)
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
     
      confirmWin=window.open('../../Operation/Singlescreen_docketentry/DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno='+ mrsno,"",winOpts);
 }
 </script>
 <div>
     <table width="10in" border="0" cellpadding="0" cellspacing="0" align="left">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><b><a href="../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
 
   <a href="#"><font class="blklnkund"><strong>Finance</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		   Update MR  
		   
		  </strong> </font>
   </td></tr>
    <%-- <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>--%>

        <%--<tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr>--%>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>
   
    <tr>
    <td>
        <asp:Table  id="documentdetail" border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:6in"  align="Center" runat="server">
       </asp:Table>
       </td>
        </tr>
        </table>
        </div>
        
</asp:Content>
