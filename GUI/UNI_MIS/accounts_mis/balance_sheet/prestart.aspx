<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="prestart.aspx.cs" Inherits="GUI_UNI_MIS_accounts_mis_balance_sheet_prestart" %>
<%@ Reference Control="~/GUI/DateSelectorWL.ascx" %>
<%@ Register TagPrefix="SControls" TagName="DateSelector" Src="~/GUI/DateSelectorWL.ascx" %>
<asp:Content ContentPlaceHolderID="MyCPH1" ID="BalanceSheet" runat="server">

    <script type="text/javascript" language="javascript" src="../../../cal/popcalendar.js"></script>

    <script type="text/javascript">
    var redToday;
    var redFromTo;
    var redSevenDay;
    var FrmChild;
    function Error()
    {
         if(document.getElementById('ctl00$MyCPH1$dlstBranch').value == "")
         {
            alert("Please Select Branch / Profit Center");
         }
         else if(document.getElementById('ctl00$MyCPH1$OnDate$txt_Date').value == "")
         {
            alert("Please Select As on Date");
         }
         else
         {
            return true;
         }
         
         return false;
 
    }
///////////////////////////////////////////////


    </script>

    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <table width="95%" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr>
                        <td height="30">
                            <a href="#"></a>
                        </td>
                    </tr>
                    <tr>
                        <td class="horzblue">
                            <img src="../../../images/clear.gif" width="2" height="1"></td>
                    </tr>
                    <tr>
                        <td>
                            <img src="../../../images/clear.gif" width="15" height="10"></td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td style="width: 10%">
                                        &nbsp;</td>
                                    <td width="50%" valign="top">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td height="300" valign="top">
                                                    <br>
                                                    <table border="0" cellpadding="3" width="55%" bgcolor="#808080" cellspacing="1" align="left"
                                                        cols="2" class="boxbg">
                                                        <tr class="bgbluegrey">
                                                            <td align="center" colspan="4">
                                                                <p align="center">
                                                                    <font class="blackfnt">Select Branch / Profit Center </font>
                                                                </p>
                                                            </td>
                                                        </tr>
                                                        <tr bgcolor="#FFFFFF">
                                                            <td align="center" colspan="1">
                                                                <div align="right">
                                                                    <font class="blackfnt">Select Branch / Profit Center</font> :
                                                                </div>
                                                            </td>
                                                            <td bgcolor="#FFFFFF" align="center" colspan="2">
                                                                <div align="left">
                                                                    <font class="blackfnt">&nbsp;<asp:DropDownList ID="dlstBranch" runat="server" Width="250px">
                                                                    </asp:DropDownList>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="dlstBranch"
                                                                            ErrorMessage="*"></asp:RequiredFieldValidator></font></div>
                                                            </td>
                                                        </tr>
                                                        <tr bgcolor="#FFFFFF">
                                                            <td bgcolor="#FFFFFF" align="center" colspan="4">
                                                                <asp:RadioButtonList ID="dlstTranType" runat="server" RepeatDirection="Horizontal">
                                                                    <asp:ListItem Selected="True" Value="Y"><font class="blackfnt"><b>Individual</b></font></asp:ListItem>
                                                                    <asp:ListItem Value="N"><font class="blackfnt"><b>Cumulative (Transaction includes all branches)</b></font></asp:ListItem>
                                                                </asp:RadioButtonList></td>
                                                        </tr>
                                                        <tr class="bgbluegrey">
                                                            <td align="center" colspan="4">
                                                                <p align="center">
                                                                    <font class="blackfnt">Enter Date</font>
                                                            </td>
                                                        </tr>
                                                        <tr bgcolor="#FFFFFF">
                                                            <td height="22" colspan="2" align="right">
                                                                <b><font class="blackfnt">As on Date : </font></b>
                                                            </td>
                                                            <td height="22" colspan="1">
                                                                <SControls:DateSelector ID="OnDate" runat="server" />
                                                        </tr>
                                                        <tr>
                                                            <td bgcolor="#FFFFFF" align="center" colspan="4" height="22">
                                                                &nbsp;<asp:Button ID="btnSubmit" runat="server" BorderStyle="None" Font-Names="Verdana"
                                                                    Font-Size="Small" Style="text-decoration: underline" Text="Submit" Width="60px" OnClientClick="return Error(this)" OnClick="btnSubmit_Click" /></td>
                                                        </tr>
                                                    </table>
                                                    <br>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    &nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
