<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="DeliveryMR_submit_done.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_Docket_submit_done" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/commonJs.js" type="text/javascript" language="javascript"></script>

    <script language="javascript" type="text/javascript">
        function popupmenu1() {
            debugger;
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 700 + ",height=" + 400 + "";
            var hdngatepassno = document.getElementById("ctl00_MyCPH1_hdngatepassno");
            confirmWin = window.open('../../Finance/Billing_Ver1/MRDotmatrixViewPrint.aspx?mrsno=' + hdngatepassno.value, "", winOpts);
        }
        function popupmenu2() {
            debugger;
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 700 + ",height=" + 400 + "";
            var hdngatepassno = document.getElementById("ctl00_MyCPH1_hdngatepassno");
            confirmWin = window.open('../../Finance/Billing_Ver1/MRDotmatrixViewPrint_Freight0.aspx?mrsno=' + hdngatepassno.value, "", winOpts);
        }
         function docPrint()
         {
            //alert("123");
            var fileURL = new String(document.location)
            var cnt=fileURL.indexOf("/GUI/",0);
            var hdngatepassno=document.getElementById("ctl00_MyCPH1_hdngatepassno");
            var HdnLocation=document.getElementById("ctl00_MyCPH1_HdnLocation");
            var hdn_psp_url = document.getElementById("ctl00_MyCPH1_hdn_psp_url");            
            window.open(fileURL.substring(0,cnt) + hdn_psp_url.value.substring(1,hdn_psp_url.value.length) + '?tp=0&doctype=GP&Location=' + HdnLocation.value + "&gatepassnos=" + hdngatepassno.value + "&start=&end=","",null);
            //window.open(fileURL.substring(0,cnt) + hdn_psp_url.value.substring(1,hdn_psp_url.value.length) + '?tp=0&doctype=GP&gatepassnos=' + hdngatepassno.value + "&start=&end=","",null);
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
                    <img alt="" src="../../images/clear.gif" width="15" height="10" /></td>
            </tr>
            <tr>
                <td>
                    <img alt="" src="../../images/clear.gif" width="15" height="10" /></td>
            </tr>
            <tr>
                <td>
                    <table border="0" cellpadding="1" cellspacing="1" class="boxbg">
                        <tr class="bgbluegrey" style="height: 25px">
                            <td align="left" colspan="5" style="height: 25px">
                                <font class="blackfnt"><b>Following document has been successfully generated</b></font></td>
                        </tr>
                        <tr bgcolor="white" style="font-size: 12pt; font-family: Times New Roman; height: 25px">
                            <td colspan="2" align="left" nowrap>
                                <font class="blackfnt">&nbsp;&nbsp;&nbsp;&nbsp;<%=dkt_call %>
                                    Name&nbsp;&nbsp;&nbsp;&nbsp;</font>
                            </td>
                            <td style="width: 398px" align="center">
                                <font class="blackfnt">
                                    <%=dkt_call %>
                                    Number</font>
                            </td>
                            <td style="width: 339px" colspan=2>
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
                                <a href="javascript:docPrint()" runat="server" id="a1"><u>Print</u></a>
                            </td>
                            <td style="width: 339px" align="center">
                                <a href="javascript:popupmenu1()" runat="server" id="a2"><u>New Mr View</u></a>
                                <span>/</span>
                                <a href="javascript:popupmenu2()" runat="server" id="a3"><u>Tejas Print</u></a>
                            </td>
                        </tr>
                        <tr bgcolor="white" id="trbill" runat="server" style="font-size: 12pt; font-family: Times New Roman;
                            height: 25px">
                            <td colspan="2" align="center">
                                <font class="blackfnt">Bill</font></td>
                            <td style="width: 398px" align="center">
                                <asp:Label ID="lblbillno" runat="server" CssClass="blackfnt" Width="313px"></asp:Label>
                            </td>
                            <td style="width: 339px" align="center" colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr class="bgbluegrey" style="height: 25px; font-size: 12pt; font-family: Times New Roman;">
                            <td align="left" colspan="5">
                                <strong><span style="font-size: 8pt; font-family: Verdana">Your Next Step</span></strong></td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td bgcolor="#FFFFFF" align="center" style="width: 9185px; height: 25px">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="center" class="bullet">
                                            <img src="../../../images/clear.gif" width="4" height="4" /></td>
                                    </tr>
                                </table>
                            </td>
                            <td width="100%" align="left" bgcolor="#FFFFFF" colspan="5" style="height: 25px">
                                <font class="blackfnt"><u><a href="DeliveryMrSelectionCritaria.aspx">
                                <font class="blklnkund">Click Here to Generate More Delivery MRs</a></u></font>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td bgcolor="#FFFFFF" align="center" style="width: 9185px; height: 25px">
                                <table border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="center" class="bullet">
                                            <img src="../../../images/clear.gif" width="4" height="4" /></td>
                                    </tr>
                                </table>
                            </td>
                            <td width="100%" align="left" bgcolor="#FFFFFF" colspan="5" style="height: 25px">
                                <font class="blackfnt"><u><a href="../GatePass/GatePassCriteria.aspx">
                                <font class="blklnkund">Click Here to Update GatePass</a></u></font>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdngatepassno" runat="server" />
        <asp:HiddenField ID="hdnbillno" runat="server" />
        <asp:HiddenField ID="hdn_psp_url" runat="server" />
        <asp:HiddenField ID="HdnLocation" runat="server" />
    </div>
    
</asp:Content>
