<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="MainSecondaryContractMaster.aspx.cs" Inherits="MainSecondaryContractMaster"
    EnableEventValidation="false" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgr" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <br />
    <br />
    <asp:UpdatePanel runat="server" ID="updone">
        <ContentTemplate>
            <asp:Panel runat="server" Width="10in">
                <asp:Table runat="server" HorizontalAlign="Center" CellSpacing="1" CssClass="ftbl"
                    Style="width: 70%">
                    <asp:TableRow CssClass="hrow" runat="server">
                        <asp:TableCell ColumnSpan="2"  Font-Bold="true" HorizontalAlign="center">
                            Secondary Contract Master
                        </asp:TableCell>
                    </asp:TableRow>
                   
                    <asp:TableRow ID="trcust" Visible="false" runat="server" CssClass="nrow">
                     <asp:TableCell>
                           Select Customer 
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:DropDownList ID="ddlcustomer" runat="Server" BackColor="White" DataValueField="custcd"
                                DataTextField="custname" CssClass="cmbm" Width="500px">
                            </asp:DropDownList>
                        </asp:TableCell>
                    </asp:TableRow>
                   
                    <asp:TableRow ID="trnext" Visible="false" runat="server" CssClass="frow">
                        <asp:TableCell ColumnSpan="2"  HorizontalAlign="Right">
                            <asp:Button ID="btnnext" Text="Next >>" CssClass="fbtn" runat="server" 
                                OnClick="btnnext_Click" />&nbsp;
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
            </asp:Panel>
            <asp:HiddenField ID="hdnflagedit" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <pgr:ProgressBar ID="pgrone" runat="server" />
</asp:Content>
