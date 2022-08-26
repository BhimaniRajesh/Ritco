<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Tracking_Result.aspx.cs" Inherits="GUI_Tracking_Tracking_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript">

function OpenPopupWindow(strDocketNo)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            //var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
            var strPopupURL = "2.aspx?strDckNo=" + strDocketNo    
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
            var strPopupURL = "THCTrack.aspx?strDckNo=" + strDocketNo    
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
        
        
        
 function OpenPopupWindowPDC(pdcno,pdctype)
 {
 if(pdctype == "D")
 {
    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
    var strPopupURL = "../../GUI/Operations/DRS/DRS_View_Print.aspx?DRSNo=" + pdcno
    winNew = window.open(strPopupURL, "_blank", strWinFeature)
 }
 else if(pdctype == "P")
 {
    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
    var strPopupURL = "../../GUI/Operations/PRS/PRS_View_Print.aspx?DRSNo=" + pdcno
    winNew = window.open(strPopupURL, "_blank", strWinFeature)
 }
 }
function OpenPopupWindowManifest(strDocketNo)
{
//debugger
var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
var strPopupURL = "FrmMenifestView.aspx?tcno=" + strDocketNo
winNew = window.open(strPopupURL, "_blank", strWinFeature)
}

function OpenPopupWindowTHC(strDocketNo)
{
//debugger
var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
var strPopupURL = "../Operations/THC/ViewPrint/thcprintview_new.aspx?tcno=" + strDocketNo
winNew = window.open(strPopupURL, "_blank", strWinFeature)
}

