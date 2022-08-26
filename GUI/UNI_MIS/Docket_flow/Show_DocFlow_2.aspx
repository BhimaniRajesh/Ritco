<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Show_DocFlow_2.aspx.cs" Inherits="DOC_FLOW_Show_DocFlow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
  
            function popupmenu2(strURL, BillNo, printYN)
            {
                var winOpts = "scrollbars=yes,resizable=yes,width=500,height=400";
                
                confirmWin = window.open(strURL + "?" + BillNo + "," + printYN, "", winOpts);
            }
            
           
             
             function BranchPopup(strPopupURL)
            {
                var strWinFeature = "height=280,width=350,resizable=yes,scrollbars=yes,left=420,top=5"
                
                winNew = window.open(strPopupURL, "_blank", strWinFeature)
            }
    </script>

    <table style="width: 1100px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b>
                            <%=docketis%>
                            Flow Report </b></font>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table border="0" style="background-color: #808080; width: 9.5in;" cellspacing="0"
        align="left" class="boxbg">
        <tr bgcolor="#ffffff">
            <td align="center">
                <label class="blackfnt">
                    You Selected</label></td>
        </tr>
        <tr bgcolor="#ffffff">
            <td>
                <br />
                <br />
                <table border="0" cellpadding="3" width="565" style="background-color: #808080;"
                    cellspacing="1" align="center" class="boxbg">
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
                        <td style="width: 205; height: 6px;">
                            <label class="blackfnt">
                                Customer Code :</label></td>
                        <td style="width: 343; height: 6px;">
                            &nbsp;
                            <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td style="height: 6px">
                            <label class="blackfnt">
                                Date Type : :</label>
                        </td>
                        <td style="height: 6px">
                            <asp:Label ID="lbldt" runat="server" CssClass="blackfnt">
                                                    Date Wise</asp:Label></td>
                    </tr>
                    <tr style="background-color: #ffffff">
                        <td style="height: 6px">
                            <label class="blackfnt">
                                Flow Type :
                            </label>
                        </td>
                        <td style="height: 6px">
                            <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                                                    Flow</asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr bgcolor="#ffffff">
            <td>
                <br />
                <br />
                <tr>
                    <td align="center">
                        <asp:GridView ID="GV_Summ" runat="server" align="center" BorderWidth="0" CellPadding="5"
                            CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                            CssClass="boxbg" FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                            OnPageIndexChanging="pgChange" AllowSorting="False" AutoGenerateColumns="true"
                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                            <PagerStyle VerticalAlign="Bottom" />
                            <Columns>
                                <asp:BoundField DataField="RowCounter" ItemStyle-Wrap="true" HeaderText="Delivery Location">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <ItemStyle Width="150" Wrap="False" BackColor="white" HorizontalAlign="Center" CssClass="blackfnt" />
                                </asp:BoundField>
                                <asp:TemplateField>
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                    <HeaderTemplate>
                                        <asp:Label ID="lblhdr" Text='<%# "Total No. of " + Session["DocketCalledAs"]%>' runat="server"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemStyle BackColor="white" CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <center>
                                            <label class="blackfnt">
                                                <asp:HyperLink Font-Underline="True" runat="server" NavigateUrl='<%#"Show_Delivery_Detail_Location_stock.aspx?Cur_loc="+""+"&dly_loc=" +DataBinder.Eval(Container.DataItem, "loccode")+"&reppara="+"drill"%>'
                                                    Text='<%#DataBinder.Eval(Container.DataItem, "TOTal_DKT")%>' ID="Hyperlink3" />
                                            </label>
                                        </center>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <br />
                        <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                    </td>
                </tr>
            </td>
        </tr>
    </table>
</asp:Content>
