<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="CrossingDocketCriteria.aspx.cs" Inherits="GUI_Operations_Crossing_CrossingDocketCriteria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="javascript" src="../../images/commonJs.js"></script>

    <script type="text/javascript" language="javascript" src="../../images/CalendarPopup.js"></script>

    <script type="text/javascript" language="javascript">
     var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>

    <script type="text/javascript" language="javascript">
     function DateSelectionCheck()
        {
            var SelectDate = document.getElementById("ctl00_MyCPH1_rdSelectDate")
            var ddlDockDateType = document.getElementById("ctl00_MyCPH1_ddlDockDateType")
            var radDate = document.getElementById("ctl00_MyCPH1_radDate")
            //var btndestination = document.getElementById("ctl00_MyCPH1_btndestination")
            var txtdockno = document.getElementById("ctl00_MyCPH1_txtdockno")
            
            if(SelectDate.checked)
            {
                document.getElementById("ctl00_MyCPH1_ddlDockDateType").disabled = false;
                document.getElementById("ctl00_MyCPH1_radDate").disabled = false;
                //document.getElementById("ctl00_MyCPH1_btndestination").disabled = false;
                document.getElementById("ctl00_MyCPH1_txtdockno").disabled = true;
            }
        }
        
     function DocketSelectionCheck()
        {
            var SelectDocket = document.getElementById("ctl00_MyCPH1_rdSelectDocket")
            var ddlDockDateType = document.getElementById("ctl00_MyCPH1_ddlDockDateType")
            var radDate = document.getElementById("ctl00_MyCPH1_radDate")
            //var btndestination = document.getElementById("ctl00_MyCPH1_btndestination")
            var txtdockno = document.getElementById("ctl00_MyCPH1_txtdockno")
            
            if(SelectDocket.checked)
            {
                document.getElementById("ctl00_MyCPH1_ddlDockDateType").disabled = true;
                document.getElementById("ctl00_MyCPH1_radDate").disabled = true;
                //document.getElementById("ctl00_MyCPH1_btndestination").disabled = true;
                document.getElementById("ctl00_MyCPH1_txtdockno").disabled = false;
            }
        }
        
     function popuplist(mode,ctlid,tbl)
        {
            var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
            var url="";
            url="./../../Admin/CrossingVendorMaster/DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
            confirmWin=window.open(url,"",winOpts);
            
        }
    function btnsubmitClick()
        {
            var dockno=document.getElementById("ctl00_MyCPH1_txtdockno").value;
            var DateFrom=document.getElementById("ctl00_MyCPH1_txtDateFrom").value;
            var DateTo=document.getElementById("ctl00_MyCPH1_txtDateTo").value;
            //var Destination=document.getElementById("ctl00_MyCPH1_txtDestination").value;
            var ddlDeliveryMethod = document.getElementById("ctl00_MyCPH1_ddlDeliveryMethod").value;
            var cboVendorType = document.getElementById("ctl00_MyCPH1_cboVendorType").value;
            var cboVendor = document.getElementById("ctl00_MyCPH1_cboVendor").value;
            
            var SelectDocket = document.getElementById("ctl00_MyCPH1_rdSelectDocket")
            var SelectDate = document.getElementById("ctl00_MyCPH1_rdSelectDate")
            
            if(SelectDocket.checked)
                {
                    if(dockno == "")
                    {
                        alert("Please Enter Docket Number...!!!!")
                        return false;
                    }
                    if(ddlDeliveryMethod == "0")
                    {
                        alert("Please Select Delivery Method....!!!!")
                        return false;
                    }
                    if(cboVendorType == "0")
                    {
                        alert("Please Select Vendor Type....!!!!")
                        return false;
                    }
                    else if(cboVendor == "0")
                    {
                        alert("Please Select Vendor....!!!!")
                        return false;
                    }
                }
            
           else
                {
                    if(DateFrom == "")
                        {
                        alert("Please Enter From Date....!!!!")
                        return false;
                        }
                    if(DateTo == "")
                        {
                        alert("Please Enter To Date....!!!!")
                        return false;
                        }
//                    if(Destination == "")
//                        {
//                        alert("Please Select Destination City....!!!!")
//                        return false;
//                        }
                    if(ddlDeliveryMethod == "0")
                        {
                        alert("Please Select Delivery Method....!!!!")
                        return false;
                        }
                    if(cboVendorType == "0")
                        {
                        alert("Please Select Vendor Type....!!!!")
                        return false;
                        }
                    if(cboVendor == "0")
                        {
                        alert("Please Select Vendor....!!!!")
                        return false;
                        }
                }
        }
    </script>

    <br />
    <br />
    <asp:UpdatePanel ID="updone" runat="server">
        <ContentTemplate>
            <asp:Table ID="Table1" runat="server" CssClass="boxbg" Width="9in" CellSpacing="1"
                BorderWidth="0">
                <asp:TableRow CssClass="bgbluegrey">
                    <asp:TableCell ColumnSpan="5" Font-Bold="true" HorizontalAlign="Center">
            Docket Selection Criteria
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true" RowSpan="4">
                        <asp:RadioButton ID="rdSelectDate" runat="server" GroupName="Selection" onclick="javascript:return DateSelectionCheck()" />
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
           Docket Date Type
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true" ColumnSpan="3">
                        <asp:DropDownList ID="ddlDockDateType" runat="server">
                            <asp:ListItem Text="Booking Date" Value="B"></asp:ListItem>
                            <asp:ListItem Text="Arrival Date" Value="A"></asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true">
            Date Range
                    </asp:TableCell>
                    <asp:TableCell>
                        <asp:Table ID="Table2" runat="server" CssClass="boxbg" CellSpacing="1" Width="100%">
                            <asp:TableRow CssClass="bgwhite">
                                <asp:TableCell>
                                    <asp:UpdatePanel ID="UpdatePanel3"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                        <ContentTemplate>
                                            <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                                AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange">
                                                <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                                <asp:ListItem Selected="false" Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                                <asp:ListItem Selected="false" Value="2" Text=" Today:"></asp:ListItem>
                                                <asp:ListItem Selected="false" Value="3" Text=" Till Date:"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </asp:TableCell>
                                <asp:TableCell VerticalAlign="Top" ColumnSpan="3">
                                    <asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline"  UpdateMode="Conditional" runat="server">
                                        <ContentTemplate>
                                            <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                            <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                            <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                                                name="anchor1" id="anchor1">
                                                <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0">
                                            </a>[dd/mm/yyyy]
                                            <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                            <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                            <a href="#" onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDateTo,'anchor11','dd/MM/yyyy'); return false;"
                                                name="anchor11" id="anchor11">
                                                <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0">
                                            </a>[dd/mm/yyyy] </br>
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
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true">
           Origin
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Left" ColumnSpan="3">
                        <asp:TextBox ID="txtOrigin" Enabled="false" runat="server" TabIndex="2" MaxLength="10"
                            Width="70px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                    </asp:TableCell>
                </asp:TableRow>
               <%-- <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true">
           Destination city
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="Left" ColumnSpan="3">
                        <asp:TextBox ID="txtDestination" Enabled="false" runat="server" TabIndex="2" MaxLength="10"
                            Width="70px" BorderStyle="Groove" CssClass="blackfnt"></asp:TextBox>
                        <input type="button" id="btndestination" value="..." class="blackfnt" runat="server" />
                    </asp:TableCell>
                </asp:TableRow>--%>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ColumnSpan="5" Font-Bold="true" HorizontalAlign="Center">
            OR
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow ID="trdockno" runat="server" CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true">
                        <asp:RadioButton ID="rdSelectDocket" runat="server" GroupName="Selection" onclick="javascript:return DocketSelectionCheck()"
                            Checked="true" />
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
                     Enter Docket No
                    </asp:TableCell>
                    <asp:TableCell ColumnSpan="3" HorizontalAlign="Left">
                        <table>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtdockno" runat="server" CssClass="blackfnt" BorderStyle="Groove"
                                        Width="300px"></asp:TextBox></td>
                                <td>
                                    <%-- <asp:Image ID="imgdockettick" runat="server" Style="display: none;" Width="15px"
                                        Height="15px" ImageUrl="~/GUI/images/dockettick.jpg" />(If Multiple Enter Seprate
                                    by Comma)--%>
                                </td>
                            </tr>
                        </table>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true" RowSpan="3">
           
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true">
           Select Delivery Method
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true" ColumnSpan="3">
                        <asp:DropDownList ID="ddlDeliveryMethod" runat="server">
                            <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Crossing Challan" Value="C"></asp:ListItem>
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true">
           Delivery Vendor Type
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true" ColumnSpan="3">
                        <asp:DropDownList ID="cboVendorType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cboVendorType_SelectedIndexChanged">
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell Font-Bold="true">
           Select Vendor
                    </asp:TableCell>
                    <asp:TableCell Font-Bold="true" ColumnSpan="3">
                        <asp:DropDownList ID="cboVendor" runat="server">
                        </asp:DropDownList>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite">
                    <asp:TableCell ColumnSpan="5" HorizontalAlign="Center">
                        <asp:Button ID="btnsubmit" Text="Submit" runat="server" CssClass="blackfnt" OnClientClick="javascript:return btnsubmitClick()"
                            OnClick="btnsubmit_Click" />
                    </asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <asp:HiddenField ID="hdnserverdate" runat="server" />
            <asp:HiddenField ID="hdnorgnloc" runat="server" />
            <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
                z-index: 99;">
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script language="javascript" type="text/javascript">
								   window.onload=DocketSelectionCheck
    </script>

</asp:Content>
