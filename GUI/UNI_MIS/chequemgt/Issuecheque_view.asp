<!-- #include file="../../SCargoConn.asp"-->
<!-- #include file="../../acctfn.asp"-->
<%		
function iif(cond,tresult,fresult)
	if cond=true then
			iif=tresult
	else
			iif=fresult
	end if			
end function
ChqNo=replace(Request.QueryString,"%20"," ")
'Response.Write ChqNo
'Response.End 
if instr(1,ChqNo,",")>0 then
	ChqNo_arr=split(ChqNo,",")
	ChqNo=trim(ChqNo_arr(0))
	ChqDt=trim(ChqNo_arr(1))
	PrintYN=trim(ChqNo_arr(2))
	'PrintYN="F"
	'Response.Write " PrintYN :" & PrintYN
	border=0
		    
end if


boxbg="boxbg"			        
bgbluegrey_var="bgbluegrey"
bluefnt="bluefnt"
border=0
	

'chqdate=datadate(Date)
recdloccode=ucase(session("brcd"))

sql="select * from webx_chq_det where chqno='" & chqno & "' and convert(varchar,chqdt,106)=convert(datetime,'" & chqdt & "',106)"
'sql="select OCAGCD,OCAGNM FROM webx_OCTAGMST WHERE (OCAGBR LIKE '%" & session("brcd") & "%')"
'Response.Write " Sql :" & Sql
'Response.end 
set myrs=con.execute(sql)
if not Myrs.eof then
	chqno=myrs.fields("chqno")
	chqdt=mydate(myrs.fields("chqdt"))
	entrydt=mydate(myrs.fields("entrydt"))
	brcd=myrs.fields("brcd")
	brnm=myrs.fields("brnm")
	narration=myrs.fields("comments")
	banknm=myrs.fields("banknm")
	chqamt=formatnumber(myrs.fields("chqamt"),2,,,false)
	ptmsptcd=myrs.fields("ptmsptcd")
	ptmsptnm=myrs.fields("ptmsptnm")
	BANKBRN=myrs.fields("BANKBRN")
	depoflag=myrs.fields("depoflag")
	voucherNo=myrs.fields("voucherNo")
	acccode=myrs.fields("acccode")
	transdate=mydate(myrs.fields("transdate"))
	depoloccode=myrs.fields("depoloccode")
	adjustamt=myrs.fields("adjustamt")
	if isnull(adjustamt) then
		adjustamt=0
	end if
	adjustamt=formatnumber(adjustamt,2,,,false)
	remamt=chqamt-adjustamt
	remamt=formatnumber(remamt,2,,,false)
