<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ManualOctroiMr_Step1.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_OctroiMR" %>






<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


                               <%--THIS TWO FILES ARE FOR CALENDAR CONTROL--%>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/CalendarPopup.js"></script>
                   
                              <%--THIS FILE IS USED FOR DATEVALIDATION FUNCTION--%>
<script language="javascript" type="text/javascript" src="JS/ViewPrint.js"></script>



<script language ="JavaScript" type="text/javascript">
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</script>



<script language="javascript" type="text/javascript">

    function dateValidate()
    {
        var optbtn=document.getElementById("ctl00$MyCPH1$radDate");
        var date1=document.getElementById("ctl00$MyCPH1$txtDateFrom");
        var date2=document.getElementById("ctl00$MyCPH1$txtDateTo");
        
        if(optbtn.value=="0")
            {
                if(!isValidDate(date1.value,"From"))
                    return false;
                if(!isValidDate(date2.value,"To"))
                    return false;
            }
    }

</script>
    
                                  <%--Back Link To First Page in Viewing Octroy Bills--%>
                                  
    <div align="center">
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right" style="height: 33px">
                <a href="javascript:window.history.go(-1)" title="back">
                <img border="0" src="../../images/back.gif"/ alt="back.gif" /></a>
            </td>
        </tr>
    </table>
    <br />
    
                                                    

                                            

    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">

                                            <%-- Blue Header --%>
          
          <tr class="bgbluegrey">
            <td align="center" colspan="2">
                <asp:Label ID="lblDateRange1" runat="server" CssClass="blackfnt" Font-Bold="False" Width="144px">Select MR Date</asp:Label>
            </td>
          </tr>
          
                                           <%-- Main Table --%>
                                           
          <tr style="background-color: white">
            <td align="left" valign="top" style="width: 146px"><font class="blackfnt"> MR Date :</font> </td>
            <td>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr style="background-color: white">
                            <td align="left" valign="top" class="blackfnt">
                              <asp:UpdatePanel ID="UpdatePanel1" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                                    <ContentTemplate>
                                        <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                            OnSelectedIndexChanged="radDate_OnSelectedIndexChange" ValidationGroup="VGDtFromTo" Width="210px">
                                            <asp:ListItem Selected="True" Text=" Date Range" Value="0"></asp:ListItem>
                                            <asp:ListItem Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                            <asp:ListItem Text=" Today:" Value="2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </ContentTemplate>
                              </asp:UpdatePanel>
                            </td>
                        <td align="left" valign="top" class="blackfnt">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                        <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"  name="anchor1" id="a1" ><img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"> 
                                            
                                        </a> (dd/mm/yyyy)
                                   
                                    <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                        <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor11','dd/MM/yyyy'); return false;"  name="anchor11" id="anchor11" ><img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"></a>(dd/mm/yyyy)
                                    <br />
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
                    
          <tr>
            <td align="center" colspan="2" bgcolor="#ffffff">
                <asp:Button ID="btnsubmit2" Text="Submit" OnClick="btnsubmit2_Click" runat="server" />
            </td>
          </tr>
          
          <tr class="bgbluegrey">
            <td align="Center" colspan="2"><font class="blackfnt">OR</font></td>
          </tr>          
          
          <tr style="background-color: white">
            <td align="left" style="width: 146px"><font class="blackfnt">Enter MR No:</font> </td>
            <td align="left">
                <asp:TextBox ID="txtmrno" ValidationGroup="grpmrno" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtmrno" ValidationGroup="grpmrno" ErrorMessage="Enter MR Number Properly...."></asp:RequiredFieldValidator>
            </td>
          </tr> 
          
          <tr>
            <td align="center" colspan="2" bgcolor="#ffffff">
                <asp:Button ID="btnsubmit1" ValidationGroup="grpmrno" Text="Submit" OnClick="btnsubmit1_Click" runat="server" />
            </td>
          </tr>         
     </table>       

<div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
          
</div>
</asp:Content>
