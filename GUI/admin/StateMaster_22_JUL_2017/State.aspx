

<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="State.aspx.cs" Inherits="GUI_WebAdmin_StateMaster_State" Title="State Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	  <tr> 
		<td>&nbsp;</td>
	  </tr>
  <tr> 
    <td> 
      <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
						<tr> 
						  
            <td height="30"><font class="blklnkund"><strong>
              Module</strong></font>&gt;<font class="blklnkund"><strong>Administrator 
              </strong></font> &gt; <font class="blklnkund"><strong>Operations</strong></font> 
              <font class="bluefnt"><strong> &gt;State Master</strong> </font></td>
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
							<tr> 
							  <td align="center"> <asp:LinkButton ID="LinkButton3" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="./StateMasterAdd.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton4" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="./StateMasterEdit.aspx" />
             </td>
							</tr>
                									
                 
            </table></td>
        </tr>
      </table></asp:Content>
