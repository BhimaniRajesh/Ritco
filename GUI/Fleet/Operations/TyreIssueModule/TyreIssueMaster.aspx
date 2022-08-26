<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="TyreIssueMaster.aspx.cs" Inherits="GUI_Fleet_TyreIssueModule_TyreIssueMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../images/DateControl.js"></script>
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
        //--------------------------------------------------Validation for Removal KM
        //Check_KM(txtRemovalKM, hdfFitmentKM)
        function Check_KM() {
            //   debugger;
            var currentTime = new Date();
            var GV_TyreDetails = document.getElementById("ctl00_MyCPH1_GV_TyreDetails");

            if (GV_TyreDetails.rows.length != 0) {
                // alert(GV_TyreDetails.rows.length);
                for (i = 0; i <= GV_TyreDetails.rows.length - 2; i++) {
                    j = i + 2;
                    var pref = "";
                    if (j < 10) {
                        pref = "ctl00$MyCPH1$GV_TyreDetails$ctl0" + j + "$";
                    }
                    else {
                        pref = "ctl00$MyCPH1$GV_TyreDetails$ctl" + j + "$";
                    }

                    // pref = "MyCPH1$GV_TyreDetails$ctl0" + i + "$";
                    var txtRemovalKM = document.getElementById(pref + "txtRemovalKM");
                    var hdfFitmentKM = document.getElementById(pref + "hdfFitmentKM");
                    var txtDistanceCovered = document.getElementById(pref + "txtDistanceCovered");
                    var txtPerKMCost = document.getElementById(pref + "txtPerKMCost");

                    if (parseFloat(txtRemovalKM.value) <= parseFloat(hdfFitmentKM.value)) {
                        alert("Removal Amount should be grater than " + hdfFitmentKM.value);
                        txtDistanceCovered = "";
                        txtPerKMCost = "";
                        txtRemovalKM.value = "";
                        txtRemovalKM.focus();
                        return false;
                    }
                }
            }


        }
        //-------------------------------------------Check Valid Vehicle No.
        function createXMLHttpRequest() {
            // Mozilla, Safari,...
            if (window.XMLHttpRequest)
            { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
            // IE
            else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
        }


        function CheckVhNo() {
            // debugger;
            //alert("CheckVhNo***");
            var txtVehNo = document.getElementById("ctl00_MyCPH1_txtVehNo");
            var txtKmReading = document.getElementById("ctl00_MyCPH1_txtKmReading");
            // alert(txtVehNo.value);

            var currentTime = new Date();

            /*if (txtKmReading.value == "") {

                txtKmReading.value = "0";
            }*/
            if (txtVehNo.value == "" && txtKmReading.value == "") {
                //                            alert("Please enter KM Reading.");
                //                            txtKmReading.focus();
                return false;
            }

            ////            if (txtKmReading.value) <= 0|| txtKmReading.value == "") {
            ////                alert("Please enter KM Reading.");
            ////                txtKmReading.focus();
            ////            }

            createXMLHttpRequest();
            if (xmlHttpRequest) {
                xmlHttpRequest.onreadystatechange = function () {
                    if (xmlHttpRequest.readyState == 4) {
                        var returnValue = xmlHttpRequest.responseText.split("~");
                        if (returnValue[0] == "N") {
                            alert("Please Enter valid Vehicle No. ");
                            txtVehNo.value = "";
                            txtVehNo.focus();
                            return false;

                        }
                        else {
                            //alert("Valid Vehicle !!!!")
                            //return false;
                            if (txtKmReading.value == "") {
                                return false;
                            }

                        }
                    }
                }
                xmlHttpRequest.open("GET", "./Ajax_Validation/AjaxResponse.aspx?Function=CheckVehicle&datetime=" + currentTime + "&VEH_NO=" + txtVehNo.value, false);
                xmlHttpRequest.send(null);
            }
        }


        //----------------------------Validation for KM Reading
        function CheckKMReading() {
            //alert("CheckKMReading****1");
            //return false;
            //debugger;
            var currentTime = new Date();
            //alert(currentTime);
            var txtKmReading = document.getElementById("<%=txtKmReading.ClientID %>");
            var hdfKMReading = document.getElementById("<%=hdfKMReading.ClientID %>");
            var txtVehNo = document.getElementById("<%=txtVehNo.ClientID %>");
            
            if (txtVehNo.value=="" && txtKmReading.value == ""  ) {
                //                            alert("Please enter KM Reading.");
                //                            txtKmReading.focus();
                return false;
            }
           

            if (txtVehNo.value == "") {
                alert("Please enter Truck No.");
                txtVehNo.focus();
                return false;
            }

           
            createXMLHttpRequest();
            if (xmlHttpRequest) {
                xmlHttpRequest.onreadystatechange = function () {
                    if (xmlHttpRequest.readyState == 4) {
                        var returnValue = xmlHttpRequest.responseText.split("~");
                        //alert("returnValue[0] : " + returnValue[0]);

                        if (returnValue[0] == "Y") {
                            //alert("txtKmReading.value : " + txtKmReading.value);
                            //alert("returnValue[1] : " + returnValue[1]); 
                            if (parseFloat(returnValue[1]) >= parseFloat(txtKmReading.value)) {
                                alert("Please Enter KM greater than " + parseFloat(returnValue[1]));
                                hdfKMReading.value = returnValue[1];
                                //txtKmReading.value = "0";
                                //alert("hdfKMReading1 :" + hdfKMReading.value);
                              
                                txtKmReading.focus();
                                return true;
                                //return false;
                            }
                            else {
                                hdfKMReading.value = returnValue[1];
                             
                                //alert("Valid KM !!!!")
                                return true;
                            }
                        }
                        else {
                            hdfKMReading.value = "0";
                        
                            return true;

                        }


                    }
                }
                xmlHttpRequest.open("GET", "./Ajax_Validation/AjaxResponse.aspx?Function=CheckTyre_KM&datetime=" + currentTime + "&VEH_NO=" + txtVehNo.value + "&temp1=" + Math.random() + "&temp2=" + currentTime, false);
                xmlHttpRequest.send(null);

            }
        }


        //--------------------------------------- For Select All Checkbox

        function SelectAll(CheckBoxControl) {
            if (CheckBoxControl.checked == true) {
                var i;
                for (i = 0; i < document.forms[0].elements.length; i++) {
                    if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('GVTyreDetails') > -1)) {
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
                    if ((document.forms[0].elements[i].type == 'checkbox') && (document.forms[0].elements[i].name.indexOf('GVTyreDetails') > -1)) {
                        document.forms[0].elements[i].checked = false;
                    }
                }
            }
        }

        //-------------------------------------------- validation on step-1

        function CheckOnSubmit() {
            // debugger
            // var txtVehNo = document.getElementById("ctl00_MyCPH1_txtVehNo");
            var txtVehNo = document.getElementById("ctl00_MyCPH1_txtVehNo");
            var txtDate = document.getElementById("ctl00_MyCPH1_txtDate");
            var txtKmReading = document.getElementById("ctl00_MyCPH1_txtKmReading");
            var Count = 0;

            if (txtVehNo.value == "") {
                alert("Enter Truck No. !!!");
                txtVehNo.focus();
                return false;
            }

            if (txtDate.value == "") {
                alert("Enter Date !!!");
                txtDate.focus();
                return false;
            }

            if (parseFloat(txtKmReading.value) <= 0) {
                alert("Enter KM Reading. !!!");
                txtKmReading.focus();
                return false;
            }
            var GVTyreDetails = document.getElementById("ctl00_MyCPH1_GVTyreDetails");
            // var GVTyreDetails = document.getElementById("MyCPH1_GVTyreDetails");
            var Count = 0;
            // alert(GVTyreDetails.rows.length);


            if (GVTyreDetails.rows.length != 0) {
                //alert(GVTyreDetails.rows.length);
                for (i = 0; i <= GVTyreDetails.rows.length - 2; i++) {
                    j = i + 2;
                    var pref = "";
                    if (j < 10) {
                        pref = "ctl00$MyCPH1$GVTyreDetails$ctl0" + j + "$";
                    }
                    else {
                        pref = "ctl00$MyCPH1$GVTyreDetails$ctl" + j + "$";
                    }
                    var chkSelected = document.getElementById(pref + "chkSelected");
                    //alert(Count + "-" + i);
                    if (chkSelected.checked == true) {
                        Count = Count + 1;
                    }
                }
            }
            //alert("2=" + Count);
            if (Count == 0) {
                alert("Select At least one Tyre ID.");
                return false;
            }

        }

        //////// Check on Submit ////////

        function CheckOnSubmit_New() {
            // debugger
            var Count = 0, Count_I = 0;

            var txtVehNo = document.getElementById("ctl00_MyCPH1_txtVehNo");
            var txtKmReading = document.getElementById("ctl00_MyCPH1_txtKmReading");
            var txtRemoveDT = document.getElementById("ctl00_MyCPH1_txtRemoveDT");
            var txtDate = document.getElementById("ctl00_MyCPH1_txtDate");
            var GV_TyreDetails = document.getElementById("ctl00_MyCPH1_GV_TyreDetails");
            var GVTyreDetails = document.getElementById("ctl00_MyCPH1_GVTyreDetails");
            var tblRemoval = document.getElementById("ctl00_MyCPH1_tblRemoval");

            

            /* if (tblRemoval.style["display"] == "block") {
            if (txtRemoveDT.value == "") {
            alert("Please Enter Removal Date.");
            txtRemoveDT.focus();
            return false;
            }
            }
            alert(tblRemoval.style.display);
            if (tblRemoval.style.display == "block") {
                alert("in")
                if (txtRemoveDT.value == "") {
                    alert("Please Enter Removal Date.");
                    txtRemoveDT.focus();
                    return false;
                }
            }*/


            

           
            if (txtDate.value == "") {
                alert("Enter Date !!!");
                txtDate.focus();
                return false;
            }
            if (txtVehNo.value == "") {
                alert("Enter Truck No. !!!");
                txtVehNo.focus();
                return false;
            }
            if (parseFloat(txtKmReading.value) <= 0) {
                alert("Enter KM Reading. !!!");
                txtKmReading.focus();
                return false;
            }

            //---------- Issue table

            if (GVTyreDetails.rows.length != 0) {
                //alert(GVTyreDetails.rows.length);
                for (i = 0; i <= GVTyreDetails.rows.length - 2; i++) {
                    j = i + 2;
                    var pref = "";
                    if (j < 10) {
                        pref = "ctl00$MyCPH1$GVTyreDetails$ctl0" + j + "$";
                    }
                    else {
                        pref = "ctl00$MyCPH1$GVTyreDetails$ctl" + j + "$";
                    }
                    var chkSelected = document.getElementById(pref + "chkSelected");
                    //alert(Count + "-" + i);
                    if (chkSelected.checked == true) {
                        Count_I = Count_I + 1;
                    }
                }
            }
            if (Count_I == 0) {
                alert("Select At least one Tyre ID for Issue to vehicle.");
                return false;
            }
            //----------

            if (GV_TyreDetails.rows.length != 0) {
                //alert(GVTyreDetails.rows.length);
                for (i = 0; i <= GV_TyreDetails.rows.length - 2; i++) {
                    j = i + 2;
                    var pref = "";
                    if (j < 10) {
                        pref = "ctl00$MyCPH1$GV_TyreDetails$ctl0" + j + "$";
                    }
                    else {
                        pref = "ctl00$MyCPH1$GV_TyreDetails$ctl" + j + "$";
                    }
                    var chkSelected1 = document.getElementById(pref + "chkSelected1");

                    var txtRemovalKM = document.getElementById(pref + "txtRemovalKM");
                    var txtDistanceCovered = document.getElementById(pref + "txtDistanceCovered");
                    var txtPerKMCost = document.getElementById(pref + "txtPerKMCost");


                    // alert(Count + "-" + i);
                    if (chkSelected1.checked == true) {
                        Count = Count + 1;

                        if (txtRemovalKM.value == "") {
                            alert("Please Enter Removal KM.");
                            txtRemovalKM.focus();
                            return false;
                        }
                    }
                }
            }


            var mVisibleFlag = document.getElementById("ctl00_MyCPH1_tblRemoval").style.visibility;
            if (mVisibleFlag == "hidden") {
                //alert("hidden");
            }
            else {
                //alert("false");
                //alert("Count : " + Count);
                if (parseInt(Count) > 0) {
                    if (txtRemoveDT.value == "") {
                        alert("Please Enter Removal Date.");
                        txtRemoveDT.focus();
                        return false;
                    }
                }
            }
            

            //alert("submit");
            //return false;


            //alert("2=" + Count);
            //AP
           // if (Count == 0) {
             //   alert("Select At least One Tyre ID to remove from vehicle.");
               // return false;
            //}

        }

        //-------------------------------JQuery
        //        $(document).ready(function () {

        //            $("#ctl00_MyCPH1_txtVehNo").blur(function () {
        //                alert("hiiii");
        //            });
        //        });
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
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Issue/Removal Master</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
     
