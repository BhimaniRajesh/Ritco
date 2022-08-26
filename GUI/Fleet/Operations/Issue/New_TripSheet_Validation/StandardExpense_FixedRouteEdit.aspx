<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="StandardExpense_FixedRouteEdit.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_New_TripSheet_Validation_StandardExpense_FixedRouteEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:UpdatePanel ID="upDCRReDeAllot" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <script language="javascript" type="text/javascript" src="../../Fleet/Webadmin/FuelRateMaster/VendorPayment.js"></script>
            <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
            <script language="javascript" type="text/javascript" src="../../Fleet/Webadmin/FuelRateMaster/VendorPayment.js"></script>
            <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
            <script language="javascript" type="text/javascript" src="../../../../admin/FuelSlipMaster/FuelSlipMaster_JS.js?v001"></script>
            <script language="javascript" type="text/javascript" src="New_Tripsheet.js"></script>

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
               <script type="text/javascript">

                 function CalulateAmount() {

                     var GridView = document.getElementById("ctl00_MyCPH1_dgWorkgroup");
                     for (var i = 1; i <= GridView.all.length; i++) {
                         var j = i + 1;
                         var txtBorder = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtBorder");
                         var txtCheckPost = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtCheckPost");
                         var txtRto = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtRto");
                         var txtLoading = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtLoading");
                         var txtUnLoading = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtUnLoading");
                         var txtIncentive = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtIncentive");
                         var txtDriverDA = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtDriverDA");
                         var txtTelephone = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtTelephone");
                         var txtEnrouteRepair = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtEnrouteRepair");
                         var txtPenalty = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtPenalty");
                         var txtHeight = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtHeight");
                         var txtBrokarage = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtBrokarage");
                         var txtGuide = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtGuide");
                         var txtBehtiExp = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtBehtiExp");
                         var txtGreenTax = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtGreenTax");
                         var txtPExp = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtPExp");
                         var txtMislExp = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtMislExp");
                         var txtOtherExp = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtOtherExp");
                         var txtMExp = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtMExp");
                         var txtTyrePuncture = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtTyrePuncture");
                         var txtServicing = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtServicing");
                         var txtParking = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtParking");
                         var txtMechanical = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtMechanical");
                         var txtGreecing = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtGreecing");
                         var txtAirCheck = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtAirCheck");
                         var txtDandaTax = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtDandaTax");
                         var txtKaanta = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtKaanta");
                         var txtToll = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtToll");
                         var txtFuel = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_txtFuel");
                         var lblSubTotal = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_lblSubTotal");
                         var lblGrandTotal = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_lblGrandTotal");
                         var hdnSubTotal = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_hdnSubTotal");
                         var hdnGrandTotal = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_hdnGrandTotal");

                       //  debugger;
                         var SubTotal = 0;
                         var GrandTotal = 0;
                        // alert(txtBorder.value);
                         SubTotal = parseFloat(txtBorder.value) + parseFloat(txtCheckPost.value) + parseFloat(txtRto.value)
                                      + parseFloat(txtLoading.value) + parseFloat(txtUnLoading.value) + parseFloat(txtIncentive.value)
                                      + parseFloat(txtDriverDA.value) + parseFloat(txtTelephone.value) + parseFloat(txtEnrouteRepair.value)
                                      + parseFloat(txtPenalty.value) + parseFloat(txtHeight.value) + parseFloat(txtBrokarage.value)
                                      + parseFloat(txtGuide.value) + parseFloat(txtBehtiExp.value) + parseFloat(txtGreenTax.value)
                                      + parseFloat(txtPExp.value) + parseFloat(txtMislExp.value) + parseFloat(txtOtherExp.value)
                                      + parseFloat(txtMExp.value) + parseFloat(txtTyrePuncture.value) + parseFloat(txtServicing.value)
                                      + parseFloat(txtParking.value) + parseFloat(txtMechanical.value) + parseFloat(txtGreecing.value)
                                      + parseFloat(txtAirCheck.value) + parseFloat(txtDandaTax.value) + parseFloat(txtKaanta.value);

                         document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_lblSubTotal").innerHTML = parseFloat(SubTotal);
                         document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_hdnSubTotal").value = (parseFloat(SubTotal));

                         GrandTotal = SubTotal + parseFloat(txtToll.value);
                         document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_lblGrandTotal").innerHTML = parseFloat(GrandTotal);
                         document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl0" + j + "_hdnGrandTotal").value = (parseFloat(GrandTotal));
                         
                     }
                 }
    </script>
            <script type="text/javascript">
                function blockSpecialChar(e) {
                    var k;
                    document.all ? k = e.keyCode : k = e.which;
                    return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || (k >= 48 && k <= 57)); //AlphaNumeric with No Spaces
                }
            </script>

            <%--VALIDATION: DATA NOT FROM MASTERS--%>
            <script language="javascript" type="text/javascript">

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

                //function City_Blur(Obj, Mode) {
                //    if (Obj.value == "") {
                //        return false;
                //    }
                //    var Search_Char = ":"
                //    if (Obj.value.indexOf(Search_Char) == -1) {
                //        alert("Invalid " + Mode + " Name : Code Format");
                //        Obj.focus();
                //        return false
                //    }
                //}

                //function CheckVhNo() {
                //    var txtVehNo = document.getElementById("ctl00_MyCPH1_dgWorkgroup_ctl02_txtVehNo");
                //    var currentTime = new Date();
                //    if (txtVehNo.value == "") {
                //        return false;
                //    }
                //    createXMLHttpRequest();
                //    if (xmlHttpRequest) {
                //        xmlHttpRequest.onreadystatechange = function () {
                //            if (xmlHttpRequest.readyState == 4) {
                //                var returnValue = xmlHttpRequest.responseText.split("~");
                //                if (returnValue[0] == "N") {
                //                    alert("Please Enter valid Vehicle No. ");
                //                    txtVehNo.value = "";
                //                    txtVehNo.focus();
                //                    return false;
                //                }
                //            }
                //        }
                //        xmlHttpRequest.open("GET", "~/GUI/Fleet/TyreIssueModule/Ajax_Validation/AjaxResponse.aspx?Function=CheckVehicle&datetime=" + currentTime + "&VEH_NO=" + txtVehNo.value, false);
                //        xmlHttpRequest.send(null);
                //    }
                //}
            </script>

            <script type="text/javascript">

                function nwOpen(id) {
                    debugger
                    //window.open("popupLoc.aspx?id=",+id ,"pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70") 
                    id = id.replace("Label2", "txtCstLoc");
                    window.open("popupLocVer1.aspx?" + id, "pbr", "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70")
                }
            </script>

            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDCRCriteria" runat="server">
                <tr class="bgbluegrey">
                    <td colspan="15" style="text-align: left" align="center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Standard Expense For Fixed Route"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left" width="20%">
                        <asp:Label class="blackfnt" Width="70px" runat="server">Route No.</asp:Label>
                    </td>
                    <td align="left">
                        <%-- <font class="blackfnt">System Generated</font>--%>
                        <asp:Label runat="server" ID="txtRouteNo" Width="70px" />
                    </td>
                    <td align="left" id="tdCityName">
                        <asp:Label class="blackfnt" Width="70px" runat="server">City Name:</asp:Label>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType1" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType1">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType2" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType2">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>

                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType3" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType3">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType4" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType4">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType5" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType5">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType6" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender6" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType6">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType7" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender7" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType7">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType8" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender8" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType8">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType9" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender9" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType9">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="txtRouteType10" onblur="javascript:Location_Blur(this,'Location');" BorderStyle="Groove" CssClass="input" />
                        <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender10" runat="server" Enabled="True" MinimumPrefixLength="1"
                            ServiceMethod="GetLocationNew" CompletionListItemCssClass="autocomplete_listItem"
                            CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                            ServicePath="~/GUI/Fleet/AtlasAutoComplete.asmx" TargetControlID="txtRouteType10">
                        </ajaxToolkit:AutoCompleteExtender>
                    </td>
                    <td width="20%">
                        <asp:Label Width="70px" class="blackfnt" runat="server">Route Name</asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtCityTrim" BorderStyle="Groove" CssClass="input" runat="server" Width="300px"></asp:TextBox>
                    </td>
                </tr>
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
                                <UserControl:UserMessage runat="server" ID="umsg" />
                                <table align="left" id="tblGrid" runat="server" cellspacing="1" cellpadding="2" class="boxbg">

                                    <tr style="background-color: white">
                                        <td colspan="2">
                                            <asp:Label ID="lblError" runat="server" Visible="true" CssClass="redfnt"> 
                                            </asp:Label>
                                        </td>
                                    </tr>

                                    <tr style="background-color: white" align="left">
                                        <td align="left" width="20%">
                                            <font class="blackfnt">Enter no. of rows</font>&nbsp;&nbsp;
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtRow" Enabled="true" runat="server" MaxLength="3" Width="30"
                                                onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                BorderStyle="Groove" Text="1" AutoPostBack="true"
                                                OnTextChanged="txtRow_TextChanged"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="RegtxtRow" runat="server"
                                                ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>

                                    <tr style="background-color: white">
                                        <td colspan="2">
                                            <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                                <ContentTemplate>
                                                    <asp:GridView ID="dgWorkgroup" runat="server" PageSize="1000"
                                                        AutoGenerateColumns="False" CellPadding="2" BorderWidth="3px"
                                                        CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign="Left"
                                                        BorderColor="#006699" BorderStyle="None" CssClass="blackfnt">
                                                        <Columns>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Options">
                                                                <ItemTemplate>
                                                                    <center>
                                                                        Option <%#Container.DataItemIndex + 1%>
                                                                        <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.DataItemIndex + 1%>'></asp:Label>
                                                                        <asp:HiddenField ID="hfTaskId" runat="server" Value="" />
                                                                        <asp:HiddenField ID="hdnSrNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"SrNo") %>' />
                                                                    </center>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>

                                                           
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Border">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtBorder"   OnBlur="javascript:return CalulateAmount()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Border") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow2" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtBorder" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Check Post">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtCheckPost"  OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CheckPost") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow3" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtCheckPost" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="RTO">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtRto"  OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"RTO") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow4" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtRto" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Loading">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtLoading"  OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Loading") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow5" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtLoading" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Unloading">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtUnLoading"  OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="60px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Unloading") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow6" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtUnLoading" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Incentive">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtIncentive"  OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="60px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Incentive") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow7" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtIncentive" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Driver D.A.">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtDriverDA"  OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"DriverDA") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow8" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtDriverDA" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Telephone">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtTelephone" OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="60px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Telephone") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow9" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtTelephone" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="ENROUTE REPAIR INCENTIVE">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtEnrouteRepair" OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"EnrouteRepair") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow10" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtUnLoading" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Penalty">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtPenalty" OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Penalty") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow11" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtPenalty" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Height">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtHeight" OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Height") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow12" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtHeight" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Brokarage">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtBrokarage" OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="60px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Brokarage") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow13" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtBrokarage" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Guide">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtGuide" OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Guide") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow14" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtGuide" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="PROTSAHAN RASHI">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtBehtiExp" OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"BehtiExp") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow15" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtBehtiExp" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Green Tax">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtGreenTax"  OnBlur="javascript:return CalulateAmount()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"GreenTax") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow16" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtGreenTax" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="P. Exp">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtPExp" OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"PExp") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow17" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtPExp" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Misl. Expense">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtMislExp"  OnBlur="javascript:return CalulateAmount()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MislExp") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow18" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtMislExp" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Other Expense">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtOtherExp"  OnBlur="javascript:return CalulateAmount()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"OtherExp") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow19" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtOtherExp" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="PENALTY(-)">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtMExp" OnBlur="javascript:return CalulateAmount()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="50px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MExp") %>'> </asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow20" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtMExp" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                             <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Tyre Puncture">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtTyrePuncture" OnBlur="javascript:return CalulateAmount()" Text='<%# DataBinder.Eval(Container.DataItem,"TyrePuncture") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow21" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtTyrePuncture" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                             <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Servicing">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtServicing" OnBlur="javascript:return CalulateAmount()" Text='<%# DataBinder.Eval(Container.DataItem,"Servicing") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow22" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtServicing" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                             <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Parking">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtParking" OnBlur="javascript:return CalulateAmount()" Text='<%# DataBinder.Eval(Container.DataItem,"Parking") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow23" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtParking" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                              <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Mechanical">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtMechanical" OnBlur="javascript:return CalulateAmount()" Text='<%# DataBinder.Eval(Container.DataItem,"Mechanical") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow24" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtMechanical" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                               <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Greecing">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtGreecing" OnBlur="javascript:return CalulateAmount()" Text='<%# DataBinder.Eval(Container.DataItem,"Greecing") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow25" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtGreecing" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                               <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Air Check">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtAirCheck" OnBlur="javascript:return CalulateAmount()" Text='<%# DataBinder.Eval(Container.DataItem,"AirCheck") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow26" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtAirCheck" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                                 <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Danda Tax">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtDandaTax" OnBlur="javascript:return CalulateAmount()" Text='<%# DataBinder.Eval(Container.DataItem,"DandaTax") %>'  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow27" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtDandaTax" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                                <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Kaanta">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtKaanta" OnBlur="javascript:return CalulateAmount()" Text='<%# DataBinder.Eval(Container.DataItem,"Kaanta") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow28" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtKaanta" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Sub Total">
                                                                <ItemTemplate>
                                                                  <%--  <asp:TextBox ID="txtSubTotal" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow1" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtSubTotal" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                                                    <asp:Label runat="server" ID="lblSubTotal" CssClass="input" BorderStyle="Groove" Width="40px" Text='<%# DataBinder.Eval(Container.DataItem,"Total") %>'></asp:Label>
                                                                    <asp:HiddenField ID="hdnSubTotal" runat="server" value='<%# DataBinder.Eval(Container.DataItem,"Total") %>' />
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>

                                                             <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Toll">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtToll" OnBlur="javascript:return CalulateAmount()"   onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"Toll") %>'></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow1" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtToll" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                                <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Grand Total">
                                                                <ItemTemplate>
                                                                    <asp:Label runat="server" ID="lblGrandTotal" CssClass="input" BorderStyle="Groove" Width="40px" Text='<%# DataBinder.Eval(Container.DataItem,"GrandTotal") %>'></asp:Label>
                                                                    <asp:HiddenField ID="hdnGrandTotal" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"GrandTotal") %>'/>
                                                                    <%--<asp:TextBox ID="txtToll" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow1" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtToll" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                               <asp:TemplateField HeaderStyle-Width="10px" HeaderText="Fuel(Ltrs)">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtFuel" Text='<%# DataBinder.Eval(Container.DataItem,"Fuel") %>' onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server"></asp:TextBox>
                                                                    <asp:RegularExpressionValidator ID="RegtxtRow30" runat="server"
                                                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                                        ControlToValidate="txtFuel" Display="Dynamic"></asp:RegularExpressionValidator>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                           <%-- <asp:TemplateField HeaderStyle-Width="60px" HeaderText="Total: Cash Fuel">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtCashRate" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CashRate") %>'></asp:TextBox>

                                                                    <asp:TextBox ID="txtCashLtr" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CashLtr") %>'></asp:TextBox>

                                                                    <asp:TextBox ID="txtCashTotal" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"CashTotal") %>'></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>--%>

                                                            <%--<asp:TemplateField HeaderStyle-Width="60px" HeaderText="Grand Total: Cash Fuel">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtGCashRate" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"GCashRate") %>'></asp:TextBox>

                                                                    <asp:TextBox ID="txtGCashLtr" onkeypress="javascript:validFloat(event,this.getAttribute('id'))" CssClass="input" BorderStyle="Groove" Width="40px" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"GCashLtr") %>'></asp:TextBox>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>--%>

                                                            <asp:TemplateField HeaderStyle-Width="80px">
                                                                <HeaderTemplate>
                                                                    <asp:Label Text="Select Vehicle" runat="server" ID="lblSelectV"></asp:Label>
                                                                </HeaderTemplate>
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtCstLoc" CssClass="input" BorderStyle="Groove" runat="server" MaxLength="298" Width="300px" OnChange="Javascript:this.value=this.value.toUpperCase();" Text='<%# DataBinder.Eval(Container.DataItem,"VehicleList") %>'></asp:TextBox>
                                                                    <asp:Label ID="Label2" runat="server" BorderStyle="Groove" TabIndex="18" onclick="javascript:nwOpen(this.id)" Text='...' Width="14px"></asp:Label>
                                                                    <%-- <asp:Button ID="BtnCustCode" runat="server" Width="21px" OnClick="BtnCustCode_Click" Text="..." />--%>
                                                                </ItemTemplate>
                                                                <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                                <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                                    Font-Underline="False" Wrap="False" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td colspan="3" align="center">
                                            <asp:Button ID="btnFinalSubmit" runat="server" OnClick="btnFinalSubmit_Click" Text="Submit" />
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white; z-index: 99;">
    </div>
</asp:Content>



