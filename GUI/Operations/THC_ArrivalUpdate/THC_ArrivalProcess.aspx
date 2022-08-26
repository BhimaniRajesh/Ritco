<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="THC_ArrivalProcess.aspx.cs" Inherits="GUI_Operations_THC_ArrivalUpdate_THC_ArrivalProcess" %>

<%@ Register TagName="PRB" TagPrefix="PRBAR" Src="~/GUI/Common_UserControls/ProgressBar.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <asp:SqlDataSource ID="MySQLDataSource_GeneralMaster" runat="server" SelectCommand="Select CodeID='', CodeDesc='--Select--'  union select codeid,codedesc from webx_master_general where codetype='LATE_A' and statuscode='Y'"
        SelectCommandType="Text"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_DelyReasons" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="usp_DeliveryReasons" SelectCommandType="StoredProcedure">
        <%--        <SelectParameters>
            <asp:Parameter DefaultValue='L' Name="ReasonType" Type="char" Size="1" />
        </SelectParameters>--%>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_ArrivalConditions" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="usp_ArrivalConditions" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Godowns" runat="server" ProviderName="System.Data.SqlClient"
        SelectCommand="usp_Godowns" SelectCommandType="StoredProcedure">
        <SelectParameters>
            
                        <asp:SessionParameter Name="brcd" SessionField="brcd" Type="String" DefaultValue="HYDB" />
        </SelectParameters>
    </asp:SqlDataSource>

    <script src="../../images/commonJs.js" language="javascript" type="text/javascript"></script>

    <script src="../../images/CalendarPopup.js" language="javascript" type="text/javascript"></script>

