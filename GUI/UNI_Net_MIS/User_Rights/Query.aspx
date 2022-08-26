<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_User_Rights_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>User Rights Management Reprot </strong></font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0">
                    </a>
                    <div align="Left">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                                <br />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <asp:UpdatePanel ID="upTHCCreate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
                        <ContentTemplate>
                            <table cellspacing="1" cellpadding="3" style="width: 6.5in" class="boxbg" align="left">
                                <tr class="bgbluegrey">
                                    <td colspan="2" align="center" style="height: 21px">
                                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Criteria </asp:Label>
                                    </td>
                                    <tr bgcolor="white">
                                    <td  align="left" style="height: 21px">
                                        <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server">Enter Location  </asp:Label>
                                    </td>
                                        <td  align="left" style="height: 21px">
                                            <asp:TextBox ID="txtNextStop" runat="server" CssClass="input" Text="" MaxLength="5"
                                                Width="250" AutoPostBack="true" OnPreRender="NextStop_TextChanged" OnTextChanged="NextStop_TextChanged"></asp:TextBox>
                                            <asp:RequiredFieldValidator ValidationGroup="grpQuery" ID="RFVtxtNextStop" runat="server"
                                                ErrorMessage="*" ControlToValidate="txtNextStop" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                            <div id="Dic_Desc" runat="server" class="boxbg" />
<%--                                            <atlas:AutoCompleteExtender runat="server" ID="nextloc" DropDownPanelID="Dic_Desc">
                                                <atlas:AutoCompleteProperties TargetControlID="txtNextStop" ServicePath="../AtlasAutoComplete.asmx"
                                                    ServiceMethod="GetLocationRPT" MinimumPrefixLength="1" Enabled="true" />
                                            </atlas:AutoCompleteExtender>--%>
                                            
                                             <ajaxToolkit:AutoCompleteExtender ID="nextloc" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                                ServiceMethod="GetLocationRPT" ServicePath="../AtlasAutoComplete.asmx" TargetControlID="txtNextStop">
                                            </ajaxToolkit:AutoCompleteExtender>
                                            <asp:Label ID="lblError1" runat="server" Text="Invalid Next Location" Visible="false"
                                                CssClass="redfnt"></asp:Label>
                                                <font class="blackfnt"  ><i>(## if Blank then All)</i></font>
                                        </td>
                                    </tr>
                                <tr bgcolor="white">
                                <td  align="left" style="height: 21px">
                                        <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" runat="server">Enter Employee  </asp:Label>
                                    </td>
                                    <td  align="left">
                                        <asp:TextBox CssClass="input" ID="txtPreparedBy" runat="server" AutoPostBack="true"
                                            MaxLength="15" Width="250" OnTextChanged="PreparedBy_TextChanged"></asp:TextBox>
                                        <asp:RequiredFieldValidator ValidationGroup="grpQuery" ID="RFVtxtPreparedBy" runat="server"
                                            ErrorMessage="*" ControlToValidate="txtPreparedBy" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                             <div id="Dic_Desc1" runat="server" class="boxbg" />
                                            <atlas:AutoCompleteExtender runat="server" ID="AutoCompleteExtender1" DropDownPanelID="Dic_Desc1">
                                                <atlas:AutoCompleteProperties TargetControlID="txtPreparedBy" ServicePath="../AtlasAutoComplete.asmx"
                                                    ServiceMethod="GetEmployeeRPT" MinimumPrefixLength="1" Enabled="true" />
                                            </atlas:AutoCompleteExtender>
                                        <asp:Label ID="lblError2" runat="server" Text="Invalid User Code" Visible="false"
                                            CssClass="redfnt"></asp:Label>
                                            <font class="blackfnt"  ><i>(## if Blank then All)</i></font>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td colspan="2" align="left">
                                        <asp:Button ID="btnSubmit"  runat="server" Text="Submit >>"
                                            OnClick="ShowDocketsForMF" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
