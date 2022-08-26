<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="CustomerGroupMasterEdit.aspx.cs" Inherits="GUI_admin_CustomerGroupMaster_CustomerGroupMasterEdit" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script language="javascript" type="text/javascript">
       function nwOpen(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }
        
       
</script>
<div style="width:9.5in">

<table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 100%; height: 228px">
    	<tr> 
          <td style="height: 36px"><a href=""><font class="blklnkund"><strong>Module</strong></font></a>
		  
	&gt; <a href=""><font class="blklnkund"><strong>Administrator </strong></font></a>

&gt; <a href=""><font class="blklnkund"><strong>Business Partners</strong></font></a>

		  <font class="bluefnt"><strong> &gt; 
		  Customer Group Master</strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1" alt="" /></td>
        </tr>
        <%--<tr> 
          <td><img src="../../images/clear.gif" width="15" height="10" alt="" /></td>
        </tr>--%>

        <tr> 
          <td align="right" style="height: 51px"><a href="javascript:window.history.go(-1)" title="back"><img src="../../images/back.gif" border="0" alt="" /></a></td>
        </tr>
          <tr> 
          <td><br /><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="39%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td valign="top" style="height: 158px">
					  <!--START--> 

  <table border="0" cellpadding="3" width="76%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
    <tr class="bgbluegrey"> 
      <td  align="center" colspan="2"> 
        <p align="center"><font class="blackfnt"><b>Quick Edit Customer Group</b></font></p>
      </td>
    </tr>

	<tr bgcolor="#FFFFFF"> 
            <td  align="center" width="40%"> 
              <div align="right"><font class="blackfnt">Enter Customer Group Code</font> 
                : </div>
            </td>
            <td bgcolor="#FFFFFF" align="left">&nbsp;<asp:TextBox ID="txtCstGrpCd" runat="server"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                    Width="14px"></asp:Label>
                </td>
          </tr>
	<tr> 
		<td bgcolor="#FFFFFF" align="center" colspan="2" height="22">
		    <font class="blackfnt"><b>OR</b></font> 
            <%--<asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
            <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" />
            <asp:Button ID="btnDelete" runat="server" Text="Delete" />--%></td>
	</tr>
  </table>
  <%--<br />--%>
  

  <table border="0" cellpadding="3" width="76%" bgcolor="#808080" cellspacing="1" align="center" class="boxbg">
    <tr class="bgbluegrey"> 
      <td  align="center" colspan="2"> 
        <p align="center"><font class="blackfnt"><b>Select Customer Group for Edit</b></font></p>
      </td>
    </tr>

    <tr bgcolor="#FFFFFF"> 
      <td  align="center" valign="top" style="width: 285px"> 
        <div align="right"><font class="blackfnt">Select Customer Group</font> 
          : </div>
      </td>
      <td bgcolor="#FFFFFF" align="left"> 
          <asp:DropDownList ID="ddCstGrp" runat="server">
          </asp:DropDownList>
          </td>
    </tr>
	<tr> 
		<td bgcolor="#FFFFFF" align="center" colspan="2" height="22">
		    <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
            <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" />
             
            <asp:Button ID="btnlist" runat="server" Text="List All" OnClick="btnlist_Click" />
                <asp:Label ID="lblmsg" runat="server" ForeColor="Red"></asp:Label><%--<asp:Button ID="btnCstAdd" runat="server" Text="Add" OnClick="btnCstAdd_Click" />
            <asp:Button ID="btnCstEdit" runat="server" Text="Edit" OnClick="btnCstEdit_Click" />
            <asp:Button ID="btnCstDelete" runat="server" Text="Delete" />--%></td>
	</tr>
  </table>
  
  <br /> 
  
  <%--<table style="z-index: 100; left: 387px; position: absolute; top: 498px"><tr><td bgcolor="#FFFFFF" align="center" colspan="2" height="22">
    <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
    <asp:Button ID="btnEdit" runat="server" Text="Edit" OnClick="btnEdit_Click" />
    <asp:Button ID="btnDelete" runat="server" Text="Delete" />
  </td></tr></table>--%>

 
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
    <%--</td>
  </tr>
</table>  

</form>
</body>
</html>--%>
</div>
</asp:Content>

