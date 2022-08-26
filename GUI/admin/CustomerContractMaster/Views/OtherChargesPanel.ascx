<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OtherChargesPanel.ascx.cs" Inherits="Views_OtherChargesPanel" %>
<%@ Register TagPrefix="uc" TagName="StanderdCharge" Src="~/GUI/admin/CustomerContractMaster/Views/StanderdCharge.ascx" %>
<%@ Register TagPrefix="uc" TagName="UpdateProgess" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>

 <div> 
        <asp:UpdatePanel runat="server" ID="updtPNL" Mode="Conditional">
            <ContentTemplate>
                <asp:Menu ID="menuTabs" CssClass="menuTabs" StaticMenuItemStyle-CssClass="tab" StaticSelectedStyle-CssClass="selectedTab"
                    Orientation="Horizontal" OnMenuItemClick="menuTabs_MenuItemClick" EnableViewState="true" runat="server">
                    <Items>
                        <asp:MenuItem Text="Tab 1" Value="0" Selected="true" />
                        <asp:MenuItem Text="Tab 2" Value="1" />
                        <asp:MenuItem Text="Tab 3" Value="2" />                        
                    </Items>                
                </asp:Menu>
                <div class="tabBody">
                    <asp:MultiView ID="multiTabs" ActiveViewIndex="0" runat="server" EnableViewState="true">
                        <asp:View ID="view1" runat="server">      
                            <uc:StanderdCharge  runat="server" ID="ucCharges" />                      
                        </asp:View>                       
                    </asp:MultiView>
                </div>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="menuTabs" EventName="MenuItemClick"/>
            </Triggers>
        </asp:UpdatePanel>
  </div>