<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Part_Add.aspx.cs" Inherits="GUI_WebAdmin_Part_Vehical_Part" %>

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
              Vehicle Part Master</strong></font>
              </td>
						</tr>
						<tr> 
						  <td class="horzblue"></td>
						</tr>
						<tr> 
							  <td>  </td>
							</tr>

        					<%--<tr> 
         					 <td align="right"><a href="javascript:window.history.go(-1)" title="back"><img src="../../../images/back.gif" border="0" alt="" /></a></td>
							 </tr>--%>
        
      						 <tr> 
							  <td>  </td>
							</tr>
            </table></td>
        </tr>
      </table>
      <br>
 <center>
    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                    <ContentTemplate>
    <table align="left" border="0" cellpadding="1" cellspacing="1" class="boxbg" width="50%">
        <tr class="bgbluegrey" align="center">
            <td align="center" colspan="4" class="blackfnt">
                Vehicle Part Master</td>
        </tr>
        <tr style="background-color: white" >
            <td colspan="1" align="left">
                <font class="blackfnt">&nbsp;Part Code</font></td>
            <td class="blackfnt" style="color: #ff3366" colspan="3" align="left">
                &nbsp;
                <asp:Label ID="lblVihicalCode" runat="server" Text="System Generated..."></asp:Label></td>
        </tr>
        <tr style="background-color: white" >
            <td colspan="1" align="left">
                <font class="blackfnt">&nbsp;Vehicle Part Name</font></td>
            <td class="blackfnt" colspan="3" align="left">
                &nbsp;<asp:TextBox ID="txtVihicalPart" runat="server"></asp:TextBox>&nbsp;
                <asp:CustomValidator ID="cvVihicalName" runat="server" ControlToValidate="txtVihicalPart"
                    ErrorMessage="This Name Already Exit" OnServerValidate="VihicalName"></asp:CustomValidator></td>
        </tr>
        <tr style="background-color: white">
            <td class="blackfnt" align="left">
                &nbsp;Active</td>
            <td class="blackfnt" colspan="3" align="left">
                
                &nbsp;<asp:CheckBox ID="chkYes" runat="server" CssClass="blackfnt" AutoPostBack="true" OnCheckedChanged="chkYes_CheckedChanged" />
                        <asp:TextBox ID="txtNo" runat="server" ReadOnly="True" Width="16px">N</asp:TextBox>
                   
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="right" colspan="5">
                <font class="blackfnt">&nbsp;<asp:Button ID="btnListing" runat="server" Text="Go To For Listing" OnClick="btnListing_Click" />&nbsp;
                    &nbsp;<asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" /></font></td>
        </tr>
    </table>
     </ContentTemplate>
                </asp:UpdatePanel></center>
</asp:Content>