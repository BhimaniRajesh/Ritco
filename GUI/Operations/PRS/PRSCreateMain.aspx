<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="PRSCreateMain.aspx.cs" Inherits="GUI_Operations_PRS_CreateMain"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <asp:SqlDataSource ID="MySQLDataSource_VendorTypes" runat="server" SelectCommand="usp_Vendor_Types"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboBookedBy" Name="route_mode" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Vendors" runat="server" SelectCommand="usp_Vendors"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVendorType" DefaultValue="" Name="vendor_type"
                Type="string" />
            <asp:SessionParameter SessionField="brcd" Name="brcd" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Vehicles" runat="server" SelectCommand="usp_Vendor_Vehicles"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVendorType" DefaultValue="" Name="vendortype"
                Type="string" />
        </SelectParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVendors" DefaultValue="" Name="vendorcode" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="MySQLDataSource_Vehicle_Types" runat="server" SelectCommand="usp_Vehicle_Types"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="cboVehicles" DefaultValue="O" Name="vehicleno" Type="string" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="MySQLDataSource_TranMode" runat="server" SelectCommand="usp_TransMode"
        SelectCommandType="StoredProcedure">
    </asp:SqlDataSource>
    <script type="text/javascript">
    function SelectAll(CheckBoxControl) 
    {
    if (CheckBoxControl.checked == true) 
    {
    var i;
    for (i=0; i < document.forms[0].elements.length; i++) 
    {
    if ((document.forms[0].elements[i].type == 'checkbox') && 
    (document.forms[0].elements[i].name.indexOf('dgDockets') > -1)) 
    {
    document.forms[0].elements[i].checked = true;
    }
    }
    } 
    else 
    {
    var i;
    for (i=0; i < document.forms[0].elements.length; i++) 
    {
    if ((document.forms[0].elements[i].type == 'checkbox') && 
    (document.forms[0].elements[i].name.indexOf('dgDockets') > -1)) 
    {
    document.forms[0].elements[i].checked = false;
    }
    }
    }
    }

 /*************************************************************************************************************
*  Date must be < system date 
/*************************************************************************************************************/                         
function DataValidation()
{
       var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
       var txtDate = document.getElementById("ctl00_MyCPH1_txtDate");   
       
       if(txtDate.value != "")
       {       
           var today = '<%= System.DateTime.Now.Date.ToString("dd/MM/yyyy") %>';
           
           var arrDt = txtDate.value.split('/');
           var arrserverdate = today.split('/');
           
           var arrDate=new Date(months[parseFloat(arrDt[1])] + " " +  arrDt[0] + "," + arrDt[2]);
           var arrToday=new Date(months[parseFloat(arrserverdate[1])] + " " +  arrserverdate[0] + "," + arrserverdate[2]);
      
           if(arrDate > arrToday) 
           {    
               alert("Date can't be future date.");
               txtDate.value = "";            
               return false;
           } 
       }
       return true;
}
    </script>
        
    <script src="../../Js/CalendarPopup.js" language="javascript" type="text/javascript"></script>
    <script src="../../Js/AssignValue.js" language="javascript" type="text/javascript"></script>

    <asp:UpdatePanel ID="upPRSGenerate"  UpdateMode="Conditional" RenderMode="Inline" runat="server">
        <ContentTemplate>
            <table cellspacing="1" style="width: 100%">
                <tr style="background-color: white">
                    <td align="left">
                        <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Generate PRS:</asp:Label>
                        <hr align="center" size="1" color="#8ba0e5">
                    </td>
                    <td align="left">
                        <asp:UpdateProgress ID="ProgressIndicator" runat="server">
                            <ProgressTemplate>
                                <div id="progressArea">
                                    <asp:Label ID="lblLS" runat="server" Text="Please wait..." CssClass="blackfnt" Font-Bold="true"></asp:Label>
                                    <asp:Image ID="LoadingImage" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblDocketCreteria" runat="server"  visible="true">
                <tr class="bgbluegrey">
                    <td colspan="2" style="text-align: center">
                        <asp:Label ID="lblTblHeader" runat="server" CssClass="blackfnt" Text="Select Docket Criteria"
                            Font-Bold="true"></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left" rowspan="4" valign="Top">
                        <asp:Label ID="lblDate" runat="server" CssClass="blackfnt" Text="Docket Date :">
                        </asp:Label>
                    </td>
