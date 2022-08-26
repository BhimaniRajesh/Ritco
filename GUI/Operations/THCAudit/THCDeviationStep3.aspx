<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="THCDeviationStep3.aspx.cs" Inherits="GUI_Operations_THCAudit_THCDeviationStep3" %>


<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="HR_To" TagPrefix="Location_To" Src="~/GUI/Common_UserControls/LOC_HRCHY_TO.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Oprations</strong></font><font class="bluefnt"><strong>
                            &gt; </strong><strong>THC Deviation Module</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../images/clear.gif" alt="" width="2" height="1" /></td>
            </tr>
            
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" style="width: 9.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="3">
                                <font class="blackfnt"><b>Deviation THC Audited Successfully….  </b></font>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="3">
                                 <a href="THCDeviationStep1.aspx"><font class="Blackfnt"><u>Click here for more Deviation THC Audit</u></font></a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
