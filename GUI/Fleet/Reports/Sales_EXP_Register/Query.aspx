<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_Sales_EXP_Register_Query" %>

<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="HR_To" TagPrefix="Location_To" Src="~/GUI/Common_UserControls/LOC_HRCHY_TO.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date_Test.ascx" %>
<%@ Register TagName="CMPFT" TagPrefix="Company" Src="~/GUI/Common_UserControls/CompayFilter.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="TRN" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster1" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="SVCTYP" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster2" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="PAYTYP" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster3" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="BUT" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster4" runat="server" SelectCommand="WebxNet_GeneralMaster_Report"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="codetype" DefaultValue="vendty" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Route" runat="server" SelectCommand="WebxNet_Routes_Report"
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <script language="JavaScript" src="../../../images/CalendarPopup.js"></script>
    <script language="javascript" src="../../../images/commonJs.js"></script>
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function cust(ID) {
            ///var FrmChild = window.open('../PopUp_Cust.aspx?ID="+ID' ,'myWindow','height=285,width=450,resizable=yes,scrollbars=yes,left=310,top=15'); 
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=600 ,height=400,status=no,left=60,top=50"
            var strPopupURL = "../PopUp_Cust.aspx?ID=" + ID

            winNew = window.open(strPopupURL, "_blank", strWinFeature)
        }



        function SelectDOC() {
            ShowDKTFilter();
            ShowDKTColumns();
        }


        function ShowDKTFilter() {
            HideDKTFilter();


            for (dkt = 1; dkt < 7; dkt++) {
                document.getElementById('ctl00_MyCPH1_dkttr' + dkt).style.display = "block";
            }


        }
        function HideDKTFilter() {

            for (dkt = 1; dkt < 6; dkt++) {
                document.getElementById('ctl00_MyCPH1_dkttr' + dkt).style.display = "none";
            }

            for (thc = 1; thc < 3; thc++) {
                document.getElementById('ctl00_MyCPH1_thctr' + thc).style.display = "none";
                if (thc == "1" | thc == "2") {
                    document.getElementById('ctl00_MyCPH1_Vendtr' + thc).style.display = "none";
                }
            }

        }


        function ShowDKTColumns() {

            for (dkt = 1; dkt < 9; dkt++) {
                document.getElementById('ctl00_MyCPH1_dktcl' + dkt).style.display = "block";
            }


        }
        function HideDKTColumns() {


            for (dkt = 1; dkt < 9; dkt++) {
                document.getElementById('ctl00_MyCPH1_dktcl' + dkt).style.display = "none";
            }


        }

        function CHKDKT1(val) {
            var CHKDKT1 = document.getElementById("ctl00_MyCPH1_CHKDKT1");

            if (CHKDKT1.checked == true) {
                for (im = 0; im < 42; im++) {
                    document.getElementById("ctl00_MyCPH1_CheckBoxList1_" + im).checked = true;
                }
            }
            if (CHKDKT1.checked == false) {
                for (im = 0; im < 42; im++) {
                    document.getElementById("ctl00_MyCPH1_CheckBoxList1_" + im).checked = false;
                }

            }
        }

        function CHKDKT2(val) {
            ij = "<%=chgV%>"

            var CHKDKT2 = document.getElementById("ctl00_MyCPH1_CHKDKT2");

            if (CHKDKT2.checked == true) {
                for (i = 0; i < ij; i++) {
                    document.getElementById("ctl00_MyCPH1_ChkAmtChrgDtl_" + i).checked = true;
                }
            }
            if (CHKDKT2.checked == false) {
                for (i = 0; i < ij; i++) {
                    document.getElementById("ctl00_MyCPH1_ChkAmtChrgDtl_" + i).checked = false;
                }

            }
        }

        function CHKDKT3(val) {
            var CHKDKT3 = document.getElementById("ctl00_MyCPH1_CHKDKT3");

            if (CHKDKT3.checked == true) {
                for (im = 0; im < 4; im++) {
                    document.getElementById("ctl00_MyCPH1_CheckBoxList3_" + im).checked = true;
                }
            }
            if (CHKDKT3.checked == false) {
                for (im = 0; im < 4; im++) {
                    document.getElementById("ctl00_MyCPH1_CheckBoxList3_" + im).checked = false;
                }

            }
        }

        function CHKDKT4(val) {
            var CHKDKT4 = document.getElementById("ctl00_MyCPH1_CHKDKT4");

            if (CHKDKT4.checked == true) {
                for (im = 0; im < 19; im++) {
                    document.getElementById("ctl00_MyCPH1_CheckBoxList4_" + im).checked = true;
                }
            }
            if (CHKDKT4.checked == false) {
                for (im = 0; im < 19; im++) {
                    document.getElementById("ctl00_MyCPH1_CheckBoxList4_" + im).checked = false;
                }
            }
        }

        function OnSub_DATACHECK() {
            // alert("HIii")
            if (!DateCheck())
                return false;


            // OnSub_Btn();
            //  alert("HIii")
            //if(!FinDateCheck())
            //    return false;
        }

   
    </script>
    <div align="left">
        <asp:HiddenField ID="hdnID" runat="server" />
        <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Sales & Expense Register</strong> </font>
                </td>
            </tr>
            <tr>
                <td class="horzblue">
                    <img src="./../../images/clear.gif" width="2" height="1">
                </td>
            </tr>
            <tr>
                <td align="right">
                    <font forecolor="white">Ver 2.1</font> <a href="javascript:window.history.go(-1)"
                        title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0">
                    </a>
                    <div align="Left">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="redfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                                <br />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" cellpadding="3" style="width: 9.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height:4 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Company Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Company Type" runat="server"></asp:Label>
                            </td>
                            <td align="left" valign="top">
                                <Company:CMPFT ID="CMPFT1" runat="server" />
                                <%-- <asp:RadioButtonList ID="documet_type" RepeatColumns="4" runat="server" RepeatDirection="horizontal"
                                    CssClass="blackfnt">
                                    <%--OnClick="Javascript:return SelectPartyCode()"--%>
                                <%--</asp:RadioButtonList>--%>
                            </td>
                        </tr>
                        <tr class="bgbluegrey">
                            <td align="center">
                                <font class="blackfnt">From</font>
                            </td>
                            <td align="center">
                                <font class="blackfnt">To</font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left">
                                <Location:HR ID="Fromlc" runat="server" />
                            </td>
                            <td align="left">
                                <Location_To:HR_To ID="Tolc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center">
                                <font class="blackfnt">Select </font>
                                <asp:DropDownList ID="DT_TYPE" runat="server">
                                    <asp:ListItem Text="Document Date" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="System Date" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Cancellation Date" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                                </font>
                            </td>
                            <td align="left">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="Left" colspan="2">
                                <font class="bluefnt"><i><b>Filters : -</b></i></font> <a href="Javascript:ShowDKTFilter();">
                                    <font class="bluefnt"><u><b>Show</b></u></font> </a><font class="blackfnt">/</font>
                                <a href="Javascript:HideDKTFilter();"><font class="bluefnt"><u><b>Hide</b></u></font>
                                </a>
                            </td>
                        </tr>
                        <%--Dockets Filter  Start--%>
                        <tr id="dkttr1" runat="server" style="background-color: white; display: none;">
                            <td align="left">
                                <font class="blackfnt">Select Paybas</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="cboPaybas" DataSourceID="MySQLDataSource_GeneralMaster2"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr2" runat="server" style="background-color: white; display: none;">
                            <td align="Left">
                                <font class="blackfnt">Select Mode</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="cboMode" DataSourceID="MySQLDataSource_GeneralMaster"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr3" runat="server" style="background-color: white; display: none;">
                            <td align="Left">
                                <font class="blackfnt">Select Service Type</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="cboType" DataSourceID="MySQLDataSource_GeneralMaster1"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr4" runat="server" style="background-color: white; display: none;">
                            <td align="Left">
                                <font class="blackfnt">Select Business Type</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="cboBUTType" DataSourceID="MySQLDataSource_GeneralMaster3"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr6" runat="server" style="background-color: white; display: none;">
                            <td align="Left">
                                <font class="blackfnt">Select Status</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="dllStatus" CssClass="blackfnt">
                                    <asp:ListItem Value="All" Text="--All--"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="Quick"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="Financial"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="Billed"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="Un Billed"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="MR - Generated"></asp:ListItem>
                                    <asp:ListItem Value="6" Text="MR - Not Generated"></asp:ListItem>
                                    <asp:ListItem Value="7" Text="Finalized"></asp:ListItem>
                                    <asp:ListItem Value="8" Text="UnFinalized"></asp:ListItem>
                                    <asp:ListItem Value="9" Text="Delivered"></asp:ListItem>
                                    <asp:ListItem Value="10" Text="Not Delivered"></asp:ListItem>
                                    <asp:ListItem Value="11" Text="Cancelled"></asp:ListItem>
                                    <asp:ListItem Value="12" Text="Detained"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr5" runat="server" align="left" style="background-color: white; display: none;">
                            <td align="left">
                                <asp:Label ID="Label1" CssClass="blackfnt" Text="Select Customer" runat="server"></asp:Label>
                            </td>
                            <td align="Left">
                                <asp:TextBox ID="txtCustomer" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                    type="button" onclick="cust('C');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <%--Dockets Filter  END THC Filter Start--%>
                        <tr id="thctr1" runat="server" style="background-color: white; display: none;">
                            <td align="Left">
                                <font class="blackfnt">Select Route</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="CboRoutes" DataSourceID="MySQLDataSource_Route"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="thctr2" runat="server" style="background-color: white; display: none;">
                            <td align="Left">
                                <font class="blackfnt">Select Status</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="CboStats">
                                    <asp:ListItem Value="All" Text="--All--"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="Contract Entry Made"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="Advance Made"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="Bill Entry Done"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="Financial Close"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="Cancelled"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="Vendtr1" runat="server" style="background-color: white; display: none;">
                            <td align="Left">
                                <font class="blackfnt">Select Vendor Type</font>
                            </td>
                            <td align="left">
                                <asp:DropDownList runat="server" ID="DllVendTy" DataSourceID="MySQLDataSource_GeneralMaster4"
                                    DataTextField="CodeDesc" DataValueField="CodeID">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="Vendtr2" runat="server" align="left" style="background-color: white; display: none;">
                            <td align="left">
                                <asp:Label ID="Label2" CssClass="blackfnt" Text="Select Vendor" runat="server"></asp:Label>
                            </td>
                            <td align="Left">
                                <asp:TextBox ID="txtVendor" Enabled="true" runat="server" Width="234"></asp:TextBox><input
                                    type="button" onclick="cust('V');" value="..." style="width: 18px; height: 21px"
                                    size="" />
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr runat="server" style="background-color: white; display: block;">
                            <td align="center" colspan="2">
                                <font class="blackboldfnt">OR</font>
                            </td>
                        </tr>
                        <tr runat="server" style="background-color: white; display: block;">
                            <td align="left">
                                <asp:Label ID="Labesys" CssClass="blackfnt" runat="server" Text=" Document No(s). (System Generated No.) :� "></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox runat="server" Text="" ID="txtsysno" Width="250"> </asp:TextBox>
                                <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="Left" colspan="2">
                                <font class="bluefnt"><i><b>Columns : -</b></i></font> <a href="Javascript:ShowDKTColumns();">
                                    <font class="bluefnt"><u><b>Show</b></u></font> </a><font class="blackfnt">/</font>
                                <a href="Javascript:HideDKTColumns();"><font class="bluefnt"><u><b>Hide</b></u></font>
                                </a>
                            </td>
                        </tr>
                        <tr id="dktcl1" runat="server" class="bgbluegrey" style="display: none;">
                            <td align="left">
                                <asp:Label ID="Labeldoc" runat="server" CssClass="blackfnt" Text="<b>AXB Details</b>"
                                    Width="111px"></asp:Label>
                            </td>
                            <td align="Left">
                                <asp:CheckBox Text="Select All " Font-Bold="true" CssClass="blackfnt" ID="CHKDKT1"
                                    onClick="CHKDKT1(this.value);" runat="server" />
                            </td>
                        </tr>
                        <tr id="dktcl2" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:CheckBoxList ID="CheckBoxList1" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal"
                                    RepeatColumns="5" TextAlign="right" Width="750px" CellPadding="3" CellSpacing="1">
                                    <asp:ListItem Selected="True" Value="dockno" Text="AXB No"></asp:ListItem>
                                    <asp:ListItem Value="docketDT" Selected="True" Text="AXB Date"></asp:ListItem>
                                    <asp:ListItem Value="orgncd" Text="Origin"></asp:ListItem>
                                    <asp:ListItem Value="destcd" Text="Dest."></asp:ListItem>
                                    <asp:ListItem Value="Curr_loc" Text="Current Loc"></asp:ListItem>
                                    <asp:ListItem Value="nextloc" Text="Next Loc"></asp:ListItem>
                                    <asp:ListItem Value="from_loc" Text="From"></asp:ListItem>
                                    <asp:ListItem Value="to_loc" Text="To"></asp:ListItem>
                                    <asp:ListItem Value="PAYTYP" Text="PayBasis"></asp:ListItem>
                                    <asp:ListItem Value="MODTYP" Text="Transport Mode"></asp:ListItem>
                                    <asp:ListItem Value="BKGTYP" Text="BookingType"></asp:ListItem>
                                    <asp:ListItem Value="LODTYP" Text="LoadType"></asp:ListItem>
                                    <asp:ListItem Value="BUSTYP" Text="BussinessType"></asp:ListItem>
                                    <asp:ListItem Value="PRODTYP" Text="ProductType"></asp:ListItem>
                                    <asp:ListItem Value="RSTYP" Text="RiskType"></asp:ListItem>
                                    <asp:ListItem Value="Cnor " Text="Consignor"></asp:ListItem>
                                    <asp:ListItem Value="Cnee " Text="Consignee"></asp:ListItem>
                                    <asp:ListItem Value="BACode " Text="BA Code"></asp:ListItem>
                                    <asp:ListItem Value="PkgsNo " Text="PkgsNo"></asp:ListItem>
                                    <asp:ListItem Value="Actuwt " Text="ActualWt"></asp:ListItem>
                                    <asp:ListItem Value="ChrgWt " Text="ChrgWt"></asp:ListItem>
                                    <asp:ListItem Value="Yield" Text="Yield"></asp:ListItem>
                                    <asp:ListItem Value="FRT_Rate" Text="FRTRate"></asp:ListItem>
                                    <asp:ListItem Value="subtotal" Text="SubTotal"></asp:ListItem>
                                    <asp:ListItem Value="svctax " Text="S.tax"></asp:ListItem>
                                    <asp:ListItem Value="Cess" Text="Cess"></asp:ListItem>
                                    <asp:ListItem Value="hedu_cess" Text="H.Cess"></asp:ListItem>
                                    <asp:ListItem Value="dkttot" Text="AXB Total"></asp:ListItem>
                                    <asp:ListItem Value="Delivered" Text="Delievered"></asp:ListItem>
                                    <asp:ListItem Value="cdeldt" Text="EDD"></asp:ListItem>
                                    <asp:ListItem Value="DELDT" Text="Dely. Date"></asp:ListItem>
                                    <asp:ListItem Value="UNDELR" Text="Undely Reason"></asp:ListItem>
                                    <asp:ListItem Value="MR" Text="MR Generated"></asp:ListItem>
                                    <asp:ListItem Value="CAN" Text="Cancelled"></asp:ListItem>
                                    <asp:ListItem Value="spl_svc_req" Text="Special Ins."></asp:ListItem>
                                    <asp:ListItem Value="VEHNO" Text="Vehicle No."></asp:ListItem>
                                    <asp:ListItem Value="AWBNO" Text="AWBNO"></asp:ListItem>
                                    <asp:ListItem Value="Status" Text="Operation Status"></asp:ListItem>
                                    <asp:ListItem Value="finalize" Text="Finalize Status"></asp:ListItem>
                                    <asp:ListItem Value="InvAmt" Text="Declared Cargo Value"></asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr id="dktcl3" runat="server" style="display: none;" class="bgbluegrey">
                            <td align="left">
                                <asp:Label ID="Label17" runat="server" CssClass="blackfnt" Text="<b>Amount & Charges Details</b>"
                                    Width="186px"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox Text="Select All" Font-Bold="true" CssClass="blackfnt" ID="CHKDKT2"
                                    runat="server" onClick="CHKDKT2(this.value);" Width="100%" />
                            </td>
                        </tr>
                        <tr id="dktcl4" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:CheckBoxList ID="ChkAmtChrgDtl" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal"
                                    RepeatColumns="4" TextAlign="Right" Width="750px" CellPadding="3" CellSpacing="1">
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr id="dktcl5" runat="server" style="display: none;" class="bgbluegrey">
                            <td align="left">
                                <asp:Label ID="Label16" runat="server" CssClass="blackfnt" Text="<b>Invoice & PFM Details</b>"
                                    Width="153px"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox Text="Select All" Font-Bold="true" CssClass="blackfnt" ID="CHKDKT3"
                                    runat="server" onClick="CHKDKT3(this.value);" Width="100%" />
                            </td>
                        </tr>
                        <tr id="dktcl6" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:CheckBoxList ID="CheckBoxList3" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal"
                                    RepeatColumns="5" TextAlign="right" Width="750px" CellPadding="3" CellSpacing="1">
                                    <asp:ListItem Value="invno" Text="Invoice No"></asp:ListItem>
                                    <asp:ListItem Value="invdt" Text="Inv Date"></asp:ListItem>
                                    <asp:ListItem Value="invamt" Text="Inv Amt"></asp:ListItem>
                                    <asp:ListItem Value="PFMno" Enabled="false" Text="PFM No./Date"></asp:ListItem>
                                    <%--<asp:ListItem Value="dockno" Text="View POD"></asp:ListItem>
                                  <asp:ListItem Value="PFMRECDT" Text="PFM Rec. Date"></asp:ListItem>--%>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr id="dktcl7" runat="server" style="display: none;" class="bgbluegrey">
                            <td align="left">
                                <asp:Label ID="Labemrbill" runat="server" CssClass="blackfnt" Text="<b>MR & Bill Details</b>"
                                    Width="178px"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox Text="Select All" Font-Bold="true" CssClass="blackfnt" ID="CHKDKT4"
                                    runat="server" onClick="CHKDKT4(this.value);" Width="100%" />
                            </td>
                        </tr>
                        <tr id="dktcl8" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:CheckBoxList ID="CheckBoxList4" RepeatColumns="5" TextAlign="Right" runat="server"
                                    CssClass="blackfnt" RepeatDirection="Horizontal" Width="750px" CellPadding="3"
                                    CellSpacing="1">
                                    <asp:ListItem Value="MRSNo" Text="MR No"></asp:ListItem>
                                    <asp:ListItem Value="MAN_MRNO" Text="Manual MR No"></asp:ListItem>
                                    <asp:ListItem Value="mrsdt" Text="MR Date"></asp:ListItem>
                                    <asp:ListItem Value="mrsbr" Text="MRGenAt"></asp:ListItem>
                                    <asp:ListItem Value="mrsamt" Text="MR Amt"></asp:ListItem>
                                    <asp:ListItem Value="MRCLDT" Text="MR Close Date"></asp:ListItem>
                                    <asp:ListItem Value="MRSTATUS" Text="MR Status"></asp:ListItem>
                                    <asp:ListItem Value="BillNo" Text="Bill No"></asp:ListItem>
                                    <asp:ListItem Value="manualbillno" Text="Manual Bill No"></asp:ListItem>
                                    <asp:ListItem Value="BParty" Text="Bill Party"></asp:ListItem>
                                    <asp:ListItem Value="fincmplbr" Text="BillGenAt"></asp:ListItem>
                                    <asp:ListItem Value="bgndt" Text="BillDate"></asp:ListItem>
                                    <asp:ListItem Value="billsubbrcd" Text="BillSubAt"></asp:ListItem>
                                    <asp:ListItem Value="BillSUBDT" Text="BillSubDate"></asp:ListItem>
                                    <asp:ListItem Value="billcolbrcd" Text="BillCollAt"></asp:ListItem>
                                    <asp:ListItem Value="BillCLDT" Text="BillCollDate"></asp:ListItem>
                                    <asp:ListItem Value="BillAmt" Text="Bill Amt"></asp:ListItem>
                                    <asp:ListItem Value="PENDAMT" Text="Bill Pend Amt"></asp:ListItem>
                                    <asp:ListItem Value="billstatus" Text="Bill Status"></asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr id="thccl1" runat="server" class="bgbluegrey" style="display: none;">
                            <td align="left">
                                <asp:Label ID="lblthc1" runat="server" CssClass="blackfnt" Text="<b>Document Details</b>"
                                    Width="178px"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox ID="THCHK1" runat="server" CssClass="blackfnt" onclick="THCHK1(this.value);"
                                    Text="Select All" Width="100%"></asp:CheckBox>
                            </td>
                        </tr>
                        <tr id="thccl2" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:CheckBoxList ID="THCCHKLIST1" runat="server" CellPadding="2" CellSpacing="2"
                                    CssClass="blackfnt" RepeatColumns="5" RepeatDirection="Horizontal" TextAlign="Right"
                                    Width="750px">
                                    <asp:ListItem Value="thcno" Text="Document No."></asp:ListItem>
                                    <asp:ListItem Value="manualthcno" Text="Manual Document No."></asp:ListItem>
                                    <asp:ListItem Value="tripsheetno" Text="TripSheet No."></asp:ListItem>
                                    <asp:ListItem Value="thc_dt" Text="Date"></asp:ListItem>
                                    <asp:ListItem Value="thcbr" Text="Location"></asp:ListItem>
                                    <asp:ListItem Value="routename" Text="Route"></asp:ListItem>
                                    <asp:ListItem Value="vehno" Text="Vehichle No."></asp:ListItem>
                                    <%--<asp:ListItem Value="thcno" Text="Vehichle Type"></asp:ListItem>--%>
                                    <asp:ListItem Value="vendtype" Text="Vendor Type"></asp:ListItem>
                                    <asp:ListItem Value="vendor_name" Text="Vendor Name"></asp:ListItem>
                                    <asp:ListItem Value="cancelled" Text="Cancelled"></asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr id="thccl3" runat="server" class="bgbluegrey" style="display: none;">
                            <td align="left" valign="top">
                                <asp:Label ID="lblthc2" runat="server" CssClass="blackfnt" Text="<b>Financial Details- Advance</b>"
                                    Width="178px"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox ID="THCHK2" runat="server" CssClass="blackfnt" onclick="THCHK2(this.value);"
                                    Text="Select All" Width="100%"></asp:CheckBox>
                            </td>
                        </tr>
                        <tr id="thccl4" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:CheckBoxList ID="THCCHKLIST2" runat="server" CellPadding="2" CellSpacing="2"
                                    CssClass="blackfnt" RepeatColumns="5" RepeatDirection="Horizontal" TextAlign="Right"
                                    Width="750px">
                                    <asp:ListItem Value="pcamt" Text="Contract Amount"></asp:ListItem>
                                    <asp:ListItem Value="advamt " Text="Adv Amount"></asp:ListItem>
                                    <asp:ListItem Value="advamt_lastpaid" Text="Advance Paid"></asp:ListItem>
                                    <%-- <asp:ListItem Value="adv_colamt" Text="Advance Paid"></asp:ListItem>--%>
                                    <asp:ListItem Value="TOTALAMTPAID" Text="Toal Amount"></asp:ListItem>
                                    <asp:ListItem Value="advpaidby" Text="Advance Paid by"></asp:ListItem>
                                    <asp:ListItem Value="advpaidat" Text="Advance Paid At"></asp:ListItem>
                                    <asp:ListItem Value="advvoucherNo" Text="Advance Voucher No."></asp:ListItem>
                                    <asp:ListItem Value="advpaiddt" Text="Advance Payment Date."></asp:ListItem>
                                    <asp:ListItem Value="(pcamt-advamt) as due" Text="Due Amount"></asp:ListItem>
                                    <asp:ListItem Value="othamt" Text="Other Amount"></asp:ListItem>
                                    <asp:ListItem Value="totcontamt" Text="Tot Contract Amount"></asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr id="thccl5" runat="server" class="bgbluegrey" style="display: none;">
                            <td align="left" valign="top">
                                <asp:Label ID="lblthc3" runat="server" CssClass="blackfnt" Text="<b>Financial Details- Balance</b>"
                                    Width="178px"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox ID="THCHK3" runat="server" CssClass="blackfnt" onclick="THCHK3(this.value);"
                                    Text="Select All" Width="100%"></asp:CheckBox>
                            </td>
                        </tr>
                        <tr id="thccl6" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:CheckBoxList ID="THCCHKLIST3" runat="server" CellPadding="2" CellSpacing="2"
                                    CssClass="blackfnt" RepeatColumns="5" RepeatDirection="Horizontal" TextAlign="Right"
                                    Width="750px">
                                    <asp:ListItem Value="dclaim" Text="Claims"></asp:ListItem>
                                    <asp:ListItem Value="oth_ded" Text="Deductions"></asp:ListItem>
                                    <asp:ListItem Value="incentive" Text="Incentive"></asp:ListItem>
                                    <asp:ListItem Value="penalty" Text="Penalty"></asp:ListItem>
                                    <asp:ListItem Value="tds_chrg" Text="TDS"></asp:ListItem>
                                    <asp:ListItem Value="load_chrg" Text="Loading Charge"></asp:ListItem>
                                    <asp:ListItem Value="netbalamt" Text="Balance Amt"></asp:ListItem>
                                    <asp:ListItem Value="balpaidby" Text="Balance Paid By"></asp:ListItem>
                                    <asp:ListItem Value="balamtbrcd" Text="Balanace Paid At"></asp:ListItem>
                                    <asp:ListItem Value="balvoucherNo" Text="Balance Payment Voucher Number"></asp:ListItem>
                                    <asp:ListItem Value="balvoucherdt" Text="Balance Payment Date."></asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr id="thccl7" runat="server" class="bgbluegrey" style="display: none;">
                            <td align="left" valign="top">
                                <asp:Label ID="lblthc4" runat="server" CssClass="blackfnt" Text="<b>Financial Details- Bill Entry </b>"
                                    Width="178px"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox ID="THCHK4" runat="server" CssClass="blackfnt" onclick="THCHK4(this.value);"
                                    Text="Select All" Width="100%"></asp:CheckBox>
                            </td>
                        </tr>
                        <tr id="thccl8" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:CheckBoxList ID="THCCHKLIST4" runat="server" CellPadding="2" CellSpacing="2"
                                    CssClass="blackfnt" RepeatColumns="5" RepeatDirection="Horizontal" TextAlign="Right"
                                    Width="750px">
                                    <asp:ListItem Value="billdt" Text="Bill Entry Date"></asp:ListItem>
                                    <asp:ListItem Value="vendorBENo" Text="Bill Entry Number"></asp:ListItem>
                                    <asp:ListItem Value="vendorbillNo" Text="Vendor Bill Number"></asp:ListItem>
                                    <asp:ListItem Value="billamt" Text="Vendor Bill Number"></asp:ListItem>
                                    <asp:ListItem Value="voucherno" Text="Payment Voucher Number"></asp:ListItem>
                                    <asp:ListItem Value="PaymentDt" Text="Payment Date  "></asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr id="thccl9" runat="server" class="bgbluegrey" style="display: none;">
                            <td align="left" valign="top">
                                <asp:Label ID="lblthc5" runat="server" CssClass="blackfnt" Text="<b>AXB Details</b>"
                                    Width="178px"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox ID="THCHK5" runat="server" CssClass="blackfnt" onclick="THCHK5(this.value);"
                                    Text="Select All" Width="100%"></asp:CheckBox>
                            </td>
                        </tr>
                        <tr id="thccl10" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:CheckBoxList ID="THCCHKLIST5" runat="server" CellPadding="2" CellSpacing="2"
                                    CssClass="blackfnt" RepeatColumns="5" RepeatDirection="Horizontal" TextAlign="Right"
                                    Width="750px">
                                    <asp:ListItem Value="Total_docket" Text="Number of Cnotes Moved"></asp:ListItem>
                                    <asp:ListItem Value="MyActualWt" Text="Total Actual Weight"></asp:ListItem>
                                    <asp:ListItem Value="Total_freight_dkt" Text="Total Freight"></asp:ListItem>
                                    <asp:ListItem Value="dept_dt" Text="Dep. Date"></asp:ListItem>
                                    <asp:ListItem Value="dept_tm" Text="Dep. Time"></asp:ListItem>
                                    <asp:ListItem Value="arrv_dt" Text="Arrv. date  "></asp:ListItem>
                                    <asp:ListItem Value="arrv_tm" Text="Arrv. Time"></asp:ListItem>
                                    <asp:ListItem Value="OPENKM" Text="Start KM"></asp:ListItem>
                                    <asp:ListItem Value="CLOSEKM" Text="Close KM"></asp:ListItem>
                                    <asp:ListItem Value="Dist" Text="Travel Distance"></asp:ListItem>
                                    <asp:ListItem Value="capacity" Text="Capacity"></asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <%--<tr style="background-color: white">
                            <td colspan="7" align="center" style="height: 21px">
                                <asp:RadioButtonList ID="rptfrt" RepeatDirection="horizontal" CssClass="blackfnt"
                                    runat="server">
                                    <asp:ListItem Selected="True" Text="HTML Format" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="XLS Download" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="CSV Download" Value="3"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>--%>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return OnSub_DATACHECK();"
                                    runat="server" Text="Submit" Width="75px" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
