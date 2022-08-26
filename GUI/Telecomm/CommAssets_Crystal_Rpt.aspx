<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="CommAssets_Crystal_Rpt.aspx.cs" Inherits="GUI_Telecomm_CommAssets_Crystal_Rpt" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <br />
    <CR:CrystalReportViewer ID="CRVAssetsReg" runat="server" AutoDataBind="true" />
</asp:Content>
