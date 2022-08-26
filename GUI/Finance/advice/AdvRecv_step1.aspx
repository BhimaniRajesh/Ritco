<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AdvRecv_step1.aspx.cs" Inherits="GUI_finance_advice_AdvRecv_step1" Title="Untitled Page" %>
<%@ Register TagPrefix="UC3" TagName="UCSelectDate" Src="~/UserControls/SelectDate.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
  <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Advice Acknowledgement</asp:Label>
                <hr align="center" size="1" color="#8ba0e5" />
            </td>
        </tr>
    </table>
    <br />
    <br>
<table border="0" cellspacing="1" cellpadding="4" width="65%" align="center" class="boxbg">
        <tr class="bgbluegrey">
                        <td colspan="2" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                        </td>
                    </tr>
       <tr style="background-color: white">
                        <td width="20%" >
                            <asp:Label ID="lblWarehouses" CssClass="blackfnt" runat="server" Font-Bold="True">Advice No</asp:Label>
                        </td>
                        <td align="left" colspan="1" style="width: 786px">
                            <asp:UpdatePanel ID="up1" RenderMode="Inline"  UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:TextBox CssClass="input" ID="txtAdviceNo" runat="Server" ValidationGroup="VGWarehousesID" BorderStyle="Groove" Width="151px"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFVWarehousesID" runat="server" ControlToValidate="txtAdviceNo"
                                        ErrorMessage="*" ValidationGroup="VGWarehousesID" />
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="cmdSubmit1" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td colspan="2" align="right">
                           
                                    <asp:Button ID="cmdSubmit1" runat="server" Text="Submit" ValidationGroup="VGWarehousesID" OnClick="cmdSubmit1_Click" />
                             
                        </td>
                    </tr>
                     <tr style="background-color: white">
                        <td align="center" colspan="3">
                            <asp:Label ID="lblOR" CssClass="blackfnt" runat="server" Font-Bold="true">
                                OR
                            </asp:Label>
                        </td>
                    </tr>
        <tr style="background-color: white">
            <td align="left" colspan="2">
            <UC3:UCSelectDate ID="UCSelectDate" runat="server"></UC3:UCSelectDate>

            </td>
        </tr> 
         <tr style="background-color: white">
                        <td colspan="2" align="right">
                         
                                    <asp:Button ID="cmdSubmit2" runat="server" Text="Submit"  OnClick="cmdSubmit2_Click" ValidationGroup="VGDtFromTo"/>
                               
                        </td>
                    </tr>
</table>             
</asp:Content>

