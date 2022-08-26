<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="PrepareJob.aspx.cs" Inherits="GUI_Fleet_Job_PrepareJob" %>

<%@ Register TagPrefix="SControls" TagName="DateSelector" Src="~/LED/DateSelector.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script src="../../images/DateControl.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>

    <script language="javascript" type="text/javascript" src="AJAX_Validator/PrepareJobSheet.js"> </script>

    <script language="javascript" type="text/javascript">
var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");

var FinYear="<%=Session["FinYear"]%>"
var FinYear_to=parseInt(FinYear)+1
	
if(FinYear_to<10)
{
    FinYear_to="0"+FinYear_to
}
var FinYear_fromdate="01/04/"+FinYear
var FinYear_todate="31/03/"+FinYear_to
var Sle_finyear=FinYear+"-"+FinYear_to

    </script>

    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
    <table cellspacing="1" style="width: 800px">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Prepare Job Order</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
            <td align="right">
                <asp:UpdateProgress ID="uppMain" runat="server">
                    <ProgressTemplate>
                        <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
                            -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                            <tr>
                                <td align="right">
                                    <img src="../../images/loading.gif" alt="" />
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
            </td>
        </tr>
    </table>
    <br />
    <br />
    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <asp:Table runat="server" ID="MainTbl">
                <asp:TableRow runat="server" ID="Job_Hdr">
                    <asp:TableCell>
                        <%--<table  align="center"  cellspacing="2" width="95%" >    
                                                               
    <tr  align="center"   style="background-color: white">
--%>
                        <table align="left" cellspacing="2" width="800px" class="boxbg">
                            <tr style="background-color: white">
                                <td colspan="4" align="center">
								    <asp:HiddenField ID="hf_Vehicle_Attached_TS" runat="server" />
                                    <asp:HiddenField ID="hf_Vehicle_Attached_JS" runat="server" />
                                    <asp:HiddenField ID="hf_Labour_Cost_TaskWise" runat="server" />
                                    <asp:Label ID="lblError" runat="server" CssClass="blackfnt" Font-Bold="true" ForeColor="red"></asp:Label>
                                </td>
                            </tr>
                            <tr class="bgbluegrey">
                                <td colspan="4" align="center">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Prepare Job Order</asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white">
                                <td align="left">
                                    <asp:Label ID="Label4" runat="server" CssClass="bluefnt" Text="Vehicle No."></asp:Label>
                                </td>
                                <td align="left">
                                    <%--OnTextChanged="txtVehNo_TextChanged" AutoPostBack="true" onblur="javascript:hitme()"--%>
                                    <asp:TextBox ID="txtVehicleNo" runat="server" CssClass="input" BorderStyle="Groove">
                                    </asp:TextBox>
                                    <asp:Label ID="lblPopup" runat="server" BorderStyle="Groove" TabIndex="18" Text='<a href="javascript:nwOpen(1)">...</a>'
                                        Width="14px" Height="16px"></asp:Label>
                                    <asp:RequiredFieldValidator ID="ReqtxtVehicleNo" runat="server" Display="Dynamic"
                                        Text="!" ControlToValidate="txtVehicleNo"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lblCheck" runat="server" ForeColor="red" Visible="false" />
                                </td>
                                <td align="left">
                                    <asp:Label ID="Label1" runat="server" Text="Vehicle Category" CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="lblCategory" BorderStyle="None" onfocus="this.blur()" runat="server"
                                        CssClass="blackfnt" />
                                </td>
                            </tr>
                            <tr style="background-color: white" align="center">
                                <td align="left">
                                    <asp:Label ID="Label2" runat="server" Text="Manufacturer" CssClass="bluefnt" />
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="lblMfg" runat="server" BorderStyle="None" onfocus="this.blur()"
                                        CssClass="blackfnt" />
                                </td>
                                <td align="left">
                                    <asp:Label ID="Label3" runat="server" Text="Model" CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="lblModel" runat="server" onfocus="this.blur()" BorderStyle="None"
                                        CssClass="blackfnt" />
                                </td>
                            </tr>
                            <tr style="background-color: white" align="center">
                                <td align="left">
                                    <asp:Label ID="Label5" runat="server" Text="Work Order No" CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblDriverCodeVal" runat="server" CssClass="redfnt" Text="Sys. Generated"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:Label ID="Label7" runat="server" Text="Job Order Date" CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtOrderDate" runat="server" onblur="javascript:ValidateDate(this)"
                                        BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtOrderDate,'anchor22','dd/MM/yyyy'); return false;"
                                        id="a1" name="anchor22">
                                        <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                </td>
                            </tr>
                            <tr style="background-color: white" align="center">
                                <td align="left">
                                    <asp:Label ID="Label9" runat="server" Text="JobCard Type" CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlOrderType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlOrderType_OnSelectedIndexChanged"
                                        CssClass="blackfnt">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic"
                                        Text="!" ControlToValidate="ddlOrderType"></asp:RequiredFieldValidator>
                                    <%-- <asp:ListItem Value="" Selected="true">Select</asp:ListItem>
                                    
                                    <asp:ListItem Value="Repair/Breakdown">Repair/Breakdown</asp:ListItem>
                                    <asp:ListItem Value="Manual Preventive Maintainence">Manual Preventive Maintainence</asp:ListItem>
