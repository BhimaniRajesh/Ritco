<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Reports_acessRights.aspx.cs" Inherits="GUI_admin_Reports_acessRights" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<%--    <JU:JavaUpdate ID="JavaUpdate" runat="server"  Visible="false"/>

    <cc1:msgBox id="MsgBox1" runat="server"></cc1:msgBox>--%>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Access Rights</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table cellspacing="1" style="width: 500px">
        <tr>
            <td align="left" width="15%">
                <asp:Label runat="server" ID="lblEmp" Text="Employee:" CssClass="blackfnt" Font-Bold="true"></asp:Label>
            </td>
            <td align="left">
                <asp:TextBox EnableViewState="true" runat="server" ID="txtEmpCode" MaxLength="50"
                    Width="75" Enabled="true"></asp:TextBox>
                <asp:Button runat="server" Text="..." ID="btnPopup" />
                <asp:UpdatePanel ID="upViewCurrentRights" runat="server"        UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:LinkButton runat="server" ID="lnkViewCurrentRights" Text="Show Current Rights"
                            CssClass="bluefnt" Font-Bold="true" OnClick="CurrentAccessRights"></asp:LinkButton>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
            <td>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                    <ProgressTemplate>
                        <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        <font class="blackfnt" color="red"><b>Please wait...</b></font>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
    <table cellspacing="1" style="width: 500px">
        <tr>
            <td align="left" width="60%">
                <asp:Label runat="server" ID="lblSelect" Text="Select :" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <asp:UpdatePanel ID="UPChkUnCheck"       UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:LinkButton ID="CheckAll" runat="server" CssClass="bluefnt" Text="All" ValidationGroup="ChkUnCheck"
                            OnClick="CheckAll_Click" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Label runat="server" ID="lblSep" Text=" | " CssClass="blackfnt" Font-Bold="false"></asp:Label>
                <asp:LinkButton ID="UnCheckAll" runat="server" CssClass="bluefnt" Text="None" ValidationGroup="ChkUnCheck"
                    OnClick="UnCheckAll_Click" />
            </td>
            <td align="right">
                <asp:UpdatePanel ID="upAssignRights1" runat="server"      UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:LinkButton runat="server" ID="AssignRights1" Text="Assign Rights" CssClass="bluefnt"
                            Font-Bold="true" OnClick="AssignRights"></asp:LinkButton>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="upLblDone1" runat="server"     UpdateMode="conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:Label ID="lblDone1" runat="server" CssClass="redfnt"></asp:Label>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="lnkViewCurrentRights" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="AssignRights1" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="AssignRights2" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" colspan="2">
                <asp:UpdatePanel ID="u1"    UpdateMode="Conditional" runat="server">
                    <ContentTemplate>
                        <asp:GridView EnableViewState="true" ID="dgGeneral" runat="server" CellSpacing="2"
                            CellPadding="2" HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." OnRowDataBound="dg_RowDataBound"
                            DataKeyNames="Chk,L0_App_Module,L1_App_Module,App_Module">
                            <%--                       BorderWidth="1"  BorderColor="#8ba0e5" OnRowCommand="dg_RowCommand" OnRowCreated="dg_RowCreated"
--%>
                            <%--DataKeyNames="ProductCode,Classification,Quantity,BasicValue,CustomDutyRate,CVDRate,EduCESSRate,CustomEduCESSRate,AddImportDutyRate"--%>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkRights" EnableViewState="true" Text="" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- Level 0 --%>
                                <asp:TemplateField  HeaderText="Reports Type" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <%--                                        <asp:Label EnableViewState="true" ID="lblLevel0" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Level0Text")%>' />
--%>
                                        <asp:LinkButton ID="lnkLvl0" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Level0Text")%>'
                                         Font-Bold="true"    CssClass="bluefnt" Font-Underline="true" CommandArgument="<%# Container.DataItemIndex %>"
                                            OnCommand="SetAllLevel0" />
                                        <!--<asp:LinkButton ID="lnkLevel0_Plus" runat="server" Text='+' CommandName="Plus" CommandArgument="<%# Container.DataItemIndex %>" OnCommand="SetAllLevel0"></asp:LinkButton>
                                        <asp:LinkButton ID="lnkLevel0_Minus" runat="server" Text='-' CommandName="Minus" CommandArgument="<%# Container.DataItemIndex %>" OnCommand="SetAllLevel0"></asp:LinkButton>-->
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- Level 1 --%>
                                <asp:TemplateField  HeaderText="Reports Sub Type" ItemStyle-HorizontalAlign="left" ItemStyle-Font-Bold="true"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <%--<asp:Label EnableViewState="true" ID="lblLevel1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Level1Text")%>' />--%>
                                        <%--<asp:LinkButton ID="lnkLvl1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Level1Text")%>'
                                            CssClass="bluefnt"   CommandArgument="<%# Container.DataItemIndex %>"
                                            OnCommand="SetAllLevel1" />--%>
                                            
                                             <asp:Label  EnableViewState="true" ID="lblLevel1"  runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Level1Text")%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- Level 2 --%>
                                <asp:TemplateField  HeaderText="Reports List" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label EnableViewState="true" ID="lblLevel2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Level2Text")%>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <%--                        <asp:AsyncPostBackTrigger ControlID="btnExecuteOrder" EventName="Click" />
--%>
                        <asp:AsyncPostBackTrigger ControlID="lnkViewCurrentRights" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="AssignRights1" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="AssignRights2" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="CheckAll" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="UnCheckAll" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="right">
                <asp:UpdatePanel ID="upAssignRights2" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:LinkButton runat="server" ID="AssignRights2" Text="Assign Rights" CssClass="bluefnt"
                            Font-Bold="true" OnClick="AssignRights"></asp:LinkButton>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server"  UpdateMode="conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:Label ID="lblDone2" runat="server" CssClass="redfnt"></asp:Label>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="lnkViewCurrentRights" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="AssignRights1" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="AssignRights2" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
</asp:Content>
