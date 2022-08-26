<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="FrmBillDetail_TLL.aspx.cs" Inherits="GUI_Octroi_ViewOctroiBill_FrmBillDetail_TLL" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/jscript">
function OpenPopupTLL(Bill_Number) 
{ 
     window.open("BillNo_Popup_TLL.aspx?Bill_No=" + Bill_Number,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
           
 }
 
 function OpenPopupBillDetailTLL(Bill_Number) 
{ 
     location.href("BillDetail_TLL.aspx?Bill_No=" + Bill_Number);
           
 }
</script>

    <table style="width: 10in">
        <tr>
            <td align="left" class="blklnkund">
                <strong>Module &gt; Octroi &nbsp;&gt; &nbsp;Bill Details </strong>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img alt="" border="0" src="../../images/back.gif" /></a>
            </td>
        </tr>
    </table>
    <table id="tblall" runat="server" border="0" cellpadding="3" cellspacing="1" class="boxbg">
        <tr class="bgbluegrey" style="background-color: #ffffff">
            <td align="center" class="bgbluegrey" colspan="3" style="height: 15px">
                <strong>You Selected</strong></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" class="blackfnt" style="width: 29%; height: 20px">
                <strong>Bill Status Date Range</strong></td>
            <td align="left" class="blackfnt" style="height: 25px">
                <asp:Label ID="lbldaterange" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:TextBox ID="TxtDateRange" runat="server" ReadOnly="True" Style="z-index: 102;
        left: 391px; position: absolute; top: 49px" Visible="False" Width="170px"></asp:TextBox>
    <asp:TextBox ID="TxtRO" runat="server" ReadOnly="True" Style="z-index: 102; left: 391px;
        position: absolute; top: 84px" Visible="False" Width="168px"></asp:TextBox>
    <asp:TextBox ID="txtLocation" runat="server" ReadOnly="True" Style="z-index: 102;
        left: 391px; position: absolute; top: 120px" Visible="False" Width="168px"></asp:TextBox>
    <br />
    <table id="tblbillno" runat="server" border="0" cellpadding="3" cellspacing="1" class="boxbg"
        colspan="2">
        <tr class="bgbluegrey" style="background-color: #ffffff">
            <td align="center" class="bgbluegrey" colspan="3" style="height: 15px">
                <strong>You Selected</strong></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td align="left" style="width: 29%; height: 25px">
                <asp:Label ID="lbldbillno" runat="server" Font-Bold="True" Text="System Bill No"
                    Width="100%"></asp:Label>
                <asp:Label ID="lbldmbillno" runat="server" Font-Bold="True" Text="Manual Bill No"
                    Width="100%"></asp:Label>
            </td>
            <td align="left" style="height: 25px">
                <asp:Label ID="lblbillno" runat="server" Width="100%"></asp:Label>
                <asp:Label ID="lblmbillno" runat="server" Width="100%"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <asp:GridView ID="grvOctroi" runat="server" AllowPaging="True" AutoGenerateColumns="False"
        BorderWidth="0px" CellSpacing="1" CssClass="boxbg" EmptyDataRowStyle-CssClass="blackfnt"
        EmptyDataRowStyle-Font-Bold="true" EmptyDataText="No Bills Found For Given Details !!"
        HeaderStyle-CssClass="bgbluegrey"     PageSize="10" Style="border-right: 0px; border-top: 0px; border-left: 0px; width: 10in;
        border-bottom: 0px" Width="686px" OnPageIndexChanging="grvOctroi_PageIndexChanging">
        <Columns>
            <asp:TemplateField HeaderText="Octroi Bill Number">
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <ItemStyle BackColor="White" HorizontalAlign="Center" />
                <ItemTemplate>
                     <asp:Label ID="lblOcbillno" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BillNo") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Octroi Billing Branch">
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <ItemStyle BackColor="White" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lblOcbillingbranch" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BBRCD") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Party Name">
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <ItemStyle BackColor="White" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lblpartyName" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"PartyName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Octroi Bill Date">
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="true" />
                <ItemStyle BackColor="White" HorizontalAlign="Center" Wrap="false" />
                <ItemTemplate>
                    <asp:Label ID="lblOcBillDate" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BGNDT") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Amount">
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <ItemStyle BackColor="White" HorizontalAlign="Right" Wrap="false" />
                <ItemTemplate>
                    <asp:Label ID="lblAmount" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BILLAMT") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Covering Letter">
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <ItemStyle BackColor="White" HorizontalAlign="Center" />
                <ItemTemplate>
                    <a class="Blackfnt" href="JavaScript:OpenPopupTLL('<%#DataBinder.Eval(Container.DataItem, "BillNo") %>')">
                        <asp:Label ID="lblCL" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BillNo") %>'></asp:Label>
                    </a>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Bill Details">
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <ItemStyle BackColor="White" HorizontalAlign="Center" />
                <ItemTemplate>
                    <a class="Blackfnt" href="JavaScript:OpenPopupBillDetailTLL('<%#DataBinder.Eval(Container.DataItem, "BillNo") %>')">
                        <asp:Label ID="lblCL" runat="server" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"BillNo") %>'></asp:Label>
                    </a>
                </ItemTemplate>
            </asp:TemplateField>
           
        </Columns>
        <EmptyDataRowStyle CssClass="blackfnt" Font-Bold="True" />
        <HeaderStyle CssClass="bgbluegrey" />
    </asp:GridView>
</asp:Content>

