<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="PassPolicy_set.aspx.cs" Inherits="PasswordPolicy_PassPolicy_AddEdit" Title="WebXpress : Password Policy" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" >
    function showHideCmpxParams(chk,tblID)
    {
        var tbl = document.getElementById(tblID);
        if(chk.checked)
            tbl.style.display = "block";
        else
            tbl.style.display = "none";
            
        return true;
    }
</script>
    <div class="blackfnt">
        <table>
            <tr>
                <td>
                    <label class="blackfnt">
                        <b>WebXPress Password Policy</b>
                    </label>
                    <hr align="center" size="1" color="#8ba0e5">
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>
                    <table class="boxbg" cellpadding="3" cellspacing="1" border="0" width="800">
                        <tr class="bgbluegrey" align="center">
                            <td><b>Update Password Policy</b></td>
                        </tr>
                        <tr bgcolor="white" align="left" valign="top" id="trEncry" runat="server">
                            <td>
                                <asp:CheckBox ID="chkEncry" runat="server" Text="Enable Password Encryption" />
                            </td>
                        </tr>
                        <tr bgcolor="white" align="left" valign="top" id="trPassCompx" runat="server">
                            <td>
                                <asp:CheckBox ID="chkPassCompx" runat="server" Text="Enable Password Complexity" />
                                <br />
                                <table id='tblCompx' runat="server" cellpadding="2">
                                    <tr align="left" valign="top" id="trMinLength" runat="server">
                                        <td width="20"></td>
                                        <td>
                                            <img src="../../images/bullet-2.gif" />
                                        </td>
                                        <td colspan="2">
                                            Minimum Length :
                                            <asp:TextBox ID="txtMinLength" runat="server" Columns="2" MaxLength="2" style="text-align:right;"></asp:TextBox>
                                            Charaters
                                        </td>
                                    </tr>
                                    <tr align="left" valign="top" id="trMaxLength" runat="server">
                                        <td width="20"></td>
                                        <td>
                                            <img src="../../images/bullet-2.gif" />
                                        </td>
                                        <td colspan="2">
                                            Maximum Length :
                                            <asp:TextBox ID="txtMaxLenght" runat="server" Columns="2" MaxLength="2" style="text-align:right;"></asp:TextBox>
                                            Charaters
                                        </td>
                                    </tr>
                                    <tr align="left" valign="top" id="trPassContains" runat="server">
                                        <td width="10"></td>
                                        <td>
                                            <img src="../../images/bullet-2.gif" />
                                        </td>
                                        <td>
                                            Password should contains
                                            <table>
                                                <tr>
                                                    <td width="20">
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox ID="chkAlpha" runat="server" Text="At least one Alphabate" />
                                                        <br />
                                                        <asp:CheckBox ID="chkNumeric" runat="server" Text="At least one Numbers" />
                                                        <br />
                                                        <asp:CheckBox ID="chkSChar" runat="server" Text="At least one Spectial Charactor" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>                        
                        <tr bgcolor="white" align="left" valign="top"  id="trPassExpiry" runat="server">
                            <td>
                                <asp:CheckBox ID="chkPassExpiry" runat="server" Text="Password expires after" />                                
                                <asp:TextBox ID="txtExpireAfter" runat="server" Columns="3" MaxLength="3"></asp:TextBox>
                                Days
                            </td>
                        </tr>
                        <tr bgcolor="white" align="left" valign="top" id="trRemLastPass" runat="server">
                            <td>
                                <asp:CheckBox ID="chkRemLastPass" runat="server" Text="Remember last password." />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr align="center">
                <td>
                    <br />
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" Width="100" OnClick="btnUpdate_Click" /></td>
                    <br />
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMsg" runat="server" ></asp:Label> </td>
            </tr>
        </table>
    </div>
</asp:Content>