<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
    <table cellspacing="0" cellpadding="0" width="700px" border="1" class="boxbg">
        <tr align="center" class="bgbluegrey">
            <td colspan="4">
                <asp:Label ID="Label4" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Issue Master</asp:Label>
            </td>
        </tr>
        <tr style="background-color: white">
            <td>
                <asp:Label ID="Label1" CssClass="blackfnt" runat="server">Enter Truck No.</asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtVehNo" runat="server" TabIndex="1" ></asp:TextBox><%-- AutoPostBack="true" OnTextChanged="OnVehChange"--%>
                <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" MinimumPrefixLength="1"
                    ServiceMethod="AutoVhNo" ServicePath="../AtlasAutoComplete.asmx" TargetControlID="txtVehNo">
                </ajaxToolkit:AutoCompleteExtender>
            </td>
            <td>
                <asp:Label ID="Label2" CssClass="blackfnt" runat="server" Width="120px">Tyre Issue Date</asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtDate" runat="server" TabIndex="2"></asp:TextBox>
                <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" Format="dd/MM/yyyy" TargetControlID="txtDate"
                    runat="server" />
            </td>
        </tr>
        <tr style="background-color: white">
            <td>
                <asp:Label ID="Label3" CssClass="blackfnt" runat="server">KM Reading at time of Fitment</asp:Label>
            </td>
            <td colspan="3">
                <asp:TextBox ID="txtKmReading" runat="server" TabIndex="3" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                       CssClass="rtxt" OnTextChanged="OnVehChange"  AutoPostBack="true"></asp:TextBox>
                <asp:HiddenField ID="hdfKMReading" runat="server" />
                
            </td>
        </tr>
    </table>
    <br />
    
            <table width="800px" border="1">
                <tr id="trRemove" runat="server">
                    <td>
                        <table width="200px" border="0" id="tblRemoval" runat="server" class="boxbg" cellspacing="1"
                            cellpadding="0">
                            <tr style="background-color: white">
                                <td>
                                    <table id="tblGrid" cellspacing="0" cellpadding="3" width="200px" class="boxbg" border="1"
                                        runat="server" visible="false">
                                        <tr class="bgwhite">
                                            <td colspan="8">
                                                <asp:Label ID="Label10" runat="server" Text="Tyre for Removal" Font-Bold="true"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td>
                                                <asp:Label ID="lblRemoveDT" runat="server" Text="Tyre Removal Date" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtRemoveDT" runat="server"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" TargetControlID="txtRemoveDT"
                                                    runat="server" />
                                            </td>
                                            <td>
                                                <asp:Label ID="Label7" runat="server" Text="Tyre As per Axle" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAxel" runat="server" Text="" onfocus="this.blur()" BorderStyle="Groove"
                                                    Width="50px" CssClass="rtxt"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label8" runat="server" Text="Actual Tyre" Font-Bold="true"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtActualTyre" runat="server" onfocus="this.blur()" CssClass="rtxt"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label9" runat="server" Text="Pending Tyre" Font-Bold="true"></asp:Label>
                                                <asp:HiddenField ID="hdfPendingTyre" runat="server" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPendingTyre" runat="server" CssClass="rtxt" onfocus="this.blur()"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td colspan="8">
                                                <br />
                                                <asp:GridView ID="GV_TyreDetails" runat="server" align="left" BorderWidth="0" CellSpacing="1"
                                                    OnRowDataBound="GV_TyreDetails_RowDataBound" CellPadding="2" HeaderStyle-CssClass="bgbluegrey"
                                                    PagerStyle-HorizontalAlign="left" EmptyDataText="No Record found for Removal of Tyre ......."
                                                    CssClass="boxbg" FooterStyle-CssClass="bgbluegrey" AllowPaging="False" PageSize="1"
                                                    Width="200px" AllowSorting="False" AutoGenerateColumns="false" ShowFooter="false"
                                                    PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]">
                                                    <PagerStyle VerticalAlign="Bottom" />
                                                    <Columns>
                                                        <asp:TemplateField ItemStyle-BackColor="white">
                                                            <HeaderTemplate>
                                                                <asp:CheckBox ID="ChkSelectAll" AutoPostBack="true" runat="server" />
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:CheckBox ID="chkSelected1" runat="server" /><%--AutoPostBack="true" OnCheckedChanged="CalculatePendingTyre"--%>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="SR.</br>NO." ItemStyle-Width="10px" ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                                                </asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="GRN Date" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <%--<asp:Label ID="lblTyreNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_ID") %>'></asp:Label>--%>
                                                                <asp:Label ID="Label6" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"GRNDT") %>'></asp:Label>
                                                                <asp:HiddenField ID="hdfTyreNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TYREID_N") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Manual</br>Tyre NO" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblManualTyreNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_NO") %>'></asp:Label>
                                                                <asp:HiddenField ID="hdfManualTyreNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TYRE_NO") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <%--                                             <asp:TemplateField HeaderText="Make" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMake" runat="server" Text="NA"></asp:Label>
                                                    <asp:HiddenField ID="hdfMake" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                                        <asp:TemplateField HeaderText="Model" ItemStyle-Width="10px" ItemStyle-Wrap="false"
                                                            ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblModel" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MODEL") %>'></asp:Label>
                                                                <asp:HiddenField ID="hdfModel" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"MODEL") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Size" ItemStyle-Width="10px" ItemStyle-Wrap="false"
                                                            ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSize" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"SIZE") %>'></asp:Label>
                                                                <asp:HiddenField ID="hdfSize" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"SIZE") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Pattern" ItemStyle-Width="10px" ItemStyle-Wrap="false"
                                                            ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPattern" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"PATTERN") %>'></asp:Label>
                                                                <asp:HiddenField ID="hdfPattern" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"PATTERN") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Tyre</br>Type" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTyreType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_TYPE") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Tyre</br>MFG" ItemStyle-Width="10px" ItemStyle-Wrap="true"
                                                            ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTyreMFG" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MFG") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="GRN</br>Amount" ItemStyle-Width="10px" ItemStyle-Wrap="false"
                                                            ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGRNAmount" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_COST") %>'></asp:Label>
                                                                <asp:HiddenField ID="hdfGRNAmount" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TYRE_COST") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Fitment</br>Date" ItemStyle-Width="10px" ItemStyle-Wrap="false"
                                                            ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblFitmentDate" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MOUNT_DT") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Fitment</br>KM" ItemStyle-Width="10px" ItemStyle-Wrap="false"
                                                            ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblFitmentKM" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MANUAL_MOUNT_KM_RUN") %>'></asp:Label>
                                                                <asp:HiddenField ID="hdfFitmentKM" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"MANUAL_MOUNT_KM_RUN") %>' />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Removal</br>KM" ItemStyle-Width="10px" ItemStyle-Wrap="false"
                                                            ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" Width="10px" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtRemovalKM" runat="server" OnTextChanged="CalculateDistance" Enabled="false"
                                                                    AutoPostBack="true" Style="text-align: right"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Distance</br>Covered" ItemStyle-Width="10px" ItemStyle-Wrap="false"
                                                            ItemStyle-BackColor="white">
                                                            <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                            <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtDistanceCovered" runat="server" Enabled="false" Style="text-align: right"
                                                                    Text="0.00"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Per KM</br>Cost" ItemStyle-Wrap="false" ItemStyle-Width="10px"
                                                            ItemStyle-BackColor="white">
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
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trIssueTyre" runat="server">
                    <td>
                        <table width="100%" id="tblIssueTyre" runat="server">
                            <tr style="background-color: white">
                                <td align="left" colspan="4">
                                    <br />
                                    <asp:Label ID="Label5" runat="server" Text="Tyre in Stock" Font-Bold="true"></asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td colspan="4">
                                    <asp:GridView ID="GVTyreDetails" runat="server" align="left" BorderWidth="1" CellSpacing="1"
                                        CellPadding="2" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                                        FooterStyle-CssClass="bgbluegrey" AllowPaging="true" PageSize="25" Width="100%"
                                          OnPageIndexChanged="gwTyreList_PageIndexChanged" OnPageIndexChanging="gwTyreList_PageIndexChanging" 
                                        AllowSorting="False" AutoGenerateColumns="false" ShowFooter="false" PagerSettings-FirstPageText="[First]"
                                        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                                        <PagerStyle VerticalAlign="Bottom" />
                                        <Columns>
                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                            <asp:CheckBox ID="chkSelected" runat="server"  /><%--AutoPostBack="true"--%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server">
                                                    </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="GRN Date." ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblGRNDT" Text='<%# DataBinder.Eval(Container.DataItem,"GRNDT") %>'
                                                        runat="server">
                                                    </asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--                 <asp:TemplateField HeaderText="Tyre</br>Reference</br>NO." ItemStyle-Wrap="false"
                                                ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTyreNo" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_ID") %>'></asp:Label>                                                    
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Manual</br>Tyre NO" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTyre_No" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_NO") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdfTyreNo" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"TYREID_N") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--  <asp:TemplateField HeaderText="Make" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                    <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                    <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblMake" runat="server"   Text=""></asp:Label>
                                        <asp:HiddenField ID="hdfMake" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Model" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblModel" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MODEL") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdfModel" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Size" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSize" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"SIZE") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdfSize" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Pattern" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPattern" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"PATTERN") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdfPattern" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Tyre Type" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="center" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTyreType" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"TYRE_TYPE") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Tyre MFG" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                                <ItemStyle CssClass="blackfnt" HorizontalAlign="center" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTyreMFG" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"MFG") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <%--        <tr style="background-color: white">
            <td align="right" colspan="4">
                <asp:Button ID="btnSubmit" runat="server" Text="Step1" OnClick="btnSubmit1_Click"
                     OnClientClick="javascript:return CheckOnSubmit()"/>
                
            </td>
        </tr>--%>
                            <tr id="trSubmit" class="bgbluegrey">
                                <td align="center" colspan="8">
                                    <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="btnSubmit_Click" OnClientClick="javascript:return CheckOnSubmit_New()" />
                                    <asp:Label ID="lblMsg" runat="server" Text="" ForeColor="Red"></asp:Label>
                                    <asp:Label ID="lbl_Page_Error" runat="server" Text="" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                            <%--        <tr id="trSubmit_New" runat="server" class="bgbluegrey">
            <td align="center" colspan="8">
                <asp:Button ID="btnSubmit_New" runat="server" Text="Submit" OnClick="btnSubmit_New_Click" />
            </td>
        </tr>--%>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
        <asp:AsyncPostBackTrigger ControlID="txtVehNo" EventName="TextChanged" />
         <asp:AsyncPostBackTrigger ControlID="txtKmReading" EventName="TextChanged" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
