<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result_RS.aspx.cs" Inherits="GUI_View_Track_Operation_Result_RS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" src="../../images/dropdowncontent.js">   </script>

    <script language="javascript" type="text/javascript">
    function OpenPopupWindow_Summary(strDocketNo,strDocketsf,ID)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=20,top=20"
            var strPopupURL = "DKT_TAB_Tracking.aspx?dockno="+strDocketNo+"&docksf="+ strDocketsf +"&ID="+ ID  
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
            function OpenPopupWindow_Summary_THC(strDocketNo,ID)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=20,top=20"
            var strPopupURL = "THC_TAB_Tracking.aspx?THCNO="+strDocketNo+"&ID="+ ID  
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
          function OpenPopupWindow_view(strDocketNo,docsf)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "../../Operation/Singlescreen_docketentry/DocketPrint/DocketView_xls.aspx?dockno=" + strDocketNo + "&docksf=" + docsf  
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
         function OpenWindowTHC(strTHC,view)
        {
           
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=125"
                var strURL = "./../../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + strTHC
                winNew = window.open(strURL,"_blank",strWinFeature)
           
        }
          function OpenPopupWindowTRS(strDocketNo)
        {
           
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=125"
                var strURL = "./../../Fleet/Operations/Issue/frmViewPrintVehicleIssueSlipNew.aspx?VSlipNo=" + strDocketNo+ "&PrintMode=0"
                winNew = window.open(strURL,"_blank",strWinFeature)
           
        }
        
        function OpenPopupWindowManifest(strDocketNo)
{
//debugger
var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=270"
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
var strPopupURL = "../../Operations/TCS/PrintTCS/FrmMenifestView.aspx?MFNo=" + strDocketNo + ",0"
winNew = window.open(strPopupURL, "_blank", strWinFeature)
}

function OpenPopupWindowLSNO(strDocketNo)
{
//debugger
var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=270"
//var strPopupURL = "1.aspx?strDckNo=" + strDocketNo
var strPopupURL = "../../Operations/TCS/PrintTCS/ViewAndPrintLoadingSheet.aspx?MFNo=" + strDocketNo + ",0"
winNew = window.open(strPopupURL, "_blank", strWinFeature)
}

