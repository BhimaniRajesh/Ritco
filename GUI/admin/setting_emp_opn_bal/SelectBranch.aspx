<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="SelectBranch.aspx.cs" Inherits="GUI_admin_OpeningBalance_SelectBranch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">

        function nwOpen(mNo)
                {
                    var FrmChild = window.open('popupbranch.aspx?' + mNo,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
                    if(FrmChild != null)
                    {

                    }
                    else
                    {
                        return false;
                    }
                }

        function fsubmit(txtBranchCode)
        {
        //alert(txtBranchCode.value);
            if (txtBranchCode.value=="")
            {
                alert("Please enter the 'Branch Code'")
                txtBranchCode.focus();
                return false;
            }
        }	
        function value(obj)
        {
            alert(obj.name);
        }
    </script>

    <br />
    <br />

    <table cellspacing="1" cellpadding="5" align="center" border="0" class="boxbg">
        <tr bgcolor="#FFFFFF">
            <td>
                <font class="blackfnt">Enter Branch Code</font>
            </td>
            <td>
                <asp:UpdatePanel ID="up1" RenderMode="Inline"  UpdateMode="Always" runat="server">
                    <ContentTemplate>
                        <asp:TextBox ID="txtBranchCode" runat="server" Width="109px" OnChange="Javascript:this.value=this.value.toUpperCase();" AutoPostBack="true" OnTextChanged="text_change"></asp:TextBox>        
                        <asp:Label ID="error" runat="server" CssClass="redfnt"></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>
                
                <input type="button" onclick="nwOpen(1);" Value="..." style="width: 18px; height: 21px" size="" />&nbsp;
            </td>
        </tr>
        <tr bgcolor="#FFFFFF">
            <td colspan="2" align="center">
                &nbsp;<asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" /></td>
        </tr>
    </table>
</asp:Content>
