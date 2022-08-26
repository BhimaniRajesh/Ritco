<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DocketTrack.aspx.cs" Inherits="GUI_Tracking_New_Webxsite_DocketTrack" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
    <LINK rel="stylesheet" type="text/css" href="../../../GUI/images/style.css" />
     <script language="javascript">

function OpenPopupWindow(strDocketNo,strDocketsf)
        {
           
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=50"
            //var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
            var strPopupURL = "TAB_Tracking/Docket/Docket_track.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
                           winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
         function OpenPopupWindow_THC(strDocketNo)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            //var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
            var strPopupURL = "TAB_Tracking/THC/THC_track.aspx?strDckNo=" + strDocketNo    
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
    var strPopupURL = "../../../../GUI/Operations/DRS/DRS_View_Print.aspx?DRSNo=" + pdcno + ",0"
    winNew = window.open(strPopupURL, "_blank", strWinFeature)
 }
 else if(pdctype == "P")
 {
    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
    var strPopupURL = "../../../GUI/Operations/PRS/PRS_View_Print.aspx?DRSNo=" + pdcno + ",0"
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
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo//thcprintview_new.aspx
var strPopupURL = "../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + strDocketNo +".,0"
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
        
        function topWindowPOD(strDocketNo1)
        {
        
            var strWinFeature1 = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
             
              var client="<%=Session["Client"]%>"
            var strPopupURL1 = "../../../GUI/Operations/FM/FMDocuments/"+client+"/" + strDocketNo1   
           
            winNew = window.open(strPopupURL1, "_blank", strWinFeature1)
            
        }
     </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
    <br />
   
    <img id="imgLogo" height="60" width="100" runat="server" />

    <br />
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
                                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%#Container.DataItemIndex+1 %>"
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
                                    <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<%#DataBinder.Eval(Container.DataItem, "docketno")%>'
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
                                    <asp:Label CssClass="blackfnt" ID="lblDockdt" Text='<%#DataBinder.Eval(Container.DataItem, "dockdt")%>'
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
                          
                            <asp:BoundField DataField="Origin_dest" HeaderText="Origin - Destination">
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
                           </Columns>
                           <Columns>
                <asp:TemplateField HeaderText="View POD" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:topWindowPOD('<%#DataBinder.Eval(Container.DataItem, "PODName") %>')">
                            <font cssclass="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "POD")%> </a>
                       
                    </ItemTemplate>
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
            </Columns>
                        <RowStyle />
                        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
                        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
                        <FooterStyle CssClass="boxbg" />
                    </asp:GridView>
    </div>
    </form>
</body>
</html>
