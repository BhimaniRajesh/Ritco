<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_MIS_OCT_RPT_Query" %>


<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="../../Images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

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
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>
                            &gt; </strong><strong>Octroi Report</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                <div align="center"><asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress></div>
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" style="width: 8.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="0"  >
                                <font class="blackfnt"></font>
                            </td>
                            <td colspan="4"  >
                                <font class="blackfnt"><b>Select Documnet Criteria</b></font>
                            </td>
                        </tr>
                        
                        <tr style="background-color: white">
                            <td align="center" colspan="2">
                                <font class="blackfnt">Select Documnet Date</font>
                            </td>
                            <td align="left" colspan="2">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                            <td align="left" colspan="2">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Status" runat="server"></asp:Label></td>
                            <td align="left" colspan="2" valign="top">
                                <asp:DropDownList ID="documet_type" runat="server" CssClass="blackfnt">
                                <asp:ListItem Text="All" Value="All" ></asp:ListItem>
                                <asp:ListItem Text="Octroi Agent Bill Done-Direct Payment Made" Value="1" ></asp:ListItem>
                                <asp:ListItem Text="Octroi Agent Bill Done-Direct Payment Not Made" Value="2" ></asp:ListItem>
                                <asp:ListItem Text="Octroi Direct Payment Done" Value="3" ></asp:ListItem>
                                <asp:ListItem Text="Octroi Agent Bill Done/Payment Made But Customer Bill/MR to Raise" Value="4" ></asp:ListItem>
                                <asp:ListItem Text="Octroi Cycle close" Value="5" ></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="2">
                            <font class="blackfnt"> Document No(s).  :</font>
                            </td>
                            <td align="left" colspan="2">
                            <asp:TextBox runat="server" Text="" ID="txtsysno" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="2">
                            <font class="blackfnt"> Octroi Bill No.:</font>
                            </td>
                            <td align="left" colspan="2">
                            <asp:TextBox runat="server" Text="" ID="txtOctBILLno" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" colspan="2">
                            <font class="blackfnt"> Octroi MR No. :</font>
                            </td>
                            <td align="left" colspan="2">
                            <asp:TextBox runat="server" Text="" ID="txtOctMrno" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr id="TRDWN" runat="server" align="center" bgcolor="white">
                            <td colspan="4">
                                <asp:RadioButtonList ID="rptmd" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Text="HTML Format" Selected="true" Value="N"></asp:ListItem>
                                    <asp:ListItem Text="XLS DownLoad" Value="Y"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                <td colspan="4">
                </td>
            </tr>
                        <tr align="center" bgcolor="white">
                <td colspan="4">
                    <asp:Button ID="btnShow" OnClick="btnShow_Click" 
                        runat="server" Text="Show" Width="75px" OnClientClick="Javascript:return OnSub_DATACHECK();" />
                </td><%--OnClientClick="Javascript: return OnSub_DATACHECK();"--%>
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
