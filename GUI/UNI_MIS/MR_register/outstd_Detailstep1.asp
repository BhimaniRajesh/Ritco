<!--#include file="../../SCargoConn.asp"-->
<!-- #include file="../../functions.asp" -->
<%
OPStr=trim(Request.QueryString)

session("date1")=""
session("date2")=""
session("Selection")=""
empcd =session("empcd")
brcd =session("brcd")
Selection=Request.Form("Selection")
tcmode=request.Form("tcmode")
tctype=request.Form("tctype")
selection=Request.Form("Selection")
sqlcust="SELECT distinct h.custcd,h.custnm from webx_custhdr h, webx_custdet d where h.custcd=d.custcd  order by custnm"' WHERE (OCAGBR LIKE '%" & bill_Loc & "%')"
Set MyRsCust = con.Execute(sqlcust)

sql="select Loccode,LocName from webx_Location where Octroi_IO <>'N' order by LocName asc"
'Response.Write "<br> sql : " & sql
set myrec=con.execute(sql)
RecFlag_Loc="N"
if not myrec.EOF then
    arrData_Loc=myrec.GetRows()
    RecFlag_Loc="Y"
end if
myrec.Close

Sql = "select E.empcd,E.currbrcd,B.LocName as brnm,B.Report_Level,B.Loc_Level from webx_empmst E inner join webx_LOCATION B on E.currbrcd=B.LocCode where E.currbrcd='" & brcd & "'"
Set MyRs = con.Execute(Sql)
if Not MyRs.EOF then
	CurrBrCd = MyRs.Fields("currbrcd")
	CurrBrNm = MyRs.Fields("brnm")
	Report_Level = MyRs.Fields("Report_Level")
	Loc_Level=MyRs.Fields("Loc_Level")
end if		

'response.write "<br>Loc_Level : " &Loc_Level


%>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
   <meta name="GENERATOR" content="Mozilla/4.73 [en] (Win98; I) [Netscape]">
   <title></title>
   
   <script language="javascript">
   
   
   var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");

function MyDateDiff( start, end, interval, rounding ) {

    var iOut = 0;
    /*
    // Create 2 error messages, 1 for each argument. 
    var startMsg = "Check the Start Date and End Date\n"
        startMsg += "must be a valid date format.\n\n"
        startMsg += "Please try again." ;
		
    var intervalMsg = "Sorry the dateAdd function only accepts\n"
        intervalMsg += "d, h, m OR s intervals.\n\n"
        intervalMsg += "Please try again." ;
*/
    var bufferA = Date.parse( start ) ;
    var bufferB = Date.parse( end ) ;
    	
    // check that the start parameter is a valid Date. 
    if ( isNaN (bufferA) || isNaN (bufferB) ) {
        alert( startMsg ) ;
        return null ;
    }
	
    // check that an interval parameter was not numeric. 
    if ( interval.charAt == 'undefined' ) {
        // the user specified an incorrect interval, handle the error. 
        alert( intervalMsg ) ;
        return null ;
    }
    
    var number = bufferB-bufferA ;
    
    // what kind of add to do? 
    switch (interval.charAt(0))
    {
        case 'd': case 'D': 
            iOut = parseInt(number / 86400000) ;
            if(rounding) iOut += parseInt((number % 86400000)/43200001) ;
            break ;
        case 'h': case 'H':
            iOut = parseInt(number / 3600000 ) ;
            if(rounding) iOut += parseInt((number % 3600000)/1800001) ;
            break ;
        case 'm': case 'M':
            iOut = parseInt(number / 60000 ) ;
            if(rounding) iOut += parseInt((number % 60000)/30001) ;
            break ;
        case 's': case 'S':
            iOut = parseInt(number / 1000 ) ;
            if(rounding) iOut += parseInt((number % 1000)/501) ;
            break ;
        default:
        // If we get to here then the interval parameter
        // didn't meet the d,h,m,s criteria.  Handle
        // the error. 		
        alert(intervalMsg) ;
        return null ;
    }
    return iOut ;
}

   
   
