<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="StandardExpense_FixedRoute.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_New_TripSheet_Validation_StandardExpense_FixedRoute" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upDCRReDeAllot" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <script language="javascript" type="text/javascript" src="../../Fleet/Webadmin/FuelRateMaster/VendorPayment.js"></script>
            <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
            <script language="javascript" type="text/javascript" src="../../../../admin/FuelSlipMaster/FuelSlipMaster_JS.js"></script>

            <script type="text/javascript">
                function CheckEmpty() {
                    var EntryDate = document.getElementById("ctl00_MyCPH1_txtEntryDate").value;

                    if (EntryDate == "") {
                        alert("Please enter entry date");
                        document.getElementById("ctl00_MyCPH1_txtEntryDate").focus();
                        return false;
                    }

                    if (document.getElementById('ctl00_MyCPH1_ddVendorName').value == 0 || document.getElementById('ctl00_MyCPH1_ddVendorName').value == "") {
                        alert("Please select vendor name");
                        document.getElementById('ctl00_MyCPH1_ddVendorName').focus();
                        return false;
                    }

                }
            </script>

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
            </script>

            <%--VALIDATION: DATA NOT FROM MASTERS--%>
            <script type="text/javascript">
                function Location_Blur(Obj, Mode) {
                    if (Obj.value == "") {
                        return false;
                    }
                    var Search_Char = "~"
                    if (Obj.value.indexOf(Search_Char) == -1) {
                        alert("Invalid " + Mode + " Name ~ Code Format");
                        Obj.focus();
                        return false
                    }
                }

                function City_Blur(Obj, Mode) {
                    if (Obj.value == "") {
                        return false;
                    }
                    var Search_Char = ":"
                    if (Obj.value.indexOf(Search_Char) == -1) {
                        alert("Invalid " + Mode + " Name : Code Format");
                        Obj.focus();
                        return false
                    }
                }
            </script>

            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDCRCriteria" runat="server">
                <tr class="bgbluegrey">
                    <td colspan="10" style="text-align: left" align="center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Standard Expense For Fixed Route"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left" width="20%">
                        <asp:Label class="blackfnt" Width="70px" runat="server">Route No.</asp:Label>
                    </td>
                    <td align="left">
                        <font class="blackfnt">System Generated</font>
                    </td>
                    <td align="left" id="tdCityName">
                        <asp:Label class="blackfnt" Width="70px" runat="server">City Name:</asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType1" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType1">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType2" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType2">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>

                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType3" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType3">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType4" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType4">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType5" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType5">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>

                    <td width="20%">
                        <asp:Label Width="70px" class="blackfnt" runat="server">Route Name</asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCityTrim" BorderStyle="Groove" CssClass="input" runat="server" Width="300px"></asp:TextBox>
                    </td>
                </tr>
                <%-- <tr bgcolor="white">
                    <td align="right" colspan="10">
                        <asp:Button ID="btnSubmit" ValidationGroup="grpQuery" runat="server" Text="Submit" />
                    </td>
                </tr>--%>
            </table>
            <br />
            <table border="0" cellspacing="1" cellpadding="3" width="900px">
                <tr>
                    <td align="center">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
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

            <table align="left" cellspacing="1" runat="server" style="width: 100%" border="0">
                <tr style="background-color: white" id="trDataGrid">
                    <td align="left" colspan="2">
                        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                            <ContentTemplate>
                                <table align="left" id="tblGrid" runat="server" cellspacing="1" cellpadding="2" class="boxbg">

                                    <tr style="background-color: white" align="left">
                                        <td align="left" width="20%">
                                            <font class="blackfnt">Enter no. of rows </font>&nbsp;&nbsp;
                                        </td>
                                        <td align="left" >
                                            <asp:TextBox ID="txtRow" runat="server" MaxLength="3" Width="30"
                                                onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                BorderStyle="Groove" Text="1" AutoPostBack="true"></asp:TextBox>

                                            <asp:RegularExpressionValidator ID="RegtxtRow" runat="server"
                                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <%--LABEL START--%>
                                        <td>
                                            <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                <ContentTemplate>
                                                    <table align="left" id="Table1" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label2" Height="22px" Text="Sr. No" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label3" Height="22px" runat="server" Text="Nature of Expense"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label42" Text="1" Height="22px" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label43" runat="server" Height="22px" Text="Toll"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="lblSerials" Height="22px" Text="2" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label1" Height="22px" runat="server" Text="Border"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label9" Height="22px" Text="3" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label10" Height="22px" runat="server" Text="Check Post"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label11" Height="22px" Text="4" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label12" Height="22px" runat="server" Text="RTO"></asp:Label>
                                                            </td>
                                                        </tr>

                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label15" Height="22px" Text="5" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label16" Height="22px" runat="server" Text="Loading"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label17" Height="22px" Text="6" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label18" Height="22px" runat="server" Text="Unloading"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label19" Height="22px" Text="7" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label20" Height="22px" runat="server" Text="Incentive"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label21" Height="22px" Text="8" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label22" Height="22px" runat="server" Text="Driver D.A."></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label13" Height="22px" Text="9" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label14" Height="22px" runat="server" Text="Telephone"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label23" Text="10" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label24" Height="22px" runat="server" Text="Enroute Repair"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label25" Height="22px" Text="11" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label26" Height="22px" runat="server" Text="Penalty"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label27" Height="22px" Text="12" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label28" Height="22px" runat="server" Text="Height"></asp:Label>
                                                            </td>
                                                        </tr>

                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label29" Height="22px" Text="13" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label30" Height="22px" runat="server" Text="Brokarage"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label31" Height="22px" Text="14" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label32" runat="server" Text="Guide"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label33" Height="22px" Text="15" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label34" Height="22px" runat="server" Text="Behti Exp."></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label35" Height="22px" Text="16" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label36" Height="22px" runat="server" Text="Green Tax"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label37" Height="22px" Text="17" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label38" Height="22px" runat="server" Text="P. Exp."></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label39" Text="18" Height="22px" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label40" runat="server" Height="22px" Text="Misl. Expense"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label41" Text="19" Height="22px" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label44" runat="server" Height="22px" Text="Other Expense"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label45" Text="20" Height="22px" runat="server"></asp:Label>
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:Label ID="Label46" runat="server" Text="M. Expenses"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>

                                        </td>
                                        <%--LABEL END--%>

                                        <%--OPTION 1 START--%>
                                        <td id="TdOption1" runat="server">
                                            <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                <ContentTemplate>
                                                    <table align="left" id="Table2" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label4" Text="Option 1" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1Toll" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1Border" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1CheckPost" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1RTO" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1Loading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1UnLoading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1Incentive" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1DriverDA" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1Telephone" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1EnrouteRepair" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1Penalty" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1Height" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1Brokarage" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1Guide" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1BehtiExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1GreenTax" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1PExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1MislExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1OtherExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op1MExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <%--OPTION 1 END--%>

                                        <%--OPTION 2 START--%>
                                        <td id="TdOption2" runat="server">
                                            <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                <ContentTemplate>
                                                    <table align="left" id="Table3" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label5" Text="Option 2" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2Toll" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2Border" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2CheckPost" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2RTO" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2Loading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2UnLoading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2Incentive" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2DriverDA" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2Telephone" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2EnrouteRepair" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2Penalty" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2Height" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2Brokarage" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2Guide" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2BehtiExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2GreenTax" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2PExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2MislExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2OtherExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op2MExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <%--OPTION 2 END--%>

                                        <%--OPTION 3 START--%>
                                        <td id="TdOption3" runat="server">
                                            <asp:UpdatePanel ID="UpdatePanel5" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                <ContentTemplate>
                                                    <table align="left" id="Table4" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label6" Text="Option 3" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3Toll" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3Border" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3CheckPost" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3RTO" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3Loading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3UnLoading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3Incentive" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3DriverDA" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3Telephone" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3EnrouteRepair" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3Penalty" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3Height" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3Brokarage" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3Guide" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3BehtiExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3GreenTax" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3PExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3MislExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3OtherExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op3MExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <%--OPTION 3 END--%>

                                        <%--OPTION 4 START--%>
                                        <td id="TdOption4" runat="server">
                                            <asp:UpdatePanel ID="UpdatePanel6" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                <ContentTemplate>
                                                    <table align="left" id="Table5" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label7" Text="Option 4" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4Toll" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4Border" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4CheckPost" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4RTO" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4Loading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4UnLoading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4Incentive" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4DriverDA" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4Telephone" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4EnrouteRepair" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4Penalty" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4Height" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4Brokarage" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4Guide" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4BehtiExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4GreenTax" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4PExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4MislExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4OtherExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op4MExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <%--OPTION 4 END--%>

                                        <%--OPTION 5 START--%>
                                        <td id="TdOption5" runat="server">
                                            <asp:UpdatePanel ID="UpdatePanel7" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                <ContentTemplate>
                                                    <table align="left" id="Table6" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label8" Text="Option 5" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5Toll" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5Border" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5CheckPost" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5RTO" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5Loading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5UnLoading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5Incentive" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5DriverDA" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5Telephone" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5EnrouteRepair" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5Penalty" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5Height" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5Brokarage" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5Guide" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5BehtiExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5GreenTax" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5PExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5MislExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5OtherExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op5MExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <%--OPTION 5 END--%>

                                        <%--OPTION 6 START--%>
                                        <td id="TdOption6" runat="server">
                                            <asp:UpdatePanel ID="UpdatePanel10" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                <ContentTemplate>
                                                    <table align="left" id="Table20" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label51" Text="Option 6" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6Toll" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6Border" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6CheckPost" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6RTO" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6Loading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6UnLoading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6Incentive" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6DriverDA" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6Telephone" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6EnrouteRepair" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6Penalty" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6Height" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6Brokarage" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6Guide" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6BehtiExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6GreenTax" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6PExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6MislExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6OtherExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op6MExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <%--OPTION 6 END--%>

                                        <%--OPTION 7 START--%>
                                        <td id="TdOption7" runat="server">
                                            <asp:UpdatePanel ID="UpdatePanel11" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                <ContentTemplate>
                                                    <table align="left" id="Table21" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label52" Text="Option 7" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7Toll" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7Border" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7CheckPost" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7RTO" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7Loading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7UnLoading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7Incentive" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7DriverDA" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7Telephone" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7EnrouteRepair" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7Penalty" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7Height" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7Brokarage" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7Guide" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7BehtiExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7GreenTax" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7PExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7MislExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7OtherExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op7MExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <%--OPTION 7 END--%>

                                        <%--OPTION 8 START--%>
                                        <td id="TdOption8" runat="server">
                                            <asp:UpdatePanel ID="UpdatePanel12" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                <ContentTemplate>
                                                    <table align="left" id="Table22" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:Label ID="Label53" Text="Option 8" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8Toll" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8Border" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8CheckPost" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8RTO" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8Loading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8UnLoading" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8Incentive" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8DriverDA" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8Telephone" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8EnrouteRepair" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8Penalty" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8Height" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8Brokarage" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8Guide" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8BehtiExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8GreenTax" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8PExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8MislExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8OtherExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr style="background-color: white">
                                                            <td colspan="2">
                                                                <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" ID="Op8MExp" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <%--OPTION 8 END--%>
                                    </tr>

                                    <%--TOTAL--%>
                                    <tr style="background-color: white">
                                        <td colspan="9">
                                            <asp:Label runat="server" Text="Total (Rate/Ltrs)" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td>
                                            <table align="left" id="Table12" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td colspan="2">
                                                        <asp:Label ID="Label47" Width="30px" Height="22px" Text="21" runat="server"></asp:Label>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:Label ID="Label48" Height="22px" Width="110px" runat="server" Text="Cash Fuel"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption1Total" runat="server">
                                            <table align="left" id="Table7" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="Op1Rate" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox1" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox2" Width="40px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption2Total" runat="server">
                                            <table align="left" id="Table8" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox3" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox4" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox5" Width="40px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption3Total" runat="server">
                                            <table align="left" id="Table9" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox6" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox7" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox8" Width="40px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption4Total" runat="server">
                                            <table align="left" id="Table10" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox9" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox10" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox11" Width="40px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption5Total" runat="server">
                                            <table align="left" id="Table11" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox12" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox13" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox14" Width="40px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption6Total" runat="server">
                                            <table align="left" id="Table26" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox31" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox32" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox33" Width="40px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption7Total" runat="server">
                                            <table align="left" id="Table27" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox34" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox35" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox36" Width="40px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption8Total" runat="server">
                                            <table align="left" id="Table28" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox37" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox38" Width="30px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox39" Width="40px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                    <%--GRAND TOTAL--%>
                                    <tr style="background-color: white">
                                        <td colspan="9">
                                            <asp:Label runat="server" Text="Grand Total" Font-Bold="true"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td>
                                            <table align="left" id="Table13" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td colspan="2">
                                                        <asp:Label ID="Label49" Width="30px" Height="22px" Text="22" runat="server"></asp:Label>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:Label ID="Label50" Height="22px" Width="110px" runat="server" Text="Credit Fuel"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>



                                        <td id="TdOption1GTotal" runat="server">
                                            <table align="left" id="Table14" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox16" Width="40px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox17" Width="70px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption2GTotal" runat="server">
                                            <table align="left" id="Table15" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox15" Width="40px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox18" Width="70px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption3GTotal" runat="server">
                                            <table align="left" id="Table16" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox19" Width="40px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox20" Width="70px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption4GTotal" runat="server">
                                            <table align="left" id="Table17" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox21" Width="40px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox22" Width="70px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption5GTotal" runat="server">
                                            <table align="left" id="Table18" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox23" Width="40px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox24" Width="70px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption6GTotal" runat="server">
                                            <table align="left" id="Table23" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox25" Width="40px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox26" Width="70px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption7GTotal" runat="server">
                                            <table align="left" id="Table24" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox27" Width="40px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox28" Width="70px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td id="TdOption8GTotal" runat="server">
                                            <table align="left" id="Table25" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox29" Width="40px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox BorderStyle="Groove" CssClass="input" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" runat="server" ID="TextBox30" Width="70px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>


                                    <%--ADD Vehicle--%>
                                    <tr style="background-color: white">
                                        <td>
                                            <asp:Label runat="server" Text="Vehicle" Font-Bold="true"></asp:Label>
                                        </td>
                                        <td id="TdOption1AddVehicle" >Add Vehicle
                                            <asp:LinkButton ID="AddRow" runat="server" ToolTip="Add This Row" Text="+" CssClass="blackfnt" Font-Bold="true"
                                                CausesValidation="false" OnClick="AddNewRow"></asp:LinkButton>
                                        </td>
                                        <td id="TdOption2AddVehicle" >Add Vehicle
                                            <asp:LinkButton ID="AddRow2" runat="server" ToolTip="Add This Row" Text="+" CssClass="blackfnt" Font-Bold="true"
                                                CausesValidation="false" OnClick="AddNewRow"></asp:LinkButton>
                                        </td>
                                        <td id="TdOption3AddVehicle" >Add Vehicle
                                            <asp:LinkButton ID="LinkButton2" runat="server" ToolTip="Add This Row" Text="+" CssClass="blackfnt" Font-Bold="true"
                                                CausesValidation="false" OnClick="AddNewRow"></asp:LinkButton>
                                        </td>
                                        <td id="TdOption4AddVehicle" >Add Vehicle
                                            <asp:LinkButton ID="LinkButton3" runat="server" ToolTip="Add This Row" Text="+" CssClass="blackfnt" Font-Bold="true"
                                                CausesValidation="false" OnClick="AddNewRow"></asp:LinkButton>
                                        </td>
                                        <td id="TdOption5AddVehicle" >Add Vehicle
                                            <asp:LinkButton ID="LinkButton4" runat="server" ToolTip="Add This Row" Text="+" CssClass="blackfnt" Font-Bold="true"
                                                CausesValidation="false" OnClick="AddNewRow"></asp:LinkButton>
                                        </td>
                                        <td id="TdOption6AddVehicle" >Add Vehicle
                                            <asp:LinkButton ID="LinkButton5" runat="server" ToolTip="Add This Row" Text="+" CssClass="blackfnt" Font-Bold="true"
                                                CausesValidation="false" OnClick="AddNewRow"></asp:LinkButton>
                                        </td>
                                        <td id="TdOption7AddVehicle" >Add Vehicle
                                            <asp:LinkButton ID="LinkButton6" runat="server" ToolTip="Add This Row" Text="+" CssClass="blackfnt" Font-Bold="true"
                                                CausesValidation="false" OnClick="AddNewRow"></asp:LinkButton>
                                        </td>
                                        <td id="TdOption8AddVehicle" >Add Vehicle
                                            <asp:LinkButton ID="LinkButton7" runat="server" ToolTip="Add This Row" Text="+" CssClass="blackfnt" Font-Bold="true"
                                                CausesValidation="false" OnClick="AddNewRow"></asp:LinkButton>
                                        </td>
                                    </tr>

                                    <tr style="background-color: white">
                                        <td>
                                            <table align="left" id="Table29" runat="server" cellspacing="1" cellpadding="2" class="boxbg">
                                                <tr style="background-color: white">
                                                    <td colspan="2">
                                                        <asp:Label ID="Label54" Width="30px" Height="22px" Text="23" runat="server"></asp:Label>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:Label ID="Label55" Height="22px" Width="110px" runat="server" Text="Add Vehicle"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <%--Add Vehicle Grid--%>
                                        <td id="TdOption1VGrid" runat="server">
                                            <table cellspacing="1" style="width: 100%">
                                                <tr style="background-color: white">
                                                    <td align="left">
                                                        <asp:UpdatePanel ID="UpdatePanel13" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                            <ContentTemplate>
                                                                <asp:GridView EnableViewState="true" ID="dgGeneral" runat="server" BorderWidth="1"
                                                                    HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                                                                    CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2"
                                                                    OnRowDataBound="dg_RowDataBound" OnRowCommand="dg_RowCommand" OnRowCreated="dg_RowCreated">
                                                                    <Columns>
                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="DeleteRow" ToolTip="Delete This Row" runat="server" CausesValidation="false"
                                                                                    Text="X"></asp:LinkButton>
                                                                                <asp:DropDownList ID="cboDocType" Width="110px" runat="server" Visible="true" DataTextField="CodeDesc" DataValueField="CodeID" AutoPostBack="true"/>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                    </Columns>
                                                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                                                    <HeaderStyle CssClass="dgHeaderStyle" />
                                                                </asp:GridView>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="AddRow" EventName="Click" />--%>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="btnSaveSeries" EventName="Click" />--%>
                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption2Grid" runat="server">
                                            <table cellspacing="1" style="width: 100%">
                                                <tr style="background-color: white">
                                                    <td align="left">
                                                        <asp:UpdatePanel ID="UpdatePanel9" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                            <ContentTemplate>
                                                                <asp:GridView EnableViewState="true" ID="dgGeneral2" runat="server" BorderWidth="1"
                                                                    HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                                                                    CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2"
                                                                    OnRowDataBound="dg_RowDataBound" OnRowCommand="dg_RowCommand" OnRowCreated="dg_RowCreated">
                                                                    <Columns>
                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="DeleteRow" ToolTip="Delete This Row" runat="server" CausesValidation="false"
                                                                                    Text="X"></asp:LinkButton>
                                                                                <asp:DropDownList ID="cboDocType" Width="110px" runat="server" Visible="true" DataTextField="CodeDesc" DataValueField="CodeID" AutoPostBack="true" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                    </Columns>
                                                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                                                    <HeaderStyle CssClass="dgHeaderStyle" />
                                                                </asp:GridView>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="AddRow" EventName="Click" />--%>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="btnSaveSeries" EventName="Click" />--%>
                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption3Grid" runat="server">
                                            <table cellspacing="1" style="width: 100%">
                                                <tr style="background-color: white">
                                                    <td align="left">
                                                        <asp:UpdatePanel ID="UpdatePanel14" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                            <ContentTemplate>
                                                                <asp:GridView EnableViewState="true" ID="dgGeneral3" runat="server" BorderWidth="1"
                                                                    HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                                                                    CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2"
                                                                    OnRowDataBound="dg_RowDataBound" OnRowCommand="dg_RowCommand" OnRowCreated="dg_RowCreated">
                                                                    <Columns>
                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="DeleteRow" ToolTip="Delete This Row" runat="server" CausesValidation="false"
                                                                                    Text="X"></asp:LinkButton>
                                                                                <asp:DropDownList ID="cboDocType" Width="110px" runat="server" Visible="true" DataTextField="CodeDesc" DataValueField="CodeID" AutoPostBack="true" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                    </Columns>
                                                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                                                    <HeaderStyle CssClass="dgHeaderStyle" />
                                                                </asp:GridView>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="AddRow" EventName="Click" />--%>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="btnSaveSeries" EventName="Click" />--%>
                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption4Grid" runat="server">
                                            <table cellspacing="1" style="width: 100%">
                                                <tr style="background-color: white">
                                                    <td align="left">
                                                        <asp:UpdatePanel ID="UpdatePanel15" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                            <ContentTemplate>
                                                                <asp:GridView EnableViewState="true" ID="dgGeneral4" runat="server" BorderWidth="1"
                                                                    HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                                                                    CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2"
                                                                    OnRowDataBound="dg_RowDataBound" OnRowCommand="dg_RowCommand" OnRowCreated="dg_RowCreated">
                                                                    <Columns>
                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="DeleteRow" ToolTip="Delete This Row" runat="server" CausesValidation="false"
                                                                                    Text="X"></asp:LinkButton>
                                                                                <asp:DropDownList ID="cboDocType" Width="110px" runat="server" Visible="true" DataTextField="CodeDesc" DataValueField="CodeID" AutoPostBack="true" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                    </Columns>
                                                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                                                    <HeaderStyle CssClass="dgHeaderStyle" />
                                                                </asp:GridView>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="AddRow" EventName="Click" />--%>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="btnSaveSeries" EventName="Click" />--%>
                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption5Grid" runat="server">
                                            <table cellspacing="1" style="width: 100%">
                                                <tr style="background-color: white">
                                                    <td align="left">
                                                        <asp:UpdatePanel ID="UpdatePanel16" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                            <ContentTemplate>
                                                                <asp:GridView EnableViewState="true" ID="dgGeneral5" runat="server" BorderWidth="1"
                                                                    HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                                                                    CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2"
                                                                    OnRowDataBound="dg_RowDataBound" OnRowCommand="dg_RowCommand" OnRowCreated="dg_RowCreated">
                                                                    <Columns>
                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="DeleteRow" ToolTip="Delete This Row" runat="server" CausesValidation="false"
                                                                                    Text="X"></asp:LinkButton>
                                                                                <asp:DropDownList ID="cboDocType" Width="110px" runat="server" Visible="true" DataTextField="CodeDesc" DataValueField="CodeID" AutoPostBack="true" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                    </Columns>
                                                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                                                    <HeaderStyle CssClass="dgHeaderStyle" />
                                                                </asp:GridView>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="AddRow" EventName="Click" />--%>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="btnSaveSeries" EventName="Click" />--%>
                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption6Grid" runat="server">
                                            <table cellspacing="1" style="width: 100%">
                                                <tr style="background-color: white">
                                                    <td align="left">
                                                        <asp:UpdatePanel ID="UpdatePanel17" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                            <ContentTemplate>
                                                                <asp:GridView EnableViewState="true" ID="dgGeneral6" runat="server" BorderWidth="1"
                                                                    HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                                                                    CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2"
                                                                    OnRowDataBound="dg_RowDataBound" OnRowCommand="dg_RowCommand" OnRowCreated="dg_RowCreated">
                                                                    <Columns>
                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="DeleteRow" ToolTip="Delete This Row" runat="server" CausesValidation="false"
                                                                                    Text="X"></asp:LinkButton>
                                                                                <asp:DropDownList ID="cboDocType" Width="110px" runat="server" Visible="true" DataTextField="CodeDesc" DataValueField="CodeID" AutoPostBack="true" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                    </Columns>
                                                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                                                    <HeaderStyle CssClass="dgHeaderStyle" />
                                                                </asp:GridView>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="AddRow" EventName="Click" />--%>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="btnSaveSeries" EventName="Click" />--%>
                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption7Grid" runat="server">
                                            <table cellspacing="1" style="width: 100%">
                                                <tr style="background-color: white">
                                                    <td align="left">
                                                        <asp:UpdatePanel ID="UpdatePanel18" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                            <ContentTemplate>
                                                                <asp:GridView EnableViewState="true" ID="dgGeneral7" runat="server" BorderWidth="1"
                                                                    HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                                                                    CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2"
                                                                    OnRowDataBound="dg_RowDataBound" OnRowCommand="dg_RowCommand" OnRowCreated="dg_RowCreated">
                                                                    <Columns>
                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="DeleteRow" ToolTip="Delete This Row" runat="server" CausesValidation="false"
                                                                                    Text="X"></asp:LinkButton>
                                                                                <asp:DropDownList ID="cboDocType" Width="110px" runat="server" Visible="true" DataTextField="CodeDesc" DataValueField="CodeID" AutoPostBack="true" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                    </Columns>
                                                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                                                    <HeaderStyle CssClass="dgHeaderStyle" />
                                                                </asp:GridView>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="AddRow" EventName="Click" />--%>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="btnSaveSeries" EventName="Click" />--%>
                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>

                                        <td id="TdOption8Grid" runat="server">
                                            <table cellspacing="1" style="width: 100%">
                                                <tr style="background-color: white">
                                                    <td align="left">
                                                        <asp:UpdatePanel ID="UpdatePanel19" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                            <ContentTemplate>
                                                                <asp:GridView EnableViewState="true" ID="dgGeneral8" runat="server" BorderWidth="1"
                                                                    HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                                                                    CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5" CellSpacing="2" CellPadding="2"
                                                                    OnRowDataBound="dg_RowDataBound" OnRowCommand="dg_RowCommand" OnRowCreated="dg_RowCreated">
                                                                    <Columns>
                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="DeleteRow" ToolTip="Delete This Row" runat="server" CausesValidation="false"
                                                                                    Text="X"></asp:LinkButton>
                                                                                <asp:DropDownList ID="cboDocType" Width="110px" runat="server" Visible="true" DataTextField="CodeDesc" DataValueField="CodeID" AutoPostBack="true" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                    </Columns>
                                                                    <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                                                    <HeaderStyle CssClass="dgHeaderStyle" />
                                                                </asp:GridView>
                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="AddRow" EventName="Click" />--%>
                                                                <%--<asp:AsyncPostBackTrigger ControlID="btnSaveSeries" EventName="Click" />--%>
                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <%--Add Vehicle Grid--%>

                                    </tr>
                                    <tr style="background-color: white">
                                        <td colspan="9" align="center">
                                            <asp:Button Text="Submit" ID="btnFinalSubmit" OnClick="btnFinalSubmit_Click" runat="server" />
                                        </td>
                                    </tr>

                                </table>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="txtRow" EventName="TextChanged" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>

            <%--*************************************************** END ***************************************************************--%>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>



