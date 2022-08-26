<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Result_LS_MF_PDRS_PFM.aspx.cs" Inherits="GUI_View_Track_Operation_Result_LS_MF_PDRS_PFM" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">
function OpenPopupWindowManifest(strDocketNo)
{
//debugger
var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
var strPopupURL = "../../Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + strDocketNo + ",0"
winNew = window.open(strPopupURL, "_blank", strWinFeature)
}
function OpenPopupWindowManifestPrint(strDocketNo)
{
//debugger
var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
var strPopupURL = "../../Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + strDocketNo + ",1"
winNew = window.open(strPopupURL, "_blank", strWinFeature)
}
function OpenPopupWindowLSNO(strDocketNo)
{
//debugger
var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
var strPopupURL = "../../Operations/TCS/PrintTCS/ViewAndPrintLoadingSheet.aspx?MFNo=" + strDocketNo + ",0"
winNew = window.open(strPopupURL, "_blank", strWinFeature)
}

function OpenPopupWindowPDC(pdcno,pdctype)
 {
 if(pdctype == "D")
 {
    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
    var strPopupURL = "../../Operations/DRS/DRS_View_Print.aspx?DRSNo=" + pdcno + ",0"
    winNew = window.open(strPopupURL, "_blank", strWinFeature)
 }
 else if(pdctype == "P")
 {
    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
    var strPopupURL = "../../Operations/PRS/PRS_View_Print.aspx?DRSNo=" + pdcno + ",0"
    winNew = window.open(strPopupURL, "_blank", strWinFeature)
 }
 }
function OpenPopupWindowPFM(docno,viewprint)
 {
    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
    var strPopupURL = "../../Operations/PFM/pfm_print.aspx?strPFMNo=" + docno + ",0"
    winNew = window.open(strPopupURL, "_blank", strWinFeature)
 }
</script>
    <div align="left">
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Administrator </strong></font><font class="bluefnt"><strong>
                            &gt; </strong><strong>Tracking</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="../../images/clear.gif" width="2" height="1" /></td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="../../images/back.gif" border="0" />
                    </a>
                </td>
            </tr>
            <tr>
                <td valign="top">
                    <%--<center>--%>
                    <table border="0" id="tbl_cri" runat="server" cellpadding="3" width="565" cellspacing="1"
                        align="left" class="boxbg">
                        <tr style="background-color: #ffffff">
                            <td align="center" class="bgbluegrey" colspan="2">
                                <label class="blackfnt">
                                    <b>You Selected</b></label></td>
                        </tr>
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
                        <tr style="background-color: #ffffff">
                            <td style="height: 6px">
                                <label class="blackfnt">
                                    Document Type :
                                </label>
                            </td>
                            <td style="height: 6px">
                                <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                                </asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td><br />
                    <asp:GridView Visible="false" align="Left" ID="dgMenifest" runat="server" BorderWidth="0"
                        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                        AllowPaging="true" PageSize="20" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                        OnPageIndexChanging="pgChange">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                           
                            <asp:BoundField DataField="doc_no" HeaderText="MF No">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="ManualDocNo" HeaderText="Manual MF No.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="doc_dt" HeaderText="MF Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Origin" HeaderText="Origin">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Dest" HeaderText="Destination">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="thcno" HeaderText="THCNO ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="totdockets" HeaderText="Total Dockets  ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Cancelled" HeaderText="Cancelled">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>
                        <Columns>
                            <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindowManifest('<%#DataBinder.Eval(Container.DataItem, "docno") %>,0')">
                                        <font cssclass="Blackfnt">View </a>
                                </ItemTemplate>
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                        </Columns>
                        <Columns>
                            <asp:TemplateField HeaderText="Print" HeaderStyle-Width="15">
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindowManifestPrint('<%#DataBinder.Eval(Container.DataItem, "docno") %>,1')">
                                        <font cssclass="Blackfnt">Print </a>
                                </ItemTemplate>
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Left" Font-Bold="true" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                    
                     <asp:GridView Visible="false" align="Left" ID="dgLS" runat="server" BorderWidth="0"
                        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                        AllowPaging="true" PageSize="20" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                        OnPageIndexChanging="pgChange">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                           
                            <asp:BoundField DataField="doc_no" HeaderText="LS No">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="ManualDocNo" HeaderText="Manual LS No.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="doc_dt" HeaderText="LS Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Origin" HeaderText="Origin">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Dest" HeaderText="Destination">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            
                            <asp:BoundField DataField="totdockets" HeaderText="Total Dockets  ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            
                        </Columns>
                        <Columns>
                            <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindowLSNO('<%#DataBinder.Eval(Container.DataItem, "docno") %>,0')">
                                        <font cssclass="Blackfnt">View </a>
                                </ItemTemplate>
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Left" Font-Bold="true" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                    
                    
                     <asp:GridView Visible="false" align="Left" ID="dgPDC" runat="server" BorderWidth="0"
            CellPadding="3"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="20" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
            FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
            OnPageIndexChanging="pgChange">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO.">
                    <ItemTemplate>
                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server">
                        </asp:Label>
                    </ItemTemplate>
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
                
                <asp:BoundField DataField="Docno" HeaderText="PDC No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="ManualDocNo" HeaderText="Manual PDC No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                
                 <asp:BoundField DataField="Origin" HeaderText="Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                  <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="doc_dt" HeaderText="PDC Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                  <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="Vehno" HeaderText="Vehicle No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
              
                <asp:BoundField DataField="totdockets" HeaderText="Total Dockets">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                 <asp:BoundField DataField="Cancelled" HeaderText="Cancelled">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowPDC('<%#DataBinder.Eval(Container.DataItem, "docno") %>','<%#DataBinder.Eval(Container.DataItem, "pdcty") %>')">
                            <font cssclass="Blackfnt">View </a>
                    </ItemTemplate>
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
            </Columns>
            <RowStyle />
             <PagerStyle HorizontalAlign="Left" Font-Bold="true" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]" Mode="NumericFirstLast" />
                       <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        
        
        
         <asp:GridView Visible="false" align="Left" ID="dgPFM" runat="server" BorderWidth="0"
                        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                        AllowPaging="true" PageSize="20" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..."
                        OnPageIndexChanging="pgChange">
                        <Columns>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                           
                            <asp:BoundField DataField="doc_no" HeaderText="PFM No">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                             <asp:BoundField DataField="ManualDocNo" HeaderText="Manual PFM No.">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="doc_dt" HeaderText="PFM Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Origin" HeaderText="Origin">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Dest" HeaderText="Destination">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            
                            <asp:BoundField DataField="totdockets" HeaderText="Total Dockets  ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ACK" HeaderText="Acknowledged">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ACKDT" HeaderText="Acknowledged Date ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>
                        <Columns>
                            <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindowPFM('<%#DataBinder.Eval(Container.DataItem, "doc_no") %>','0')">
                                        <font cssclass="Blackfnt">View </a>
                                </ItemTemplate>
                                <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Left" Font-Bold="true" CssClass="bgbluegrey" />
                        <HeaderStyle CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
