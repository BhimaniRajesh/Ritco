<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="AdvanceBillSearch.aspx.cs" Inherits="GUI_Finance_Vendor_BA_payment_PaymentAgainstBillEntry_AdvanceTHCVendorPaymentInstallmentWise_AdvanceBillSearch" %>

<%@ Register TagName="LH" TagPrefix="Location" Src="~/GUI/Common_UserControls/LocationHirarchy_Location_Wise_BankDetail.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript">
        var cal = new CalendarPopup("testdiv1");
        cal.setCssPrefix("TEST");
        cal.showNavigationDropdowns();

        function ClearSelection(param) {

            if (param == "VENDOR") {
            }


            if (param == "BN") {
                document.getElementById('ctl00_MyCPH1_ddlro').selectedIndex = 0;
                document.getElementById('ctl00_MyCPH1_cboVendor2').selectedIndex = 0;
            }
            if (param == "VB") {
                document.getElementById('ctl00_MyCPH1_ddlro').selectedIndex = 0;
                document.getElementById('ctl00_MyCPH1_cboVendor2').selectedIndex = 0;
            }

            if (param == "VN") {
                document.getElementById('ctl00_MyCPH1_ddlro').selectedIndex = 0;
                document.getElementById('ctl00$MyCPH1$cboVendor2').selectedIndex = 0;
            }
        }

        function validcheck() {
            //if (document.getElementById('ctl00_MyCPH1_ddlro').selectedIndex == "0") {
                   // alert("Select Location");
                    //document.getElementById('ctl00_MyCPH1_ddlro').focus();
                    //return false;
                //}
                if (document.getElementById('ctl00_MyCPH1_cboVendor2').selectedIndex == "0") {
                    alert("Select Vendor");
                    document.getElementById('ctl00_MyCPH1_cboVendor2').focus();
                    return false;
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
                            <td align="center" colspan="3"><font class="blackfnt"><b>Bill / Voucher View Print</b></font></td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                         <td  align="left">Select Branch :</td>
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
                            <td valign="top">
                                <font class="blackfnt">
                                    <asp:Label ID="Label3" runat="server" Text="Select Vendor"></asp:Label>
                                </font>
                            </td>
                            <td valign="top" align="left">
                                <asp:UpdatePanel ID="updatepanel12" runat="server">
                                    <ContentTemplate>
                                        <asp:DropDownList ID="cboVendor2" runat="server" onchange="javascript:ClearSelection('VENDOR')" AutoPostBack="true">
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
                                        <td align="left" width="35%">
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
                                                    <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom" CssClass="blackfnt" ErrorMessage="Date From cannot be blank :(" ValidationGroup="VGDtFromTo" />                                                    
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtDateFrom" ErrorMessage="Invalid Date From  :(" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))" ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>                                                    
                                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo" CssClass="blackfnt" ErrorMessage="Date To cannot be blank :(" ValidationGroup="VGDtFromTo" />                                                    
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtDateTo" ErrorMessage="Invalid Date To  :(" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))" ValidationGroup="VGDtFromTo"></asp:RegularExpressionValidator>                                                   
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
                            <td valign="top" colspan="3">
                                <center><font class="blackfnt"><b>OR</b>
                                </font></center>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff">
                            <td valign="top">
                                <label>Enter Document No.</label>
                            </td>
                            <td>
                                <input type="text" runat="server" id="txtDocNo" />
                            </td>
                        </tr>                        
                    </table>
                </td>
            </tr>
           
            
            <tr bgcolor="#ffffff">
                <td bgcolor="#ffffff" align="center">
                    <asp:Button ID="btnsubmit1" runat="server" CssClass="blackfnt" Text="Submit" OnClick="btnsubmit1_Click" />
                </td>
            </tr>                         
                               
            <tr id="trTrueResult" runat="server" style="display:none">
            <td>
                <table width="80%" border="0" align="left" cellpadding="3" cellspacing="1" bgcolor="#808080" class="boxbg"  >
                <tr class="bgbluegrey">
                    <td align="center"><font class="blackfnt"><b>Result</b></font></td>
                </tr>
                <tr>
                    <td align="left">
                    <asp:UpdatePanel ID="u1" UpdateMode="Always" runat="server">
                    <ContentTemplate>
                        <asp:DataGrid ID="gvViewPrint" runat="server" PageSize="1000" AutoGenerateColumns="False" CellPadding="2" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CssClass="Styles.css" CellSpacing="1" Width="100%" Height="1px" ItemStyle-HorizontalAlign="Left">
                            <FooterStyle BackColor="#8BA0E5" ForeColor="#003399" />
                            <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <PagerStyle NextPageText="Next" PrevPageText="Previous" HorizontalAlign="Center" Font-Bold="True" Font-Underline="True" BackColor="#8BA0E5" ForeColor="White" Wrap="False" Mode="NumericPages" CssClass="whitefnt"></PagerStyle>
                            <ItemStyle BackColor="White" ForeColor="#003399" CssClass="blackfnt" />
                            <HeaderStyle BackColor="#336699" CssClass="whitefnt" ForeColor="White" Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
                            <Columns>
                                <asp:BoundColumn DataField="DocumentNo" HeaderText="Document No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" width="2in" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="VendorName" HeaderText="Vendor Name">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="PaymentMode" HeaderText="Payment Mode">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="PaymentDate" HeaderText="Payment Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                                <asp:BoundColumn DataField="Amount" HeaderText="Amount">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                </asp:BoundColumn>
                               <asp:HyperLinkColumn DataNavigateUrlField="DocumentNo" Target="_blank" DataNavigateUrlFormatString="../../../../UNI_Net_MIS/THCAdvVendrBillPay/Result.aspx?DocumentNo={0},0" Text="View" HeaderText="View" HeaderStyle-HorizontalAlign="Left" >
                                    <ItemStyle CssClass="bluefnt"/>
                                    <HeaderStyle Width="50px" />
                                </asp:HyperLinkColumn>
                            </Columns>
                        </asp:DataGrid>
                    </ContentTemplate>
                    </asp:UpdatePanel>           
                    </td>
                </tr>
            </table>
            </td>
            </tr>
              
            <tr id="trZeroResult" runat="server" style="display:none">
            <td>
                <table width="80%" border="0" align="left" cellpadding="3" cellspacing="1" bgcolor="#808080" class="boxbg">
                <tr class="bgbluegrey">
                    <td align="center"><font class="blackfnt"><b>Result</b></font></td>
                </tr>
                <tr>
                    <td align="left">
                             No Records Found
                    </td>
                </tr>
            </table>
            </td>
            </tr>
                  
       </table>

    </div>    
    <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></div>   
</asp:Content>


