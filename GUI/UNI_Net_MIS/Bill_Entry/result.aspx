<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="result.aspx.cs" Inherits="GUI_UNI_MIS_Bill_Entry_result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript">
function ViewBillDetails(BillNo,arg,Type)
{
    //window.open("../../Finance/Vendor_BA_payment/BA_Payment/ViewPrint/View_BillEntry.aspx?BillNo="+BillNo+","+ arg ,"BillDetails","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
    //window.open("../../Finance/Vendor_BA_payment/PaymentAgainstBillEntry/Vendor/vendorbill_xls.aspx?strGenerateBillNo="+BillNo+","+ arg ,"BillDetails","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
    //window.open("../../Finance/Vendor_BA_payment/ViewExpenseEntry.aspx?expBillNo="+BillNo+","+ arg ,"BillDetails","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
    if(Type == "BA Payment")
    {
      window.open("../../Finance/Vendor_BA_payment/BA_Payment/ViewPrint/View_BillEntry.aspx?BillNo="+BillNo+","+ arg ,"BillDetails","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");  
    }
    else if(Type == "THC")
    {
        window.open("../../Finance/Vendor_BA_payment/PaymentAgainstBillEntry/Vendor/vendorbill_xls.aspx?strGenerateBillNo="+BillNo+","+ arg ,"BillDetails","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
    }
    else if(Type == "Expense")
    {
        window.open("../../Finance/Vendor_BA_payment/ViewExpenseEntry.aspx?expBillNo="+BillNo+","+ arg ,"BillDetails","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
    }
    
}
</script>
 <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Report </strong></font><font class="bluefnt"><strong><font
                            class="blklnkund"><strong>Finance </strong></font><font class="bluefnt"><strong>&gt;
                            </strong><strong>Accounts Payable Register</strong></font>
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
                <td valign="top">
    <table border="0" cellpadding="3" width="565" cellspacing="1" align="left" class="boxbg">
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
                        Report Type :
                    </label>
                </td>
                <td style="height: 6px"> &nbsp;
                    <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                    </asp:Label></td>
            </tr>
    </table> </td>
            </tr>
              <tr>
                <td valign="top">
    <br />
    
                <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
            <tr>
                <td valign="top">
    <br />
 
    <asp:GridView Visible="false" ShowFooter="true" align="center" ID="dgDocket" runat="server" BorderWidth="0"
        CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="true" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
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
            <%-- <asp:BoundField DataField="BILLNO" HeaderText="BILLNO">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>    --%>
            <asp:TemplateField HeaderText="BILLNO" ItemStyle-BackColor="white">
                <ItemTemplate>
                   <a href="javascript:ViewBillDetails('<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>','0','<%# DataBinder.Eval(Container.DataItem,"BETYPE") %>')"> 
                   <asp:Label CssClass="blackfnt" ID="lblBillNo" Text='<%# DataBinder.Eval(Container.DataItem,"BILLNO") %>'
                        runat="server">
                    </asp:Label></a>
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Font-Underline="true" />
                <HeaderStyle CssClass="blackfnt" />
                <ControlStyle Font-Underline="true" />
            </asp:TemplateField>
            
            <asp:BoundField DataField="brcd" HeaderText="Location">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="billdt" HeaderText="Bill Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="vendorbillno" HeaderText="Vendor BILLNO">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="vendorbilldt" HeaderText="Vendor Bill Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="vendorname" HeaderText="Vendor">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="DUEDT" HeaderText="DUE Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Paydt" HeaderText="Payment date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Finclosedt" HeaderText="Financially Close date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="voucherno" HeaderText="Voucher No.">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="PCAMT" HeaderText="Contract Amt.">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="right" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="ADVAMT" HeaderText="Advance Amt.">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="right" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
             <asp:BoundField DataField="OTHAMT" HeaderText="Other Amt.">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="right" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="otherded" HeaderText="Other Deduction">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="right" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
           
            <asp:BoundField DataField="tdsrate" HeaderText="TDS Rate ">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>     
            <asp:BoundField DataField="tds" HeaderText="TDS">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="right" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>     
            <asp:BoundField DataField="netamt" HeaderText="Net Amt.">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="right" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                
            </asp:BoundField>      
            <asp:BoundField DataField="BETYPE" HeaderText="Bill Type">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>     
            <asp:BoundField DataField="Entryby" HeaderText="Entry By">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>     
            <asp:BoundField DataField="ENtrydt" HeaderText="Entry Date">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>     

           
           
          
       
        </Columns>
        <RowStyle />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle HorizontalAlign="center" CssClass="bgbluegrey" />
    </asp:GridView>
   </td>
            </tr>
            <tr>
                <td valign="top">
    <br />
    
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>
