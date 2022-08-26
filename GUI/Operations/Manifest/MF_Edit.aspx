<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="MF_Edit.aspx.cs" Inherits="GUI_Operations_Manifest_MF_Edit" Title="Untitled Page" %>

<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<%@ Register src="../../Common_UserControls/ProgressBar.ascx" tagname="ProgressBar" tagprefix="uc1" %>
<asp:content id="Content1" contentplaceholderid="MyCPH1" runat="Server">
    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>
    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>
    <script src="../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>
    <script type="text/javascript">

        function changeMFDetails(chkB) {
            var ctrlID = chkB.getAttribute('id');
            var IsChecked = chkB.checked;
            if (IsChecked) {
                chkB.parentElement.parentElement.style.backgroundColor = '669999';
                chkB.parentElement.parentElement.style.color = 'white';

                var txttotaldockets = document.getElementById("<%=txttotaldockets.ClientID %>");
                var txttotalpackages = document.getElementById("<%=txttotalpackages.ClientID %>");
                var txttotalweight = document.getElementById("<%=txttotalweight.ClientID %>");
                var hidtotaldockets = document.getElementById("<%=hidtotaldockets.ClientID %>");
                var hidtotalpackages = document.getElementById("<%=hidtotalpackages.ClientID %>");
                var hidtotalweight = document.getElementById("<%=hidtotalweight.ClientID %>");
                var hidTotActWt = document.getElementById("<%=hidTotActWt.ClientID %>");
                var hidTotActPkg = document.getElementById("<%=hidTotActPkg.ClientID %>");
                var lblTotActWt = document.getElementById("<%=lblTotActWt.ClientID %>");
                var lblTotActPkg = document.getElementById("<%=lblTotActPkg.ClientID %>");

                var hidPkgsLoad = document.getElementById(ctrlID.replace("chkDocket", "hidPkgsLoad"));
                var hidWeightLoad = document.getElementById(ctrlID.replace("chkDocket", "hidWeightLoad"));
                var hidPkgs = document.getElementById(ctrlID.replace("chkDocket", "hidPkgs"));
                var hidWeight = document.getElementById(ctrlID.replace("chkDocket", "hidWeight"));

                var iTotDkt = parseInt(txttotaldockets.value);
                var iTotPkgs = parseInt(txttotalpackages.value);
                var fTotWeight = parseFloat(txttotalweight.value);

                var iTotActPkgs = parseInt(hidTotActPkg.value);
                var fTotActWeight = parseFloat(hidTotActWt.value);

                var iPkgs = parseInt(hidPkgsLoad.value);
                var fWeight = parseFloat(hidWeightLoad.value);
                var iActPkgs = parseInt(hidPkgs.value);
                var fActWeight = parseFloat(hidWeight.value);

                iTotDkt = iTotDkt - 1;
                iTotPkgs = iTotPkgs - iPkgs;
                fTotWeight = fTotWeight - fWeight;
                iTotActPkgs = iTotActPkgs - iActPkgs;
                fTotActWeight = fTotActWeight - fActWeight;

                txttotaldockets.value = roundNumber(iTotDkt, 0);
                txttotalpackages.value = roundNumber(iTotPkgs, 0);
                txttotalweight.value = roundNumber(fTotWeight, 2)
                hidtotaldockets.value = roundNumber(iTotDkt, 0);
                hidtotalpackages.value = roundNumber(iTotPkgs, 0);
                hidtotalweight.value = roundNumber(fTotWeight, 2)

                hidTotActWt.value = roundNumber(fTotActWeight, 2);
                hidTotActPkg.value = roundNumber(iTotActPkgs, 0);
                lblTotActWt.innerText = roundNumber(fTotActWeight, 2);
                lblTotActPkg.innerText = roundNumber(iTotActPkgs, 0);
                CalculateWeightAdj();
            }
            else {
                chkB.parentElement.parentElement.style.backgroundColor = 'white';
                chkB.parentElement.parentElement.style.color = 'black';

                var txttotaldockets = document.getElementById("<%=txttotaldockets.ClientID %>");
                var txttotalpackages = document.getElementById("<%=txttotalpackages.ClientID %>");
                var txttotalweight = document.getElementById("<%=txttotalweight.ClientID %>");
                var hidtotaldockets = document.getElementById("<%=hidtotaldockets.ClientID %>");
                var hidtotalpackages = document.getElementById("<%=hidtotalpackages.ClientID %>");
                var hidtotalweight = document.getElementById("<%=hidtotalweight.ClientID %>");
                var hidTotActWt = document.getElementById("<%=hidTotActWt.ClientID %>");
                var hidTotActPkg = document.getElementById("<%=hidTotActPkg.ClientID %>");
                var lblTotActWt = document.getElementById("<%=lblTotActWt.ClientID %>");
                var lblTotActPkg = document.getElementById("<%=lblTotActPkg.ClientID %>");

                var hidPkgsLoad = document.getElementById(ctrlID.replace("chkDocket", "hidPkgsLoad"));
                var hidWeightLoad = document.getElementById(ctrlID.replace("chkDocket", "hidWeightLoad"));
                var hidPkgs = document.getElementById(ctrlID.replace("chkDocket", "hidPkgs"));
                var hidWeight = document.getElementById(ctrlID.replace("chkDocket", "hidWeight"));

                var iTotDkt = parseInt(txttotaldockets.value);
                var iTotPkgs = parseInt(txttotalpackages.value);
                var fTotWeight = parseFloat(txttotalweight.value);

                var iTotActPkgs = parseInt(hidTotActPkg.value);
                var fTotActWeight = parseFloat(hidTotActWt.value);

                var iPkgs = parseInt(hidPkgsLoad.value);
                var fWeight = parseFloat(hidWeightLoad.value);
                var iActPkgs = parseInt(hidPkgs.value);
                var fActWeight = parseFloat(hidWeight.value);

                iTotDkt = iTotDkt + 1;
                iTotPkgs = iTotPkgs + iPkgs;
                fTotWeight = fTotWeight + fWeight;
                iTotActPkgs = iTotActPkgs + iActPkgs;
                fTotActWeight = fTotActWeight + fActWeight;

                txttotaldockets.value = roundNumber(iTotDkt, 0);
                txttotalpackages.value = roundNumber(iTotPkgs, 0);
                txttotalweight.value = roundNumber(fTotWeight, 2)
                hidtotaldockets.value = roundNumber(iTotDkt, 0);
                hidtotalpackages.value = roundNumber(iTotPkgs, 0);
                hidtotalweight.value = roundNumber(fTotWeight, 2);

                hidTotActWt.value = roundNumber(fTotActWeight, 2);
                hidTotActPkg.value = roundNumber(iTotActPkgs, 0);
                lblTotActWt.innerText = roundNumber(fTotActWeight, 2);
                lblTotActPkg.innerText = roundNumber(iTotActPkgs, 0);
                CalculateWeightAdj();
            }
        }

        function onDateCheck(selectedDate) {
            //alert("script started")
            var txtDocumentDate = document.getElementById("<%=hidmfdate.ClientID%>");
            var txtNextStopcd = document.getElementById("<%=lblnextstop.ClientID %>");

            if (selectedDate.value != "") {
                var mfdt = getDate(txtDocumentDate.value);
                var dt = getDate(selectedDate.value);
                if (dt > mfdt) {
                    alert("Date should not be grater than MF date.");
                    selectedDate.value = "";
                    selectedDate.focus();
                }
            }
        }

        function onDktCheck(chkB) {
            var ctrlID = chkB.getAttribute('id');
            var IsChecked = chkB.checked;
            if (IsChecked) {
                chkB.parentElement.parentElement.style.backgroundColor = '669999';
                chkB.parentElement.parentElement.style.color = 'white';

                var txttotaldockets = document.getElementById("<%=txttotaldockets.ClientID %>");
                var txttotalpackages = document.getElementById("<%=txttotalpackages.ClientID %>");
                var txttotalweight = document.getElementById("<%=txttotalweight.ClientID %>");
                var hidtotaldockets = document.getElementById("<%=hidtotaldockets.ClientID %>");
                var hidtotalpackages = document.getElementById("<%=hidtotalpackages.ClientID %>");
                var hidtotalweight = document.getElementById("<%=hidtotalweight.ClientID %>");
                var hidTotActWt = document.getElementById("<%=hidTotActWt.ClientID %>");
                var hidTotActPkg = document.getElementById("<%=hidTotActPkg.ClientID %>");
                var lblTotActWt = document.getElementById("<%=lblTotActWt.ClientID %>");
                var lblTotActPkg = document.getElementById("<%=lblTotActPkg.ClientID %>");

                var hdpkgsno = document.getElementById(ctrlID.replace("chkDocket", "hdpkgsno"));
                var hdwt = document.getElementById(ctrlID.replace("chkDocket", "hdwt"));
                var txtPkgs = document.getElementById(ctrlID.replace("chkDocket", "txtPkgs"));
                var txtWt = document.getElementById(ctrlID.replace("chkDocket", "txtWt"));

                txtPkgs.disabled = false;
                if (txtWt.value == hdwt.value)
                    txtWt.disabled = true;
                else
                    txtWt.disabled = false;

                var iTotDkt = parseInt(txttotaldockets.value);
                var iTotPkgs = parseInt(txttotalpackages.value);
                var fTotWeight = parseFloat(txttotalweight.value);
                var iTotActPkgs = parseInt(hidTotActPkg.value);
                var fTotActWeight = parseFloat(hidTotActWt.value);

                var iPkgs = parseInt(txtPkgs.value);
                var fWeight = parseFloat(txtWt.value);
                var iActPkgs = parseInt(hdpkgsno.value);
                var fActWeight = parseFloat(hdwt.value);

                iTotDkt = iTotDkt + 1;
                iTotPkgs = iTotPkgs + iPkgs;
                fTotWeight = fTotWeight + fWeight;
                iTotActPkgs = iTotActPkgs + iActPkgs;
                fTotActWeight = fTotActWeight + fActWeight;

                txttotaldockets.value = roundNumber(iTotDkt, 0);
                txttotalpackages.value = roundNumber(iTotPkgs, 0);
                txttotalweight.value = roundNumber(fTotWeight, 2)
                hidtotaldockets.value = roundNumber(iTotDkt, 0);
                hidtotalpackages.value = roundNumber(iTotPkgs, 0);
                hidtotalweight.value = roundNumber(fTotWeight, 2);

                hidTotActWt.value = roundNumber(fTotActWeight, 2);
                hidTotActPkg.value = roundNumber(iTotActPkgs, 0);
                lblTotActWt.innerText = roundNumber(fTotActWeight, 2);
                lblTotActPkg.innerText = roundNumber(iTotActPkgs, 0);
                CalculateWeightAdj();
            }
            else {
                chkB.parentElement.parentElement.style.backgroundColor = 'white';
                chkB.parentElement.parentElement.style.color = 'black';

                var txttotaldockets = document.getElementById("<%=txttotaldockets.ClientID %>");
                var txttotalpackages = document.getElementById("<%=txttotalpackages.ClientID %>");
                var txttotalweight = document.getElementById("<%=txttotalweight.ClientID %>");
                var hidtotaldockets = document.getElementById("<%=hidtotaldockets.ClientID %>");
                var hidtotalpackages = document.getElementById("<%=hidtotalpackages.ClientID %>");
                var hidtotalweight = document.getElementById("<%=hidtotalweight.ClientID %>");
                var hidTotActWt = document.getElementById("<%=hidTotActWt.ClientID %>");
                var hidTotActPkg = document.getElementById("<%=hidTotActPkg.ClientID %>");
                var lblTotActWt = document.getElementById("<%=lblTotActWt.ClientID %>");
                var lblTotActPkg = document.getElementById("<%=lblTotActPkg.ClientID %>");


                var hdpkgsno = document.getElementById(ctrlID.replace("chkDocket", "hdpkgsno"));
                var hdwt = document.getElementById(ctrlID.replace("chkDocket", "hdwt"));
                var txtPkgs = document.getElementById(ctrlID.replace("chkDocket", "txtPkgs"));
                var txtWt = document.getElementById(ctrlID.replace("chkDocket", "txtWt"));

                txtPkgs.disabled = true;
                txtWt.disabled = true;

                var iTotDkt = parseInt(txttotaldockets.value);
                var iTotPkgs = parseInt(txttotalpackages.value);
                var fTotWeight = parseFloat(txttotalweight.value);
                var iTotActPkgs = parseInt(hidTotActPkg.value);
                var fTotActWeight = parseFloat(hidTotActWt.value);

                var iPkgs = parseInt(txtPkgs.value);
                var fWeight = parseFloat(txtWt.value);
                var iActPkgs = parseInt(hdpkgsno.value);
                var fActWeight = parseFloat(hdwt.value);

                iTotDkt = iTotDkt - 1;
                iTotPkgs = iTotPkgs - iPkgs;
                fTotWeight = fTotWeight - fWeight;
                iTotActPkgs = iTotActPkgs - iActPkgs;
                fTotActWeight = fTotActWeight - fActWeight;

                txttotaldockets.value = roundNumber(iTotDkt, 0);
                txttotalpackages.value = roundNumber(iTotPkgs, 0);
                txttotalweight.value = roundNumber(fTotWeight, 2)
                hidtotaldockets.value = roundNumber(iTotDkt, 0);
                hidtotalpackages.value = roundNumber(iTotPkgs, 0);
                hidtotalweight.value = roundNumber(fTotWeight, 2);

                hidTotActWt.value = roundNumber(fTotActWeight, 2);
                hidTotActPkg.value = roundNumber(iTotActPkgs, 0);
                lblTotActWt.innerText = roundNumber(fTotActWeight, 2);
                lblTotActPkg.innerText = roundNumber(iTotActPkgs, 0);

                CalculateWeightAdj();
            }
        }

        function getDate(strDate) // dd/MM/yyyy
        {
            var dt = strDate;
            //alert(dt)
            var dt_dd = dt.substring(0, 2)
            var dt_mm = dt.substring(3, 5)
            var dt_yy = dt.substring(6, 10)

            return new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
        }

        function SelectAll(CheckBoxControl) {
            if (CheckBoxControl.checked == true) {
                var i;
                for (i = 0; i < document.forms[0].elements.length; i++) {
                    if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('dgDockets') > -1)) {
                        document.forms[0].elements[i].checked = true;
                    }
                }
            }
            else {
                var i;
                for (i = 0; i < document.forms[0].elements.length; i++) {
                    if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('dgDockets') > -1)) {
                        document.forms[0].elements[i].checked = false;
                    }
                }
            }
            calculateTotWeight();
        }

        function CHK_WT(arwt) {
            var ctrlID = arwt.getAttribute('ID');

            var chgwt = document.getElementById(ctrlID.replace("txtWt", "hdwt"));
            var chgpkg = document.getElementById(ctrlID.replace("txtWt", "hdpkgsno"));
            var Arrpkg = document.getElementById(ctrlID.replace("txtWt", "txtPkgs"));

            if (parseFloat(chgwt.value) <= parseFloat(arwt.value)) {
                alert("Weight Should Be  Less Than " + chgwt.value)
                //arwt.value=chgwt.value;
                arwt.value = Math.round((parseFloat(chgwt.value) * parseInt(Arrpkg.value)) / parseInt(chgpkg.value));
                //arwt.value = Math.round((parseFloat(chgwt.value) / parseInt(chgpkg.value)) * parseInt(Arrpkg.value));
                arwt.focus();
                return false;
            }
            calculateTotWeight();
            return true;
        }

        function ENABLED_WT(chkpkg) {
            //alert(chkpkg.value)
            var ctrlID = chkpkg.getAttribute('ID');
            var ret = true;
            var chgpkg = document.getElementById(ctrlID.replace("txtPkgs", "hdpkgsno"));
            var hgwt = document.getElementById(ctrlID.replace("txtPkgs", "hdwt"));
            var arwt = document.getElementById(ctrlID.replace("txtPkgs", "txtWt"));

            if (parseInt(chkpkg.value) > 0) {
                if (parseInt(chgpkg.value) < parseInt(chkpkg.value)) {
                    alert("Arrived Pkgsno Should Be  Less Than " + chgpkg.value)
                    arwt.disabled = true;
                    chkpkg.value = chgpkg.value;
                    chkpkg.focus();
                    ret = false;
                }
                else {
                    arwt.value = Math.round((parseFloat(chkpkg.value) * parseInt(hgwt.value)) / parseInt(chgpkg.value));
                    arwt.disabled = false;
                }

                if (parseInt(chgpkg.value) == parseInt(chkpkg.value)) {
                    arwt.value = hgwt.value;
                    arwt.disabled = true;
                }
            }
            else {
                alert("Arrived Pkgsno Should Be Greter Than 0")
                arwt.disabled = true;

                chkpkg.value = chgpkg.value;
                chkpkg.focus();
                ret = false;
            }
            calculateTotWeight();
            return ret;
        }

        function calculateTotWeight() {

            var txttotaldockets = document.getElementById("<%=txttotaldockets.ClientID %>");
            var txttotalpackages = document.getElementById("<%=txttotalpackages.ClientID %>");
            var txttotalweight = document.getElementById("<%=txttotalweight.ClientID %>");
            var hidtotaldockets = document.getElementById("<%=hidtotaldockets.ClientID %>");
            var hidtotalpackages = document.getElementById("<%=hidtotalpackages.ClientID %>");
            var hidtotalweight = document.getElementById("<%=hidtotalweight.ClientID %>");
            var hidTotActWt = document.getElementById("<%=hidTotActWt.ClientID %>");
            var hidTotActPkg = document.getElementById("<%=hidTotActPkg.ClientID %>");
            var lblTotActWt = document.getElementById("<%=lblTotActWt.ClientID %>");
            var lblTotActPkg = document.getElementById("<%=lblTotActPkg.ClientID %>");

            var GVD = document.getElementById("<%=dgDockets.ClientID %>");
            var GVM = document.getElementById("<%=gvmfdetails.ClientID %>");
            var GVD_frmname = "<%=dgDockets.ClientID %>" + "_";
            var GVM_frmname = "<%=gvmfdetails.ClientID %>" + "_";

            var rno = parseInt(GVD.rows.length) + 1;
            var rno2 = parseInt(GVM.rows.length) + 1;
            var pref = "";
            var pref2 = "";

            var totDkt = 0;
            var totPkgs = 0;
            var totWT = 0.00;

            var totActPkgs = 0;
            var totActWT = 0.00;

            for (var ij = 2; ij < rno2; ij++) {
                if (ij < 10)
                    pref2 = GVM_frmname + "ctl0" + ij + "_";
                else
                    pref2 = GVM_frmname + "ctl" + ij + "_";

                var chk = document.getElementById(pref2 + "chkDocket");
                var hidPkgsLoad = document.getElementById(pref2 + "hidPkgsLoad");
                var hidWeightLoad = document.getElementById(pref2 + "hidWeightLoad");
                var hidPkgs = document.getElementById(pref2 + "hidPkgs");
                var hidWeight = document.getElementById(pref2 + "hidWeight");

                if (chk.checked == false) {
                    totWT = totWT + parseFloat(hidWeightLoad.value);
                    totPkgs = totPkgs + parseInt(hidPkgsLoad.value);

                    totActWT = totActWT + parseFloat(hidWeight.value);
                    totActPkgs = totActPkgs + parseInt(hidPkgs.value);

                    totDkt = totDkt + 1;
                }
            }

            for (var ij = 2; ij < rno; ij++) {
                if (ij < 10)
                    pref = GVD_frmname + "ctl0" + ij + "_";
                else
                    pref = GVD_frmname + "ctl" + ij + "_";

                var chk = document.getElementById(pref + "chkDocket");
                var txtWt = document.getElementById(pref + "txtWt");
                var txtPkgs = document.getElementById(pref + "txtPkgs");
                var chgpkg = document.getElementById(pref + "hdpkgsno");
                var hgwt = document.getElementById(pref + "hdwt");

                if (chk.checked == true) {
                    totWT = totWT + parseFloat(txtWt.value);
                    totPkgs = totPkgs + parseInt(txtPkgs.value);

                    totActWT = totActWT + parseFloat(hgwt.value);
                    totActPkgs = totActPkgs + parseInt(chgpkg.value);

                    totDkt = totDkt + 1;
                }
            }

            txttotaldockets.value = roundNumber(totDkt, 0);
            txttotalpackages.value = roundNumber(totPkgs, 0);
            txttotalweight.value = roundNumber(totWT, 2)
            hidtotaldockets.value = roundNumber(totDkt, 0);
            hidtotalpackages.value = roundNumber(totPkgs, 0);
            hidtotalweight.value = roundNumber(totWT, 2)

            hidTotActWt.value = roundNumber(totActWT, 2);
            hidTotActPkg.value = roundNumber(totActPkgs, 0);
            lblTotActWt.innerText = roundNumber(totActWT, 2);
            lblTotActPkg.innerText = roundNumber(totActPkgs, 0);
            CalculateWeightAdj();
        }

        function CalculateWeightAdj() {
            var hidtotalweight = document.getElementById("<%=hidtotalweight.ClientID %>");
            var lblTOTWT = document.getElementById("<%=lblTOTWT.ClientID %>");
            var DDLWTADJ = document.getElementById("<%=DDLWTADJ.ClientID %>");
            var txtWtAdj = document.getElementById("<%=txtWtAdj.ClientID %>");
            var lblTotAdjAmt = document.getElementById("<%=lblTotAdjAmt.ClientID %>");

            lblTOTWT.innerText = roundNumber(hidtotalweight.value, 2);
            if (txtWtAdj.value == "")
                txtWtAdj.value = "0";
            
            var totWT = parseFloat(hidtotalweight.value);
            var totWTADJ = 0.00;
            
            if (DDLWTADJ.value == "+") {
                totWTADJ = totWT + parseInt(txtWtAdj.value)
            }
            else if (DDLWTADJ.value == "-") {
                totWTADJ = totWT - parseInt(txtWtAdj.value)
            }
            lblTOTWT.innerText = roundNumber(totWT,2);
            lblTotAdjAmt.innerText = roundNumber(totWTADJ, 2);
        }
        
    </script>
    <div class="blackfnt">
         <uc1:ProgressBar ID="ProgressBar1" runat="server" />
        <table border="0" width="800" cellpadding="3" cellspacing="1" class="boxbg">
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <b>MF Summary</b>                   
                </td>
            </tr>
            <tr class="bgwhite">
                <td align="left" width="20%">
                    MF No:
                </td>
                <td align="left" width="30%">
                    <asp:label id="lblmfno" runat="server"></asp:label>
                </td>
                <td align="left" width="20%">
                    MF Date:
                </td>
                <td align="left" width="30%">
                    <asp:label id="lblmfdate" runat="server"></asp:label>
                    <asp:hiddenfield id="hidmfdate" runat="server" />
                </td>
            </tr>
            <tr class="bgwhite">
                <td align="left" width="20%">
                    Next Stop:
                </td>
                <td align="left" width="30%">
                    <asp:label id="lblnextstop" runat="server"></asp:label>
                </td>
                <td align="left" width="20%">
                    Total
                    <%=SessionUtilities.DocketCalledAs %>:
                </td>
                <td align="left" width="30%">
                    <asp:textbox id="txttotaldockets" readonly="true" runat="server" style="text-align: right;
                        width: 80px;">
                    </asp:textbox>
                    <asp:hiddenfield id="hidtotaldockets" runat="server" />
                </td>
            </tr>
            <tr class="bgwhite">
                <td align="left" width="20%">
                    Total Weight:
                </td>
                <td align="left" width="30%">
                    <asp:textbox id="txttotalweight" readonly="true" runat="server" style="text-align: right;
                        width: 100px;">
                    </asp:textbox>/
                    <asp:label id="lblTotActWt" runat="server" cssclass="bluefnt"></asp:label>
                    <asp:hiddenfield id="hidtotalweight" runat="server" />
                    <asp:hiddenfield id="hidTotActWt" runat="server" />
                </td>
                <td align="left" width="20%">
                    Total Packages:
                </td>
                <td align="left" width="30%">
                    <asp:textbox id="txttotalpackages" readonly="true" runat="server" style="text-align: right;
                        width: 80px;">
                    </asp:textbox>
                    /
                    <asp:label id="lblTotActPkg" runat="server" cssclass="bluefnt"></asp:label>
                    <asp:hiddenfield id="hidtotalpackages" runat="server" />
                    <asp:hiddenfield id="hidTotActPkg" runat="server" />
                </td>
            </tr>
        </table>
        <br />
        <table border="0" cellpadding="0" cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey" height="25px">
                <td align="center" valign="middle">
                    <b>MF Details</b>
                </td>
            </tr>
            <tr class="bgwhite">
                <td>
                    <asp:gridview id="gvmfdetails" allowpaging="false" headerstyle-horizontalalign="Center"
                        rowstyle-horizontalalign="Center" runat="server" autogeneratecolumns="false"
                        cellpadding="3" headerstyle-cssclass="bgbluegrey" headerstyle-wrap="false" rowstyle-wrap="false"
                        width="800">
                        <columns>
                            <asp:TemplateField HeaderText="Sr No">
                                <ItemTemplate>
                                    <asp:Label ID="lblSrNo" runat="server" Text="<%# Container.DataItemIndex+1 %>"></asp:Label>
                                    <asp:HiddenField ID="hidLSNo" runat="server" Value='<%#Eval("LS")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Docket">
                                <%--<HeaderTemplate>
                                    <asp:Label ID="lblDKT_H" runat="server" Text='<%=SessionUtility.DocketCalledAs %> No'></asp:Label>
                                </HeaderTemplate>--%>
                                <ItemTemplate>
                                    <asp:Label ID="lbldockno" runat="server" Text='<%#Eval("DOCKET")%>'></asp:Label>
                                    <asp:HiddenField ID="hidDockNo" runat="server" Value='<%#Eval("DOCKNO")%>' />
                                    <asp:HiddenField ID="hidDockSF" runat="server" Value='<%#Eval("DOCKSF")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="DocketSF">
                                <HeaderTemplate>
                                    <asp:Label ID="lblDKTSF_H" runat="server" Text='<%=SessionUtility.DocketCalledAs %> SF'></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lbldock" runat="server" Text='<%#Eval("DOCKSF")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Origin">
                                <ItemTemplate>
                                    <asp:Label ID="lblorgncd" runat="server" Text='<%#Eval("ORGNCD")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Destination">
                                <ItemTemplate>
                                    <asp:Label ID="lbldestcd" runat="server" Text='<%#Eval("DESTCD")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="From">
                                <ItemTemplate>
                                    <asp:Label ID="lblfrom" runat="server" Text='<%#Eval("FROM_LOC")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="To">
                                <ItemTemplate>
                                    <asp:Label ID="lblto" runat="server" Text='<%#Eval("TO_LOC")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Pkgs[L/B]">
                                <ItemTemplate>
                                    <asp:Label ID="lblPkgsLoad" runat="server" Text='<%#Eval("LOADPKGSNO")%>'></asp:Label>
                                    <font class="blackfnt">/</font>
                                    <asp:Label ID="lblPkgs" runat="server" Text='<%#Eval("PKGSNO")%>'></asp:Label>
                                    <asp:HiddenField ID="hidPkgs" runat="server" Value='<%#Eval("PKGSNO")%>' />
                                    <asp:HiddenField ID="hidPkgsLoad" runat="server" Value='<%#Eval("LOADPKGSNO")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Weight[L/B]">
                                <ItemTemplate>
                                    <asp:Label ID="lblWeightLoad" runat="server" Text='<%#Eval("LOADACTUWT")%>'></asp:Label>
                                    <font class="blackfnt">/</font>
                                    <asp:Label ID="lblWeight" runat="server" Text='<%#Eval("ACTUWT")%>'></asp:Label>
                                    <asp:HiddenField ID="hidWeight" runat="server" Value='<%#Eval("ACTUWT")%>' />
                                    <asp:HiddenField ID="hidWeightLoad" runat="server" Value='<%#Eval("LOADACTUWT")%>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mark Deleted">
                                <ItemTemplate>
                                    <asp:CheckBox runat="server" ID="chkDocket" EnableViewState="true" Text="" onclick="changeMFDetails(this)" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </columns>
                    </asp:gridview>
                </td>
            </tr>
            <tr class="bgwhite">
                <td>
                    <br />
                   <asp:UpdatePanel ID="upMFAdd" runat="server">
                        <ContentTemplate>
                            <table align="center">
                                <tr bgcolor="white">
                                    <td align="left">
                                        <font class="blackfnt">
                                            <%=SessionUtilities.DocketCalledAs%>
                                            Number(s): </font>
                                    </td>
                                    <td>
                                        <asp:textbox id="txtDockNos" runat="server" width="200">
                                        </asp:textbox>
                                        <asp:button id="btnAddDkt" runat="server" text="Add" onclick="btnAddDkt_Click" />
                                        &nbsp; <font class="bluefnt">[<i> Enter coma(,) saperated if multiple </i>]</font>
                                    </td>
                                </tr>
                            </table>
                            <asp:gridview id="dgDockets" runat="server" cellspacing="1" cellpadding="3" headerstyle-cssclass="dgHeaderStyle"
                                allowsorting="false" autogeneratecolumns="false" cssclass="dgRowStyle" emptydatatext="No Records Found..."
                                width="100%" datakeynames="DOCKNO,DOCKSF,PackagesLB,WeightLB">
                                <columns>        
                                    <asp:TemplateField>
                                        <HeaderTemplate>
                                            <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)">
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkDocket" EnableViewState="true" Text="" Onclick="Javascript:return onDktCheck(this);" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="<%=SessionUtilities.DocketCalledAs%> #" ItemStyle-HorizontalAlign="left"
                                        ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lnk1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketNo")%>'
                                                CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Bkg. Date" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lnk4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketDate")%>'
                                                CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Trans. Mode" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lnkTransMode" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TransMode")%>'
                                                CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Bkg. Loc." ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lnk3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "OrgCode")%>'
                                                CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Dely. Loc." ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lnk" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ReDestCode")%>'
                                                CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="City From-To" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lnkFromTo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "FromTo")%>'
                                                CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Comm. Dely Date" ItemStyle-HorizontalAlign="left"
                                        ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:Label ID="lnk7" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Commited_DelyDate")%>'
                                                CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Pkgs.[L/B]" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdpkgsno" Value='<%#DataBinder.Eval(Container.DataItem, "PackagesLB").ToString().Trim()%>'
                                                runat="server" />
                                            <asp:TextBox runat="server" Enabled="False" OnChange="Javascript:return ENABLED_WT(this);"
                                                ID="txtPkgs" Width="30" EnableViewState="true" Text='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>' />
                                            <asp:Label ID="lnk8" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>'
                                                CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Wt.[L/B]" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                                        <ItemTemplate>
                                            <asp:HiddenField ID="hdwt" Value='<%#DataBinder.Eval(Container.DataItem, "WeightLB").ToString().Trim()%>'
                                                runat="server" />
                                            <asp:TextBox runat="server" OnChange="Javascript:return CHK_WT(this);" Enabled="False"
                                                ID="txtWt" Width="30" EnableViewState="true" Text='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>' />
                                            <asp:Label ID="lnk9" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>'
                                                CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </columns>
                            </asp:gridview>
                       </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr class="blackfnt">
                    <td id="wtsdj" runat="server" bgcolor="white" align="right">
                       Weight Adjustment:&nbsp;
                       <asp:Label ID="lblTOTWT" runat="server" Font-Bold="true" Text="0"></asp:Label>
                        <asp:DropDownList ID="DDLWTADJ" CssClass="blackfnt" runat="server" onchange="CalculateWeightAdj();">
                            <asp:ListItem Text="+" Value="+"></asp:ListItem>
                            <asp:ListItem Text="-" Value="-"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtWtAdj" Style="text-align: right;" runat="server"
                            CssClass="input" Width="60" Text="0" MaxLength="10" onkeypress="validInt(event);" onchange="CalculateWeightAdj();">
                        </asp:TextBox>
                        <b>&nbsp;=&nbsp;</b>
                        <asp:Label ID="lblTotAdjAmt" runat="server" Font-Bold="true" Text="0"></asp:Label>
                    </td>
                </tr>
            <tr class="bgbluegrey" height="25px">
                <td align="center" valign="middle">
                    <asp:button id="btnSubmit" runat="server" text="Update" borderstyle="Groove" onclick="btnSubmit_Click"
                        width="85" />
                </td>
            </tr>
        </table>
        <asp:label id="lblError" runat="server" forecolor="Red"></asp:label>
    </div>
    <script type="text/javascript">
        CalculateWeightAdj();
    </script>
</asp:content>
