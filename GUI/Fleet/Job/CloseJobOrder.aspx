<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"
    CodeFile="CloseJobOrder.aspx.cs" Inherits="GUI_Fleet_Job_CloseJobOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../Js/querystring.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>
    <script language="javascript" type="text/javascript" src="AJAX_Validator/CloseJobSheet.js"> </script>
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
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Close Job Order</asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel4" UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <asp:Table runat="server">
                <asp:TableRow runat="server" ID="rowSM_Hdr">
                    <asp:TableCell>
                        <table align="center" cellspacing="2" width="100%">
                            <tr align="center" style="background-color: white">
                                <td align="left">
                                    <table align="left" cellpadding="3" cellspacing="2" width="700px" class="boxbg">
                                        <tr style="background-color: white">
                                            <td colspan="4" align="center">
                                                <asp:Label ID="lblError" CssClass="redfnt" Visible="true" Font-Bold="true" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr class="bgbluegrey">
                                            <td colspan="4" align="center">
                                                <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Close Job Order</asp:Label>
                                            </td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td align="left">
                                                <asp:Label ID="Label8" runat="server" CssClass="bluefnt" Text="Job Order No."></asp:Label>
                                            </td>
                                            <td align="left">
                                                &nbsp;
                                                <asp:DropDownList ID="ddlWONo" runat="server" Width="150px" AutoPostBack="true" CssClass="blackfnt"
                                                    OnSelectedIndexChanged="ddlWONo_SelectedIndexChanged">
                                                </asp:DropDownList>
                                                &nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="Label12" runat="server" Text="Job Order Date" CssClass="bluefnt"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                &nbsp;<asp:Label ID="lblDate" runat="server" CssClass="blackfnt">
                                                </asp:Label>
                                            </td>
                                        </tr>
                                        <tr style="background-color: white">
                                            <td align="left">
                                                <asp:Label ID="Label4" runat="server" CssClass="bluefnt" Text="Vehicle No."></asp:Label>
                                            </td>
                                            <td align="left">
                                                &nbsp;
                                                <asp:Label ID="lblVehicleNo" runat="server" CssClass="blackfnt">
                                                </asp:Label>&nbsp;&nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="Label1" runat="server" Text="Vehicle Category" CssClass="bluefnt"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                &nbsp;<asp:Label ID="lblCategory" runat="server" CssClass="blackfnt">
                                 
                                                </asp:Label>
                                            </td>
                                        </tr>
                                        <tr style="background-color: white" align="center">
                                            <td align="left">
                                                <asp:Label ID="Label2" runat="server" Text="Manufacturer" CssClass="bluefnt"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                &nbsp;<asp:Label ID="lblMfg" runat="server" CssClass="blackfnt">
                                 
                                                </asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="Label3" runat="server" Text="Model" CssClass="bluefnt"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                &nbsp;<asp:Label ID="lblModel" runat="server" CssClass="blackfnt">
                                 
                                                </asp:Label>
                                            </td>
                                        </tr>
                                        <tr style="background-color: white" align="center">
                                            <td align="left">
                                                <asp:Label ID="Label9" runat="server" Text="Job Card Type" CssClass="bluefnt"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                &nbsp;<asp:Label ID="lblOrderType" runat="server" CssClass="blackfnt">
                                     
                                 
                                                </asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="Label11" runat="server" Text="Order Status" CssClass="bluefnt"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                &nbsp;<asp:Label ID="lblOrderStatus" runat="server" CssClass="blackfnt">
                                 
                                                </asp:Label>
                                            </td>
                                        </tr>
                                        <tr style="background-color: white" align="center">
                                            <td align="left">
                                                <asp:Label ID="Label13" runat="server" Text="Vendor Type " CssClass="bluefnt"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                &nbsp;<asp:Label ID="lblSCType" runat="server" CssClass="blackfnt">
                                                               
                                                </asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="lblVendorHead" runat="server" Text="Vendor Name" CssClass="bluefnt"
                                                    Visible="false"></asp:Label>
                                                <asp:Label ID="lblWLocHead" runat="server" Text="Workshop Location" CssClass="bluefnt"
                                                    Visible="false"></asp:Label>
                                            </td>
                                            <td align="left">
                                                &nbsp;<asp:Label ID="lblVendor" runat="server" CssClass="blackfnt" Visible="false">
                                                </asp:Label>
                                                <asp:Label ID="lblwLoc" runat="server" CssClass="blackfnt" Visible="false">
                                 
                                                </asp:Label>
                                            </td>
                                        </tr>
                                        <tr style="background-color: white" align="center">
                                            <td align="left">
                                                <asp:Label ID="Label7" runat="server" Text="Send date to WorkShop " CssClass="bluefnt"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                &nbsp;<asp:Label ID="LblSendDt" runat="server" CssClass="blackfnt"></asp:Label>
                                            </td>
                                            <td align="left">
                                                &nbsp;<asp:Label ID="Label14" runat="server" Text="Estimated return date " CssClass="bluefnt"></asp:Label>
                                            </td>
                                            <td align="left">
                                                &nbsp;
                                                <asp:Label ID="LblReturnDt" runat="server" CssClass="blackfnt"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr style="background-color: white" align="center">
                                            <td align="left">
                                                <asp:Label ID="Label15" runat="server" Text="Actual Date of return " CssClass="bluefnt"></asp:Label>
                                            </td>
                                            <td align="left" colspan="3">
                                                &nbsp;
                                                <asp:TextBox ID="txtDCActRetrunDt" runat="server" onblur="javascript:ValidateDate(this)"
                                                    BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDCActRetrunDt,'anchor22','dd/MM/yyyy'); return false;"
                                                    id="a2" name="anchor22">
                                                    <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                            </td>
                                            <%--  <td align="left"  >
                                 <asp:Label ID="Label28" runat="server" Text="Closure Type" CssClass="bluefnt"  ></asp:Label>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlClosureType" runat="server">
                                    <asp:ListItem Value="1" Text="Operational"></asp:ListItem>  
                                    <asp:ListItem Value="2" Text="Financial"></asp:ListItem>  
                                </asp:DropDownList>
                            </td>--%>
                                        </tr>
                                        <tr style="background-color: white" align="center">
                                            <td align="left">
                                                <asp:Label ID="Label18" runat="server" Text="Starting KM Reading" CssClass="bluefnt"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                &nbsp;<asp:Label ID="lblKMReading" runat="server" CssClass="blackfnt" Width="100px"
                                                    Style="text-align: right"></asp:Label>
                                            </td>
                                            <td align="left">
                                                <asp:Label ID="Label17" runat="server" Text="Closing KM Reading" CssClass="bluefnt"></asp:Label>
                                                &nbsp;
                                            </td>
                                            <td align="right">
                                                &nbsp;
                                                <asp:TextBox ID="txtCloseKM" Text="0" Style="text-align: right" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                    runat="server" Width="80px" CssClass="input" BorderStyle="Groove"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="RegtxtCloseKM" runat="server" ErrorMessage="!"
                                                    ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtCloseKM"
                                                    Display="Dynamic"></asp:RegularExpressionValidator>
                                            </td>
                                        </tr>
                                    </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow runat="server" ID="rowNOSM_Hdr">
                    <asp:TableCell>
                        <table>
                            <tr>
                                <table align="left" cellpadding="3" cellspacing="2" width="700px" class="boxbg">
                                    <tr class="bgbluegrey" align="center">
                                        <td align="center" colspan="2">
                                            <asp:Label ID="Label16" Font-Bold="true" runat="server" Text="Estimated Hrs and Cost"
                                                CssClass="bluefnt"></asp:Label>
                                        </td>
                                        <td align="center" colspan="2">
                                            <asp:Label ID="Label25" Font-Bold="true" runat="server" Text="Actual Hrs and Cost"
                                                CssClass="bluefnt"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white" align="center">
                                        <td align="left">
                                            <asp:Label ID="Label20" runat="server" Text="Total Estimated Labour Hrs" CssClass="bluefnt"></asp:Label>
                                        </td>
                                        <td align="right">
                                            &nbsp;<asp:Label ID="lbltotEstLHrs" runat="server" CssClass="blackfnt" Width="100px"
                                                Style="text-align: right">
                                            </asp:Label>
                                        </td>
                                        <td align="left" colspan="2">
                                        </td>
                                    </tr>
                                    <tr style="background-color: white" align="center">
                                        <%--<td align="left"  >
                        <asp:Label ID="Label5" runat="server" Text="Total Actual Labour Hrs" CssClass="bluefnt"  ></asp:Label>
                        &nbsp;
                    </td>
                    <td align="right" >
                        &nbsp;<asp:TextBox ID="txttotActLabHrs" runat="server" style="text-align: right"  Width="80px" CssClass="blackfnt"   ReadOnly="true"  BorderStyle="groove">
                        </asp:TextBox>
                    </td>--%>
                                        <td align="left">
                                            <asp:Label ID="Label22" runat="server" Text="Total Estimated Labour Cost" CssClass="bluefnt"></asp:Label>
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            &nbsp;<asp:Label ID="lbltotEstLCost" runat="server" Width="100px" Style="text-align: right"
                                                CssClass="blackfnt">
                                 
                                            </asp:Label>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="Label10" runat="server" Text="Total Actual Labour Cost" CssClass="bluefnt"></asp:Label>
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            &nbsp;<asp:TextBox ID="txttotActLabCost" BorderStyle="None" Text="0.00" Style="text-align: right"
                                                Width="80px" runat="server" CssClass="blackfnt">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white" align="center">
                                        <td align="left">
                                            <asp:Label ID="Label28" runat="server" Text="Total Estimated Part Quantity" CssClass="bluefnt"></asp:Label>
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblPartQty" runat="server" Width="100px" Style="text-align: right"
                                                CssClass="blackfnt" />
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="Label29" runat="server" Text="Total Actual Part Quantity" CssClass="bluefnt"></asp:Label>
                                        </td>
                                        <td align="right">
                                            &nbsp;<asp:TextBox ID="txtActQty" BorderStyle="None" runat="server" Text="0.00" Style="text-align: right"
                                                Width="80px" CssClass="blackfnt">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white" align="center">
                                        <td align="left">
                                            <asp:Label ID="Label30" runat="server" Text="Total Estimated Part Unit" CssClass="bluefnt"></asp:Label>
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblTotPartCostUnit" runat="server" Width="100px" Style="text-align: right"
                                                CssClass="blackfnt" />
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="Label31" runat="server" Text="Total Actual Part Unit" CssClass="bluefnt"></asp:Label>
                                        </td>
                                        <td align="right">
                                            &nbsp;<asp:TextBox ID="txtActCostUnit" BorderStyle="None" runat="server" Text="0.00"
                                                Style="text-align: right" Width="80px" CssClass="blackfnt">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white" align="center">
                                        <td align="left">
                                            <asp:Label ID="Label26" runat="server" Text="Total Estimated Part Cost" CssClass="bluefnt"></asp:Label>
                                        </td>
                                        <td align="right">
                                            &nbsp;<asp:TextBox ID="txtEstimatedSparePart" BorderStyle="None" runat="server" Style="text-align: right"
                                                Width="80px" CssClass="blackfnt">
                                            </asp:TextBox>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="Label19" runat="server" Text="Total Actual Part Cost" CssClass="bluefnt"></asp:Label>
                                        </td>
                                        <td align="right">
                                            &nbsp;<asp:TextBox ID="txtActPartCost" BorderStyle="None" runat="server" Text="0.00"
                                                Style="text-align: right" Width="80px" CssClass="blackfnt">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white" align="center">
                                        <td align="left">
                                            <asp:Label ID="Label5" Font-Bold="true" runat="server" Text="Total Estimated Cost"
                                                CssClass="bluefnt"></asp:Label>
                                        </td>
                                        <td align="right">
                                            &nbsp;<asp:TextBox ID="txtTotEstimatedCost" BorderStyle="None" runat="server" Style="text-align: right"
                                                Width="80px" CssClass="blackfnt">
                                            </asp:TextBox>
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="Label21" runat="server" Text="Total Actual Job Cost" CssClass="bluefnt"
                                                Font-Bold="true"></asp:Label>
                                            &nbsp;
                                        </td>
                                        <td align="right">
                                            &nbsp;<asp:TextBox ID="txtJobCost" BorderStyle="None" Text="0.00" Style="text-align: right"
                                                Width="80px" Font-Bold="true" runat="server" CssClass="blackfnt">
                                 
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </tr>
                            <tr>
                                <br />
                                <td>
                                    <asp:Panel ID="pnlTaskDet" runat="server" Width="100%">
                                        <table cellspacing="1" width="85%" class="boxbg" border="0">
                                            <tr class="bgbluegrey">
                                                <td width="75%">
                                                    <asp:Label ID="Label23" CssClass="blackfnt" Font-Bold="true" runat="server">Task Details</asp:Label>
                                                </td>
                                                <td align="left" width="15%">
                                                    <asp:Label CssClass="blackfnt" ID="Label24" runat="server">Enter no. of rows </asp:Label>
                                                </td>
                                                <td width="5%">
                                                    <asp:TextBox ID="txtTaskRow" runat="server" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                        MaxLength="3" Width="30" BorderStyle="Groove" AutoPostBack="true" Text="0" OnTextChanged="txtTaskRow_TextChanged"></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="RegtxtTaskRow" runat="server" ErrorMessage="!"
                                                        ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ValidationGroup="row"
                                                        ControlToValidate="txtTaskRow" Display="Dynamic"></asp:RegularExpressionValidator>
                                                </td>
                                                <td width="5%">
                                                    <asp:Label ID="lblTaskL" runat="server" Font-Bold="True">Show...</asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:Panel ID="pnlTask" runat="server">
                                        <asp:GridView ID="gvTaskDetails" runat="server" OnRowDataBound="gvTaskDetails_RowDataBound"
                                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..." HeaderStyle-CssClass="dgHeaderStyle">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Select">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chk_Flag" runat="server" Checked="True" onclick="javascript:checkme() " />
                                                    </ItemTemplate>
                                                    <ItemStyle Width="10%" HorizontalAlign="Center" VerticalAlign="Top" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Work Group" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblW_GRPCD" runat="server" CssClass="blackfnt"></asp:Label>
                                                        <asp:DropDownList ID="ddlWorkGroup" runat="server" Width="150px" AutoPostBack="true"
                                                            CssClass="blackfnt" OnSelectedIndexChanged="ddlWorkGroup_SelectedIndexChanged"
                                                            Visible="false">
                                                        </asp:DropDownList>
                                                        <asp:HiddenField ID="hfW_GRPCD" Value="" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Task Code " Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskCode" runat="server" CssClass="blackfnt"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Task Description" HeaderStyle-Wrap="false" ItemStyle-Wrap="false"
                                                    HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTaskDesc" runat="server" CssClass="blackfnt"></asp:Label>
                                                        <asp:DropDownList ID="ddlTask" runat="server" Width="350px" CssClass="blackfnt" Visible="false">
                                                        </asp:DropDownList>
                                                        <asp:HiddenField ID="hfTaskCd" Value="" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Task Type" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlTaskType" runat="server" Width="125px" CssClass="blackfnt" />
                                                        <asp:TextBox ID="txtTaskType" onfocus="this.blur()" runat="server" BorderStyle="None"
                                                            CssClass="blackfnt" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Remark" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRemark" runat="server" CssClass="blackfnt"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action Taken" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtAction" runat="server" Width="100px" CssClass="input" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%-- <asp:TemplateField HeaderText="Completion Date(dd/mm/yyyy)" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left" >
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtComplDate"    runat="server"  Width="80px" CssClass="input" BorderStyle="Groove" maxlength="10"  ></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegtxtComplDate" runat="server"
                                        ErrorMessage="!" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))" SetFocusOnError="true"
                                        ControlToValidate="txtComplDate" Display="Dynamic"></asp:RegularExpressionValidator>
                                </ItemTemplate>
                                </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Est. Labour Hours" HeaderStyle-HorizontalAlign="left"
                                                    ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtEstHrs" onfocus="this.blur()" runat="server" BorderStyle="None"
                                                            CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Est. Labour Cost" HeaderStyle-HorizontalAlign="left"
                                                    ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtEstCost" onfocus="this.blur()" runat="server" BorderStyle="None"
                                                            CssClass="blackfnt"></asp:TextBox>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="AMC/Non AMC" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlAMC" runat="server">
                                                            <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                                            <asp:ListItem Text="AMC" Value="2"></asp:ListItem>
                                                            <asp:ListItem Text="Non AMC" Value="1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%--  <asp:TemplateField HeaderText="Actual Labour Hours" Visible="false" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Right" >
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtEstHrs" Text="0" style="text-align: right"     onblur="javascript:return calculate()"  onkeypress="javascript:validFloat(event,this.getAttribute('id'))"   runat="server"  Width="80px" CssClass="input" BorderStyle="Groove" OnTextChanged="txtEstHrs_TextChanged"   ></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegtxtEstHrs" runat="server"
                                        ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true"
                                        ControlToValidate="txtEstHrs" Display="Dynamic"></asp:RegularExpressionValidator>                           
	                                </ItemTemplate>
	                            </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Actual Labour Cost" HeaderStyle-HorizontalAlign="left"
                                                    ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtActualLabourCost" Style="text-align: right" Text="0" runat="server"
                                                            onblur="javascript:return calculate()" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                            Width="80px" CssClass="input" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:HiddenField ID="DETSRNO" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"SRNO") %>' />
                                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="!"
                                                            ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$" SetFocusOnError="true" ControlToValidate="txtActualLabourCost"
                                                            Display="Dynamic"></asp:RegularExpressionValidator>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                                            <PagerStyle HorizontalAlign="Left" />
                                            <HeaderStyle CssClass="dgHeaderStyle" />
                                        </asp:GridView>
                                    </asp:Panel>
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender3" runat="Server"
                                        TargetControlID="pnlTask" CollapsedSize="0" Collapsed="True" ExpandControlID="pnlTaskDet"
                                        CollapseControlID="pnlTaskDet" AutoCollapse="False" AutoExpand="False" TextLabelID="lblTaskL"
                                        CollapsedText="Show..." ExpandedText="Hide..." ExpandDirection="Vertical" />
                                </td>
                                <%--          </td>
        </tr> 
    </table>
                                --%>
                                <br />
                            </tr>
                        </table>
                        <asp:Panel ID="tblSpare" runat="server" Width="100%">
                            <table cellspacing="1" width="85%" class="boxbg" border="0">
                                <tr class="bgbluegrey">
                                    <td width="75%">
                                        <asp:Label ID="lblHead" CssClass="blackfnt" Font-Bold="true" runat="server">Spare Part-Requirements(Estimates)</asp:Label>
                                    </td>
                                    <td align="left" width="15%">
                                        <asp:Label CssClass="blackfnt" ID="lblRow" runat="server">Enter no. of rows </asp:Label>
                                    </td>
                                    <td width="5%">
                                        <asp:TextBox ID="txtRow" runat="server" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                            MaxLength="3" Width="30" BorderStyle="Groove" AutoPostBack="true" Text="0" OnTextChanged="txtRow_TextChanged"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegtxtRow" runat="server" ErrorMessage="!" ValidationExpression="^\$?[+-]?[\d,]*\.?\d{0,2}$"
                                            SetFocusOnError="true" ValidationGroup="row" ControlToValidate="txtRow" Display="Dynamic"></asp:RegularExpressionValidator>
                                    </td>
                                    <td width="5%">
                                        <asp:Label ID="lblTDSH" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <table cellspacing="1" width="100%">
                            <tr align="left">
                                <td align="center">
                                    <asp:Panel ID="pnlSpare" runat="server">
                                        <asp:DataGrid ID="dgSpare" runat="server" AutoGenerateColumns="False" BorderColor="#8BA0E5"
                                            BorderWidth="1px" CellPadding="5" CellSpacing="1" CssClass="dgRowStyle" Width="100%"
                                            HeaderStyle-CssClass="dgHeaderStyle" PagerStyle-HorizontalAlign="left" OnItemDataBound="dgSpare_ItemDataBound">
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="Sr.No." HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
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
                                                <asp:TemplateColumn HeaderText="Work Group" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlWorkGroup" runat="server" Width="150px" AutoPostBack="true"
                                                            CssClass="blackfnt" OnSelectedIndexChanged="ddlWorkGroupPart_SelectedIndexChanged"
                                                            Visible="false">
                                                        </asp:DropDownList>
                                                        <asp:Label ID="lblW_GRPCD" runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Left" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Part Description" HeaderStyle-HorizontalAlign="Left"
                                                    ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlPartNo" runat="server" Width="200px" CssClass="blackfnt">
                                                        </asp:DropDownList>
                                                        <asp:Label ID="lblPartDesc" runat="server"></asp:Label>
                                                        <asp:HiddenField ID="hfPartCode" Value="" runat="server" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Left" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Task Type" HeaderStyle-HorizontalAlign="left" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlTaskType" runat="server" Width="125px" CssClass="blackfnt" />
                                                        <asp:TextBox ID="txtTaskType" onfocus="this.blur()" runat="server" BorderStyle="None"
                                                            CssClass="blackfnt" />
                                                    </ItemTemplate>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Estimated Quantity" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEstQty" runat="server" Width="50px" CssClass="blackfnt" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Estimated Cost/Unit" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEstCostUnit" runat="server" BorderStyle="None" Width="50px" CssClass="blackfnt" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Cost" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCost" runat="server" BorderStyle="None" Width="50px" CssClass="blackfnt" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Actual Quantity" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtQty" Width="75px" runat="server" Style="text-align: right" onkeypress="javascript:validFloat(event,this.getAttribute('id'))"
                                                            onkeydown="return numeric(event)" CssClass="input" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqtxtQty" ValidationGroup="G1" runat="server" Display="Dynamic"
                                                            Text="!" ControlToValidate="txtQty"></asp:RequiredFieldValidator>
                                                        <asp:RegularExpressionValidator ID="RegtxtQty" runat="server" ErrorMessage="!" ValidationExpression="^\d{0,9}$"
                                                            SetFocusOnError="true" ControlToValidate="txtQty" Display="Dynamic"></asp:RegularExpressionValidator>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Actual Cost/Unit" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtCostUnit" Width="75px" runat="server" Style="text-align: right"
                                                            onkeypress="javascript:validFloat(event,this.getAttribute('id'))" onkeydown="return numeric(event)"
                                                            CssClass="input" BorderStyle="Groove"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Actual Cost" HeaderStyle-HorizontalAlign="Right"
                                                    ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtActualCost" runat="server" Style="text-align: right" Width="75px"
                                                            BorderStyle="None"></asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="reqtxtCost" ValidationGroup="G1" runat="server" Display="Dynamic"
                                                            Text="!" ControlToValidate="txtActualCost"></asp:RequiredFieldValidator>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Right" />
                                                    <ItemStyle HorizontalAlign="Right" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="Remarks" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtSpareRemark" runat="server" Width="250px" CssClass="input" BorderStyle="Groove"></asp:TextBox>
                                                        <asp:HiddenField ID="SPARESRNO" runat="server" Value='<%# DataBinder.Eval(Container.DataItem,"SPARE_SRNO") %>' />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Left" />
                                                    <ItemStyle HorizontalAlign="Left" />
                                                </asp:TemplateColumn>
                                            </Columns>
                                            <PagerStyle HorizontalAlign="Left" />
                                            <HeaderStyle CssClass="dgHeaderStyle" />
                                        </asp:DataGrid>
                                    </asp:Panel>
                                    <ajaxToolkit:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="Server"
                                        TargetControlID="pnlSpare" CollapsedSize="0" Collapsed="True" ExpandControlID="tblSpare"
                                        CollapseControlID="tblSpare" AutoCollapse="False" AutoExpand="False" TextLabelID="lblTDSH"
                                        CollapsedText="Show..." ExpandedText="Hide..." ExpandDirection="Vertical" />
                                </td>
                            </tr>
                        </table>
                        <asp:Panel ID="pnlSummaryHdr" runat="server" Width="100%">
                            <table cellspacing="1" width="85%" class="boxbg" border="0">
                                <tr class="bgbluegrey">
                                    <td width="75%">
                                        <asp:Label ID="Label6" CssClass="blackfnt" Height="20px" Font-Bold="true" runat="server">Summary</asp:Label>
                                    </td>
                                    <td width="5%">
                                        <asp:Label ID="lblSummaryHdr" runat="server" Font-Bold="True">Show...</asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Panel ID="pnlSummary" runat="server" Width="85%">
                            <asp:GridView ID="gvSummary" runat="server" AutoGenerateColumns="False" BorderColor="#8BA0E5"
                                BorderWidth="1px" CellPadding="5" CellSpacing="1" CssClass="dgRowStyle" Width="100%"
                                HeaderStyle-CssClass="dgHeaderStyle" PagerStyle-HorizontalAlign="left">
                                <Columns>
                                    <asp:BoundField DataField="TaskType" HeaderText="Task Type"></asp:BoundField>
                                    <asp:BoundField DataField="ACCDESC" HeaderText="Expense ledger "></asp:BoundField>
                                    <asp:BoundField DataField="TOT_LABOUR_COST" HeaderText="Labour Cost"></asp:BoundField>
                                    <asp:BoundField DataField="TOT_SPARE_COST" HeaderText="Spare Cost"></asp:BoundField>
                                </Columns>
                            </asp:GridView>
                        </asp:Panel>
                        <ajaxToolkit:CollapsiblePanelExtender ID="cpe" runat="Server" TargetControlID="pnlSummary"
                            CollapsedSize="0" Collapsed="True" ExpandControlID="pnlSummaryHdr" CollapseControlID="pnlSummaryHdr"
                            AutoCollapse="False" AutoExpand="False" TextLabelID="lblSummaryHdr" CollapsedText="Show..."
                            ExpandedText="Hide..." ExpandDirection="Vertical" />
                        <br />
                        <table cellspacing="1" width="85%" class="boxbg">
                            <tr class="bgbluegrey">
                                <td align="center">
                                    <asp:Button ID="cmdOperationlSubmit" runat="server" Text="Operational Close" OnClientClick="javascript:return checkOperational()"
                                        OnClick="cmdOperationlSubmit_Click" />
                                    <asp:Button ID="cmdSubmit" runat="server" Text="Financial Close" OnClientClick="javascript:return checkFinancial()"
                                        OnClick="cmdSubmit_Click" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <center>
                            <font class="blackfnt" style="color: Red;"><b>
                                <asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
                            </font>
                        </center>
                        <br />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="ddlWONo" EventName="SelectedIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="cmdSubmit" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
