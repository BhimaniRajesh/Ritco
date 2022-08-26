<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="vehicle_2.aspx.cs" Inherits="GUI_Vihicle_vehicle_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Vehicle Regester Report</b></font>
            </td>
        </tr>
    </table>

    <script language="javascript" type="text/javascript">
  
            function popupmenu2(strURL, BillNo, printYN)
            {
                var winOpts = "scrollbars=yes,resizable=yes,width=500,height=400";
                
                confirmWin = window.open(strURL + "?" + BillNo + "," + printYN, "", winOpts);
            }
            
           
             
//             function BranchPopup(strPopupURL)
//            {
//                var strWinFeature = "height=280,width=350,resizable=yes,scrollbars=yes,left=420,top=5"
//                
//                winNew = window.open(strPopupURL, "_blank", strWinFeature)
//            }
    </script>

    <br />
    <br />
    <table width="100%" border="0" cellspacing="0" align="left" cellpadding="0">
        <tr align="left">
            <td style="width: 39%;" valign="top">
                <br />
                <%--<p align="left">
                    <label class="blackfnt">
                        <b>You Selected
                            <asp:Label ID="Label1" runat="server"></asp:Label></b></label></p>--%>
                <%--<center>--%>
                <table border="0" cellpadding="3" align="left" width="565" cellspacing="1" align="center"
                    class="boxbg">
                    <tr style="background-color: #ffffff">
                        <td style="height: 10px">
                            <label class="blackfnt">
                                Date :
                            </label>
                        </td>
                        <td style="height: 10px">
                            <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 15px;">
                            <label class="blackfnt">
                                RO :</label></td>
                        <td style="width: 343; height: 15px;">
                            <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205">
                            <label class="blackfnt">
                                Location :</label></td>
                        <td style="width: 343">
                            <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #FFFFFF">
                        <td style="width: 205; height: 6px;">
                            <label class="blackfnt">
                                Route :</label></td>
                        <td style="width: 343; height: 6px;">
                            <asp:Label ID="lblroute" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td style="height: 6px">
                            <label class="blackfnt">
                                Vendore :
                            </label>
                        </td>
                        <td style="height: 6px">
                            <asp:Label ID="lblven" runat="server" CssClass="blackfnt">
                                                                        Date Wise </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td style="height: 6px">
                            <label class="blackfnt">
                                Document &nbsp;Type :
                            </label>
                        </td>
                        <td style="height: 6px">
                            <asp:Label ID="lbldoctype" runat="server" CssClass="blackfnt">
                                                                        
                                                                        Flow </asp:Label>
                        </td>
                    </tr>
                </table>
                <%--</center>--%>
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <table id="tblBillDetails" runat="server" border="0" cellspacing="1" cellpadding="4"
                    style="width: 100%" align="center" class="boxbg">
                    <tr class="bgbluegrey">
                        <td colspan="4" align="center">
                            <label class="blackfnt">
                                <b>Vehicle Report&nbsp;</b></label></td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td align="center" colspan="4">
                            <asp:GridView ID="GV_Veh" runat="server" align="center" BorderWidth="0" CellPadding="5"
                                CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" HeaderStyle-Font-Names="verdana"
                                PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg"
                                AllowPaging="true" c PageSize="25" OnPageIndexChanging="pgChange" AllowSorting="False"
                                AutoGenerateColumns="true" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                EmptyDataText="No Records Found...">
                                <PagerStyle VerticalAlign="Bottom" />
                                <Columns>
                                    <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="SR.NO.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                        <ItemStyle BackColor="white" CssClass="blackfnt" />
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                                ForeColor="Red" Text="Label" Visible="False"></asp:Label></td>
                    </tr>
                </table>
                <br />
                <center>
                    &nbsp;&nbsp;</center>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="background-color: #ffffff" align="center">
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
