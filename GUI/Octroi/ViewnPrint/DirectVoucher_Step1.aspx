<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="DirectVoucher_Step1.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_DirectVoucher_Step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">


                         <%--THIS TWO FILES ARE FOR CALENDAR CONTROL--%>
<script language="javascript" type="text/javascript" src="./../../Images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="./../../Images/CalendarPopup.js"></script>
                
                      <%--THIS FILE IS USED FOR DATEVALIDATION FUNCTION--%>
<script language="javascript" type="text/javascript" src="JS/ViewPrint.js"></script>


<script language="JavaScript" type="text/javascript">
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</script>


<script language="javascript" type="text/javascript">
 

    
/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                   THIS FUNCTION PERFORMS EMPTY CHECK FOR MANDATORY FIELDS
 *=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
    
        function requireValidate()
        {
            var txtdatefrom=document.getElementById("ctl00$MyCPH1$txtDateFrom");
            var txtdateto=document.getElementById("ctl00$MyCPH1$txtDateTo");
            
            var txtdocno=document.getElementById("ctl00$MyCPH1$txtdocno");
            var txtbillno=document.getElementById("ctl00$MyCPH1$txtbillno");
            var txtrecno=document.getElementById("ctl00$MyCPH1$txtrecno");
            
             var optrecno=document.getElementById("ctl00_MyCPH1_optrecno");
             var optbillno=document.getElementById("ctl00_MyCPH1_optbillno");
             var optdocno=document.getElementById("ctl00_MyCPH1_optdocno");
             var optonlydates=document.getElementById("ctl00_MyCPH1_optonlydates");
            
                
                if(optonlydates.checked==true)
                    {
                        if(!isValidDate(txtdatefrom.value,"From"))
                            return false;
                        if(!isValidDate(txtdateto.value,"To"))
                            return false;
                    }        
                else if(optrecno.checked==true)
                    {
                        if(txtrecno.value=="")
                            {
                                alert("Enter Record Number");
                                txtrecno.focus();
                                return false;
                            }
                    }
                    
                if(optbillno.checked==true)
                    {
                        if(txtbillno.value=="")
                            {
                                alert("Enter Bill Number");
                                txtbillno.focus();
                                return false;
                            }
                    }
                    
                if(optdocno.checked==true)
                    {
                        if(txtdocno.value=="")
                            {
                                alert("Enter the Docket Numebr.");
                                txtdocno.focus();
                                return false;
                            }
                        
                    }
        
        
        }


</script>

<%--
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
                                            Voucher Bill
=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
--%>
                           

    
    <div align="center">

    
                              <%--Back Link To First Page in Viewing Octroy Bills--%>
                                  
    <br /><br />
    <table align="center" border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="right" style="height: 33px">
                <a href="javascript:window.history.go(-1)" title="back">
                <img border="0" src="../../images/back.gif"/ alt="back.gif" /></a>
            </td>
        </tr>
    </table>
    <br />
    
                                                    
                                              <%-- Main Table --%>
                                              
                                              
    <table class="boxbg" width="85%">
      
    </table>

    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="85%">


                                            <%-- Blue Header --%>

        <tr class="bgbluegrey">
            <td align="center" colspan="3" class="blackfnt"><strong>View& Print Direct Vouchers</strong></td>
        </tr>
        
          <tr style="background-color: white">
            <td align="right" valign="top">
                <asp:Label ID="lblDateRange1" runat="server" CssClass="blackfnt" Font-Bold="False">Select Voucher Date :</asp:Label>
            </td>
            <td>
                    <table cellpadding="0" cellspacing="0" class="boxbg" border="0"> 
                        <tr style="background-color: white">
                            <td align="left" valign="top" >
                              <asp:UpdatePanel ID="UpdatePanel1" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                                    <ContentTemplate>
                                        <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                            OnSelectedIndexChanged="radDate_OnSelectedIndexChange"  Width="210px">
                                            <asp:ListItem Selected="True" Text=" Date Range " Value="0"></asp:ListItem>
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
                                    <asp:TextBox ID="txtDateFrom" runat="Server" Width="80"></asp:TextBox>
                                        <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"  name="anchor1" id="a1" ><img src="./../../images/calendar.jpg" alt="calendar.jpg" border="0"> 
                                            
                                        </a> (dd/mm/yyyy)
                                   
                                    <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server"  Width="80"></asp:TextBox>
                                        <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor11','dd/MM/yyyy'); return false;"  name="anchor11" id="anchor11" ><img src="./../../images/calendar.jpg" alt="calendar.jpg" border="0"></a>(dd/mm/yyyy)
                                    
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
               <td align ="center" colspan="3" class="bgbluegrey"><font class="blackfnt"><b>Select Voucher For</b></font></td>
           </tr>
          
          
          
           <tr bgcolor="#ffffff">
              <td align="left" style="font-size: 12pt; font-family: Times New Roman;">
                   <font class="blackfnt">&nbsp;</font>
              </td>
              <td align="left" class="blackfnt">
                    <asp:RadioButton ID="optonlydates" Checked="true"  GroupName="grpvfor" runat="server" />&nbsp;&nbsp;Only Dates : 
              </td>
           </tr>
           
           <tr bgcolor="#ffffff">
               <td align ="right" style="font-size: 12pt; font-family: Times New Roman;">
                  <font class="blackfnt">Enter Docker No : </font>
               </td>
               <td bgcolor="#ffffff" align= "left" colspan="2">
                    <asp:RadioButton ID="optdocno" GroupName="grpvfor" runat="server" />
                    <asp:TextBox ID="txtdocno" runat="server"></asp:TextBox>
               </td>
           </tr>
           
           <tr bgcolor="#ffffff">
              <td align="left" style="font-size: 12pt; font-family: Times New Roman;">
                   <font class="blackfnt">Enter Agent Bill Number : </font>
              </td>
              <td align="left">
                    <asp:RadioButton ID="optbillno"  GroupName="grpvfor" runat="server" />
                    <asp:TextBox ID="txtbillno" runat="server"></asp:TextBox>
              </td>
           </tr>
           
           <tr bgcolor="#ffffff">
              <td align="left"  style="font-size: 12pt; font-family: Times New Roman;"><font class="blackfnt">Enter Octroi Reciept No. : </font></td>
              <td align="left" bgcolor="#ffffff" colspan="2" style="font-size: 12pt; font-family: Times New Roman">
                    <asp:RadioButton ID="optrecno" GroupName="grpvfor" runat="server" />
                    <asp:TextBox ID="txtrecno" runat="server"></asp:TextBox>
              </td>
           </tr>
           
           <tr bgcolor="#ffffff">
              <td align="center" colspan="3">
                    <asp:Button  runat="server" ID="btnsubmit" OnClick="btnsubmit_Click" Text="Submit"/>
              </td>
           </tr>
       </table>
                </div>
            <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
            
</asp:Content>
