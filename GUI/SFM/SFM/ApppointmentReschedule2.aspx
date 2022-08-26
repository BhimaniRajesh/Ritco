<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ApppointmentReschedule2.aspx.cs" Inherits="SFM_ApppointmentReschedule2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <%--<script type="text/javascript" language="javascript" src="../CAL/datetimepicker.js"></script>
    <link href="../CAL/popcalendar.css" type="text/css" rel="stylesheet" />
    <script language="javascript" type="text/javascript" src="../CAL/popcalendar.js"></script>--%>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>

    <script language="javascript" type="text/javascript">
    
    var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    </script>

    <script language="javascript" type="text/javascript">
function OpenWindow(prospectcode)
        {
            var strWinFeature = "menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125"
            var strURL = "../REPORT/pros_reg_detail.aspx?prospectcode="+prospectcode    
            winNew = window.open(strURL,"_blank",strWinFeature)
        }
function check(txtReshceduleDt,txtTime)
{
    if(txtReshceduleDt.value=="")
    {
    alert("Please Enter Reschedule Date")
    txtReshceduleDt.focus()
    return false
    }
    
    if(txtTime.value=="")
    {
    alert("Please Enter Time")
    txtTime.focus()
    return false
    }
}

function setButton(id) 
{
var grid=document.getElementById("ctl00_MyCPH1_GridAppointment");
var rows=grid.rows.length;
    var pref="";
    var lblPref = "";
    for(var i=2;i<rows+1;i++)
    {
        if(i<10)
            pref="ctl00_MyCPH1_GridAppointment_ctl0" + i;
        else
            pref="ctl00_MyCPH1_GridAppointment_ctl" + i;
            
            var iradId= pref + "_Radio1"
            lblPref = pref + "_lblAppointmentCode";
            
            if(id!=iradId)    
                {
                    var obj=document.getElementById(iradId);
                    obj.checked=false;
                }            
                 else 
                {
                    if(document.getElementById("ctl00_MyCPH1_txtAppointment"))
                    {
                    document.getElementById("ctl00_MyCPH1_txtAppointment").value = document.getElementById(lblPref).innerText;
                    }
                    else if(document.getElementById("ctl00_MyCPH1_txtAppointmentCode2"))
                    {
                    document.getElementById("ctl00_MyCPH1_txtAppointmentCode2").value = document.getElementById(lblPref).innerText;
                    }
                    
                }
            
    }
    
}
                  

    </script>

    <table style="width: 100%">
        <tr>
            <td align="left" colspan="3">
                <asp:Label ID="lblWelcome" runat="server" Text="Reschedule/Cancel Appointment" CssClass="blackfnt"
                    Font-Bold="true"></asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    <br />
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right">
                <a href="javascript:window.history.go(-1)" title="back">
                    <img border="0" src="../images/back.gif" alt="" /></a>
            </td>
        </tr>
    </table>
    <br />
    <div align="center">
        <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td>
                    <asp:GridView ID="GridAppointment" runat="server" align="center" BorderWidth="1"
                        CellPadding="2" HeaderStyle-CssClass="bgbluegrey" CssClass="boxbg" BackColor="white"
                        FooterStyle-CssClass="boxbg" AllowPaging="false" PageSize="100" OnPageIndexChanging="pgChange"
                        AllowSorting="False" AutoGenerateColumns="false" Width="100%">
                        <Columns>
                            <%--<asp:TemplateField  HeaderText="SRNo."  ControlStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true">
          <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
          <ItemStyle CssClass="blackfnt" />
          <ItemTemplate>
          <asp:Label ID="lblSRNo" text ="<%# Container.DataItemIndex+1 %>" runat="server">
          </asp:Label>
          </ItemTemplate>
          </asp:TemplateField>   --%>
                            <asp:TemplateField HeaderText="Select" ControlStyle-CssClass="blackfnt" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" Width="30" />
                                <ItemStyle CssClass="blackfnt" />
                                <ItemTemplate>
                                    <asp:RadioButton ID="Radio1" runat="server" GroupName="ABC" onclick="setButton(this.getAttribute('id'));" />
                                   <%-- <input id="Radio1" onclick='setButton(this);' runat="server"  name="AAA" type="radio" value='<%#DataBinder.Eval(Container.DataItem, "AppointmentCode") %>' />--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ProspectCode" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Left" />
                                <ItemTemplate>
                                <asp:Label ID="lblAppointmentCode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "AppointmentCode")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ProspectCode" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Font-Bold="true" HorizontalAlign="Left" />
                                <ItemTemplate>
                                <asp:Label ID="lblProspectId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ProspectCode")%>'></asp:Label>
                                    <a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "ProspectCode") %>')">
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Company" HeaderStyle-Font-Bold="true">
                                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                                <ItemStyle CssClass="blackfnt" Font-Bold="true" />
                                <ItemTemplate>
                                    <%--<a href="JavaScript:OpenWindow('<%#DataBinder.Eval(Container.DataItem, "Company") %>')"> --%>
                                    <%#DataBinder.Eval(Container.DataItem, "Company")%>
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="City" HeaderText="City" HeaderStyle-CssClass="blackfnt"
                                ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-Font-Bold="true" />
                            <asp:BoundField DataField="SalesManager" HeaderText="Sales Manager" HeaderStyle-CssClass="blackfnt"
                                ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Center"
                                HeaderStyle-Font-Bold="true" />
                            <asp:BoundField DataField="AppointmentDt" HeaderText="Appointment Date" HeaderStyle-CssClass="blackfnt"
                                ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left"
                                HeaderStyle-Font-Bold="true" />
                            <asp:BoundField DataField="AppTime" HeaderText="Time" HeaderStyle-CssClass="blackfnt"
                                ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left"
                                HeaderStyle-Font-Bold="true" />
                            <asp:BoundField DataField="Purpose" HeaderText="Purpose of Visit" HeaderStyle-CssClass="blackfnt"
                                ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left"
                                HeaderStyle-Font-Bold="true" />
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" HeaderStyle-CssClass="blackfnt"
                                ItemStyle-CssClass="blackfnt" ControlStyle-CssClass="blackfnt" ItemStyle-HorizontalAlign="Left"
                                HeaderStyle-Font-Bold="true" />
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td width="50%" valign="middle" align="left" height="25">
                    <asp:UpdatePanel ID="up" runat="server">
                        <ContentTemplate>
                            <asp:RadioButton ID="RadioButton1" runat="server" OnCheckedChanged="RadioButton1_CheckedChanged"
                                AutoPostBack="true" Checked="false" />
                            <font class="blackfnt">Reschedule</font>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td width="50%" valign="middle" align="left" height="25">
                    <asp:UpdatePanel ID="up2" runat="server">
                        <ContentTemplate>
                            <asp:RadioButton ID="RadioButton2" runat="server" OnCheckedChanged="RadioButton2_CheckedChanged"
                                AutoPostBack="true" Checked="false" />
                            <font class="blackfnt">Cancel</font> </td>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                </ContentTemplate> </asp:UpdatePanel> </td>
            </tr>
        </table>
        <br />
        <div align="center">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="p1" Width="100%" runat="server" Visible="false">
                        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                            cols="1" width="100%">
                            
                            <tr bgcolor="white">
                                <td align="left" class="field1" style="width: 175px; height: 21px;">
                                    <font class="blackfnt">Appointment Id.</font>
                                </td>
                                <td align="left" colspan="4">
                                    <asp:TextBox ID="txtAppointment" runat="server" Width="60px"></asp:TextBox>
                                </td>
                                
                            </tr>
                            <tr bgcolor="white">
                                <td align="left" class="field1" style="width: 175px; height: 21px;">
                                    <font class="blackfnt">Prospect/Customer Id.</font>
                                </td>
                                <td align="left" colspan="2">
                                    <asp:TextBox ID="txtCustCode" runat="server" Width="60px" ReadOnly="true"></asp:TextBox>
                                </td>
                                <td align="left" class="field1">
                                    <font class="blackfnt">Entry Date</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtEntrydate" runat="server" Width="70px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td align="left" class="field1">
                                    <font class="blackfnt">Reschedule Date</font>
                                </td>
                                <td align="left" colspan="2">
                                    <asp:TextBox ID="txtReshceduleDt" runat="server" Width="88px"></asp:TextBox>
                                    <a href="#" onclick="cal.select(ctl00$MyCPH1$txtReshceduleDt,'anchor1','dd/MM/yyyy'); return false;"
                                        name="anchor1" id="anchor1">
                                        <img src="../../images/calendar.jpg" border="0" />
                                </td>
                                <td align="left" class="field1">
                                    <font class="blackfnt">Time (In 24 hr. format)</font>
                                </td>
                                <td align="left">
                                    <font class="blackfnt">
                                        <asp:TextBox ID="txtTime" runat="server" Width="88px"></asp:TextBox>HH:MM
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtTime"
                                            ErrorMessage="Time is  required in HH:MM format" ValidationExpression="^\d{2}:\d{2}$"
                                            Width="200px"></asp:RegularExpressionValidator></font>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td align="left" class="field1">
                                    <font class="blackfnt">Remarks</font>
                                </td>
                                <td align="left" colspan="4">
                                    <asp:TextBox ID="txtRemarks" runat="server" Width="550px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" bgcolor="#ffffff" colspan="5">
                                    &nbsp;<asp:Button ID="btnsubmit1" runat="server" Text="Submit" Width="80px" OnClick="btnsubmit1_Click" /></td>
                            </tr>
                        </table>
                    </asp:Panel>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="RadioButton1" EventName="CheckedChanged" />
                </Triggers>
            </asp:UpdatePanel>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="p2" runat="server" Width="100%" Visible="false">
                        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg"
                            cols="1" width="100%">
                            
                             <tr bgcolor="white">
                                <td align="left" class="field1" style="width: 175px; height: 21px;">
                                    <font class="blackfnt">Appointment Id.</font>
                                </td>
                                <td align="left" colspan="4">
                                    <asp:TextBox ID="txtAppointmentCode2" runat="server" Width="60px"></asp:TextBox>
                                </td>
                                
                            </tr>
                            
                            <tr bgcolor="white">
                                <td align="left" class="field1">
                                    <font class="blackfnt">Prospect/Customer Id.</font>
                                </td>
                                <td align="left" colspan="2">
                                    <asp:TextBox ID="TextBox1" runat="server" Width="60px" ReadOnly="true"></asp:TextBox>
                                </td>
                                <td align="left" class="field1">
                                    <font class="blackfnt">Entry Date</font>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtEntryDt2" runat="server" Width="70px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr bgcolor="white">
                                <td align="left" class="field1">
                                    <font class="blackfnt">Reason For Cancellation :</font>
                                </td>
                                <td align="left" colspan="4">
                                    <asp:TextBox ID="txtReason" runat="server" Width="550px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" bgcolor="#ffffff" colspan="5">
                                    <asp:Button ID="btnSubmit2" runat="server" Text="Submit" Width="80px" OnClick="btnSubmit2_Click" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="RadioButton2" EventName="CheckedChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
            layer-background-color: white; z-index: 99;">
        </div>
</asp:Content>
