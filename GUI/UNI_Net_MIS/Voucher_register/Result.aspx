<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_Voucher_register_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">
        function ViewPrint(arg1,arg2,arg3)
        {   
            var strPopupURL = "";
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125";
            var typ= arg1.toUpperCase();
            var res = arg2.split(":");
            //var voucherno = res[1];
            var voucherno = res[1].substring(1,res[1].length);
            if(typ == "JOURNAL")
            {
               strPopupURL = "../../Finance/ViewPrint/Voucher Register/Print/JournalVoucherView.aspx?voucherno=" + voucherno + "&printyn=N";
	           winNew = window.open(strPopupURL, "_blank", strWinFeature);
            }
            else if(typ == "CASH PAYMENT" || typ == "BANK PAYMENT" || typ == "BOTH PAYMENT" || typ == "CC PAYMENT")
            {
               if(arg3.toUpperCase() == "SPECIAL COST VOUCHER")
               { 
                    strPopupURL = "../../Finance/ViewPrint/Voucher Register/Print/SpecialCostVoucherView.aspx?voucherno=" + voucherno + "&printyn=N";
	                winNew = window.open(strPopupURL, "_blank" , strWinFeature);
	           }
	           else
	           { 
                    strPopupURL = "../../Finance/ViewPrint/Voucher Register/Print/DebitVoucherView.aspx?voucherno=" + voucherno + "&printyn=N";
	                winNew = window.open(strPopupURL, "_blank" , strWinFeature);
	           }    
            }
            else if(typ == "CASH RECEIPT" || typ == "BANK RECEIPT" || typ == "BOTH RECEIPT" || typ == "CC RECEIPT")
            {  
               if(arg3.toUpperCase() == "SPECIAL COST VOUCHER")
               { 
                    strPopupURL = "../../Finance/ViewPrint/Voucher Register/Print/SpecialCostVoucherView.aspx?voucherno=" + voucherno + "&printyn=N";
	                winNew = window.open(strPopupURL, "_blank", strWinFeature);
	           }
	           else
	           { 
                    strPopupURL = "../../Finance/ViewPrint/Voucher Register/Print/CreditVoucherView.aspx?voucherno=" + voucherno + "&printyn=N";
	                winNew = window.open(strPopupURL, "_blank", strWinFeature);
	           }
               
            }
            else if(typ == "CONTRA")
            {                        
               strPopupURL = "../../Finance/ViewPrint/Voucher Register/Print/ContraView.aspx?voucherno=" + voucherno + "&printyn=N";
	           winNew = window.open(strPopupURL, "_blank", strWinFeature);
            }
        }
    </script>
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>&gt;<font
                        class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Voucher Register </strong> </font>
            </td>
        </tr>
        <tr>
            <td class="horzblue">
                <img src="./../../images/clear.gif" width="2" height="1" /></td>
        </tr>
        <tr>
            <td align="right">
                <div align="center">
                    <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                        <ProgressTemplate>
                            <div id="progressArea">
                                <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="Back" src="./../../images/back.gif" border="0" />
                </a>
            </td>
        </tr>
        <tr>
            <td>
                <table border="0" runat="server" id="TBL_CRI"   horizontalalign="left" cellpadding="3" cellspacing="1" style="width: 7.0in;"
                    class="boxbg">
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Date</td>
                        <td>
                            <asp:Label runat="server" ID="LBLDATE"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            RO</td>
                        <td>
                            <asp:Label runat="server" ID="LBLBRANCH"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Location</td>
                        <td>
                            <asp:Label runat="server" ID="LBLRPT"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Voucher Type</td>
                        <td>
                            <asp:Label runat="server" ID="lblvrty"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Voucher Transaction Type</td>
                        <td>
                            <asp:Label runat="server" ID="lbltrty"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Voucher Referance No</td>
                        <td>
                            <asp:Label runat="server" ID="lblrefno"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Voucher Status</td>
                        <td>
                            <asp:Label runat="server" ID="lblvrstatus"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top"><br />
                <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
        <tr>
            <td  align="left" valign="top">
                <br />
                    <asp:GridView Visible="false" ShowFooter="true" align="left" ID="dgDocket" runat="server" BorderWidth="0"
                    CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                    AllowPaging="true" PageSize="50" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                    PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                    PagerSettings-FirstPageText="[First]"
                    PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
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
                        <asp:TemplateField HeaderText="Voucher No." ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                            <ItemTemplate>
                                <a href="Javascript:ViewPrint('<%# DataBinder.Eval(Container.DataItem,"transtype") %>','<%# DataBinder.Eval(Container.DataItem,"voucherno") %>','<%# DataBinder.Eval(Container.DataItem,"opertitle") %>')" style="text-decoration:underline"><%# DataBinder.Eval(Container.DataItem,"voucherno") %></a>
                            </ItemTemplate>
                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            <HeaderStyle CssClass="blackfnt" />
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="voucherno" HeaderText="Voucher No.">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="left" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>--%>
                        <asp:BoundField DataField="Manual_Voucherno" HeaderText="Manual No.">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="left" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="transdate" HeaderText="Date">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="entrydt" HeaderText="Entry Date">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="brcd" HeaderText="Location">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="transtype_str" HeaderText="Voucher Type">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="chqno" HeaderText="Chq No.">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="chqdate" HeaderText="Chq Date">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="amt" HeaderText="Amount">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="right" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="docno" HeaderText="Doc No.">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="opertitle" HeaderText="Transaction Type">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Narration" HeaderText="Narration">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left"  />
                        </asp:BoundField>
                        <asp:BoundField DataField="Refno" HeaderText="Referance No">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left"  />
                        </asp:BoundField>
                        <asp:BoundField DataField="EntryBy" HeaderText="Entry By">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left"  />
                        </asp:BoundField>
                        <asp:BoundField DataField="UpdateBy" HeaderText="Cancelled By">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left"  />
                        </asp:BoundField>
                        <asp:BoundField DataField="comment" HeaderText="Cancel Reason">
                            <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="true" />
                            <HeaderStyle CssClass="blackfnt" HorizontalAlign="Left"  />
                        </asp:BoundField>
                    </Columns>
                    <RowStyle />
                    <PagerStyle HorizontalAlign="left"  Font-Bold="true" CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]" Mode="NumericFirstLast" />
                    <FooterStyle HorizontalAlign="center" CssClass="bgbluegrey" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td valign="top"><br />
                <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