var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");


function ValidateForm(obj){
	if (isdate(obj.value)==false){
		obj.focus()
		return false
	}
    return true
 }
	
function seldate()
{
	if(document.form1.txtfromdt.value!="")
	{
	document.form1.Selection[0].checked=true
	}
	else if(document.form1.txttodt.value!="")
	{
	document.form1.Selection[0].checked=true
	}
}	
function DateCheck()
{
/*if(document.form1.cbolocation.value=="")
{
alert("Please select 'Location'")
document.form1.cbolocation.focus();
return false;
}*/

 if (document.form1.Selection[0].checked==true)
  {
		if(document.form1.txtfromdt.value=="")
		 {
		  alert("Please enter the From Date")
		  document.form1.txtfromdt.focus();
		  return false;
		 }
		if(document.form1.txtfromdt.value!="")
		 {
		if (ValidateForm(document.form1.txtfromdt)==false)
				{
				 return false;
				}
		 }
		if(document.form1.txttodt.value=="")
		 {
		  alert("Please enter the To Date")
		  document.form1.txttodt.focus();
		  return false;
		 }
		
		if(document.form1.txttodt.value!="")
		 {
		if (ValidateForm(document.form1.txttodt)==false)
				{
				 return false;
				}
		}
		

		var dt1=document.form1.txtfromdt.value
		var dd1=dt1.substring(0,2)
		var mm1=dt1.substring(3,5)
		var yy1=dt1.substring(6,10)
			
		var dt2=document.form1.txttodt.value
		var dd2=dt2.substring(0,2)
		var mm2=dt2.substring(3,5)
		var yy2=dt2.substring(6,10)

		dt1=new Date(months[parseFloat(mm1)]+ " " + parseFloat(dd1) + ", " + parseFloat(yy1)  + " ")		
		dt2=new Date(months[parseFloat(mm2)]+ " " + parseFloat(dd2) + ", " + parseFloat(yy2)  + " ")		
		
		
		
		var diff=parseFloat(MyDateDiff(dt1,dt2,'d',0))+1
		
		/*
		if (parseInt(diff)>31)
		{
		  alert("Date Range Should be of 31 days only")
		  document.form1.txtfromdt.focus();
		  return false
		}
		*/
		
  }	
  /* if(document.form1.cboRO.value=="" || document.form1.cboRO.value=="All"  )
		{
		 alert("Please Select One RO ")
		 document.form1.cboRO.focus();
		 return false;
		}
   if(document.form1.cbolocation.value=="" || document.form1.cbolocation.value=="All"  )
		{
		 alert("Please Select One Location")
		 document.form1.cbolocation.focus();
		 return false;
		}*/
  
  document.form1.action="outstd_Detailstep2.asp"
  document.form1.submit();
}

function Chk(obj){
//alert(obj.value)
	if (obj.value=="N" || obj.value=="C")
	{
		//alert("HI")
		//document.form1.cboLocation_TO.disabled=true
		//document.form1.cboRO_To.disabled=true
		document.form1.cboMRcash.disabled=true
	}
	else 
	{
	//alert("HI---")
	//document.form1.cboLocation_TO.disabled=false
		//document.form1.cboRO_To.disabled=false
		document.form1.cboMRcash.disabled=false
	}
	}
function branchpopup1(str1)
{
  winNew=window.open(str1,null,"height=280,width=350,resizable=yes,scrollbars=yes,left=420,top=5")
}
</script>
   <LINK title=stylesheet href="../../images/style.css" type=text/css rel=stylesheet>
   <SCRIPT LANGUAGE="JavaScript" SRC="../../Images/CalendarPopup.js"></SCRIPT> 
<script language="javascript" src="../../images/commonJs.js"></script>