<%--                    <td>
                        <asp:DropDownList ID="cboDocketDate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ResetDocketList">
                            <asp:ListItem Text="--Select--" Value="" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Booking Date" Value="B"></asp:ListItem>
                            <asp:ListItem Text="Arrival Date" Value="A"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator SetFocusOnError="true" ControlToValidate="cboDocketDate" ID="RFVcboDocketDate"
                            runat="server" ErrorMessage="*" CssClass="redfnt" ToolTip="Docket Date: Booking Or Arrival"></asp:RequiredFieldValidator>
                    </td>
--%>                

                    <td align="left">
                        <asp:RadioButton ID="radFromToDate" GroupName="Dates" runat="server" Text="" AutoPostBack="true" OnCheckedChanged="ResetDocketList"/>
                        <asp:Label ID="lblFromDate" runat="server" CssClass="blackfnt" Text="From :" />
                        <asp:TextBox ID="txtFrom" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtFrom,'a1','dd/MM/yyyy'); return false;"
                            id="a1">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                        <asp:RegularExpressionValidator SetFocusOnError="true" ID="REVDtFrom" runat="server" ErrorMessage="!" ControlToValidate="txtFrom"
                            ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                        &nbsp;
                        <asp:Label ID="lblToDate" runat="server" CssClass="blackfnt" Text=" To " />
                        &nbsp;
                        <asp:TextBox ID="txtTo" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtTo,'a2','dd/MM/yyyy'); return false;"
                            id="a2">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                        <asp:RegularExpressionValidator SetFocusOnError="true" ID="REVDtTo" runat="server" ErrorMessage="!" ControlToValidate="txtTo"
                            ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                        <asp:Label ID="lblddmmyyyy" runat="server" CssClass="blackfnt" Text=" [dd/mm/yyyy] " />
                        <%--<asp:Calendar ID="mycal1" runat="server" Visible="false" OnSelectionChanged="MyCal1" Height="25" Width="25"></asp:Calendar>--%>
                    </td>
