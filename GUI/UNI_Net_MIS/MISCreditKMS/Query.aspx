<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_MISCreditKMS_Query" %>
<asp:Content ID="Content1" ContentPlaceHolderID="CPHHeader" Runat="Server">
     <script type="text/javascript" language="javascript" src="./../../images/commonJs.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <table style="width: 7in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                    </strong><strong>MIS for Credit KMS Report </strong></font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
            </td>
        </tr>
        <tr>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="./../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
        <tr>
            <td>
                <table id="selection" border="0" cellspacing="1" cellpadding="3" class="boxbg" width="700">
                    <tr class="bgbluegrey">
                        <td colspan="2" align="left" style="height: 21px">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Criteria </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <font class="blackfnt">Select Vehicle</font>
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlVehicle" runat="server" />
                        </td>
                    </tr>
                    <tr class="bgwhite">
                         <td align="left">
                            <font class="blackfnt">Select Balance</font>
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlBalance" runat="server">
                                <asp:ListItem Value="" >ALL</asp:ListItem>      
                                <asp:ListItem Value="0" >Zero Balance</asp:ListItem>      
                                <asp:ListItem Value="1" >Credit Balance</asp:ListItem>      
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr align="center" class="bgbluegrey">
                        <td colspan="2">
                            <asp:Button ID="btnShow" runat="server" Text="Show" OnClick="btnShow_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div id="testdiv1" name="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

