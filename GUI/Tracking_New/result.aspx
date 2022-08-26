<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="result.aspx.cs" Inherits="GUI_Tracking_New_result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript">
    function OpenPopupWindowTS(strDocketNo,view)
    {
        var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=80"
        var strPopupURL = "../Fleet/Operations/Issue/frmViewPrintVehicleIssueSlip.aspx?VSlipNo=" + strDocketNo + "&PrintMode=0"
        winNew = window.open(strPopupURL, "_blank", strWinFeature)
    }
    function OpenPopupWindow_TS(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=70"
            var strPopupURL = "TripSheetTrack.aspx?strDckNo=" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
function OpenPopupWindow(strDocketNo,strDocketsf)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=50"
            //var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
            var strPopupURL = "TAB_Tracking/Docket/Docket_track.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
                  //  var strPopupURL = "../Operation/Singlescreen_docketentry/DocketPrint/DocketView_xls.aspx?dockno=" + strDocketNo + "&docksf=" + docsf  
             //var strPopupURL = "Docket/mainTab.aspx?strDckNo=" + strDocketNo    
            //var strPopupURL = "3.master?strDckNo=" + strDocketNo    
           // var strPopupURL = "docket_tracking.aspx?strDckNo=" + strDocketNo   
            //var strPopupURL = "tckdcktpp.aspx?SessEmpCode=" + '<%=Session["empcd"] %>' + "&SessEmpName=" + '<%=Session["cstnm"] %>' + "&strDckNo=" + strDocketNo + "&Destination=" + strDestination 
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
         function OpenPopupWindow_THC(strDocketNo)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            //var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
            var strPopupURL = "TAB_Tracking/THC/THC_track.aspx?strDckNo=" + strDocketNo    
             //var strPopupURL = "Docket/mainTab.aspx?strDckNo=" + strDocketNo    
            //var strPopupURL = "3.master?strDckNo=" + strDocketNo    
           // var strPopupURL = "docket_tracking.aspx?strDckNo=" + strDocketNo   
            //var strPopupURL = "tckdcktpp.aspx?SessEmpCode=" + '<%=Session["empcd"] %>' + "&SessEmpName=" + '<%=Session["cstnm"] %>' + "&strDckNo=" + strDocketNo + "&Destination=" + strDestination 
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
        function OpenPopupWindowManifest_XLS(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../print/MenifestPrint.aspx?tcno=" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        function OpenPopupWindowTHC_XLS(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../print/THCPrint.aspx?tcno=" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        function OpenPopupWindowPDC_XLS(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../print/PDCPrint.aspx?DRSNo=" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
        
        
 function OpenPopupWindowPDC(pdcno,pdctype,view)
 {
 if(pdctype == "D")
 {
    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
    var strPopupURL = "../../GUI/Operations/DRS/DRS_View_Print.aspx?DRSNo=" + pdcno + ",0"
    winNew = window.open(strPopupURL, "_blank", strWinFeature)
 }
 else if(pdctype == "P")
 {
    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
    var strPopupURL = "../../GUI/Operations/PRS/PRS_View_Print.aspx?DRSNo=" + pdcno + ",0"
    winNew = window.open(strPopupURL, "_blank", strWinFeature)
 }
 }
function OpenPopupWindowManifest(strDocketNo)
{
//debugger
var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
var strPopupURL = "../Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + strDocketNo + ",0"
winNew = window.open(strPopupURL, "_blank", strWinFeature)
}

function OpenPopupWindowTHC(strDocketNo,view)
{
//debugger
var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo//thcprintview_new.aspx//NewTHCView//THCViewPrint
var strPopupURL = "../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + strDocketNo +".,0"
winNew = window.open(strPopupURL, "_blank", strWinFeature)
}

function OpenPopupWindowTHC_New(strDocketNo,view)
{
//debugger
var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo//thcprintview_new.aspx//NewTHCView//THCViewPrint
var strPopupURL = "../Operations/THC/ViewPrint/NewTHCView.aspx?tcno=" + strDocketNo +".,1"
winNew = window.open(strPopupURL, "_blank", strWinFeature)
}

function OpenPopupWindowLSNO(strDocketNo,view)
{
//debugger
var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
var strPopupURL = "../Operations/TCS/PrintTCS/ViewAndPrintLoadingSheet.aspx?MFNo=" + strDocketNo + ",0"
winNew = window.open(strPopupURL, "_blank", strWinFeature)
}
function OpenPopupWindow1(strDocketNo,docsf)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../Operation/Singlescreen_docketentry/DocketPrint/DocketView_xls.aspx?dockno=" + strDocketNo + "&docksf=" + docsf  
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
    </script>

    <br />
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
                    <img src="./../images/clear.gif" width="2" height="1"></td>
            </tr>
            <tr>
                <td align="right">
                    <img src="./../images/back.gif" border="0"></td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <p align="center">
                        <label class="blackfnt">
                            <b>You Selected </b>
                        </label>
                    </p>
                    <%--<center>--%>
                    <table border="0" cellpadding="3" width="565" cellspacing="1" align="center" class="boxbg">
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
                       <%-- <tr style="background-color: #FFFFFF">
                            <td style="width: 205; height: 6px;">
                                <label class="blackfnt">
                                    Customer Code :</label></td>
                            <td style="width: 343; height: 6px;">
                                &nbsp;
                                <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>--%>
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
                    <br />
                    <asp:GridView Visible="false" align="center" ID="dgDocket" runat="server" BorderWidth="0"
                        CellPadding="2" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                        AllowPaging="true" PageSize="10" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
                        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="dgDocket_RowDataBound"
                        EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
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
                            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColname" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "doc_no")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            
                            
                            <asp:TemplateField HeaderText="DocNO" ItemStyle-BackColor="white" Visible="false">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColdockno1" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldockno1" Text='<% #DataBinder.Eval(Container.DataItem, "Docno")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="DocSF" ItemStyle-BackColor="white" Visible="false">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColdocsf" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lbldocksf" Text='<% #DataBinder.Eval(Container.DataItem, "Docsf")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            
                            
                            
                            <asp:BoundField Visible="false" DataField="doc_no" HeaderText="Docket No">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="SR.NO.">
                                <HeaderTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblColDockdt" runat="server"> </asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label CssClass="blackfnt" ID="lblDockdt" Text='<% #DataBinder.Eval(Container.DataItem, "doc_dt")%>'
                                        runat="server">
                                    </asp:Label>
                                </ItemTemplate>
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                                <HeaderStyle CssClass="blackfnt" />
                            </asp:TemplateField>
                            <asp:BoundField Visible="false" DataField="Dockdt" HeaderText="Docket Date">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Deldt" HeaderText=" EDD - ADD ">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Origin_dest" HeaderText="Origin - Destination">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Type" HeaderText="Paybas | Mode">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cnor" HeaderText="Consignor">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cnee" HeaderText="Consignee">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            
                            <asp:BoundField  HeaderText="MR No/Bill">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                            </asp:BoundField>
                            
                            <%--<asp:BoundField DataField="docket_mode" HeaderText="Type">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>--%>
                        </Columns>
                        <%--<Columns>
                            <asp:TemplateField HeaderText="Track" HeaderStyle-Width="40">
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "docno") %>','<%#DataBinder.Eval(Container.DataItem, "docsf") %>')">
                                        <font cssclass="Blackfnt">Track </a>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            </asp:TemplateField>
                        </Columns>
                        <Columns>
                            <asp:TemplateField HeaderText="View" HeaderStyle-Width="40">
                                <ItemTemplate>
                                    <a href="JavaScript:OpenPopupWindow1('<%#DataBinder.Eval(Container.DataItem, "docno") %>','<%#DataBinder.Eval(Container.DataItem, "docsf") %>')">
                                        <font cssclass="Blackfnt">View </a>
                                </ItemTemplate>
                                <HeaderStyle CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                            </asp:TemplateField>
                        </Columns>--%>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
                    
                    
                    <asp:GridView Visible="false" align="center" ID="dgMenifest" runat="server" BorderWidth="0"
            CellPadding="3"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="10" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
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
                <asp:BoundField DataField="ManualdocNo" HeaderText="Manual MF No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
               <%-- <asp:BoundField DataField="tcno" HeaderText="MF No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>--%>
                
                <asp:TemplateField HeaderText="MF No" HeaderStyle-Width="15" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%--<a href="JavaScript:OpenPopupWindowManifest_XLS('<%#DataBinder.Eval(Container.DataItem, "docno") %>')">--%>
                            <font class="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "docno")%> </a>
                        <%-- <asp:LinkButton ID ="LnkView" Text="View" PostBackUrl ='<%#"~/GUI/Tracking/FrmMenifestView.aspx?tcno=" + DataBinder.Eval(Container.DataItem, "tcno") + ""%>' runat="server"  CssClass="blackfnt"></asp:LinkButton> --%>
                    </ItemTemplate>
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
           
                
                <asp:BoundField DataField="doc_dt" HeaderText="MF Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="origin_dest" HeaderText="MF Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="curr_next" HeaderText="Next Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="doc_veh" HeaderText="THCNO ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="docket_mode" HeaderText="Total Dockets  ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowManifest('<%#DataBinder.Eval(Container.DataItem, "docno") %>,0')">
                            <font cssclass="Blackfnt">View </a>
                        <%-- <asp:LinkButton ID ="LnkView" Text="View" PostBackUrl ='<%#"~/GUI/Tracking/FrmMenifestView.aspx?tcno=" + DataBinder.Eval(Container.DataItem, "tcno") + ""%>' runat="server"  CssClass="blackfnt"></asp:LinkButton> --%>
                    </ItemTemplate>
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
            </Columns>
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <asp:GridView Visible="false" align="center" ID="dgLS" runat="server" BorderWidth="0"
            CellPadding="3"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="10" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
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
                    <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
                <asp:BoundField DataField="manualdocno" HeaderText="Manual LS No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center"/>
                </asp:BoundField>
                <asp:BoundField DataField="docno" HeaderText="LS No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center"/>
                </asp:BoundField>
                <asp:BoundField DataField="doc_dt" HeaderText="LS Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white"  HorizontalAlign="Center"/>
                </asp:BoundField>
                <asp:BoundField DataField="origin_dest" HeaderText=" Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="curr_next" HeaderText="Next Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="docket_mode" HeaderText="Total Dockets  ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white"  HorizontalAlign="Center"/>
                </asp:BoundField>
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowLSNO('<%#DataBinder.Eval(Container.DataItem, "docno") %>,0')">
                            <font cssclass="Blackfnt">View </a>
                    </ItemTemplate>
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
            </Columns>
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <asp:GridView Visible="false" align="center" ID="dgTHC" runat="server" BorderWidth="0"
            CellPadding="3"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="10" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
            FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"  OnRowDataBound="dgTHC_RowDataBound"
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
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="ManualdocNo" HeaderText="Manual THC No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <%--<asp:BoundField DataField="thcno" HeaderText="THC No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>--%>
                
                 <asp:TemplateField HeaderText="THC No" HeaderStyle-Width="15" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                       <%-- <a href="JavaScript:OpenPopupWindowTHC_XLS('<%#DataBinder.Eval(Container.DataItem, "docno") %>')">--%>
                            <%--<font class="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "docno")%></font> </a>--%>
                            <asp:Label CssClass="blackfnt" ID="lblTHCno" Text='<% #DataBinder.Eval(Container.DataItem, "docno")%>'
                                        runat="server">
                                    </asp:Label>
                    </ItemTemplate>
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
                
                
                <asp:BoundField DataField="doc_dt" HeaderText="THC Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="origin_dest" HeaderText="Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="doc_veh" HeaderText="Vehicle No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="cust" HeaderText="Driver ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="curr_next" HeaderText="Last Location ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="deldt" HeaderText="Departure Date & Time ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
               <%-- <asp:BoundField DataField="status" HeaderText="Status">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>--%>
            </Columns>
             <Columns>
                <asp:TemplateField HeaderText="Track"  HeaderStyle-Width="40">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindow_THC('<%#DataBinder.Eval(Container.DataItem, "docno") %>')">
                            <font cssclass="Blackfnt">Track </a>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                     <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                </asp:TemplateField>
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowTHC('<%#DataBinder.Eval(Container.DataItem, "docno") %>')">
                            <font cssclass="Blackfnt">View </a>
                    </ItemTemplate>
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
                
                 <asp:TemplateField HeaderText="Print" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowTHC_New('<%#DataBinder.Eval(Container.DataItem, "docno") %>')">
                            <font cssclass="Blackfnt">View </a>
                    </ItemTemplate>
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
            </Columns>
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <asp:GridView Visible="false" align="center" ID="dgPDC" runat="server" BorderWidth="0"
            CellPadding="3"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="10" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
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
                <asp:BoundField DataField="Manualdocno" HeaderText="Manual PDC No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <%--<asp:BoundField DataField="pdcno" HeaderText="PDC No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>--%>
                
                <asp:TemplateField HeaderText="PDC No"  HeaderStyle-Width="15" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%--<a href="JavaScript:OpenPopupWindowPDC_XLS('<%#DataBinder.Eval(Container.DataItem, "docno") %>')">--%>
                            <font class="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "docno")%></font> </a>
                    </ItemTemplate>
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" Wrap="false" />
                </asp:TemplateField>
                 <asp:BoundField DataField="origin_dest" HeaderText="Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                  <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="doc_dt" HeaderText="PDC Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                  <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="doc_veh" HeaderText="Vehicle No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <%--<asp:BoundField DataField="tobh_code" HeaderText="Driver " > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>--%>
                <asp:BoundField DataField="docket_mode" HeaderText="Total Dockets">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowPDC('<%#DataBinder.Eval(Container.DataItem, "docno") %>','P',0)">
                            <font cssclass="Blackfnt">View </a>
                    </ItemTemplate>
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
            </Columns>
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        
        <asp:GridView Visible="false" align="center" ID="dgPDC1" runat="server" BorderWidth="0"
            CellPadding="3"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="10" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
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
                <asp:BoundField DataField="Manualdocno" HeaderText="Manual PDC No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <%--<asp:BoundField DataField="pdcno" HeaderText="PDC No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>--%>
                
                <asp:TemplateField HeaderText="PDC No"  HeaderStyle-Width="15" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%--<a href="JavaScript:OpenPopupWindowPDC_XLS('<%#DataBinder.Eval(Container.DataItem, "docno") %>')">--%>
                            <font class="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "docno")%></font> </a>
                    </ItemTemplate>
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" Wrap="false" />
                </asp:TemplateField>
                 <asp:BoundField DataField="origin_dest" HeaderText="Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                  <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="doc_dt" HeaderText="PDC Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                  <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="doc_veh" HeaderText="Vehicle No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <%--<asp:BoundField DataField="tobh_code" HeaderText="Driver " > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>--%>
                <asp:BoundField DataField="docket_mode" HeaderText="Total Dockets">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowPDC('<%#DataBinder.Eval(Container.DataItem, "docno") %>','D',0)">
                            <font cssclass="Blackfnt">View </a>
                    </ItemTemplate>
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
            </Columns>
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>
        <asp:GridView Visible="false" align="center" ID="dgTS" runat="server" BorderWidth="0"
            CellPadding="3"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="10" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
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
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField DataField="Docno" HeaderText="TripSheet No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                
                 <asp:TemplateField HeaderText="Manual TripSheet No" HeaderStyle-Width="15" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <%--<a href="JavaScript:OpenPopupWindowTS_XLS('<%#DataBinder.Eval(Container.DataItem, "Docno") %>')">--%>
                            <font class="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "ManualDocNo")%></font> <%--</a>--%>
                    </ItemTemplate>
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
                
                
                <asp:BoundField DataField="doc_dt" HeaderText="TS Start Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                
                  <asp:BoundField DataField="Deldt" HeaderText="Close Date ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="Origin_dest" HeaderText="Start Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                
                 <asp:BoundField DataField="Curr_Next" HeaderText="Close Location ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                
                <asp:BoundField DataField="doc_veh" HeaderText="Vehicle No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="cust" HeaderText="Driver ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
               
              
                <asp:BoundField DataField="docket_mode" HeaderText="Status">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
             <%--<Columns>
                <asp:TemplateField HeaderText="Track"  HeaderStyle-Width="40">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindow_TS('<%#DataBinder.Eval(Container.DataItem, "Docno") %>')">
                            <font cssclass="Blackfnt">Track </a>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                     <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                </asp:TemplateField>
            </Columns>--%>
            <Columns>
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowTS('<%#DataBinder.Eval(Container.DataItem, "Docno") %>')">
                            <font cssclass="Blackfnt">View </a>
                    </ItemTemplate>
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
            </Columns>
            <RowStyle />
            <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
            <HeaderStyle CssClass="bgbluegrey" />
            <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
            <FooterStyle CssClass="boxbg" />
        </asp:GridView>

                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
