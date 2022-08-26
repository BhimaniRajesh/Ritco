<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="SelectBranch_1.aspx.cs" Inherits="GUI_admin_setting_emp_opn_bal_SelectBranch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

 <script language="javascript" type="text/javascript">

function nwOpen(mNo)
        {
            window.open("popupbranch.aspx?" + mNo,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
        }

function fsubmit(txtBranchCode)
		{
			
			if (txtBranchCode.value=="")
			 {
			  alert("Please enter the 'Branch Code'")
			  txtBranchCode.focus();
			  return false;
			 }
		}	 
    </script>

    <table cellspacing="1" cellpadding="5" align="center" border="0" class="boxbg">
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Enter Branch Code</font>
            </td>
            <td>
                <asp:TextBox ID="txtBranchCode" runat="server" Width="40px" OnChange="Javascript:this.value=this.value.toUpperCase();"></asp:TextBox>
                <button type="button" onclick="nwOpen(1)" name="submit">
                    ...</button>
                <%--<asp:Label ID="Label1" runat="server" BorderStyle="Groove" Text='<a href="javascript:nwOpen(1)">...</a>'
                    Width="14px"></asp:Label>--%>
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td colspan="2" align="center">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
