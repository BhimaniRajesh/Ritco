<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="FrmMissingDockets.aspx.cs" Inherits="FrmPaidFollowUp" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
function ToExcel(){


if (window.ActiveXObject){

var  xlApp = new ActiveXObject("Excel.Application"); 
var xlBook = xlApp.Workbooks.Add();


xlBook.worksheets("Sheet1").activate;
var XlSheet = xlBook.activeSheet;
xlApp.visible = true; 

for(var P = 1; P<= obj.getRowProperty("count"); P++){

      for(var Q = 1; Q <= obj.getColumnProperty("count"); Q++){
      if (P==1){
      XlSheet.cells(P ,Q).value = obj.getColumnProperty("text",Q-1)
      }
      
             XlSheet.cells(P +1,Q).value = obj.getDataText(P-1,Q-1);
}
}
XlSheet.columns.autofit; 
}
}//end function 
    </script>

    <br />
    <table style="width: 1000px">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Operation.aspx"><font class="blklnkund">
                        <b>Operations</b></font></a> <b>&gt; </b><font class="bluefnt"><b><%=Session["DocketCalledAs"] %> Not Used</b></font>
            </td>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img src="../../images/back.gif" border="0" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <div align="left">
        &nbsp;
        <table align="left" border="0" cellpadding="5" cellspacing="1" class="boxbg"
            style="width: 398px; height: 1px">
            <tr class="bgbluegrey">
                <td align="center" colspan="3" style="height: 23px" class="blackfnt">
                    Your Query
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="left" style="width: 110px;" class="blackfnt">
                    Date</td>
                <td style="width: 136px;">
                    <div align="left">
                        <asp:Label ID="lblDate" align="left" runat="server" Text="Label" CssClass="blackfnt"
                            Width="267px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="left" style="width: 60px;" class="blackfnt">
                    RO</td>
                <td style="width: 136px;">
                    <div align="left">
                        <asp:Label ID="lblStatus" runat="server" CssClass="blackfnt" Text="Label" Width="267px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="left" style="width: 60px;" class="blackfnt">
                    Location</td>
                <td style="width: 136px;">
                    <div align="left">
                        <asp:Label ID="lbllocation" CssClass="blackfnt" runat="server" Text="Label" Width="267px"></asp:Label></div>
                </td>
            </tr>
            <tr bgcolor="white">
                <td align="left" style="width: 110px;" class="blackfnt">
                    <%=Session["DocketCalledAs"] %>  No</td>
                <td style="width: 136px;">
                    <div align="left">
                        <asp:Label ID="Lblsearchdockno" CssClass="blackfnt" runat="server" Text="Label" Width="267px"></asp:Label></div>
                </td>
            </tr>
        </table>
    </div>
    <asp:TextBox ID="txtfdate" runat="server" Visible="false"></asp:TextBox>
    <asp:TextBox ID="txttdate" runat="server" Visible="false"></asp:TextBox><br />
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
    <div align="left">
        <asp:GridView ID="GrdPaidFollow" EmptyDataRowStyle-BackColor="white" EmptyDataRowStyle-CssClass="blackfnt" EmptyDataText="No Records Found.....!!" AllowPaging="true"
            OnPageIndexChanging="PageIndexChanged_Click" PagerStyle-Mode="NumericPages" CssClass="boxbg"
            PageSize="10" AutoGenerateColumns="false" HeaderStyle-CssClass="bgbluegrey" runat="server" SelectedIndex="1" CellPadding="5" CellSpacing="1" BorderWidth="0" OnRowDataBound="GrdPaidFollow_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO.">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center" BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lblsrnot" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField  >
                <HeaderTemplate>
                <asp:Label ID="ds" Text='<%#Session["DocketCalledAs"]+" Location "%> ' runat="server"></asp:Label>
                </HeaderTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lbldocketbranch" CssClass="blackfnt" Text='<%# Eval("docbrcd") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="From">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lblfrom" ForeColor="black" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"doc_sr_from") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="To">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lblto" ForeColor="black" CssClass="blackfnt" Text='<%# DataBinder.Eval( Container.DataItem,"doc_sr_to") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:BoundField DataField="op_dly" HeaderText="Function" />  --%>
                <asp:TemplateField ControlStyle-Width="80" HeaderStyle-Width="80" HeaderText="Total Leafs"
                    Visible="true">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lbltotleaf" CssClass="blackfnt" Text='<%#DataBinder.Eval( Container.DataItem,"tot_Leaf") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ControlStyle-Width="100" HeaderStyle-Width="100" HeaderText="CNote Booked Count">
                    <HeaderStyle CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white" />
                    <ItemTemplate>
                        <asp:Label ID="lblcnotebookedcount" CssClass="blackfnt" Text='<%#DataBinder.Eval( Container.DataItem,"docketsbookedinthisrange") %>'
                            runat="server"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ControlStyle-Width="100" HeaderText="CNote Unused Count">
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white" />
                    <ItemTemplate>
                        <div align="center">
                            <asp:Label ID="lblcnoteunusedcount" CssClass="blackfnt" Text='<%#Convert.ToInt32(DataBinder.Eval( Container.DataItem,"tot_Leaf")) - Convert.ToInt32(DataBinder.Eval( Container.DataItem,"docketsbookedinthisrange")) %>'
                                runat="server"></asp:Label>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField  ControlStyle-Width="100" ItemStyle-Width="100" HeaderText="Asigned On">
                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                    <ItemStyle HorizontalAlign="Center"  BackColor="white" />
                    <ItemTemplate>
                        <div align="center">
                            <asp:Label ID="lblasignedon" CssClass="blackfnt" Text='<%#DataBinder.Eval( Container.DataItem,"updton_str") %>'
                                runat="server"></asp:Label>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle  HorizontalAlign="Center"  CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg"  BackColor="white"/>
        </asp:GridView>
    </div>
    <div align="center" style="width:10.5in">
        <br />
        <asp:Button ID="Button1" runat="server" OnClick="cmdexcel_Click" Text="Excel" Width="54px" /><br />
        &nbsp;</div>
</asp:Content>
