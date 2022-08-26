<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="load_planner.aspx.cs" Inherits="GUI_admin_VehicleMaster_VehicleMasterAdd"
    EnableEventValidation="false" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js">
    </script>

    <script language="javascript" type="text/javascript">
            function san(chk,wgt)
            {
//            alert("Hi...sandy........");

//            alert(wgt);
//debugger

            if(document.getElementById("ctl00_MyCPH1_txttot").value == "")
            {
             document.getElementById("ctl00_MyCPH1_txttot").value=0;
            }
            if(document.getElementById(chk).checked == true)
            {
                    var tot= Number(document.getElementById("ctl00_MyCPH1_txttot").value)+Number(wgt)
             }
            else
            {
                    var tot= Number(document.getElementById("ctl00_MyCPH1_txttot").value)-Number(wgt)
             }
                         
             document.getElementById("ctl00_MyCPH1_txttot").value=tot; 
             
             var onn= Number(document.getElementById("ctl00_MyCPH1_txttot").value);
             var onn2= Number(document.getElementById("ctl00_MyCPH1_txtcap").value);
             
            // alert(onn);
      //    debugger
      document.getElementById("ctl00_MyCPH1_h_tot").value=onn;
       document.getElementById("ctl00_MyCPH1_h_cap").value=onn2;
             if(onn > onn2)
             {
                document.getElementById("ctl00_MyCPH1_txtop").value ="Truck is OverLoaded";
                alert("Truck is OverLoaded");
             }
             else
             {
                document.getElementById("ctl00_MyCPH1_txtop").value = "Truck is UnderLoaded";
             }
             
             document.getElementById("ctl00_MyCPH1_h_res").value=document.getElementById("ctl00_MyCPH1_txtop").value;
             

            }
    
    </script>

    <script language="vbscript" type="text/vbscript">
        
        function findDateDifference(dtFrom, dtTo, interval)
            
            findDateDifference = DateDiff(interval, dtFrom, dtTo)
            
        end function
        
    </script>

    <script language="vbscript" type="text/vbscript">
        
        function findDateDifference(dtFrom, dtTo, interval)
            
            findDateDifference = DateDiff(interval, dtFrom, dtTo)
            
        end function
        
    </script>

    <div align="left" style="width: 10in">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
            <ContentTemplate>
                <table border="0" align="center" cellpadding="0" cellspacing="0" style="width: 940px">
                    <tr>
                        <td height="30" style="width: 895px">
                            <a><font class="blklnkund"><strong>Module</strong></font></a> &gt; <a><font class="blklnkund">
                                <strong>Administrator </strong></font></a>&gt; <a href="../operations.aspx"><font
                                    class="blklnkund"><strong>Operations</strong></font></a> <font class="bluefnt"><strong>
                                        &gt; Load Planner</strong> </font>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <table width="100%" border="0" class="boxbg" cellspacing="1" cellpadding="5">
                    <tr class="bgbluegrey">
                        <td colspan="4" align="center">
                            <font class="bluefnt"><b>Vehicle Information</b></font></td>
                    </tr>
                    <tr style="background-color: White">
                        <td>
                            <font class="blackfnt">Vehicle Type &nbsp;&nbsp;:</font></td>
                        <td>
                            <asp:DropDownList ID="ddVehicleType" AutoPostBack="true" runat="server" Width="179px"
                                OnSelectedIndexChanged="ddVehicleType_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <font class="blackfnt">Vehicle No. &nbsp;&nbsp;:</font></td>
                        <td>
                            <asp:DropDownList ID="ddlvehno" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlvehno_SelectedIndexChanged"
                                Width="179px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
                <asp:Panel ID="pnl1" runat="server" Visible="false">
                    <table width="100%" border="0" class="boxbg" cellspacing="1" cellpadding="5">
                        <tr bgcolor="#FFFFFF">
                            <td>
                                <font class="blackfnt">GVW&nbsp;&nbsp;&nbsp;:</font></td>
                            <td>
                                <asp:Label ID="lblgvw" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                            <td>
                                <font class="blackfnt">Unladen&nbsp;&nbsp;&nbsp;:</font></td>
                            <td style="width: 5px">
                                <asp:Label ID="lblUnladen" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="#FFFFFF">
                            <td>
                                <font class="blackfnt">Payload &nbsp;&nbsp;&nbsp;:</font></td>
                            <td>
                                <asp:Label ID="lblpayload" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                            <td>
                                <font class="blackfnt">Capacity &nbsp;&nbsp;&nbsp;:</font></td>
                            <td>
                                <asp:Label ID="lblcapacity" runat="server" CssClass="blackfnt"></asp:Label>
                            </td>
                        </tr>
                        <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                            <td valign="top" align="left">
                                <asp:Label ID="Label3" CssClass="blackfnt" Text="Select Login Date" runat="server"
                                    Width="145px"></asp:Label>
                            </td>
                            <td align="left" style="width: 359px" valign="top">
                                <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                    AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1"
                                    Width="244px">
                                    <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                    <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                    <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                </asp:RadioButtonList></td>
                            <td valign="top" align="left" colspan="2" style="width: 359px">
                                <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"
                                    name="anchor1" id="anchor1">
                                    <img src="./../../images/calendar.jpg" border="0"></img>
                                </a>
                                <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor2','dd/MM/yyyy'); return false;"
                                    name="anchor2" id="a1">
                                    <img src="./../../images/calendar.jpg" border="0"></img>
                                </a>
                                <br />
                                <%--   <asp:CustomValidator CssClass="blackfnt" ID="CustomValidator2" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                    OnServerValidate="daterange"></asp:CustomValidator>--%>
                                <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom"
                                    ErrorMessage="Date From cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                    ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                    ErrorMessage="Date To cannot be blank :(" CssClass="blackfnt" ValidationGroup="VGDtFromTo" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :("
                                    ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                <br />
                                <asp:CustomValidator ID="CustomValidator1" CssClass="blackfnt" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                    OnServerValidate="daterange"></asp:CustomValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="blackfnt" runat="server"
                                    ControlToValidate="txtDateFrom" ErrorMessage="Date From Can Not Be Blank"></asp:RequiredFieldValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateTo"
                                    ErrorMessage="Date To Can Not Be Blank"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                            <td valign="top" colspan="4" align="left">
                                <center>
                                    <asp:Button ID="btnsubmit" Width="150" Text="Submit" OnClick="btnsubmit_Click" runat="server" /><asp:HiddenField
                                        ID="h_cap" runat="server" />
                                    <asp:HiddenField ID="h_tot" runat="server" />
                                    <asp:HiddenField ID="h_res" runat="server" />
                                </center>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <br />
                <center>
                    <asp:Panel ID="pnl2" runat="server" Visible="false">
                        <table width="100%" border="0" class="boxbg" cellspacing="1" cellpadding="5">
                            <tr bgcolor="#ffffff" align="center">
                                <td valign="top" colspan="4" align="right">
                                    <asp:Label ID="lblvehcap" CssClass="blackfnt" Text="Vehicle Capacity :" runat="server"
                                        Width="145px"></asp:Label>
                                    <asp:TextBox ID="txtcap" Enabled="false" Font-Bold="true" BorderWidth="0" BorderStyle="None"
                                        runat="server"></asp:TextBox>
                                    <br />
                                    <asp:Label ID="lblwht" CssClass="blackfnt" Text="Total Weight :" runat="server" Width="145px"></asp:Label>
                                    <asp:TextBox ID="txttot" Enabled="false" Font-Bold="true" BorderWidth="0" BorderStyle="None"
                                        runat="server"></asp:TextBox>
                                    <br />
                                    <asp:TextBox ID="txtop" Enabled="false" Font-Bold="true" BorderWidth="0" BorderStyle="None"
                                        runat="server"></asp:TextBox><br />
                                    <asp:Label ID="lblload" CssClass="blackfnt" Text="" runat="server" Width="145px"></asp:Label>
                                    <br />
                                    <center>
                                        <%--   <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>--%>
                                        <asp:GridView ID="GV_Booking" runat="server" align="center" BorderWidth="0" CellPadding="5"
                                            HeaderStyle-CssClass="bgbluegrey" CellSpacing="1" PagerStyle-HorizontalAlign="left"
                                            CssClass="boxbg" FooterStyle-CssClass="boxbg" AllowPaging="false" FooterStyle-BackColor="white"
                                            AllowSorting="False" AutoGenerateColumns="false" OnRowDataBound="GV_D_OnRowDataBound"
                                            PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                                            <PagerStyle VerticalAlign="Bottom" />
                                            <Columns>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:CheckBox ID="hdr_chsrno" AutoPostBack="true" OnCheckedChanged="ch_chg" runat="server" />
                                                    </HeaderTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                                                    <ItemStyle HorizontalAlign="right" CssClass="blackfnt" BackColor="white" />
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chsrno" runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:Label ID="Label21" Text='<%# Session["DocketCalledAs"] +" No." %>' runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                                                    <ItemStyle HorizontalAlign="right" CssClass="blackfnt" BackColor="white" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label32" Text='<%#DataBinder.Eval(Container.DataItem, "dockno")%>'
                                                            runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <asp:Label ID="Label24" Text='<%# Session["DocketCalledAs"] +" Date" %>' runat="server"></asp:Label>
                                                    </HeaderTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="true" CssClass="blackfnt" />
                                                    <ItemStyle HorizontalAlign="right" CssClass="blackfnt" BackColor="white" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label35" Text='<%#DataBinder.Eval(Container.DataItem, "dockdt")%>'
                                                            runat="server"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="actuwt" HeaderText="Actual Weight" ItemStyle-Wrap="true"
                                                    ItemStyle-BackColor="White">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle Width="20" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="chrgwt" HeaderText="Charged Weight" ItemStyle-Wrap="true"
                                                    ItemStyle-BackColor="White">
                                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                                    <ItemStyle Width="20" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                                                </asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                    </center>
                                    <%--   </ContentTemplate>
                            </asp:UpdatePanel>--%>
                                </td>
                            </tr>
                            <tr bgcolor="#ffffff" align="center">
                                <td valign="top" colspan="4" align="right">
                                    <tr bgcolor="#FFFFFF">
                                        <td align="center">
                                            <asp:Button ID="btn_csv" Width="150" Text="Submit" OnClick="btn_csv_Click" runat="server" />
                                        </td>
                                    </tr>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </center>
                <br />
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:Panel ID="pnl3" runat="server">
            <table width="100%" border="0" class="boxbg" cellspacing="1" cellpadding="5">
                <%--<tr bgcolor="#FFFFFF">
                    <td align="center">
                        <asp:Button ID="btn_csv" Width="150" Text="Submit" OnClick="btn_csv_Click" runat="server" />
                    </td>
                </tr>--%>
            </table>
        </asp:Panel>
    </div>
    <div id="divDate" style="position: absolute; visibility: hidden; background-color: white;
        z-index: 99;">
    </div>
</asp:Content>
