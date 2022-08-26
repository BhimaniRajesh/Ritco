<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_DKT_Profi_Query" %>

<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>
    <script language="javascript" src="./../../images/commonJs.js"></script>
    <script language="JavaScript" type="text/javascript">
     var cal = new CalendarPopup("testdiv1"); 
	 cal.setCssPrefix("TEST");
	 cal.showNavigationDropdowns();
	       
     function OnSub_DATACHECK()
     {     
        var ddlDocType = document.getElementById("ctl00_MyCPH1_ddlDocType");  
        if(ddlDocType.value == "0")
        {
               alert("Please select Document Type.");
               ddlDocType.focus();
               return false;
        }       
        return true;      
     }
    </script>

   
   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 23/5/2014 --%>
 <div align="left">
        <table style="width: 8.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>LS/MF Report</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0">
                    </a>
                    <div align="Left">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                                <br />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" cellpadding="3" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Report Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center">
                                <font class="blackfnt">Select Document Type </font>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlDocType" runat="server" CssClass="blackfnt">
                                    <asp:ListItem Selected="True" Value="0">---Select---</asp:ListItem>
                                    <asp:ListItem Value="LS">Loading Sheet</asp:ListItem>
                                    <asp:ListItem Value="MF">Manifest</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="2">
                                <Location:HR ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center">
                                <font class="blackfnt">Select Delivery Date </font>
                            </td>
                            <td align="left">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" colspan="2">
                                OR
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center">
                                <font class="blackfnt">Document No(s) : </font>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDocNos" Width="250px" BorderStyle="Groove" runat="server" CssClass="blackfnt"></asp:TextBox> [seperated by comma if multiple]
                            </td>
                        </tr>
                        <tr align="center" class="bgbluegrey">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return OnSub_DATACHECK();"
                                    runat="server" Text="Submit" Width="75px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
