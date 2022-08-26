<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="frmNewTripFuelDetails.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_frmNewTripFuelDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="AJAX_Validator/NewTripClosure.js"></script>
    <script type="text/javascript" src="../../../Js/jquery.min.js"></script>
    <script type="text/javascript" language="javascript" src="AJAX_Validator/NewTripDetailsUpdate.js?v11"></script>
    <script type="text/javascript" language="javascript" src="../../../images/commonJs.js"></script>
   
     <script type="text/javascript" language="javascript">

/// <reference name="MicrosoftAjax.js"/>
      
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
		
		$(document).ready(function () {

    var txtCurrentKM1 = document.getElementById("ctl00_MyCPH1_txtCurrentKM1");
    var txtCurrentKM2 = document.getElementById("ctl00_MyCPH1_txtCurrentKM2");
    var txtCurrentKM3 = document.getElementById("ctl00_MyCPH1_txtCurrentKM3");
    var txtCurrentKM4 = document.getElementById("ctl00_MyCPH1_txtCurrentKM4");

    var txtLastKM1 = document.getElementById("ctl00_MyCPH1_txtLastKM1");
    var txtLastKM2 = document.getElementById("ctl00_MyCPH1_txtLastKM2");
    var txtLastKM3 = document.getElementById("ctl00_MyCPH1_txtLastKM3");
    var txtLastKM4 = document.getElementById("ctl00_MyCPH1_txtLastKM4");

    CheckCurrentKM1(txtCurrentKM1, txtLastKM1);
    CheckCurrentKM2(txtCurrentKM2, txtLastKM2);
    CheckCurrentKM3(txtCurrentKM3, txtLastKM3);
    CheckCurrentKM4(txtCurrentKM4, txtLastKM4);
});
    </script>

    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 150px;
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
    <asp:UpdatePanel runat="server" UpdateMode="Always" ID="updatePanel9">
        <ContentTemplate>
            <asp:Table ID="Table1" runat="server" CellSpacing="1" Width="800px">
                <asp:TableRow Style="background-color: white">
                    <asp:TableCell HorizontalAlign="left" Width="45%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server" Text="TRIP SHEET >> ISSUE NEW WITHOUT REQUEST" />
                        <asp:HiddenField ID="hdnLastKM" runat="server" />
                    </asp:TableCell></asp:TableRow></asp:Table><br /><asp:Table ID="Table2" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                class="boxbg" Width="750px" BorderWidth="0">
                <asp:TableRow Style="background-color: white">
                    <asp:TableCell>
                        <table cellspacing="1" align="center">
                            <tr align="center">
                                <td align="left">
                                    <asp:Table ID="Table3" CellSpacing="1" CellPadding="3" runat="server" runat="server"
                                        class="boxbg" Width="750px" BorderWidth="0">
                                        <asp:TableRow ID="tblTripSummaryHdr" runat="server" class="bgbluegrey">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Fill 1 </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Fill 2 </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Fill 3 </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Fill 4 </font> </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow ID="TableRow1" Style="background-color: white" runat="server">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Date </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDate1" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="1"></asp:TextBox>
                                                <asp:HiddenField ID="hdnTotalAmount" runat="server" />
                                                <asp:HiddenField ID="hdnTotalAmtApproved" runat="server" />
                                                <asp:HiddenField ID="hdnDeviationFuel" runat="server" />
                                                <asp:HiddenField ID="hdnDeviationFuelPerc" runat="server" />
                                                <ajaxToolkit:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" TargetControlID="txtDate1"
                                                    runat="server" />
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDate2" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="11"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" TargetControlID="txtDate2"
                                                    runat="server" />
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDate3" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="21"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="CalendarExtender3" Format="dd/MM/yyyy" TargetControlID="txtDate3"
                                                    runat="server" />
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDate4" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="31"></asp:TextBox>
                                                <ajaxToolkit:CalendarExtender ID="CalendarExtender4" Format="dd/MM/yyyy" TargetControlID="txtDate4"
                                                    runat="server" />
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow ID="TableRow2" Style="background-color: white" runat="server">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Place </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtPlace1" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="2"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtPlace2" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="12"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtPlace3" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="22"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtPlace4" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="32"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Current KM </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtCurrentKM1" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="3" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtCurrentKM2" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="13" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtCurrentKM3" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="23" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtCurrentKM4" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="33" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Last KM </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtLastKM1" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtLastKM2" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtLastKM3" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtLastKM4" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Difference </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDifference1" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDifference2" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDifference3" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDifference4" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Vendor </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:DropDownList ID="ddlVendor1" runat="server" CssClass="input" Width="150px" BorderStyle="Groove"
                                                    MaxLength="50" TabIndex="4">
                                                </asp:DropDownList>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:DropDownList ID="ddlVendor2" runat="server" CssClass="input" Width="150px" BorderStyle="Groove"
                                                    MaxLength="50" TabIndex="14">
                                                </asp:DropDownList>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:DropDownList ID="ddlVendor3" runat="server" CssClass="input" Width="150px" BorderStyle="Groove"
                                                    MaxLength="50" TabIndex="24">
                                                </asp:DropDownList>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:DropDownList ID="ddlVendor4" runat="server" CssClass="input" Width="150px" BorderStyle="Groove"
                                                    MaxLength="50" TabIndex="34">
                                                </asp:DropDownList>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Bill No. </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtBillNo1" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="5"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtBillNo2" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="15"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtBillNo3" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="25"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtBillNo4" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="35"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Payment Mode </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:DropDownList ID="ddlPayment1" runat="server" CssClass="input" Width="150px"
                                                    BorderStyle="Groove" TabIndex="6" AutoPostBack="false">
                                                    <asp:ListItem Value="--Select--" Text="--Select--" />
                                                    <asp:ListItem Value="Cash" Text="Cash" />
                                                    <asp:ListItem Value="Diesel Card" Text="Diesel Card" />
                                                    <asp:ListItem Value="Fuel Slip" Text="Fuel Slip" />
                                                </asp:DropDownList>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:DropDownList ID="ddlPayment2" runat="server" CssClass="input" Width="150px"
                                                    BorderStyle="Groove" TabIndex="16" AutoPostBack="false">
                                                    <asp:ListItem Value="--Select--" Text="--Select--" />
                                                    <asp:ListItem Value="Cash" Text="Cash" />
                                                    <asp:ListItem Value="Diesel Card" Text="Diesel Card" />
                                                    <asp:ListItem Value="Fuel Slip" Text="Fuel Slip" />
                                                </asp:DropDownList>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:DropDownList ID="ddlPayment3" runat="server" CssClass="input" Width="150px"
                                                    BorderStyle="Groove" TabIndex="26" AutoPostBack="false">
                                                    <asp:ListItem Value="--Select--" Text="--Select--" />
                                                    <asp:ListItem Value="Cash" Text="Cash" />
                                                    <asp:ListItem Value="Diesel Card" Text="Diesel Card" />
                                                    <asp:ListItem Value="Fuel Slip" Text="Fuel Slip" />
                                                </asp:DropDownList>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:DropDownList ID="ddlPayment4" runat="server" CssClass="input" Width="150px"
                                                    BorderStyle="Groove" TabIndex="36" AutoPostBack="false">
                                                    <asp:ListItem Value="select" Text="select" />
                                                    <asp:ListItem Value="Cash" Text="Cash" />
                                                    <asp:ListItem Value="Diesel Card" Text="Diesel Card" />
                                                    <asp:ListItem Value="Fuel Slip" Text="Fuel Slip" />
                                                </asp:DropDownList>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Reference No. </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtRefNo1" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="7"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtRefNo2" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="17"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtRefNo3" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="27"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtRefNo4" CssClass="input" Width="150px" Style="text-align: left"
                                                    runat="server" BorderStyle="Groove" TabIndex="37"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Diesel Qty </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDieselQty1" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="8" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDieselQty2" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="18" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDieselQty3" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="28" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDieselQty4" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="38" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Diesel Rate </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDieselRate1" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="9" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDieselRate2" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="19" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDieselRate3" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="29" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtDieselRate4" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="39" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Amount </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtAmount1" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtAmount2" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtAmount3" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtAmount4" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> Approved Amount </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtApprvdAmt1" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="10" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtApprvdAmt2" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="20" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtApprvdAmt3" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="30" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtApprvdAmt4" CssClass="input" Width="150px" Style="text-align: right"
                                                    runat="server" TabIndex="40" BorderStyle="Groove" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                        <asp:TableRow Style="background-color: white">
                                            <asp:TableCell HorizontalAlign="left" Width="150px"> <font class=blackfnt> KMPL </font> </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtKMPL1" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtKMPL2" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtKMPL3" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                            <asp:TableCell HorizontalAlign="left" Width="150px">
                                                <asp:TextBox ID="txtKMPL4" Width="150px" Style="text-align: right" runat="server"
                                                    BorderStyle="None" onfocus="this.blur()"></asp:TextBox>
                                            </asp:TableCell>
                                        </asp:TableRow>
                                    </asp:Table>
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell></asp:TableRow><asp:TableRow class="bgbluegrey">
                    <asp:TableCell HorizontalAlign="Center">
                        <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" ValidationGroup="main"
                            OnClick="SubmitData" OnClientClick="javascript:return CheckFuelValidation()" />
                    </asp:TableCell></asp:TableRow></asp:Table></ContentTemplate></asp:UpdatePanel></asp:Content>