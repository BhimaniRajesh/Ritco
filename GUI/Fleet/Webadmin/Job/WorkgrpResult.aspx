<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master"    CodeFile="WorkgrpResult.aspx.cs" Inherits="GUI_Job_WorkgrpResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
<table>
<tr>
<td>

<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Fleet</strong></font> <strong>&gt; </strong>
                <font class="blklnkund"><strong>Jobsheet Master</strong></font><strong>&gt; </strong>
                <font class="bluefnt"><strong>Work Group Master</strong></font>&nbsp;</td>
        </tr>
       <tr>
            <td class="horzblue">
                <img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
</table>  
</td>
</tr>
<tr>
<td>

    <table border="0" class="boxbg" cellpadding="2" cellspacing="1" width="700px">
        <tr class="bgbluegrey">
            <td align="center" colspan="3">
                <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following Work Group(s) are created" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        
       <tr style="background-color:White">
            <td align="center"> 
                <asp:Label ID="lblDocType" runat="server" Text="Work Group(s): "   CssClass="blackfnt"></asp:Label>
            </td>
            <td align="center"> 
                <asp:Label ID="lblDocNo" runat="server"  CssClass="blackfnt"></asp:Label>
            </td>
           
            
            
        </tr> 
     
        <tr class="bgbluegrey">
            <td align="left" colspan="3">
                <asp:Label ID="lblNextStep" runat="server" Text="Your Next Step"  Font-Bold="true" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>

        <tr style="background-color:White">
            <td align="left" colspan="3">
                <asp:LinkButton ID="lnkStep1" runat="server" Text="Enter More Work Group(s)" CssClass="blackfnt" PostBackUrl="Workgrpdet.aspx"/>&nbsp;&nbsp;&nbsp;&nbsp&nbsp;<asp:LinkButton ID="LinkButton1" runat="server" Text="Return To Browse Page" CssClass="blackfnt" PostBackUrl="Workgrp.aspx"/>
            </td>
        </tr>
       
        
    </table>
 </td>
</tr>
</table>
  </asp:Content>
