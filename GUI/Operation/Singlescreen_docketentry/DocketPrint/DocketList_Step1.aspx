<%@ Page Language="C#" AutoEventWireup="true" Trace="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="DocketList_Step1.aspx.cs" Inherits="GUI_admin_DocketPrint_DocketList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


                               <%--THIS TWO FILES ARE FOR CALENDAR CONTROL--%>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/CalendarPopup.js"></script>
                   
                              <%--THIS FILE IS USED FOR DATEVALIDATION FUNCTION--%>
<script language="javascript" type="text/javascript" src="../viewnprint/ViewPrint.js"></script>



<script language ="JavaScript" type="text/javascript">
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</script>



<script language="javascript" type="text/javascript">

    function dateValidate()
    {
        var optdate=document.getElementById("ctl00_MyCPH1_optdate");
        var optdockno=document.getElementById("ctl00_MyCPH1_optdockno");

        var date1=document.getElementById("ctl00_MyCPH1_txtDateFrom");
        var date2=document.getElementById("ctl00_MyCPH1_txtDateTo");
        var dockno=document.getElementById("ctl00$MyCPH1$txtdockno");
        
        if(optdate.checked==true)
            {
                if(!isValidDate(date1.value,"From"))
                    return false;
                if(!isValidDate(date2.value,"To"))
                    return false;
            }
         else if(optdockno.checked==true)   
            {
               if(dockno.value=="")        
                {
                    alert("Enter Docket Numer Properly or Select Date........");
                    txtdockno.focus();
                    return false;
                }
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
                <asp:Label ID="lblDateRange1" runat="server" CssClass="blackfnt" Font-Bold="False" Width="144px">Select Docket Date</asp:Label>
            </td>
          </tr>
          
                                           <%-- Main Table --%>
                                           
          <tr style="background-color: white">
            <td align="left" valign="top" style="width: 146px">
                <asp:RadioButton ID="optdate" GroupName="grprad" runat="server" />
                <font class="blackfnt"> Docket Date :</font> 
            </td>
            <td>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr style="background-color: white">
                            <td align="left" valign="top" >
                              <asp:UpdatePanel ID="UpdatePanel1" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                                    <ContentTemplate>
                                        <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                            OnSelectedIndexChanged="radDate_OnSelectedIndexChange" ValidationGroup="VGDtFromTo" Width="210px">
                                            <asp:ListItem Selected="True" Text=" Date Range [dd/mm/yyyy]" Value="0"></asp:ListItem>
                                            <asp:ListItem Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                            <asp:ListItem Text=" Today:" Value="2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </ContentTemplate>
                              </asp:UpdatePanel>
                            </td>
                        <td align="left" valign="top">
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
                    
          <tr class="bgbluegrey">
            <td align="Center" colspan="2"><font class="blackfnt">OR</font></td>
          </tr>          
          
          <tr style="background-color: white">
            <td align="left" style="width: 146px">
            <asp:RadioButton ID="optdockno" GroupName="grprad" runat="server" />
            <font class="blackfnt">Enter Docket No:</font> </td>
            <td align="left">
                <asp:TextBox ID="txtdockno" ValidationGroup="grpmrno" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtdockno" ValidationGroup="grpmrno" ErrorMessage="Enter MR Number Properly...."></asp:RequiredFieldValidator>
            </td>
          </tr> 
          
          <tr>
            <td align="center" colspan="2" bgcolor="#ffffff">
                <asp:Button ID="btnsubmit" ValidationGroup="grpmrno" Text="Submit" OnClick="btnsubmit_Click" runat="server" />
            </td>
          </tr>         
     </table>       

<div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
          
</div>



</asp:Content>
