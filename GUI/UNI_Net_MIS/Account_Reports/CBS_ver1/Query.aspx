<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_Account_Reports_CBS_ver1_Query"  %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy_Location_Wise_BankDetail.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript"  type="text/javascript" src="../../../Images/CalendarPopup.js"></script>

    <script language="javascript"  type="text/javascript" src="../../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();

function OnSub_DATACHECK()
     {
        
     
     //alert("HIii")
        if(!DateCheck())
            return false;
      //  alert("HIii")
        if(!FinDateCheck())
            return false;             
     }
    </script>

    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>&gt;<font class="blklnkund"><strong> Accounts </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>Cash & Bank Report</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <div align="center">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="../../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" style="width: 7.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="4">
                                <font class="blackfnt"><b>Select Voucher Criteria</b></font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="4">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <font class="blackfnt">Select Voucher Date</font>
                            </td>
                            <td align="left" colspan="3">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                          
                         <%--<tr id="Tr1" visible="true" runat="server" style="background-color: white">
                            <td align="left" >
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Account" runat="server"></asp:Label></td>
                            <td align="left" colspan="3" valign="top">
                                <asp:DropDownList ID="DLLAcc" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>--%>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                 <asp:RadioButtonList ID="rpttyp" RepeatDirection="horizontal"
                        CssClass="blackfnt" runat="server">
                        <asp:ListItem Text="Register" Selected Value="1"></asp:ListItem>
                          <asp:ListItem Text="Location Wise(Summary)" Value="2"></asp:ListItem>
                        </asp:RadioButtonList>
                        
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                 <asp:RadioButtonList ID="rptmd" RepeatDirection="horizontal"
                        CssClass="blackfnt" runat="server">
                        <asp:ListItem Text="HTML Format" Selected Value="N"></asp:ListItem>
                          <asp:ListItem Text="XLS Format" Value="Y"></asp:ListItem>
                        </asp:RadioButtonList>
                        
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click"   OnClientClick="Javascript:return OnSub_DATACHECK();"
                                    runat="server" Text="Show" Width="75px" />
                                    <%--OnClientClick="Javascript: return DateCheck();"--%>
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
