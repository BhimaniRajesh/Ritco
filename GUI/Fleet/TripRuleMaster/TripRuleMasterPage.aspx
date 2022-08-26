<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPageSA.master" AutoEventWireup="true"
    CodeFile="TripRuleMasterPage.aspx.cs" Inherits="GUI_Fleet_TripRuleMaster_TripRuleMasterPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <ajaxToolkit:TabContainer runat="server" ID="tabTripOperaton" ActiveTabIndex="0"
        CssClass="ajax__tab_msngallery-theme" Width="100%" Height="1000px">
        <ajaxToolkit:TabPanel runat="server" ID="Panel1" HeaderText="Fleet Operation">
            <ContentTemplate>
                <iframe id="Iframe1" src="../TripRuleMaster/TripRuleMaster.aspx" width="100%" height="600px"
                    runat="server"></iframe>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="TabPanel1" HeaderText="Fleet Accounts">
            <ContentTemplate>
                <iframe id="Iframe2" src="../TripRuleMaster/TripExpenseMst/TripExpense.aspx" width="100%"
                    height="600px" runat="server"></iframe>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" ID="TabPanel2" HeaderText="Fleet Finance">
            <ContentTemplate>
                <iframe id="Iframe3" width="100%" height="600px" runat="server" src="../TripRuleMaster/TripFinanceMst/TripFinance.aspx" ></iframe>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
         <ajaxToolkit:TabPanel runat="server" ID="TabPanel3" HeaderText="Back Date Control Setting">
            <ContentTemplate>
                <iframe id="Iframe4" src="../TripRuleMaster/BackDateControl/Back_Date_Control.aspx" width="100%" height="600px" runat="server"></iframe>
            </ContentTemplate>
        </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
</asp:Content>
