<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="addzone.aspx.cs" Inherits="GUI_admin_Zone_Master_addzone" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language ="javascript" type="text/javascript">

function checklocation(obj)
        {
        var a;
        a=1;
        obj.value = obj.value.toUpperCase()
       for(i=0;i<str.length;i++)
       {

            if(obj.value==str[i])
            {
                a=2
                alert("Zone Name Already Exist....")
           obj.focus();
                break;
                //return false;
            }
            else
            {
                continue
            }
       }
//       if (a!=2)
//       {
//          alert("please enter valid location")
//          obj.focus();
//       }


}
  
function check(txtzoneName)
{
    if(txtzoneName.value=="")
    {
    alert('Please Enter Zone Name')
    txtzoneName.focus();
    return false
    }
}

</script>

<table width="95%" border="0" cellspacing="1" cellpadding="3" align="center" class="boxbg">
    <tr class="bgbluegrey"> 
      <td colspan="2"> 
        <div align="center"><font class="blackfnt"><strong>Add Zone Master</strong></font></div>
      </td>
    </tr>
    <tr>
      <td colspan="2" bgcolor="#ffffff">
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
    <tr> 
      <td width="116" nowrap> 
        <div align="left"><strong><font class="blackfnt">Zone Code</font></strong></div>
      </td>
      <td width="440"><font class="redfnt">System Generated...</font></td>
    </tr>
    <tr> 
      <td width="116" nowrap><div align="left"><strong><font class="blackfnt">Zone Name</font></strong></div>
      </td>
      <td width="440"> 
        <div align="left">
        <asp:TextBox ID="txtzoneName" runat="server" onblur="return checklocation(this)"   MaxLength="50" Width="250px"></asp:TextBox>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="2" height="22"> 
        <div align="right">
          <asp:Button ID="cmdList" runat="server" Text="Go to Listing" OnClick="cmdList_Click" />
          <asp:Button ID="cmdSubmit" runat="server" Text="Save" OnClick="cmdSubmit_Click"/>
          <asp:Button ID="cmdUpdate" runat="server" Text="Update" Visible="false"/>
        </div>
      </td>
    </tr>
</table>


	</td>
    </tr>
 </table>


</asp:Content>
