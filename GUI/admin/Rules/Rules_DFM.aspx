<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Rules_DFM.aspx.cs" Inherits="GUI_admin_Rules_Rules_DFM" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<table cellpadding="1" cellspacing="1" border="0" class="blackfnt">
        <tr>
            <td align="left">
                <label class="blackfnt">
                    <b>WebXPress DFM Rules</b>
                </label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        <tr bgcolor="white">
            <td>
               <table cellpadding="1" cellspacing="1" border="0" class="boxbg">
                    <tr class="bgbluegrey" align="center" style="font-weight:bold;">
                        <td></td>
                        <td nowrap>Sr. No</td>
                        <td nowrap>RuleID</td>
                        <td nowrap>Description</td>
                        <td nowrap>Default</td> 
                        <asp:Repeater ID="reptHdr" runat="server" OnItemDataBound="reptHdr_ItemDataBound">
                            <ItemTemplate>
                                <td nowrap>
                                    <asp:Label ID="lblHdr" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CodeDesc")%>'></asp:Label>
                                    <asp:HiddenField ID="hidDocTyp" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "CodeID")%>'/>
                                </td>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <td nowrap>
                                    <asp:Label ID="lblHdr" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CodeDesc")%>'></asp:Label>
                                    <asp:HiddenField ID="hidDocTyp" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "CodeID")%>'/>
                                </td>
                            </AlternatingItemTemplate>
                        </asp:Repeater>               
                    </tr>
                   <asp:Repeater ID="reptRules" runat="server" OnItemDataBound="reptRules_ItemDataBound">
                    <ItemTemplate>
                        <tr bgcolor="white">
                            <td align="center"><asp:CheckBox ID="chkEdit" runat="server"/></td>
                            <td nowrap align="center">                                
                                <%# Container.ItemIndex+1 %>
                            </td>
                            <td nowrap>
                                <asp:Label ID="lblRuleID" runat="server"></asp:Label></td>
                            <td nowrap>
                                <asp:Label ID="lblDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Description")%>'></asp:Label></td>
                            <td>
                                <asp:DropDownList ID="ddlDefValue" runat="server"></asp:DropDownList></td> 
                            <asp:Repeater ID="reptDocTyp" runat="server" OnItemDataBound="reptDocTyp_ItemDataBound">
                                <ItemTemplate>
                                    <td>
                                        <asp:DropDownList ID="ddlValue" runat="server"></asp:DropDownList>
                                        <asp:HiddenField ID="hidID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "ID")%>'/>
                                    </td>
                                </ItemTemplate>
                                <AlternatingItemTemplate> 
                                    <td>
                                        <asp:DropDownList ID="ddlValue" runat="server"></asp:DropDownList>
                                        <asp:HiddenField ID="hidID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "ID")%>'/>
                                    </td>
                                </AlternatingItemTemplate>
                            </asp:Repeater>                        
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr bgcolor="#f7f7f7">
                            <td align="center"><asp:CheckBox ID="chkEdit" runat="server"/></td>
                            <td nowrap align="center">
                                <%# Container.ItemIndex+1 %>
                            </td>
                            <td nowrap>
                                <asp:Label ID="lblRuleID" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "CodeID")%>'></asp:Label></td>
                            <td nowrap>
                                <asp:Label ID="lblDesc" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Description")%>'></asp:Label></td>
                            <td nowrap>
                                <asp:DropDownList ID="ddlDefValue" runat="server"></asp:DropDownList></td> 
                            <asp:Repeater ID="reptDocTyp" runat="server" OnItemDataBound="reptDocTyp_ItemDataBound">
                                <ItemTemplate>
                                    <td>
                                        <asp:DropDownList ID="ddlValue" runat="server"></asp:DropDownList>
                                        <asp:HiddenField ID="hidID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "ID")%>'/>
                                    </td>
                                </ItemTemplate>
                                <AlternatingItemTemplate> 
                                    <td>
                                        <asp:DropDownList ID="ddlValue" runat="server"></asp:DropDownList>
                                        <asp:HiddenField ID="hidID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "ID")%>'/>
                                    </td>
                                </AlternatingItemTemplate>
                            </asp:Repeater>                         
                        </tr>
                    </AlternatingItemTemplate>
                   </asp:Repeater>
               </table> 
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="center">
                <table class="boxbg" cellpadding="1" cellspacing="1" border="0" width="100%">
                    <tr class="bgbluegrey">
                        <td align="center">
                            <asp:Button ID="btnSave" runat="server" Text="Save" Width="100" Font-Bold="true" OnClick="btnSave_Click"/>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="center">
                <asp:Label ID="lblMsg" runat="server" ></asp:Label></td>
        </tr>
    </table>
</asp:Content>

