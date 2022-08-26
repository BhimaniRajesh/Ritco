<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="vendorContract_profile.aspx.cs" Inherits="GUI_Admin_Vendor_contract_vendorContract_profile"   Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<br /><br /><br />
<SCRIPT LANGUAGE="JavaScript" SRC="../../Images/CalendarPopup.js"></SCRIPT> 
<script language="javascript" src="../../images/commonJs.js"></script>
<SCRIPT LANGUAGE="JavaScript" type="text/javascript">
var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</script>

  <script language="javascript" type="text/javascript">
  function  Check_num(obj,arg){
		if (isNaN(obj.value))
    	{
     	 alert("Please enter in numeric")
      		obj.focus();
      		obj.value="0.00";
      	return false;
    	}
	}
var dtCh= "/";
var minYear=1900;
var maxYear=2100;
function  Check_num(obj,arg){
		if (isNaN(obj.value))
    	{
     	 alert("Please enter in numeric")
      		obj.focus();
      	return false;
    	}
	}

var months = new Array("","January", "February", "March", "April", "May", "June",
	"July", "August", "September", "October", "November", "December");
 function BranchPopup(strPopupURL)
            {
                var strWinFeature = "height=280,width=350,resizable=yes,scrollbars=yes,left=420,top=5"
                
                winNew = window.open(strPopupURL, "_blank", strWinFeature)
            }
            
            
            
