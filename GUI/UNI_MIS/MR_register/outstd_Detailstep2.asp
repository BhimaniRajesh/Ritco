<!-- #include file="../../SCargoConn.asp"-->
<!-- #include file="../../functions.asp"-->
<%		
	function iif(cond,tresult,fresult)
						if cond=true then
								iif=tresult
						else
								iif=fresult
						end if			
	end function

	set MyRs1=server.CreateObject("adodb.recordset")
	
	date_mr=Request.Form("date_mr")
	
	function getChequeno(mrsno)
			set rsInv= server.CreateObject("adodb.recordset")
			sql="select distinct CHQNO + '/' + convert(varchar,chqdt,106) as CHQNO from WEBX_BILLCHQDETAIL where DOCNO='" & mrsno & "' "'and docksf='" & docksf  & "'"' and DOC_CURLOC='" & orgncd & "'"
			
			'Response.Write("<br>sql--> " &sql )
			
		
			set rsInv=con.execute(sql)
			StrInv=""
			do until rsInv.EOF
				if StrInv="" then
					StrInv=rsInv.Fields("CHQNO") 
					'Response.Write("<br>StrInv-1-> " &StrInv )
				else
					StrInv=StrInv + " , <br>" + rsInv.Fields("CHQNO")  
					'Response.Write("<br>StrInv-2-> " &StrInv )
				end if 
				
				
			rsInv.MoveNext
			loop
			rsInv.Close 
			getChequeno=StrInv
end function
	
	
	MRType=trim(Request.form("cboNRtype"))
	if MRType <> "-" then
		MRTypeDesc=GetPayMode_MR(MRType)
	else
		MRTypeDesc="All"
		MRType="ALL"
	end if
	
	loccode=Request.Form("loccode")
		
	if trim(loccode)<>"" then
		locName=getLocation(loccode)
		if locName="" then
			ErrMsg = "Invalid Branch Code!!!" 
		end if
		option2det=loccode & " : " & locName
	else
		option2det= "All"
		loccode="ALL"
	end if
	
	billat_RO=Request.Form("cboRO")
	if trim(billat_RO)<>"" then
		billatName_RO=getLocation(billat_RO)
		if billatName_RO="" then
			ErrMsg = "Invalid Branch Code!!!" 
		end if
		option4det_RO=billat_RO & " : " & billatName_RO
	else
		option4det_Ro= "All"
		billat_RO="ALL"
	end if
	
	if option4det_Ro <> "All" then
		option4det_RO=billat_RO & " : " & getLocation(billat_RO)
		else 
		response.write "All"
	end if
	'response.write " <br > billat_RO : " &billat_RO 
	'response.end
	
	billat=Request.Form("cbolocation")
	if trim(billat)<>"" then
		billatName=getLocation(billat)
		if billatName="" then
			ErrMsg = "Invalid Branch Code!!!" 
		end if
		option4det=billat & " : " & billatName
	else
		option4det= "All"
		billat="ALL"
	end if
	'response.write " <br > billat : " &billat 
		session("billat_RO")=billat_RO
	
	session("billat")=billat
	subat=Request.Form("subat")
	if trim(subat)<>"" then
		subatName=getLocation(subat)
		if subatName="" then
			ErrMsg = "Invalid Branch Code!!!" 
		end if
		optionSdet=subat & " : " & subatName
	else
		optionSdet= "All"
		subat="ALL"
	end if
	
	oddaysDesc=Request.Form("oddays")
	if oddaysDesc="0" then
		oddaysDesc="All"
	end if
	
	if oddaysDesc="All" then
		oddays=0
	else
		oddays	=oddaysDesc
	end if
	
	amtDesc=formatNumber(Request.Form("amt"),2,,,false)
	if amtDesc="0.00" then
		amtDesc="All"
	end if
	if amtDesc="All" then
		MRamt=0
	else
		MRamt=formatNumber(Request.Form("amt"),2,,,false)
	end if
	
		
	MRStatus=Request.Form("cboMRStatus")
	'response.write " <br> MRStatus " &  MRStatus
	if MRStatus = "-" then
		MRStatus="All"
		MRStatusDesc="ALL"
	else
	 	MRStatusDesc=MRStatus
	end if
	MRcash=Request.Form("cboMRcash")
	'response.write " <br> MRcash " &  MRcash
	if MRcash = "-"  or MRcash = ""  then
		MRcash="All"
		MRcashDesc="ALL"
	else
	 	MRcashDesc=MRcash
	end if
	Custcd=Request.Form("partycode")
		'selection1cls=" and ocbillno in (select OCBILLNO from cci_oct_hdr where OCAGBILLNO='" & OCAGBILLNO & "')"
		
	if trim(Custcd)<>"" then
		CustName=getCustomer(Custcd)
		if CustName="" then
			ErrMsg = "Invalid Party Code!!!" 
		end if
		option3det=Custcd & " : " & CustName
	else
		option3det= "All"
	end if	
	if Custcd="" then
		Custcd="ALL"
	end if
	
	Selection=Request.Form("Selection")
	
	CBOsvctax=Request.Form("CBOsvctax")
		
	if  CBOsvctax="-" then
		CBOsvctax="ALL"
	end if
	
	Dt=Date()
	select case Selection
		case  "Date"
		   FromDt=mydate1(Request.Form("txtfromdt"))
		   ToDt=mydate1(Request.Form("txttodt"))

		   FromDt1=(Request.Form("txtfromdt"))
		   ToDt1=(Request.Form("txttodt"))
		case "Today"
			 FromDt= mydate(Dt)
			 ToDt= mydate(Dt)
		case "Week"
		   FromDt=mydate(cdate(Dt) -6)
		   ToDt= mydate(cdate(Dt))
	end select
	mDateRange= FromDt & " - " & ToDt	
	'Response.Write " <br> Custcd " &  Custcd
	'Response.Write " <br> FromDt " &  FromDt
	'Response.Write " <br> ToDt " &  ToDt
	'Response.Write " <br> MRType " &  MRType
	'Response.Write " <br> MRStatusDesc " &  MRStatusDesc
	'Response.Write " <br> MRamt " &  MRamt
	
	'Response.Write " <br> Loccode " &  Loccode
	'Response.Write " <br> billat " &  billat
	'Response.Write " <br> subat " &  subat
	
	set myrec=server.CreateObject("adodb.recordset")
    set myrec1=server.CreateObject("adodb.recordset")
        
	'currentpage = TRIM(Request.QueryString("currentPage"))
	'If currentPage = "" then currentPage=1
	dim  currentPage, rowCount, ctr
		currentpage = TRIM(Request.QueryString("currentPage"))
		If currentPage = "" then 
			currentpage1 = TRIM(Request.FORM("currentPage1"))'27-Apr-05
			IF currentpage1 <> "" and srchcol="" THEN
				currentPage=currentpage1
			ELSE
				currentPage=1
			END IF 
		END IF	
		
	myrec.CursorType =3
	myrec.PageSize =25'25'2
	pgsize=25
	myrec.CursorLocation = 3
	
	if billat_RO="" or billat_RO="ALL"  then billat_RO="All"
	if billat="" or   billat="ALL" then billat="All"

