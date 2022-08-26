<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AirportList.aspx.cs" Inherits="GUI_admin_AirportMaster_AirportList" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="vbscript" type ="text/vbscript">
 
    Function del(Prompt)
    
        if MsgBox (Prompt, vbYesNo, "Confirmation") = vbYes then
            del = true
        else
            del = false
        end if
           
    End Function
    
 </script>  

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td style="height: 19px">&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%">
    	<tr> 
          <td height="30"><a href=""><font class="blklnkund"><strong>Module</strong></font></a>
	        &gt; <a href=""><font class="blklnkund"><strong>Administrator </strong></font></a>
            &gt; <a href=""><font class="blklnkund"><strong>Company Structure</strong></font></a>
		  <font class="bluefnt"><strong> &gt; Airport Listing</strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>
        <tr> 
          <td align="right"><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border="0" alt="" /></a></td>
        </tr>
        <tr> 
          <td><br /><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="39%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="300" valign="top">
					  <!--START--> 
                      <table cellspacing="1" cellpadding="0" align="center" style="height:18; width: 96%;" border="0" class="boxbg">
                        <tr> 
                          <td colspan="8" bgcolor="#FFFFFF" height=30> 
                            <div align="center">
                                <asp:Label ID="lblMsg" runat="server" ForeColor="#FF8080"></asp:Label></div>
                          </td>
                        </tr>
                        <tr> 
                          <td colspan="8">
                          <table width="100%" cellspacing="1" cellpadding="3" align="center" border="0">
                          <tr class="bgbluegrey">
                          <td colspan="1" align="center" style="width: 69px">
                              <strong>Select</strong></td>
                          <td colspan="1" align="center" style="width: 58px"><strong>Airport Code</strong></td>
                          <td colspan="1" align="center" style="width: 406px"><strong>Airport City</strong></td> 
                              <td align="center" colspan="1" width="5%">
                              </td>
                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 69px; height: 9px;">
                                                           <asp:CheckBox ID="chk1" runat="server"/>
                                                        </td>
                                                            <td style="width: 58px; height: 9px">
                                                                <asp:Label ID="lblCode1" runat="server" class="blackfnt"></asp:Label></td>
                                                        <td style="width: 406px; height: 9px;">
                                                            <asp:Label ID="lblCity1" runat="server"></asp:Label></td>
                                                            <td style="width: 128px; height: 9px"><font class="blackfnt">
                                                                <asp:LinkButton ID="lnkEdit1" runat="server" BorderStyle="None" CssClass="blkfnt"
                                                                    ForeColor="Black" OnClick="lnkEdit1_Click">Edit</asp:LinkButton></font></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 69px; height: 15px;">
                                                            <asp:CheckBox ID="chk2" runat="server" /></td>
                                                            <td style="width: 58px; height: 15px;">
                                                                <asp:Label ID="lblCode2" runat="server" class="blackfnt"></asp:Label></td>
                                                        <td style="width: 406px; height: 15px;">
                                                            <asp:Label ID="lblCity2" runat="server"></asp:Label></td>
                                                            <td style="width: 128px; height: 15px">
                                                                <asp:LinkButton ID="lnkEdit2" runat="server" BorderStyle="None" CssClass="blkfnt"
                                                                    ForeColor="Black" OnClick="lnkEdit2_Click">Edit</asp:LinkButton></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 69px; height: 15px;">
                                                            <asp:CheckBox ID="chk3" runat="server" /></td>
                                                            <td style="width: 58px; height: 15px;">
                                                                <asp:Label ID="lblCode3" runat="server" class="blackfnt"></asp:Label></td>
                                                        <td style="width: 406px; height: 15px;">
                                                            <asp:Label ID="lblCity3" runat="server"></asp:Label></td>
                                                            <td style="width: 128px; height: 15px"><font class="blackfnt">
                                                                <asp:LinkButton ID="lnkEdit3" runat="server" BorderStyle="None" CssClass="blkfnt"
                                                                    ForeColor="Black" OnClick="lnkEdit3_Click">Edit</asp:LinkButton></font></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 69px; height: 15px;">
                                                            <asp:CheckBox ID="chk4" runat="server" /></td>
                                                            <td style="width: 58px; height: 15px;">
                                                                <asp:Label ID="lblCode4" runat="server" class="blackfnt"></asp:Label></td>
                                                        <td style="width: 406px; height: 15px;">
                                                            <asp:Label ID="lblCity4" runat="server"></asp:Label></td>
                                                            <td style="width: 128px; height: 15px;">
                                                                <asp:LinkButton ID="lnkEdit4" runat="server" BorderStyle="None" CssClass="blkfnt"
                                                                    ForeColor="Black" OnClick="lnkEdit4_Click">Edit</asp:LinkButton></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 69px">
                                                            <asp:CheckBox ID="chk5" runat="server" /></td>
                                                            <td style="width: 58px">
                                                                <asp:Label ID="lblCode5" runat="server" class="blackfnt"></asp:Label></td>
                                                        <td style="width: 406px">
                                                            <asp:Label ID="lblCity5" runat="server"></asp:Label></td>
                                                            <td style="width: 128px">
                                                                <asp:LinkButton ID="lnkEdit5" runat="server" BorderStyle="None" CssClass="blkfnt"
                                                                    ForeColor="Black" OnClick="lnkEdit5_Click">Edit</asp:LinkButton></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 69px">
                                                            <asp:CheckBox ID="chk6" runat="server" /></td>
                                                            <td style="width: 58px">
                                                                <asp:Label ID="lblCode6" runat="server" class="blackfnt"></asp:Label></td>
                                                        <td style="width: 406px">
                                                            <asp:Label ID="lblCity6" runat="server"></asp:Label></td>
                                                            <td style="width: 128px"><font class="blackfnt">
                                                                <asp:LinkButton ID="lnkEdit6" runat="server" BorderStyle="None" CssClass="blkfnt"
                                                                    ForeColor="Black" OnClick="lnkEdit6_Click">Edit</asp:LinkButton></font></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 69px">
                                                            <asp:CheckBox ID="chk7" runat="server" /></td>
                                                            <td style="width: 58px">
                                                                <asp:Label ID="lblCode7" runat="server" class="blackfnt"></asp:Label></td>
                                                        <td style="width: 406px">
                                                            <asp:Label ID="lblCity7" runat="server"></asp:Label></td>
                                                            <td style="width: 128px">
                                                                <asp:LinkButton ID="lnkEdit7" runat="server" BorderStyle="None" CssClass="blkfnt"
                                                                    ForeColor="Black" OnClick="lnkEdit7_Click">Edit</asp:LinkButton></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 69px">
                                                            <asp:CheckBox ID="chk8" runat="server" /></td>
                                                            <td style="width: 58px">
                                                                <asp:Label ID="lblCode8" runat="server" class="blackfnt"></asp:Label></td>
                                                        <td style="width: 406px">
                                                            <asp:Label ID="lblCity8" runat="server"></asp:Label></td>
                                                            <td style="width: 128px"><font class="blackfnt">
                                                                <asp:LinkButton ID="lnkEdit8" runat="server" BorderStyle="None" CssClass="blkfnt"
                                                                    ForeColor="Black" OnClick="lnkEdit8_Click">Edit</asp:LinkButton></font></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 69px">
                                                            <asp:CheckBox ID="chk9" runat="server" /></td>
                                                            <td style="width: 58px">
                                                                <asp:Label ID="lblCode9" runat="server" class="blackfnt"></asp:Label></td>
                                                        <td style="width: 406px">
                                                            <asp:Label ID="lblCity9" runat="server"></asp:Label></td>
                                                            <td style="width: 128px">
                                                                <asp:LinkButton ID="lnkEdit9" runat="server" BorderStyle="None" CssClass="blkfnt"
                                                                    ForeColor="Black" OnClick="lnkEdit9_Click">Edit</asp:LinkButton></td>
                                                        </tr>
                                                        <tr style="background-color:White; height: 15px">
                                                        <td style="width: 69px; height: 15px;">
                                                            <asp:CheckBox ID="chk10" runat="server" /></td>
                                                            <td style="width: 58px; height: 15px">
                                                                <asp:Label ID="lblCode10" runat="server" class="blackfnt"></asp:Label></td>
                                                        <td style="width: 406px; height: 15px;">
                                                            <asp:Label ID="lblCity10" runat="server"></asp:Label></td>
                                                            <td style="width: 128px; height: 15px">
                                                                <asp:LinkButton ID="lnkEdit10" runat="server" BorderStyle="None" CssClass="blkfnt"
                                                                    ForeColor="Black" OnClick="lnkEdit10_Click">Edit</asp:LinkButton></td>
                                                        </tr>
                                                        
                     
                      </table>
                              <%--<asp:Button ID="btnDelete" runat="server" OnClientClick="return del('Delete')" OnClick="btnDelete_Click" Text="Delete" />
                              <asp:Button ID="btnAdd" runat="server" Text="Add" /></td>--%>
                      </tr>
                      <tr >
                      <td bgcolor="#FFFFFF" align="right">
                        <asp:Button ID="Button1" runat="server" OnClientClick="return del('Delete')" OnClick="btnDelete_Click" Text="Delete" />
                              <asp:Button ID="Button2" runat="server" Text="Add" OnClick="Button2_Click" />
                      </td>
                      </tr>
                     
                     </table>
  					                      <!--END-->
					  </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <%--<tr>
                      <td></td>
                    </tr>--%>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
    </td>
  </tr>
</table>    

</asp:Content>

