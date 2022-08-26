<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" EnableEventValidation="false" Inherits="GUI_UNI_Net_MIS_TripStatement_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
    function OpenPopupWindow(strTHCNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + strTHCNo + ".,0" 
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
    </script>

    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        <strong>Operation </strong></font><font class="bluefnt"><strong></strong>&gt;<strong>TripStatement
                            Report</strong> </font>
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
                                RO :</label></td>
                        <td style="width: 343; height: 15px;">
                            &nbsp;
                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205">
                            <label class="blackfnt">
                                Location :</label></td>
                        <td style="width: 343">
                            &nbsp;
                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205">
                            <label class="blackfnt">
                                Trans Mode :</label></td>
                        <td style="width: 343">
                            &nbsp;
                            <asp:Label ID="lblTransMode" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left">
                <br />
                <asp:Button ID="btn_csv1" Text="DownLoad XLS" runat="server" Visible="true" Width="170" OnClick="btn_csv1_Click" />
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView align="left" ID="dgDocket" runat="server" BorderWidth="0" CellPadding="3"
                    CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
                    PageSize="50" PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                    PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]"
                    OnRowDataBound="dgDocket_RowDataBound" OnPageIndexChanging="pgChange" PagerSettings-LastPageText="[Last]"
                    EmptyDataText="No Records Found..." EmptyDataRowStyle-HorizontalAlign="Center" EmptyDataRowStyle-CssClass="bgbluegrey" EmptyDataRowStyle-ForeColor="Red">
                    <Columns>
                        <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                            <ItemTemplate>
                                <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                    runat="server">
                                </asp:Label>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        
                         <asp:BoundField HeaderStyle-Wrap="true" DataField="vehno" HeaderText="Vehicle No">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                         <asp:BoundField DataField="routecd" HeaderText="Route Code">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                         <asp:BoundField DataField="routename" HeaderText="Route">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Doc No" ItemStyle-BackColor="white">
                            <ItemTemplate>
                                <label class="blackfnt">
                                    <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "thcno") %>')">
                                        <%#DataBinder.Eval(Container.DataItem, "thcno")%>
                                    </a>
                                </label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField HeaderStyle-Wrap="true" DataField="thcdt" HeaderText="Doc. Date">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <%--<asp:BoundField HeaderStyle-Wrap="true" DataField="tobh_code" HeaderText="Last Location">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>--%>
                        <asp:BoundField DataField="actdept_dt" HeaderText="Departed at">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="actdept_tm" HeaderText="EDD & Time">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        <%--<asp:BoundField DataField="curr_loc" HeaderText="Next Location">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>--%>
                        <asp:BoundField DataField="payload" HeaderText="PayLoad Of Vehicle">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                        </asp:BoundField>
                         <asp:BoundField DataField="totdkt" HeaderText="No. of Packages">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ld_actuwt" HeaderText="Actual Load Carried">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="totfrt" HeaderText="Total Freight">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" BackColor="white" />
                        </asp:BoundField>
                        <asp:BoundField DataField="status" HeaderText="Status">
                            <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        </asp:BoundField>
                        
                    </Columns>
                    <RowStyle />
                    <PagerStyle HorizontalAlign="left" Font-Bold="true" CssClass="bgbluegrey" />
                    <HeaderStyle CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                        Mode="NumericFirstLast" />
                    <FooterStyle CssClass="boxbg" />
                </asp:GridView>
                <br />
            </td>
        </tr>
        
        <tr>
            <td align="left">
                <br />
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Visible="true"  Width="170" OnClick="btn_csv_Click" />
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
