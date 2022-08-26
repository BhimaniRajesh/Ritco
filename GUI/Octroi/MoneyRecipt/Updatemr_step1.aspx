<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"  AutoEventWireup="true" CodeFile="Updatemr_step1.aspx.cs" Inherits="GUI_Finance_MoneyRecipt_Updatemr_step1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
   <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
 
     <script language="javascript" type="text/javascript">
        var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");

        function Submitdata()
        {
           
           Form_name="ctl00$MyCPH1$"
           if (document.getElementById(Form_name+"txtmrsno").value=="" && document.getElementById(Form_name+"txtdocno").value=="")
           {
                    //alert("hi..")
                    //return false;
                    if(document.getElementById(Form_name+"txtDateFrom").value=="")
                     {
                        alert("PLz Enter From Date")
                        document.getElementById(Form_name+"txtDateFrom").focus();
                        return false;
                     }
                     
                     if(document.getElementById(Form_name+"txtDateFrom").value!="")
                     {
                        if (ValidateForm(document.getElementById(Form_name+"txtDateFrom"))==false)
			            {
			                document.getElementById(Form_name+"txtDateFrom").focus();
			               	 return false;
				        }
			          }
			       if(document.getElementById(Form_name+"txtDateTo").value=="")
                     {
                        alert("PLz Enter To Date")
                        document.getElementById(Form_name+"txtDateTo").focus()
                        return false;
                     }
                     if(document.getElementById(Form_name+"txtDateTo").value!="")
                     {
                        if (ValidateForm(document.getElementById(Form_name+"txtDateTo"))==false)
			            {
			                document.getElementById(Form_name+"txtDateTo").focus()
				            return false;
			            }
			          }
                     if(document.getElementById(Form_name+"mrstype").value=="")
                     {
                        alert("PLz Select Mrs Type")
                        document.getElementById(Form_name+"mrstype").focus()
                        return false;
                     }
                   //  alert("done")
                  return true;
           }
            return true;
        }
function ValidateForm(obj){

  if (obj.value!="")
  {
    
	if (isDate(obj.value)==false){
	
		obj.focus()
		return false
	}
    return true
  }  
 }
 var dtCh= "/";
 var minYear=1900;
var maxYear=2100;
 function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}
  function isDate(dtStr){
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		alert("The date format should be : dd/mm/yyyy")
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		alert("Please enter a valid month")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		alert("Please enter a valid day")
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		alert("Please enter a valid date")
		return false
	}
	return true
}
    </script>
    <div>
     <table width="10in" border="0" cellpadding="0" cellspacing="0" align="left">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr><td><font class="blackfnt"><b><a href="../../welcome.aspx"><font class="blklnkund"><strong>Module</strong></font></a><strong> &gt; </strong></font>
 
   <a href="#"><font class="blklnkund"><strong>Finance</strong> </font></a>
   &gt; <font class="bluefnt"><strong>  
		   Update MR  
		   
		  </strong> </font>
   </td></tr>
    <%-- <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>--%>

        <%--<tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr>--%>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>
   
    <tr>
    <td>
<asp:UpdatePanel ID="UP1" runat="Server">
<ContentTemplate>
<table cellspacing="1" style="width: 100%; height: 263px;" border="0" align="center"  >
            
            
                <tr align="center">
                    <td style="height: 324px" align="center" colspan="3">
                        <table cellspacing="1"  cellpadding="3" style="width: 800px" class="boxbg" border="0" align="left" > 
                            <tr class="bgbluegrey">
                                <td colspan="3" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" 
                                        Font-Bold="true" runat="server">
                                        Select Criteria
                                    </asp:Label>
                                </td>
                            </tr>
                            
                                  <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                                        <td valign="top" align ="left">
                                                       <asp:Label ID="Label3"  CssClass="blackfnt" Text="MR Date" runat="server" Width="145px"></asp:Label>    
                                                            </td>
                                                        <td  align="left" style="width: 359px" valign="top">
                                                            <asp:RadioButtonList ID="radDate" runat="server" ValidationGroup="VGDtFromTo" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_SelectedIndexChanged" RepeatColumns="1" Width="244px">
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Value="1" Text=" Last Week (Including Today)"></asp:ListItem>
                                        <asp:ListItem Value="2" Text=" Today:"></asp:ListItem>
                                          </asp:RadioButtonList></td>
                                                        
                                                        <td valign="top" align="left" style="width: 359px">
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label><asp:TextBox ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox><asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label><asp:TextBox ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="80"></asp:TextBox>
                                                           <%-- <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Date Range Must Be 1 month Only"
                                                                OnServerValidate="daterange"></asp:CustomValidator>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDateFrom"
                                                                ErrorMessage="Date From Can Not Be Blank"></asp:RequiredFieldValidator>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDateTo"
                                                                ErrorMessage="Date To Can Not Be Blank"></asp:RequiredFieldValidator></td>
--%>                        </tr>
                        <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                             <td  align="left"  class="blackfnt" >
                             
                                    MRs Type</td>
                                <td colspan="2" align="left"  class="blackfnt" >
                             
                                    <asp:DropDownList ID="mrstype" runat="server">
                                  <%--  <asp:ListItem Value="" >Select</asp:ListItem>
                                    <asp:ListItem Value="1" >Paid MR</asp:ListItem>--%>
                                     <asp:ListItem Value="4" Selected="true">Octroi MR</asp:ListItem>
                                    </asp:DropDownList></td>
                          </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                             
                                <td colspan="3" align="center"  class="blackfnt" >
                             
                                    OR</td>
                                
                            </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="left" valign="top">
                                    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Text="MR NO."
                                        Width="145px"></asp:Label></td>
                                <td align="left" colspan="2" style="width: 359px" valign="top">
                                    <asp:TextBox ID="txtmrsno" runat="server"></asp:TextBox></td>
                                
                            </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                 <td colspan="3"  align="center"  class="blackfnt" >
                             
                                    OR</td>
                                
                            </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                <td align="left" style="height: 21px" valign="top">
                                    <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Text="Docket No."
                                        Width="145px"></asp:Label></td>
                                <td align="left"  colspan="2" style="width: 359px; height: 21px" valign="top">
                                    <asp:TextBox ID="txtdocno" runat="server"></asp:TextBox></td>
                                 
                            </tr>
                            <tr bgcolor="#ffffff" style="font-size: 12pt; font-family: Times New Roman">
                                 <td colspan="3"  align="center"  class="blackfnt" >
                             
                                    <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Submit" CssClass="blackfnt" /></td>
                                
                            </tr>
                        
                        </table>
                        
</ContentTemplate>
</asp:UpdatePanel>


</td>
        </tr>
        </table>
        </div>


</asp:Content>