</tr>
                <tr bgcolor="white">
                    <td align="left">
                        <asp:RadioButton ID="radToday" GroupName="Dates" runat="server" Text="" AutoPostBack="true" OnCheckedChanged="ResetDocketList"/>
                        <asp:Label ID="lblToday" runat="server" CssClass="blackfnt">Today's - <%=dtToday%></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <asp:RadioButton ID="radLastWeek" GroupName="Dates" runat="server" Text="" Checked="true" AutoPostBack="true" OnCheckedChanged="ResetDocketList"/>
                        <asp:Label ID="lblLastWeek" runat="server" CssClass="blackfnt">Last Week's - <%=dtLastWeek%></asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <asp:RadioButton ID="radTillDate" GroupName="Dates" runat="server" Enabled="false" Text="" AutoPostBack="true" OnCheckedChanged="ResetDocketList"/>
                        <asp:Label ID="lblTillDate" runat="server" CssClass="blackfnt">Till Date</asp:Label>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Docket No(s).:</font>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDocketList" runat="server" Text="" Width="300" AutoPostBack="true" OnTextChanged ="ResetDocketList"></asp:TextBox>
                        <font class="blackfnt">[Seperated by <i>Comma</i> if multiple]</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Booked By:</font>
                    </td>
                    <td>
                        <asp:DropDownList ID="cboBookedBy" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ResetDocketList">
                            <asp:ListItem Text="--Select--" Value="" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="All" Value="AA"></asp:ListItem>
                            <asp:ListItem Text="Staff" Value="P"></asp:ListItem>
                            <asp:ListItem Text="BA" Value="B"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator runat="server" ID="RFVcboBookedBy" ControlToValidate="cboBookedBy" ErrorMessage="*" SetFocusOnError="true"></asp:RequiredFieldValidator>
                    </td>
                </tr>

                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Transition Mode:</font>
                    </td>
                    <td>
                        <asp:DropDownList ID="cboTranMode" runat="server" AutoPostBack="true" DataSourceID="MySQLDataSource_TranMode"
                            DataTextField="CodeDesc" DataValueField="CodeID" OnSelectedIndexChanged="ResetDocketList">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator SetFocusOnError="true" ID="RFVcboTrnaMode" runat="server" ControlToValidate="cboTranMode" ErrorMessage="*" CssClass="redfnt"></asp:RequiredFieldValidator>
                        
                    </td>
                </tr>

            </table>
            <br />
            <table border="0" cellspacing="1" cellpadding="3" width="900px" id="tblNote" runat="server"  visible="true">
                <tr>
                    <td align="left">
                        <font class="redfnt"><b>Note:</b></font>
                        <asp:Label ID="lblDocDateRange" runat="server" CssClass="redfnt" Font-Bold="false">PRS <%=DocDateRange%></asp:Label>
                    </td>
                </tr>
            </table>    
            
            <table border="0" cellspacing="1" cellpadding="3" width="900px" class="boxbg" id="tblPRSHeader" runat="server" visible="true">
                <tr class="bgbluegrey">
                    <td align="center" colspan="6">
                        <font class="blackfnt"><b>PRS Header Information</b></font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Manual Code:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtManCode" runat="server" Text="" Width="75" MaxLength="10"></asp:TextBox>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Date:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtDate" runat="server" MaxLength="10" Width="70" AutoPostBack="true" OnTextChanged="ResetDocketList"></asp:TextBox>
                        <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDate,'a3','dd/MM/yyyy'); return false;"
                            id="a3">
                            <img src="./../../images/calendar.jpg" border="0" />
                        </a>
                        <asp:RegularExpressionValidator SetFocusOnError="true" ID="REVDate" runat="server" ErrorMessage="!" ControlToValidate="txtDate"
                            ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
