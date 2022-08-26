<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_NET_MIS_LRWiseCollection_Query" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgr" %>
<%@ Register Src="../../Common_UserControls/LocationHirarchy.ascx" TagName="LocationHirarchy"
    TagPrefix="uc1" %>
<asp:content id="Content1" contentplaceholderid="MyCPH1" runat="Server">

    <script src="../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>

    <script src="../../images/commonJs.js" type="text/javascript"></script>

    <script src="../../Js/Date.js" type="text/javascript"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("divDate");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <script language="JavaScript" type="text/javascript">
        function validate() {
            var txtDKTNo = document.getElementById("ctl00_MyCPH1_txtDKTNo");
            var FromDate = document.getElementById("ctl00_MyCPH1_DT_txtDateFrom");
            var ToDate = document.getElementById("ctl00_MyCPH1_DT_txtDateTo");
            var radDateRange = document.getElementById("ctl00_MyCPH1_DT_radDate_0");
            var hdnRptId = document.getElementById("ctl00_MyCPH1_hdnRptId"); // added by Manisha 26/5/2014
        //var RO = document.getElementById("ctl00_MyCPH1_LocationHirarchy_cboRO");
            //var Region = RO.options[RO.selectedIndex].value;
            //var LO = document.getElementById("ctl00_MyCPH1_LocationHirarchy_cboLO");
            //var Location = LO.options[LO.selectedIndex].value;
            
            if (txtDKTNo.value == "") {
                if (radDateRange.checked)
            {
               if (FromDate.value == "") {
                    alert("Please Select From Date");
                    FromDate.focus();
                    return false;
                }
                else if (ToDate.value == "") {
                    alert("Please Select To Date");
                    ToDate.focus();
                    return false;
                }
            }
               var dat =/^\s*((0?[1-9]|[12][0-9]|3[01])[/](0?[1-9]|1[012])[/](20|19)[0-9]{2})\s*$/;
                if (!dat.test(FromDate.value)) {
                    alert("Invalid format FromDate");
                    FromDate.value="";
                    FromDate.focus();
                    return false;
                }
                if (!dat.test(ToDate.value)) {
                    alert("Invalid format ToDate");
                    ToDate.value="";
                    ToDate.focus();
                    return false;
                }
                var now = new Date();
                var day = now.getDate();
                var month = now.getMonth() + 1;
                var year = now.getFullYear();

                if (month < 10) {
                    month = "0" + month;
                }

                var today = day + "/" + month + "/" + year;
                var mindate = "01/01/1950";

                if (Date.parse(DateString(FromDate.value)) < Date.parse(DateString(mindate))) {
                    alert("Enter Date more than 01/01/1950");
                    return false;
                }

                if (Date.parse(DateString(FromDate.value)) > Date.parse(DateString(today))) {
                    alert("Enter FromDate Less than TODAY's Date");
                    return false;
                }
                if (Date.parse(DateString(ToDate.value)) > Date.parse(DateString(today))) {
                    alert("Enter ToDate Less than TODAY's Date");
                    return false;
                }
                if (Date.parse(DateString(FromDate.value)) > Date.parse(DateString(ToDate.value))) {
                    alert("From Date must be less than ToDate");
                    return false;
                }
            }
            var qs = "?FromDate=" + FromDate.value + "&ToDate=" + ToDate.value + "&dockno=" + txtDKTNo.value.trim() + "&hdnRptId=" + hdnRptId.value;
            window.open("Result.aspx" + qs, "pbr", "top=0, left=0, width=900, height=650, scrollbars=yes, menubar=no,toolbar=no,status=1,resizable=yes").focus();

        }
         function DateString(str) {
            var arrDate = new Array();
            arrDate = str.split('/');
            return arrDate[1] + '/' + arrDate[0] + '/' + arrDate[2];
        } 
    </script>

    <br />
   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 26/5/2014 --%>
<asp:table runat="server" id="tblHdr" cellspacing="1" width="900px">
        <asp:tablerow cssclass="nrow" horizontalalign="left">
            <asp:tableheadercell height="30">
                <font class="blklnkund">
<strong>Operation </strong>
<strong>&gt;</strong><strong> CNote wise Collection Report</strong></font>
            </asp:tableheadercell>
        </asp:tablerow>
        <asp:tablerow>
            <asp:tablecell cssclass="horzblue">
                <img alt="" src="../../images/clear.gif" width="2" height="1" />
            </asp:tablecell>
        </asp:tablerow>
        <asp:tablerow>
            <asp:tablecell horizontalalign="Right">
            <a href="javascript:window.history.go(-1)" title="back">
                <img alt="Back" src="../../images/back.gif" border="0" />
            </a>
            &nbsp;</asp:tablecell>
        </asp:tablerow>
        <asp:tablerow>
            <asp:tablecell horizontalalign="left">
                <asp:table id="tblMain" runat="server" horizontalalign="left" cssclass="boxbg" cellpadding="3"
                    cellspacing="1" borderwidth="0" width="900px">
                    <asp:tablerow cssclass="bgbluegrey" verticalalign="Middle">
                        <asp:tableheadercell horizontalalign="left" columnspan="2" font-bold="true">
                            <center>
                                Select Criteria</center>
                        </asp:tableheadercell>
                    </asp:tablerow>
                    <%--<asp:tablerow cssclass="bgwhite" verticalalign="Middle">
            <asp:tablecell horizontalalign="left" columnspan="1">
            Location               
            </asp:tablecell>
            <asp:tablecell horizontalalign="left" columnspan="1">
                <uc1:LocationHirarchy ID="LocationHirarchy" runat="server" />
            </asp:tablecell>
        </asp:tablerow>--%>
                    <asp:tablerow cssclass="bgwhite" verticalalign="Middle">
                        <asp:tablecell horizontalalign="left" columnspan="1">
            Select Date               
            </asp:tablecell>
                        <asp:tablecell horizontalalign="left" columnspan="1">
                            <Date:DT ID="DT" runat="server" />
                        </asp:tablecell>
                    </asp:tablerow>
                    <asp:tablerow cssclass="bgwhite" verticalalign="Middle">
                        <asp:tablecell horizontalalign="center" columnspan="2" font-bold="true" cssclass="blackfnt">
            OR              
            </asp:tablecell>
                    </asp:tablerow>
                    <asp:tablerow cssclass="bgwhite" verticalalign="Middle">
                        <asp:tablecell horizontalalign="left" columnspan="1">
            Enter Docket No              
            </asp:tablecell>
                        <asp:tablecell horizontalalign="left" columnspan="1" cssclass="bgwhite">
                            <asp:textbox id="txtDKTNo" runat="server" cssclass="blackfnt" maxlength="100">
                            </asp:textbox>
                        </asp:tablecell>
                    </asp:tablerow>
                    <asp:tablefooterrow cssclass="bgbluegrey" verticalalign="Middle">
                        <asp:tablecell horizontalalign="left" columnspan="2" font-bold="true">
                            <center>
                                <asp:button id="btnSubmit" runat="server" font-bold="true" usesubmitbehavior="false"
                                    cssclass="blackfnt" text="Show" onclientclick="javascript:return validate()" />
                            </center>
                            <pgr:ProgressBar ID="pgrMain" runat="server" />
                        </asp:tablecell>
                    </asp:tablefooterrow>
                </asp:table>
            </asp:tablecell>
        </asp:tablerow>
    </asp:table>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:content>
