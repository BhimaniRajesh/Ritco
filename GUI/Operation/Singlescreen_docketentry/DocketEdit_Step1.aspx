<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="DocketEdit_Step1.aspx.cs" Inherits="GUI_admin_DocketPrint_DocketList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


                               <%--THIS TWO FILES ARE FOR CALENDAR CONTROL--%>
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>


<script language ="JavaScript" type="text/javascript">
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	
	
	function openPartyPopUp()
	{
	    window.open("DataPopUp.aspx?mode=partycode&codeid=ctl00_MyCPH1_txtpartycode&codename=ctl00_MyCPH1_txtpartyname&tbl=none",null,'left=300, top=150, height=300, width= 300, status=n o, resizable= no, scrollbars= yes, toolbar= no,location= no, menubar= no');
	    return false;
	
	}
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
    

<br />
<u><font class="blackfnt"><b>Docket Entry</b> >> <font class="bluefnt"><b>Edit Selection</b></font></font></u>
<br /><br /><br />
       

<div align="center" style="width:10in;">


    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="100%">

                                            <%-- Blue Header --%>
          
          <tr class="bgbluegrey">
            <td align="center" colspan="2">
                <asp:Label ID="lblDateRange1" runat="server" CssClass="blackfnt" Font-Bold="True" Width="144px">Select Criteria</asp:Label>
            </td>
          </tr>
          
                                           <%-- Main Table --%>
                                           
          <tr style="background-color: white">
            <td align="left" valign="top" style="width: 146px">
                <asp:RadioButton ID="optdate" Checked="true" GroupName="grprad" runat="server" />
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
                                        <a href="#"  onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"  name="anchor1" id="anchor1" >
                                        <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0"> 
                                            
                                        </a> (dd/mm/yyyy)
                                   
                                    <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                        <a href="#"  onclick="cal.select(document.aspnetForm.ctl00_MyCPH1_txtDateTo,'anchor11','dd/MM/yyyy'); return false;"  name="anchor11" id="anchor11" >
                                        <img src="../../images/calendar.jpg" alt="calendar.jpg" border="0">
                                        
                                        </a> (dd/mm/yyyy)
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
          
          <tr bgcolor="#ffffff">
            <td align="left"><font class="blackfnt">Party Code : </font></td>
            <td align="left">
                <asp:TextBox ID="txtpartycode" runat="server" CssClass="blackfnt" BorderStyle="Groove" Width="70px"></asp:TextBox>
                <input type="button" id="btnpartycode" runat="server" onclick="javascript:return openPartyPopUp()" class="blackfnt" value="..." />
                <asp:TextBox ID="txtpartyname" runat="server" CssClass="blackfnt" BorderStyle="Groove"></asp:TextBox>
            </td>
          </tr>  
                  
          <tr class="bgbluegrey">
            <td align="Center" colspan="2"><font class="blackfnt"><b>OR</b></font></td>
          </tr>          
          
          <tr style="background-color: white">
            <td align="left" style="width: 146px">
            <asp:RadioButton ID="optdockno" GroupName="grprad" runat="server" />
            <font class="blackfnt">Enter Docket No:</font> </td>
            <td align="left">
                <asp:TextBox ID="txtdockno" ValidationGroup="grpmrno" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtdockno" ValidationGroup="grpmrno" ErrorMessage="Enter Docket Number Properly...."></asp:RequiredFieldValidator>
            </td>
          </tr> 
          
          <tr>
            <td align="center" colspan="2" bgcolor="#ffffff">
                <asp:Button ID="btnsubmit" ValidationGroup="grpmrno" Text="Submit" CssClass="blackfnt" OnClick="btnsubmit_Click" runat="server" />
            </td>
          </tr>         
     </table>       

<div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
          
</div>



</asp:Content>
