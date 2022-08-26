<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPageLogin.master" AutoEventWireup="true"
    CodeFile="ChangePassword.aspx.cs" Inherits="GUI_admin_EmployeeMaster_ChangePassword"
    Title="Untitled Page" %>
<%@ Register Src="~/GUI/admin/EmployeeMaster/ChangePassword.ascx" TagName="ChgPass" TagPrefix="UC" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPHLogin" runat="Server">
    <div class="blackfnt">
       <table style="width: 100%">
            <tr>
                <td align="left"  colspan="3">
                    <asp:Label ID="lblWelcome" runat="server" Text="" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                    <hr align="center" size="1" color="#8ba0e5">
                </td>
            </tr>
            <tr>
                <td align="center">
                    <%--OldCode commented By Harshad --%>           
                    <%--<asp:Label ID="Label1" runat="server" Text="Your password is expired please change password to login..." CssClass="blackfnt" ></asp:Label>
                    <br />    
                    <br />           
                    <table cellpadding="1" cellspacing="1" border="0" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center">
                                <b>Change Password</b>
                            </td>
                        </tr>
                        <tr bgcolor="white" align="left">
                            <td>
                                Current Password
                            </td>
                            <td>
                                <asp:TextBox ID="txtOldPass" runat="server" ValidationGroup="onUpdate" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvOldPass" runat="server" ErrorMessage="*" ControlToValidate="txtOldPass"  ValidationGroup="onUpdate"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr bgcolor="white" align="left">
                            <td>
                                New Password
                            </td>
                            <td>
                                <asp:TextBox ID="txtNewPass" runat="server" ValidationGroup="onUpdate" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNewPass" runat="server" ErrorMessage="*" ControlToValidate="txtNewPass"  ValidationGroup="onUpdate"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revNewPass" runat="server" ErrorMessage="!!"  ValidationGroup="onUpdate"
                                    Display="dynamic" ControlToValidate="txtNewPass" ValidationExpression="^(\S+)$" ToolTip="Password does not match complexity requirement. "></asp:RegularExpressionValidator>
                                <asp:CompareValidator ID="cvOldPass" runat="server" Display="Dynamic" SetFocusOnError="True"  ValidationGroup="onUpdate"
                                    ControlToCompare="txtOldPass" ControlToValidate="txtNewPass" ErrorMessage="Password should not be a current password." Operator="NotEqual"></asp:CompareValidator>
                                <asp:CompareValidator ID="cvLastPass" runat="server" Display="Dynamic" SetFocusOnError="True"
                                    ControlToValidate="txtNewPass" ErrorMessage="Password should not be a last password."  ValidationGroup="onUpdate"
                                    ValueToCompare="" Operator="NotEqual"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr bgcolor="white" align="left">
                            <td>
                                Conform New Password
                            </td>
                            <td>
                                <asp:TextBox ID="txtConfPass" runat="server" ValidationGroup="onUpdate" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ValidationGroup="onUpdate"
                                    ControlToValidate="txtConfPass" Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvConfPass" runat="server" ErrorMessage="Password does not match." ValidationGroup="onUpdate"
                                    ControlToCompare="txtNewPass" ControlToValidate="txtConfPass" Display="Dynamic" Operator="Equal"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr bgcolor="white" align="left">
                            <td></td>
                            <td>
                                <asp:Button ID="btpUpdate" runat="server" Text="Update" Width="100" BorderStyle="Groove" OnClick="btpUpdate_Click" ValidationGroup="onUpdate" />
                            </td>
                        </tr>
                    </table>  --%>
                                        
                </td>
                <td><UC:ChgPass ID="ucChangePass" runat="server" DoRedirect="true" RedirectURL="~/GUI/default.aspx" AskForOldPass="true" /></td>
            </tr>            
        </table>
    </div>
</asp:Content>
