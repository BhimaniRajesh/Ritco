<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ApppointmentRescheduleDone.aspx.cs" Inherits="SFM_ApppointmentRescheduleDone" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<table style="width: 100%">

        <tr>
            <td align="left"  colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Reschedule/Cancel Appointment" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
        </table>
        <br />
        
        
            <div align="center">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                      <ContentTemplate>
                      <asp:Panel ID="Panel2" runat="server" Width="100%" Visible="false">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="center">
                        <font class="bluefnt"><b>You have Successfully Cancelled Prospect :<asp:Label ID="prospectid" runat="server" Width="100px" ForeColor="red"></asp:Label></b></font>
                    </td>
                </tr>
            </table>
            </asp:Panel>
          </ContentTemplate>
          </asp:UpdatePanel>
          
          <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                      <ContentTemplate>
                      <asp:Panel ID="Panel1" runat="server" Width="100%" Visible="false">
            <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="center">
                        <font class="bluefnt"><b>You have Successfully Reschedule Prospect :<asp:Label ID="ProspectCode" runat="server" Width="100px" ForeColor="red"></asp:Label></b></font>
                    </td>
                </tr>
            </table>
            </asp:Panel>
          </ContentTemplate>
          </asp:UpdatePanel>
          <br />
          <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td align="center">
                        <a href="javascript:window.history.go(-1)" title="back">
                        <img border="0" src="../../images/back.gif" alt="" /></a>
                    </td>
                </tr>
            </table>
            <br />

</div>
</asp:Content>
