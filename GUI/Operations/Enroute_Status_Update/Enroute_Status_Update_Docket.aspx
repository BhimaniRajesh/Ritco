<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Enroute_Status_Update_Docket.aspx.cs" Inherits="GUI_Operations_Enroute_Status_Update_Enroute_Status_Update_Docket" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagName="ProgressBar"
    TagPrefix="pgb" %>
<%@ Register Src="~/GUI/Common_UserControls/WebxComplete/XAC.ascx" TagName="WebxComplete"
    TagPrefix="xac" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/commonJs.js" type="text/javascript" language="javascript"></script>

    <script src="../../images/CalendarPopup.js" type="text/javascript" language="javascript"></script>

    <script type="text/javascript" language="javascript">

        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function closeAlert() {
            document.getElementById("ctl00_MyCPH1_progressBackgroundFilter").style.display = "none";
            document.getElementById("ctl00_MyCPH1_processMessage").style.display = "none";
            return false;
        }

        function optselect() {
            var optdockno = document.getElementById("ctl00_MyCPH1_optselect_0");
            var optmanualdockno = document.getElementById("ctl00_MyCPH1_optselect_1");

            var txtdockno = document.getElementById("ctl00_MyCPH1_txtdockno");
            var txtmdockno = document.getElementById("ctl00_MyCPH1_txtmdockno");
            var txtPLPartner = document.getElementById("ctl00_MyCPH1_txtPLPartner");
            var txtPLPartnernm = document.getElementById("ctl00_MyCPH1_txtPLPartnernm");

            if (optdockno.checked) {
                txtdockno.disabled = false;
                txtdockno.className = 'ltxtm';
                txtdockno.focus();

                txtmdockno.disabled = true;
                txtmdockno.value = "";
                txtmdockno.className = 'ltxtd';

                txtPLPartner.disabled = true;
                txtPLPartner.value = "";
                txtPLPartner.className = 'ltxtd';
            }
            else {
                txtdockno.disabled = true;
                txtdockno.value = "";
                txtdockno.className = 'ltxtd';
                txtmdockno.disabled = false;
                txtmdockno.className = 'ltxtm';
                txtmdockno.focus();
                txtPLPartner.disabled = false;
                txtPLPartner.className = 'ltxtm';
            }
        }

        /*************************************************************************************************************
        *   CHECK MINUTE NOT > 60
        /*************************************************************************************************************/
        function checkMinute(id) {
            var txtSchMM = document.getElementById(id);
            if (txtSchMM.value != "") {
                if ((parseInt(txtSchMM.value) < 0) || (parseInt(txtSchMM.value) > parseInt("59"))) {
                    alert("Minute must be less than 60.");
                    txtSchMM.value = "";
                    txtSchMM.focus();
                }
            }
            return false;
        }

        /*************************************************************************************************************
        *   CHECK Hour NOT > 23
        /*************************************************************************************************************/
        function checkHour(id) {
            var txtSchHH = document.getElementById(id);
            if (txtSchHH.value != "") {
                if (parseInt(txtSchHH.value) > parseInt("23")) {
                    alert("Hour must be less than 24.");
                    txtSchHH.value = "";
                    txtSchHH.focus();
                }
            }
            return false;
        }

        /*************************************************************************************************************
        *   VALIDATION FOR DATE : dd/mm/yyyy Format
        /*************************************************************************************************************/
        function checkDate(id, strCaption) {
            var obj = document.getElementById(id);
            obj.value = obj.value.toUpperCase();

            if (obj.value != "") {
                if (!isValidDate(obj.value, strCaption)) {
                    obj.value = "";
                    obj.focus();
                    return false;
                }
            }
        }

        /*************************************************************************************************************
        *   VALIDATION FOR ALL INPUT WHEN SUBMIT BUTTON CLICK
        /*************************************************************************************************************/

        function btnSubmitCheck() {
            var txtDate = document.getElementById("ctl00_MyCPH1_txtDate");
            var txtTimeHH = document.getElementById("ctl00_MyCPH1_txtTimeHH");
            var txtTimeMM = document.getElementById("ctl00_MyCPH1_txtTimeMM");
            var txtLocation = document.getElementById("ctl00_MyCPH1_txtLocation");

            if (txtDate.value == "") {
                alert("Please enter Date.");
                txtDate.focus();
                return false;
            }

            if (txtTimeHH.value == "") {
                alert("Please enter Hour");
                txtTimeHH.focus();
                return false;
            }

            if (txtTimeMM.value == "") {
                alert("Please enter Minute");
                txtTimeMM.focus();
                return false;
            }

            if (txtLocation.value == "") {
                alert("Please enter Location");
                txtLocation.focus();
                return false;
            }

            return true;
        }
	    	    
    </script>

    <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <br />
            <table>
                <tr id="trHeader" runat="server">
                    <td>
                        <asp:Table ID="tblHeader" runat="server" Width="9in" CellSpacing="1" CssClass="ftbl">
                            <asp:TableRow CssClass="hrow">
                                <asp:TableCell ColumnSpan="4" Font-Bold="true" HorizontalAlign="Center"><font class="blackfnt"><b>Enroute Status Update</b></font></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell HorizontalAlign="Left" ColumnSpan="4">
                                    <asp:RadioButtonList ID="optselect" onclick="javascript:return optselect();" RepeatDirection="Horizontal"
                                        runat="server">
                                        <asp:ListItem Selected="True" Value="CN" Text="Docket Number"></asp:ListItem>
                                        <asp:ListItem Value="MN" Text="3PL  Number"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell Width="20%">
              <font class="blackfnt"><%=SessionUtilities.DocketCalledAs.ToString() %>  Number</font>
                                </asp:TableCell>
                                <asp:TableCell ColumnSpan="3" Width="85%">
                                    <asp:TextBox ID="txtdockno" runat="server" CssClass="ltxtm" TabIndex="1"></asp:TextBox><br />
                                    <asp:Label runat="server" ID="Label3" CssClass="redfnt" Font-Bold="true"></asp:Label>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell Width="20%">
              <font class="blackfnt">3PL Number</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:TextBox ID="txtmdockno" runat="server" CssClass="ltxtm" TabIndex="2"></asp:TextBox><br />
                                    <asp:Label runat="server" ID="Label1" CssClass="redfnt" Font-Bold="true"></asp:Label>
                                </asp:TableCell>
                                <asp:TableCell Width="20%">
              <font class="blackfnt">3PL Partner</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:TextBox ID="txtPLPartner" runat="server" MaxLength="10" Width="60px" CssClass="ltxtm" TabIndex="3" 
                                        autocomplete="off"></asp:TextBox>-<asp:TextBox ID="txtPLPartnernm" Width="100px"
                                            CssClass="ltxtm" runat="server" Enabled="false"></asp:TextBox><br />
                                    <xac:WebxComplete ID="xacPLPartner" runat="server" CodeTarget="txtPLPartner" MinPrefixLength="2"
                                        NameTarget="txtPLPartnernm" FilterString="03" WebxEntity="Vendor" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="frow">
                                <asp:TableCell ColumnSpan="4" Font-Bold="true" HorizontalAlign="Right">
                                    <asp:Button ID="btnstep1" OnClick="btnstep1_Click" Text="Step 1" runat="server" CssClass="nbtn"
                                        TabIndex="4" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </td>
                </tr>                
                <tr id="trDetails" runat="server">
                    <td>
                        <asp:Table ID="tblDetails" runat="server" Width="9in" CellSpacing="1" CssClass="ftbl">
                        <asp:TableRow CssClass="hrow">
                                <asp:TableCell ColumnSpan="4" Font-Bold="true" HorizontalAlign="Center"><font class="blackfnt"><b>Enroute Status Update</b></font></asp:TableCell>
                            </asp:TableRow>
                        <asp:TableRow CssClass="nrow" ID="trDock" runat="server">
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt"><%=SessionUtilities.DocketCalledAs.ToString() %>  Number</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%" ColumnSpan="3">
                                    <asp:Label ID="lblDockNO" runat="server" CssClass="blackfnt" />
                                </asp:TableCell>                                
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow" ID="trPLPartner" runat="server">
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt">3PL Number</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:Label ID="lblmdockno" runat="server" CssClass="blackfnt" />
                                </asp:TableCell>
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt">3PL Partner</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:Label ID="lblPLPartner" runat="server" CssClass="blackfnt" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt">Consignor</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:Label ID="lblConsignor" runat="server" CssClass="blackfnt" />
                                </asp:TableCell>
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt">Consignee</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:Label ID="lblConsignee" runat="server" CssClass="blackfnt" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt">Origin</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:Label ID="lblOrigin" runat="server" CssClass="blackfnt" />
                                </asp:TableCell>
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt">Destination</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:Label ID="lblDestination" runat="server" CssClass="blackfnt" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell Width="20%">
                     <font class="blackfnt">Date of Update</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:TextBox ID="txtDate" runat="Server" Width="70px" BorderStyle="Groove" TabIndex="5"
                                        CssClass="ltxtm" onkeypress="javascript:return validDate(event)" onblur="javascript:return checkDate(this.getAttribute('id'), '')"
                                        MaxLength="10">
                                    </asp:TextBox>&nbsp;<a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDate, 'cal111', 'dd/MM/yyyy'); return false;"
                                        id="cal111"><img src="../../images/calendar.jpg" border="0" alt="calendar.jpg" tabindex="17" />
                                    </a>
                                </asp:TableCell>
                                <asp:TableCell Width="20%">
                     <font class="blackfnt">Time of Update</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:TextBox ID="txtTimeHH" MaxLength="2" onblur="checkHour(this.getAttribute('id'))"
                                        CssClass="rtxtm" onkeypress="javascript:return validInt(event);" runat="server"
                                        Width="22px" TabIndex="6"></asp:TextBox>&nbsp;:
                                    <asp:TextBox ID="txtTimeMM" MaxLength="2" onblur="checkMinute(this.getAttribute('id'))"
                                        CssClass="rtxtm" onkeypress="javascript:return validInt(event);" runat="server"
                                        Width="22px" TabIndex="7"></asp:TextBox>(HH : MM)
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell Width="20%">
                     <font class="blackfnt">Location</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:TextBox ID="txtLocation" runat="Server" Width="250px" CssClass="ltxtm"
                                        MaxLength="250" TabIndex="8" TextMode="MultiLine">
                                    </asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell Width="20%">
                    <font class="blackfnt">Remarks</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:TextBox ID="txtRemarks" runat="Server" Width="250px" CssClass="ltxtm"
                                        MaxLength="250" TabIndex="9" TextMode="MultiLine">
                                    </asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="frow">
                                <asp:TableCell ColumnSpan="4" Font-Bold="true" HorizontalAlign="Center">
                                    <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" Text="Submit" runat="server"
                                        CssClass="nbtn" TabIndex="10" />
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </td>
                </tr>
            </table>
            <%--<pgb:ProgressBar ID="pgrone" runat="server" />--%>
            <asp:HiddenField ID="hdnerrorkeys" runat="server" />
            <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
                z-index: 99;">
            </div>
            <div id="progressBackgroundFilter" visible="false" runat="server" class="progressBackgroundFilter">
            </div>
            <div id="processMessage" visible="false" runat="server" class="processMessage">
                <div style="width: 6in; height: 4in;">
                    <table class="ftbl" cellspacing="1">
                        <tr class="hrow">
                            <td>
                                Message
                            </td>
                        </tr>
                        <tr class="nrow">
                            <td>
                                <table width="100%">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblalert" runat="server" CssClass="nfnt"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Button ID="btnalertclose" Font-Bold="true" onmouseover="this.style.cursor='pointer'"
                                                runat="server" OnClientClick="javascript:return closeAlert();" Width="50px" Text="OK"
                                                CssClass="ebtn"></asp:Button>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
