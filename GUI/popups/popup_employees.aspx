<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup_employees.aspx.cs"
    Inherits="GUI_popups_popup_employees" %>

<%--<%@ Register Src="~/GUI/usercontrol/javachild.ascx" TagName="JavaUpdate" TagPrefix="JU" %>
<%@ Reference Control="~/GUI/usercontrol/javachild.ascx"%>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employees</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%--        <JU:JavaUpdate ID="JavaUpdate" runat="server"  Visible="true"/>
--%>
            <table cellspacing="1" style="width: 100%">
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Select Employee</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                    </td>
                </tr>
            </table>
            <table cellspacing="1" style="width: 500px">
                <tr>
                    <td align="left" width="50%">
                        <asp:Label runat="server" ID="lblEmp" Text="User ID/Init. Chars of Name/Br.Code:" CssClass="blackfnt"
                            Font-Bold="true"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txt" runat="server" Text="" AutoPostBack="true"></asp:TextBox>
                        <asp:LinkButton runat="server" ID="btnClick" Text="Show Employees" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:GridView HeaderStyle-CssClass="dgHeaderStyle" CssClass="dgRowStyle" BorderColor="#8BA0E5"
                            BorderWidth="1px" CellSpacing="2" CellPadding="2" ID="GridView1" runat="server"
                            AutoGenerateColumns="False" DataKeyNames="UserId" DataSourceID="SqlConn" >
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <%--                                        <asp:LinkButton ID="lnkSelect" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="Select" ></asp:LinkButton>
--%>
                                        <input type="radio" name="radSelect" value='<%# Eval("UserId")%>'></input>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="UserId" HeaderText="UserId" ReadOnly="True" SortExpression="UserId" />
                                <asp:BoundField DataField="EmpId" HeaderText="EmpId" SortExpression="EmpId" />
                                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                                <asp:BoundField DataField="BranchCode" HeaderText="BranchCode" SortExpression="BranchCode" />
                                <asp:BoundField DataField="EmailId" HeaderText="EmailId" SortExpression="EmailId" />
                            </Columns>
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlConn" runat="server" ProviderName="System.Data.SqlClient"
                            SelectCommand="SELECT [UserId], [BranchCode], [Name], [EmpId], [EmailId] FROM [WebX_Master_Users] Where BranchCode=@UserNameCode Or UserId=@UserNameCode Or [Name] like @UserNameCode + '%'">
                            <SelectParameters>
                                <asp:ControlParameter PropertyName="Text" ControlID="txt" Type="string" Name="UserNameCode"
                                    DefaultValue="" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <%--        ConnectionString="Data Source=WEBXPRESS;Initial Catalog=WebXNet;User ID=sa;Password=sys"
--%>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="height: 26px">
                        <asp:Button runat="server" Text="Go >>" ID="btnGo" OnClick="btnGo_Click" />
                        <asp:HiddenField ID="hUserID" runat="server" Value=""/>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
