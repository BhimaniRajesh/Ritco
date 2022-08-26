<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LinkedReport.ascx.cs"
    Inherits="GUI_Common_UserControls_LinkedReport" %>
<link href="../../GUI/images/style.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="../../GUI/images/CalendarPopup.js"> </script>
<script src="../images/commonJs.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">


    function DateCheck() {
        var txtReportName = document.getElementById("<%=txtReportName.ClientID %>");
        var txtReportDesc = document.getElementById("<%=txtReportDesc.ClientID %>");

        if (txtReportName == "") {
            alert("Please enter Report Name")
            txtReportName.focus();
            return false;
        }
    }

    /* function CheckDuplicate() {
    alert("hiii");

    return true;
    }
    */
    function CheckDuplicate(txtid) {

        var hdnajaxstate = document.getElementById("<%=hdnajaxstate.ClientID %>"); // document.getElementById("ctl00_MyCPH1_hdnajaxstate");
        var btnSubmit = document.getElementById("<%=BtUpdSubs.ClientID %>");
        hdnajaxstate.value = "1";
        var txtReportName = document.getElementById("LnkRPT1_txtReportName");
        var txt = txtReportName;
        if (txt.value == "") {
            hdnajaxstate.value = "0";
            return false;
        }

        var strpg = "";
        var findobj = GetXMLHttpObject();
        if (findobj) {
            strpg = "./../AjaxResponse.aspx?mode=check&code1=RPTNM&RPTID=" + txt.value + "&sid=" + Math.random();
            // alert(" hii 2 : - " + strpg)
            findobj.open("GET", strpg);
            findobj.onreadystatechange = function () {
                // alert(" hii : - " + findobj.readyState)
                // alert(" hii 2 : - " + findobj.responseText)
                if ((findobj.readyState == 4)) {

                    var res = findobj.responseText.split("|");
                    // alert(res[0])
                    if (res[0] == "false") {

                        alert("Report Already Exists...");

                        txt.value = "";
                        txt.focus();
                        hdnajaxstate.value = "0";
                        btnSubmit.disabled = true;
                        return false;
                    }
                    else if (res[0] == "true") {
                        hdnajaxstate.value = "0";
                        btnSubmit.disabled = false;

                    }
                }
            }
            findobj.send(null);
        }
        return true;

    }

    function GetXMLHttpObject() {
        var xmlHttp;
        try {
            xmlHttp = new XMLHttpRequest();    // Firefox, Opera 8.0+, Safari    
        }
        catch (e) {
            // Internet Explorer    
            try {
                xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
            }
            catch (e) {
                try
                    { xmlHttp = new ActiveXObject("Microsoft.XMLHTTP"); }
                catch (e) {
                    alert("Your browser does not support AJAX!");
                    return false;
                }
            }
        }
        return xmlHttp;
    }
   

</script>

<%--<table>
    <tr bgcolor="white" style="background-color: white">
        <td align="Left">
            <font class="bluefnt"><i><b>Save Report</b></i></font> <a href="Javascript:return ShowtrlkngrptFilter();">
                <font class="bluefnt"><u><b>Show</b></u></font> </a><a href="Javascript:return HidetrlkngrptFilter();">
                    <font class="bluefnt"><u><b>Hide</b></u></a>
            <asp:LinkButton ID="btnshow" runat="server" Text="Show"></asp:LinkButton><font class="blackfnt">/</font>
            <asp:LinkButton ID="btnhide" runat="server" Text="Hide"></asp:LinkButton><font class="blackfnt">/</font>
            </font>
        </td>
    </tr>
</table>--%>
<asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
<asp:Panel ID="pnlCompanyHDR" runat="server" Width="600px">
    <table class="boxbg" cellpadding="3" cellspacing="1" width="600px">
        <tr class="bgbluegrey">
            <td>
                <table width="100%">
                    <tr>
                        <th width="200px" align="left">
                            <table>
                                <tr valign="middle" align="left">
                                    <th>
                                        <asp:Image ID="ImgCom" runat="server" ImageUrl="~/GUI/images/settings.gif"></asp:Image>
                                    </th>
                                    <th>
                                        <asp:Label CssClass="bluefnt" Font-Bold="true" ID="Label1" runat="server">Save Report</asp:Label>
                                    </th>
                                </tr>
                            </table>
                        </th>
                        <th align="left">
                            <asp:Label CssClass="bluefnt" Font-Bold="true" ID="lblCompanyDetails" runat="server">(Show Details...)</asp:Label>
                        </th>
                        <th style="width: 20px" align="center">
                            <asp:ImageButton ID="ImgCompExpand" runat="server" ImageUrl="~/GUI/images/expand_blue.jpg"
                                AlternateText="(Show Details...)" />
                        </th>
                    </tr>
            </td>
    </table>
    </tr></td> </tr> </table></asp:Panel>
<asp:Panel ID="pnlCompany" runat="server" Height="0" Width="600px">
    <table border="0" class="boxbg" cellpadding="3" cellspacing="1" width="600px">
        <tr>
            <td bgcolor="white" width="15%">
                <asp:Label ID="lblTO" CssClass="blackfnt" runat="server" Text="Report Name"></asp:Label>
            </td>
            <td bgcolor="white" class="style17" width="15%">
                <asp:TextBox ID="txtReportName" CssClass="input" runat="server"></asp:TextBox>
            </td>
            <td bgcolor="white" width="15%">
                <asp:Label ID="Label2" CssClass="blackfnt" runat="server" Text="Report Description"></asp:Label>
            </td>
            <td bgcolor="white" class="style17" width="15%">
                <asp:TextBox ID="txtReportDesc" Width="250" MaxLength="500" CssClass="input" TextMode="MultiLine"
                    runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr bgcolor="white">
            <td colspan="2" bgcolor="white" class="style17" width="15%">
                <asp:Label ID="Label3" CssClass="blackfnt" runat="server" Text="Report available for auto mail"></asp:Label>
            </td>
            <td colspan="2" bgcolor="white" class="style17" width="15%">
                <asp:RadioButtonList ID="rblstYesNo" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                    <asp:ListItem Text="No" Selected="True" Value="N"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr bgcolor="white" id="LBLERR" runat="server" style="display: none;">
            <td colspan="4" bgcolor="white" class="style17" width="15%">
                <asp:Label ID="lerr" runat="server" CssClass="redfnt"></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td align="center" colspan="4">
                <asp:Button ID="BtUpdSubs" runat="server" OnClick="BtUpdSubs_Click" OnClientClick="Javascript:return DateCheck();"
                    Text="Save Report" />
            </td>
        </tr>
    </table>
</asp:Panel>
<ajaxToolkit:CollapsiblePanelExtender ID="cpeCompDetails" runat="Server" TargetControlID="pnlCompany"
    ExpandControlID="pnlCompanyHDR" CollapseControlID="pnlCompanyHDR" Collapsed="True"
    TextLabelID="lblCompanyDetails" ImageControlID="ImgCompExpand" ExpandedText="(Hide Details...)"
    CollapsedText="(Show Details...)" ExpandedImage="~/GUI/images/collapse_blue.jpg"
    CollapsedImage="~/GUI/images/expand_blue.jpg" SuppressPostBack="true" />
