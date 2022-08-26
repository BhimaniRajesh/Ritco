<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="MFCreateMain_FromLS.aspx.cs" Inherits="GUI_Operations_LS_ver2_MFCreateMain_FromLS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>
    <script type="text/javascript">
        String.prototype.trim = function() { return this.replace(/^\s+|\s+$/g, ""); };

        function SelectAll(CheckBoxControl) {
            if (CheckBoxControl.checked == true) {
                var i;
                for (i = 0; i < document.forms[0].elements.length; i++) {
                    if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('dgLS') > -1)) {
                        document.forms[0].elements[i].checked = true;
                    }
                }
            }
            else {
                var i;
                for (i = 0; i < document.forms[0].elements.length; i++) {
                    if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('dgLS') > -1)) {
                        document.forms[0].elements[i].checked = false;
                    }
                }
            }
            calculateTotWeight();
            return true;
        }

        function EnableOnCheck(chk) {
            var ctrlID = chk.getAttribute('id'); //chkDocket
            var txtPkgs = document.getElementById(ctrlID.replace('chkDocket', 'txtPkgs'));
            var txtWt = document.getElementById(ctrlID.replace('chkDocket', 'txtWt'));

            if (chk.checked == true) {
                txtPkgs.disabled = false;                
            }
            else {
                txtPkgs.disabled = true;
                txtWt.disabled = true;
            }
            calculateTotWeight();
            return true;
        }

        function onPkgsChange(pkgs) {
            var ctrlID = pkgs.getAttribute('id'); //txtPkgs
            var txtWt = document.getElementById(ctrlID.replace('txtPkgs', 'txtWt'));
            var hidBookPkgs = document.getElementById(ctrlID.replace('txtPkgs', 'hidBookPkgs'));
            var hidBookWt = document.getElementById(ctrlID.replace('txtPkgs', 'hidBookWt'));

            if (pkgs.value == "")
                pkgs.value = 0;
            var actPkg = parseInt(pkgs.value);
            var bWt = parseInt(hidBookWt.value);
            var bPkg = parseInt(hidBookPkgs.value);
            var actWt = 0;
            
            if (actPkg <= 0) {
                alert("Packages should be grater than 0");
                pkgs.value = bPkg;
                txtWt.value = bWt;
                pkgs.focus();
                return false;
            }
           
            if(actPkg > bPkg)
            {
                alert("Packages can not be grater than "+bPkg);
                pkgs.value = bPkg;
                txtWt.value = bWt;
                pkgs.focus();
                return false;
            }
            
            if (actPkg > 0) {
                actWt = Math.round((actPkg * bWt) / bPkg);
                txtWt.disabled = false;
                txtWt.value = actWt;
            }
            if (actWt == bWt) {
                txtWt.disabled = true;
            }
            calculateTotWeight();
            return true;
        }
        
        
        function onWeightChange(txtWt)
        {
            var ctrlID = txtWt.getAttribute('id'); //txtWt
            var hidBookWt = document.getElementById(ctrlID.replace('txtWt', 'hidBookWt'));
            var hidBookPkgs = document.getElementById(ctrlID.replace('txtWt', 'hidBookPkgs'));
            var txtPkgs = document.getElementById(ctrlID.replace('txtWt', 'txtPkgs'));            
            
            if (txtWt.value == "")
                txtWt.value = 0;

            var bWt = parseInt(hidBookWt.value);
            var actWt = parseInt(txtWt.value);
            var actPkg = parseInt(txtPkgs.value);
            var bPkg = parseInt(hidBookPkgs.value);

            if (actWt <= 0) {
                alert("Weight should not be grater than 0");
                actWt = Math.round((actPkg * bWt) / bPkg);
                txtWt.value = actWt;
                txtWt.focus();
                return false;
            }
            if (actWt > bWt) {
                alert("Weight can not be grater than " + bWt);
                actWt = Math.round((actPkg * bWt) / bPkg);
                txtWt.value = actWt;
                txtWt.focus();
                return false;
            }
            calculateTotWeight();
            return true;
        }

        function calculateTotWeight() {
            var GV_frmname = "ctl00_MyCPH1_dgLS_";
            var GV = document.getElementById("ctl00_MyCPH1_dgLS");
            var lblTOTWT = document.getElementById("ctl00_MyCPH1_lblTOTWT");
            var HIDTOTWT = document.getElementById("ctl00_MyCPH1_HIDTOTWT");
            var DDLWTADJ = document.getElementById("ctl00_MyCPH1_DDLWTADJ");
            var txtWtAdj = document.getElementById("ctl00_MyCPH1_txtWtAdj");
            var lblTotAdjAmt = document.getElementById("ctl00_MyCPH1_lblTotAdjAmt");
            var DDLWTADJ = document.getElementById("ctl00_MyCPH1_DDLWTADJ");
            if (txtWtAdj.value == "")
                txtWtAdj.value = "0";
            var rno = parseInt(GV.rows.length) + 1;
            var pref = "";
            var chkcount = 0;
            var totWT = 0.00;
            var totWTADJ = 0.00;
            for (var ij = 2; ij < rno; ij++) {
                if (ij < 10)
                    pref = GV_frmname + "ctl0" + ij + "_";
                else
                    pref = GV_frmname + "ctl" + ij + "_";

                var chk = document.getElementById(pref + "chkDocket");
                var txtWt = document.getElementById(pref + "txtWt");

                if (chk.checked == true)
                    totWT = totWT + parseFloat(txtWt.value);
            }
            if (DDLWTADJ.value == "+") {
                totWTADJ = totWT + parseInt(txtWtAdj.value)
            }
            else if (DDLWTADJ.value == "-") {
                totWTADJ = totWT - parseInt(txtWtAdj.value)
            }
            lblTOTWT.innerText = totWT;
            HIDTOTWT.value = totWT;
            lblTotAdjAmt.innerText = totWTADJ;
        }

        function CHKREC() {
            var GV_frmname = "ctl00_MyCPH1_dgLS_";
            var GV = document.getElementById("ctl00_MyCPH1_dgLS");
            var rno = parseInt(GV.rows.length) + 1;
            var pref = "";
            var chkcount = 0;
            for (var ij = 2; ij < rno; ij++) {
                if (ij < 10)
                    pref = GV_frmname + "ctl0" + ij + "_";
                else
                    pref = GV_frmname + "ctl" + ij + "_";

                var chk = document.getElementById(pref + "chkDocket");

                if (chk.checked == true) {
                    chkcount++;
                    var txtPkgs = document.getElementById(pref + "txtPkgs");
                    var txtWt = document.getElementById(pref + "txtWt");
                    if (txtPkgs.value.trim() == "" || parseInt(txtPkgs.value.trim()) <= 0) {
                        alert("Package should be grater than 0");
                        txtPkgs.focus();
                        return false;
                    }
                    if (txtWt.value.trim() == "" || parseInt(txtWt.value.trim()) <= 0) {
                        alert("Weight should be grater than 0");
                        txtPkgs.focus();
                        return false;
                    }                    
                }
            }
            if (chkcount == 0) {
                alert("No Row Selected...");
                return false;
            }
            document.getElementById("ctl00_MyCPH1_btnPrepareManifest").style.display = "none";
            return true;
        }
    </script>

    <table cellspacing="1" style="width: 700px">
        <tr style="background-color: white">
            <td align="left" width="75%">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Update <%=strDocumentLS%>  & Prepare Manifest  </asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
            <td align="left">
                <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                    <ProgressTemplate>
                        <div id="progressArea">
                            <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                            <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>
        </tr>
    </table>
    <table cellpadding="3" cellspacing="1" border="0" id="tblNoDocketsSelected" runat="server"
        width="900px" visible="false">
        <tr bgcolor="white">
            <td align="left">
                <font class="redfnt"><b>Alert: </b>No
                    <%=strDocumentDKT%>s Were Selected</font>
            </td>
        </tr>
    </table>
    <table cellpadding="3" cellspacing="1" border="0" id="iblError" runat="server" width="900px"
        visible="false">
        <tr bgcolor="white">
            <td align="left">
                <font class="redfnt"><b>Alert: </b>
                    <asp:Label ID="lblerr" runat="server" CssClass="redfnt"></asp:Label></font>
            </td>
        </tr>
    </table>
    <table cellpadding="3" cellspacing="1" border="0" id="Table2" runat="server" width="900px">
        <tr bgcolor="white">
            <td align="left">
                <font class="bluefnt"><b>
                    <%=strDocumentLS%>
                    No.: - </b>
                    <asp:Label ID="lblllsno" Font-Bold="true" Font-Underline="true" runat="server" CssClass="bluefnt"></asp:Label></font>
            </td>
        </tr>
    </table>
    <table border="0" cellspacing="1" cellpadding="3" width="900px" id="Table1" runat="server"
        visible="true">
        <tr>
            <td align="left">
                <asp:GridView ID="dgLS" runat="server" CellSpacing="1" CellPadding="3" HeaderStyle-CssClass="dgHeaderStyle"
                    AllowSorting="true" AutoGenerateColumns="false" OnRowDataBound="dgLS_RowDataBound"
                    CssClass="dgRowStyle" EmptyDataText="No Records Found..." Width="100%" DataKeyNames="DOCKNO,DOCKSF,PackagesLB,WeightLB">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)">
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chkDocket" EnableViewState="true" Text="" onclick="EnableOnCheck(this)" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                            <HeaderTemplate>
                                <asp:Label CssClass="blackfnt" Text="LS No." Font-Bold="true" ID="lblColname" runat="server"> </asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lnk1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DocketNo")%>'
                                    CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
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
                                    CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
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
                        <%--                                <asp:TemplateField  HeaderText="Arrv. Date" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk6" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ArrivalDate")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>
