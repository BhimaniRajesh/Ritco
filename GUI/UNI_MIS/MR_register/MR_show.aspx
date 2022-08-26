<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" Title="Webxpress" CodeFile="MR_show.aspx.cs" Inherits="MR_show" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
    function nwOpen(mrsno,type,printyn)
        {
 
               if(type=="TBB")
               {
                window.open(" ../../Finance/MoneyRecipt/MR_Summ_Popup.aspx?mrsno="+mrsno+"&type="+type+"&printyn="+printyn,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
               }
               else
               {
                window.open(" ../../operation/singlescreen_docketentry/docketprint/paidmr/MR_Summ_Popup.aspx?mrsno="+mrsno+","+printyn,"pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
               }
        }
   
            function popupmenu2(strURL, BillNo, printYN)
            {
                var winOpts = "scrollbars=yes,resizable=yes,width=500,height=400";
                
                confirmWin = window.open(strURL + "?" + BillNo + "," + printYN, "", winOpts);
            }
            
            function PageSelectionChanged(objPages)
            {
                if(document.getElementById("HIDCurrentPageNo"))
                {
                    document.getElementById("HIDCurrentPageNo").value = objPages.value;
                    document.frmMRRegisterDetails.submit();
                }                    
            }
             
             function BranchPopup(strPopupURL)
            {
                var strWinFeature = "height=280,width=350,resizable=yes,scrollbars=yes,left=420,top=5"
                
                winNew = window.open(strPopupURL, "_blank", strWinFeature)
            }
    </script>

    <div align="left" style="width: 9.5in;">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Finance.aspx"><font class="blklnkund">
                            <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>MR Regester Report</b></font>
                </td>
            </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td style="width: 39%;" valign="top">
                    <br />
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected </b>
                        </label>
                    </p>
                    <%--<center>--%>
                    <%--                    <table border="0" cellpadding="3" width="565" style="background-color: #808080;"
                        cellspacing="1"  class="boxbg">--%>
                    <table width="565" align="center" border="0" cellspacing="1" cellpadding="5" class="boxbg">
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    RO</label></td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Location</label></td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    MR Party</label></td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblmrparty" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Mr Type</label></td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblmrtype" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Status</label></td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblstatus" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Cash / Cheque</label></td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblcash" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Amount Greater Than
                                </label>
                            </td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblamtgrt" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    MRSNO
                                </label>
                            </td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lblmr" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: #FFFFFF">
                            <td style="width: 205">
                                <label class="blackfnt">
                                    Docket No
                                </label>
                            </td>
                            <td style="width: 343">
                                &nbsp;
                                <asp:Label ID="lbldno" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <%--Table for displaying no records found message--%>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <asp:Panel ID="p1" runat="server">
            <asp:GridView ID="GV_MR" runat="server" align="center" BorderWidth="0" CellPadding="5"
                CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                CssClass="boxbg" FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                OnPageIndexChanging="pgChange" AllowSorting="False" AutoGenerateColumns="false"
                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                <PagerStyle VerticalAlign="Bottom" />
                <Columns>
                    <asp:TemplateField HeaderText="Sr.No." HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
                        <ItemTemplate>
                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--         <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderText="MR No." HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="white" />
                        <ItemTemplate>
                            <label class="bluefnt">
                                <asp:HyperLink Font-Underline="True" Target="_blank" runat="server" NavigateUrl='<%#"MR_SUMM_POPUP.aspx?para1=2&mrsno="+DataBinder.Eval(Container.DataItem, "MRSNO")+"&mrtyp="+DataBinder.Eval(Container.DataItem, "MRSTYPE")%>'
                                    Text='<%# Eval("MRSNO")%>' CssClass="bluefnt" ID="Hyperlink3" />
                            </label>
                        </ItemTemplate>
                    </asp:TemplateField>--%>
                    <asp:TemplateField ItemStyle-HorizontalAlign="left" HeaderText="MR No." HeaderStyle-Font-Bold="true">
                        <HeaderStyle HorizontalAlign="center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle CssClass="blackfnt" BackColor="white" />
                        <ItemTemplate>
                            <a class="bluefnt" href="JavaScript:nwOpen('<%#DataBinder.Eval(Container.DataItem, "mrsno") %>','<%#DataBinder.Eval(Container.DataItem, "mrstype") %>',0)">
                                <%#DataBinder.Eval(Container.DataItem, "mrsno")%>
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%--  <asp:BoundField DataField="MRSNo" HeaderText="MR Number " ItemStyle-Wrap="true">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
            </asp:BoundField>--%>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label ID="Label2" Text='<%# Session["DocketCalledAs"] + " No."%>' Font-Bold="true"
                                runat="server"></asp:Label>
                        </HeaderTemplate>
                        <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                        <ItemStyle HorizontalAlign="right" CssClass="blackfnt" BackColor="white" />
                        <ItemTemplate>
                            <asp:Label ID="Label1" Text='<%#DataBinder.Eval(Container.DataItem, "dockno")%>'
                                runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="MRSTYPE" HeaderText="MR Type  " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MRSdt" HeaderText="MR Date " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="PartyNAME" HeaderText="MR Party" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MRBRNNM" HeaderText="MR Branch  " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Paymode" HeaderText="Payment Mode " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MRChequeDetails" HeaderText="Cheque No./Date" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="chq_amt" HeaderText="Cheque Amt. " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MRS_Status" HeaderText="MR Status  " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="MRSAMT" HeaderText="MR.Amount " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="finclosedt" HeaderText="MR Close Date   " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TDSDED" HeaderText="TDS " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    
                                <asp:BoundField DataField="unexpded" HeaderText="UnAdjusted Amount" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    
                    
                    <asp:BoundField DataField="frt_new" HeaderText="Fraight Rrebate   " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="CLMDED" HeaderText="CLAIM" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ded_oth" HeaderText="Other Deduction " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="othchrg_frt" HeaderText="Addition  " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="netamt" HeaderText="Close Amount   " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="remark" HeaderText="REMARK" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="" HeaderText="MR Close By " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="" HeaderText="Bill Cancelled By   " HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                </Columns>
            </asp:GridView>
        </asp:Panel>
        <br />
        <br />
        <label class="blackfnt" id="lblComment" runat="server">
            ** Click on MR No. to view MR details
        </label>
        <table border="0" cellpadding="0" width="565" id="ttt1" runat="server" bgcolor="white"
            cellspacing="0" align="center">
            <tr align="center">
                <td style="background-color: #ffffff">
                    <asp:LinkButton ID="LinkButton1" OnClick="fst" runat="server" Font-Underline="true"
                        Text="First">
                    </asp:LinkButton>
                </td>
                <td style="background-color: #ffffff">
                    <asp:LinkButton ID="LinkButton2" OnClick="lst" runat="server" Font-Underline="true"
                        Text="Last">
                    </asp:LinkButton>
                </td>
            </tr>
            <tr align="center">
                <td colspan="2" align="center">
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
