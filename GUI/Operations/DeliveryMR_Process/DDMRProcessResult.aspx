<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="DDMRProcessResult.aspx.cs" Inherits="GUI_Operations_DocketNonDeliveryUpdate_DocketNonDeliveryCriteria" %>

<%@ Register Src="~/GUI/Common_UserControls/AutoComplete/CRM.ascx" TagName="WebxComplete"
    TagPrefix="xac" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_Vendors" runat="server" SelectCommand="usp_Vendors"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVendorType" DefaultValue="" Name="vendor_type"
                Type="string" />
            <asp:ControlParameter ControlID="hBrCd" DefaultValue="" Name="brcd" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_VendorTypes" runat="server" SelectCommand="uspVendorTypes"
        SelectCommandType="StoredProcedure">
        <%--<SelectParameters>
            <asp:ControlParameter DefaultValue="B" Name="" Type="string" />
        </SelectParameters>--%>
    </asp:SqlDataSource>

    <script language="JavaScript" src="../../images/CalendarPopup.js" type="text/javascript"></script>
    <script language="javascript" src="../../images/commonJs.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>

    <script language="JavaScript" type="text/javascript">

        var cal = new CalendarPopup("Div1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
        var months = new Array("", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
        var FinYear = "<%=Session["FinYear"]%>";
        var FinYear_to = parseInt(FinYear) + 1;

        if (FinYear_to < 10) {
            FinYear_to = "0" + FinYear_to;
        }
        var FinYear_fromdate = "01/04/" + FinYear;
        var FinYear_todate = "31/03/" + FinYear_to;


        function OnSub_Step1() {
            //alert("H");
            //alert(document.getElementById("ctl00_MyCPH1_GV_DDMRList"));
            document.getElementById("ctl00_MyCPH1_ButStep1").disabled = false;
            var tbl = document.getElementById("ctl00_MyCPH1_GV_DDMRList");
            var Totalcount = tbl.rows.length;
            var Check_flag = "N";
            for (i = 2; i <= Totalcount; i++) {
                if (i < 10) {
                    if (document.getElementById("ctl00_MyCPH1_GV_DDMRList_ctl0" + i + "_Chk_Docno").checked == true) {
                        Check_flag = "Y";
                    }
                }
                else {
                    if (document.getElementById("ctl00_MyCPH1_GV_DDMRList_ctl" + i + "_Chk_Docno").checked == true) {
                        Check_flag = "Y";
                    }
                }
            }
            if (Check_flag != "Y") {
                alert("Please Select Atleast One Records");
                return false;
            }
        }

        /*************************************************************************************************************
        FUNCTION FOr Check All
        *************************************************************************************************************/
        var FRM_NM = "ctl00_MyCPH1_"
        function Check_All(Grd_Name, Obj_chk_All, Obj_Chk_Ind) {

            Grid_Id = Grd_Name
            var grid = document.getElementById("ctl00_MyCPH1_" + Grid_Id);
            var rows = grid.rows.length;

            if (document.getElementById("ctl00$MyCPH1$" + Grid_Id + "$ctl01$" + Obj_chk_All).checked) {
                for (var b = 2; b <= rows; b++) {
                    // alert(b)
                    if (b < 10) {
                        GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
                    }
                    else {
                        GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";
                    }

                    document.getElementById(GV_FRM_NM + Obj_Chk_Ind).checked = true
                    //alert("hi..")
                }
            }
            else {
                for (var b = 2; b <= rows; b++) {
                    //alert(b)
                    if (b < 10) {
                        GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl0" + b + "_";
                    }
                    else {
                        GV_FRM_NM = "ctl00_MyCPH1_" + Grid_Id + "_ctl" + b + "_";
                    }

                    document.getElementById(GV_FRM_NM + Obj_Chk_Ind).checked = false

                }
            }
        }

        function OnSub_DATACHECK() {
            document.getElementById("ctl00_MyCPH1_btnShow").hide();
            var TxtManualDDMRNo = document.getElementById("ctl00_MyCPH1_TxtManualDDMRNo");
            var TxtDDMRDate = document.getElementById("ctl00_MyCPH1_TxtDDMRDate");
            var TxtValDate = document.getElementById("ctl00_MyCPH1_TxtValDate");
            var TxtContrctAmt = document.getElementById("ctl00_MyCPH1_TxtContrctAmt");
            var cboVendorType = document.getElementById("ctl00_MyCPH1_cboVendorType");
            var cboVendors = document.getElementById("ctl00_MyCPH1_cboVendors");
            var cboTripSheet = document.getElementById("ctl00_MyCPH1_cboTripSheet");
            var txtMarketVendor = document.getElementById("ctl00_MyCPH1_txtMarketVendor");
            var txtMktVeh = document.getElementById("ctl00_MyCPH1_txtMktVeh");
            var btnShow = document.getElementById("ctl00_MyCPH1_btnShow");

            if (TxtManualDDMRNo.value == "") {
                alert("Please Enter The Manual DDMR Number");
                document.getElementById("ctl00_MyCPH1_TxtManualDDMRNo").focus();
                return false;
            }
            if (TxtDDMRDate.value == "") {
                alert("Please Enter The DDMR Date");
                document.getElementById("ctl00_MyCPH1_TxtDDMRDate").focus();
                return false;
            }
            //            if(TxtValDate.value=="")
            //            {
            //                alert("Please Enter The License Validity Date");
            //                document.getElementById("ctl00_MyCPH1_TxtValDate").focus();
            //                return false;
            //            }
            if (cboVendorType.value == "") {
                alert("Please Select The Vendor Type");
                document.getElementById("ctl00_MyCPH1_cboVendorType").focus();
                return false;
            }
                //else if (cboVendorType.value!="XX")
                //{
                //    if(cboVendors.value=="")
                //    {
                //       alert("Please Select The Vendor");
                //       document.getElementById("ctl00_MyCPH1_cboVendors").focus();
                //       return false;
                //   }
                //   if(cboVendorType.value=="05")
                //   {
                //      if(cboTripSheet.value="")
                //      {
                //          alert("Please Select The Trip Sheet No");
                //          document.getElementById("ctl00_MyCPH1_cboTripSheet").focus();
                //          return false;
                //     }
                //  }
                //}
            else if (cboVendorType.value == "XX") {
                if (txtMarketVendor.value == "") {
                    alert("Please Enetr The Market Vendor Name");
                    document.getElementById("ctl00_MyCPH1_txtMarketVendor").focus();
                    return false;
                }
                if (txtMktVeh.value == "") {
                    alert("Please Enetr The Market Vehicle");
                    document.getElementById("ctl00_MyCPH1_txtMktVeh").focus();
                    return false;
                }
            }
            if (TxtContrctAmt.value == 0) {
                alert("Please Enter The Contract Amount");
                document.getElementById("ctl00_MyCPH1_TxtContrctAmt").focus();
                return false;
            }

            var FinYear_fromdate_dd = FinYear_fromdate.substring(0, 2);
            var FinYear_fromdate_mm = FinYear_fromdate.substring(3, 5);
            var FinYear_fromdate_yy = FinYear_fromdate.substring(6, 10);
            FinYear_fromdate1 = new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy));

            var FinYear_todate_dd = FinYear_todate.substring(0, 2);
            var FinYear_todate_mm = FinYear_todate.substring(3, 5);
            var FinYear_todate_yy = FinYear_todate.substring(6, 10);
            FinYear_todate1 = new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy));

            var dt = document.getElementById("ctl00_MyCPH1_TxtDDMRDate").value;
            var dt_dd = dt.substring(0, 2);
            var dt_mm = dt.substring(3, 5);
            var dt_yy = dt.substring(6, 10);
            dt = new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy));

            if (dt > FinYear_todate1 || dt < FinYear_fromdate1) {
                alert("You have Selected Finacial Year as " + Sle_finyear + " , SO Billdate Should Be Between  " + FinYear_fromdate + " to " + FinYear_todate + " !!!");
                document.getElementById("ctl00_MyCPH1_TxtDDMRDate").focus();
                return false;
            }
            click_count = parseFloat(document.getElementById("ctl00_MyCPH1_click_count").value);
            if (click_count > 0) {
                alert("Sorry... You cannot click twice !!!")
                return false;
            }
            else {
                click_count = click_count + 1
                document.getElementById("ctl00_MyCPH1_click_count").value = click_count
                return true;
            }
        }
        function Calculation() {
            var TxtContrctAmt = document.getElementById("ctl00_MyCPH1_TxtContrctAmt");
            var TxtAdvAmt = document.getElementById("ctl00_MyCPH1_TxtAdvAmt");
            var TxtBalAmt = document.getElementById("ctl00_MyCPH1_TxtBalAmt");

            if (parseFloat(TxtContrctAmt.value) > 0) {
                if (parseFloat(TxtContrctAmt.value) < parseFloat(TxtAdvAmt.value)) {
                    alert("Contract Amount Not Less Then Advance Amount");
                    TxtAdvAmt.value = 0;
                    document.getElementById("ctl00_MyCPH1_TxtAdvAmt").focus();
                    return false;
                }
                TxtBalAmt.value = parseFloat(TxtContrctAmt.value) - parseFloat(TxtAdvAmt.value)
            }
            else {
                TxtContrctAmt.value = 0;
                TxtAdvAmt.value = 0;
                TxtBalAmt.value = 0;
            }
        }
        function ENABLED_WT(chkpkg) {
            //alert("H");
            //alert(document.getElementById("ctl00_MyCPH1_GV_DDMRList"));
            //var tbl = document.getElementById("ctl00_MyCPH1_GV_DDMRList");
            var tbl = document.getElementById("ctl00_MyCPH1_GV_DDMRList");
            var Totalcount = tbl.rows.length;
            var TxtBookedPkt = 0, TxtGievnPkt = 0, TxtPendPkt = 0;
            //alert(Totalcount);
            for (i = 2; i <= Totalcount; i++) {
                //alert("Hi");
                if (i < 10) {
                    //alert("Hii");
                    TxtBookedPkt = document.getElementById("ctl00_MyCPH1_GV_DDMRList_ctl0" + i + "_TxtBookedPkt")
                    TxtGievnPkt = document.getElementById("ctl00_MyCPH1_GV_DDMRList_ctl0" + i + "_TxtGievnPkt")
                    TxtPendPkt = document.getElementById("ctl00_MyCPH1_GV_DDMRList_ctl0" + i + "_TxtPendPkt")
                    //alert(TxtBookedPkt.value);
                    //alert(TxtGievnPkt.value);
                    if (parseFloat(TxtGievnPkt.value) >= 0) {
                        if (parseFloat(TxtBookedPkt.value) < parseFloat(TxtGievnPkt.value)) {
                            alert("Given Pkt is not More then Booked Pkt")
                            TxtGievnPkt.disabled = false;
                            TxtGievnPkt.value = TxtBookedPkt.value;
                        }
                        else {
                            TxtPendPkt.value = TxtBookedPkt.value - TxtGievnPkt.value
                            TxtGievnPkt.disabled = false;
                        }
                    }
                    else {
                        alert("Given Pkt Can Be Greater then Zero")
                        TxtGievnPkt.value = TxtBookedPkt.value;
                    }
                }
                else {
                    //alert("Hiii");
                    TxtBookedPkt = document.getElementById("ctl00_MyCPH1_GV_DDMRList_ctl" + i + "_TxtBookedPkt")
                    TxtGievnPkt = document.getElementById("ctl00_MyCPH1_GV_DDMRList_ctl" + i + "_TxtGievnPkt")
                    TxtPendPkt = document.getElementById("ctl00_MyCPH1_GV_DDMRList_ctl" + i + "_TxtPendPkt")

                    if (parseFloat(TxtGievnPkt.value) >= 0) {
                        if (parseFloat(TxtBookedPkt.value) < parseFloat(TxtGievnPkt.value)) {
                            alert("Given Pkt is not More then Booked Pkt")
                            TxtGievnPkt.disabled = false;
                            TxtGievnPkt.value = TxtBookedPkt.value;
                        }
                        else {
                            TxtPendPkt.value = TxtBookedPkt.value - TxtGievnPkt.value
                            TxtGievnPkt.disabled = false;
                        }
                    }
                    else {
                        alert("Given Pkt Can Be Greater then Zero")
                        TxtGievnPkt.value = TxtBookedPkt.value;
                    }
                }
            }
        }
        function popuplist(mode, ctlid, tbl) {
            var winOpts = "scrollbars=yes,resizable=yes,width=" + 500 + ",height=" + 400 + "";
            var url = "";
            url = "DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl;
            confirmWin = window.open(url, "", winOpts);
            return false;
        }
        function LocBlur(id) {

            var str = "";
            for (var i = 0; i < id.length - 14; i++) {
                str += id.charAt(i);
            }
            document.getElementById(id).value = document.getElementById(id).value.toUpperCase()
            var txtLocation = document.getElementById(id);
            //var lbllocname=document.getElementById("ctl00_MyCPH1_lbllocname");

            var Location = txtLocation.value;
            if (Location == "")
                return false;

            var findobj = false;
            findobj = GetXMLHttpObject();
            if (findobj) {
                var strpg = "CheckExist.aspx?mode=LocCode&Code=" + Location + "&sid=" + Math.random();
                findobj.open("GET", strpg, true);
                findobj.onreadystatechange = function () {
                    if (findobj.readyState == 4 && findobj.status == 200) {
                        var res = findobj.responseText.split("|");
                        if (res[0] == "false") {
                            alert("Location Code is not Valid... Please Enter Valid Location Code");
                            txtLocation.value = "";
                            //lbllocname.innerText = "";
                            txtLocation.focus();
                            return false;
                        }
                    }
                }
                findobj.send(null);
            }
            return false;
        }
    </script>

    <div align="left">
        <br />
        <asp:UpdatePanel ID="Updtl" runat="server" UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table cellspacing="1" class="stbl" align="left">
                    <tr class="hrow">
                        <td colspan="3" align="center">
                            <asp:Label ID="lblDDMR" CssClass="ffnt" Font-Bold="true" runat="server">DDMR Generation Process</asp:Label>
                        </td>
                    </tr>
                    <tr class="nrow" id="gridview" runat="server" visible="true">
                        <td>
                            <br />
                            <asp:GridView ID="GV_DDMRList" runat="server" align="left" BorderWidth="0" CellSpacing="1"
                                CellPadding="2" HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left"
                                CssClass="boxbg" FooterStyle-CssClass="bgbluegrey" AllowPaging="False" PageSize="1"
                                Width="100%" AllowSorting="False" AutoGenerateColumns="false" ShowFooter="false"
                                PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                                <PagerStyle VerticalAlign="Bottom" />
                                <Columns>
                                    <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" />
                                        <HeaderTemplate>
                                            <asp:CheckBox ID="ChkAll" runat="server" onclick="javascript:Check_All('GV_DDMRList','ChkAll','Chk_Docno')" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>" runat="server"> </asp:Label>
                                            <asp:CheckBox ID="Chk_Docno" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Docket No." ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="LblDOCKNO" Text='<%# DataBinder.Eval(Container.DataItem, "DOCKNO") %>'
                                                runat="server"> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Delivery MR No." ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <asp:Label ID="LblMRSNO" Text='<%# DataBinder.Eval(Container.DataItem, "MRSNO") %>'
                                                runat="server"> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Docket Booking Date" ItemStyle-Wrap="true" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" Width="80" />
                                        <ItemTemplate>
                                            <asp:Label ID="LblDOCKETDT" Text='<%# DataBinder.Eval(Container.DataItem, "DOCKETDT") %>'
                                                runat="server"> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Consignee" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="left" Width="150" />
                                        <ItemTemplate>
                                            <asp:Label ID="LblConsignee" Text='<%# DataBinder.Eval(Container.DataItem, "CSGENM") %>'
                                                runat="server"> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Private Marka" ItemStyle-Wrap="false" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" Width="50" />
                                        <ItemTemplate>
                                            <asp:Label ID="LblPrivate" Text='<%#DataBinder.Eval(Container.DataItem, "Private") %>'
                                                runat="server"> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Door Delivery Charges" ItemStyle-Wrap="true" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" Width="50" />
                                        <ItemTemplate>
                                            <asp:Label ID="LblDDLCharge" Text='<%#DataBinder.Eval(Container.DataItem, "DDLCharge") %>'
                                                runat="server"> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Booked Pkt" ItemStyle-Wrap="true" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" Width="50" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="TxtBookedPkt" runat="server" Enabled="false" Text='<%#DataBinder.Eval(Container.DataItem, "PKGSNO") %>'
                                                Width="50"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Given Pkt" ItemStyle-Wrap="true" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" Width="50" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="TxtGievnPkt" runat="server" Enabled="true" OnChange="Javascript:return ENABLED_WT(this);"
                                                Text='<%#DataBinder.Eval(Container.DataItem, "PKGSNO") %>' Width="50"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Pending Pkt" ItemStyle-Wrap="true" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" Width="50" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="TxtPendPkt" runat="server" Enabled="false" Text="0" Width="50"></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Charge Weight/KG" ItemStyle-Wrap="true" ItemStyle-BackColor="white">
                                        <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" Font-Bold="true" />
                                        <ItemStyle CssClass="blackfnt" HorizontalAlign="Right" Width="60" />
                                        <ItemTemplate>
                                            <asp:Label ID="LblCHRGWT" Text='<%# DataBinder.Eval(Container.DataItem, "CHRGWT") %>'
                                                runat="server"> </asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr align="right" bgcolor="white" id="Step1" runat="server" visible="true">
                        <td colspan="3">
                            <br />
                            <asp:Button ID="ButStep1" runat="server" Text="Step-1" Width="75px" CssClass="fbtn"
                                OnClientClick="Javascript:return OnSub_Step1();" OnClick="ButStep1_Click" />
                        </td>
                    </tr>
                    <tr align="left" bgcolor="white" id="DDMRProcess" runat="server" visible="false">
                        <td>
                            <br />
                            <br />
                            <table cellspacing="1" class="stbl" align="left">
                                <tr bgcolor="#FFFFFF" align="left">
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text="Manual DDMR NO."></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtManualDDMRNo" runat="server" Text=""></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text="DDMR Date"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="TxtDDMRDate" runat="server" Width="80px" BorderStyle="Groove" CssClass="input"
                                            MaxLength="10"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$TxtDDMRDate,'anchor1','dd/MM/yyyy'); return false;"
                                            id="anchor1" name="anchor1">
                                            <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" align="left">
                                    <td>
                                        <asp:Label ID="Label3" runat="server" Text="System No."></asp:Label>
                                    </td>
                                    <td>
                                        <strong><span style="color: #ff0000">&nbsp;&lt;System Generated&gt;</span></strong>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label4" runat="server" Text="From Location"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtFromLoc" runat="server" BorderStyle="Groove" Width="100px" Enabled="false"></asp:TextBox>
                                        <input id="btnFromLoc" nowrap type="button" value="..." runat="server" />
                                        <%--<xac:WebxComplete ID="WebxBranch" runat="server" WebxEntity="BranchCode" CodeTarget="TxtFromLoc"
                                            MinPrefixLength="1" />--%>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label5" runat="server" Text="To Location"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtToLoc" runat="server" BorderStyle="Groove" Width="100px" Enabled="true"></asp:TextBox>
                                        <input id="btnToLoc" type="button" value="..." runat="server" />
                                        <%--<xac:WebxComplete ID="WebxBranch1" runat="server" WebxEntity="BranchCode" CodeTarget="TxtToLoc"
                                            MinPrefixLength="1" />--%>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" align="left">
                                    <td>
                                        <asp:Label ID="Label21" runat="server" Text="Select Vendor Type"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="cboVendorType" AutoPostBack="true" DataSourceID="MySQLDataSource_VendorTypes"
                                            DataTextField="Vendor_Type" DataValueField="Vendor_Type_Code" OnSelectedIndexChanged="OnVendorTypeChange">
                                        </asp:DropDownList>
                                    </td>
                                    <td align="left">
                                        <div align="left">
                                            <asp:Label ID="Label22" runat="server" Text="Select Vendor"></asp:Label>
                                        </div>
                                    </td>
                                    <td colspan="3">
                                        <font class="blackfnt" color="red">
                                            <asp:DropDownList runat="server" ID="cboVendors" AutoPostBack="true" DataSourceID="MySQLDataSource_Vendors"
                                                DataTextField="Vendor_Name" DataValueField="Vendor_Code" OnSelectedIndexChanged="OnVendorChange">
                                            </asp:DropDownList>
                                            <asp:TextBox ID="txtMarketVendor" runat="server" MaxLength="50" Width="200" Visible="false"></asp:TextBox>
                                        </font>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" align="left">
                                    <td>
                                        <asp:Label ID="Label6" runat="server" Text="Vehicle No."></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="cboVehicles" AutoPostBack="true" OnSelectedIndexChanged="OnVehicleChange">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtMktVeh" Visible="false" runat="server" Width="200" MaxLength="10"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label7" runat="server" Text="Vehicle Type"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="cboVehicleTypes" AutoPostBack="true" DataTextField="Type_Name"
                                            DataValueField="TypeCode">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label8" runat="server" Text="FTL Type"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="cboFTLTypes" runat="server" DataTextField="CodeDesc" DataValueField="CodeID">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" align="left">
                                    <td>
                                        <asp:Label ID="Label9" runat="server" Text="Trip Sheet No"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="cboTripSheet" AutoPostBack="true" DataTextField="VSlipNo"
                                            DataValueField="CodeSlipNo" Enabled="false">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label10" runat="server" Text="Remarks"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:TextBox ID="TxtRemarks" Visible="true" runat="server" Width="200"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" align="left">
                                    <td>
                                        <asp:Label ID="Label11" runat="server" Text="Driver Name"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label14" runat="server" Text="Driver Mobile No."></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label12" runat="server" Text="License No."></asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:Label ID="Label15" runat="server" Text="Issue By RTO"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label13" runat="server" Text="License Validity Date"></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" align="left">
                                    <td>
                                        <asp:TextBox ID="TxtDriverName" runat="server" BorderStyle="Groove" Width="100px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtMobNo" runat="server" BorderStyle="Groove" Width="100px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtLicenseNo" runat="server" BorderStyle="Groove" Width="100px"></asp:TextBox>
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="TxtRTO" runat="server" BorderStyle="Groove" Width="100px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="TxtValDate" runat="server" Width="80px" BorderStyle="Groove" CssClass="input"
                                            MaxLength="10"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$TxtValDate,'anchor11','dd/MM/yyyy'); return false;"
                                            id="a11" name="anchor11">
                                            <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" align="left">
                                    <td>
                                        <asp:Label ID="Label16" runat="server" Text="Contract Amount"></asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="TxtContrctAmt" runat="server" Text="0" BorderStyle="Groove" Width="100px"
                                            OnChange="Javascript:return Calculation();"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label17" runat="server" Text="Advance Amount"></asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="TxtAdvAmt" runat="server" Text="0" BorderStyle="Groove" Width="100px"
                                            OnChange="Javascript:return Calculation();"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" align="left">
                                    <td>
                                        <asp:Label ID="Label18" runat="server" Text="Balance Amount"></asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="TxtBalAmt" runat="server" Text="0" BorderStyle="Groove" Width="100px"
                                            Enabled="false"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label19" runat="server" Text="Advance Payment Location"></asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="TxtAdvLoc" runat="server" BorderStyle="Groove" Width="100px" Enabled="true"></asp:TextBox>
                                        <input id="ButAdvLoc" nowrap type="button" value="..." runat="server" />
                                        <%--<xac:WebxComplete ID="WebxComplete2" runat="server" WebxEntity="BranchCode" CodeTarget="TxtAdvLoc"
                                            MinPrefixLength="1" />--%>
                                    </td>
                                </tr>
                                <tr bgcolor="#FFFFFF" align="left">
                                    <td>
                                        <asp:Label ID="Label20" runat="server" Text="Balance Payment Location"></asp:Label>
                                    </td>
                                    <td colspan="5">
                                        <asp:TextBox ID="TxtBalLoc" runat="server" BorderStyle="Groove" Width="100px" Enabled="true"></asp:TextBox>
                                        <input id="ButBalLoc" nowrap type="button" value="..." runat="server" />
                                        <%--<xac:WebxComplete ID="WebxComplete1" runat="server" WebxEntity="BranchCode" CodeTarget="TxtBalLoc"
                                            MinPrefixLength="1" />--%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr align="center" bgcolor="white" id="submit" runat="server" visible="false">
                        <td class="frow" colspan="3">
                            <asp:Button ID="btnShow" OnClientClick="Javascript:return OnSub_DATACHECK();" runat="server"
                                Text="Submit" Width="75px" CssClass="fbtn" OnClick="btnShow_Click" />
                            <asp:HiddenField ID="hBrCd" runat="server" />
                            <asp:HiddenField ID="click_count" runat="server" Value="0" />
                        </td>
                    </tr>
                </table>
                <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