function OpenPopupWindowLSNO(strDocketNo)
{
//debugger
var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
var strPopupURL = "../Operations/TCS/PrintTCS/ViewAndPrintLoadingSheet.aspx?MFNo=" + strDocketNo
winNew = window.open(strPopupURL, "_blank", strWinFeature)
}
function OpenPopupWindow1(strDocketNo)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../Operation/Singlescreen_docketentry/DocketPrint/DocketView_xls.aspx?dockno=" + strDocketNo    
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
       
    </script>

    <%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">--%>
    <div>
        <br />
        <p align="center">
            <label class="blackfnt">
                <b>You Selected </b>
            </label>
        </p>
        <%--<center>--%>
        <table border="0" cellpadding="3" width="565" 
            cellspacing="1" align="center" class="boxbg">
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
                        Document Type :
                    </label>
                </td>
                <td style="height: 6px">
                    <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                    </asp:Label></td>
            </tr>
        </table>
        <br />
        <asp:GridView Visible="false" align="center" ID="dgDocket" runat="server"  BorderWidth="0"
            CellPadding="2"  CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true" AllowPaging="true"
            PageSize="10" PagerStyle-HorizontalAlign="left" CssClass="boxbg" 
           
            FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" OnRowDataBound="dgDocket_RowDataBound"
            EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
            <Columns>
                <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
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
                                      <asp:Label CssClass="blackfnt" ID="lblColname"    runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt" ID="lbldockno"  Text='<% #DataBinder.Eval(Container.DataItem, "docket")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                         <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                <asp:BoundField  Visible="false" DataField="docket" HeaderText="Docket No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt"  BackColor="white"/>
                </asp:BoundField>
                 <asp:TemplateField HeaderText="SR.NO.">
                                     <HeaderTemplate>
                                      <asp:Label CssClass="blackfnt" ID="lblColDockdt"    runat="server"> </asp:Label>
                                     </HeaderTemplate>
                                        <ItemTemplate>
                                        
                                            <asp:Label CssClass="blackfnt"  ID="lblDockdt"  Text='<% #DataBinder.Eval(Container.DataItem, "Dockdt")%>'        runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                
                <asp:BoundField  Visible="false"  DataField="Dockdt" HeaderText="Docket Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="cdeldt" HeaderText=" EDD - ADD ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="orgncd" HeaderText="Origin - Destination">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="paybas" HeaderText="Paybas | Mode">
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
                <%--<asp:BoundField DataField="docket_mode" HeaderText="Type">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>--%>
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="Track"  HeaderStyle-Width="40">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindow('<%#DataBinder.Eval(Container.DataItem, "docket") %>')">
                            <font cssclass="Blackfnt">Track </a>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                     <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                </asp:TemplateField>
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="40">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindow1('<%#DataBinder.Eval(Container.DataItem, "DOCKNO") %>')">
                            <font cssclass="Blackfnt">View </a>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                     <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                </asp:TemplateField>
            </Columns>
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
                <asp:BoundField DataField="Manual_TCNo" HeaderText="Manual MF No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
               <%-- <asp:BoundField DataField="tcno" HeaderText="MF No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>--%>
                
                <asp:TemplateField HeaderText="MF No" HeaderStyle-Width="15" HeaderStyle-HorizontalAlign="Center">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowManifest_XLS('<%#DataBinder.Eval(Container.DataItem, "tcno") %>')">
                            <font class="Blackfnt"><%#DataBinder.Eval(Container.DataItem, "tcno") %> </a>
                        <%-- <asp:LinkButton ID ="LnkView" Text="View" PostBackUrl ='<%#"~/GUI/Tracking/FrmMenifestView.aspx?tcno=" + DataBinder.Eval(Container.DataItem, "tcno") + ""%>' runat="server"  CssClass="blackfnt"></asp:LinkButton> --%>
                    </ItemTemplate>
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
           
                
                <asp:BoundField DataField="tcdt" HeaderText="MF Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="tcbr" HeaderText="MF Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="tobh_code" HeaderText="Next Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="THCNO" HeaderText="THCNO ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                     <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="TOT_DKT" HeaderText="Total Dockets  ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowManifest('<%#DataBinder.Eval(Container.DataItem, "tcno") %>')">
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
                <asp:BoundField DataField="manuallsno" HeaderText="Manual LS No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center"/>
                </asp:BoundField>
                <asp:BoundField DataField="tcno" HeaderText="LS No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center"/>
                </asp:BoundField>
                <asp:BoundField DataField="tcdt" HeaderText="LS Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white"  HorizontalAlign="Center"/>
                </asp:BoundField>
                <asp:BoundField DataField="tcbr" HeaderText="LS Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white"  HorizontalAlign="Center"/>
                </asp:BoundField>
                <asp:BoundField DataField="tobh_code" HeaderText="Next Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white"  HorizontalAlign="Center"/>
                </asp:BoundField>
                <asp:BoundField DataField="TOT_DKT" HeaderText="Total Dockets  ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle CssClass="blackfnt" BackColor="white"  HorizontalAlign="Center"/>
                </asp:BoundField>
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowLSNO('<%#DataBinder.Eval(Container.DataItem, "tcno") %>')">
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
                <asp:BoundField DataField="ManualThcNo" HeaderText="Manual THC No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="thcno" HeaderText="THC No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="thcdt" HeaderText="THC Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="thcbr" HeaderText="Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="vehno" HeaderText="Vehicle No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="driver1" HeaderText="Driver ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="tobh_code" HeaderText="Last Location ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="dept_date_time" HeaderText="Departure Date & Time ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="status" HeaderText="Status">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
             <Columns>
                <asp:TemplateField HeaderText="Track"  HeaderStyle-Width="40">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindow_THC('<%#DataBinder.Eval(Container.DataItem, "thcno") %>')">
                            <font cssclass="Blackfnt">Track </a>
                    </ItemTemplate>
                    <HeaderStyle CssClass="blackfnt" />
                     <ItemStyle CssClass="blackfnt" BackColor="white" HorizontalAlign="Center" Wrap="false" />
                </asp:TemplateField>
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowTHC('<%#DataBinder.Eval(Container.DataItem, "thcno") %>')">
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
                <asp:BoundField DataField="Manualpdcno" HeaderText="Manual PDC No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="pdcno" HeaderText="PDC No">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                    <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="pdcdt" HeaderText="PDC Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                  <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="vehno" HeaderText="Vehicle No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
                <%--<asp:BoundField DataField="tobh_code" HeaderText="Driver " > 
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                                    <ItemStyle CssClass="blackfnt" />
                                </asp:BoundField>--%>
                <asp:BoundField DataField="TOT_DKT" HeaderText="Total Dockets">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                   <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <Columns>
                <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                    <ItemTemplate>
                        <a href="JavaScript:OpenPopupWindowPDC('<%#DataBinder.Eval(Container.DataItem, "pdcno") %>','<%#DataBinder.Eval(Container.DataItem, "PDCTY") %>')">
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
    </div>
</asp:Content>
<%--   </form>
</body>
</html>
--%>