<%--                        <asp:CompareValidator ID="CVDate" ControlToValidate="txtDate" runat="server" ErrorMessage="#" CssClass="redfnt" Type="Date" Operator="DataTypeCheck"></asp:CompareValidator>
--%>                        <%--<asp:RangeValidator ID="RVDate" Type="Date" runat="server" ErrorMessage="^" ControlToValidate="txtDate" Display="Dynamic"></asp:RangeValidator>--%>    
                        <asp:RequiredFieldValidator SetFocusOnError="true" ID="RFVtxtDate" runat="server" ErrorMessage="*" CssClass="redfnt" ControlToValidate="txtDate"></asp:RequiredFieldValidator>
                     </td>
                    <td align="left">
                        <font class="blackfnt">Location:</font>
                    </td>
                    <td align="left">
                        <font class="bluefnt">
                            <%=mBrCd%>
                        </font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Pickup By:</font>
                    </td>
                    <td align="left" colspan="2">
                        <asp:DropDownList runat="server" ID="cboVendorType" AutoPostBack="true" DataSourceID="MySQLDataSource_VendorTypes"
                            DataTextField="Vendor_Type" DataValueField="Vendor_Type_Code" OnSelectedIndexChanged="OnVendorTypeChange">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator SetFocusOnError="true" runat="server" ID="RFVcboVendorType" ControlToValidate="cboVendorType" ErrorMessage="*" ToolTip="Select Vendor Type" CssClass="redfnt"></asp:RequiredFieldValidator>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Vendor:</font>
                    </td>
                    <td align="left" colspan="2">
                        <asp:DropDownList runat="server" ID="cboVendors" AutoPostBack="true" DataSourceID="MySQLDataSource_Vendors"
                            DataTextField="Vendor_Name" DataValueField="Vendor_Code" OnSelectedIndexChanged="OnVendorChange">
                        </asp:DropDownList>
                        <asp:TextBox ID="txtMarketVendor" runat="server" MaxLength="50" Width="200" Visible="false"></asp:TextBox>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Vendor Vehicles:</font>
                    </td>
                    <td align="left" colspan="5">
                        <asp:DropDownList runat="server" ID="cboVehicles" AutoPostBack="true" DataSourceID="MySQLDataSource_Vehicles"
                            DataTextField="DispVehicle" DataValueField="Vehno" OnSelectedIndexChanged="OnVehicleChange">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator SetFocusOnError="true" ID="RFVcboVehicles" runat="server" ControlToValidate="cboVehicles" ErrorMessage="*" CssClass="redfnt"></asp:RequiredFieldValidator>
                        <asp:TextBox ID="txtVehicle" runat="server" MaxLength="10" Width="100" Visible="false"></asp:TextBox>
                        <asp:RequiredFieldValidator SetFocusOnError="true" ID="RFVtxtVehicle" runat="server" ControlToValidate="txtVehicle" ErrorMessage="*" CssClass="redfnt"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Vehicle Type:</font>
                    </td>
                    <td align="left" colspan="5">
                        <asp:DropDownList runat="server" ID="cboVehicleTypes" AutoPostBack="false" DataSourceID="MySQLDataSource_Vehicle_Types"
                            DataTextField="Type_Name" DataValueField="TypeCode">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator SetFocusOnError="true" ID="RFVcboVehicleTypes" runat="server" ControlToValidate="cboVehicleTypes" ErrorMessage="*" ToolTip="Select Vehicle Type"></asp:RequiredFieldValidator>
                    </td>
                </tr>
<%--                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Engine No.:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtEngineNo" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Chasis No.:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtChasisNo" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                    </td>
                    <td align="left">
                        <font class="blackfnt">RC Book No.:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtRCBookNo" runat="server" MaxLength="15" Width="100"></asp:TextBox>
                    </td>
                </tr>
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Vehicle Regn Date.:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtVRDate" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                        <asp:RegularExpressionValidator SetFocusOnError="true" ID="REVtxtVRDate" runat="server" ErrorMessage="!"
                            ToolTip="Date Format dd/MM/yyyy" ControlToValidate="txtVRDate" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Insurane Policy Date:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtIPDate" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                        <asp:RegularExpressionValidator SetFocusOnError="true" ID="REVtxtIPDate" runat="server" ErrorMessage="!"
                            ToolTip="Date Format dd/MM/yyyy" ControlToValidate="txtIPDate" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Fitness Certificate Date:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtFCDate" runat="server" MaxLength="10" Width="70"></asp:TextBox>
                        <asp:RegularExpressionValidator SetFocusOnError="true" ID="REVtxtFCDate" runat="server" ErrorMessage="!"
                            ToolTip="Date Format dd/MM/yyyy" ControlToValidate="txtFCDate" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                    </td>
                </tr>--%>
                
                <tr style="background-color: White">
                    <td align="left">
                        <font class="blackfnt">Driver:</font>
                    </td>
                    <td align="left" colspan="3">
                        <asp:TextBox ID="txtDriver" runat="server" MaxLength="50" Width="300" CssClass="input"></asp:TextBox>
                        <asp:RequiredFieldValidator SetFocusOnError="true" ControlToValidate="txtDriver" ID="RFVtxtDriver" runat="server" ErrorMessage="*" ToolTip="Enter Driver Name" CssClass="redfnt"></asp:RequiredFieldValidator>
                    </td>
                    <td align="left">
                        <font class="blackfnt">Actual Pickup Time:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtHHMM" runat="server" MaxLength="5" Width="30" CssClass="input"></asp:TextBox>
                        <font class="blackfnt">[HH:MM]</font>
                        <asp:RegularExpressionValidator SetFocusOnError="true" ID="REVtxtHHMM" runat="server" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$" ErrorMessage="!" ToolTip="Time in HH:MM format" ControlToValidate="txtHHMM"></asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator SetFocusOnError="true"  ControlToValidate="txtHHMM" ID="RFVtxtHHMM" runat="server" ErrorMessage="*" ToolTip="Enter Act. Dept. Time"></asp:RequiredFieldValidator>
