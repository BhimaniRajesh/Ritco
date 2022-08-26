<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="VendorVoucher_Step1.aspx.cs" Inherits="GUI_Octroi_ViewnPrint_VendorVoucher_Stept1" %>

<asp:Content ContentPlaceHolderID="MyCPH1" ID="any" runat="server">





                               <%--THIS TWO FILES ARE FOR CALENDAR CONTROL--%>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../admin/CustomerContractMaster/Scripts/CalendarPopup.js"></script>
<script language="JavaScript" type="text/javascript">
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</script>
                      <%--THIS FILE IS USED FOR DATEVALIDATION FUNCTION--%>
<script language="javascript" type="text/javascript" src="JS/ViewPrint.js"></script>




<script type="text/javascript" language="javascript">

      
        
        function requireValidate()
        {
          
            var opttype=document.getElementById("ctl00_MyCPH1_optdatetype");
            var optvoucher=document.getElementById("ctl00_MyCPH1_optvoucher");
            var optdoc=document.getElementById("ctl00_MyCPH1_optdoc");
            
            var radDate=document.getElementById("ctl00$MyCPH1$radDate");
            var voucherno=document.getElementById("ctl00$MyCPH1$txtvoucherno");
            var docno=document.getElementById("ctl00$MyCPH1$txtdocno");
            var date1=document.getElementById("ctl00$MyCPH1$txtDateFrom");
            var date2=document.getElementById("ctl00$MyCPH1$txtDateTo");
            
            var vendortype=document.getElementById("ctl00$MyCPH1$cmbvendortype");
            var vendorname=document.getElementById("ctl00$MyCPH1$cmbvendorname");
            
          
           if(opttype.checked==true)
            {
               if(radDate.value=="0")
                {
                    if(!isValidDate(date1.value,"From"))
                        return false;
                    if(!isValidDate(date2.value,"To"))
                        return false;
                        
                   if(vendortype=="Select")
                        return false;
                   if(vendorname=="select")
                        return false;
                }
            }
           else if(optvoucher.checked==true)
            {
                if(voucherno.value=="")
                    {
                        alert("Enter Voucher Number Properly........");
                        voucherno.focus();
                        return false;
                    }
            }
           else if(optdoc.checked==true)
            {
                if(docno.value=="")
                    {
                        alert("Enter Document Number Properly........");
                        docno.focus();
                        return false;
                    }
            }            
        }

</script>


<div align="center" runat="server" id="divall">

  
                              <%--Back Link To First Page in Viewing Octroy Bills--%>
                                  
    
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
                                              
                                              
    <table style="width:100%" class="boxbg" border="0" cellpadding="0" cellspacing="0">
        <tr bgcolor="#ffffff">
            <td align="center" class="blackfnt"><strong>View & Print Vendor Payment</strong></td>
        </tr>
    </table>
    <br />                                              
                                            

