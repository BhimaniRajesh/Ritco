<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Holiday.aspx.cs" Inherits="GUI_admin_Holiday_Holiday" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">
        function ValidateData()
            {
                if(document.getElementById("ctl00_MyCPH1_ddRg"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddRg").value == "--Select--")
                    {
                        alert("Select Region");
                        document.getElementById("ctl00_MyCPH1_ddRg").focus();
                        return false;
                    }
                }
                    
                if(document.getElementById("ctl00_MyCPH1_ddLoc"))
                {
                    if(document.getElementById("ctl00_MyCPH1_ddLoc").value == "--Select--")
                    {
                        alert("Please Select Location ");
                        document.getElementById("ctl00_MyCPH1_ddLoc").focus();
                        return false;
                    }
                }
                return true;
            }
            
</script>  
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30">
          <div align="left">
    <a><font class="blklnkund"><b>Module</b></font></a>
							<b> &gt; </b>
							<a><font class="blklnkund"><b>Administrator</b></font></a>
							<b> &gt; </b>
							<a href="../miscellaneous.aspx"><font class="blklnkund"><b>Miscellaneous</b></font></a>
							<b> &gt; </b>
							<font class="bluefnt"><b>Holiday Master</b></font></div>
          </td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>

        <tr> 
          <td align="right"><a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a></td>
        </tr>
        
        <tr> 
          <td><br /><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="39%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="300" valign="top">
					  <!--START--> 
                          <table border="0" cellpadding="3" width="76%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
                            <tr class="bgbluegrey"> 
                              <td  align="center" colspan="2"> 
                                <p align="center"><font class="blackfnt"><b>Select Holidays for Edit/Delete</b></font></p>
                              </td>
                            </tr>
	                        <tr bgcolor="#FFFFFF"> 
                                    <td  align="center" width="40%"> 
                                      <div align="right"><font class="blackfnt">Select Region</font> 
                                        : </div>
                                    </td>
                                    <td bgcolor="#FFFFFF" align="left"> 
                                        <asp:UpdatePanel ID="upddRg" runat="server">
   	                                        <ContentTemplate>
                                                <asp:DropDownList ID="ddRg" runat="server" CssClass="input" OnSelectedIndexChanged="ddRg_SelectedIndexChanged" AutoPostBack="True">
                                                </asp:DropDownList>
                                            </ContentTemplate>
   	                                    </asp:UpdatePanel>
   	                                </td>   
                                  </tr>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td align="center" valign="top"> 
                                      <div align="right"><font class="blackfnt">Select Location</font> 
                                        : </div>
                                    </td>
                                    <td align="left"> 
                                       <asp:UpdatePanel ID="upddLoc" runat="server">
   	                                     <ContentTemplate> 
                                            <asp:DropDownList ID="ddLoc" runat="server" CssClass="input">
                                            <asp:ListItem Text="--Select--"></asp:ListItem>
                                            </asp:DropDownList>
                                          </ContentTemplate>
                                          <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddRg" EventName="SelectedIndexChanged" />
                                          </Triggers>
   	                                    </asp:UpdatePanel> 
                                    </td>
                                  </tr>
	                        <tr> 
		                        <td bgcolor="#FFFFFF" align="center" colspan="2" height="22">
                                    &nbsp;<asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Add" />
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClientClick="return ValidateData()" OnClick="btnEdit_Click" Visible="False" />
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" Visible="False" />
                                    <asp:Button ID="btnListing" runat="server" Text="Listing" OnClick="btnListing_Click" /></td>
	                        </tr>
                          </table>

 
  					  <!--END-->
					  </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
    </td>
  </tr>
</table>  

</asp:Content>

