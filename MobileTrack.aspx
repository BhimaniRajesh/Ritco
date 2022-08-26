<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MobileTrack.aspx.cs" Inherits="MobileTrack" %>
<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<body>
    <mobile:Form id="Form1" runat="server">
        <mobile:Label ID="lblTitle" Runat="server" Alignment="Center" Font-Bold="True" Font-Name="Arial">WebXpress Mobile Tracking</mobile:Label>
        <br />
        <br />
        <mobile:Label ID="Label1" Runat="server" Font-Name="Arial">Select type of reference</mobile:Label>
        <mobile:SelectionList ID="listRefType" Runat="server" Font-Name="Arial" Title="Reference type">
            <Item Selected="True" Text="Docket Number" Value="DOC" />
            <Item Text="Invoice Number" Value="INV" />
            <Item Text="Customer Tracking Number" Value="CTN" />
        </mobile:SelectionList>
        <br />
        <mobile:Label ID="Label2" Runat="server" Font-Name="Arial">Enter Number</mobile:Label>
        <mobile:TextBox ID="txtNumber" Runat="server" Font-Name="Arial" Title="Number">
        </mobile:TextBox>
        <mobile:Command ID="cmdSubmit" Runat="server" Font-Name="Arial" OnClick="cmdSubmit_Click">Submit</mobile:Command>
        
    </mobile:Form>
</body>
</html>