<table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="100%">
    <tr bgcolor="#ffffff">
        <td align="left" class="blackfnt" valign="top">
                <asp:RadioButton ID="optdatetype" Checked="true" runat="server" GroupName="grptype" />Select Date
        </td>    
        <td>
    <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="100%">


                                            <%-- Blue Header --%>

          
          <tr style="background-color: white">
            <td align="left" valign="top" style="width: 175px">
                <asp:Label ID="lblDateRange1" runat="server" CssClass="blackfnt" Font-Bold="False" Width="144px">Select Voucher Date</asp:Label>
            </td>
            <td colspan="">
                    <table cellpadding="0" cellspacing="0" class="boxbg" border="0"> 
                        <tr style="background-color: white">
                            <td align="left" valign="top" class="blackfnt" >
                              <asp:UpdatePanel ID="UpdatePanel1" runat="server"     UpdateMode="Conditional" RenderMode="Inline">
                                    <ContentTemplate>
                                        <asp:RadioButtonList ID="radDate" runat="server" AutoPostBack="true" CssClass="blackfnt"
                                            OnSelectedIndexChanged="radDate_OnSelectedIndexChange"  Width="210px">
                                            <asp:ListItem Selected="True" Text=" Date Range [dd/mm/yyyy]" Value="0"></asp:ListItem>
                                            <asp:ListItem Text=" Last Week (Including Today)" Value="1"></asp:ListItem>
                                            <asp:ListItem Text=" Today:" Value="2"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </ContentTemplate>
                              </asp:UpdatePanel>
                            </td>
                        <td align="left" valign="top" class="blackfnt">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" runat="server" CssClass="blackfnt" Text=" From: "></asp:Label>
                                    <asp:TextBox ID="txtDateFrom" runat="Server" Width="80"></asp:TextBox>
                                        <a href="#"  onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor1','dd/MM/yyyy'); return false;"  name="anchor1" id="a1" ><img src="../../admin/CustomerContractMaster/images/calendar.jpg" alt="calendar.jpg" border="0"> 
                                            
                                        </a> (dd/mm/yyyy)
                                   
                                    <asp:Label ID="lblTo" runat="server" CssClass="blackfnt" Text=" To: "></asp:Label>
                                    <asp:TextBox ID="txtDateTo" runat="Server"  Width="80"></asp:TextBox>
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
          
                
           <tr bgcolor="#ffffff">
               <td align ="center" colspan="3" class="bgbluegrey"><font class="blackfnt"><b>Select Voucher For</b></font></td>
           </tr>

           
           <tr bgcolor="#ffffff">
              <td align="left" style="font-size: 12pt; font-family: Times New Roman; width: 175px;">
                   <font class="blackfnt">Select Vendor Type : </font>
              </td>
              <td align="left">
              <asp:UpdatePanel ID="u1" runat="server">
                    <ContentTemplate>
                         <asp:DropDownList ID="cmbvendortype" AutoPostBack="true" OnSelectedIndexChanged="cmbvendortype_SelectedIndexChanged" runat="server">
                                <asp:ListItem> -- All -- </asp:ListItem>
                         </asp:DropDownList>
                     </ContentTemplate>
                 </asp:UpdatePanel>
              </td>
           </tr>
           
           <tr bgcolor="#ffffff">
              <td align="left"  style="font-size: 12pt; font-family: Times New Roman; width: 175px;"><font class="blackfnt">Select Vendor : </font></td>
              <td align="left" bgcolor="#ffffff" colspan="2" style="font-size: 12pt; font-family: Times New Roman">
                <asp:UpdatePanel ID="u2" runat="server">
                    <ContentTemplate>
                        <asp:DropDownList ID="cmbvendorname" runat="server">
                                
                         </asp:DropDownList>
                    </ContentTemplate>
                    <Triggers>
                       <asp:AsyncPostBackTrigger ControlID="cmbvendortype" EventName="SelectedIndexChanged" />
                    </Triggers>
                 </asp:UpdatePanel>
              </td>
           </tr>
       </table>
       
       
     </td> <%-- first line second cell--%>
    </tr>
    
    
    <tr class="bgbluegrey">
         <td align="center" colspan="2" class="blackfnt">OR</td>
    </tr>
         
         
    <tr bgcolor="#ffffff">
         <td align="left" valign="top" class="blackfnt">
             <asp:RadioButton ID="optvoucher" runat="server" GroupName="grptype" />By Voucher
        </td>
    <td align="left">
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="100%">
            <tr bgcolor="#ffffff">
                <td class="blackfnt" style="width:21%" valign="top" align="left">Voucher Number</td>
                <td align="left" valign="top">
                  <asp:TextBox ID="txtvoucherno" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
    </td>
</tr>  

    
    <tr class="bgbluegrey">
         <td align="center" colspan="2" class="blackfnt">OR</td>
    </tr>
         
         
    <tr bgcolor="#ffffff">
         <td align="left" valign="top" class="blackfnt">
             <asp:RadioButton ID="optdoc" runat="server" GroupName="grptype" />By Doc No.
        </td>
    <td align="left">
        <table bgcolor="#808080" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="100%">
            <tr bgcolor="#ffffff">
                <td class="blackfnt" style="width:21%" valign="top" align="left">Document Number</td>
                <td align="left" valign="top">
                  <asp:TextBox ID="txtdocno" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
    </td>
</tr>  
    
    
    <tr bgcolor="#ffffff">
        <td align="center" colspan="3">
              <asp:Button  runat="server" ID="btnsubmit" OnClick="btnsubmit_Click" Text="Submit"/>
        </td>
    </tr>
</table>
             <div id="testdiv1" style="position:absolute;visibility:hidden;background-color:white;z-index:99;"></div>
</div>



</asp:Content>