'cboRO=Request.Form("cboRO")
dockno=trim(Request.Form("dockno"))
if  dockno<>"" then
sql="select MRSNo,MRSDT,MRSTYPE,MRSBR,MRBRNNM,PTCD,PTNAME,ORGNCD,DOCBKNM,DESTCD,DOCDLNM,MRSAMT,dockno,(case when paymode='cash'then mrscash else mrschq end) as Closeamt,MRS_CLOSED,paymode,finclosedt,DEDUCTION,miscchrg,MR_CANCEL,NETAMT,(select  sum(chqamt) as CHQNO from WEBX_BILLCHQDETAIL where DOCNO= d.mrsno)  as chq_amt,remark,report_loc,ded_tds,finclose_empcd,BCANEMPCD  from vw_MRS_Register_report d with(NOLOCK) where mrsno in ('" & Replace(Replace(Trim(dockno)," ",""),",","','") & "')"
else
	sql="exec webx_MR_DETAIL_ver3  '" & Custcd & "','" & FromDt & "','" & ToDt & "','"  & MRType & "','" & MRStatusDesc & "','" & MRamt & "','" & billat & "','" & subat & "','" & Loccode & "','" & MRcashDesc & "','" & billat_RO & "','"&date_mr&"','"&CBOsvctax&"'" 
end if
	'," & oddays & "
