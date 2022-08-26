<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DocketReportingUnloadingDeviationResult.aspx.cs" Inherits="GUI_Operations_FM_NewPODModules_DocketReportingUnloadingDeviationResult"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="2" style="width: 900px">
        <tr style="background-color: white">
            <td align="left" style="width: 50%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Deviation Result:</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
            <td align="left">
                <font class="blackfnt">&nbsp;</font>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="left" >
                <table cellspacing="2" cellpadding="3" class="boxbg" style="width: 900px">
                    <tr class="bgbluegrey" >
                        <td align="left" style="width: 50%">
                        <font class="blackfnt"><b>Docket Deviation done Sucussesfully...</b></font>
                        </td>
                    </tr>
                    <tr style="background-color: white">
            <td align="left">
                <font class="blackfnt"><a href="./DocketReportingUnloadingDeviationCriteria.aspx"><u>Click here to go Deviation Module</u></a></font>
            </td>
        </tr>
                </table>
            </td>
        </tr>
        
    </table>
</asp:Content>
