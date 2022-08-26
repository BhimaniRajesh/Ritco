<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Vehical_Add.aspx.cs" Inherits="GUI_WebAdmin_Class_Vihical_Master" %>

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
    <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                    <ContentTemplate>
    <table align="center" border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width: 70%; height: 151px;">
        <tr class="bgbluegrey">
            <td align="center" colspan="4" class="blackfnt">
                Vehicle Class Master</td>
        </tr>
        <tr bgcolor="white" >
            <td colspan="1" align="left" >
                <font class="blackfnt">&nbsp;Class Code</font></td>
            <td class="blackfnt" style="color: #ff3366" colspan="3" align="left">
                &nbsp;
                <asp:Label ID="lblVihicalCode" runat="server" Text="System Generated..."></asp:Label></td>
        </tr>
        <tr bgcolor="white" >
            <td colspan="1" align="left">
                <font class="blackfnt">&nbsp;Vehicle Class Name</font></td>
            <td class="blackfnt" colspan="3" align="left">
                &nbsp;<asp:TextBox ID="txtVihicalMaster" runat="server"></asp:TextBox>&nbsp;
                <asp:CustomValidator ID="cvVihicalName" runat="server" ControlToValidate="txtVihicalMaster"
                    ErrorMessage="This Name Already Exit" OnServerValidate="VihicalName"></asp:CustomValidator></td>
        </tr>
        <tr bgcolor="white" >
            <td class="blackfnt" align="left">
                &nbsp;Active</td>
            <td class="blackfnt" colspan="3" align="left">
                
                &nbsp;<asp:CheckBox ID="chkYes" runat="server" CssClass="blackfnt" AutoPostBack="true" OnCheckedChanged="chkYes_CheckedChanged" />
                        <asp:TextBox ID="txtNo" runat="server" Width="16px" ReadOnly="True">N</asp:TextBox>
                
                </td>
        </tr>
        <tr bgcolor="white">
            <td align="right"colspan="5">
                <font class="blackfnt">&nbsp;<asp:Button ID="btnListing" runat="server" Text="Go To For Listing" OnClick="btnListing_Click" />&nbsp;
                    &nbsp;<asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" /></font></td>
        </tr>
    </table>
    </ContentTemplate>
                </asp:UpdatePanel>
                </center>
</asp:Content>
