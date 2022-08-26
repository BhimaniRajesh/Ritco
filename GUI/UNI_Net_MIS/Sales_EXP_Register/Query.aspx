<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_Sales_EXP_Register_Query" %>

<%@ Register TagName="HR" TagPrefix="Location" Src="~/GUI/Common_UserControls/LOC_HRCHY.ascx" %>
<%@ Register TagName="HR_To" TagPrefix="Location_To" Src="~/GUI/Common_UserControls/LOC_HRCHY_TO.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
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
    <asp:SqlDataSource ID="MySQLDataSource_BKGCHARGES" runat="server" SelectCommand="WEbxnet_Sales_Chrges_RPT"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="BUT" Type="String" DefaultValue="All" ControlID="cboBUTType" />
            <asp:Parameter Name="TYP" Type="String" DefaultValue="P" />
            <asp:Parameter Name="BD_TYP" Type="String" DefaultValue="N" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_DLYCHARGES" runat="server" SelectCommand="WEbxnet_Sales_Chrges_RPT"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter Name="BUT" Type="String" DefaultValue="Alll" ControlID="cboBUTType" />
            <asp:Parameter Name="TYP" Type="String" DefaultValue="P" />
            <asp:Parameter Name="BD_TYP" Type="String" DefaultValue="Y" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Route" runat="server" SelectCommand="WebxNet_Routes_Report"
        SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

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

            var DOCTYP = document.getElementById("ctl00_MyCPH1_documet_type");
            // alert(DOCTYP)
            // alert(DOCTYP.value)

            //if (DOCTYP.value == "DKT") {
            for (dkt = 1; dkt < 6; dkt++) {

                document.getElementById('ctl00_MyCPH1_dkttr' + dkt).style.display = "block";
            }
            //}


        }
        function HideDKTFilter() {

            for (dkt = 1; dkt < 6; dkt++) {

                document.getElementById('ctl00_MyCPH1_dkttr' + dkt).style.display = "none";
            }

        }


        function ShowDKTColumns() {
            var DOCTYP = document.getElementById("ctl00_MyCPH1_documet_type");

            if (DOCTYP.value == "DKT") {
                for (dkt = 1; dkt < 7; dkt++) {
                    document.getElementById('ctl00_MyCPH1_dktcl' + dkt).style.display = "block";
                }
            }

        }
        function HideDKTColumns() {
            var DOCTYP = document.getElementById("ctl00_MyCPH1_documet_type");


            for (dkt = 1; dkt < 7; dkt++) {
                document.getElementById('ctl00_MyCPH1_dktcl' + dkt).style.display = "none";
            }
            if (DOCTYP.value != "DKT") {
                for (thc = 1; thc < 11; thc++) {
                    document.getElementById('ctl00_MyCPH1_thccl' + thc).style.display = "none";
                }
            }

        }

        function ShowDKTMRColumns() {
            var DOCTYP = document.getElementById("ctl00_MyCPH1_documet_type");

            if (DOCTYP.value == "DKT") {
                for (dkt = 7; dkt < 11; dkt++) {
                    document.getElementById('ctl00_MyCPH1_dktcl' + dkt).style.display = "block";
                }
            }

        }
        function HideDKTMRColumns() {
            var DOCTYP = document.getElementById("ctl00_MyCPH1_documet_type");


            for (dkt = 7; dkt < 11; dkt++) {
                document.getElementById('ctl00_MyCPH1_dktcl' + dkt).style.display = "none";
            }
            if (DOCTYP.value != "DKT") {
                for (thc = 5; thc < 9; thc++) {
                    document.getElementById('ctl00_MyCPH1_thccl' + thc).style.display = "none";
                }
            }
        }


        function CHKDKT1(val) {
            var CHKDKT1 = document.getElementById("ctl00_MyCPH1_CHKDKT1");

            if (CHKDKT1.checked == true) {
                for (im = 0; im < 47; im++) {
                    document.getElementById("ctl00_MyCPH1_CheckBoxList1_" + im).checked = true;
                }
            }
            if (CHKDKT1.checked == false) {
                for (im = 0; im < 47; im++) {
                    document.getElementById("ctl00_MyCPH1_CheckBoxList1_" + im).checked = false;
                }

            }
        }

        function CHKDKT2() {
            // alert("Hii")
            var chk = null;
            var i = 0;
            var chkall = document.getElementById("ctl00_MyCPH1_CHKDKT2");

            do {
                chk = document.getElementById("ctl00_MyCPH1_ChkAmtChrgDtl_" + i + "");

                if (chk) {

                    // alert(chk.disabled)                           
                    if (chkall.checked == true) {
                        chk.checked = true;
                    }
                    else {
                        chk.checked = false;
                    }
                }
                i++;
            } while (chk);
            return true;
        }

        function CHKDKT2a() {
            // alert("Hii")
            var chk = null;
            var i = 0;
            var chkall = document.getElementById("ctl00_MyCPH1_CHKDKT2a");

            do {
                chk = document.getElementById("ctl00_MyCPH1_ChkAmtChrgDt2_" + i + "");

                if (chk) {

                    // alert(chk.disabled)                           
                    if (chkall.checked == true) {
                        chk.checked = true;
                    }
                    else {
                        chk.checked = false;
                    }
                }
                i++;
            } while (chk);
            return true;
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
            //alert("HIii")
            if (!DateCheck())
                return false;
            //  alert("HIii")
            //if(!FinDateCheck())
            //    return false;             
        }
        
    </script>
   <input type="hidden" id="hdnRptId" runat="server" /> <%-- added by Manisha 23/5/2014 --%>

    <div align="left">
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
                    <%--<img src="./../../images/clear.gif" width="2" height="1">--%>
                </td>
            </tr>
            <tr>
                <td align="right">
                    <a href="javascript:window.history.go(-1)" title="back">
                        <img alt="Back" src="./../../images/back.gif" border="0">
                    </a>&nbsp;<div align="Left">
                        <asp:UpdateProgress ID="uppMain" runat="server">
                            <ProgressTemplate>
                                <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                                    -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                                    <tr>
                                        <td align="right">
                                            <img id="Img1" src="./../../images/loading.gif" runat="server" />
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
                    </div>
                </td>
            </tr>
            <tr>
                <td height="300" valign="top">
                    <table cellspacing="1" cellpadding="3" style="width: 9.5in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="2" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Documnets Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                            <td align="left">
                                <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Document Type" runat="server"></asp:Label>
                            </td>
                            <td align="left" valign="top">
                                <asp:DropDownList ID="documet_type" runat="server" OnChange="Javascript:return SelectDOC();">
                                </asp:DropDownList>
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
                        <tr id="dkttr41" runat="server" style="background-color: white; display: block;">
                            <td align="Left">
                                <font class="blackfnt">Select Business Type</font>
                            </td>
                            <td align="left">
                                <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList runat="server" ID="cboBUTType" DataSourceID="MySQLDataSource_GeneralMaster3"
                                            AutoPostBack="true" DataTextField="CodeDesc" DataValueField="CodeID">
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
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
                        <tr id="dkttr5" runat="server" style="background-color: white; display: none;">
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
                                    <%--<asp:ListItem  Value="7" Text="Octroi Paid"></asp:ListItem>
                                <asp:ListItem  Value="8" Text="Octroi Not Paid"></asp:ListItem>--%>
                                    <asp:ListItem Value="9" Text="Delivered"></asp:ListItem>
                                    <asp:ListItem Value="10" Text="Not Delivered"></asp:ListItem>
                                    <asp:ListItem Value="11" Text="Cancelled"></asp:ListItem>
                                    <asp:ListItem Value="12" Text="Detained"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="dkttr4" runat="server" align="left" style="background-color: white; display: none;">
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
                                <font class="bluefnt"><i><b>
                                    <%=Session["DocketCalledAs"]%>
                                    Details Columns : -</b></i></font> <a href="Javascript:ShowDKTColumns();"><font class="bluefnt">
                                        <u><b>Show</b></u></font> </a><font class="blackfnt">/</font> <a href="Javascript:HideDKTColumns();">
                                            <font class="bluefnt"><u><b>Hide</b></u></font> </a>
                            </td>
                        </tr>
                        <tr id="dktcl1" runat="server" class="bgbluegrey" style="display: none;">
                            <td align="left">
                                <asp:Label ID="Labeldoc" runat="server" CssClass="blackfnt" Text="<b>Docket Details</b>"
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
                                    <asp:ListItem Selected="True" Value="dockno" Text="Docket No"></asp:ListItem>
                                    <%--added by amol--%>
                                    <asp:ListItem Value="DOCKDT_Entry" Selected="True" Text="Docket System Date"></asp:ListItem>
                                    <asp:ListItem Value="ENTRYBY" Text="Entry By"></asp:ListItem>
                                    <%--added by amol--%>
                                    <asp:ListItem Value="docketDT" Selected="True" Text="Docket Date"></asp:ListItem>
                                    <asp:ListItem Value="orgncd" Text="Origin"></asp:ListItem>
                                    <asp:ListItem Value="Destcd" Text="Destination"></asp:ListItem>
                                    <asp:ListItem Value="Curr_loc" Text="Current Location"></asp:ListItem>
                                    <asp:ListItem Value="nextloc" Text="Next Location"></asp:ListItem>
                                    <asp:ListItem Value="from_loc" Text="From"></asp:ListItem>
                                    <asp:ListItem Value="to_loc" Text="To"></asp:ListItem>
                                    <asp:ListItem Value="PAYTYP" Text="Payment Basis"></asp:ListItem>
                                    <asp:ListItem Value="MODTYP" Text="Transport Mode"></asp:ListItem>
                                    <asp:ListItem Value="BKGTYP" Text="Booking Type"></asp:ListItem>
                                    <asp:ListItem Value="LODTYP" Text="Load Type"></asp:ListItem>
                                    <asp:ListItem Value="BUSTYP" Text="Bussiness Type"></asp:ListItem>
                                    <asp:ListItem Value="PRODTYP" Text="Product Type"></asp:ListItem>
                                    <asp:ListItem Value="PKGSTYP" Text="Packaging Type"></asp:ListItem>
                                    <asp:ListItem Value="RSTYP" Text="Risk Type"></asp:ListItem>
                                    <asp:ListItem Value="Rate_Type" Text="Rate Type"></asp:ListItem>
                                    <asp:ListItem Value="Cnor " Text="Consignor "></asp:ListItem>
                                    <asp:ListItem Value="Cnee " Text="Consignee "></asp:ListItem>
                                    <asp:ListItem Value="privatemark" Text="Private Mark"></asp:ListItem>
                                    <asp:ListItem Value="BACode " Text="BA Code "></asp:ListItem>
                                    <asp:ListItem Value="PkgsNo " Text="Pkgs. No. "></asp:ListItem>
                                    <asp:ListItem Value="Actuwt " Text="Actual Wt. "></asp:ListItem>
                                    <asp:ListItem Value="ChrgWt " Text="Chrg Wt."></asp:ListItem>
                                    <asp:ListItem Value="Yield" Text="Yield"></asp:ListItem>
                                    <asp:ListItem Value="FRT_Rate" Text="FRT Rate"></asp:ListItem>
                                    <asp:ListItem Value="subtotal" Text="Sub Total"></asp:ListItem>
                                    <asp:ListItem Value="svctax " Text="S.tax"></asp:ListItem>
                                    <asp:ListItem Value="Cess" Text="Cess"></asp:ListItem>
                                    <asp:ListItem Value="hedu_cess" Text="H.Cess"></asp:ListItem>
                                    <asp:ListItem Value="dkttot" Text="Docket Total"></asp:ListItem>
                                    <asp:ListItem Value="Delivered" Text="Delievered"></asp:ListItem>
                                    <asp:ListItem Value="cdeldt" Text="EDD"></asp:ListItem>
                                    <asp:ListItem Value="DELDT" Text="Dely. Date"></asp:ListItem>
                                    <asp:ListItem Value="UNDELR" Text="Undelivery Reason"></asp:ListItem>
                                    <asp:ListItem Value="MR" Text="MR Generated"></asp:ListItem>
                                    <asp:ListItem Value="CAN" Text="Cancelled"></asp:ListItem>
                                    <asp:ListItem Value="spl_svc_req" Text="Special Instruction"></asp:ListItem>
                                    <asp:ListItem Value="VEHNO" Text="Vehicle No."></asp:ListItem>
                                    <asp:ListItem Value="Status" Text="Status"></asp:ListItem>
                                    <asp:ListItem Value="freight" Text="Basic Freight"></asp:ListItem>
                                    <asp:ListItem Value="PolicyNo" Text="Policy No"></asp:ListItem>
                                    <asp:ListItem Value="PolicyDate" Text="Policy Date"></asp:ListItem>
									<asp:ListItem Value="CSGEADDR" Text="Consinee Address"></asp:ListItem>
                                    <asp:ListItem Value="CSGETeleNo" Text="Consinee Telephone"></asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr id="dktcl3" runat="server" style="display: none;" class="bgbluegrey">
                            <td align="left">
                                <asp:Label ID="Label17" runat="server" CssClass="blackfnt" Text="<b>Booking Charges Details</b>"
                                    Width="186px"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox Text="Select All" Font-Bold="true" CssClass="blackfnt" ID="CHKDKT2"
                                    runat="server" onClick="CHKDKT2(this.value);" Width="100%" />
                            </td>
                        </tr>
                        <tr id="dktcl4" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:UpdatePanel ID="upTHCCreate" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:CheckBoxList ID="ChkAmtChrgDtl" DataSourceID="MySQLDataSource_BKGCHARGES" DataTextField="codedesc"
                                            DataValueField="codeid" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal"
                                            RepeatColumns="4" TextAlign="Right" Width="750px" CellPadding="3" CellSpacing="1">
                                        </asp:CheckBoxList>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cboBUTType" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr id="dktcl5" runat="server" style="display: none;" class="bgbluegrey">
                            <td align="left">
                                <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Text="<b>Delivery Charges Details</b>"
                                    Width="186px"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox Text="Select All" Font-Bold="true" CssClass="blackfnt" ID="CHKDKT2a"
                                    runat="server" onClick="CHKDKT2a(this.value);" Width="100%" />
                            </td>
                        </tr>
                        <tr id="dktcl6" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:UpdatePanel ID="aa" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>
                                        <asp:CheckBoxList ID="ChkAmtChrgDt2" DataSourceID="MySQLDataSource_DLYCHARGES" DataTextField="codedesc"
                                            DataValueField="codeid" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal"
                                            RepeatColumns="4" TextAlign="Right" Width="750px" CellPadding="3" CellSpacing="1">
                                        </asp:CheckBoxList>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:AsyncPostBackTrigger ControlID="cboBUTType" EventName="SelectedIndexChanged" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="Left" colspan="2">
                                <font class="bluefnt"><i><b>
                                    <%=Session["DocketCalledAs"]%>
                                    Invoice / PFM / MR / Bill Details Columns : -</b></i></font> <a href="Javascript:ShowDKTMRColumns();">
                                        <font class="bluefnt"><u><b>Show</b></u></font> </a><font class="blackfnt">/</font>
                                <a href="Javascript:HideDKTMRColumns();"><font class="bluefnt"><u><b>Hide</b></u></font>
                                </a>
                            </td>
                        </tr>
                        <tr id="dktcl7" runat="server" style="display: none;" class="bgbluegrey">
                            <td align="left">
                                <asp:Label ID="Label16" runat="server" CssClass="blackfnt" Text="<b>Invoice & PFM Details</b>"
                                    Width="153px"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox Text="Select All" Font-Bold="true" CssClass="blackfnt" ID="CHKDKT3"
                                    runat="server" onClick="CHKDKT3(this.value);" Width="100%" />
                            </td>
                        </tr>
                        <tr id="dktcl8" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:CheckBoxList ID="CheckBoxList3" runat="server" CssClass="blackfnt" RepeatDirection="Horizontal"
                                    RepeatColumns="5" TextAlign="right" Width="750px" CellPadding="3" CellSpacing="1">
                                    <asp:ListItem Value="invno" Text="Invoice No"></asp:ListItem>
                                    <asp:ListItem Value="invdt" Text="Invoice Date"></asp:ListItem>
                                    <asp:ListItem Value="invamt" Text="Invoice Amt"></asp:ListItem>
                                    <asp:ListItem Value="PFMno" Enabled="false" Text="PFM No./Date"></asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr id="dktcl9" runat="server" style="display: none;" class="bgbluegrey">
                            <td align="left">
                                <asp:Label ID="Labemrbill" runat="server" CssClass="blackfnt" Text="<b>MR & Bill Details</b>"
                                    Width="178px"></asp:Label>
                            </td>
                            <td align="left">
                                <asp:CheckBox Text="Select All" Font-Bold="true" CssClass="blackfnt" ID="CHKDKT4"
                                    runat="server" onClick="CHKDKT4(this.value);" Width="100%" />
                            </td>
                        </tr>
                        <tr id="dktcl10" runat="server" style="background-color: white; display: none;">
                            <td align="left" colspan="2">
                                <asp:CheckBoxList ID="CheckBoxList4" RepeatColumns="5" TextAlign="Right" runat="server"
                                    CssClass="blackfnt" RepeatDirection="Horizontal" Width="750px" CellPadding="3"
                                    CellSpacing="1">
                                    <asp:ListItem Value="MRSNo" Text="MR No"></asp:ListItem>
                                    <asp:ListItem Value="MAN_MRNO" Text="Manual MR No"></asp:ListItem>
                                    <asp:ListItem Value="mrsdt" Text="MR Date"></asp:ListItem>
                                    <asp:ListItem Value="mrsbr" Text="MR Gen. At"></asp:ListItem>
                                    <asp:ListItem Value="mrsamt" Text="MR Amount"></asp:ListItem>
                                    <asp:ListItem Value="MRCLDT" Text="MR Close Date"></asp:ListItem>
                                    <asp:ListItem Value="MRSTATUS" Text="MR Status"></asp:ListItem>
                                    <asp:ListItem Value="BillNo" Text="Bill No"></asp:ListItem>
                                    <asp:ListItem Value="manualbillno" Text="Manual Bill No"></asp:ListItem>
                                    <asp:ListItem Value="BParty" Text="Bill Party"></asp:ListItem>
                                    <asp:ListItem Value="fincmplbr" Text="Bill Gen. At"></asp:ListItem>
                                    <asp:ListItem Value="bgndt" Text="Bill Date"></asp:ListItem>
                                    <asp:ListItem Value="billsubbrcd" Text="Bill Sub. At"></asp:ListItem>
                                    <asp:ListItem Value="BillSUBDT" Text="Bill Sub. Date"></asp:ListItem>
                                    <asp:ListItem Value="billcolbrcd" Text="Bill Coll. At"></asp:ListItem>
                                    <asp:ListItem Value="BillCLDT" Text="Bill Coll. Date"></asp:ListItem>
                                    <asp:ListItem Value="BillAmt" Text="Bill Amount"></asp:ListItem>
                                    <asp:ListItem Value="PENDAMT" Text="Bill Pending Amount"></asp:ListItem>
                                    <asp:ListItem Value="billstatus" Text="Bill Status"></asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                        </tr>
                        <tr align="center" bgcolor="white">
                            <td colspan="7">
                                <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return OnSub_DATACHECK();"
                                    runat="server" Text="Submit" Width="75px" />
                                <asp:Button ID="btnDownload" runat="server" OnClick="btnDownload_Click" CssClass="hbtn"  Text="Download CSV" />
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
