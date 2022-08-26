<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Vehical_Master.aspx.cs" Inherits="GUI_WebAdmin_Class_Vehical_Master_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr> 
		<td>&nbsp;</td>
	  </tr>
  <tr> 
    <td> 
      <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
						<tr> 
						  
            <td height="30"><font class="blackfnt"><strong>
              Masters Module</strong></font>
              <font class="bluefnt"><strong> &gt; Vehicle Class Master</strong> </font></td>
						</tr>
						<tr> 
						  <td class="horzblue"></td>
						</tr>
						<tr> 
							  <td>  </td>
							</tr>

        					<tr> 
         					 <td align="right"><a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a></td>
							 </tr>
        
      						 <tr> 
							  <td>  </td>
							</tr>
            </table></td>
        </tr>
      </table>
    <center>
    <asp:HyperLink ID="hlVihicalAdd" runat="server" CssClass="blackfnt" NavigateUrl="./Vehical_Add.aspx">Add</asp:HyperLink>
               |
               <asp:HyperLink ID="hlVihicalEdit" runat="server" CssClass="blackfnt" NavigateUrl="./Vehical_Edit.aspx">Edit</asp:HyperLink>
   </center>
</asp:Content>