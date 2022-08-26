<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_Tracking_ver1_Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <%--<link rel="stylesheet" href="JS_CSS/thumbnailviewer.css" type="text/css" />

    <script src="JS_CSS/thumbnailviewer.js" type="text/javascript">

/***********************************************
* Image Thumbnail Viewer Script- � Dynamic Drive (www.dynamicdrive.com)
* This notice must stay intact for legal use.
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/

    </script>--%>

    <script type="text/javascript" src="../../images/dropdowncontent.js">

/***********************************************
* Drop Down/ Overlapping Content- � Dynamic Drive (www.dynamicdrive.com)
* This notice must stay intact for legal use.
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/

    </script>

    <script language="javascript" type="text/javascript">
/*function OpenPopupWindow(strDocketNo,strDocketsf)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "Docket/DOcket_track.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }*/
        
 function OpenPopupWindow_Summary(strDocketNo,strDocketsf)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "Docket/DocketSummary.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
 function OpenPopupWindow_OPNLIFECYCLE(strDocketNo,strDocketsf)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "Docket/opnLifecycle.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
   function OpenPopupWindow_FINLIFECYCLE(strDocketNo,strDocketsf)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "Docket/FinLifeCycle.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
  function OpenPopupWindow_PODTrack(strDocketNo,strDocketsf)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "Docket/PODPFM_track.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
   function OpenPopupWindow_movement(strDocketNo,strDocketsf)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "Docket/Movement.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }

 /*function OpenPopupWindow_THC_TRACK(strDckNo)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=900hi ,height=540,status=no,left=60,top=50"
            var strPopupURL = "TAB_Tracking/THC_Track.aspx?strDckNo="+strDckNo
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }*/
        
     function OpenPopupWindow_Summary_THC(strDocketNo,strDocketsf)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "THC/Summary.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
 function OpenPopupWindow_OPNLIFECYCLE_THC(strDocketNo,strDocketsf)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "THC/Opn_Lifecycle.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
 function OpenPopupWindow_movement_THC(strDocketNo,strDocketsf)
        {
            //debugger
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=800,height=600,status=no,left=60,top=50"
            var strPopupURL = "THC/Movement.aspx?strDckNo="+strDocketNo+"&strDcksf="+ strDocketsf  
            
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }
        
  function OpenPopupWindow_view(strDocketNo,docsf)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=830,height=540,status=no,left=60,top=270"
            var strPopupURL = "../../Operation/Singlescreen_docketentry/DocketPrint/DocketView_xls.aspx?dockno=" + strDocketNo + "&docksf=" + docsf  
            winNew = window.open(strPopupURL, "_blank", strWinFeature)
            
        }
 function OpenWindowTHC(strTHC,view)
        {
           
                var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
                var strURL = "./../../Operations/THC/ViewPrint/THCViewPrint.aspx?tcno=" + strTHC
                winNew = window.open(strURL,"_blank",strWinFeature)
           
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
            <%--<tr>
            <td valign="top"><br />
                <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="Left">
                    <tr bgcolor="white">
                        <td colspan="2" align="center">
                            <asp:Button ID="Button1" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>--%>
            <tr>
                <td>
                    <br />
                    <asp:Table ID="TBL_TRACKING" Visible="false" border="0" HorizontalAlign="left" runat="server"
                        CellPadding="3" CellSpacing="1" Style="width: 8.5in;" CssClass="boxbg">
                    </asp:Table>
                </td>
            </tr>
            <%--<tr>
            <td valign="top"><br />
                <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="Left">
                    <tr bgcolor="white">
                        <td colspan="2" align="center">
                            <asp:Button ID="Button2" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>--%>
        </table>
    </div>
    <%-- <DIV id="subcontent2" style="position:absolute; visibility: hidden; border: 1px solid black; background-color: AliceBlue; width: 160px; height: 30px; padding: 4px;">

<div style="width: 100%; float: left">
<ul>
<li><a href="JavaScript:OpenPopupWindow_Summary(,,)" rel="thumbnail"><font size="+4" class="blackfnt">Summary</font></a></li>
<li><a href="http://www.javascriptkit.com"><font class="blackfnt">Operation Life Cycle</font></a></li>
<li><a href="http://www.cssdrive.com"><font class="blackfnt">Finance Life Cycle</font></a></li>
</ul>
</div>

<div align="right"><a href="javascript:dropdowncontent.hidediv('subcontent2')">Hide This DIV Manually</a></div>

</DIV>--%>

    <script type="text/javascript">
//Call dropdowncontent.init("anchorID", "positionString", glideduration, "revealBehavior") at the end of the page:

//dropdowncontent.init("searchlink", "right-bottom", 500, "mouseover")
 ij="<%=jk%>"
 for(i=1;i<ij;i++)
{
     dropdowncontent.init("contentlink"+i, "left-top", 300, "mouseover")
}
dropdowncontent.init("contentlink"+ij, "left-top", 300, "mouseover")

    </script>

</asp:Content>
