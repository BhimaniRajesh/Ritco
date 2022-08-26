<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorContract_Step1.aspx.cs" Inherits="GUI_Admin_Vendor_contract_vendorContract_Step1" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><font class="blklnkund"><strong> Module</strong></font>
          
		<strong> &gt; </strong><font class="blklnkund"><strong>Administrator </strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Finance & Accounts</strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Vendor Contract Master </strong></font>

<font class=bluefnt><strong> &gt; </strong>
		  <strong>New Contract </strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>

   
        
        <tr> 
          <td align=right> <div align="center">
 <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                    <ContentTemplate>
                                    <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                                <ProgressTemplate>
                                    <div id="progressArea">
                                        <asp:Label ID="lblLS" runat="server" Text="Please wait..." ForeColor="red" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
</div><img src="./../../images/back.gif" border=0></td>
        </tr>
                    <tr> 
                      <td height="300" valign="top">
<br /><br />

 <table border=0 style="width:5.0in" align="center" cellspacing="1" class=boxbg>
    <tr bgcolor="#ffffff">
      
      <td  bgcolor="#ffffff"> <table border="0" cellspacing="1" cellpadding="0">
                                  <tr> 
                                    <td class=bullet><IMG height=4 src="../../../GUI/images/clear.gif" width=4></td>
                                  </tr>
                                </table></td>
      <td width=30%  >&nbsp;<font  class=blackfnt>Select Vendor Type</font></td>
      <td width=30% >&nbsp;<font class=blackfnt> <asp:UpdatePanel Id="UP" runat="server"> 
               <ContentTemplate>
                  <asp:DropDownList ID="cbovendortype" runat="server"  AutoPostBack="true"  OnSelectedIndexChanged="cbovendortype_SelectedIndexChanged" >
                  
                    </asp:DropDownList>
                   </ContentTemplate>
        </asp:UpdatePanel></font></td>
      
    </tr>
   
    <tr bgcolor="#ffffff">
     
     
       <td  bgcolor="#ffffff"> <table border="0" cellspacing="1" cellpadding="0">
                                  <tr> 
                                    <td class=bullet><IMG height=4 src="../../../GUI/images/clear.gif" width=4></td>
                                  </tr>
                                </table></td>
      <td width=30% >&nbsp;<font class=blackfnt>Add New Contract </font></td>
      <td width=30% valign="middle" >&nbsp;<font class=blackfnt><asp:UpdatePanel Id="UpdatePanel1" runat="server"> 
               <ContentTemplate>
                  <asp:DropDownList ID="cbovendortype1" runat="server"  AutoPostBack="true" >
                  <asp:ListItem Text="Select" Value=""></asp:ListItem>
                    </asp:DropDownList>
                   </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cbovendortype" EventName="SelectedIndexChanged" />
                    </Triggers>
        </asp:UpdatePanel></font></td>
      
	   
    </tr>
    
    <tr bgcolor="#ffffff">
     
      <td width=1%  bgcolor="#ffffff"> <table border="0" cellspacing="5" cellpadding="0">
                                  <tr> 
                                    <td class=bullet><IMG height=4 src="../../../GUI/images/clear.gif" width=4></td>
                                  </tr>
                                </table></td>
      <td width=30% >&nbsp;<font class=blackfnt>Edit Existing Contract</font></td>
      <td width=30% >&nbsp;<font class=blackfnt><asp:UpdatePanel Id="UpdatePanel2" runat="server"> 
               <ContentTemplate>
                  <asp:DropDownList ID="cbovendortype2" runat="server"  AutoPostBack="true" >
                  <asp:ListItem Text="Select" Value=""></asp:ListItem>
                    </asp:DropDownList>
                   </ContentTemplate>
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cbovendortype" EventName="SelectedIndexChanged" />
                    </Triggers>
        </asp:UpdatePanel></font></td>
      
	   
    </tr>
    
    <tr bgcolor="#ffffff">
     
     <td  bgcolor="#ffffff"> <table border="0" cellspacing="5" cellpadding="0">
                                  <tr> 
                                    <td class=bullet><IMG height=4 src="../../../GUI/images/clear.gif" width=4></td>
                                  </tr>
                                </table></td>
      <td width=30% >&nbsp;<font class=blackfnt>View Existing Contract</font></td>
      <td width=30%  >&nbsp;<font class=blackfnt><asp:UpdatePanel Id="UpdatePanel3" runat="server"> 
               <ContentTemplate>
                  <asp:DropDownList ID="cbovendortype3" runat="server"  AutoPostBack="true" >
                  <asp:ListItem Text="Select" Value=""></asp:ListItem>
                    </asp:DropDownList>
                   </ContentTemplate>
                   
                     <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cbovendortype" EventName="SelectedIndexChanged" />
                    </Triggers>
        </asp:UpdatePanel></font></td>
      
	   
    </tr>
     <tr style="background-color: white">
                        <td align="center" colspan="3">
                         <asp:Button ID="btnShow" runat="server" Text="Submit"  OnClick="btnShow_Click"  Width="75px"  />
                        </td>
                    </tr>


  </table>
</td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table>

</asp:Content>

