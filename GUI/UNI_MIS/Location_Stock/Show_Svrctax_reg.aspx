<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Show_Svrctax_reg.aspx.cs" Inherits="GUI_UNI_MIS_Login_View_Login_2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <div align="left" style="width: 9.5in;">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Finance.aspx"><font class="blklnkund">
                            <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>Service Tax Regester
                                Report</b></font>
                </td>
            </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <br />
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected
                                <asp:Label ID="Label1" runat="server" Text="Label" Visible="false"></asp:Label></b></label></p>
                    <table border="0" cellpadding="5" width="565" cellspacing="1" align="center" class="boxbg">
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
                                    Ro :</label></td>
                            <td style="width: 343; height: 6px;">
                                &nbsp;
                                <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <br />
                </td>
            </tr>
            <tr>
            <td>
            <%--<tr>  
                                                                
                                                                
                                                                
                                                                   
                                                                   <%--<asp:UpdatePanel ID="UP1" runat="Server">
                                                                    <ContentTemplate>OnPageIndexChanging="pgChange"--%>
                                                                    
            <asp:GridView ID="GV_Booking" runat="server" HorizontalAlign="Center"   BorderWidth="0"
            CellPadding="2"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="10" PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" 
            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange"
                 OnRowDataBound="CustomersGridView_RowDataBound">
                <PagerStyle VerticalAlign="Bottom" />
                <Columns>
                 <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                    <ItemTemplate>
                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server">
                        </asp:Label>
                    </ItemTemplate>
                     <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
                    <%--  <asp:BoundField  DataField="Sno"   ItemStyle-Wrap="true"     > 
                                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                                           <ItemStyle  Width="20"  Wrap="False"  HorizontalAlign="Center" CssClass="blackfnt" />
                                                                             </asp:BoundField>--%>
                    <asp:BoundField DataField="MRSNo" ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="mr_typ" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    
                    <asp:BoundField DataField="MRS_DT" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                   
                     <asp:BoundField DataField="PTNAME" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="locname" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MRSAMT" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dockno" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dock_dt" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                   
                    <asp:BoundField DataField="BillNo" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="bgndt" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="billsubbrcd" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="StaxRate" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CessRate" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="H_CessRate" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                    
                    <asp:BoundField DataField="dock_COL_FRT" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dock_COL_STAX" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="dock_COL_CESS" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>                    
                    <asp:BoundField DataField="dock_col_H_Cess" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                    
                     <asp:BoundField DataField="BILL_COL_FRT" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="BILL_COL_STAX" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="BILL_COL_CESS" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="BILL_col_H_Cess" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                    
                       <asp:BoundField DataField="OT_DET_FRT" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="OT_DET_STAX" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="OT_DET_CESS" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="OT_DET_H_Cess" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                    
                       <asp:BoundField DataField="OTCH_DET_FRT" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="OTCH_DET_STAX" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="OTCH_DET_CESS" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="OTCH_DET_H_Cess" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                    
                       <asp:BoundField DataField="RECD_FRT" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="RECD_DET_STAX" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="RECD_DET_CESS" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="RECD_DET_H_Cess" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                    
                    <asp:BoundField DataField="REP_TDS_ded" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="REP_cliam_ded" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                    
                    <asp:BoundField DataField="BAL_COL_FRT" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="BAL_COL_STAX" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="BAL_COL_CESS" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                     <asp:BoundField DataField="BAL_col_H_Cess" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                    
                    <asp:BoundField DataField="NET_BAL_AMT" ItemStyle-Wrap="false">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle BackColor="white" Wrap="False" HorizontalAlign="Right" CssClass="blackfnt" />
                    </asp:BoundField>
                </Columns>
                <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
            </asp:GridView>
            <%--      OnRowDataBound="CustomersGridView_RowDataBound"
                                                                --%>
            <%-- </ContentTemplate>
                                                                </asp:UpdatePanel>--%>
                                                                </td></tr>
            <tr>
                <asp:Label ID="lblnull" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Medium"
                    ForeColor="Red" Text="Label" Visible="False"></asp:Label></tr>
            <tr align="center">
            </tr>
        </table>
        <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="Server">
                                                                    <ContentTemplate>--%>
        <br />
        <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
            
           
            <tr bgcolor="white">
                <td colspan="2" align="center">
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
