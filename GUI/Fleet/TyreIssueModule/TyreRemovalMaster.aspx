<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="TyreRemovalMaster.aspx.cs" Inherits="GUI_Fleet_TyreIssueModule_TyreRemovalMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript">


        function validFloat(event, txtid) {
            var tb = document.getElementById(txtid);
            var txt = tb.value;
            if (event.keyCode == 13)
                return true;
            if (event.keyCode == 46)
                if (txt.indexOf('.') != -1)
                    event.keyCode = 0;

        if ((event.keyCode < 46 || event.keyCode > 57) || event.keyCode == 47)
        { event.keyCode = 0; return false; }
    }

    //validation for Removal KM

    function CheckKM() {
        // debugger

        var GV_TyreDetails = document.getElementById("ctl00_MyCPH1_GV_TyreDetails");
        var cnt = 0;

        if (GV_TyreDetails != null) {
            if (GV_TyreDetails.rows.length != 0) {
                for (i = 0; i <= GV_TyreDetails.rows.length - 2; i++) {
                    j = i + 2;
                    var pref = "";
                    if (j < 10) {
                        pref = "ctl00$MyCPH1$GV_TyreDetails$ctl0" + j + "$";
                    }
                    else {
                        pref = "ctl00$MyCPH1$GV_TyreDetails$ctl" + j + "$";
                    }

                    var txtRemovalKM = document.getElementById(pref + "txtRemovalKM");
                    var hdfFitmentKM = document.getElementById(pref + "hdfFitmentKM");

                    if (txtRemovalKM.value < hdfFitmentKM.value) {
                        alert("Removal KM should be greater than " + hdfFitmentKM.value);
                    }
                }
            }
        }
    }

    //Validation to calculate Distance & Cost per KM
    function CalculateDistance(txtRemovalKM, txtDistanceCovered, txtPerKMCost, hdfFitmentKM, hdfGRNAmount) {
        //debugger;
        // alert("hii");

        //alert(txtRemovalKM.value + "  " + txtDistanceCovered.value + "  " + txtPerKMCost.value + "  " + hdfFitmentKM.value + "  " + hdfGRNAmount.value);
        var DistanceCovered = 0.00, GRNAmount = 0.00, PerKMCost = 0.00;

        if (txtRemovalKM.value == "") {
            txtRemovalKM.focus();
            return true;

        }
        if (parseFloat(txtRemovalKM.value) > parseFloat(hdfFitmentKM.value)) {
            txtDistanceCovered.value = parseFloat(txtRemovalKM.value) - parseFloat(hdfFitmentKM.value);
            DistanceCovered = txtDistanceCovered.value;
            GRNAmount = hdfGRNAmount.value;

            PerKMCost = parseFloat(parseFloat(GRNAmount) / parseFloat(DistanceCovered));
            //txtPerKMCost.value = PerKMCost;
            txtPerKMCost.value = PerKMCost.toFixed(4);
            //alert(hdfGRNAmount.value + " " + DistanceCovered + PerKMCost);
        }
        else {
            alert("Removal KM should be greater than " + hdfFitmentKM.value);
            txtRemovalKM.value = "";
            txtPerKMCost.value = "0.00";
            txtDistanceCovered.value = "0.00";
            txtRemovalKM.focus();
            return false;
        }
    }

    /// Validation for blank data

    function CheckOnSubmit() {
        // debugger;
        var GV_TyreDetails = document.getElementById("ctl00_MyCPH1_GV_TyreDetails");
        var Count = 0;

        var txtDate = document.getElementById("ctl00_MyCPH1_txtDate");

        if (txtDate.value == "") {
            alert("Please select Removal Date");
            txtDate.focus();
            return false;
        }

        for (i = 2; i <= GV_TyreDetails.rows.length; i++) {
            pref = "ctl00$MyCPH1$GV_TyreDetails$ctl0" + i + "$";
            var chkSelected = document.getElementById(pref + "chkSelected");
            var txtRemovalKM = document.getElementById(pref + "txtRemovalKM");

            //                if (chkSelected.checked == true) {


            //                }

            //if (Count >= 1) {
            if (chkSelected.checked == true) {
                Count = Count + 1;
                if (txtRemovalKM.value == "") {
                    alert("Please Enter Removal KM.");
                    txtRemovalKM.focus();
                    return false;
                }

            }
            // }
        }
        if (Count == 0) {
            alert("Select At least One Tyre ID.");
            return false;
        }
    }

    //--------------------------------------- For Select All Checkbox

    function SelectAll(CheckBoxControl) {
        if (CheckBoxControl.checked == true) {
            var i;
            for (i = 0; i < document.forms[0].elements.length; i++) {
                if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('GV_TyreDetails') > -1)) {
                    //if(document.forms[0].elements[i].enabled){
                    //alert(document.forms[0].elements[i].name);
                    document.forms[0].elements[i].checked = true;
                    //}
                }
            }
        }
        else {
            var i;
            for (i = 0; i < document.forms[0].elements.length; i++) {
                if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('GV_TyreDetails') > -1)) {
                    document.forms[0].elements[i].checked = false;
                }
            }
        }
    }
    </script>
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                <tr>
                    <td align="right">
                        <img src="../../../images/loading.gif" alt="" />
                    </td>
                    <td>
                        <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                    </td>
                </tr>
            </table>
            <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
                background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
                opacity: .50; -moz-opacity: .50;" runat="server">
                <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                    left: 50%;" ID="Panel2" runat="server">
                </asp:Panel>
            </asp:Panel>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Removal Master</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <table width="1000px" border="1" class="boxbg" cellspacing="0" cellpadding="0">
        <tr class="bgwhite">
            <td>
                <asp:Label ID="lblError" CssClass="redfnt" Font-Bold="true" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td colspan="9" align="center">
                <asp:Label ID="Label7" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Removal Master</asp:Label>
            </td>
        </tr>
        <tr style="background-color: white">
            <td>
                <table cellspacing="1" cellpadding="3" style="width: 100%" class="boxbg" border="0">
                    <tr style="background-color: white">
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Enter Truck No. " Font-Bold="true"></asp:Label>
                            <asp:Label ID="Label6" runat="server" Text="  *" Font-Bold="true" ForeColor="Red"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtVehNo" runat="server" OnTextChanged="BindGrid" AutoPostBack="true"></asp:TextBox>
                            <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                                ServiceMethod="AutoVhNo" ServicePath="../AtlasAutoComplete.asmx" TargetControlID="txtVehNo">
                            </ajaxToolkit:AutoCompleteExtender>
                        </td>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Tyre Removal Date" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDate" runat="server"></asp:TextBox>
                            <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtDate"
                                runat="server" />
                        </td>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Tyre As per Axle" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <%--<asp:Label ID="lblAxle" runat="server" Text=""></asp:Label>--%>
                            <asp:TextBox ID="txtAxel" runat="server" Text="" ReadOnly="true" BorderStyle="Groove"
                                Width="50px" CssClass="rtxt"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text="Actual Tyre" Font-Bold="true"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtActualTyre" runat="server" ReadOnly="true" CssClass="rtxt"
                                Text="0"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="Pending Tyre" Font-Bold="true"></asp:Label>
                            <asp:HiddenField ID="hdfPendingTyre" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtPendingTyre" runat="server" CssClass="rtxt" ReadOnly="true"></asp:TextBox>
                        </td>
                    </tr>
                    <%--<tr style="background-color: white">
                                <td colspan="10">
                                <br />                               
                                </td>
                            </tr>--%>
                </table>
            </td>
        </tr>
    </table>
    <%--    <tr id="trTyreDtls" runat="server">
        <td>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table id="tblGrid" cellspacing="0" cellpadding="0" width="1000px" class="boxbg" border="1"
                runat="server">
                <tr class="bgbluegrey">
                    <td align="center">
                        <asp:Label ID="Label8" runat="server" Text="Removal Tyre" Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: white">
                    <td>
                        <asp:GridView ID="GV_TyreDetails" runat="server" align="left" BorderWidth="0" CellSpacing="1" EmptyDataText="No record found"
                            OnRowDataBound="GV_TyreDetails_RowDataBound" CellPadding="0" HeaderStyle-CssClass="bgbluegrey"
                            PagerStyle-HorizontalAlign="left" CssClass="boxbg" FooterStyle-CssClass="bgbluegrey"
                            AllowPaging="False" PageSize="1" Width="100%" AllowSorting="False" AutoGenerateColumns="false"
                            ShowFooter="false" PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]">
                            <PagerStyle VerticalAlign="Bottom" />
                            <Columns>
                                <asp:TemplateField ItemStyle-BackColor="white">
                                    <HeaderTemplate>
                                        <%--<asp:CheckBox ID="ChkSelectAll" AutoPostBack="true" runat="server" />--%>
                                        <input type="CheckBox" name="ChkSelectAll" onclick="SelectAll(this)" />
                                        <%--onselect="SelectAllCheckBox_onchange(this)">--%>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <asp:CheckBox ID="chkSelected" runat="server" />
                                                <%--AutoPostBack="true" OnCheckedChanged="CalculatePendingTyre" --%>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SR.</BR>NO." ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                        </asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--                                <asp:TemplateField HeaderText="Tyre NO" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblTyreNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_ID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Manual Tyre NO" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblManualTyreNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_NO") %>'></asp:Label>
                                        <asp:HiddenField ID="hdfManualTyreNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TYRE_NO") %>' />
                                        <asp:HiddenField ID="hdfTyreNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TYREID_N") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%-- <asp:TemplateField HeaderText="Make" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMake" runat="server" Text="NA"></asp:Label>
                                                    <asp:HiddenField ID="hdfMake" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                <asp:TemplateField HeaderText="Model" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblModel" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MODEL") %>'></asp:Label>
                                        <asp:HiddenField ID="hdfModel" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"MODEL") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Size" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblSize" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"SIZE") %>'></asp:Label>
                                        <asp:HiddenField ID="hdfSize" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"SIZE") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Pattern" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblPattern" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"PATTERN") %>'></asp:Label>
                                        <asp:HiddenField ID="hdfPattern" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"PATTERN") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tyre Type" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblTyreType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_TYPE") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tyre MFG" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblTyreMFG" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MFG") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="GRN Amount" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblGRNAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_COST") %>'></asp:Label>
                                        <asp:HiddenField ID="hdfGRNAmount" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TYRE_COST") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fitment Date" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblFitmentDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MOUNT_DT") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fitment KM" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblFitmentKM" runat="server" Style="text-align: right" Text='<%# DataBinder.Eval(Container.DataItem,"MANUAL_MOUNT_KM_RUN") %>'></asp:Label>
                                        <asp:HiddenField ID="hdfFitmentKM" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"MANUAL_MOUNT_KM_RUN") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Removal KM" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtRemovalKM" runat="server" Style="text-align: right" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox><%--OnTextChanged="CalculateDistance" AutoPostBack="true"--%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Distance Covered" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDistanceCovered" runat="server" Enabled="false" Style="text-align: right"
                                            Text="0.00"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Per KM Cost" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtPerKMCost" runat="server" Enabled="false" Style="text-align: right"
                                            Text="0.00"></asp:TextBox>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr id="trSubmit" class="bgbluegrey">
                    <td align="center">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                            OnClientClick="javascript:return CheckOnSubmit()" />
                        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
            <%--        </td>
    </tr>--%>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