--%>
                                </td>
                                <td align="left">
                                    <asp:Label ID="Label11" runat="server" Text="Order Status" CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblOrderStatus" runat="server" CssClass="blackfnt">
                                 
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr style="background-color: white" align="center">
                                <td align="left">
                                    <asp:Label ID="Label13" runat="server" Text="Service Centre Type " CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlSCtype" runat="server" Width="100px" AutoPostBack="true"
                                        CssClass="blackfnt" OnSelectedIndexChanged="ddlSCtype_SelectedIndexChanged">
                                        <asp:ListItem Value="" Selected="true">-- Select --</asp:ListItem>
                                        <asp:ListItem Value="Workshop">Workshop</asp:ListItem>
                                        <asp:ListItem Value="Vendor">Vendor</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic"
                                        Text="!" ControlToValidate="ddlSCtype"></asp:RequiredFieldValidator>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblVendor" runat="server" Text="Vendor Name" CssClass="bluefnt" Visible="false"></asp:Label>
                                    <asp:Label ID="lblWLoc" runat="server" Text="Workshop Location" CssClass="bluefnt"
                                        Visible="false"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlVendor" runat="server" CssClass="blackfnt" Visible="false">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlWLoc" runat="server" CssClass="blackfnt" Visible="false">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr style="background-color: white" align="center">
                                <td align="left">
                                    <asp:Label ID="Label8" runat="server" Text="Send date to WorkShop " CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left" nowrap>
                                    <%-- <SControls:DateSelector     ID="txtDCSendDt_WS" runat="server" /> --%>
                                    <asp:TextBox ID="txtDCSendDt" runat="server" onblur="javascript:ValidateDate(this)"
                                        BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDCSendDt,'anchor23','dd/MM/yyyy'); return false;"
                                        id="a2" name="anchor23">
                                        <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                </td>
                                <td align="left">
                                    <asp:Label ID="Label10" runat="server" Text="Estimated return date " CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left" nowrap>
                                    <%-- <SControls:DateSelector ID="txtDCReturnDt_WS" runat="server" /> --%>
                                    <asp:TextBox ID="txtDCReturnDt" runat="server" onblur="javascript:ValidateDate(this)"
                                        BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDCReturnDt,'anchor24','dd/MM/yyyy'); return false;"
                                        id="a3" name="anchor24">
                                        <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                </td>
                            </tr>
                            <tr style="background-color: white" align="center">
                                <td align="left">
                                    <asp:Label ID="Label18" runat="server" Text="Current KM Reading" CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtKMReading" runat="server" onfocus="this.blur()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                        BorderStyle="None">
                                 
                                    </asp:TextBox>
                                    <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic" Text="!" ControlToValidate="txtKMReading"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txtKMReading" Display="Dynamic"></asp:RegularExpressionValidator>                    --%>
                                </td>
                                <td align="left">
                                    <asp:Label ID="Label12" runat="server" Text="Labour Cost per Hour" CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtEstLabourHrs" runat="server" Style="text-align: right" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                        BorderStyle="Groove" CssClass="input">
                                 
                                    </asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"
                                        Text="!" ControlToValidate="txtEstLabourHrs"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="!"
                                        ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtKMReading"
                                        Display="Dynamic"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr style="background-color: white" align="center">
                                <td align="left">
                                    <asp:Label ID="lblKM" runat="server" Text="Tmp Current KM Reading" CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left" colspan="3">
                                    <asp:TextBox ID="txt_Tmp_CurrentKM" runat="server" Text="0" Style="text-align: right"
                                        CssClass="input" BorderStyle="Groove" />
                                </td>
                            </tr>
                            <tr style="background-color: white" runat="server" id="rowCost" align="center">
                                <td align="left">
                                    <asp:Label ID="Label20" runat="server" Text="Total Estimated Labour Hrs" Font-Bold="true"
                                        CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txttotEstHrs" onfocus="this.blur()" runat="server" CssClass="input"
                                        Style="text-align: right" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                        BorderStyle="Groove">
                                    </asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ID="reqtxtEstHrs" runat="server" Display="Dynamic" Text="!" ControlToValidate="txttotEstHrs"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegtxtEstHrs" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txttotEstHrs" Display="Dynamic"></asp:RegularExpressionValidator>                    --%>
                                </td>
                                <td align="left">
                                    <asp:Label ID="Label22" runat="server" Text="Total Estimated Labour Cost" Font-Bold="true"
                                        CssClass="bluefnt"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txttotEstCost" onfocus="this.blur()" runat="server" CssClass="input"
                                        Style="text-align: right" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                        BorderStyle="Groove">
                                 
                                    </asp:TextBox>
                                    <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic" Text="!" ControlToValidate="txttotEstCost"></asp:RequiredFieldValidator>
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                    ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                                    ControlToValidate="txttotEstCost" Display="Dynamic"></asp:RegularExpressionValidator>    --%>
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server" ID="rowTaskDet" Visible="false">
                    <asp:TableCell>
                        <%-- </tr>
          
     <tr  runat="server" id="No_SM" align="center"   style="background-color: white">
       --%>
                        <br />
                        <table cellspacing="1" class="boxbg" border="0" width="800px">
                            <tr class="bgbluegrey">
                                <td width="75%">
                                    <asp:Label ID="Label6" CssClass="blackfnt" Font-Bold="true" runat="server" Width="500px">Task Details</asp:Label>
                                </td>
                                <td align="left" width="30%">
                                    <asp:Label CssClass="blackfnt" ID="Label15" runat="server" Width="100px">Enter no. of rows </asp:Label>
                                </td>
                                <td width="5%">
                                    <asp:TextBox ID="txtTaskRow" MaxLength="2" runat="server" Width="20" BorderStyle="Groove"
                                        onkeypress="javascript:validFloat(event,this.getAttribute('id'))" Text="0" AutoPostBack="true"
                                        OnTextChanged="txtTaskRow_TextChanged"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegtxtRow" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                        SetFocusOnError="true" ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                                </td>
                                <td width="5%">
                                    <asp:Panel ID="pnlTaskDet" runat="server" Width="25px">
                                        <asp:Label ID="lblTaskL" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <table cellspacing="2" align="center">
                            <tr align="center">
                                <td align="left">
                                    <asp:Panel ID="pblTask" runat="server">
                                        <asp:GridView ID="gvTaskDetails" runat="server" OnRowDataBound="gvTaskDetails_ItemDataBound"
                                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                                            CellSpacing="1" CssClass="dgRowStyle" HeaderStyle-CssClass="dgHeaderStyle" PagerStyle-HorizontalAlign="left">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Work Group">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblWorkGroup" runat="server" CssClass="blackfnt"></asp:Label>
                                                        <asp:DropDownList ID="ddlWorkGroup" runat="server" Width="150px" AutoPostBack="true"
                                                            CssClass="blackfnt" OnSelectedIndexChanged="ddlWorkGroup_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="ReqddlWorkGroup" runat="server" Display="Dynamic"
                                                            Text="!" ValidationGroup="Group11" ControlToValidate="ddlWorkGroup"></asp:RequiredFieldValidator>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Task Description">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlTask" runat="server" Width="350px" CssClass="blackfnt">
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Task Type">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlTaskType" runat="server">
                                                        </asp:DropDownList>
                                                        <%--<asp:TextBox ID="txtTaskType"  MaxLength="10" runat="server"  Width="150px" BorderStyle="None" ></asp:TextBox>--%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Estimated Labour Hours">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtEstHrs" Style="text-align: right" MaxLength="10" CssClass="input"
                                                            onkeydown="return numeric(event)" runat="server" Width="50px" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Estimated Labour Cost">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtEstCost" Style="text-align: right" MaxLength="10" runat="server"
                                                            Width="50px" BorderStyle="None"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Remarks">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtRemarks" runat="server" BorderStyle="Groove" CssClass="input"
                                                            Width="200px"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <PagerStyle HorizontalAlign="Left" />
                                            <HeaderStyle CssClass="dgHeaderStyle" />
                                        </asp:GridView>
                                    </asp:Panel>
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender4" runat="Server"
                                        TargetControlID="pblTask" Collapsed="false" ExpandControlID="pnlTaskDet" CollapseControlID="pnlTaskDet"
                                        TextLabelID="lblTaskL" CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" />
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server" ID="rowManualTaskbtn" Visible="false">
                    <asp:TableCell>
                        <br />
                        <table runat="server" id="Table1" cellspacing="1" width="800px" class="boxbg" border="0">
                            <tr class="bgbluegrey">
                                <td width="100%" align="right">
                                    <asp:Button ID="btnAddManualTask" OnClick="btnAddManualTask_Click" Text="Add Manual Task"
                                        Width="200px" CssClass="blackfnt" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server" ID="rowSMTaskbtn" Visible="false">
                    <asp:TableCell>
                        <br />
                        <table runat="server" id="tblSMTaskbtn" cellspacing="1" width="800px" class="boxbg"
                            border="0">
                            <tr class="bgbluegrey">
                                <td width="100%" align="right">
                                    <asp:Button ID="btnAddSMTask" OnClick="btnAddSMTask_Click" Text="Add Scheduled Maintenance Task"
                                        Width="200px" CssClass="blackfnt" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server" ID="TableRow1">
                    <asp:TableCell>
                        <asp:Label ID="lblSMTaskErr" runat="server" CssClass="redfnt"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server" ID="rowSMTask" Visible="false">
                    <asp:TableCell>
                        <table cellspacing="1" class="boxbg" border="0" width="800px">
                            <tr class="bgbluegrey">
                                <td width="75%">
                                    <asp:Label ID="Label23" CssClass="blackfnt" Height="20px" Font-Bold="true" runat="server"
                                        Width="500px">Scheduled Maintenance Tasks</asp:Label>
                                </td>
                                <td width="5%">
                                    <asp:Panel ID="pnlSMTaskHdr" runat="server" Width="25px">
                                        <asp:Label ID="lblShowSMDet" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <table runat="server" id="tblSMTaskDet" cellspacing="1" width="800px">
                            <tr align="center">
                                <td align="left">
                                    <asp:Panel ID="pnlSMTaskDet" runat="server">
                                        <asp:GridView ID="gvSMTaskDet" runat="server" EmptyDataText="There is no Scheduled Maintenance Task for this Vehicle."
                                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                                            CellSpacing="1" CssClass="dgRowStyle" OnRowDataBound="gvSMTaskDet_OnRowDataBound"
                                            HeaderStyle-CssClass="dgHeaderStyle" PagerStyle-HorizontalAlign="left">
                                            <Columns>
                                                <asp:TemplateField HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                                    </ItemTemplate>
                                                    <ItemStyle Width="5%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Work Group">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hfWrkGrpID" Value='<%# Eval("W_GRPCD") %>' runat="server" />
                                                        <asp:Label ID="lblWorkGroup" runat="server" Text='<%# Eval("W_GRPDESC") %>' CssClass="blackfnt"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="20%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Task Description">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hfTaskId" Value='<%# Eval("TASK_ID") %>' runat="server" />
                                                        <asp:Label ID="lblTaskDesc" runat="server" Text='<%# Eval("TASKDESC") %>' CssClass="blackfnt"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="30%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Task Type">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hfTaskTypeId" Value='<%# Eval("TASKTYP") %>' runat="server" />
                                                        <asp:Label ID="lblTaskType" runat="server" Text='<%# Eval("TaskType") %>' CssClass="blackfnt"></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="30%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Estimated Labour Hours">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtEstHrs" Text='<%# Eval("Estimated_Hrs") %>' Style="text-align: right"
                                                            MaxLength="10" runat="server" Width="50px" BorderStyle="None"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Estimated Labour Cost">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtEstCost" Style="text-align: right" MaxLength="10" runat="server"
                                                            Width="50px" BorderStyle="None"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Remarks">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtRemarks" runat="server" BorderStyle="Groove" Width="200px" CssClass="input"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="15%" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <PagerStyle HorizontalAlign="Left" />
                                            <HeaderStyle CssClass="dgHeaderStyle" />
                                        </asp:GridView>
                                    </asp:Panel>
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server"
                                        TargetControlID="pnlSMTaskDet" Collapsed="false" ExpandControlID="pnlSMTaskHdr"
                                        CollapseControlID="pnlSMTaskHdr" AutoCollapse="False" TextLabelID="lblShowSMDet"
                                        CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" />
                                </td>
                            </tr>
                        </table>
                        <br />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server" ID="rowSparePart" Visible="false">
                    <asp:TableCell>
                        <br />
                        <table cellspacing="1" class="boxbg" border="0" width="800px">
                            <tr class="bgbluegrey">
                                <td width="75%">
                                    <asp:Label ID="lblHead" CssClass="blackfnt" Font-Bold="true" runat="server" Width="400px">Spare Part-Requirements(Estimates)</asp:Label>
                                </td>
                                <td align="left" width="30%">
                                    <asp:Label CssClass="blackfnt" ID="lblRow" runat="server" Width="100px">Enter no. of rows </asp:Label>
                                </td>
                                <td width="5%">
                                    <asp:TextBox ID="txtRow" runat="server" MaxLength="2" Width="20px" BorderStyle="Groove"
                                        onkeypress="javascript:validFloat(event,this.getAttribute('id'))" AutoPostBack="true"
                                        Text="0" OnTextChanged="txtRow_TextChanged"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="!"
                                        ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ValidationGroup="row"
                                        ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                                </td>
                                <td width="5%">
                                    <asp:Panel ID="tblSpare" runat="server" Width="25px">
                                        <asp:Label ID="lblTDSH" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <table cellspacing="1" width="800px">
                            <tr align="center">
                                <td align="left">
                                    <asp:Panel ID="pnlSpare" runat="server">
                                        <asp:DataGrid ID="dgSpare" runat="server" AutoGenerateColumns="False" BorderColor="#8BA0E5"
                                            BorderWidth="1px" CellPadding="5" CellSpacing="1" CssClass="dgRowStyle" HeaderStyle-CssClass="dgHeaderStyle"
                                            PagerStyle-HorizontalAlign="left" OnItemDataBound="dgSpare_ItemDataBound" Width="85%">
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="Sr.No.">
                                                    <ItemTemplate>
                                                        <center>
                                                            <%# Container.ItemIndex+1 %>.
                                                            <asp:Label ID="count" runat="server" Visible="false" Text=' <%# Container.ItemIndex+1 %>'></asp:Label>
                                                        </center>
                                                    </ItemTemplate>
                                                    <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                                        Font-Underline="False" Wrap="False" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Work Group">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblWorkGroup" runat="server" CssClass="blackfnt"></asp:Label>
                                                        <asp:DropDownList ID="ddlWorkGroup" runat="server" Width="150px" AutoPostBack="true"
                                                            CssClass="blackfnt" OnSelectedIndexChanged="ddlWorkGroup_SelectedChanged">
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="ReqddlWorkGroup" runat="server" Display="Dynamic"
                                                            Text="!" ValidationGroup="Group11" ControlToValidate="ddlWorkGroup"></asp:RequiredFieldValidator>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Part Description" HeaderStyle-HorizontalAlign="Left"
                                                    ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlPartNo" runat="server" Width="150px" CssClass="blackfnt">
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Task Type">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlTaskType" runat="server" Width="150px" CssClass="blackfnt">
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="ReqddlTaskType" runat="server" Display="Dynamic"
                                                            Text="!" ValidationGroup="Group11" ControlToValidate="ddlTaskType"></asp:RequiredFieldValidator>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Quantity" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtQty" MaxLength="10" runat="server" Style="text-align: right"
                                                            Width="100px" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                            CssClass="input" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqtxtQty" ValidationGroup="G1" runat="server" Display="Dynamic"
                                                            Text="!" ControlToValidate="txtQty"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegtxtQty" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                                            SetFocusOnError="true" ControlToValidate="txtQty" Display="Dynamic"></asp:RegularExpressionValidator>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Cost/Unit" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtCostUnit" Width="100px" CssClass="input" Style="text-align: right"
                                                            BorderStyle="Groove" runat="server"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Cost" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtCost" Style="text-align: right" runat="server" Width="100px"
                                                            CssClass="blackfnt" BorderStyle="None"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqtxtCost" ValidationGroup="G1" runat="server" Display="Dynamic"
                                                            Text="!" ControlToValidate="txtCost"></asp:RequiredFieldValidator>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Remarks" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtSpareRemark" runat="server" CssClass="input" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                            </Columns>
                                            <PagerStyle HorizontalAlign="Left" />
                                            <HeaderStyle CssClass="dgHeaderStyle" />
                                        </asp:DataGrid>
                                    </asp:Panel>
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender3" runat="Server"
                                        TargetControlID="pnlSpare" Collapsed="false" ExpandControlID="tblSpare" CollapseControlID="tblSpare"
                                        AutoCollapse="False" TextLabelID="lblTDSH" CollapsedText="Show" ExpandedText="Hide"
                                        ExpandDirection="Vertical" />
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server" ID="rowSummary" Width="">
                    <asp:TableCell>
                        <br />
                        <table cellspacing="1" class="boxbg" border="0" width="400px">
                            <tr class="bgbluegrey">
                                <td width="50%">
                                    <asp:Label ID="Label14" CssClass="blackfnt" Font-Bold="true" runat="server" Width="300px">Summary</asp:Label>
                                </td>
                                <td width="5%">
                                    <asp:Panel ID="pnlSummaryHdr" runat="server" Width="25px">
                                        <asp:Label ID="lblSummaryHdr" runat="server" Font-Bold="True" Width="25px">Show...</asp:Label>
                                    </asp:Panel>
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="pnlSummary" runat="server" Width="400px">
                            <table cellspacing="1" class="boxbg" width="100%" border="0">
                                <tr style="background-color: white">
                                    <td width="50%">
                                        <asp:Label Font-Bold="true" CssClass="bluefnt" ID="Label16" Text="Total Estimated Labour Hours"
                                            runat="server"></asp:Label>
                                    </td>
                                    <td align="left" width="50%">
                                        <asp:TextBox Font-Bold="true" Width="98%" onfocus="this.blur()" CssClass="bluefnt"
                                            ID="txtTotalEstimatedLabHours" Style="text-align: right" BorderStyle="None" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td width="50%">
                                        <asp:Label ID="Label17" Font-Bold="true" CssClass="bluefnt" Text="Total Estimated Labour Cost"
                                            runat="server"></asp:Label>
                                    </td>
                                    <td align="left" width="50%">
                                        <asp:TextBox Font-Bold="true" Width="98%" onfocus="this.blur()" CssClass="bluefnt"
                                            ID="txtTotalEstimatedLabCost" Style="text-align: right" BorderStyle="None" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td width="50%">
                                        <asp:Label ID="Label19" Font-Bold="true" CssClass="bluefnt" Text="Total Estimated Part Cost"
                                            runat="server"></asp:Label>
                                    </td>
                                    <td align="left" width="50%">
                                        <asp:TextBox Font-Bold="true" Width="98%" CssClass="bluefnt" onfocus="this.blur()"
                                            ID="txtTotalPartCost" Style="text-align: right" BorderStyle="None" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr style="background-color: white">
                                    <td width="50%">
                                        <asp:Label ID="Label21" Font-Bold="true" CssClass="bluefnt" Text="Total Estimated Cost"
                                            runat="server"></asp:Label>
                                    </td>
                                    <td align="left" width="50%">
                                        <asp:TextBox Font-Bold="true" Width="98%" CssClass="bluefnt" onfocus="this.blur()"
                                            ID="txtTotalEstimated" Style="text-align: right" BorderStyle="None" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender5" runat="Server"
                            TargetControlID="pnlSummary" Collapsed="false" ExpandControlID="pnlSummaryHdr"
                            CollapseControlID="pnlSummaryHdr" AutoCollapse="False" TextLabelID="lblSummaryHdr"
                            CollapsedText="Show" ExpandedText="Hide" ExpandDirection="Vertical" />
                        <br />
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server" ID="rowSubmit" Width="">
                    <asp:TableCell>
                        <table runat="server" id="tblSubmit" align="left" class="boxbg" visible="false" style="width: 800px">
                            <tr class="bgbluegrey" align="center">
                                <td align="center" colspan="2">
                                    <asp:Button ID="cmdSubmit" runat="server" Text="Submit" ValidationGroup="Group11"
                                        OnClientClick="javascript:return check()" OnClick="cmdSubmit_Click1" />
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
