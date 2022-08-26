<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_InTransitStock_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        <strong>Operation</strong></font><font class="bluefnt"><strong></strong>&gt;<strong>InTransit
                            Stock Report </strong></font>
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
            </td>
        </tr>
    </table>
    <br /><br /><br /><br /><br /><br />
    <table id="selection" runat="server" style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
    <%--<asp:Table ID="selection" runat="server" Width="10.5in" BorderWidth="1" HorizontalAlign="Left" CellSpacing="0" CellPadding="0">--%>
        <tr>
            <td valign="top" height="30">
                <p align="left">
                    <label class="blackfnt">
                        <b>You Selected </b>
                    </label>
                </p>
                <table runat="server" id="TBL_CRI" border="0" cellpadding="3" width="400" cellspacing="1"
                    align="left" class="boxbg">
                    <tr style="background-color: #ffffff">
                        <td style="height: 10px">
                            <label class="blackfnt">
                                Date :</label></td>
                        <td style="height: 10px">
                            <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 15px;">
                            <label class="blackfnt">
                               From RO :</label></td>
                        <td style="width: 343; height: 15px;">
                            &nbsp;
                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205">
                            <label class="blackfnt">
                               From Location :</label></td>
                        <td style="width: 343">
                            &nbsp;
                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 15px;">
                            <label class="blackfnt">
                               To RO :</label></td>
                        <td style="width: 343; height: 15px;">
                            &nbsp;
                            <asp:Label ID="lblToRO" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205">
                            <label class="blackfnt">
                               To Location :</label></td>
                        <td style="width: 343">
                            &nbsp;
                            <asp:Label ID="lblToLoc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
       </table>
       <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
        <table id="Table1" runat="server" style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td align="left">
                <br />
                <asp:Button ID="btn_csv1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv1_Click" />
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="dgDocket" runat="server" EmptyDataText="No Records Found" CssClass="boxbg"
                    HeaderStyle-CssClass="bgbluegrey" BorderWidth="0" OnRowDataBound="dgDocket_RowDataBound"
                    CellPadding="3" CellSpacing="1" AutoGenerateColumns="true">
                    <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"
                        Width="200" />
                </asp:GridView>
                <br />
            </td>
        </tr>
        <tr>
            <td align="left">
                <br />
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