//function Submitdata(txtContractDt,txtContractloccode,txtValidDt.ClientID,txtVendorPerName,txtEffectDt,cboVendorCategory,cboVendorContractCat,txtVendorPin,txtSecDepDt,txtPayLoccode,chkRoad,chkAir,chkRail,chkExpress,btnShow)
//{
function Submitdata(txtContractDt,txtContractloccode,txtValidDt,txtVendorPerName,txtEffectDt,cboVendorCategory,cboVendorContractCat,txtVendorPin,txtSecDepDt,txtPayLoccode,chkRoad,chkAir,chkRail,chkExpress,btnShow)
{

	if(txtContractDt.value=="")
	{
			alert("Please Enter the Contract Date")
			txtContractDt.focus();
			return false;
	}
	
	 if(txtContractDt.value!="")
	{
	   	if (ValidateForm(txtContractDt)==false)
	   	{
	   		return false;
	   	}
	}
	
	  var dt ="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
                            //var dt =document.getElementById("ctl00$MyCPH1$GV_D1$ctl02$txtSTART_DATE").value
                            var dt_dd=dt.substring(0,2)
                            var dt_mm=dt.substring(3,5)
                            // alert("hi")
                            var dt_yy=dt.substring(6,10)

                            dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
                           // alert(dt)
	
	if(txtContractDt.value!="")
				      {
				          var  pdt=txtContractDt.value
        				  
                      ContractDt =txtContractDt.value
	//alert(ContractDt)
	ContractDt_dd=ContractDt.substring(0,2)
	ContractDt_mm=ContractDt.substring(3,5)
	ContractDt_yy=ContractDt.substring(6,10)
	ContractDt=new Date(months[parseFloat(ContractDt_mm)] + " " + parseFloat(ContractDt_dd) + ", " + parseFloat(ContractDt_yy))
                 //   alert(ContractDt)
                          
                          // alert(ContractDt)
                            if (dt<ContractDt)
                            {
                                alert( "Contract Date can not be greater than today's date !!!")
                                txtContractDt.focus();
                                return false;
                            }
                    }
                    
                    
    if(txtContractloccode.value=="")
	{
		alert("Please Enter the Contract Signing  Location")
		txtContractloccode.focus();
		return false;
	}
	
	
		if(txtValidDt.value=="")
	{
			alert("Please Enter the Contract Valid Till Date")
			document.form1.txtValidDt.focus();
			return false;
	}

    if(txtValidDt.value!="")
	{
	   	if (ValidateForm(txtValidDt)==false)
	   	{
	   		return false;
	   	}
	}
	
	ContractDt1 =txtValidDt.value
	ContractDt_dd=ContractDt1.substring(0,2)
	ContractDt_mm=ContractDt1.substring(3,5)
	ContractDt_yy=ContractDt1.substring(6,10)
	
	ValidDt=new Date(months[parseFloat(ContractDt_mm)] + " " + parseFloat(ContractDt_dd) + ", " + parseFloat(ContractDt_yy))
	
	if(ValidDt < ContractDt  )
	{
	    alert("Valid Till Date should be greater than Contract Date")
	    txtContractDt.focus();
		return false;
	}
	
		if(txtVendorPerName.value=="")
	{
		alert("Please Enter the Vendor")
		txtVendorPerName.focus();
		return false;
	}
	
  	
	if(txtEffectDt.value=="")
	{
			alert("Please Enter the Effective Date")
			txtEffectDt.focus();
			return false;
	}

    if(txtEffectDt.value!="")
	{
	   	if (ValidateForm(txtEffectDt)==false)
	   	{
	   		return false;
	   	}
	}
	ContractDt2 =txtEffectDt.value
	ContractDt_dd=ContractDt2.substring(0,2)
	ContractDt_mm=ContractDt2.substring(3,5)
	ContractDt_yy=ContractDt2.substring(6,10)
	
	EffectDt=new Date(months[parseFloat(ContractDt_mm)] + " " + parseFloat(ContractDt_dd) + ", " + parseFloat(ContractDt_yy))
	
	if(EffectDt < ContractDt  )
	{
	    alert("Effective Till Date should be greater than Contract Date")
	   txtContractDt.focus();
		return false;
	}
	
	
	if(cboVendorCategory.value=="")
	{
			alert("Please Enter the Vendor Category")
			cboVendorCategory.focus();
			return false;
	}
	
	if(cboVendorCategory.value=="")
	{
			alert("Please Enter the Vendor Category")
			cboVendorCategory.focus();
			return false;
	}
	
	if(cboVendorContractCat.value=="")
	{
			alert("Please Enter the Vendor Contract Category")
			cboVendorContractCat.focus();
			return false;
	}
	 
	if(txtVendorPin.value!="")
	{
			if(isNaN(txtVendorPin.value)||(txtVendorPin.value.length!=6))
			{
				alert("Please Enter the Proper Pin No")
				txtVendorPin.focus();
				return false;
			}	
	} 
	
	/*if(document.form1.txtSecDepDt.value=="")
	{
			alert("Please Enter the Security Deposit Date")
			document.form1.txtSecDepDt.focus();
			return false;
	}*/

    if(txtSecDepDt.value!="")
	{
	   	if (ValidateForm(txtSecDepDt)==false)
	   	{
	   		return false;
	   	}
	}
	
	if((chkRoad.checked==false) &&(chkAir.checked==false)&& (chkRail.checked==false)&& (chkExpress.checked==false))
	{
		alert("Vendor should have atleast one service type")
  		chkRoad.focus();
		return false;
	}
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
 
 <table width="80%" border="0" align="left" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><font class="blklnkund"><strong> Module</strong></font>
          
		<strong> &gt; </strong><font class="blklnkund"><strong>Administrator </strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Finance & Accounts</strong></font>

<strong> &gt; </strong> <font class="blklnkund"><strong>Vendor Contract Master </strong></font>

<font class=bluefnt><strong> &gt; </strong>
		  <strong>New Contract </strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"/></td>
        </tr>

   
        
        <tr> 
          <td align=right><img src="./../../images/back.gif" border=0/></td>
        </tr>
                    <tr> 
                      <td height="300" valign="top">
					  <!--START--> 
<table align="letf" border=0 cellPadding=7 cellSpacing=1 style="width: 9.5in;" class="boxbg">
<tr class="bgbluegrey">
<td colspan=3 align=center><font class=blackfnt><b>VENDOR CONTRACT MASTER </b></font></td>
</tr>
<tr>
<td bgcolor="#FFFFFF">
<table  BORDER=0 align="left" cellSpacing=1 cellpadding=6 style="width: 9.0in;" class="boxbg">
        <tr class="bgbluegrey"> 
          <td colspan=4><font class=blackfnt><strong><U>Step : 1</U></strong></font></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="25%" nowrap><font class=blackfnt>Vendor Name</font></td>
          <td width="25%">&nbsp;<asp:Label ID="vendor"  CssClass="blackfnt" runat="server" Text=""></asp:Label></td>
          <td width="25%"><font class=blackfnt>Vendor Type</font></td>
          <td width="25%">&nbsp;<asp:Label ID="vendortype" CssClass="blackfnt"  runat="server" Text=""></asp:Label></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%" nowrap><font class=blackfnt>Contract Code</font></td>
          <td class="blackfnt" style="color: #ff3366; width: 371px;" >
                &nbsp;
                <asp:Label ID="lblConrtaID" runat="server" Text="System Generated..."></asp:Label></td>
          <td width="20%"><font class=blackfnt>Contract date</font></td>
          <td nowrap>&nbsp;<asp:TextBox class="input"   ID="txtContractDt" runat="server" MaxLength="10" Width="60px"></asp:TextBox>
          
          <A HREF="#"
			   onClick="cal.select(ctl00$MyCPH1$txtContractDt,'anchor1','dd/MM/yyyy'); return false;"
			   NAME="anchor1" ID="anchor1"><img src="../../images/calendar.jpg" border="0"></img>
			</A></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%" nowrap><font class=blackfnt>Contract signing location</font></td>
          <td>&nbsp;<asp:TextBox ID="txtContractloccode" class="input"   runat="server" Width="48px"></asp:TextBox>
           <input type="button" value="..." runat="server" id="btnAt" onclick="BranchPopup('../../Uni_mis/Branch_Popup.aspx?9,A,A')" /></td>
         
          <td width="15%" nowrap><font class=blackfnt>Valid Until</font></td>
          <td nowrap>&nbsp;<asp:TextBox class="input"  ID="txtValidDt" MaxLength="10" runat="server" Width="60px"></asp:TextBox>
            <A HREF="#"
			   onClick="cal.select(ctl00$MyCPH1$txtValidDt,'anchor2','dd/MM/yyyy'); return false;"
			   NAME="anchor2" ID="anchor2"><img src="../../images/calendar.jpg" border="0"></img>
			</A></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%"><font class=blackfnt>Vendor representative</font></td>
          <td width="20%">&nbsp;<asp:TextBox ID="txtVendorPerName" class="input"  runat="server" Width="90px"></asp:TextBox></td>
          <td width="20%" nowrap><font class=blackfnt>Effective from date</font></td>
          <td nowrap>&nbsp;<asp:TextBox ID="txtEffectDt" class="input"  MaxLength="10" runat="server" Width="60px"></asp:TextBox>
          <A HREF="#"
			   onClick="cal.select(ctl00$MyCPH1$txtEffectDt,'anchor3','dd/MM/yyyy'); return false;"
			   NAME="anchor3" ID="anchor3"><img src="../../images/calendar.jpg" border="0"></img>
			</A></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%"><font class=blackfnt>Designation</font></td>
          <td width="20%">&nbsp;<asp:TextBox ID="txtVendorPerDesg" runat="server" Width="144px"></asp:TextBox></td>
          <td width="20%" nowrap><font class=blackfnt>Company employee name</font></td>
          <td>&nbsp;<asp:TextBox ID="txtCompEmpName" runat="server"></asp:TextBox></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%"><font class=blackfnt>Vendor Witness</font></td>
          <td width="20%">&nbsp;<asp:TextBox ID="txtVendorWitness" runat="server"></asp:TextBox></td>
          <td width="20%" nowrap><font class=blackfnt>Designation </font></td>
          <td>&nbsp;<asp:TextBox ID="txtCompEmpDesg" runat="server"></asp:TextBox></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%"><font class=blackfnt>Vendor Address</font></td>
          <td width="20%">&nbsp;<asp:TextBox ID="txtVendorAdd"   TextMode="MultiLine"  runat="server" Width="136px"></asp:TextBox></td>
          <td width="20%" nowrap><font class=blackfnt>Company witness </font></td>
          <td>&nbsp;<asp:TextBox ID="txtCompWitness" runat="server"></asp:TextBox></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%"><font class=blackfnt>City- Pin</font></td>
          <td width="20%">&nbsp;<asp:TextBox ID="txtVendorCity" runat="server" Width="88px"></asp:TextBox>-<asp:TextBox
                  ID="txtVendorPin" MaxLength="6" runat="server" Width="48px"></asp:TextBox></td>
          <td width="20%" nowrap><font class=blackfnt>Vendor category</font></td>
          <td>&nbsp;<asp:DropDownList ID="cboVendorCategory" runat="server">
          <asp:ListItem Text="--Select-- " Value=""></asp:ListItem>
          <asp:ListItem Text="Contract" Value="C"></asp:ListItem>
          <asp:ListItem Text="Non Contract" Value="NC"></asp:ListItem>
              </asp:DropDownList></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%"><font class=blackfnt>TDS Applicable</font></td>
          <td >&nbsp;<asp:UpdatePanel ID="upChkActFlag" runat="server">
                                                    <ContentTemplate>
                                                    <asp:CheckBox ID="TDSChk" runat="server" AutoPostBack="True" OnCheckedChanged="TDSChk_CheckedChanged" />
              <asp:TextBox ID="txtTDS" runat="server" ReadOnly="True" Width="40px">No</asp:TextBox>
              </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="TDSChk" EventName="CheckedChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel></td>
          
          <td width="20%" nowrap><font class=blackfnt>Contract Category</font></td>
          <td>&nbsp;<asp:DropDownList ID="cboVendorContractCat" runat="server" Width="80px">
          <asp:ListItem Text="--Select-- " Value=""></asp:ListItem>
          <asp:ListItem Text="Contract" Value="C"></asp:ListItem>
          <asp:ListItem Text="Subcontract" Value="S"></asp:ListItem>
              </asp:DropDownList></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%"><font class=blackfnt>TDS Rate</font></td>
          <td width="20%">&nbsp;<asp:TextBox ID="txtTdsRate" runat="server"></asp:TextBox></td>
          <td width="20%" nowrap><font class=blackfnt>Security deposit cheque(s)</font></td>
          <td>&nbsp;<asp:TextBox ID="txtNoOfCheques" runat="server"></asp:TextBox></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%"><font class=blackfnt>Payment interval</font></td>
          <td width="20%">&nbsp;<asp:DropDownList ID="cboPayInterval" runat="server">
              
              <asp:ListItem Text="--Select-- " Value=""></asp:ListItem>
          <asp:ListItem Text="Quarterly" Value="Quarterly"></asp:ListItem>
          <asp:ListItem Text="Monthly" Value="Monthly"></asp:ListItem>
           <asp:ListItem Text="Weekly" Value="Weekly"></asp:ListItem>
          
              </asp:DropDownList><td width="20%" nowrap><font class=blackfnt>Security deposit date</font></td>
          <td nowrap>&nbsp;<asp:TextBox ID="txtSecDepDt" MaxLength="10" runat="server" Width="60px"></asp:TextBox>
           <A HREF="#"
			   onClick="cal.select(ctl00$MyCPH1$txtSecDepDt,'anchor4','dd/MM/yyyy'); return false;"
			   NAME="anchor4" ID="anchor4"><img src="../../images/calendar.jpg" border="0"></img>
			</A></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%"><font class=blackfnt>Payment Basis</font></td>
          <td width="20%">&nbsp;<asp:DropDownList ID="cboTransType" runat="server">
          <asp:ListItem Text="--Select-- " Value=""></asp:ListItem>
          <asp:ListItem Text="Cash" Value="Cash"></asp:ListItem>
          <asp:ListItem Text="Cheque" Value="Cheque"></asp:ListItem>
           <asp:ListItem Text="DD" Value="DD"></asp:ListItem>
              </asp:DropDownList></td>
          <td width="20%" nowrap><font class=blackfnt>Security deposit Amount</font></td>
          <td>&nbsp;<asp:TextBox ID="txtSecDepAmt" runat="server"></asp:TextBox></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%" nowrap><font class=blackfnt>Payment location</font></td>
          <td><font class=blackfnt>&nbsp; 
              <asp:TextBox ID="txtPayLoccode" runat="server" Width="48px"></asp:TextBox></font></td>
          <td><font class=blackfnt>Monthly Phone Charges</font></td>
          <td>&nbsp;<asp:TextBox ID="txtMonPhChrg" runat="server"></asp:TextBox></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%" nowrap><font class=blackfnt>Service</font></td>
          <td colspan=2><font class=blackfnt>&nbsp;<asp:CheckBox ID="chkAir" runat="server" />
              <asp:Label ID="lblAir" runat="server" CssClass="blackfnt" Text=""></asp:Label></font></td>
          <td>&nbsp;<asp:CheckBox ID="chkRoad" runat="server" />
              <asp:Label ID="lblRoad" runat="server" CssClass="blackfnt" Text=""></asp:Label></td>
        </tr>
        <tr bgcolor="#ffffff"> 
          <td width="20%" nowrap><font class=blackfnt>&nbsp;</font></td>
          <td colspan=2>&nbsp;<asp:CheckBox ID="chkRail" runat="server" />
              <asp:Label ID="lblTrain" runat="server" CssClass="blackfnt" Text=""></asp:Label></td>
          <td>&nbsp;<asp:CheckBox ID="chkExpress" runat="server" />
              <asp:Label ID="lblEXp" runat="server" CssClass="blackfnt" Text=""></asp:Label></td>
        </tr>

        <tr bgcolor="#FFFFFF"> 
          <td colspan=4 align=middle>&nbsp; <asp:Button ID="btnShow" runat="server" Text="Submit" OnClick="btnShow_Click"   Width="75px"  /></td>
        </tr>
      </table>
</td>
</tr>
</table>
</td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td></td>
                    </tr>
                  </table>

<DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV>
</asp:Content>

