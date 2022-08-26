<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="Enroute_Status_Update_Vehicle_THC.aspx.cs" Inherits="GUI_Operations_Enroute_Status_Update_Enroute_Status_Update_Vehicle_THC" %>

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
                        <asp:Table ID="tblHeader" runat="server" Width="6in" CellSpacing="1" CssClass="ftbl">
                            <asp:TableRow CssClass="hrow">
                                <asp:TableCell ColumnSpan="4" Font-Bold="true" HorizontalAlign="Center"><font class="blackfnt"><b>Enroute Status Update</b></font></asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow" ID="trVehicle" runat="server">
                                <asp:TableCell Width="30%">
              <font class="blackfnt">Enter Vehicle Number</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:TextBox ID="txtVehicleNo" runat="server" CssClass="ltxtm" TabIndex="2" Width="180px" autocomplete="off"></asp:TextBox><br />
                                    <xac:WebxComplete ID="xacVehicleNo" runat="server" CodeTarget="txtVehicleNo" MinPrefixLength="2" WebxEntity="Vehicle"/>                                    
                                </asp:TableCell>
                                <asp:TableCell ColumnSpan="2" HorizontalAlign="Right">
                                    <asp:Button ID="btnstep1" OnClick="btnstep1_Click" Text="Step 1" runat="server" CssClass="nbtn"
                                        TabIndex="1" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow" ID="trTHCNo" runat="server">
                                <asp:TableCell Width="30%">
              <font class="blackfnt"><%=SessionUtilities.THCCalledAs.ToString()%>  Number</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:TextBox ID="txtTHCNo" runat="server" CssClass="ltxtm" TabIndex="2" Width="180px"></asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell ColumnSpan="2" HorizontalAlign="Right">
                                    <asp:Button ID="btnstep2" OnClick="btnstep1_Click" Text="Step 1" runat="server" CssClass="nbtn"
                                        TabIndex="1" />
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
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt">Vehicle Number</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:Label ID="lblVehicleNo" runat="server" CssClass="blackfnt" />
                                </asp:TableCell>
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt"><%=SessionUtilities.THCCalledAs.ToString()%>  Number</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:Label ID="lblTHCNo" runat="server" CssClass="blackfnt" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt">Driver</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:Label ID="lblDriver" runat="server" CssClass="blackfnt" />
                                </asp:TableCell>
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt">Mobile</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:Label ID="lblMobile" runat="server" CssClass="blackfnt" />
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell Width="20%">
                     <font class="blackfnt">Date of Update</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:TextBox ID="txtDate" runat="Server" Width="70px" BorderStyle="Groove" TabIndex="2"
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
                                        Width="22px" TabIndex="3"></asp:TextBox>&nbsp;:
                                    <asp:TextBox ID="txtTimeMM" MaxLength="2" onblur="checkMinute(this.getAttribute('id'))"
                                        CssClass="rtxtm" onkeypress="javascript:return validInt(event);" runat="server"
                                        Width="22px" TabIndex="4"></asp:TextBox>(HH : MM)
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell Width="20%">
                     <font class="blackfnt">Location</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:TextBox ID="txtLocation" runat="Server" Width="250px" CssClass="ltxtm"
                                        MaxLength="250" TabIndex="5" TextMode="MultiLine">
                                    </asp:TextBox>
                                </asp:TableCell>
                                <asp:TableCell Width="20%">
                    <font class="blackfnt">Remarks</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:TextBox ID="txtRemarks" runat="Server" Width="250px" CssClass="ltxtm"
                                        MaxLength="250" TabIndex="6" TextMode="MultiLine">
                                    </asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt">Movement Status</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:DropDownList ID="ddlMovementStatus" CssClass="blackfnt" runat="server" Width="150px" TabIndex="7"/>
                                </asp:TableCell>
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt">Awaiting action</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%">
                                    <asp:DropDownList ID="ddlAwaitingAction" CssClass="blackfnt" runat="server" Width="150px" TabIndex="8"/>
                                </asp:TableCell>
                            </asp:TableRow>
                            <asp:TableRow CssClass="nrow">
                                <asp:TableCell Width="20%">
                                    <font class="blackfnt">Days since last action</font>
                                </asp:TableCell>
                                <asp:TableCell Width="30%" ColumnSpan="3">
                                    <asp:TextBox ID="txtDays" runat="server" CssClass="rtxtm" Width="50px" onkeypress="javascript:return validInt(event);" TabIndex="9"/>  
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
           <%-- <pgb:ProgressBar ID="pgrone" runat="server" />--%>
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
