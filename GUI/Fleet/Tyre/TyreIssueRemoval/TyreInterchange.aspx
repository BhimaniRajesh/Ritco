<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="TyreInterchange.aspx.cs" Inherits="GUI_Fleet_Tyre_TyreIssueRemoval_TyreInterchange" %>

<%@ Register Src="~/GUI/Fleet/Tyre/TyreIssueRemoval/MultiEmpSelector.ascx" TagName="MultiSelect"
    TagPrefix="ucl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript">


        function createXMLHttpRequest() {
            // Mozilla, Safari,...
            if (window.XMLHttpRequest)
            { xmlHttpRequest = new XMLHttpRequest(); if (xmlHttpRequest.overrideMimeType) xmlHttpRequest.overrideMimeType("text/xml"); }
            // IE
            else if (window.ActiveXObject) { try { xmlHttpRequest = new ActiveXObject("Msxml2.XMLHTTP"); } catch (e) { try { xmlHttpRequest = new ActiveXObject("Microsoft.XMLHTTP"); } catch (e) { } } }
        }

        function CheckKMReading_1() {
            ////alert("KM 1");
            var currentTime = new Date();
            var txtKMReading_1 = document.getElementById("ctl00_MyCPH1_txtKMReading_1");
            var txtKMReading_2 = document.getElementById("ctl00_MyCPH1_txtKMReading_2");
            var ddlVHNO_1 = document.getElementById("ctl00$MyCPH1$ddlVHNO_1");
            var ddlVHNO_2 = document.getElementById("ctl00$MyCPH1$ddlVHNO_2");

            //// alert(ddlVHNO_1.value);
            if (ddlVHNO_1.value == "0") {
                alert("Please select Vehicle No");
                ddlVHNO_1.focus();
                return false;
            }

            if (txtKMReading_1.value == "") {
                //                            alert("Please enter KM Reading.");
                //                            txtKmReading.focus();
                return true;
            }

            if (parseFloat(txtKMReading_1.value) <= 0) {
                //alert("AAAAAAAA");
                return true;
            }
            //            var str = "./Ajax_Validation/AjaxResponse.aspx?Function=CheckTyre_KM&datetime=" + currentTime + "&VEH_NO=" + txtVehNo.value;
            //            alert(str);

            createXMLHttpRequest();
            if (xmlHttpRequest) {
                xmlHttpRequest.onreadystatechange = function () {
                    if (xmlHttpRequest.readyState == 4) {
                        var returnValue = xmlHttpRequest.responseText.split("~");
                        if (returnValue[0] == "Y") {
                            ////alert("KM-1 " + returnValue[1]);
                            if (parseFloat(returnValue[1]) >= parseFloat(txtKMReading_1.value)) {
                                alert("Please Enter KM greater than " + parseFloat(returnValue[1]));
                                txtKMReading_1.value = "0";
                                txtKMReading_1.focus();
                                return false;
                            }
                            //                            else {
                            //                                hdfKMReading.value = txtKMReading_1.value;
                            //                            }
                        }

                    }
                }
                xmlHttpRequest.open("GET", "./Ajax_Validation/AjaxResponse.aspx?Function=CheckTyre_KM&datetime=" + currentTime + "&VEH_NO=" + ddlVHNO_1.value, false);
                xmlHttpRequest.send(null);

                //                xmlHttpRequest.open("GET", "./Ajax_Validation/AjaxResponse.aspx?Function=CheckVehicle&datetime=" + currentTime + "&VEH_NO=" + txtVehNo.value, false);
                //                xmlHttpRequest.send(null);
            }
        }


        function CheckKMReading_2() {
            ////alert("KM 2");
            var currentTime = new Date();
            var txtKMReading_1 = document.getElementById("ctl00_MyCPH1_txtKMReading_1");
            var txtKMReading_2 = document.getElementById("ctl00_MyCPH1_txtKMReading_2");
            var ddlVHNO_1 = document.getElementById("ctl00$MyCPH1$ddlVHNO_1");
            var ddlVHNO_2 = document.getElementById("ctl00$MyCPH1$ddlVHNO_2");

            ////alert(ddlVHNO_2.value);
            if (ddlVHNO_2.value == "0") {
                alert("Please select Vehicle No.");
                ddlVHNO_2.focus();
                return false;
            }

            if (txtKMReading_2.value == "") {
                //                            alert("Please enter KM Reading.");
                //                            txtKmReading.focus();
                return true;
            }

            if (parseFloat(txtKMReading_2.value) <= 0) {
                //alert("AAAAAAAA");
                return true;
            }
            //            var str = "./Ajax_Validation/AjaxResponse.aspx?Function=CheckTyre_KM&datetime=" + currentTime + "&VEH_NO=" + txtVehNo.value;
            //            alert(str);

            createXMLHttpRequest();
            if (xmlHttpRequest) {
                xmlHttpRequest.onreadystatechange = function () {
                    if (xmlHttpRequest.readyState == 4) {
                        var returnValue = xmlHttpRequest.responseText.split("~");
                        if (returnValue[0] == "Y") {
                            ////alert("KM-2  " + returnValue[1]);
                            if (parseFloat(returnValue[1]) >= parseFloat(txtKMReading_2.value)) {
                                alert("Please Enter KM greater than " + parseFloat(returnValue[1]));
                                txtKMReading_2.value = "0";
                                txtKMReading_2.focus();
                                return false;
                            }
                            //                            else {
                            //                                hdfKMReading.value = txtKMReading_1.value;
                            //                            }
                        }

                    }
                }
                xmlHttpRequest.open("GET", "./Ajax_Validation/AjaxResponse.aspx?Function=CheckTyre_KM&datetime=" + currentTime + "&VEH_NO=" + ddlVHNO_2.value, false);
                xmlHttpRequest.send(null);

                //                xmlHttpRequest.open("GET", "./Ajax_Validation/AjaxResponse.aspx?Function=CheckVehicle&datetime=" + currentTime + "&VEH_NO=" + txtVehNo.value, false);
                //                xmlHttpRequest.send(null);
            }
        }


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

    function CheckOnSubmit() {
        var ddlVHNO_1 = document.getElementById("ctl00$MyCPH1$ddlVHNO_1");
        var ddlVHNO_2 = document.getElementById("ctl00$MyCPH1$ddlVHNO_2");
        var txtKMReading_1 = document.getElementById("ctl00_MyCPH1_txtKMReading_1");
        var txtKMReading_2 = document.getElementById("ctl00_MyCPH1_txtKMReading_2");

        if (ddlVHNO_1.value == "0") {
            alert("select Vehicle No.");
            ddlVHNO_1.focus();
            return false;
        }

        if (ddlVHNO_2.value == "0") {
            alert("select Vehicle No.");
            ddlVHNO_2.focus();
            return false;
        }



        if (ddlVHNO_1.value != "0" && ddlVHNO_2.value != "0") {
            if (ddlVHNO_1.value == ddlVHNO_2.value) {
                alert("You has selected same vehicle No.");
                ddlVHNO_1.value = "0";
                document.getElementById("ctl00$MyCPH1$lstVhno_Left").options.length = 0;
                document.getElementById("ctl00$MyCPH1$lstModel_Left").options.length = 0;
                ddlVHNO_1.focus();
                return false;
            }

            if (parseFloat(txtKMReading_2.value) <= 0) {
                alert("Please enter KM reading");
                txtKMReading_2.focus();
                return false;
            }

            if (parseFloat(txtKMReading_1.value) <= 0) {
                alert("Please enter KM reading");
                txtKMReading_1.focus();
                return false;
            }
        }
    }

    function OnSubmit() {
        // debugger;

        var ddlVHNO_1 = document.getElementById("ctl00$MyCPH1$ddlVHNO_1");
        var ddlVHNO_2 = document.getElementById("ctl00$MyCPH1$ddlVHNO_2");
        var lstVhno_Left = document.getElementById("ctl00$MyCPH1$lstVhno_Left");
        var lstVhno_Right = document.getElementById("ctl00$MyCPH1$lstVhno_Right");
        var txtKMReading_1 = document.getElementById("ctl00_MyCPH1_txtKMReading_1");
        var txtKMReading_2 = document.getElementById("ctl00_MyCPH1_txtKMReading_2");
        // alert(ddlVHNO_1.value);

        if (ddlVHNO_1.value == "0") {
            alert("select Vehicle No.");
            ddlVHNO_1.focus();
            return false;
        }
        //alert(ddlVHNO_2.value);
        if (ddlVHNO_2.value == "0") {
            alert("select Vehicle No.");
            ddlVHNO_2.focus();
            return false;
        }

        if (ddlVHNO_1.value != "0" && ddlVHNO_2.value != "0") {
            if (ddlVHNO_1.value == ddlVHNO_2.value) {
                alert("You has selected same vehicle No.");
                ddlVHNO_1.focus();
                return false;
            }
        }

        if (parseFloat(txtKMReading_2.value) <= 0) {
            alert("Please enter KM reading");
            txtKMReading_2.focus();
            return false;
        }

        if (parseFloat(txtKMReading_1.value) <= 0) {
            alert("Please enter KM reading");
            txtKMReading_1.focus();
            return false;
        }


        var lenLeft = lstVhno_Left.options.length;
        var lenRight = lstVhno_Right.options.length;
        //alert("L=" + lenLeft + " R=" + lenRight);

        if (lenLeft == 0 && lenRight == 0) {
            alert("There is no any Tyre No. available to interchange.Select other Vehicle No.");
            ddlVHNO_1.focus();
            return false;
        }
    }

        
    </script>
    <table width="100%">
        <tr>
            <td>
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Interchange Master</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
                </br>
            </td>
        </tr>
    </table>
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
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
        <ContentTemplate>--%>
    <table border="1" width="60%">
        <tr class="bgbluegrey">
            <td align="center" colspan="5">
                <asp:Label ID="Label3" runat="server" Text="Interchange Tyre Master" Font-Bold="true"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label4" runat="server" Text="Select Truck No." Font-Bold="true"></asp:Label>
            </td>
            <td>
                <%-- <asp:UpdatePanel ID="up_VhTyp" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                            <ContentTemplate>--%>
                <asp:DropDownList ID="ddlVHNO_1" runat="server" Width="100px" OnSelectedIndexChanged="ddlVHNO1_SelectedIndexChanged"
                    AutoPostBack="true">
                </asp:DropDownList>
                <%-- </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="lstVhno_Left" EventName="selectedIndexChanged" />
                            </Triggers>
                        </asp:UpdatePanel>--%>
            </td>
            <td>
            </td>
            <td>
                <asp:Label ID="Label5" runat="server" Text="Select Truck No." Font-Bold="true"></asp:Label>
            </td>
            <td>
                <asp:UpdatePanel ID="UpdatePanel2" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlVHNO_2" runat="server" Width="100px" OnSelectedIndexChanged="ddlVHNO2_SelectedIndexChanged"
                            AutoPostBack="true">
                        </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="lstVhno_Right" EventName="selectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label6" runat="server" Text="Odometer Reading"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtKMReading_1" runat="server" Text="0" Style="text-align: right"
                    onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
            </td>
            <td>
            </td>
            <td>
                <asp:Label ID="Label7" runat="server" Text="Odometer Reading"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtKMReading_2" runat="server" Text="0" Style="text-align: right"
                    onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="5">
                <br>
            </td>
        </tr>
        <tr style="background-color: white">
            <td align="center" style="width: 250px">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp
                <asp:Label ID="lblNotMap" runat="server" Text="Tyre No."></asp:Label>
                <asp:UpdatePanel ID="up_VhTyp" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:ListBox ID="lstVhno_Left" runat="server" SelectionMode="Multiple" Height="110"
                            Width="100%" ToolTip="CityNotMap"></asp:ListBox>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlVHNO_1" EventName="selectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="Label2" runat="server" Text="Model No."></asp:Label>
                <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:ListBox ID="lstModel_Left" SelectionMode="Multiple" runat="server" Height="110"
                            Width="100%"></asp:ListBox>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlVHNO_1" EventName="selectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
            <td align="center" style="width: 60px">
                <asp:Button ID="linkAddAll" runat="server" Text=">>" OnClick="linkAddAll_Click" ToolTip="Add all to selected"
                    Width="25" Font-Bold="true" BorderStyle="Groove" /><br />
                <asp:Button ID="linkAddSelected" runat="server" Text=">" OnClick="linkAddSelected_Click"
                    ToolTip="Add to selected" Width="25" Font-Bold="true" BorderStyle="Groove" /><br />
                <asp:Button ID="linkRemoveSelected" runat="server" Text="<" OnClick="linkRemoveSelected_Click"
                    ToolTip="Remove from selected" Width="25" Font-Bold="true" BorderStyle="Groove" /><br />
                <asp:Button ID="linkRemoveAll" runat="server" Text="<<" OnClick="linkRemoveAll_Click"
                    ToolTip="Remove all from selected" Width="25" Font-Bold="true" BorderStyle="Groove" />
            </td>
            <td align="center" style="width: 240px">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblMap" runat="server" Text="Tyre No."></asp:Label>
                <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:ListBox ID="lstVhno_Right" runat="server" SelectionMode="Multiple" Height="110"
                            Width="100%"></asp:ListBox>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlVHNO_2" EventName="selectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
            <td>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp
                <asp:Label ID="Label1" runat="server" Text="Model No."></asp:Label>
                <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                    <ContentTemplate>
                        <asp:ListBox ID="lstModel_Right" SelectionMode="Multiple" runat="server" Height="110"
                            Width="100%"></asp:ListBox>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ddlVHNO_2" EventName="selectedIndexChanged" />
                    </Triggers>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr class="bgbluegrey">
            <td colspan="5" align="center">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"
                    OnClientClick="javascript:return OnSubmit()" />
            </td>
        </tr>
        <tr class="bgwhite">
            <td colspan="5">
                <asp:Label ID="lblMessage" runat="server" Visible="False" ForeColor="Red" ToolTip="PincodeMap"></asp:Label>
            </td>
        </tr>
    </table>
    <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
