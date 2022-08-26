<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ChangePassword.ascx.cs"
    Inherits="Usercontrol_ChangePassword" %>
<asp:Table ID="tblMain" runat="server" HorizontalAlign="center" CellSpacing="1" BorderWidth="0"
    Width="100%" BorderStyle="Groove">
    <asp:TableRow>
        <asp:TableCell HorizontalAlign="center">
            <asp:Label ID="lblTitleMsg" runat="server" CssClass="blackfnt"></asp:Label>
            <br />
            <br />
            <asp:Table ID="tblContent" runat="server" HorizontalAlign="center" CssClass="boxbg"
                CellSpacing="1" BorderWidth="0" Width="60%" BorderStyle="Groove">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="2" HorizontalAlign="center" CssClass="bgbluegrey">
                        <b>Change Password</b>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" HorizontalAlign="left" ID="trOldPass" runat="server">
                    <asp:TableCell HorizontalAlign="left">
                        Current Password
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="left">
                        <asp:TextBox ID="txtOldPass" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                            ValidationGroup="onUpdate" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvOldPass" runat="server" ErrorMessage="*" ControlToValidate="txtOldPass"
                            ToolTip="Required" ValidationGroup="onUpdate" Display="Dynamic"></asp:RequiredFieldValidator>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" HorizontalAlign="left">
                    <asp:TableCell HorizontalAlign="left" Width="30%">
                        New Password
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="left">
                        <asp:TextBox ID="txtNewPass" runat="server" BorderStyle="Groove" CssClass="blackfnt"
                            ValidationGroup="onUpdate" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNewPass" runat="server" ErrorMessage="*" ControlToValidate="txtNewPass"
                            ToolTip="Required" ValidationGroup="onUpdate" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revNewPass" runat="server" ErrorMessage="!!"
                            ValidationGroup="onUpdate" Display="dynamic" ControlToValidate="txtNewPass" ValidationExpression="^(\S+)$"
                            ToolTip="Password does not match complexity requirement. "></asp:RegularExpressionValidator>
                        <asp:CompareValidator ID="cvOldPass" runat="server" Display="Dynamic" SetFocusOnError="True"
                            ValidationGroup="onUpdate" ControlToCompare="txtOldPass" ControlToValidate="txtNewPass"
                            ErrorMessage="Password should not be a current password." Operator="NotEqual"></asp:CompareValidator>
                        <asp:CompareValidator ID="cvLastPass" runat="server" Display="Dynamic" SetFocusOnError="True"
                            ControlToValidate="txtNewPass" ErrorMessage="Password should not be a last password."
                            ValidationGroup="onUpdate" ValueToCompare="" Operator="NotEqual"></asp:CompareValidator>
                        <asp:CompareValidator ID="cvOldPassValue" runat="server" Display="Dynamic" SetFocusOnError="True"
                            ValidationGroup="onUpdate" ControlToValidate="txtNewPass" ValueToCompare="" ErrorMessage="Password should not be a current password."
                            Operator="NotEqual"></asp:CompareValidator>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" HorizontalAlign="left">
                    <asp:TableCell HorizontalAlign="left">
                        Conform New Password
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="left">
                        <asp:TextBox ID="txtConfPass" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                            ValidationGroup="onUpdate" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*"
                            ToolTip="Required" ValidationGroup="onUpdate" ControlToValidate="txtConfPass"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvConfPass" runat="server" ErrorMessage="Password does not match."
                            ValidationGroup="onUpdate" ControlToCompare="txtNewPass" ControlToValidate="txtConfPass"
                            Display="Dynamic" Operator="Equal"></asp:CompareValidator>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgbluegrey" VerticalAlign="Middle">
                    <asp:TableCell HorizontalAlign="center" ColumnSpan="2">
                        <asp:Button ID="btpUpdate" runat="server" Text="Update" Width="100" CssClass="blackfnt"
                            OnClick="btpUpdate_Click" ValidationGroup="onUpdate" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow>
        <asp:TableCell HorizontalAlign="center">
           <%-- <asp:Label ID="lblMsg" runat="server"></asp:Label>--%>
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
<asp:Table ID="tblMsg" runat="server" HorizontalAlign="center" CssClass="boxbg" CellSpacing="1"
    BorderWidth="0" Width="60%" BorderStyle="Groove" Visible="false">
    <asp:TableRow CssClass="bgbluegrey" >
        <asp:TableCell ColumnSpan="2" HorizontalAlign="center" CssClass="bgbluegrey">
                        <b>Change Password</b>
        </asp:TableCell>
    </asp:TableRow>
    <asp:TableRow>
        <asp:TableCell HorizontalAlign="center" CssClass="bgwhite" Height="20px" VerticalAlign="Middle">
            <asp:Label ID="lblMsg" CssClass="blackfnt" runat="server"></asp:Label>
        </asp:TableCell>
    </asp:TableRow>    
    <asp:TableRow>
        <asp:TableCell HorizontalAlign="center" CssClass="bgbluegrey">
            <asp:Button ID="btnMain" runat="server" Text="Go to edit Page" Width="125px" CssClass="blackfnt"
                OnClick="btpMain_Click" />
        </asp:TableCell>
    </asp:TableRow>
</asp:Table>