<script language="vbscript" type="text/vbscript">
        
        function findDateDifference(dtFrom, dtTo, interval)
            
            findDateDifference = DateDiff(interval, dtFrom, dtTo)
            
        end function
        
    </script>
    
    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();
    </script>

    <script language="javascript" type="text/javascript">

        var months = new Array("", "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December");
      
        function ValidateData() 
        {
            var hdnDeptDate = document.getElementById("ctl00_MyCPH1_hdnDeptDate");
            var HDKM = document.getElementById("ctl00_MyCPH1_HDKM");
            var txtArrivalTimeHH = document.getElementById("ctl00_MyCPH1_txtArrivalTimeHH");
            var txtArrivalTimeMM = document.getElementById("ctl00_MyCPH1_txtArrivalTimeMM");
            var txtIncomingSealNo = document.getElementById("ctl00_MyCPH1_txtIncomingSealNo");
            var txtopenkm = document.getElementById("ctl00_MyCPH1_txtopenkm");
            var txtUnloader = document.getElementById("ctl00_MyCPH1_txtUnloader");
            var txtIncrmk = document.getElementById("ctl00_MyCPH1_txtIncrmk");
            var ddlLateArrivalReason = document.getElementById("ctl00_MyCPH1_ddlLateArrivalReason");
            var txtStockUpdateDate = document.getElementById("ctl00_MyCPH1_txtStockUpdateDate");
            var cboArrivalConditions_All = document.getElementById("ctl00_MyCPH1_cboArrivalConditions_All");
            var cboGodowns_All = document.getElementById("ctl00_MyCPH1_cboGodowns_All");
            var txtarrvdt = document.getElementById("ctl00_MyCPH1_txtarrvdt");

            var PRSTYP = document.getElementById("ctl00_MyCPH1_PRSTYP");
            
            var dt = txtarrvdt.value
           // alert(dt)
            var dt_dd = dt.substring(0, 2)
            var dt_mm = dt.substring(3, 5)
            var dt_yy = dt.substring(6, 10)

            var arrvdt = new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))

            var deptdt = hdnDeptDate.value
            // alert(dt)
            var deptdt_dd = deptdt.substring(0, 2)
            var deptdt_mm = deptdt.substring(3, 5)
            var deptdt_yy = deptdt.substring(6, 10)

            var deptdt_HH = deptdt.substring(11, 13)
            var deptdt_MM = deptdt.substring(14, 16)

           // alert(deptdt_MM)
                    
            var deptdate = new Date(months[parseFloat(deptdt_mm)] + " " + parseFloat(deptdt_dd) + ", " + parseFloat(deptdt_yy))

            currdate = "<%=currdate%>"
            dt_dd = currdate.substring(0, 2)
            dt_mm = currdate.substring(3, 5)
            dt_yy = currdate.substring(6, 10)
          
            
            currdate = new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))

            if (PRSTYP.value == "A" || PRSTYP.value == "B") {
                // alert(txtarrvdt)
                if (currdate < arrvdt) {
                    alert("Arrival Date should be less than or equal to  system Date ")
                    txtarrvdt.focus();
                    return false;
                }

                if (deptdate > arrvdt) {
                    alert("Arrival Date should be gretter than  " + deptdate.value)
                    txtarrvdt.focus();
                    return false;
                }
                // alert(hdnDeptDate.value.substring(0, 10))
                // alert(txtarrvdt.value)
                if (hdnDeptDate.value.substring(0, 10) == txtarrvdt.value) {



                    if (parseFloat(deptdt_HH) > parseFloat(txtArrivalTimeHH.value)) {
                        alert("Please Enter Time in Hours > " + deptdt_HH);
                        txtArrivalTimeHH.focus();
                        return false;
                    }


                    if (parseFloat(deptdt_HH) == parseFloat(txtArrivalTimeHH.value)) {

                        if (parseFloat(deptdt_MM) >= parseFloat(txtArrivalTimeMM.value)) {
                            alert("Please Enter Time in Minutes > " + deptdt_MM);
                            txtArrivalTimeMM.focus();
                            return false;
                        }
                    }


                }

                // 

                if (txtArrivalTimeHH.value == "") {
                    alert("Please Enter Time in Hours between 1 & 23");
                    txtArrivalTimeHH.focus();
                    return false;
                }
                //alert("hi..1")
                if (parseFloat(txtArrivalTimeHH.value) <= 0 || parseFloat(txtArrivalTimeHH.value) > 23) {
                    alert("Please Enter Time in Hours between 1 & 23");
                    txtArrivalTimeHH.focus();
                    return false;
                }

                if (txtArrivalTimeMM.value == "") {
                    alert("Please Enter Time in Minutes between 1 & 59");
                    txtArrivalTimeMM.focus();
                    return false;
                }

                if (parseFloat(txtArrivalTimeMM.value) < 0 || parseFloat(txtArrivalTimeMM.value) > 59) {
                    alert("Please Enter Time in Minutes between 1 & 59");
                    txtArrivalTimeMM.focus();
                    return false;
                }


                if (txtIncomingSealNo.value == "") {
                    alert("Please Enter Seal  No....");
                    txtIncomingSealNo.focus();
                    return false;
                }

                if (txtopenkm.value == "") {
                    alert("Please Enter Closing KM ....");
                    txtopenkm.focus();
                    return false;
                }
                // alert("txtopenkm  " + txtopenkm.value + " HDKM  " + HDKM.value)

                if (parseFloat(txtopenkm.value) <= parseFloat(HDKM.value)) {
                    alert("Please Enter Closing KM > " + HDKM.value);
                    txtopenkm.focus();
                    return false;
                }

                if (txtUnloader.value == "") {
                    alert("Please Enter Unloader....");
                    txtUnloader.focus();
                    return false;
                }
                if (txtIncrmk.value == "") {
                    alert("Please Enter Incoming Remarks....");
                    txtIncrmk.focus();
                    return false;
                }
                if (ddlLateArrivalReason.value == "") {
                    alert("Please Select Late Arrival Reason....");
                    ddlLateArrivalReason.focus();
                    return false;
                }

            }

            if (PRSTYP.value == "S" || PRSTYP.value == "B") {
                if (txtStockUpdateDate.value == "") {
                    alert("Please Enter Stock Update Date....");
                    txtStockUpdateDate.focus();
                    return false;
                }
                if (cboArrivalConditions_All.value == "") {
                    alert("Please Enter Arrival Condition....");
                    cboArrivalConditions_All.focus();
                    return false;
                }
                if (cboGodowns_All.value == "0") {
                    alert("Please Enter Warehouse ID....");
                    cboGodowns_All.focus();
                    return false;
                }
            }

                 
        }
        
    </script>

    <asp:UpdatePanel ID="upTHCCreate"  RenderMode="Inline" runat="server">
        <ContentTemplate>
            <br />
            <table cellspacing="1"  style="width: 9.0in">
                <tr style="background-color: white">
                    <td align="left" width="75%">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Text="" Font-Bold="true" runat="server"></asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                        <asp:HiddenField ID="HdeptDt" runat="server" />
                        <asp:HiddenField runat="server" ID="HDKM" />
                        <asp:HiddenField ID="PRSTYP" runat="server" />
                        <asp:HiddenField ID="hdnajaxstate" runat="server" Value="0" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <a href="javascript:window.history.go(-1)" title="back">
                            <img alt="Back" src="./../../images/back.gif" style="border: 0;">
                        </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<PRBAR:PRB ID="PB" runat="server" />
                    </td>
                </tr>
            </table>
            <table cellpadding="2" cellspacing="1" border="0" class="boxbg" id="tblMain" runat="server"
                style="width: 8.0in">
                <tr class="bgbluegrey">
                    <td align="center" colspan="4">
                        <asp:Label ID="lbltblHDR" CssClass="blackfnt" Text="Select Criteria For Arrival"
                            Font-Bold="true" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left"  >
                        <asp:Label ID="lbkThcno" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
                    </td>
                    <td align="left"  >
                        <asp:Label ID="lblTHCNO" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                      <td align="left">
                        <asp:Label ID="Label12" CssClass="blackfnt" Text="Vehicle #" Font-Bold="true" runat="server"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblvehicle" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <asp:Label ID="lbltotMF" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblCntMF" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                     <td align="left">
                        <asp:Label ID="lbltotDKT" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblCntDKt" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                </tr>
                
                
              
                <tr bgcolor="white">
                    <td align="left">
                        <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" Text="Vehicle Departed From # "
                            runat="server"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblvehicledep" CssClass="blackfnt" runat="server"></asp:Label>
                        <asp:HiddenField ID="hdnDeptDate" runat="server" />
                    </td>
                     <td align="left">
                        <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="true" Text="Expected Arrival Date & Time # "
                            runat="server"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="lblexparr" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                </tr>
               
                <tr bgcolor="white" id="tr7" runat="server">
                    <td align="left" >
                        <asp:Label ID="Label13" CssClass="blackfnt" Font-Bold="true" Text="Actual  Arrival Date & Time # "
                            runat="server"></asp:Label>
                    </td>
                    <td align="left" colspan="3">
                        <asp:Label ID="lblarrrvatDt" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white" id="tr1" runat="server">
                    <td align="left" >
                        <asp:Label ID="Label4" CssClass="blackfnt" Font-Bold="true" Text="Actual  Arrival Date & Time # "
                            runat="server"></asp:Label>
                    </td>
                    <td align="left" colspan="3">
                        <asp:TextBox ID="txtarrvdt" CssClass="input" Width="60" MaxLength="10"
                        onblur="javascript:return isValidDate(this.value,'Arrival Date!!!')" onkeypress="javascript:return validDate(event)" runat="server"></asp:TextBox>
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtarrvdt,'anchor4','dd/MM/yyyy'); return false;"
                            name="anchor4" id="a1">
                            <img src="./../../images/calendar.jpg" id="Img2" runat="server" border="0" />
                        </a>&nbsp;
                        <asp:TextBox ID="txtArrivalTimeHH" CssClass="input" Width="20" MaxLength="2" runat="server"></asp:TextBox>
                        :
                        <asp:TextBox CssClass="input" ID="txtArrivalTimeMM" Width="20" MaxLength="2" runat="server"></asp:TextBox>
                        <label class="blackfnt" style="vertical-align: text-top">
                            &nbsp;(dd/mm/yyyy HH:MM)
                        </label>
                    </td>
                </tr>
                <tr style="background-color: White" id="tr2" runat="server">
                    <td align="left" >
                        <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" Text="Incoming Seal # & Status #"
                            runat="server"></asp:Label>
                    </td>
                    <td align="left" colspan="3">
                        <asp:TextBox ID="txtIncomingSealNo" CssClass="input" runat="server" MaxLength="0"
                            Width="70"></asp:TextBox>
                        &nbsp;&nbsp;
                        <asp:DropDownList ID="ddlSealStatus" runat="server" CssClass="blackfnt">
                            <asp:ListItem Text="OK"></asp:ListItem>
                            <asp:ListItem Text="Broken"></asp:ListItem>
                            <asp:ListItem Text="Unsealed"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr bgcolor="white" id="tr3" runat="server">
                    <td align="left">
                        <asp:Label ID="Label5" CssClass="blackfnt" Font-Bold="true" Text="Closing KM # "
                            runat="server"></asp:Label>
                    </td>
                    <td align="left" >
                        <asp:TextBox ID="txtopenkm" CssClass="input" runat="server" onkeypress="javascript:return validInt(event)" MaxLength="0" Width="70"></asp:TextBox>
                        &nbsp;&nbsp;
                        <asp:Label ID="lblopnekm" CssClass="blackfnt" runat="server"></asp:Label>
                        
                    </td>
                    <td align="left">
                        <asp:Label ID="Label6" CssClass="blackfnt" Font-Bold="true" Text="Unloader # " runat="server"></asp:Label>
                    </td>
                    <td align="left" >
                        <asp:TextBox ID="txtUnloader" CssClass="input" runat="server" MaxLength="0" Width="70"></asp:TextBox>
                        &nbsp;&nbsp;
                        <asp:Label ID="Label7" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                </tr>
                
                <tr bgcolor="white" id="tr5" runat="server">
                    <td align="left">
                        <asp:Label ID="Label8" CssClass="blackfnt" Font-Bold="true" Text="Incoming Remarks # "
                            runat="server"></asp:Label>
                    </td>
                    <td align="left" colspan="3">
                        <asp:TextBox ID="txtIncrmk" CssClass="input" runat="server" TextMode="MultiLine"
                            Width="270"></asp:TextBox>
                        &nbsp;&nbsp;
                        <asp:Label ID="Label9" CssClass="blackfnt" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white" id="tr6" runat="server">
                    <td align="left">
                        <asp:Label ID="Label10" CssClass="blackfnt" Font-Bold="true" Text="Late Arrival Reason (if any) # "
                            runat="server"></asp:Label>
                    </td>
                    <td align="left" colspan="3">
                        <asp:DropDownList ID="ddlLateArrivalReason" DataSourceID="MySQLDataSource_GeneralMaster"
                            DataTextField="Codedesc" DataValueField="CodeID" runat="server" CssClass="blackfnt">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" colspan="4" height="10">
                    </td>
                </tr>
            </table>
            <table cellpadding="2" cellspacing="1" border="0" class="boxbg" id="Table1" runat="server"
                style="width: 8.0in">
                <tr class="bgbluegrey">
                    <td align="center" colspan="3">
                        <asp:Label ID="Label11" CssClass="blackfnt" Text="Select Criteria For Stock Update"
                            Font-Bold="true" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr class="bgbluegrey">
                    <td align="left">
                        <asp:Label ID="Label14" CssClass="blackfnt" Font-Bold="true" Text="Stock Update Date # "
                            runat="server"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label15" CssClass="blackfnt" Font-Bold="true" Text="Arrival Condition  # "
                            runat="server"></asp:Label>
                    </td>
                    <td align="left">
                        <asp:Label ID="Label16" CssClass="blackfnt" Font-Bold="true" Text="Warehouse ID  # "
                            runat="server"></asp:Label>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <asp:TextBox ID="txtStockUpdateDate" runat="server"
                        onblur="javascript:return isValidDate(this.value,'StockUpdate Date!!!')" onkeypress="javascript:return validDate(event)" CssClass="input" MaxLength="10"
                            Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtStockUpdateDate,'b','dd/MM/yyyy'); return false;"
                            id="b">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="cboArrivalConditions_All" runat="server" CssClass="input" DataSourceID="MySQLDataSource_ArrivalConditions"
                            DataTextField="Code" DataValueField="CodeID">
                        </asp:DropDownList>
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="cboGodowns_All" runat="server" CssClass="input" DataSourceID="MySQLDataSource_Godowns"
                            DataTextField="godown_name" DataValueField="godown_srno" >
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <table cellpadding="2" cellspacing="1" border="0" class="boxbg" id="Table2" runat="server"
                style="width: 8.0in">
                <tr style="background-color: White">
                    <td align="center" colspan="3">
                        <%--<br style="font-size: medium;" />--%>
                        <asp:Button ID="btnSubmit" runat="server"  OnClientClick="Javascript: return  ValidateData();"  OnClick="btnSubmit_Click" />
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
