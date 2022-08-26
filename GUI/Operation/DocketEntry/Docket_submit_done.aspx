<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Docket_submit_done.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_Docket_submit_done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/commonJs.js" type="text/javascript" language="javascript"></script>

    <script type="text/javascript" src="../../images/dropdowncontent.js"></script>

    <script language="javascript" type="text/javascript">
 function popupCoverlater()
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var billno="<%=billno%>"
 
    var fileURL = new String(document.location)
    var cnt=fileURL.indexOf("/GUI/",0);
    var hdn_bps_url = document.getElementById("ctl00_MyCPH1_hdn_bps_url");
    window.open(fileURL.substring(0,cnt) + hdn_bps_url.value.substring(1,hdn_bps_url.value.length) + '?Bill_No=' + billno,"",winOpts);
    return false;
  
 }
 function popupBillView()
 { 
   var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
   var billno="<%=billno%>"
  
   var fileURL = new String(document.location)
    var cnt=fileURL.indexOf("/GUI/",0);
    var hdn_abv_url = document.getElementById("ctl00_MyCPH1_hdn_abv_url");
    window.open(fileURL.substring(0,cnt) + hdn_abv_url.value.substring(1,hdn_abv_url.value.length) + '?billno=' + billno,"",winOpts);
    return false;
 }
 
 function popupmenu2()
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  dockno="<%=dockno%>"
  confirmWin=window.open('DocketPrint/DocketView_xls.aspx?dockno=' + dockno + '&docksf=.',"",winOpts);
 }
 function popupmenu1()
 { 
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var mrno="<%=mrno%>,0";
      confirmWin=window.open('DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno='+ mrno,"",winOpts);
 }
 function popupmenuPrint()
 {
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var mrno="<%=mrno%>,1";
      confirmWin=window.open('DocketPrint/PaidMR/MR_Summ_Popup.aspx?mrsno='+ mrno,"",winOpts);
 }
 
 function docPrint()
 {
    var fileURL = new String(document.location)
    var cnt=fileURL.indexOf("/GUI/",0);
    var dockno="<%=dockno%>";
    var hdn_psp_url = document.getElementById("ctl00_MyCPH1_hdn_psp_url");
    window.open(fileURL.substring(0,cnt) + hdn_psp_url.value.substring(1,hdn_psp_url.value.length) + '?tp=0&docknos=' + dockno,"",null);
    return false;
}     
    </script>

    <br />
    <div id="divres" runat="server" style="width: 9in; height: 8in; display: none;">
    </div>
    <div align="left" style="width: 9.5in;">
        <table style="width: 9.5in;" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <img src="../../images/clear.gif" width="15" height="10"></td>
            </tr>
            <tr>
                <td>
                    <img src="../../images/clear.gif" width="15" height="10"></td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey" style="height: 25px">
                            <td align="left" colspan="4" style="height: 25px">
                                <font class="blackfnt"><b>Following document has been successfully Generated</b></font></td>
                        </tr>
                        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
                            <td colspan="2" align="left" nowrap>
                                <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;Document Name&nbsp;&nbsp;&nbsp;&nbsp;</font>
                            </td>
                            <td style="width: 398px" align="center">
                                <font class="blackfnt">Document Number</font>
                            </td>
                            <td style="width: 339px">
                            </td>
                        </tr>
                        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
                            <td colspan="2" align="center">
                                <font class="blackfnt">
                                    <%=dkt_call %>
                                </font>
                            </td>
                            <td style="width: 398px" align="center">
                                <asp:Label ID="cnno" runat="server" CssClass="blackfnt" Width="313px"></asp:Label></td>
                            <td style="width: 339px" align="center">
                                <a href="javascript:popupmenu2()" runat="server" id="ankone"><u>View</u></a>
                                <label onmouseover="this.style.cursor='pointer'" class="blackfnt" onclick="javascript:return docPrint()"
                                    runat="server" id="a3">
                                    <u>Print</u></label>
                            </td>
                        </tr>
                        <tr bgcolor="white" id="trmr" runat="server" style="font-size: 12pt; font-family: Times New Roman;
                            height: 25px">
                            <td colspan="2" align="center">
                                <font class="blackfnt">MR</font></td>
                            <td style="width: 398px" align="center">
                                <asp:Label ID="mrsno" runat="server" CssClass="blackfnt" Width="313px"></asp:Label>
                            </td>
                            <td style="width: 339px" align="center">
                                <a href="javascript:popupmenu1()" runat="server" id="a1"><u>View</u></a>|<a href="javascript:popupmenuPrint()"
                                    runat="server" id="a2"><u>Print</u></a>
                            </td>
                        </tr>
                        <tr bgcolor="white" id="trbillno" runat="server" style="font-size: 12pt; font-family: Times New Roman;
                            height: 25px">
                            <td colspan="2" align="center">
                                <font class="blackfnt">BILL </font>
                            </td>
                            <td style="width: 398px" align="center">
                                <asp:Label ID="lblbillno" runat="server" CssClass="blackfnt" Width="313px"></asp:Label>
                            </td>
                            <td style="width: 339px" align="center">
                                <asp:LinkButton ID="lnkbillview" runat="server" Font-Underline="true" OnClientClick="javascript:return popupBillView()">View</asp:LinkButton>|
                                <asp:LinkButton ID="lnkbillcoverletter" runat="server" Font-Underline="true" OnClientClick="javascript:return popupCoverlater()">CoveringLater</asp:LinkButton>
                            </td>
                        </tr>
                        <tr bgcolor="white">
                            <td colspan="4" align="left" style="height: 25px">
                                <font class="blackfnt"><a href="#" id="Href_Acct_Po" rel="Acct_Po"><b>Show Accounting
                                    Treatment For Document </b></a></font>
                                <div align="left" id="Acct_Po" style='position: absolute; visibility: hidden; border: 1px solid black;
                                    background-color: AliceBlue; width: 600px; height: 200; padding: 1px;'>
                                    <div>
                                        <%=ToolTip_Str%>
                                    </div>
                                </div>

                                <script type="text/javascript">
                                                           // alert(Href_Acct_Po)
                                                            dropdowncontent.init("Href_Acct_Po", "right-middle", 500, "mouseover")   
                                                           //alert(Href_Acct_Po)
                                </script>

                            </td>
                        </tr>
                        <tr class="bgbluegrey" style="height: 25px; font-size: 12pt; font-family: Times New Roman;">
                            <td align="left" colspan="4">
                                <strong><span style="font-size: 8pt; font-family: Verdana">Your Next Step</span></strong></td>
                        </tr>
                        <tr id="trentry" runat="server" bgcolor="#FFFFFF">
                            <td bgcolor="#FFFFFF" align="center" style="width: 9185px; height: 25px">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="center" class="bullet">
                                            <img src="../../../images/clear.gif" width="4" height="4" /></td>
                                    </tr>
                                </table>
                            </td>
                            <td width="100%" align="left" bgcolor="#FFFFFF" colspan="5" style="height: 25px">
                                <font class="blackfnt"><u><a href="docket.aspx"><font class="blklnkund">Click here for
                                    More
                                    <%=dkt_call %>Entry</a></u></font>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF" id="tredit" runat="server">
                            <td bgcolor="#FFFFFF" align="center" style="width: 9185px; height: 25px">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="center" class="bullet">
                                            <img src="../../../images/clear.gif" width="4" height="4" /></td>
                                    </tr>
                                </table>
                            </td>
                            <td width="100%" align="left" bgcolor="#FFFFFF" colspan="5" style="height: 25px">
                                <font class="blackfnt"><u><a href="DocketEdit_Step1.aspx"><font class="blklnkund">Click
                                    here to Edit
                                    <%=dkt_call %></a></u></font>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdn_psp_url" runat="server" />
        <asp:HiddenField ID="hdn_bps_url" runat="server" />
        <asp:HiddenField ID="hdn_abv_url" runat="server" />
    </div>
</asp:Content>
