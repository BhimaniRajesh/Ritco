<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MobileTrack_Result.aspx.cs" Inherits="MobileTrack_Result" %>
<%@ Register TagPrefix="mobile" Namespace="System.Web.UI.MobileControls" Assembly="System.Web.Mobile" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<body>
    <mobile:Form id="Form1" runat="server">
        <mobile:Label ID="Label1" Runat="server" Alignment="Center" Font-Bold="True" Font-Name="Arial">WebXpress Mobile Tracking</mobile:Label>
        <br />
        <br />
        <mobile:Label ID="Label2" Runat="server" Font-Bold="True" Font-Name="Arial" Font-Size="Small">Tracking Information</mobile:Label>
        <br />
        <mobile:Panel ID="Panel1" Runat="server">
            <mobile:Label ID="lblDocket" Runat="server" Font-Name="Arial" Font-Size="Small">
            </mobile:Label>
            <mobile:Label ID="lblOrgDest" Runat="server" Font-Name="Arial" Font-Size="Small">
            </mobile:Label>
            <mobile:Label ID="lblFromTo" Runat="server" Font-Name="Arial" Font-Size="Small">
            </mobile:Label>
            <mobile:Label ID="lblEDD" Runat="server" Font-Name="Arial" Font-Size="Small">
            </mobile:Label>
            <mobile:Label ID="lblStatus" Runat="server" Font-Name="Arial" Font-Size="Small">
            </mobile:Label>
            <mobile:Label ID="lblDelivered" Runat="server" Font-Name="Arial" Font-Size="Small">
            </mobile:Label>
        </mobile:Panel>
        <br />
    </mobile:Form>
</body>
</html>
