<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MenifestPrint.aspx.cs" Inherits="GUI_Print_MenifestPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Menifest Print</title>
    <link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
 <object id="objPrint" classid="CLSID:91DF5E28-29FB-4D68-A027-60F581A55443"     codebase="http://202.87.45.77/webx/dosprint/print_utility/webx_dos_print.cab#version=1,0,0,0"></object>
    <form id="form1" runat="server">
        
        <br />
        
        <table bgcolor="#ffffff" border="0" cellpadding="3" cellspacing="1" class="boxbg"
            width="100%">
            <tr bgcolor="#ffffff">
                <td align="center">
                    <font class="blackfnt">Dep.date and time</font>
                </td>
                <td align="left" >
                    <font class="blackfnt"><b>
                        <asp:Label ID="lblMFDate" runat="server" Font-Bold="False"></asp:Label></b></font>
                </td>
                <td align="center">
                    <font class="blackfnt">Page No</font>
                </td>
                <td align="left">
                    <font class="blackfnt"><b>
                        <asp:Label ID="lblPageNo" runat="server" Font-Bold="False"></asp:Label></b></font>
                </td>
            </tr>
            
            <tr bgcolor="#ffffff">
                <td align="center">
                    <font class="blackfnt">VHC No</font>
                </td>
                <td align="left" >
                    <font class="blackfnt"><b>
                        <asp:Label ID="LblTHCNo" runat="server" Font-Bold="False"></asp:Label></b></font>
                </td>
                <td align="center">
                    <font class="blackfnt">Vehicle No</font>
                </td>
                <td align="left">
                    <font class="blackfnt"><b>
                        <asp:Label ID="LblVehicle" runat="server" Font-Bold="False"></asp:Label></b></font>
                </td>
            </tr>
            
            <tr bgcolor="#ffffff">
                <td align="center">
                    <font class="blackfnt">ManifestNo</font>
                </td>
                <td align="left" >
                    <font class="blackfnt"><b>
                        <asp:Label ID="lblMFNo" runat="server" Font-Bold="False"></asp:Label></b></font>
                </td>
                <td align="center">
                    <font class="blackfnt">From-To</font>
                </td>
                <td align="left">
                    <font class="blackfnt"><b>
                        <asp:Label ID="LblFromTo" runat="server" Font-Bold="False"></asp:Label></b></font>
                </td>
            </tr>
            
            <tr bgcolor="#ffffff">
                <td align="center">
                    <font class="blackfnt">Route Path</font>
                </td>
                <td align="left" >
                    <font class="blackfnt"><b>
                        <asp:Label ID="LblRoute" runat="server" Font-Bold="False"></asp:Label></b></font>
                </td>
                <td align="center">
                    <font class="blackfnt">Print Date & Time</font>
                </td>
                <td align="left">
                    <font class="blackfnt"><b>
                        <asp:Label ID="lblPrintDate" runat="server" Font-Bold="False"></asp:Label></b></font>
                </td>
            </tr>
            
            <tr bgcolor="#ffffff">
                <td align="center">
                    <font class="blackfnt">Seal No</font>
                </td>
                <td align="left" colspan="3">
                    <font class="blackfnt"><b>
                        <asp:Label ID="lblSealNo" runat="server" Font-Bold="False"></asp:Label></b></font>
                </td>
                
            </tr>
        </table>
        <br />
        
        <br />
        <asp:Table id="tblMFDKT" visible="false" runat="server" CellPadding="3" CellSpacing="1" Width="100%" CssClass="boxbg">
        
        </asp:Table>
        
         <br />
        
        <br />
        <table bgcolor="#ffffff" border="0" cellpadding="3" cellspacing="1" class="boxbg"
            width="100%">
            <tr bgcolor="#ffffff">
                <td align="left" style="width:200px">
                    <font class="blackfnt"><b>Staff Code</b></font>
                </td>
                <td align="left" style="width:400px" colspan="4">
                    <font class="blackfnt"><b>
                        <asp:Label ID="lblStaffCode" runat="server" Font-Bold="False" ></asp:Label></b></font>
                </td>
                <td align="left" style="width:200px">
                    <font class="blackfnt"><b>Signature</b></font>
                </td>
                <td align="left" style="width:400px">
                    <font class="blackfnt"><b>
                        <asp:Label ID="lblSign" runat="server" Font-Bold="False" ></asp:Label></b></font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="width:200px">
                    <font class="blackfnt"><b>Staff Name</b></font>
                </td>
                <td align="left" style="width:400px" colspan="14">
                    <font class="blackfnt"><b>
                        <asp:Label ID="lblStaffName" runat="server" Font-Bold="False"></asp:Label></b></font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="width:400px" colspan="14">
                <font class="blackfnt"><b>
                        <asp:Label ID="Label1" runat="server" Font-Bold="False" Text=""></asp:Label></b></font>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="left" style="width:200px">
                    <font class="blackfnt"><b>Remarks</b></font>
                </td>
                <td align="left" style="width:400px" colspan="14">
                    <font class="blackfnt"><b>
                        <asp:Label ID="lblRemarks" runat="server" Font-Bold="False" ></asp:Label></b></font>
                </td>
            </tr>
        </table>
        <asp:Button ID="btnPrint" runat="server" Text="Print" OnClick="btnPrint_Click" />
        <br />
    </form>
</body>
</html>