<%--                        <asp:TextBox ID="txtHH" runat="server" MaxLength="2" Width="15"></asp:TextBox>
                        <font class="blackfnt">:</font>
                        <asp:TextBox ID="txtMM" runat="server" MaxLength="2" Width="15"></asp:TextBox>
                        
                        <asp:RequiredFieldValidator ControlToValidate="txtHH" ID="RFVtxtHH" runat="server" ErrorMessage="*" ToolTip="Enter Arrival Hours (HH)"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ControlToValidate="txtHH" ID="RVtxtHH" runat="server" MinimumValue="0" MaximumValue="23" ErrorMessage="!" ToolTip="Invalid Arrival Hours (HH)" ></asp:RangeValidator>
                        <asp:RequiredFieldValidator ControlToValidate="txtMM" ID="RFVtxtMM" runat="server" ErrorMessage="*" ToolTip="Enter Arrival Mins (MM)"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ControlToValidate="txtMM" ID="RVtxtMM" runat="server" MinimumValue="0" MaximumValue="59" ErrorMessage="!" ToolTip="Invalid Arrival Mins (MM)" ></asp:RangeValidator>
--%>                    </td>
                </tr>
                
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt">Start KM:</font>
                    </td>
                    <td colspan="3">
                        <asp:TextBox ID="txtStartKM" runat="server" CssClass="input" MaxLength="6" Width="50"></asp:TextBox>
                        <asp:RequiredFieldValidator SetFocusOnError="true" ErrorMessage="*" ID="RFVtxtStartKM" runat="server" ControlToValidate="txtStartKM"></asp:RequiredFieldValidator>
                        <asp:RangeValidator  SetFocusOnError="true" ErrorMessage="!" ID="RVtxtStartKM" runat="server" MinimumValue="0" MaximumValue="999999" Type="Integer" ControlToValidate="txtStartKM"></asp:RangeValidator>
                    </td>
                    <td align="left">
                        <font class="blackfnt">End KM:</font>
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtEndKM" runat="server" CssClass="input" MaxLength="6" Width="50"></asp:TextBox>
                        <asp:RequiredFieldValidator SetFocusOnError="true" ErrorMessage="*" ID="RFVtxtEndKM" runat="server" ControlToValidate="txtEndKM"></asp:RequiredFieldValidator>
                        <asp:CompareValidator  SetFocusOnError="true" ErrorMessage="!" ID="CVtxtEndKM" runat="server" ControlToCompare="txtStartKM" Operator="GreaterThan" Type="Integer" ControlToValidate="txtEndKM"></asp:CompareValidator>
                    </td>                </tr>
                
                <tr style="background-color: White">
                    <td align="right" colspan="6">
                        <asp:Button ID="btnSubmit" runat="server" OnClientClick="javascript:return DataValidation();"    Text="List Dockets for PRS Generation >>" OnClick="ListDocketsForPRSGeneration"/>
                    </td>
                </tr>
            </table>
            
            <br />
            
            <table cellpadding="3" cellspacing="1" border="0" id="tblNoDocketsSelected" runat="server" width="900px" visible="false">
                <tr bgcolor="white">
                    <td align="left">
                        <font class="redfnt"><b>Alert: </b>No Dockets Were Selected</font>
                    </td>
                </tr>
            </table>

            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblResult" runat="server" width="900px" visible="false">
                <tr bgcolor="white">
                    <td align="left">
                        <font class="blackfnt"><b>PRS Generation Result</b></font>
                    </td>
                </tr>
                
                <tr bgcolor="white">
                    <td align="left">
                        <font class="redfnt"><b>Note:</b>Click on Document # for View/Print</font>
                    </td>
                </tr>
                <tr bgcolor="white">
                    <td align="left">
                        <asp:GridView ID="dgResult" runat="server" CellSpacing="1"
                            CellPadding="3" HeaderStyle-CssClass="dgHeaderStyle" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." Width="100%">
                       

                            <Columns>
                                

                                <asp:TemplateField  HeaderText="PRS #" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnk6" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PDCNo")%>'
                                            CssClass="blackfnt" Font-Underline="false" PostBackUrl='<%# "~/GUI/Operations/PRS/PRS_View_Print.aspx?PRSNo=" + DataBinder.Eval(Container.DataItem, "PDCNo")%>'
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>