function OpenPopupWindowPDC(pdcno,pdctype)
 {
 if(pdctype == "D")
 {
    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=270"
    var strPopupURL = "../../Operations/DRS/DRS_View_Print.aspx?DRSNo=" + pdcno + ",0"
    winNew = window.open(strPopupURL, "_blank", strWinFeature)
 }
 else if(pdctype == "P")
 {
    var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=270"
    var strPopupURL = "../../Operations/PRS/PRS_View_Print.aspx?DRSNo=" + pdcno + ",0"
    winNew = window.open(strPopupURL, "_blank", strWinFeature)
 }
 }
    </script>

    <div align="left">
        <asp:UpdatePanel ID="UP" runat="server">
            <ContentTemplate>
                <table style="width: 12.5in" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr>
                        <td height="30">
                            <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                                class="blklnkund"><strong>Administrator </strong></font><font class="bluefnt"><strong>
                                    &gt; </strong><strong>View & Track - Operation</strong> </font>
                        </td>
                    </tr>
                    <tr>
                        <td class="horzblue">
                            <img src="./../../images/clear.gif" width="2" height="1"></td>
                    </tr>
                    <tr>
                        <td align="right">
                            <a href="javascript:window.history.go(-1)" title="back">
                                <img alt="Back" src="./../../images/back.gif" border="0">
                            </a>
                            <div align="Left">
                                <asp:UpdateProgress ID="uppMain" runat="server">
                                    <ProgressTemplate>
                                        <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                            -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                            <tr>
                                                <td align="right">
                                                    <img src="./../../images/loading.gif" alt="" />
                                                </td>
                                                <td>
                                                    <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                                            background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                                            opacity: .50; -moz-opacity: .50;" runat="server">
                                            <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                                                left: 50%;" ID="Panel2" runat="server">
                                            </asp:Panel>
                                        </asp:Panel>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </div>
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
                                <%-- <tr style="background-color: #FFFFFF">
                            <td style="width: 205; height: 15px;">
                                <label class="blackfnt">
                                    RO :</label></td>
                            <td style="width: 343; height: 15px;">
                                &nbsp;
                                <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>--%>
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
                    <tr bgcolor="white" id="TRPG" runat="server" style="display: block;">
                        <td colspan="2" align="left" valign="top">
                            <br />
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <img alt="Back" id="imgPrev" style="display: none;" runat="server" src="./../../images/prev.gif"
                                border="0" />
                            <font class="blackfnt">Page :</font>
                            <asp:DropDownList ID="PAging" AutoPostBack="true" CssClass="blackfnt" runat="server"
                                OnSelectedIndexChanged="PAging_SelectedIndexChanged">
                            </asp:DropDownList>
                            <font class="blackfnt">&nbsp;&nbsp;<b>of</b>&nbsp;
                                <%=TOTPg%>
                            </font>
                            <img alt="Back" id="imgNext" style="display: none;" runat="server" src="./../../images/next.gif"
                                border="0" />
                        </td>
                    </tr>
                    <tr bgcolor="white" id="TR1" runat="server" style="display: none;">
                        <td colspan="2" align="left" valign="top">
                            <br />
                            <asp:GridView ID="DGTrackDKT" runat="server" EmptyDataText="No Records Found" CssClass="boxbg"
                                HeaderStyle-CssClass="bgbluegrey" BorderWidth="0" k CellPadding="5" CellSpacing="1"
                                Visible="false" OnRowDataBound="dgDocket_RowDataBound" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="" runat="server">
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
                                            <asp:Label CssClass="blackfnt" ID="lbldockno" Text='<% #DataBinder.Eval(Container.DataItem, "docno")%>'
                                                runat="server">
                                            </asp:Label>
                                            <asp:Label CssClass="blackfnt" ID="lbldocksf" Text='<% #DataBinder.Eval(Container.DataItem, "docsf")%>'
                                                runat="server">
                                            </asp:Label>
                                            <asp:Label CssClass="blackfnt" Visible="false" ID="lbldocstaus" Text='<% #DataBinder.Eval(Container.DataItem, "status")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="doc_dt" HeaderText="Booking">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Deldt" HeaderText="EDD - ADD">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Origin_dest" HeaderText="Origin - Destination">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Curr_Next" HeaderText="Curr. Loc. - Next Loc.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="From_to" HeaderText="From - To">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Type" HeaderText="Paybas | Mode | Type">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="doc_veh" HeaderText="Cust Ref. No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="cnor" HeaderText="Consignor">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="cnee" HeaderText="Consignee">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                </Columns>
                                <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"
                                    Width="200" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr bgcolor="white" id="TR2" runat="server" style="display: none;">
                        <td colspan="2" align="left" valign="top">
                            <br />
                            <asp:GridView ID="dgTHC" runat="server" EmptyDataText="No Records Found" CssClass="boxbg"
                                HeaderStyle-CssClass="bgbluegrey" BorderWidth="0" CellPadding="5" CellSpacing="1"
                                Visible="false" OnRowDataBound="dgTHC_RowDataBound" AutoGenerateColumns="false">
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                        <ItemTemplate>
                                            <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="" runat="server">
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
                                            <asp:Label CssClass="blackfnt" Visible="false" ID="lbldocksf" Text='<% #DataBinder.Eval(Container.DataItem, "docno")%>'
                                                runat="server">
                                            </asp:Label>
                                            <asp:Label CssClass="blackfnt" Visible="false" ID="lbldocstaus" Text='<% #DataBinder.Eval(Container.DataItem, "status")%>'
                                                runat="server">
                                            </asp:Label>
                                        </ItemTemplate>
                                        <HeaderStyle CssClass="blackfnt" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="doc_dt" HeaderText="Booking">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ManualDocNo" HeaderText="Manual No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Origin_dest" HeaderText="Location">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="doc_veh" HeaderText="Vehicle No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Curr_Next" HeaderText="Last Location">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Deldt" HeaderText="Departure Date & Time">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="doc_veh" HeaderText="Vehicle No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                                    </asp:BoundField>
                                </Columns>
                                <RowStyle HorizontalAlign="center" BackColor="white" CssClass="blackfnt" Wrap="false"
                                    Width="200" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr bgcolor="white" id="TR3" runat="server" style="display: none;">
                        <td colspan="2" align="left" valign="top">
                            <br />
                            <asp:GridView Visible="false" align="Left" ID="dgMenifest" runat="server" BorderWidth="0"
                                CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                                AllowPaging="false" PageSize="20" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                OnRowDataBound="dgDOC_RowDataBound" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                EmptyDataText="No Records Found...">
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
  <asp:BoundField DataField="TOT_PKGS" HeaderText="Total Pkgs  ">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
  <asp:BoundField DataField="TOT_aCTUWT" HeaderText="Total Act. Wt.  ">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Right" />
                                    </asp:BoundField>
  <asp:BoundField DataField="frt" HeaderText="Total FRT  ">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Right" />
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
                                <RowStyle />
                                <PagerStyle HorizontalAlign="Left" Font-Bold="true" CssClass="bgbluegrey" />
                                <HeaderStyle CssClass="bgbluegrey" />
                                <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                                    Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr bgcolor="white" id="TR4" runat="server" style="display: none;">
                        <td colspan="2" align="left" valign="top">
                            <br />
                            <asp:GridView Visible="false" align="Left" ID="dgLS" runat="server" BorderWidth="0"
                                CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                                AllowPaging="false" PageSize="20" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                OnRowDataBound="dgDOC_RowDataBound" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                EmptyDataText="No Records Found...">
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
                                <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                                    Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr bgcolor="white" id="TR5" runat="server" style="display: none;">
                        <td colspan="2" align="left" valign="top">
                            <br />
                            <asp:GridView Visible="false" align="Left" ID="dgPDC" runat="server" BorderWidth="0"
                                CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                                AllowPaging="false" PageSize="20" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                OnRowDataBound="dgDOC_RowDataBound" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                EmptyDataText="No Records Found...">
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
                                <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                                    Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr bgcolor="white" id="TR6" runat="server" style="display: none;">
                        <td colspan="2" align="left" valign="top">
                            <br />
                            <asp:GridView Visible="false" align="Left" ID="dgPFM" runat="server" BorderWidth="0"
                                CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                                AllowPaging="false" PageSize="20" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                OnRowDataBound="dgDOC_RowDataBound" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                EmptyDataText="No Records Found...">
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
                                            <a href="JavaScript:OpenPopupWindowManifest('<%#DataBinder.Eval(Container.DataItem, "docno") %>,0')">
                                                <font cssclass="Blackfnt">View </a>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle />
                                <PagerStyle HorizontalAlign="Left" Font-Bold="true" CssClass="bgbluegrey" />
                                <HeaderStyle CssClass="bgbluegrey" />
                                <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                                    Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr bgcolor="white" id="TR7" runat="server" style="display: none;">
                        <td colspan="2" align="left" valign="top">
                            <br />
                            <asp:GridView Visible="false" align="Left" ID="dgTRS" runat="server" BorderWidth="0"
                                CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
                                AllowPaging="false" PageSize="20" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                                OnRowDataBound="dgDOC_RowDataBound" FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast"
                                AutoGenerateColumns="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"
                                EmptyDataText="No Records Found...">
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
                                    <asp:BoundField DataField="doc_no" HeaderText="TripSheet No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ManualDocNo" HeaderText="Manual PFM No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="doc_dt" HeaderText="TS Start Date">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="deldt" HeaderText="Close Date">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Origin" HeaderText="Start Location">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="dest" HeaderText="Close Location">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="doc_veh" HeaderText="Vehicle No.">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="cust" HeaderText="Driver">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                     <asp:BoundField DataField="docket_mode" HeaderText="Status">
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                                <Columns>
                                    <asp:TemplateField HeaderText="View" HeaderStyle-Width="15">
                                        <ItemTemplate>
                                            <a href="JavaScript:OpenPopupWindowTRS('<%#DataBinder.Eval(Container.DataItem, "docno") %>,0')">
                                                <font cssclass="Blackfnt"><u>View </u></a>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="false" BackColor="white" CssClass="blackfnt" HorizontalAlign="Center" />
                                        <HeaderStyle CssClass="blackfnt" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle />
                                <PagerStyle HorizontalAlign="Left" Font-Bold="true" CssClass="bgbluegrey" />
                                <HeaderStyle CssClass="bgbluegrey" />
                                <PagerSettings FirstPageText="[First]" Position="TopAndBottom" LastPageText="[Last]"
                                    Mode="NumericFirstLast" />
                                <FooterStyle CssClass="boxbg" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <script type="text/javascript">

 ij="<%=jk%>"
for(i=1;i<ij;i++)
{
     dropdowncontent.init("contentlink"+i, "left-top", 300, "mouseover")
}
dropdowncontent.init("contentlink"+ij, "left-top", 300, "mouseover")

    </script>

</asp:Content>
