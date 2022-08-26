<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="GRNViewPrintCriteria.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_POViewPrint_POViewPrintCriteria" %>


<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" TagName="WebxComplete"
    TagPrefix="xac" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="../../../images/CalendarPopup.js"type="text/javascript"></script>

    <script language="javascript" src="../../../images/commonJs.js" type="text/javascript"></script>

    <script language="JavaScript" type="text/javascript">
    
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	 function OnSub_DATACHECK()
     {
        if(!DateCheck())
            return false;
     }

     function Validation() 
     {
        if(!DateCheck())
            return false;

        if(document.getElementById('ctl00_MyCPH1_rdDocketCri').checked == true && document.getElementById('ctl00_MyCPH1_txtDocketNo').value == '')
        {
            alert('Please Enter the PO No');
            document.getElementById('ctl00_MyCPH1_txtDocketNo').focus();
            document.getElementById('ctl00_MyCPH1_txtDocketNo').select();
            return false;
        }
    }
    
        
    </script>
<asp:HiddenField ID="hidDocTypeCode" runat="server" />
    <div align="left">
        <br />
        <table cellspacing="1" class="boxbg" align="left">
            <tr class="bgbluegrey">
                <td colspan="3" align="center">
                    <asp:Label ID="lblQry" CssClass="ffnt" Font-Bold="true" runat="server" Text="Selection Criteria For GRN Details"></asp:Label>
                </td>
            </tr>            
            <tr bgcolor="white">
                <td rowspan="2" style="width: 10px">
                    <asp:RadioButton ID="rdDateRange" GroupName="grpcri" runat="server" />
                </td>
                <td align="left" style="width: 130px">
                    <font class="blackfnt">Select GRN Date </font>&nbsp;
                </td>
                <td align="left" style="width: 5in">
                    <Date:DT ID="DT" runat="server" />
                </td>
            </tr>
            <tr bgcolor="white">
                <td style="width: 150px">
                    <asp:Label ID="lblPartyCode" runat="server" CssClass="blackfnt">Enter Vendor Code</asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPartyCode" runat="server" CssClass="ltxtm" Width="70px" MaxLength="20"></asp:TextBox><asp:TextBox ID="txtPartyName" 
                    runat="server" Width="150px" MaxLength="200"></asp:TextBox><br />
                    <xac:WebxComplete ID="xacpartycode" runat="server" MinPrefixLength="2" WebxEntity="Vendor"
                        CodeTarget="txtPartyCode" NameTarget="txtPartyName" />
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="center" colspan="3">
                    OR
                </td>
            </tr>
            <tr bgcolor="white">
                <td valign="middle">
                    <asp:RadioButton ID="rdDocketCri" GroupName="grpcri" runat="server" />
                </td>
                <td style="width: 130px">
                    <asp:Label ID="lblDocketNo" runat="server" CssClass="blackfnt" Text="Enter GRN Code"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtGRNNo" runat="server" BorderStyle="groove" CssClass="ltxt"
                        MaxLength="500"></asp:TextBox>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="center" colspan="3">
                    OR
                </td>
            </tr>
            <tr bgcolor="white">
                <td valign="middle">
                    <asp:RadioButton ID="rdmanualGRN" GroupName="grpcri" runat="server" />
                </td>
                <td style="width: 130px">
                    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="Enter Manual GRN No"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtManualGRNNo" runat="server" BorderStyle="groove" CssClass="ltxt"
                        MaxLength="500"></asp:TextBox>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td class="bgbluegrey" colspan="3">
                    <asp:Button ID="btnShow" OnClientClick="Javascript:return Validation();" runat="server"
                        Text="Show" Width="75px" BorderStyle="Groove" OnClick="btnShow_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99; left: -74px; top: 1px;">
    </div>
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

