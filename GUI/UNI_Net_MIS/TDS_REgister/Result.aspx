<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_TDS_REgister_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript">
function OpenPopupWindow(strDocketNo)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=900hi ,height=540,status=no,left=60,top=50"
            var strPopupURL = "./Bill_popUp.aspx?billno="+strDocketNo    
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }</script>
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                        class="blklnkund"><strong>Accounts </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>TDS Report</strong> </font>
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
                <table border="0" runat="server" id="TBL_CRI" horizontalalign="left" cellpadding="3"
                    cellspacing="1" style="width: 7.0in;" class="boxbg">
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
                            Customer</td>
                        <td>
                            <asp:Label runat="server" ID="lblcust"></asp:Label></td>
                    </tr>
                    
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Type</td>
                        <td>
                            <asp:Label runat="server" ID="lblBM_TYp"></asp:Label></td>
                    </tr>
                   
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                            Amount  :
                        </td>
                        <td>
                            <asp:Label runat="server" ID="lblamt"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td valign="top" align="left">
           
            <br />
                
                            <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        
            </td>
        </tr>
        <tr>
            <td valign="top">
                <br />
                <asp:GridView align="left" ID="dgDocket" runat="server" BorderWidth="0" AutoGenerateColumns="false"
                    CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                     ShowFooter="false"
                    AllowPaging="true" PageSize="50" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                    FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" PagerSettings-FirstPageText="[First]"
                    PagerSettings-LastPageText="[Last]"  EmptyDataText="No Records Found..."
                    OnPageIndexChanging="pgChange">
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
                            <asp:BoundField Visible="true" DataField="VRNO" HeaderText="Voucher No.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="transdate" HeaderText="Voucher Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="VendorName" HeaderText="Vendor Name">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="true" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="VendorAddress" HeaderText="Address">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="true" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="PinNo" HeaderText="PIN Code">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="true" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="PanNo" HeaderText="PAN No.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="true" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="VehicalNo" HeaderText="Vehical No">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="true" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="docno" HeaderText="Doc. No">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                             <asp:BoundField Visible="true" DataField="DocDt" HeaderText="Doc. Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="account" HeaderText="Account Desc.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="false" DataField="acccategory" HeaderText="Account Category">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="docamt" HeaderText="Doc. Amt">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="Credit" HeaderText="TDS Dr.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="Debit" HeaderText="TDS Cr.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                             <asp:BoundField Visible="true" DataField="TDSRate" HeaderText="TDS Rate">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="finyear" HeaderText="Fin. Year">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="chqno" HeaderText="Chq. No.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="chqdate" HeaderText="Chq. Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="narration" HeaderText="Narration">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="payto" HeaderText="Pay To">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                                
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="transtype" HeaderText="Trans. Type">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="brcd" HeaderText="Branch">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="opertitle" HeaderText="TYPE Of Operation">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                            <asp:BoundField Visible="true" DataField="pbov_name" HeaderText="Party">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Wrap="False" BackColor="white" />
                            </asp:BoundField>
                         
                    </Columns>
                    <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"
                        Width="200" />
                    <PagerStyle HorizontalAlign="Left" Font-Bold="true"  CssClass="bgbluegrey" />
                    <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]" Mode="NumericFirstLast" />
                   <FooterStyle CssClass="bgbluegrey" Wrap="false" Width="200" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td valign="top" align="left">
                <br />
              
                            <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        
            </td>
        </tr>
    </table>
</asp:Content>
