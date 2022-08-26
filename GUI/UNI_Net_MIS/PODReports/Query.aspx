<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Query.aspx.cs" Inherits="GUI_UNI_Net_MIS_PODReports_Query" %>


<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy.ascx" %>
<%@ Register TagName="DT" TagPrefix="Date" Src="~/GUI/Common_UserControls/RPT_Date.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script type="text/javascript">

        var txtCustomerNameID = '<%=txtCustomerName.ClientID%>';
        var hdnCustID = '<%=hdnCust.ClientID%>';

        var txtOriginID = '<%=txtOrigin.ClientID%>';
        var hdnOriginID = '<%=hdnOrigin.ClientID%>';

        var txtDestinationID = '<%=txtDestination.ClientID%>';
        var hdnDestinationID = '<%=hdnDestination.ClientID%>';

        var serviceUrl = '<%=ResolveClientUrl("~/services/GSTCommonService.asmx")%>';
    </script>
    <script language="javascript" type="text/javascript" src="JS/GSTCommon.js?v=22"></script>
    <script language="javascript" type="text/javascript" src="JS/CustomerGSTRegistration.js?v=22"></script>

    <script language="JavaScript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="./../../images/commonJs.js"></script>
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

        function OnSub_DATACHECK() {
            //alert("HIii")
            if (!DateCheck())
                return false;
            //  alert("HIii")
            //if(!FinDateCheck())
            //    return false;             
        }
        
        function onReportTypeChange(ctrl) {
            if ($("#ctl00_MyCPH1_rbType_2").prop("checked")) {
                $("#trAgingRegister").show();
                $("#trStatusRegister").show();
            } else {
                $("#trAgingRegister").hide();
                $("#trStatusRegister").hide();
            }
            
        }
        
    </script>

    <input type="hidden" id="hdnRptId" runat="server" />
    <%-- added by Manisha 23/5/2014 --%>
    <div align="left">
        <table style="width: 8.5in" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td height="30">
                    <font class="blklnkund"><strong>Module</strong></font> <strong>&gt; </strong><font
                        class="blklnkund"><strong>Reports </strong></font><font class="bluefnt"><strong>&gt;
                        </strong><strong>Docket POD Register Report</strong> </font>
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
                    <table cellspacing="1" cellpadding="3" style="width: 8.0in" class="boxbg" align="left">
                        <tr class="bgbluegrey">
                            <td colspan="3" align="center" style="height: 21px">
                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Select Report Criteria </asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center" style="width: 3.5in">
                                <font class="blackfnt">Select Location</font>
                            </td>
                            <td align="left">
                                <Location:LH ID="Fromlc" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center">
                                <font class="blackfnt">Select Date </font>
                            </td>
                            <td align="left" colspan="2">
                                <Date:DT ID="DT" runat="server" />
                            </td>
                        </tr>

                        <tr style="background-color: white">
                            <td align="center">Select Customer
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox CssClass="ltxt" runat="server" ID="txtCustomerName" onblur="return onValidateCustomerExist(this)" Width="350px"></asp:TextBox>
                                <asp:HiddenField runat="server" ID="hdnCust"></asp:HiddenField>
                            </td>
                        </tr>

                        <tr style="background-color: white">
                            <td align="center">Select Origin
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox CssClass="ltxt" runat="server" ID="txtOrigin" onblur="return onValidateLocationExist(this);" />
                                <asp:HiddenField ID="hdnOrigin" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center">Select Destination
                            </td>
                            <td align="left" colspan="2">
                                <asp:TextBox CssClass="ltxt" runat="server" ID="txtDestination" onblur="return onValidateLocationExist(this);" />
                                <asp:HiddenField ID="hdnDestination" runat="server" />
                            </td>
                        </tr>

                        <tr style="background-color: white">
                            <td align="center">Select Type
                            </td>
                            <td align="left" colspan="2">
                                <asp:RadioButtonList runat="server" ID="rbType" RepeatDirection="Horizontal" onclick="onReportTypeChange(this);">
                                    <asp:ListItem Text="Customer Wise (Summary)" Value="C" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Location Wise (Summary)" Value="L"></asp:ListItem>
                                    <asp:ListItem Text="Register" Value="R"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr style="background-color: white;display:none;" id="trAgingRegister">
                            <td align="center">Select Aging
                            </td>
                            <td align="left" colspan="2">
                                <asp:DropDownList runat="server" ID="DDLAgingList">
                                    <asp:ListItem Text="ALL" Value="0" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="1 - 7 Days" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="8 - 15 Days" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="16 - 30 Days" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="31 - 45 Days" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="46 - 60 Days" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="61 - 90 Days" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="91 - 120 Days" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="121 - 180 Days" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="181 - 365 Days" Value="9"></asp:ListItem>
                                    <asp:ListItem Text="> 365 Days" Value="10"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="background-color: white;display:none;" id="trStatusRegister">
                            <td align="center">Select Status
                            </td>
                            <td align="left" colspan="2">
                                <asp:DropDownList ID="ddlStatus" runat="server">
                                    <asp:ListItem Text="ALL" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Booked" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="Billed" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Unbilled" Value="3"></asp:ListItem>
                                     <asp:ListItem Text="POD pending" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Billing Pending" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Handover Pending" Value="6"></asp:ListItem>
									<asp:ListItem Text="Acknowledgement Pending" Value="8"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="center" class="bgbluegrey">
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
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>
