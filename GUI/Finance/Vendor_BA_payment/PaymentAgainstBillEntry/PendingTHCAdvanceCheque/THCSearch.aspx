<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="THCSearch.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_PendingTHCAdvanceCheque_THCSearch" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy_Location_Wise_BankDetail.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function ClearSelection(param) {

            if (param == "VENDOR") {
                //document.getElementById('ctl00$MyCPH1$txtDocNo').value = "";
                //document.getElementById('ctl00$MyCPH1$txtVendorBillNo').value = "";
            }


            if (param == "BN") {
                document.getElementById('ctl00$MyCPH1$cbovendortype').selectedIndex = 0;
                document.getElementById('ctl00$MyCPH1$cboVendor2').selectedIndex = 0;
                //document.getElementById('ctl00$MyCPH1$txtVendorBillNo').value = "";
            }
            if (param == "VB") {
                document.getElementById('ctl00$MyCPH1$cbovendortype').selectedIndex = 0;
                document.getElementById('ctl00$MyCPH1$cboVendor2').selectedIndex = 0;
                //document.getElementById('ctl00$MyCPH1$txtDocNo').value = "";
            }

            if (param == "VN") {
                document.getElementById('ctl00$MyCPH1$cbovendortype').selectedIndex = 0;
                document.getElementById('ctl00$MyCPH1$cboVendor2').selectedIndex = 0;
                //document.getElementById('ctl00$MyCPH1$txtDocNo').value = "";
                //document.getElementById('ctl00$MyCPH1$txtVendorBillNo').value = "";
            }
        }

        function validcheck() {
            //var txtDocNo = document.getElementById('ctl00$MyCPH1$txtDocNo').value
            //var txtVendorBillNo = document.getElementById('ctl00$MyCPH1$txtVendorBillNo').value
            var txtVehicleNo = "";//document.getElementById('ctl00$MyCPH1$txtVehicleNo').value

            if (txtVehicleNo == "") {
                //if (document.getElementById('ctl00$MyCPH1$cbovendortype').value == "0") {
                //    alert("Select Vendor Type");
                //    document.getElementById('ctl00$MyCPH1$cbovendortype').focus();
                //    return false;
                //}
                //if (document.getElementById('ctl00$MyCPH1$cboVendor2').value == "0") {
                //    alert("Select Vendor");
                //    document.getElementById('ctl00$MyCPH1$cboVendor2').focus();
                //    return false;
                //}
            }
            return true;
        }
    </script>
    <br />
    <asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank"
                style="border: 0px; position: absolute; z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth); height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft); top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../../images/loading.gif" /><font face="verdana" color="blue" size="4">&nbsp;<b>Please Wait...</b></font>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div align="left">
        <table width="80%" border="0" align="left" cellpadding="3" cellspacing="1">
            <tr>
                <td>
                    <table width="80%" border="0" align="left" cellpadding="3" cellspacing="1" bgcolor="#808080" class="boxbg">
                        <tr class="bgbluegrey">
                            <td align="center" colspan="3"><font class="blackfnt"><b>Prepare Payment Voucher 
                            </b></font></td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td align="center">Select Branch :</td>
                            <td>
                                <asp:UpdatePanel ID="up3" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="ddlro" runat="server" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>


                        <tr bgcolor="#ffffff">
                            <td valign="top"><font class="blackfnt">Document date range </font></td>
                            <td colspan="2" valign="top">
                                <table width="100%" height="100%">
                                    <tr>
                                        <td align="left">
                                            <asp:UpdatePanel ID="UpdatePanel9" runat="server">
                                                <ContentTemplate>
                                                    <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                                        <asp:ListItem Selected="True" Value="0" Text="Date Range [dd/mm/yyyy]"></asp:ListItem>
                                                        <asp:ListItem Selected="false" Value="1" Text="Last Week (Including Today)"></asp:ListItem>
                                                        <asp:ListItem Selected="false" Value="2" Text="Today:"></asp:ListItem>
                                                        <asp:ListItem Selected="false" Value="3" Text="Till Date:"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <td valign="top" align="left">
                                            <asp:UpdatePanel ID="UpdatePanel10" runat="server">
                                                <ContentTemplate>
                                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor112','dd/MM/yyyy'); return false;" name="anchor112" id="anchor112">
                                                        <img src="../../../../images/calendar.jpg" border="0" />
                                                    </a>
                                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor113','dd/MM/yyyy'); return false;" name="anchor113" id="a1">
                                                        <img src="../../../../images/calendar.jpg" border="0" />
                                                    </a>
                                                    </br>
                                                        <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                                            ErrorMessage="Date From cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                                    </br>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                                            ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                                    </br>
                                                        <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                                            ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                                    </br>
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                                            ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" runat="server">
                            <td valign="top" colspan="3" align="center">
                                <font class="blackfnt"><b>OR</b>
                                </font>
                            </td>
                        </tr>

                        <tr bgcolor="#FFFFFF"> 
                                <td align="left"><font class="blackfnt">Select Vendor Type&nbsp;&nbsp;
                                <td colspan="2" align="left">
                                
                                <asp:UpdatePanel ID="updatepanel2" runat="server">
                                  <ContentTemplate>
                                   <asp:DropDownList ID="cbovendortype" runat="server" Width="200px" AutoPostBack="true" OnSelectedIndexChanged="cbovendortype_SelectedIndexChanged">
                                     
                                   </asp:DropDownList>
                                  
                                  </ContentTemplate>
                                  </asp:UpdatePanel>
                                 
                                </td>
                              </tr>
                              <tr bgcolor="#FFFFFF"> 
                                <td align="left"><font class="blackfnt">Select Vendor &nbsp;&nbsp;</td>
                                <td colspan="2" align="left">
                                <asp:UpdatePanel ID="updatepanel5" runat="server">
                                  <ContentTemplate>
                                   <asp:DropDownList ID="cbovendor" CssClass="blackfnt" runat="server">
                                     <asp:ListItem > Select </asp:ListItem>
                                   </asp:DropDownList>
                                  
                                  </ContentTemplate>
                                  <Triggers>
               <asp:AsyncPostBackTrigger ControlID="cboVendorType" EventName="SelectedIndexChanged" />
         </Triggers>
                                  </asp:UpdatePanel>
                                </td>
                              </tr>

                        <tr bgcolor="#ffffff" runat="server" visible="false">
                            <td valign="top">
                                <font class="blackfnt">
                                    <asp:Label ID="lblDocument" runat="server" Text="Bill Entry Number"></asp:Label>
                                </font>
                            </td>
                            <td valign="top" align="left">
                                <asp:TextBox ID="txtDocNo" runat="server" Width="164px" onchange="javascript:ClearSelection('BN')"></asp:TextBox><font class="blackfnt">(If Multiple - separated by comma)</font>
                            </td>

                        </tr>
                        <tr bgcolor="#ffffff" runat="server" visible="false">
                            <td valign="top" colspan="3" align="center">
                                <font class="blackfnt"><b>OR</b>
                                </font>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" runat="server" visible="false">
                            <td valign="top">
                                <font class="blackfnt">
                                    <asp:Label ID="Label1" runat="server" Text="Vendor Bill Number"></asp:Label>
                                </font>
                            </td>
                            <td valign="top" align="left">
                                <asp:TextBox ID="txtVendorBillNo" runat="server" Width="164px" onchange="javascript:ClearSelection('VB')"></asp:TextBox><font class="blackfnt">(If Multiple - separated by comma)</font>
                            </td>

                        </tr>
                        <asp:TextBox ID="txtVehicleNo" Visible="False" runat="server" Width="164px" onchange="javascript:ClearSelection('VN')"></asp:TextBox>
                    </table>
                </td>
            </tr>
            <tr bgcolor="#ffffff">
                <td align="center" bgcolor="#ffffff">
                    <asp:Button ID="btnsubmit1" runat="server" CssClass="blackfnt" Text="Submit" OnClick="btnsubmit1_Click" />
                </td>
            </tr>
        </table>
    </div>
    <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>
</asp:Content>