<SCRIPT LANGUAGE="JavaScript">
	//var cal = new CalendarPopup();
	var cal = new CalendarPopup("testdiv1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
</SCRIPT>
<script language="javascript" src="dyn_loader.js"></script>
</head>
<body leftmargin="0" topmargin="0" marginwidth = "0" marginheight = "0">
<%
on error resume next

PageDesc="Reports-New Reports-MR Register Form "
%>
<form name=form1 method=post><!-- action = "tcstep2.asp">-->
<input type=hidden name=empcd value=<%=empcd%>>
<input name=OPStr type=hidden value="<%=OPstr%>">



<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td align=center> 
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
       <!--<tr> 
          <td height="30"><A href="../welcome.asp"><font class=blklnkund><strong>

		  <%=session("MainLevel_Type")%></font></a>
		  
	&gt; <a href="../../finance/finance.asp"><font class=blklnkund><strong>Finance </strong></font></a>

		<font class=bluefnt><strong> &gt;<a href="../../finance/reports.asp"><font class=blklnkund> <strong>
     		 Reports </strong> </font></a></strong>
     		  
    <strong> &gt; </strong><font class=bluefnt><strong>Bill Register - Details</strong></font></strong> </font>		  
		  </td>
        </tr>-->
        
        <tr> 
          <td height="30"><a href="../../welcome.asp"><font class=blklnkund><strong><%=session("MainLevel_Type")%> Module</strong></font></a><strong> &gt; </strong>
            <a href="../reportmenu.asp"><font class=blklnkund><strong>Reports</strong></font></a>
            <strong> &gt; </strong>

			<a href="../rpt_finance.asp"><font class=blklnkund><strong>Finance </strong></font></a>
            <strong> &gt; </strong>
			<font class=bluefnt><strong>MR Register - Details</strong> </font></td>
        </tr>
        
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="39%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="300" valign="top">
					  <!--START-->


						<br>
						<center>

							<TABLE BORDER=0 CELLPADDING=3 COLS=1 WIDTH="85%" BGCOLOR="#808080" cellspacing="1" class=boxbg>
                              <tr class="bgbluegrey"> 
                                <td  align="center" colspan="2"> <font class=blackfnt><b>Select 
                                  Criteria </b></font> </td>
                              </tr>
                              <TR bgcolor="#FFFFFF"> 
                                <!--<TD valign=top ><FONT class=blackfnt>Date Selection</FONT></TD>-->
                                <td valign=top><font class=blackfnt><font class=blackfnt>Select 
                                  MR 
                                  <select name="date_mr">
                                    <option value="mrsdt" selected >Generation 
                                    Date</option>
                                    <option value="finclosedt"  >Closing Date</option>
                                  </select>
                                  </font></td>
                                <td valign=top > <table  align="right">
                                    <tr> 
                                      <td> <input type="hidden" name="hSelection" value="2"> 
                                        <input type="radio" id=Selection name=Selection value="Date" onClick="Javascript:document.form1.hSelection.value='1'"> 
                                      </td>
                                      <td><input type="Text" name="txtfromdt" maxlength=10 size=10 class=input onBlur="seldate()"> 
                                        <a href="#"
						   onClick="cal.select(document.forms['form1'].txtfromdt,'anchor1','dd/MM/yyyy');document.form1.Selection[0].checked=true; return false;"
						   name="anchor1" id="anchor1" tabindex="<%=tabcntr+1%>"><img src="../../images/calendar.jpg" border="0"> 
                                        </a><font face=verdana size=1>(dd/mm/yyyy)</font> 
                                      </td>
                                      <td width="246"><div align="right"><font  class=blackfnt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To 
                                          : </font> 
                                          <input type="Text" name="txttodt" maxlength=10 size=10 class=input onBlur="seldate()">
                                          <a href="#"
					   onClick="cal.select(document.forms['form1'].txttodt,'anchor2','dd/MM/yyyy');document.form1.Selection[0].checked=true;  return false;"
					   name="anchor2" id="anchor2" tabindex="<%=tabcntr+1%>"><img src="../../images/calendar.jpg" border="0"> 
                                          </a><font face=verdana size=1>(dd/mm/yyyy)</font> 
                                        </div></td>
                                    </tr>
                                    <tr> 
                                      <td> <input name=Selection type="radio" id=Selection onClick="Javascript:document.form1.hSelection.value='2'" value="Today"  onSelect="seldate();" checked > 
                                      </td>
                                      <td colspan=2><font class=blackfnt>&nbsp;Todays 
                                        - <%=formatDateTime(date(),vbLongDate)%></font></td>
                                    </tr>
                                    <tr> 
                                      <td> <input type="radio" id=Selection name=Selection value="Week" onClick="Javascript:document.form1.hSelection.value='3'"> 
                                      </td>
                                      <td><font class=blackfnt> Last 7 Days</font></td>
                                      <td></td>
                                    </tr>
                                  </table></td>
                              </tr>
                              <%if cdbl(Loc_Level)<=2 then
	strMode = "Location"
	'Response.Write strMode
%>
                              <tr bgcolor="#FFFFFF"> 
                                <td><font class=blackfnt>Select RO</font></td>
                                <td  valign=top > 
                                  <!--#include file="./inc_cboRO.asp"-->
                                </td>
                              </tr>
                              <%end if%>
                              <tr bgcolor="#FFFFFF"> 
                                <td><font class=blackfnt>Select Location</font></td>
                                <td  valign=top > 
                                  <!--#include file="./inc_cboLocation.asp"-->
                                </td>
                              </tr>
                              <TR bgcolor="#FFFFFF"> 
                                <TD ><FONT class=blackfnt>MR Party &nbsp;:&nbsp;</TD>
                                <TD > <input name=partycode class=input  type=text size=7 maxlength=7  tabIndex="<%=tabcntr+1%>">
                                  <input tabIndex="<%=tabcntr+1%>" type=button value="..." name=branchpopup onclick="branchpopup1('../../webadmin/customer/popup-cust.asp')">
                                  &nbsp; </TD>
                              </tr>
                              <TR bgcolor="#FFFFFF"> 
                                <TD ><FONT class=blackfnt>MR Type &nbsp;:&nbsp;</TD>
                                <TD > <select name="cboNRtype">
                                    <option value="-" selected >-All-</option>
                                    <option value="1"><%=GetPayMode_MR(1)%></option>
                                    <option value="2"><%=GetPayMode_MR(2)%></option>
                                    <option value="3"><%=GetPayMode_MR(3)%></option>
                                    <option value="4"><%=GetPayMode_MR(4)%></option>
                                    <option value="5"><%=GetPayMode_MR(6)%></option>
                                    <!--<option value="6"><'%=GetBillType(6)%></option>
          <option value="7"><'%=GetBillType(7)%></option>
         <option value="7">Supplementary</option>
          <option value="6">Miscellaneous</option>
		 <option value="8">Trial TBB</option>-->
                                  </select></TD>
                              </TR>
                              <% if cdbl(Loc_Level)=1 then %>
                              <!--<TR bgcolor="#FFFFFF">
								<TD ><FONT class=blackfnt>MR Branch&nbsp;:&nbsp;</TD>
								<TD ><input name=billat class=input  type=text size=5 maxlength=3   tabIndex="<%=tabcntr+1%>" ><input tabIndex="<%=tabcntr+1%>" type=button value="..." name=branchpup1 onclick="branchpopup1('../popup-branch.asp?7,A,A')">&nbsp;
								</TD>
							</TR><%Else %>
							<TR bgcolor="#FFFFFF">
								<TD ><FONT class=blackfnt>MR Branch&nbsp;:&nbsp;</TD>
								<TD ><input name=billat class=input  type=text size=5 maxlength=3   tabIndex="<%=tabcntr+1%>" value="<%=session("brcd")%>" >
								</TD>
							</TR>-->
                              <%end if%>
                              <!--<TR bgcolor="#FFFFFF">
								<TD ><FONT class=blackfnt>Booking At &nbsp;:&nbsp;</TD>
								<TD ><input name=subat class=input  type=text size=5 maxlength=3   tabIndex="<%=tabcntr+1%>" ><input tabIndex="<%=tabcntr+1%>" type=button value="..." name=branchpup1 onclick="branchpopup1('../popup-branch.asp?8,A,A')">&nbsp;
								</TD>
							</TR>
							<TR bgcolor="#FFFFFF">
								<TD ><FONT class=blackfnt>Delivery  At&nbsp;:&nbsp;</TD>
								<TD ><input name=loccode class=input  type=text size=5 maxlength=3   tabIndex="<%=tabcntr+1%>" ><input tabIndex="<%=tabcntr+1%>" type=button value="..." name=branchpup1 onclick="branchpopup1('../popup-branch.asp?2,A,A')">&nbsp;
								</TD>
							</TR>-->
                              <TR bgcolor="#FFFFFF"> 
                                <TD ><FONT class=blackfnt>Status&nbsp;:&nbsp;</font></TD>
                                <TD ><select name="cboMRStatus" onChange="javascript:Chk(this);">
                                    <option value='-' Selected>-All-</option>
                                    <option value='N'>MR - Generated</option>
                                    <option value='Y'>MR - Closed</option>
                                    <option value='C'>Cancelled - MR</option>
                                    <!--  <option value='Unsubmitted – Due'>Unsubmitted – Due</option>
            <option value='Unsubmitted – Not Due'>Unsubmitted – Not Due</option>
            <option value='Collected'>Collected</option>-->
                                  </select></TD>
                              </TR>
                              <TR bgcolor="#FFFFFF">
                                <TD ><FONT class=blackfnt>MR List Type</FONT></TD>
                                <TD ><FONT class=blackfnt><select name="CBOsvctax">
            <option value='-' Selected>-All-</option>
            <option value='1'>With SVCTAX+Cess</option>
            <option value='2'>W/O SVCTAX+Cess</option>
           
          </select></FONT></TD>
                              </TR>
                              <TR bgcolor="#FFFFFF"> 
                                <TD ><FONT class=blackfnt>Cash/Cheque</font></TD>
                                <TD ><select name="cboMRcash">
                                    <option value='-' Selected>-All-</option>
                                    <option value='cash'>Close By Cash</option>
                                    <option value='cheque'>Close By Cheque</option>
                                  </select></TD>
                              </TR>
                              <!--<TR bgcolor="#FFFFFF">
								<TD ><FONT class=blackfnt>Over Due Days&nbsp;:&nbsp;</TD>
								<TD ><input name=oddays class=input  type=text size=5 maxlength=3  value=0 tabIndex="<%=tabcntr+1%>" onblur="return Nagative_Chk_woDecimal(this)" >&nbsp;
								</TD>
							</TR>-->
                              <TR bgcolor="#FFFFFF"> 
                                <TD ><FONT class=blackfnt>Amount Greater than&nbsp;:&nbsp;</TD>
                                <TD ><input name=amt class=input  type=text size=5 maxlength=9 value=0  tabIndex="<%=tabcntr+1%>" onblur="return Nagative_Chk_woDecimal(this)" >
                                  &nbsp; </TD>
                              </TR>
                              <tr bgcolor="#FFFFFF"> 
                                <td><font class=blackfnt>Enter MR No.</font></td>
                                <td  valign=top ><input name=dockno type=text size=30 maxlength=100 > 
                                  <font class="blackfnt">[seperated by <i>comma</i> 
                                  if multiple]</font> </td>
                              </tr>
                            </TABLE>
							
						<br>
								<INPUT type="Button" value="Submit" id=submit1 name=submit1 onclick="return DateCheck()">

						<br><br>
						</center>
					  
					  <!--END-->
					  </td>
                    </tr>
                    <tr> 
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td><!--#include file="../../bot.asp"--></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table>
    </td>
  </tr>
</table>

 <!--#include file="../../asp_track.asp"-->

</form>


</body>
</html>
</html><div id="manifest_list_div">
		</div><DIV ID="testdiv1" STYLE="position:absolute;visibility:hidden;background-color:white;layer-background-color:white;z-index:99;"></DIV>
