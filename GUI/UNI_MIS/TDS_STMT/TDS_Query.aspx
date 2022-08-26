<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="TDS_Query.aspx.cs" Inherits="GUI_UNI_MIS_TDS_Query_TDS_Query" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <!--Atlas Script Manager -->
    <!--End of Atlas Script Manager -->
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<%-- <script language="javascript" type="text/javascript" src="docket_javascript.js"></script>--%>
<script language="javascript" type="text/javascript" >
var cal = new CalendarPopup("testdiv1");
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();
</script>
    <script language="javascript" type="text/javascript">
     function ValidateData()
            {
           // debugger
               if(document.getElementById("ctl00_MyCPH1_cboSelType"))
                {
                    if(document.getElementById("ctl00_MyCPH1_cboSelType").value == "0")
                    {
                        alert("Please Select Atleast One");
                        document.getElementById("ctl00_MyCPH1_cboSelType").focus();
                        return false;
                    }
                }
                
                }
    </script>

    <div align="left" style="width: 10in">
        <br />
        <table align="left" style="width: 1100px">
            <tr>
                <td align="left">
                    <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                        <b>Reports</b></font></a> <b>&gt; </b><a href="../rpt_Finance.aspx"><font class="blklnkund">
                            <b>Finance</b></font></a> <b>&gt; </b><font class="bluefnt"><b>TDS Regester Report</b></font>
                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <asp:UpdatePanel ID="UpdatePanel3" runat="server"     UpdateMode="Conditional" RenderMode="Inline">
            <ContentTemplate>
                <table cellspacing="1" align="left" style="width: 100%">
                    <tr align="left">
                        <td align="left">
                            <table cellspacing="1" align="left" class="boxbg" style="width: 80%">
                                <tr align="left" class="bgbluegrey">
                                    <td align="center" colspan="3">
                                        <asp:Label ID="lblQry" runat="server" CssClass="blackfnt" Font-Bold="True">Select Party</asp:Label>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="right">
                                        <asp:Label ID="lblBookLoc" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Booking Location"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:DropDownList ID="cboBookLoc" Width="150" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr class="bgbluegrey">
                                    <td align="center" colspan="3">
                                        <asp:Label ID="lblQuery" runat="server" CssClass="blackfnt" Font-Bold="True">TDS Satatement Search Criteria</asp:Label>
                                    </td>
                                </tr>
                                
                                
                                
                                        <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td valign="top" align ="left">
                                                       <asp:Label ID="Label3"  CssClass="blackfnt" Text="Select Login Date" runat="server" Width="145px"></asp:Label>    
                                                            </td>
                                                        <td  align="left" style="width: 359px" valign="top">
                                                            <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1" Width="244px">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                          </asp:RadioButtonList></td>
                                                        
                                                        <td valign="top" align="left" style="width: 359px">
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                     <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
			   NAME="anchor1"  id="anchor1"><img src="./../../images/calendar.jpg" border="0"></img>
			</A>
                                    
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                                <A href="#"  onClick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
			   NAME="anchor2"  id="a1"><img src="./../../images/calendar.jpg" border="0"></img>
			</A> <br />
                                                            <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                                                OnServerValidate="daterange"></asp:CustomValidator>
                                                              <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                        ErrorMessage="Date From cannot be blank dsdsdsd :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                        ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                               
                                                                  </tr>
                            <%--    <tr style="background-color: white">
                                    <td align="right">
                                        <asp:Label ID="lblDateRange1" runat="server" CssClass="blackfnt" Font-Bold="True">Select Document Date Range:</asp:Label>
                                    </td>
                                    <td align="left">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
                                            <ContentTemplate>
                                                <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                                    OnSelectedIndexChanged="radDate_OnSelectedIndexChange" ValidationGroup="VGDtFromTo">
                                                    <asp:ListItem Selected="True" Text=" Date Range [dd/mm/yyyy]" Value="0"></asp:ListItem>
                                                    <asp:ListItem Selected="false" Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                                    <asp:ListItem Selected="false" Text=" Today:" Value="2"></asp:ListItem>
                                                    <asp:ListItem Selected="false" Text=" Till Date:" Value="3"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                    <td align="left" valign="top">
                                        <asp:UpdatePanel ID="UpdatePanel2" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                                            <ContentTemplate>
                                                <asp:Label ID="lblFrom" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                                                <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                                 <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;" name="anchor1" id="a1" ><img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0">

                                                            </a>
                                                <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                                <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor11','dd/MM/yyyy'); return false;" name="anchor11" id="anchor11" ><img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"></a>
                                                
                                                <br />
                                                
                                                <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                                                OnServerValidate="daterange"></asp:CustomValidator>
                                                              <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                        ErrorMessage="Date From cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                        ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                                
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>--%>
                                <tr style="background-color: white">
                                    <td align="right">
                                        <asp:Label ID="lblSelType" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select Type"></asp:Label>
                                    </td>
                                    <td align="left" colspan="2">
                                        <asp:DropDownList ID="cboSelType" runat="server" AutoPostBack="true" OnTextChanged="doOnDataBound">
                                            <asp:ListItem Text="--Select--" Value="0"></asp:ListItem>
                                            <asp:ListItem Text="Receivable" Value="r"></asp:ListItem>
                                            <asp:ListItem Text="Payable" Value="p"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="right">
                                        <asp:Label ID="lblVendor" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select Vendor"
                                            Visible="False"></asp:Label>
                                        <asp:Label ID="lblCust" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Select Customer"
                                            Visible="False"></asp:Label></td>
                                    <td align="left" colspan="2">
                                        <asp:TextBox ID="txtVendor" runat="server" Visible="False"></asp:TextBox>
                                        <input id="btnVendor" type="button" name="" runat="server" visible="false" />
                                        <asp:TextBox ID="txtCust" runat="server" Visible="False"></asp:TextBox>
                                        <input id="btnCust" type="button" name="" runat="server" visible="false" />&nbsp;
                                        <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True" Text="OR"
                                            Visible="False"></asp:Label>&nbsp;
                                        <asp:TextBox ID="txtCust1" runat="server" Width="48px" Visible="False" ReadOnly="True">8888</asp:TextBox>
                                        <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True" Text=":"
                                            Visible="False"></asp:Label>&nbsp;
                                        <asp:TextBox ID="txtCust2" runat="server" Visible="False"></asp:TextBox></td>
                                </tr>
                                <tr style="background-color: white">
                                    <td align="center" colspan="3">
                                        <asp:UpdatePanel ID="UPShowBrands" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                                            <ContentTemplate>
                                                <asp:Button ID="btnShowTDS" runat="server" OnClick="btnShowTDS_OnClick" Text="Show TDS (s) >>"
                                                    ValidationGroup="VGDtFromTo" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <br />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
</asp:Content>
