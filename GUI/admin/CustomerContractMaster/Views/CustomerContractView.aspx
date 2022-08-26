<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CustomerContractView.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_CustomerContractView" %>

<%@ Register Src="SundryChargesView.ascx" TagName="SundryChargesView" TagPrefix="ccm" %>
<%@ Register Src="ViewCCServices.ascx" TagName="ViewCCServices" TagPrefix="ccm" %>
<%@ Register TagPrefix="ccm" TagName="OtherChargesPanel" Src="~/GUI/admin/CustomerContractMaster/Views/OtherChargesPanel.ascx" %>
<%@ Register TagPrefix="pgb" TagName="UpdateProgess" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo" TagPrefix="cust" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/Views/ViewFTL.ascx" TagPrefix="ccm" TagName="ViewFTL" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/Views/ViewODACharges.ascx" TagPrefix="ccm" TagName="ODACharges" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <table border="0" align="left" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td height="30">
                <span class="blackfnt"><b>Customer Contract View</b></span>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="../../../images/clear.gif" width="2" height="1" /></td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <div>
        <cust:CustInfo runat="server" ID="cstheader" />
        <br />
        <pgb:updateprogess id="updtBar" runat="server" />
        <asp:UpdatePanel runat="server" ID="updtPNL"  UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Menu ID="menuTabs" CssClass="menuTabs" StaticMenuItemStyle-CssClass="tab" StaticSelectedStyle-CssClass="selectedTab"
                    Orientation="Horizontal" OnMenuItemClick="menuTabs_MenuItemClick" EnableViewState="true"
                    runat="server">
                    <Items>
                        <asp:MenuItem Text="Contract Services" Value="0" Selected="true" />
                        <asp:MenuItem Text="Standard Charges" Value="1" />
                        <asp:MenuItem Text="Freight Sundry Charges" Value="2" />
                        <asp:MenuItem Text="Freight FTL Charges" Value="3" />
                        <asp:MenuItem Text="ODA Charges" Value="4" />
                    </Items>
                </asp:Menu>
                <div class="tabBody">
                    <asp:MultiView ID="multiTabs" ActiveViewIndex="0" runat="server" EnableViewState="true">
                        <asp:View ID="view1" runat="server">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="blackfnt">
                                        <b>&nbsp;</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ccm:viewccservices id="ucVCCS" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="view2" runat="server">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="blackfnt">
                                        <b>&nbsp;</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ccm:otherchargespanel runat="server" id="ucOCP" />
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="view3" runat="server">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="blackfnt">
                                        <b>&nbsp;</b>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ccm:sundrychargesview id="ucSSV" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="view4" runat="server">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="blackfnt">
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <ccm:ViewFTL runat="server" ID="ucFTL" />
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                        <asp:View ID="view5" runat="server">
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="blackfnt">
                                        <ccm:ODACharges runat="server" ID="ViewODACharges" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                            </table>
                        </asp:View>
                    </asp:MultiView>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="menuTabs" EventName="MenuItemClick" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</asp:Content>
