<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="query.aspx.cs" Inherits="GUI_UNI_MIS_OPN_DOC_Register_query" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="LH_to" TagPrefix="Location_to" Src="~/GUI/Common_UserControls/LocationHirarchy_to.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="JavaScript" src="./../../Images/CalendarPopup.js"></script>

    <script language="javascript" src="./../../images/commonJs.js"></script>

    <script language="JavaScript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function SelectPartyCode() {

            // var ddl = document.getElementById('ctl00_MyCPH1_documet_type');
            // alert("Hiiiiii")
            if (document.getElementById("ctl00_MyCPH1_documet_type_0").checked == true) {
                document.getElementById('ctl00_MyCPH1_tbl_dkt').style.display = "block";
                document.getElementById('ctl00_MyCPH1_tbl_thc').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_CHKdkt').style.display = "block";
                document.getElementById('ctl00_MyCPH1_tbl_thcchk').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_DRSchk').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_PRSchk').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_prs').style.display = "none";

            }
            else if (document.getElementById("ctl00_MyCPH1_documet_type_1").checked == true) {

                document.getElementById('ctl00_MyCPH1_tbl_dkt').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_thc').style.display = "block";
                document.getElementById('ctl00_MyCPH1_tbl_CHKdkt').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_thcchk').style.display = "block";
                document.getElementById('ctl00_MyCPH1_tbl_DRSchk').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_PRSchk').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_prs').style.display = "none";

            }
            else if (document.getElementById("ctl00_MyCPH1_documet_type_2").checked == true) {

                document.getElementById('ctl00_MyCPH1_tbl_dkt').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_thc').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_CHKdkt').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_thcchk').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_DRSchk').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_PRSchk').style.display = "block";
                document.getElementById('ctl00_MyCPH1_tbl_prs').style.display = "block";

            }
            else if (document.getElementById("ctl00_MyCPH1_documet_type_3").checked == true) {

                document.getElementById('ctl00_MyCPH1_tbl_dkt').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_thc').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_CHKdkt').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_thcchk').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_DRSchk').style.display = "block";
                document.getElementById('ctl00_MyCPH1_tbl_PRSchk').style.display = "none";
                document.getElementById('ctl00_MyCPH1_tbl_prs').style.display = "block";

            }



            //return false;
        }

        function CHKDKT1(val) {
            var CHKDKT1 = document.getElementById("ctl00_MyCPH1_CHKDKT1");
            $("input[type=checkbox][id*=ctl00_MyCPH1_CheckBoxList1_]").each(function () {
                $(this).prop("checked", CHKDKT1.checked);
            });
        }

        function CHKDKT2(val) {
            var CHKDKT2 = document.getElementById("ctl00_MyCPH1_CHKDKT2");
            $("input[type=checkbox][id*=ctl00_MyCPH1_ChkAmtChrgDtl_]").each(function () {
                $(this).prop("checked", CHKDKT2.checked);
            });
        }

        function CHKDKT3(val) {

            var CHKDKT3 = document.getElementById("ctl00_MyCPH1_CHKDKT3");

            $("input[type=checkbox][id*=ctl00_MyCPH1_CheckBoxList3_]").each(function () {
                $(this).prop("checked", CHKDKT3.checked);
            });

        }

        function CHKDKT4(val) {

            var CHKDKT4 = document.getElementById("ctl00_MyCPH1_CHKDKT4");

            $("input[type=checkbox][id*=ctl00_MyCPH1_CheckBoxList4_]").each(function () {
                $(this).prop("checked", CHKDKT4.checked);
            });

        }

        function THCHK1(val) {

            var THCHK1 = document.getElementById("ctl00_MyCPH1_THCHK1");

            $("input[type=checkbox][id*=ctl00_MyCPH1_THCCHKLIST1_]").each(function () {
                $(this).prop("checked", THCHK1.checked);
            });

        }

        function THCHK2(val) {

            var THCHK2 = document.getElementById("ctl00_MyCPH1_THCHK2");

            $("input[type=checkbox][id*=ctl00_MyCPH1_THCCHKLIST2_]").each(function () {
                $(this).prop("checked", THCHK2.checked);
            });

        }

        function THCHK3(val) {

            var THCHK3 = document.getElementById("ctl00_MyCPH1_THCHK3");

            $("input[type=checkbox][id*=ctl00_MyCPH1_THCCHKLIST3_]").each(function () {
                $(this).prop("checked", THCHK3.checked);
            });

        }

        function THCHK4(val) {

            var THCHK4 = document.getElementById("ctl00_MyCPH1_THCHK4");
            $("input[type=checkbox][id*=ctl00_MyCPH1_THCCHKLIST4_]").each(function () {
                $(this).prop("checked", THCHK4.checked);
            });


        }

        function THCHK5(val) {

            var THCHK1 = document.getElementById("ctl00_MyCPH1_THCHK5");

            $("input[type=checkbox][id*=ctl00_MyCPH1_THCCHKLIST5_]").each(function () {
                $(this).prop("checked", THCHK1.checked);
            });

        }



        function PRSHK1(val) {

            var PRSHK1 = document.getElementById("ctl00_MyCPH1_PRSHK1");
            $("input[type=checkbox][id*=ctl00_MyCPH1_PRSCHKLIST1_]").each(function () {
                $(this).prop("checked", PRSHK1.checked);
            });

        }

        function PRSHK2(val) {

            var PRSHK2 = document.getElementById("ctl00_MyCPH1_PRSHK2");
            $("input[type=checkbox][id*=ctl00_MyCPH1_PRSCHKLIST2_]").each(function () {
                $(this).prop("checked", PRSHK2.checked);
            });


        }

        function PRSHK3(val) {

            var PRSHK3 = document.getElementById("ctl00_MyCPH1_PRSHK3");

            $("input[type=checkbox][id*=ctl00_MyCPH1_PRSCHKLIST3_]").each(function () {
                $(this).prop("checked", PRSHK3.checked);
            });

        }

        function PRSHK4(val) {

            var PRSHK4 = document.getElementById("ctl00_MyCPH1_PRSHK4");

            $("input[type=checkbox][id*=ctl00_MyCPH1_PRSCHKLIST4_]").each(function () {
                $(this).prop("checked", PRSHK4.checked);
            });

        }

        function PRSHK5(val) {

            var PRSHK1 = document.getElementById("ctl00_MyCPH1_PRSHK5");

            $("input[type=checkbox][id*=ctl00_MyCPH1_PRSCHKLIST5_]").each(function () {
                $(this).prop("checked", PRSHK1.checked);
            });
        }
        function DRSHK1(val) {

            var DRSHK1 = document.getElementById("ctl00_MyCPH1_DRSHK1");

            $("input[type=checkbox][id*=ctl00_MyCPH1_DRSCHKLIST1_]").each(function () {
                $(this).prop("checked", DRSHK1.checked);
            });

        }

        function DRSHK2(val) {

            var DRSHK2 = document.getElementById("ctl00_MyCPH1_DRSHK2");

            $("input[type=checkbox][id*=ctl00_MyCPH1_DRSCHKLIST2_]").each(function () {
                $(this).prop("checked", DRSHK2.checked);
            });

        }

        function DRSHK3(val) {

            var DRSHK3 = document.getElementById("ctl00_MyCPH1_DRSHK3");

            $("input[type=checkbox][id*=ctl00_MyCPH1_DRSCHKLIST3_]").each(function () {
                $(this).prop("checked", DRSHK3.checked);
            });

        }

        function DRSHK4(val) {

            //alert(ik)
            var DRSHK4 = document.getElementById("ctl00_MyCPH1_DRSHK4");

            $("input[type=checkbox][id*=ctl00_MyCPH1_DRSCHKLIST4_]").each(function () {
                $(this).prop("checked", DRSHK4.checked);
            });

        }

        function DRSHK5(val) {

            //alert(ik)
            var DRSHK1 = document.getElementById("ctl00_MyCPH1_DRSHK5");

            $("input[type=checkbox][id*=ctl00_MyCPH1_DRSCHKLIST5_]").each(function () {
                $(this).prop("checked", DRSHK1.checked);
            });

        }

        function DRSHK6(val) {

            //alert(ik)
            var DRSHK6 = document.getElementById("ctl00_MyCPH1_DRSHK6");

            $("input[type=checkbox][id*=ctl00_MyCPH1_DRSCHKLIST6_]").each(function () {
                $(this).prop("checked", DRSHK6.checked);
            });
        }

        function OnSub_DATACHECK() {
            //alert("HIii")
            if (!DateCheck())
                return false;
            //  alert("HIii")
            if (!FinDateCheck())
                return false;
        }
    </script>
    <div align="center">
        <%--<asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                    <ContentTemplate>
                                    <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                                <ProgressTemplate>
                                    <div id="progressArea">
                                        <asp:Label ID="lblLS" runat="server" Text="Please wait..." ForeColor="red" CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                        <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                                    </ContentTemplate>
                                </asp:UpdatePanel>--%>
    </div>
    <br />
    <div align="left">

       <asp:UpdatePanel ID="updatepanel311" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table style="width: 10.5in" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr>
                        <td height="30">
                            <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                                class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt; </strong><strong>Sales & Expense Register</strong> </font>
                        </td>
                    </tr>
                    <tr>
                        <td class="horzblue">
                            <img src="./../../images/clear.gif" width="2" height="1"></td>
                    </tr>
                    <tr>
                        <td align="right">
                            <a href="javascript:window.history.go(-1)" title="back">
                                <img alt="Back" src="./../../images/back.gif" border="0">
                            </a>
                        </td>
                    </tr>
                    <tr>
                        <td height="300" valign="top">
                            <table cellspacing="1" style="width: 9.5in" class="boxbg" align="left">
                                <tr class="bgbluegrey">
                                    <td colspan="7" align="center" style="height: 21px">
                                        <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Sales Criteria </asp:Label>
                                    </td>
                                </tr>


                                <tr id="Tr1" visible="true" runat="server" style="background-color: white">
                                    <td align="left" colspan="3">
                                        <asp:Label ID="Label12" CssClass="blackfnt" Text="Select Document Type" runat="server"></asp:Label></td>
                                    <td align="left" colspan="4" valign="top">
                                        <%-- <asp:UpdatePanel ID="updatepanel3" runat="server">
                                    <ContentTemplate>--%>
                                        <%--   <asp:DropDownList ID="documet_type" runat="server" AutoPostBack="true"  OnClick="Javascript:return SelectPartyCode()" >
                                        </asp:DropDownList>--%>
                                        <asp:RadioButtonList ID="documet_type" runat="server" RepeatDirection="horizontal" CssClass="blackfnt" OnClick="Javascript:return SelectPartyCode()">
                                            <%--<asp:ListItem Text="Bill" Selected="true" Value="B"></asp:ListItem>
                                    <asp:ListItem Text="MR" Value="M"></asp:ListItem>--%>
                                        </asp:RadioButtonList>
                                        <%--</ContentTemplate>
                                </asp:UpdatePanel>--%>
                                    </td>
                                </tr>
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="3" style="width: 3.5in">
                                        <font class="blackfnt">From</font>
                                    </td>
                                    <td align="center" colspan="4">
                                        <font class="blackfnt">To</font>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="left" colspan="3">
                                        <Location:LH ID="Fromlc" runat="server" />
                                    </td>
                                    <td align="left" colspan="4">
                                        <Location_to:LH_to ID="Tolc" runat="server" />
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="center" colspan="3">
                                        <font class="blackfnt">Select Documnet Date</font>
                                    </td>
                                    <td align="left" colspan="4">
                                        <Date:DT ID="DT" runat="server" />
                                    </td>
                                </tr>

                                <tr style="background-color: white">

                                    <td align="left" colspan="7">
                                        <!-- #include file="./SelectList_DKT.aspx"-->
                                       <%-- <asp:UpdatePanel ID="updatepanel4" runat="server">
                                            <ContentTemplate>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="documet_type" EventName="SelectedIndexChanged" />

                                            </Triggers>
                                        </asp:UpdatePanel>--%>
                                    </td>


                                </tr>

                                <tr align="center" bgcolor="white">
                                    <td colspan="7">
                                        <asp:Label ID="Label1" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                                    </td>
                                </tr>
                                <tr bgcolor="white">
                                    <td colspan="7">
                                        <asp:Label ID="Labesys" CssClass="blackfnt" runat="server" Text=" Document No(s). (System Generated No.) :� "></asp:Label>
                                        <asp:TextBox runat="server" Text="" ID="txtsysno" Width="250"> </asp:TextBox>
                                        <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                                    </td>
                                </tr>

                                <tr align="center" bgcolor="white">
                                    <td colspan="7">
                                        <%-- <asp:Label ID="Label4" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>--%>
                                    </td>
                                </tr>
                                <%--  <tr bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label5" CssClass="blackfnt" runat="server" Text=" Document No(s). (Manual No./Invoice No.):� "></asp:Label>
                    <asp:TextBox runat="server" Text="" ID="txtmanbo" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label6" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label9" CssClass="blackfnt" runat="server" Text=" Customer Ref. No./Vehicle No. :�� "></asp:Label>
                    <asp:TextBox runat="server" Text="" ID="txtCustRefno" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[seperated by <i>comma</i> if multiple]</font>
                </td>
            </tr>
            <tr align="center" bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label10" CssClass="blackfnt" Font-Bold="true" runat="server" Text=" OR "></asp:Label>
                </td>
            </tr>
            <tr bgcolor="white">
                <td colspan="7">
                    <asp:Label ID="Label11" CssClass="blackfnt" runat="server" Text=" Free Text :�� "></asp:Label>
                    <asp:TextBox runat="server" Text="" ID="txtFreeText" Width="250"> </asp:TextBox>
                    <font class="blackfnt">[Insert Remak Word]</font>
                </td>
            </tr>--%>
                                <tr style="background-color: white">

                                    <td align="left" colspan="7">
                                        <!-- #include file="./CHKLIST_DKT.aspx"-->
                                       <%-- <asp:UpdatePanel ID="updatepanel5" runat="server">
                                            <ContentTemplate>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="documet_type" EventName="SelectedIndexChanged" />

                                            </Triggers>
                                        </asp:UpdatePanel>--%>
                                    </td>

                                </tr>
                                <tr style="background-color: white">
                                    <td colspan="7" align="center" style="height: 21px">
                                        <asp:RadioButtonList ID="rptfrt" RepeatDirection="horizontal" CssClass="blackfnt" runat="server">
                                            <asp:ListItem Selected="True" Text="HTML Format" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="XLS Download" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="CSV Download" Value="3"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr align="center" bgcolor="white">
                                    <td colspan="7">
                                        <asp:Button ID="btnShow" OnClick="btnShow_Click" OnClientClick="Javascript: return OnSub_DATACHECK();"
                                            runat="server" Text="Show" Width="75px" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                </table>
          </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
<%--OnClick="btnShow_Click"--%>
