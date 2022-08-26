<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="StepSelection.aspx.cs" Inherits="GUI_admin_CustomerContractMaster_StepSelection" %>

<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo"
    TagPrefix="cust" %>
<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagPrefix="pgr" TagName="ProgressBar" %>
<asp:Content ID="cntone" ContentPlaceHolderID="MyCPH1" runat="server">
    <cust:CustInfo runat="server" ID="cstheader" />
    <br />
    <asp:Panel runat="server" Width="10in" HorizontalAlign="Center">
        <pgr:ProgressBar ID="pgr" runat="server" />
        <asp:Table Width="5in" runat="server" CssClass="ftbl" CellPadding="0" CellSpacing="1"
            BorderWidth="0">
            <asp:TableRow CssClass="hrow">
                <asp:TableCell ColumnSpan="2" HorizontalAlign="Left" Font-Bold="true">
            &nbsp;Select Step
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trintro" runat="server" BackColor="White">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optintro" runat="server" GroupName="grvchoose" CssClass="nfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Contract Basic Information
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trservices" runat="server" CssClass="nrow">
                <asp:TableCell HorizontalAlign="Center">
                    <asp:RadioButton ID="optservices" runat="server" GroupName="grvchoose" CssClass="nfnt" />
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="Left">
                &nbsp;Service Selection
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow ID="trsubmit" runat="server" CssClass="hrow">
                <asp:TableCell HorizontalAlign="Center" ColumnSpan="2">
                    <asp:Button ID="btnSubmit" CssClass="hbtn" Text="Submit" runat="server" ToolTip="Click here to submit and proceed"
                        OnClick="btnSubmit_Click" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
        <asp:HiddenField ID="hdncontractid" runat="server" />
        <asp:HiddenField ID="hdncustcode" runat="server" />
    </asp:Panel>
</asp:Content>