<%--                                <asp:TemplateField  HeaderText="MR #" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false" >
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnk7" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "MRGenerated")%>'
                                            CssClass="blackfnt" Font-Underline="false" PostBackUrl="#"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>
--%>

                                <asp:TemplateField  HeaderText="Transaction Result" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk8" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "TranXaction")%>'
                                            CssClass="redfnt" Font-Underline="false"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                            </Columns>

                        </asp:GridView>                
                    </td>
                </tr>
            </table>

            <table cellpadding="3" cellspacing="1" border="0" class="boxbg" id="tblDocketList" runat="server" width="900px" visible="false">
                <tr style="background-color:White">
                    <td align="center">
                        <font class="blackfnt"><b>Dockets available for PRS Generation</b></font>
                    </td>
                </tr>
                
                <tr style="background-color:White">
                    <td align="left">
                        <asp:GridView ID="dgDockets" runat="server" CellSpacing="1"
                            CellPadding="3" HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." Width="100%" DataKeyNames="DOCKNO,DOCKSF">
                       

                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                    <input type="CheckBox" name="SelectAllCheckBox" onclick="SelectAll(this)">
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox runat="server" ID="chkDocket" EnableViewState="true" Text="" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField  HeaderText="Docket #" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk1" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DOCKNO")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField  HeaderText="Suffix" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk2" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "DOCKSF")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField  HeaderText="Bkg. Location" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk3" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ORGNCD")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField  HeaderText="Bkg. Date" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk4" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Bkg_Date")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField  HeaderText="Pay Basis" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk5" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PAYBAS_Str")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>

<%--                                <asp:TemplateField  HeaderText="Arrv. Date" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk6" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Arrival_Date")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>
--%>
                                <asp:TemplateField  HeaderText="Comm. Dely Date" ItemStyle-HorizontalAlign="left"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk7" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Commited_Dely_Date")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>


<%--                                <asp:TemplateField  HeaderText="Pending Pkgs." ItemStyle-HorizontalAlign="center"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk8" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PendPkgQty")%>'
                                            CssClass="redfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>
--%>

<%--                                <asp:TemplateField  HeaderText="Arrived Pkgs." ItemStyle-HorizontalAlign="center"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk9" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ArrPkgQty")%>'
                                            CssClass="bluefnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>
--%>
                                <asp:TemplateField  HeaderText="Booked Pkgs." ItemStyle-HorizontalAlign="center"
                                    ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lnk10" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "PKGSNO")%>'
                                            CssClass="blackfnt" Font-Underline="false" CommandArgument="<%# Container.DataItemIndex %>"
                                             />
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>

                        </asp:GridView>                
                    </td>
                </tr>
            </table>

            <table cellpadding="3" cellspacing="1" border="0" id="tblSubmitBtn" runat="server" width="900px" visible="false">
                <tr bgcolor="white">
                    <td align="right">
                        <asp:Button ID="btnCreatePRS" runat="server" Text="Generate PRS >>" OnClick="GeneratePRS"/>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
    
</asp:Content>