Response.Write " <br> SQL " &  Sql
'Response.End 
	session("DKTFLOWDET_SQL")=sql
	'set Myrs=con.execute(sql)
	session("date_mr")=date_mr 
	session("CBOsvctax")=CBOsvctax
	'if NOT Myrs.EOF then
		'Response.Write " <br>--->1 " &  Myrs.FIELDS(0)
		'Response.Write " <br> --->2" &  Myrs.FIELDS(1)
	'END IF
	'Response.End 
	
	
	myrec.open sql,con
	if not myrec.EOF then
	  RecFlag="Y"
	  myrec.AbsolutePage = cint(currentPage)
	end if
	rowCount=0
		
%>
<html>
<head>
<title></title>
<script>
function saveCurrentIdx()		
		{	//alert(idx);
			idx = document.frm.cboPgNo.selectedIndex;
		}

function goToPage()
		{	
			yesNo = confirm("Do U Want to go to this Page?");
			if(yesNo)
			{	
			document.frm.action = "outstd_Detailstep2.asp?currentPage=" + document.frm.cboPgNo.options[document.frm.cboPgNo.selectedIndex].value;
					document.frm.target = "_self";
					document.frm.submit();	
			}
			else
			{
					document.frm.cboPgNo.selectedIndex = idx; 
			}
		}	
	
		function goPage(pg)
			{	
				document.frm.action = "outstd_Detailstep2.asp?currentPage=" + pg +",";
				document.frm.target = "_self";
				document.frm.submit();
			}	

function fnext(brcd,flagrc,amt)
{
document.frm.target="_self"
document.frm.flagrc.value=flagrc
document.frm.currbrcd.value=brcd
document.frm.selamt.value=amt
document.frm.action="outstd_summarystep3.asp"
document.frm.submit()
}
function fpartynext(custcd,agefrom,ageto,amt)
{
document.frm.target="_self"
document.frm.flagrc.value="C"
document.frm.custcd.value=custcd
document.frm.agefrom.value=agefrom
document.frm.ageto.value=ageto
document.frm.selamt.value=amt
document.frm.action="outstd_summarystep3.asp"
document.frm.submit()
}
function faction(printYN)
{
	 document.frm.target="_New"
	 document.frm.printYN.value=printYN
	 document.frm.method="post"
	 document.frm.action="outstd_detailstep2_xls.asp"
	 if(printYN=="1")
	 {
		document.frm.target="myform"
		var choice=""//outstd_summarystep2_xls.asp"
		var winOpts="scrollbars=yes,resizable=yes,left=25,top=100,width="+730+",height="+400+"";
		confirmWin=window.open(choice,document.frm.target,winOpts);
     }
     document.frm.submit();
}     
function popupmenu2(filestr,mrsno,printYN)
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
  confirmWin=window.open(filestr+ "?"+mrsno+","+printYN,"",winOpts);
 }

