<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_Net_MIS_CHQ_register_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script  type="text/javascript">
    function popup(objval)
    {
        //alert(objval.value)
        var FrmChild = window.open('popup-usage.aspx?id='+ objval.value ,'myWindow','height=285,width=800,resizable=yes,scrollbars=yes,left=210,top=15'); 
	       
        return false;
    }
</script>
    
    <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr>
            <td height="30">
                <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                    class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong>&gt;<font
                        class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Cheque Register </strong> </font>
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
                            Date Type </td>
                        <td>
                            <asp:Label runat="server" ID="lbldttyp"></asp:Label></td>
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
                            Cheque Type </td>
                        <td>
                            <asp:Label runat="server" ID="lblvrty"></asp:Label></td>
                    </tr>
                    <tr  id="TR1" runat="server"  bgcolor="white" class="blackfnt">
                        <td>
                           Issuing Bank </td>
                        <td>
                            <asp:Label runat="server" ID="lbltrty"></asp:Label></td>
                    </tr>
                    
                    <tr id="TR2" runat="server"  bgcolor="white" class="blackfnt">
                        <td>
                           Cheque Deposit Status  </td>
                        <td>
                            <asp:Label runat="server" ID="lblchqdepostatus"></asp:Label></td>
                    </tr>
                    
                    <tr id="TR3" runat="server"  bgcolor="white" class="blackfnt">
                        <td>
                           On Account Status  </td>
                        <td>
                            <asp:Label runat="server" ID="lblonAccst"></asp:Label></td>
                    </tr>
                            
                            <tr bgcolor="white" class="blackfnt">
                        <td>
                           Reconciliation Status  </td>
                        <td>
                            <asp:Label runat="server" ID="lblRECst"></asp:Label></td>
                    </tr>
                    <tr bgcolor="white" class="blackfnt">
                        <td>
                           Cheque Amount Range </td>
                        <td>
                            <asp:Label runat="server" ID="lblAmt"></asp:Label></td>
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
            <asp:TemplateField HeaderText="Usage" ItemStyle-BackColor="white">
                <ItemTemplate>
                     <input name=chk type=radio onclick="popup(this);" value='<%#DataBinder.Eval(Container.DataItem,"CHQNO") %> ,<%#DataBinder.Eval(Container.DataItem,"CHQDT")  %>' >
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
            </asp:TemplateField>
            
                                           
                                            
                                       
            <asp:BoundField DataField="chqno" HeaderText="Cheque No.">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                
            </asp:BoundField>
            <asp:BoundField DataField="chqdt" HeaderText="Cheque Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="entrydt" HeaderText="Cheque Entry Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="chqamt" HeaderText="Amount">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="right" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="BANK" HeaderText="Issued From Bank">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="Party" HeaderText="Issued To Vendor/Party">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="brcd" HeaderText="Issued At Location">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="voucherno" HeaderText="Transaction Document No">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="transdate" HeaderText="Transaction Document Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="Reconciled" HeaderText="Reconciled Y/N">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>        
     
            
             </Columns>
        <RowStyle />
        <PagerStyle HorizontalAlign="left"  Font-Bold="true" CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle HorizontalAlign="center" CssClass="bgbluegrey" />
        
        
    </asp:GridView>
                
                <asp:GridView Visible="false" ShowFooter="true" align="left" ID="dgDocket1" runat="server" BorderWidth="0"
        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="true" PageSize="50" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
          PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
        PagerSettings-FirstPageText="[First]"
        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange1">
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
 <asp:TemplateField HeaderText="Usage" ItemStyle-BackColor="white">
                <ItemTemplate>
                     <input name=chk type=radio onclick="popup(this);" value='<%#DataBinder.Eval(Container.DataItem,"CHQNO") %> ,<%#DataBinder.Eval(Container.DataItem,"CHQDT")  %>' >
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
            </asp:TemplateField>
            <asp:BoundField DataField="chqno" HeaderText="Cheque No.">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                
            </asp:BoundField>
            <asp:BoundField DataField="chqdt" HeaderText="Cheque Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="entrydt" HeaderText="Cheque Entry Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="chqamt" HeaderText="Amount">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="right" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="adjustamt" HeaderText="Amount Used">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="right" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="NotUsedAmt" HeaderText="Amount Not Used">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="right" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="DepoFlag" HeaderText="Depoisted Y/N">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="Bank" HeaderText="Deposited In Bank">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="party" HeaderText="Received From">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="brcd" HeaderText="Received At Location">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
           
      <asp:BoundField DataField="voucherno" HeaderText="Transaction Document No">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="transdate" HeaderText="Transaction Document Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
              <asp:BoundField DataField="Reconciled" HeaderText="Reconciled Y/N">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
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
