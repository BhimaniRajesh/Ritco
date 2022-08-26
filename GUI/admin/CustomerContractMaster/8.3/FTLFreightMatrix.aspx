<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="FTLFreightMatrix.aspx.cs" Inherits="GUI_Admin_CustomerContractMaster_FTLFreightMatrix"
    Title="Untitled Page" %>

<%@ Register Src="~/GUI/Common_UserControls/ProgressBar.ascx" TagPrefix="pgr" TagName="ProgressBar" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/CustContractInfo.ascx" TagName="CustInfo"
    TagPrefix="cust" %>
<%@ Register Src="~/GUI/Common_UserControls/ContractComplete/CAC.ascx" TagName="ContractComplete"
    TagPrefix="CAC" %>
<%@ Register Src="~/GUI/admin/CustomerContractMaster/StepNavigation.ascx" TagName="StepNavigation"
    TagPrefix="nvp" %>
<%@ Register Src="~/GUI/Common_UserControls/UserMessage.ascx" TagName="UserMessage"
    TagPrefix="ums" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript">




        function windowPopUp(mode, ctlid, tbl) {
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            var url = "";
            url = "DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=4row";
            confirmWin = window.open(url, "", winOpts);
            return false;
        }


        function windowHeadPopUp(mode, ctlid, tbl, head) {
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            var url = "";
            url = "DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl + "&tp=" + head;
            confirmWin = window.open(url, "", winOpts);
            return false;
        }

        function locTest(txtid, testtype) {
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
            hdnajaxstate.value = "1";
            debugger;
            var hdnclient = document.getElementById("ctl00_MyCPH1_hdnclient");
            var txt = document.getElementById(txtid);
            if (txt.value == "") {
                hdnajaxstate.value = "0";
                return false;
            }

            txt.value = txt.value.toUpperCase();
            var strpg = "";
            var findobj = false;
            findobj = GetXMLHttpObject();
            if (findobj) {
                if (testtype == "citytest")
                    strpg = "AjaxResponse.aspx?mode=check&code1=citytest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
                else if (testtype == "loctest")
                    strpg = "AjaxResponse.aspx?mode=check&code1=loctest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();
                else if (testtype == "zonetest")
                    strpg = "AjaxResponse.aspx?mode=check&code1=zonetest&code2=" + txt.value + "&sid=" + Math.random() + "&sid=" + Math.random();

                findobj.open("GET", strpg);
                findobj.onreadystatechange = function() {
                    if ((findobj.readyState == 4) && (findobj.status == 200)) {
                        var res = findobj.responseText.split("|");
                        if (res[0] == "false") {
                            if (testtype == "citytest")
                                alert("City doesn't Exists...");
                            else if (testtype == "loctest")
                                alert("Location doesn't Exists...");
                            else if (testtype == "zonetest")
                                alert("Zone doesn't Exists...");
                            txt.value = "";
                            txt.focus();
                            hdnajaxstate.value = "0";
                            return false;
                        }
                        else if (res[0] == "true") {
                            hdnajaxstate.value = "0";
                        }
                    }
                }

                findobj.send(null);
            }

            return true;
        }

        function submitValidation() {
            var hdnajaxstate = document.getElementById("ctl00_MyCPH1_hdnajaxstate");
            var hdnBillLocRule = document.getElementById("ctl00_MyCPH1_hdnBillLocRule");
            if (hdnajaxstate.value == "1") {
                alert("Let the Internal Processes over. Please wait 5-10 seconds or LogOut.");
                return false;
            }

            var grid = document.getElementById("ctl00_MyCPH1_grvcharges");
            var len = parseInt(grid.rows.length);
            var pref = "";
            var cnt = 0;
            for (var i = 2; i <= len; i++) {
                if (i < 10)
                    pref = "ctl00_MyCPH1_grvcharges_ctl0" + i + "_";
                else
                    pref = "ctl00_MyCPH1_grvcharges_ctl" + i + "_";

                var txtfrom = document.getElementById(pref + "txtfrom");
                var txtto = document.getElementById(pref + "txtto");
                var txtBillingLoc = document.getElementById(pref + "txtBillingLoc");
                var chkyes = document.getElementById(pref + "chkyes");
                var ddlftltype = document.getElementById(pref + "ddlftltype");
                if (chkyes.checked == true) {
                    cnt++;
                    if (txtfrom.value == "") {
                        alert("Please Enter From Location");
                        txtfrom.focus();
                        return false;
                    }

                    if (txtto.value == "") {
                        alert("Please Enter To Location");
                        txtto.focus();
                        return false;
                    }
                    if (hdnBillLocRule.value == "3") {
                        if (txtBillingLoc.value == "") {
                            alert("Please Enter Billing Location");
                            txtBillingLoc.focus();
                            return false;
                        }
                    }

                    for (var j = 2; j < len; j++) {
                        var jref = "";
                        if (j < 10)
                            jref = "ctl00_MyCPH1_grvcharges_ctl0" + j + "_";
                        else
                            jref = "ctl00_MyCPH1_grvcharges_ctl" + j + "_";

                        var txtjfrom = document.getElementById(jref + "txtfrom");
                        var txtjto = document.getElementById(jref + "txtto");
                        var txtBillingLoc = document.getElementById(jref + "txtBillingLoc");

                        var ddljftltype = document.getElementById(jref + "ddlftltype");
                        var chkjyes = document.getElementById(jref + "chkyes");
                        if (i != j && chkjyes.checked) {

                            if (txtfrom.value == txtjfrom.value && txtto.value == txtjto.value && ddljftltype.value == ddlftltype.value) {
                                alert("No Two pair(FROM -TO -FTL Type) should be same.Please Enter Another Location");
                                txtto.value = "";
                                txtto.focus();
                                return false;
                            }

                            if (hdnBillLocRule.value == "3") {
                                if (txtBillingLoc.value == "") {
                                    alert("Please Enter Billing Location");
                                    txtBillingLoc.focus();
                                    return false;
                                }
                            }



                        } // i!=j

                    } //  J loop

                } // Check of YES/NO        

            } // I loop

            if (cnt == 0) {
                if (!confirm("No Record Selected. All listed data will be removed.Do you want to continue ?"))
                    return false;
            }
            return true;
        }
    </script>

    <cust:CustInfo runat="server" ID="cstheader" />
    <nvp:StepNavigation ID="nvpMain" runat="server" OnSaveContractInformation="SaveContractInformation" />
    <br />
   
    <asp:UpdatePanel ID="upone" runat="server">
        <ContentTemplate> <ums:UserMessage ID="umsg" runat="server" />
            <asp:UpdatePanel runat="server" ID="updone" RenderMode="Inline" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Table ID="Table1" runat="server">
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell ColumnSpan="2">
                            Please Note : &nbsp;<font class='redfnt'>Existing Data will be Replaced, if any</font>
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow CssClass="nrow">
                            <asp:TableCell ColumnSpan="2">
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Table ID="Table3" HorizontalAlign="Left" runat="server" CellSpacing="1" CssClass="stbl"
                                    Width="5in">
                                    <asp:TableRow CssClass="nrow">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">Matrix Type
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblmatrixtype" runat="server" CssClass="nfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="nrow">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">Trans Mode
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lbltransmode" runat="server" CssClass="nfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="trbasedon1" runat="server" CssClass="nrow">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblbasedon1" runat="server" CssClass="nfnt"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblbasecode1" runat="server" CssClass="nfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow ID="trbasedon2" runat="server" CssClass="nrow">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblbasedon2" runat="server" CssClass="nfnt"></asp:Label>
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblbasecode2" runat="server" CssClass="nfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="nrow">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">From Location Filter
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblfilterfrom" runat="server" CssClass="nfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="nrow">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">To Location Filter
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblfilterto" runat="server" CssClass="nfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="nrow">
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">FTL Type 
                                        </asp:TableCell>
                                        <asp:TableCell Width="50%" HorizontalAlign="Left">
                                            <asp:Label ID="lblftltype" runat="server" CssClass="nfnt"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                                <br />
                                <br />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow>
                            <asp:TableCell>
                                <asp:Table ID="tblmain" CellSpacing="1" CssClass="ftbl" runat="server">
                                    <asp:TableRow CssClass="hrow">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:Label ID="lblheader" CssClass="hfnt" Font-Bold="true" runat="server" Text="FTL Freight Matrix"></asp:Label>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="nrow">
                                        <asp:TableCell Width="20%">Enter No of Rows
                                        </asp:TableCell>
                                        <asp:TableCell Width="80%">
                                            <asp:TextBox ID="txtrows" Width="40px" onkeypress="javascript:return validInt(event)"
                                                BorderStyle="Groove" MaxLength="2" CssClass="rtxt" runat="server"></asp:TextBox>
                                            <asp:Button ID="btnaddrows" runat="server" OnClick="btnaddrows_Click" CssClass="nbtn"
                                                Text="Add New Rows" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="nrow">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:GridView HorizontalAlign="left" ID="grvcharges" runat="server" BorderWidth="0"
                                                CellSpacing="1" AllowSorting="true" PagerStyle-HorizontalAlign="left" CssClass="ftbl"
                                                HeaderStyle-CssClass="hrow" RowStyle-CssClass="nrow" RowStyle-HorizontalAlign="Center"
                                                HeaderStyle-HorizontalAlign="Center" FooterStyle-CssClass="frow" AutoGenerateColumns="false"
                                                HeaderStyle-Font-Bold="true" EmptyDataText="No Records Found..." Width="7in"
                                                OnRowDataBound="grvcharges_RowDataBound">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkyes" runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            From
                                                            <input type="button" id="btnfrom" runat="server" class="hbtn" value="...." />
                                                        </HeaderTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtfrom" Width="100px" Text='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>'
                                                                            CssClass="ltxtm" runat="server"></asp:TextBox><br />
                                                                        <CAC:ContractComplete ID="cactxtfrom" CodeTarget="txtfrom" MinPrefixLength="2" runat="server" />
                                                                        <asp:HiddenField ID="hdnfrom" runat="server" Value='<%# DataBinder.Eval( Container.DataItem,"from_loccode") %>' />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            To
                                                            <input type="button" id="btnto" runat="server" class="hbtn" value="...." />
                                                        </HeaderTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td align="left">
                                                                        <asp:TextBox ID="txtto" Width="100px" Text='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>'
                                                                            CssClass="ltxtm" runat="server"></asp:TextBox><br />
                                                                        <CAC:ContractComplete ID="cactxtto" CodeTarget="txtto" MinPrefixLength="2" runat="server" />
                                                                        <asp:HiddenField ID="hdnto" runat="server" Value='<%# DataBinder.Eval( Container.DataItem,"to_loccode") %>' />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            FTL Type<br />
                                                            <asp:DropDownList ID="ddlftltype" DataTextField="codedesc" DataValueField="codeid"
                                                                AutoPostBack="true" OnSelectedIndexChanged="ddlftltype_SelectedIndexChanged"
                                                                runat="server" CssClass="cmbm">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlftltype" DataTextField="codedesc" DataValueField="codeid"
                                                                runat="server" CssClass="cmbm">
                                                            </asp:DropDownList>
                                                            <asp:HiddenField ID="hdnoldftltype" Value='<%# DataBinder.Eval( Container.DataItem,"oldftltype") %>'
                                                                runat="server" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            Rate
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtrate" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"ftl1_trip_rate") %>'
                                                                onblur="javascript:return this.value=roundNumber(this.value,2)" CssClass="rtxtm"
                                                                MaxLength="8" onkeypress="javascript:return validFloat(event,this.getAttribute('id'))"
                                                                Width="80px" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            Transit Days
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txttrdays" BorderStyle="Groove" Text='<%# DataBinder.Eval( Container.DataItem,"ftl1_trdays") %>'
                                                                MaxLength="3" onkeypress="javascript:return validInt(event)" CssClass="rtxtm"
                                                                Width="50px" runat="server"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            Rate Type<br />
                                                            <asp:DropDownList ID="ddlratetype" DataTextField="codedesc" DataValueField="codeid"
                                                                AutoPostBack="true" OnSelectedIndexChanged="ddlratetype_SelectedIndexChanged"
                                                                runat="server" CssClass="cmbm">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlratetype" DataTextField="codedesc" DataValueField="codeid"
                                                                runat="server" CssClass="cmbm">
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            Transit Mode<br />
                                                            <asp:DropDownList ID="ddltransmode" DataTextField="codedesc" DataValueField="codeid"
                                                                AutoPostBack="true" OnSelectedIndexChanged="ddltransmode_SelectedIndexChanged"
                                                                runat="server" CssClass="cmbm">
                                                            </asp:DropDownList>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddltransmode" runat="server" DataTextField="codedesc" DataValueField="codeid"
                                                                CssClass="cmbm">
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <HeaderTemplate>
                                                            Billing Location
                                                            <%--<input type="button" id="btnBillLoc" runat="server" class="hbtn" value="...." />--%>
                                                        </HeaderTemplate>
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtBillingLoc" runat="server" CssClass="ltxtm" MaxLength="15" Width="100px"
                                                                Text='<%# DataBinder.Eval( Container.DataItem,"BillLoc") %>'>
                                                            </asp:TextBox><br />
                                                            <CAC:ContractComplete ID="cacBillLoc" FilterString="3456789" ContractEntity="Branch"
                                                                CodeTarget="txtBillingLoc" MinPrefixLength="2" runat="server" />
                                                            <asp:HiddenField ID="hdnBillLoc" runat="server" Value='<%# DataBinder.Eval( Container.DataItem,"BillLoc") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                            </asp:GridView>
                                        </asp:TableCell>
                                    </asp:TableRow>
                                    <asp:TableRow CssClass="hrow">
                                        <asp:TableCell ColumnSpan="2">
                                            <asp:Button ID="btnsubmit" CssClass="hbtn" Text="Save & Exit" runat="server" OnClick="btnsubmit_Click"
                                                OnClientClick="javascript:return submitValidation()" />
                                            <asp:Button ID="btnsubmitclear" CssClass="hbtn" Text="Save & Clear Data" runat="server"
                                                OnClick="btnsubmitclear_Click" OnClientClick="javascript:return submitValidation()" />
                                        </asp:TableCell>
                                    </asp:TableRow>
                                </asp:Table>
                            </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
                    <asp:HiddenField ID="hdncontractid" runat="server" />
                    <asp:HiddenField ID="hdncustcode" runat="server" />
                    <asp:HiddenField ID="hdncontracttype" runat="server" />
                    <asp:HiddenField ID="hdnmatrixtype" runat="server" />
                    <asp:HiddenField ID="hdntransmode" runat="server" />
                    <asp:HiddenField ID="hdnajaxstate" runat="server" />
                    <asp:HiddenField ID="hdnfrom" runat="server" />
                    <asp:HiddenField ID="hdnto" runat="server" />
                    <asp:HiddenField ID="hdnbasedon1" runat="server" />
                    <asp:HiddenField ID="hdnbasecode1" runat="server" />
                    <asp:HiddenField ID="hdnbasedon2" runat="server" />
                    <asp:HiddenField ID="hdnbasecode2" runat="server" />
                    <asp:HiddenField ID="hdnBillLocRule" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
            <pgr:ProgressBar ID="pgr" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