function ViewPrint(arg1,arg2,arg3)
{
	if(arg3=="2")
		window.open("../../finance/billing/billmr/billmr_print.asp?" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
	else
		window.open("mr_xls.asp?" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
	//window.open("mr_xls.asp?" + arg1 + "," + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK title=stylesheet href="../../images/style.css" type=text/css rel=stylesheet>
</head>
<body bgcolor="#FFFFFF">
<%
on error resume next

PageDesc="Reports-New Reports-MR Register Form Result"
%>
<form name="frm" method="post">
<input type=hidden name=partycode value="<%=Request.Form("partycode")%>">
<input type=hidden name=loccode value="<%=Request.Form("loccode")%>">
<input type=hidden name=txttodt value="<%=Request.Form("txttodt")%>">
<input type=hidden name=txtfromdt value="<%=Request.Form("txtfromdt")%>">
<input type=hidden name=printYN value="">
<input type=hidden name=Selection value="<%=Request.Form("Selection")%>">
<input type=hidden name=cboNRtype value="<%=Request.Form("cboNRtype")%>">
<input type=hidden name=cboMRStatus value="<%=Request.Form("cboMRStatus")%>">
<input type=hidden name=cboMRcash value="<%=Request.Form("cboMRcash")%>">
<input type=hidden name=oddays value="<%=Request.Form("oddays")%>">
<input type=hidden name=amt value="<%=Request.Form("amt")%>">
<input type=hidden name=cbolocation value="<%=Request.Form("cbolocation")%>">
<input type=hidden name=subat value="<%=Request.Form("subat")%>">
<input name=dockno type=hidden value="<%=dockno%>">
<input type=hidden name=date_mr value="<%=Request.Form("date_mr")%>">
<input type=hidden name=CBOsvctax value="<%=Request.Form("CBOsvctax")%>">





  <table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr> 
    <td> 
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
                <td height="30"><a href="../../welcome.asp"><font class=blklnkund><strong><%=session("MainLevel_Type")%> 
                  Module</strong></font></a><strong> &gt; </strong> <a href="../reportmenu.asp"><font class=blklnkund><strong>Reports</strong></font></a> 
                  <strong> &gt; </strong> <a href="../rpt_finance.asp"><font class=blklnkund><strong>Finance</strong></font></a> 
                  <strong> &gt; </strong> <font class=bluefnt><strong>MR Register 
                  - Details</strong> </font></td>
        </tr>
        
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>

        <tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr>
        
        <tr> 
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="39%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="300" valign="top">
					  <!--START-->  

<%if ErrMsg<>"" then%>	
						<br><br><br>
						<Table border=1 cellspacing=0 cellpadding=2 width=70% align=center class=bglightblue>
   					    <TR>
   							<TD align=center class="bgbluegrey"><font class=blackfnt color=red><b>Result</b></font></TD></TR>
						<TR><TD><br>
						   <p align=center><font class=blackfnt ><%=ErrMsg%></font><br>
						   <br><font class=blackfnt><a href="javascript:history.go(-1)"><u>Back</u></a></br></p>
						   </TD>
						  </TR>
						 </TABLE>				  
<%else%>
    <br>
  <p align="center"><font class=blackfnt><b>You Selected</b></font></p>
                              <table border=0 cellpadding=3 cols=1 width="565" bgcolor="#808080" cellspacing="1" align="center" class=boxbg>
                                <center>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td  width="205" > <font class=blackfnt >MR 
                                      Date </font></div> </td>
                                    <td  width="343" align="center"> <div align="left"><font class=blackfnt>&nbsp;<%=mDateRange%></font></div></td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td  width="205" > <font class=blackfnt >MR 
                                      Party </font></div> </td>
                                    <td  width="343" align="center"> <div align="left"><font class=blackfnt>&nbsp;<%=option3det%></font></div></td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td  width="205" > <font class=blackfnt >MR 
                                      Type </font></div> </td>
                                    <td  width="343" align="center"> <div align="left"><font class=blackfnt>&nbsp;<%=MRTypedesc%></font></div></td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td > <font class=blackfnt>MR RO</font> </td>
                                    <td align="center"> <div align="left"><font class=blackfnt> 
                                        &nbsp;<%=billat_RO%> 
                                        <% if billat_RO <>"All" then %>
                                        : <%=getlocation(billat_RO)%> 
                                        <%end if%>
                                        </font></div></td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td  width="205" > <font class=blackfnt>MR 
                                      Branch</font> </div> </td>
                                    <td  width="343" align="center"> <div align="left"><font class=blackfnt> 
                                        &nbsp;<%=billat%> 
                                        <% if billat <>"All" then %>
                                        : <%=getlocation(billat)%> 
                                        <%end if%>
                                        </font></div></td>
                                  </tr>
                                  <!-- <tr bgcolor="#FFFFFF"> 
                                    <td  width="205" > <font class=blackfnt>Booking 
                                      At</font> </div> </td>
                                    <td  width="343" align="center"> <div align="left"><font class=blackfnt>&nbsp;<%=optionSdet%></font></div></td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td  width="205" > <font class=blackfnt>Delivery 
                                      At</font> </div> </td>
                                    <td  width="343" align="center"> <div align="left"><font class=blackfnt>&nbsp;<%=option2det%></font></div></td>
                                  </tr> -->
                                  <tr bgcolor="#FFFFFF"> 
                                    <td  width="205" > <font class=blackfnt >Status 
                                      </font></div> </td>
                                    <%if MRStatus ="N" then 
		msg="MR - Generated" 
		elseif MRStatus ="Y" then 
		msg="MR - Closed" 
		elseif MRStatus ="C" then 
		msg="Cancelled MR" 
		else 
		msg="All" 
		end if%>
                                    <td  width="343" align="center"> <div align="left"><font class=blackfnt>&nbsp;<%=msg%></font></div></td>
                                  </tr>
                                  <!--<tr bgcolor="#FFFFFF"> 
        <td  width="205" > 
          <font class=blackfnt >Over Due Days </font></div>
        </td>
        <td  width="343" align="center"> 
          <div align="left"><font class=blackfnt>&nbsp;<%=oddaysDesc%></font></div>
        </td>
      </tr>-->
                                  <tr bgcolor="#FFFFFF"> 
                                    <td  width="205" > <font class=blackfnt >Amount 
                                      Greater Than </font></div> </td>
                                    <td  width="343" align="center"> <div align="left"><font class=blackfnt>&nbsp;<%=amtDesc%></font></div></td>
                                  </tr>
                                  <% if MRStatus<>"N" or MRStatus<>"C"  then%>
                                  <% if MRcash="-" or MRcash="" then
								  msg1="Both"
								  elseif MRcash="cash" then
								  msg1="Cash"
								  elseif MRcash="cheque" then
								  msg1="Cheque"
								  else   msg1="All"
								  end if %>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td > <font class=blackfnt >Cash/Cheque</font> 
                                    </td>
                                    <td align="center"> <div align="left"><font class=blackfnt>&nbsp;<%=msg1%></font></div></td>
                                  </tr>
                                  <tr bgcolor="#FFFFFF"> 
                                    <td > <font class=blackfnt >Date Type</font> 
                                    </td><% if date_mr ="mrsdt" then
									msg3 = "Generation Date " 
									else 
									msg3="Closing Date"
									end if%> 
                                    <td align="center"> <div align="left"><font class=blackfnt>&nbsp;<%=msg3%></font></div></td>
                                  </tr>
                                  <%end if%>
                                </center>
                              </table>
  <br>
<%'Response.End %>
  <table border=0 cellspacing=1 cellpadding=4 width=100% align=center class=boxbg>
		<tr class="bgbluegrey"> 
          <td colspan=4 align=center><font class=blackfnt><b>
           MR List</b> <% if CBOsvctax="1" then
		   response.write "With SVCTAX+Cess"
		   elseif CBOsvctax="2" then
		   response.write "W/O SVCTAX+Cess"
		   end if 
		    %>
          </td>
        </tr>
        </table>
        <br>
                              <table BORDER =0 WIDTH="98%" align=center BGCOLOR="#808080" cellspacing="1" cellpadding=2 class=boxbg>
                                <tr class="bgbluegrey"> 
                                  <td ALIGN=middle><font class=blackfnt>Sr. No.</font></td>
                                  <td > <center>
                                      <font class=blackfnt><font class=blackfnt>MR 
                                      Number</font> </font> </center></td>
                                  <td  > <center>
                                      <font class=blackfnt><font class=blackfnt>Docket 
                                      No.</font> </font> </center></td>
                                  <td> <center>
                                      <font class=blackfnt><font class=blackfnt>MR 
                                      Type</font> </font> </center></td>
                                  <td > <center>
                                      <font class=blackfnt><font class=blackfnt>MR 
                                      Date</font></font> </center></td>
                                  <td> <center>
                                      <font class=blackfnt><font class=blackfnt>MR 
                                      Party</font> </font> </center></td>
                                  <td > <center>
                                      <font class=blackfnt><font class=blackfnt>MR 
                                      Branch </font> </font> </center></td>
                                  <!--<td > <center>
                                      <font class=blackfnt><font class=blackfnt>Booking 
                                      At </font> </font> </center></td>
                                  <td > <center>
                                      <font class=blackfnt><font class=blackfnt>Delivery 
                                      At</font> </font> </center></td>-->
                                  <td  > <center>
                                      <font class=blackfnt><font class=blackfnt>Payment 
                                      Mode</font> </font> </center></td>
                                  <td  nowrap > <center>
                                      <font class=blackfnt><font class=blackfnt>&nbsp;&nbsp;&nbsp;&nbsp;Cheque 
                                      No./Date&nbsp;&nbsp;&nbsp;&nbsp;</font> 
                                      </font> </center></td>
                                  <td  > <center>
                                      <font class=blackfnt><font class=blackfnt>Cheque 
                                      Amt.</font> </font> </center></td>
                                  <td  > <center>
                                      <font class=blackfnt><font class=blackfnt>MR 
                                      Status</font> </font> </center></td>
                                  <td > <center>
                                      <font class=blackfnt>Amount </font> </center></td>
                                  <td  > <center>
                                      <font class=blackfnt><font class=blackfnt>Close 
                                      Amount</font> </font> </center></td>
                                  <td > <center>
                                      <font class=blackfnt>MR Close Date </font> 
                                    </center></td>
                                  <td > <center>
                                      <font class=blackfnt>TDS</font> </center></td>
                                  <td ><font class=blackfnt>Frsight Rrebate</font> 
                                  </td>
                                  <td ><font class=blackfnt>Claim</font></td>
                                  
                                  <td ><font class=blackfnt>Adj</font></td>
								  <td ><font class=blackfnt>Other Deduction</font></td>
                                  <td > <center>
                                      <font class=blackfnt>Addition</font> </center></td>
                                  <td > <center>
                                      <font class=blackfnt>Remark</font> </center></td>
									   <td > <center>
                                      <font class=blackfnt>MR Close  By </font> 
                                    </center></td>
                                  <td > <center>
                                      <font class=blackfnt>Bill Cancelled  By </font> 
                                    </center></td>
                                </tr>
                                <%if RecFlag="Y" then
						ctr=1
						
						ctr=(pgsize*(currentpage-1))+1
						Do while not myrec.eof  and rowcount < myrec.pageSize
						 	
					'MRSNo=myrec("MRSNo")
					MRSNo=myrec("MRSNo")
					
					MRSDT=mydate(myrec("MRSDT"))
					MRSTYPE=myrec("MRSTYPE")
					MRSBR=myrec("MRSBR")
					MRBRNNM=myrec("MRBRNNM")
					PTCD=myrec("PTCD")
					PTNAME=myrec("PTNAME")
					ORGNCD=myrec("ORGNCD")
					DOCBKNM=myrec("DOCBKNM")
					DESTCD=myrec("DESTCD")
					DOCDLNM=myrec("DOCDLNM")
					MRSAMT=myrec("MRSAMT")
					Dockno=myrec("Dockno")					
					MRS_Close=myrec("MRS_CLOSED")
									
					Paymode=myrec("Paymode")
					finclosedt=mydate(myrec("finclosedt"))
					
					
					sql_det="select  sum(TDSDED)as TDSDED,sum(FRTDED) as FRTDED,sum(CLMDED) as CLMDED,sum(unexpded) as unexpded from WEBX_MRDET_BILL with(NOLOCK) where mrsno='"&MRSNo&"'"
					'response.write "<br> sql_det : "&sql_det
					
					set rs2=con.execute(sql_det)
					
					if not rs2.eof then
					DEDUCTION=rs2("TDSDED")
					DEDUCTION1=rs2("FRTDED")
					DEDUCTION2=rs2("CLMDED")
					DEDUCTION3=rs2("unexpded")
					else 
					DEDUCTION=0
					DEDUCTION1=0
					DEDUCTION2=0
					DEDUCTION3=0
					end if
					rs2.close
					
					
					if MRSTYPE<>"p02" then
					other_deduction1=myrec("deduction")
					if isnull(other_deduction1) then 
 					other_deduction1=0
				end if
					DEDUCTION=myrec("ded_tds")
 				if isnull(DEDUCTION) then 
 					DEDUCTION=0
				end if
				other_deduction=cdbl(other_deduction1)-cdbl(DEDUCTION)
					else 
					other_deduction="0"
					end if
					miscchrg=myrec("miscchrg")
					MRS_cancel=myrec("MR_CANCEL")
					chq_amt=myrec("chq_amt")
					'Closeamt=myrec("NETAMT")
					Chequeno=getChequeno(MRSNo)
					remark=myrec("remark")
					
					
					finclose_empcd=myrec("finclose_empcd") & " : " &GetEmpName(myrec("finclose_empcd"))
					BCANEMPCD=myrec("BCANEMPCD") & " : " &GetEmpName(myrec("BCANEMPCD"))
					'response.write( "<br>Chequeno :"&Chequeno )
					
					if Paymode ="cash" or Paymode ="Cheque"  then 
						Closeamount=myrec("NETAMT")
					else 
						Closeamount=myrec("Closeamt")
					end if
					
						if isnull(MRSAMT) then
				 		MRSAMT=0												
				 	end if
					if isnull(Closeamount) then
				 		Closeamount=0
												
				 	end if
					if isnull(DEDUCTION) then
				 		DEDUCTION=0
												
				 	end if
					
					if isnull(DEDUCTION1) then
				 		DEDUCTION1=0
												
				 	end if
					if isnull(DEDUCTION2) then
				 		DEDUCTION2=0
												
				 	end if
					if isnull(DEDUCTION3) then
				 		DEDUCTION3=0
												
				 	end if
					if isnull(miscchrg) then
				 		miscchrg=0
												
				 	end if
				 	
				 	
				 	
				 '	MRSAMT=formatNumber(MRSAMT,2,,,false)
				 '	Response.Write "MRSAMT :" & MRSAMT	
				 
				 		Total_close=cdbl(Total_close )+ cdbl(Closeamount)
				 	
				 	totMRamt_recvd=cdbl(totMRamt_recvd )+ cdbl(MRSAMT)
					tot_DEDUCTION=tot_DEDUCTION +cdbl(DEDUCTION)
					tot_DEDUCTION1=tot_DEDUCTION1 +cdbl(DEDUCTION1)
					tot_DEDUCTION2=tot_DEDUCTION2 +cdbl(DEDUCTION2)
					tot_DEDUCTION3=tot_DEDUCTION3 +cdbl(DEDUCTION3)
					tot_miscchrg=tot_miscchrg+cdbl(miscchrg)
						tot_other_deduction=tot_other_deduction+cdbl(other_deduction)
					'response.write("<br>MRSNo-->" &MRSNo )
					'response.end
						%>
                                <tr bgcolor="#FFFFFF"> 
                                  <td ALIGN=middle nowrap><font class=blackfnt><%=ctr%></font></td>
                                  <td > <center><font class=blackfnt><font class=blackfnt><a href="Javascript:ViewPrint('<%=MRSNO%>','0','<%=MRSTYPE%>')"> 
                                  <font class=blklnkund><%=MRSNO%></font></a> 
                                  <td  > <center>
                                      <font class=blackfnt><%=Dockno%> </font> 
                                    </center></td>
                                  <td  nowrap> <center>
                                      <font class=blackfnt><%=GetPayMode_MR(MRSTYPE)%></font> 
                                    </center></td>
                                  <td nowrap> <center>
                                      <font class=blackfnt><%=MRSDT%> </font> 
                                    </center></td>
                                  <td  > <center>
                                      <font class=blackfnt><%=PTCD%> : <%=PTNAME%> 
                                      </font> </center></td>
                                  <td > <center>
                                      <font class=blackfnt><%=MRSBR%> </font> 
                                    </center></td>
                                  <!--<td nowrap> <center>
                                      <font class=blackfnt><%=ORGNCD%> </font> 
                                    </center></td>
                                  <td nowrap> <center>
                                      <font class=blackfnt><%=DESTCD%> </font> 
                                    </center></td>-->
                                  <td  > <center>
                                      <font class=blackfnt><%=Paymode%> </font> 
                                    </center></td>
                                  <td  ><div align="center"><font class=blackfnt><%=Chequeno%></font></div></td>
                                  <td  ><div align="center"><font class=blackfnt><%=chq_amt%></font></div></td>
                                  <%
								'  response.write "<br> MRS_cancel : " &MRS_cancel
								   if MRS_Close="N" and MRS_cancel="N" then
															mr_st1="MR - Generated "
														elseif MRS_Close="Y" and MRS_cancel="N" then
															mr_st1="MR - Close "
															end if
														if  MRS_cancel="Y" then
															mr_st1="Cancelled MR"
														end if
															'response.write "<br> mr_st : " &mr_st1%>
                                  <td  nowrap><div align="center"><font class=blackfnt><%=mr_st1%></font></div></td>
                                  <td > <center>
                                      <font class=blackfnt><%=MRSAMT%> </font> 
                                    </center></td>
                                  <td  > <center>
                                      <font class=blackfnt><%=Closeamount%> </font> 
                                    </center></td>
                                  <td   nowrap><div align="center"><font class=blackfnt><%=finclosedt%></font></div></td>
                                 
                                  <td  ><div align="center"><font class=blackfnt><%=DEDUCTION%></font></div></td>
                                  <td  ><div align="center"><font class=blackfnt><%=DEDUCTION1%></font></div></td>
                                  <td  ><div align="center"><font class=blackfnt><%=DEDUCTION2%></font></div></td>
                                  <td  ><div align="center"><font class=blackfnt><%=DEDUCTION3%></font></div></td>
								   <td  ><font class=blackfnt><%=other_deduction%></font></div></td>
                                  <td  ><div align="center"><font class=blackfnt><%=miscchrg%></font></div></td>
                                  <td  ><div align="center"><font class=blackfnt><%=remark%></font></div></td>
								   <td  ><div align="center"><font class=blackfnt><%=finclose_empcd%></font></div></td>
                                  <td  ><div align="center"><font class=blackfnt><%=BCANEMPCD%></font></div></td>
                                </tr>
                                <% 
							 MRS_cancel="N"
						mr_st1=""
							ctr=ctr+1
							myrec.MoveNext						
							rowcount=rowcount+1%>
                                <%loop
						 end if%>
                                <tr bgcolor="#FFFFFF"> 
                                  <td colspan=13 align=right> <font class=blackfnt><b>Total 
                                    </b> </font> </td>
                                  <td > <center>
                                      <font class=blackfnt><b><%=formatNumber(totMRamt_recvd,2,,,false)%></b></font> 
                                    </center></td>
                                  <td ><div align="center"><font class=blackfnt><b><%=formatNumber(Total_close,2,,,false)%></b></font></div></td>
                                  <td >&nbsp;</td>
                                  <td ><div align="center"><font class=blackfnt><strong><%=tot_DEDUCTION%></strong></font></div></td>
                                  <td ><div align="center"><font class=blackfnt><strong><%=tot_DEDUCTION1%></strong></font></div></td>
                                  <td ><div align="center"><font class=blackfnt><strong><%=tot_DEDUCTION2%></strong></font></div></td>
                                  
                                  <td ><div align="center"><font class=blackfnt><strong><%=tot_DEDUCTION3%></strong></font></div></td>
                                 <td ><font class=blackfnt><strong><%=tot_other_deduction%></strong></font></td>
								  <td ><div align="center"><font class=blackfnt><strong><%=tot_miscchrg%></strong></font></div></td>
                                  <td >&nbsp;</td>
                                </tr>
                              </table>
                              </center>
		
			</td>
		 </tr>
					</table>
  <br>
  <br>
                        <table border=0 align="center" cellpadding=0 cellspacing=4 %>
                          <tr><%if cint(currentPage) >1 and cint(currentPage) <= myrec.PageCount then%>
				<td><a href='javascript:goPage(<%=currentPage-1%>)' style='text-decoration:none'><img src="../../images/prev.gif" border=0></a></td>
			<%end if%>				
			<%if myrec.PageCount>1 then%> 
			<td><div align="center"><font class=blackfnt>Page :</font> 
				<select name="cboPgNo" size="1" onClick="saveCurrentIdx()" onChange="goToPage()">
					<%	for i=1 to myrec.PageCount
						if cint(currentPage)=i then %> 
							<option value='<%=i%>' selected><%=i%> <%else%> 
							<option value='<%=i%>'><%=i%> 
					<%	end if
						next %> 
				</select><font class=blackfnt>&nbsp;&nbsp;<b>of</b>&nbsp; <%=myrec.PageCount%></font> 
				</div></td>
   			<%end if%>	
			<%if myrec.PageCount>1 and cint(currentPage) <  myrec.PageCount then%>
				<td><a href='javascript:goPage(<%=currentPage+1%>)' style='text-decoration:none'><img src="../../images/next.gif" border=0></a></td>						
			<%end if%>	
		</tr>
		</table>
                        <br>
  <table width="25%" border="0" cellspacing="1" cellpadding="3" align="center" >
			<tr bgcolor="#ffffff"> 
			 <td > 
			    <center>
			      <font class=blackfnt><font class=blackfnt><input type=button class=btncolor value="  Print  " onclick="faction(1)" id=button3 name=button3></font> </font></font></font> 
			    </center>
			  </td>
			  <td> 
			    <center>
			      <font class=blackfnt><font class=blackfnt><input type=button class=btncolor value="Download  XLS  " id=button1 name=button1 onclick="faction(2)"></font> </font></font></font> 
			    </center>
			  </td>
			  <td> 
			    <center>
			      <font class=blackfnt><font class=blackfnt><input type=button class=btncolor value="  Email " id=button1 name=button2></font> </font></font></font> 
			    </center>
			  </td>
			  </tr>
		</table>	
  <!--<br>
  -->  
<div align="center"> 
  <center>
    

<%end if%>	     
<%'end if%>	     


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
</body>
</html>