end if
myrs.close
%>
<html>
<head>
<title>Cheque View/Print</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK title=stylesheet href="../../images/style.css" type=text/css rel=stylesheet>
<script language=javascript>
function ViewPrint(arg1,arg2,arg3,arg4)
{
	window.open("print/ReceiptVoucher_vp.asp?" + arg1 + "," + arg2  ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
}
function faction(printYN)
{
	 document.frm.target="_self"
	 document.frm.printYN.value=printYN
	 document.frm.method="post"
	 document.frm.action="issuecheque_view_xls.asp"
	 if(printYN=="1")
	 {
		document.frm.target="myform"
		var choice=""//outstd_summarystep2_xls.asp"
		var winOpts="scrollbars=yes,resizable=yes,left=25,top=100,width="+730+",height="+400+"";
		confirmWin=window.open(choice,document.frm.target,winOpts);
     }
     document.frm.submit();
}   

</script>
<%if PrintYN="1" then%>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--
function window_onload() 
{
	window.print();
}

//-->
</SCRIPT>
<%else%>
<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript>
<!--
function window_onload() 
{
}
//-->
</SCRIPT>
<%end if%>
</head>
<body bgcolor="#FFFFFF" onload="return window_onload()">
<form name="frm" method="post">
<input type=hidden name=printYN value="">
<input type=hidden name=chqno value="<%=chqno%>">
<input type=hidden name=chqdt value="<%=chqdt%>">


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
<!--       <tr> 
          <td height="30"><A href="../../welcome.asp"><font class=blklnkund><strong>

		  <%=session("Level_Type")%></font></a>
		  
	<font class=blackfnt>&gt; <a href="../finance.asp"><font class=blklnkund><strong>Finance </strong></font></a>

<font class=blackfnt>&gt;  <a href="../cheque_finance.asp"><font class=blklnkund><strong> Cheque management </strong> </font></a><font class=blackfnt>></font><font class=bluefnt><strong>View Issues cheque statement</strong></font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>-->
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>
<!--
        <tr> 
          <td align=right><a href="javascript:window.history.go(-1)" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr>
-->        
   
					  </table>	
					  <br>
					  <tr> 
    <td> 
    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr> 
	<td> 
    <p align=center ><font class=bluefnt><strong><u>Cheque Summary</u></strong></font> </p >
	<table cellSpacing="1" cellPadding="3" border="0" bgcolor="#808080" width="95%"  align="center" class=<%=boxbg%>>
     <tr> 
     
      <td vAlign="top"  bgcolor="#FFFFFF" width="129"><font class=blackfnt>Cheque number</font></td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class=blackfnt ><font class=<%=bluefnt%>><%=chqno%></font>
          </font></div>
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class=blackfnt>Cheque date</font> 
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class=blackfnt>
        <font class=<%=bluefnt%>><%=chqdt%></font></font></td>
    </tr>
     <tr> 
      <td vAlign="top"  bgcolor="#FFFFFF" width="129"><font class=blackfnt>Issue location</font></td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class=blackfnt ><font class=<%=bluefnt%>><%=brcd & " : " & brnm%></font>
          </font></div>
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class=blackfnt>Issue date</font> 
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class=blackfnt>
        <font class=<%=bluefnt%>><%=entrydt%></font></font></td>
    </tr>
    <%if depoflag="Y" then%>
    <!--<tr> 
      <td vAlign="top"  bgcolor="#FFFFFF" width="129"><font class=blackfnt>Deposit Location</font></td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class=blackfnt ><font class=<%=bluefnt%>><%=depoloccode & " : " & getlocation(depoloccode)%></font>
          </font></div>
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class=blackfnt>Deposit date</font> 
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class=blackfnt>
        <font class=<%=bluefnt%>><%=transdate%></font></font></td>
    </tr>-->
    <tr> 
      <td vAlign="top"  bgcolor="#FFFFFF" width="129"><font class=blackfnt>Issue voucher no ##</font></td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="center" > 
        <div align="left"><font class=blackfnt ><a href="Javascript:ViewPrint('<%=voucherNo%>','0')"><font class=<%=bluefnt%>><u><%=voucherNo%></u></font></font>
          </font></div>
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="166"> 
        <p align="left"><font class=blackfnt>Issued from</font> 
      </td>
      <td vAlign="top"  bgcolor="#FFFFFF" align="left" width="222"><font class=blackfnt>
        <font class=<%=bluefnt%>><%=acccode & " : " &  getAccountDesc(acccode)%></font></font></td>
    </tr>
    <%end if%>
    <tr> 
      <td vAlign="top" height="19" bgcolor="#FFFFFF" align="left" width="166"><font class=blackfnt>Cheque Amount </font></td>
      <td vAlign="top" height="19" bgcolor="#FFFFFF" align="left" width="222"><font class=<%=bluefnt%>><%=chqamt%></font>
								
               </td>
      <td vAlign="top" height="21" bgcolor="#FFFFFF" align="left" width="166"><font class=blackfnt>Issued to</font></td>
      <td vAlign="top" height="21" bgcolor="#FFFFFF" align="left" width="222"><font class=blackfnt>
        <font class=<%=bluefnt%>><%=ptmsptcd & "  " & ptmsptnm %></font></font></td>
    </tr>
    <!--<tr> 
     <td vAlign="top" height="21" bgcolor="#FFFFFF" align="left" width="166"><font class=blackfnt>Accounted Amount</font></td>
      <td vAlign="top" height="21" bgcolor="#FFFFFF" align="left" width="222"><font class=blackfnt>
        <font class=<%=bluefnt%>><%=adjustamt%></font></font></td>
        <td vAlign="top" height="19" bgcolor="#FFFFFF" align="left" width="166"><font class=blackfnt></font></td>
      <td vAlign="top" height="19" bgcolor="#FFFFFF" align="left" width="222"></td>
       
    </tr>
    <tr> 
      <td vAlign="top" height="21" bgcolor="#FFFFFF" align="left" width="166"><font class=blackfnt>Accounted Amount</font></td>
      <td vAlign="top" height="21" bgcolor="#FFFFFF" align="left" width="222"><font class=blackfnt>
        <font class=<%=bluefnt%>><%=remamt%></font></font></td>
       <td vAlign="top" height="19" bgcolor="#FFFFFF" align="left" width="166"><font class=blackfnt></font></td>
      <td vAlign="top" height="19" bgcolor="#FFFFFF" align="left" width="222"></td>
       
    </tr>-->
  
  </table>
   <br> <font class=blackfnt>## Click on voucher number to view full details</font><br>

  <table width="25%" border="0" cellspacing="1" cellpadding="3" align="center" >
			<tr bgcolor="#ffffff"> 
			 <td > 
			    <center>
			      <font class=blackfnt><font class=blackfnt><input type=button class=btncolor value="  Print  " onclick="faction(1)" id=button3 name=button3></font> </font></font></font> 
			    </center>
			  </td>
			  <td> 
			    <center>
			      <font class=blackfnt><font class=blackfnt><input type=button class=btncolor value="  XLS  " id=button1 name=button1 onclick="faction(2)"></font> </font></font></font> 
			    </center>
			  </td>
			  <td> 
			    <center>
			      <font class=blackfnt><font class=blackfnt><input type=button class=btncolor value="  Email " id=button1 name=button2></font> </font></font></font> 
			    </center>
			  </td>
			  </tr>
		</table>	
        <!-- #include file="../../functions.asp"-->
  
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
					
</form>
</body>
</html>