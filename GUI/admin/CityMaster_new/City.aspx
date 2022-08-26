
<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="City.aspx.cs" Inherits="GUI_WebAdmin_CityMaster_City" Title="City Master" %>
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
              <font class="bluefnt"><strong> &gt; City Master</strong> </font></td>
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
							 
             <td align="center"> <asp:LinkButton ID="LinkButton1" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Add" PostBackUrl="./Citymaster_Step1.aspx" />
                <font class="blackfnt">|</font>
                <asp:LinkButton ID="LinkButton2" CssClass="bluefnt" runat="server" Font-Bold="false" Text="Edit" PostBackUrl="./Citymaster_Step2.aspx" />
             </td>
							</tr>
                									
                 
            </table></td>
        </tr>
      </table></asp:Content>
