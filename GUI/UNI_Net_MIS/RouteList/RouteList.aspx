<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" EnableEventValidation="false"
    CodeFile="RouteList.aspx.cs" Inherits="GUI_UNI_MIS_RouteList_RouteList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        <strong>Operation </strong></font><font class="bluefnt"><strong></strong>&gt;<strong>Root Performance Report</strong> </font>
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
        <tr>
            <td valign="top">
                <p align="left">
                    <label class="blackfnt">
                        <b>You Selected </b>
                    </label>
                </p>
                <table runat="server" id="TBL_CRI" border="0" cellpadding="3" width="400" cellspacing="1"
                    align="left" class="boxbg">
                    <tr id="tr1" runat="server" style="background-color: #ffffff">
                        <td style="height: 10px">
                            <label class="blackfnt">
                                Start Location :</label></td>
                        <td style="height: 10px">
                            <asp:Label ID="lblstartLoc" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr id="tr2" runat="server" style="background-color: #FFFFFF">
                        <td style="width: 205; height: 15px;">
                            <label class="blackfnt">
                                End Location :</label></td>
                        <td style="width: 343; height: 15px;">
                            <asp:Label ID="lblendloc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr id="tr3" runat="server" style="background-color: #FFFFFF">
                        <td style="width: 205">
                            <label class="blackfnt">
                                Enroute Location :</label></td>
                        <td style="width: 343">
                            <asp:Label ID="lblenloc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left">
                <br />
                <asp:Button ID="btn_csv1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv1_Click" />
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView align="left" ID="dgDocket" runat="server" BorderWidth="0" CellPadding="3"
                    CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowPaging="true"
                    PageSize="50" PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                    PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="true" PagerSettings-FirstPageText="[First]"
                    OnPageIndexChanging="pgChange" PagerSettings-LastPageText="[Last]"
                    EmptyDataText="No Records Found..." OnRowDataBound="dgDocket_RowDataBound">
                    <Columns>
                    
                     </Columns>
                     <PagerStyle HorizontalAlign="left" CssClass="bgbluegrey" Font-Bold="true" />
                     
                    <HeaderStyle CssClass="bgbluegrey" Wrap="false" />
                    <RowStyle BackColor="white" Wrap="false" />
                    <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                        Mode="NumericFirstLast"/>
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
