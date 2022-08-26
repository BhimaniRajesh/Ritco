<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    EnableEventValidation="false" Title="Webxpress" CodeFile="LR_PROFF_show.aspx.cs"
    Inherits="MR_show" %>

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
            function OpenPopupWindow1(strDocketNo,docsf)
            {
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
                var strPopupURL = "../../Operation/Singlescreen_docketentry/DocketPrint/DocketView_xls.aspx?dockno=" + strDocketNo + "&docksf=" + docsf  
                winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
            }
            function OpenPopupWindowTHC(strDocketNo,view)
            {
                //debugger
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
                //var strPopupURL = "1.aspx?strDckNo=" + strDocketNo//thcprintview_new.aspx//NewTHCView//THCViewPrint
                var strPopupURL = "../../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + strDocketNo +".,0"
                winNew = window.open(strPopupURL, "_blank", strWinFeature)
            }
    </script>

    <div align="left" style="width: 9.5in;">
        <table style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Finance.aspx"><font class="blklnkund">
                            <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>LR Proffibility Report</b></font>
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
                <asp:TemplateField HeaderText="LR no." >
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindow1('<%#DataBinder.Eval(Container.DataItem, "dockno") %>','<%#DataBinder.Eval(Container.DataItem, "docksf") %>')">
                                        <asp:Label runat="server" ID="lbldocno" Text='<%#DataBinder.Eval(Container.DataItem, "dockno") %>'></asp:Label> </a>
                                </ItemTemplate>
                               <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                               <ItemStyle Width="150"  Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                            <ControlStyle Font-Underline="true" />
                  </asp:TemplateField>
                    <%--<asp:BoundField DataField="dockno" HeaderText="LR no." HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>--%>
                    <asp:BoundField DataField="docketdt" HeaderText="LR date" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="chrgwt" HeaderText="LR charged weight" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="docket_total" HeaderText="LR Amount" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Cnor" HeaderText="Cnor" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                     <asp:BoundField DataField="Cnee" HeaderText="Cnee" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                     <asp:BoundField DataField="Frm_loc" HeaderText="From Location" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="to_loc" HeaderText="To Location" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                                  <asp:BoundField DataField="orgn" HeaderText="Origion" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dest" HeaderText="Destination" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    
                    <asp:TemplateField HeaderText="THC NO" >
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindowTHC('<%#DataBinder.Eval(Container.DataItem, "thcno") %>','<%#DataBinder.Eval(Container.DataItem, "docksf") %>')">
                                        <asp:Label runat="server" ID="lblThcNo" Text='<%#DataBinder.Eval(Container.DataItem, "thcno") %>'></asp:Label> </a>
                                </ItemTemplate>
                               <HeaderStyle HorizontalAlign="Center" Font-Bold="true" Wrap="False" CssClass="blackfnt" />
                               <ItemStyle Width="150"  Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                            <ControlStyle Font-Underline="true" />
                  </asp:TemplateField>
                     <%--<asp:BoundField DataField="thcno" HeaderText="THC No" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>--%>
                     <asp:BoundField DataField="ManualTHCNo" HeaderText="Manual THC No" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="thcdt" HeaderText="THC date" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="thccost" HeaderText="Cost at time of THC generation" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="thccost2" HeaderText="Cost at time of THC closure" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="deduction" Visible="false" HeaderText="Deduction" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="incentive" Visible="false" HeaderText="Incentive" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Total_COST" HeaderText="Total cost" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField> 
                    <asp:BoundField DataField="profit" HeaderText="Profit" HeaderStyle-Font-Bold="true"
                        ItemStyle-Wrap="true">
                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                        <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt"
                            BackColor="white" />
                    </asp:BoundField> 
                         <asp:BoundField DataField="profit_per" HeaderText="Percentage" HeaderStyle-Font-Bold="true"
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