--%>
                        <asp:TemplateField HeaderText="Comm. Dely Date" ItemStyle-HorizontalAlign="left"
                            ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lnk7" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Commited_DelyDate")%>'
                                    CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pkgs.[L/B]" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="txtPkgs" Width="30" Enabled="false" onkeypress="validInt(event)"
                                             EnableViewState="true" onchange="onPkgsChange(this);" Text='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>' />
                                <%--<asp:RequiredFieldValidator ValidationGroup="grpResult" ID="RFVtxtPkgs" runat="server"
                                    ErrorMessage="*" ControlToValidate="txtPkgs" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ValidationGroup="grpResult" ID="REVtxtPkgs" runat="server"
                                    ControlToValidate="txtPkgs" ValidationExpression="^\d+$" ErrorMessage="!" ToolTip="Invalid Value"
                                    SetFocusOnError="true"></asp:RegularExpressionValidator>
                                <asp:CompareValidator ValidationGroup="grpResult" runat="server" ValueToCompare='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>'
                                    ID="CVtxtPkgs" ControlToValidate="txtPkgs" Operator="LessThanEqual" Type="Integer"
                                    ErrorMessage="#" ToolTip="Loaded Pkgs. cannot be greater than Booked" SetFocusOnError="true"></asp:CompareValidator>
                                <asp:RangeValidator ValidationGroup="grpResult" runat="server" MinimumValue="1" Type="Integer"
                                    MaximumValue="999999999" ID="RVtxtPkgs" ControlToValidate="txtPkgs" ErrorMessage="~"
                                    ToolTip="Cannot be less than 1"></asp:RangeValidator>--%>
                                <font class="blackfnt">/</font>
                                <asp:Label ID="lnk8" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>'
                                    CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                <asp:HiddenField ID="hidBookPkgs" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "PackagesLB")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Wt.[L/B]" ItemStyle-HorizontalAlign="left" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:TextBox runat="server" ID="txtWt" Width="30" Enabled="false"  onkeypress="validInt(event)"
                                             EnableViewState="true" onchange="onWeightChange(this)" Text='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>' />
                                <%--<asp:RequiredFieldValidator ValidationGroup="grpResult" ID="RFVtxtWt" runat="server"
                                    ErrorMessage="*" ControlToValidate="txtWt" SetFocusOnError="true"></asp:RequiredFieldValidator>                                
                                <asp:RegularExpressionValidator ValidationGroup="grpResult" ID="REVtxtWt" runat="server"
                                    ControlToValidate="txtWt" ValidationExpression="^\d+$" ErrorMessage="!" ToolTip="Invalid Value"
                                    SetFocusOnError="true"></asp:RegularExpressionValidator>
                                <asp:CompareValidator ValidationGroup="grpResult" runat="server" ValueToCompare='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>'
                                    ID="CVtxtWt" ControlToValidate="txtWt" ToolTip="Loaded Wt. cannot be greater than Booked"
                                    Operator="LessThanEqual" Type="Double" ErrorMessage="#" SetFocusOnError="true"></asp:CompareValidator>--%>
                                <font class="blackfnt">/</font>
                                <asp:Label ID="lnk9" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>'
                                    CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>" />
                                <asp:HiddenField ID="hidBookWt" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "WeightLB")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr class="blackfnt">
            <td id="wtsdj" runat="server" bgcolor="white" align="right">
                Weight Adjustment:&nbsp;
                <asp:Label ID="lblTOTWT" runat="server" Font-Bold="true" Text="0"></asp:Label>
                <asp:HiddenField runat="server" ID="HIDTOTWT" Value="0" />
                <asp:DropDownList ID="DDLWTADJ" CssClass="blackfnt" runat="server" onchange="calculateTotWeight();">
                    <asp:ListItem Text="+" Value="+"></asp:ListItem>
                    <asp:ListItem Text="-" Value="-"></asp:ListItem>
                </asp:DropDownList>
                <asp:TextBox ID="txtWtAdj" Style="text-align: right;" runat="server" CssClass="input"
                    Width="60" Text="0" MaxLength="10" onkeypress="validInt(event);" onchange="calculateTotWeight();">
                </asp:TextBox>
                <b>&nbsp;=&nbsp;</b>
                <asp:Label ID="lblTotAdjAmt" runat="server" Font-Bold="true" Text="0"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <table border="0" cellspacing="1" cellpadding="3" width="100%" runat="server" id="tblSubmitBtn">
                    <tr class="bgbluegrey">
                        <td align="Center" style="height:25px;">
                            <asp:Button ValidationGroup="grpResult" ID="btnPrepareManifest" runat="server" Text="Prepare <%=strDocumentMF%> >>"
                                OnClick="PrepareManifest" OnClientClick="Javascript:return CHKREC()" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
