<!-- #include file="../../SCargoConn.asp"-->
<!-- #include file="../../functions.asp"-->
<!-- #include file="../../acctfn.asp"-->
<%		
			mBillType = request.form("chkBillType")
			'response.write mbilltype
			function iif(cond,tresult,fresult)
						if cond=true then
								iif=tresult
						else
								iif=fresult
						end if			
			end function
		
		
			dim pod_dt
			dim dely_dt
		
			FromDt=mydate(Request.Form("txtfromdt"))
		   ToDt=mydate(Request.Form("txttodt"))

		
			function PutCheckBox(poddt,delydt,tbbtopay,dockno)
						'PutCheckBox = "-"
						'if Not (isnull(poddt) or isnull(deldt) or tbbtopay="N") or mBillType = "Octroi" or mBillType="Trial TBB" then
						PutCheckBox = "<input type='checkbox' name='chkDoc' value='" & dockno & "'>"
						'end if
			end function
			
			empcd = session("empcd")
			loccode=trim(Request.Form("cbolocation"))
			
			loccodecls=""
			if loccode<>"" then
				loccodecls=" and bbrcd='" & loccode & "'"
			end if
			
		
			Selection=Request.Form("Selection")
	'response.write "<br> Selection : " &Selection
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
			
			party_code=trim(Request.Form("party_code"))
			vendor_code=trim(Request.Form("vendor_code"))
			party_Name=trim(Request.Form("party_Name"))
			
			if party_code <> "" then
				PartyDesc=party_code & " : " & getCustomer(party_code)
			elseif vendor_code <> "" then
				PartyDesc=vendor_code & " : " & GetVendor(vendor_code)
			else
				PartyDesc="All"
			end if
			
			
			
			orgncds=replace(Request.form("cbolocation"),", ",",")
			
			if orgncds ="" then
				branchName="All"
			else
				branchName=orgncds & ":" &  getlocation(orgncds)
			end if	
			
			'if instr(1,orgncds,"All")>0 then
			'	orgncds="All"
			'end if
		
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
			
			PANNO=""
			 DocumentType = Request("cboDocumentType")
			' response.write"<br>DocumentType: "&DocumentType
			'response.write"<br> party_code: "&party_code
			'response.write"<br>vendor_code: "&vendor_code
			
			'if party_code<>"" and DocumentType="R" then
				'sql="select m.*,(select custnm from webx_custHDR with(NOLOCK) where custcd=m.pbov_code) as pbov_name,(select top 1 oppaccount from webx_acctrans_06_07 A with(NOLOCK) where  A.pbov_code=m.pbov_code and A.docno=m.docno and  A.Credit=m.tds ) as Acc_head,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn,A.ACCDESC from vw_TDS m left outer join webx_tds_paydet d on  m.docno=d.billno  LEFT OUTER JOIN webx_acctinfo A ON M.TDSACCCODE=A.ACCCODE    where pbov_code='" & party_code & "'  and convert(varchar,billdate,106) between Convert(datetime,'"& FromDt &"',106) and convert(datetime,'"& ToDt &"',106)" & replace(loccodecls,"bbrcd","loccode") & " order by pbov_type,billdate "	
			'elseif vendor_code<>"" and DocumentType="P"  then
				'sql="select m.*,(select custnm from webx_custHDR with(NOLOCK) where custcd=m.pbov_code) as pbov_name,(select top 1 oppaccount from webx_acctrans_06_07 A with(NOLOCK) where  A.pbov_code=m.pbov_code and A.docno=m.docno and  A.Credit=m.tds ) as Acc_head,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn,A.ACCDESC from vw_TDS m left outer join webx_tds_paydet d on   m.docno=d.billno  LEFT OUTER JOIN webx_acctinfo A ON M.TDSACCCODE=A.ACCCODE   where pbov_code='" & vendor_code & "'  and convert(varchar,billdate,106) between Convert(datetime,'"& FromDt &"',106) and convert(datetime,'"& ToDt &"',106)" & replace(loccodecls,"bbrcd","loccode") & " order by pbov_type,billdate "	
			'elseif party_code=""  and  vendor_code="" then
				 'if DocumentType="R" then
					' sql="select m.*,(select VENDORname from webx_VENDOR_HDR with(NOLOCK) where vendorcode=m.pbov_code) as pbov_name,(select top 1 oppaccount from webx_acctrans_06_07 A with(NOLOCK) where  A.pbov_code=m.pbov_code and A.docno=m.docno and  A.Credit=m.tds ) as Acc_head,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn,A.ACCDESC from vw_TDS m left outer join webx_tds_paydet d on  m.docno=d.billno   LEFT OUTER JOIN webx_acctinfo A ON M.TDSACCCODE=A.ACCCODE  where  pbov_code in (select custcd from webx_custhdr)  and convert(varchar,billdate,106) between Convert(datetime,'"& FromDt &"',106) and convert(datetime,'"& ToDt &"',106)" & replace(loccodecls,"bbrcd","loccode") & " order by pbov_type,billdate "	
				' elseif DocumentType="P" then
				 	' sql="select m.*,(select VENDORname from webx_VENDOR_HDR with(NOLOCK) where vendorcode=m.pbov_code) as pbov_name,(select top 1 oppaccount from webx_acctrans_06_07 A with(NOLOCK) where  A.pbov_code=m.pbov_code and A.docno=m.docno and  A.Credit=m.tds ) as Acc_head,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn,A.ACCDESC from vw_TDS m left outer join webx_tds_paydet d on   m.docno=d.billno  LEFT OUTER JOIN webx_acctinfo A ON M.TDSACCCODE=A.ACCCODE  where pbov_code in (select VENDORCODE from webx_VENDOR_HDR)  and convert(varchar,billdate,106) between Convert(datetime,'"& FromDt &"',106) and convert(datetime,'"& ToDt &"',106)" & replace(loccodecls,"bbrcd","loccode") & " order by pbov_type,billdate "	
		'		end if
			'end if	
			
			if DocumentType="R" then 
				if party_code<>"" then
					sql="select m.*,(case when pbov_code='8888' then pbov_name else  (select custnm from webx_custHDR with(NOLOCK) where custcd=m.pbov_code) end ) as pbov_name,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn,A.ACCDESC as oppaccdesc from vw_TDS m left outer join webx_tds_paydet d on  m.docno=d.billno  LEFT OUTER JOIN webx_acctinfo A ON M.TDSACCCODE=A.ACCCODE    where pbov_code='" & party_code & "'  and convert(varchar,billdate,106) between Convert(datetime,'"& FromDt &"',106) and convert(datetime,'"& ToDt &"',106)" & replace(loccodecls,"bbrcd","loccode") & " order by pbov_type,billdate "	
				else
					if party_Name="" then
						 sql="select m.*,(case when pbov_code='8888' then pbov_name else  (select custnm from webx_custHDR with(NOLOCK) where custcd=m.pbov_code) end ) as pbov_name,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn,A.ACCDESC as oppaccdesc from vw_TDS m left outer join webx_tds_paydet d on  m.docno=d.billno   LEFT OUTER JOIN webx_acctinfo A ON M.TDSACCCODE=A.ACCCODE  where   pbov_type='P'  and convert(varchar,billdate,106) between Convert(datetime,'"& FromDt &"',106) and convert(datetime,'"& ToDt &"',106)" & replace(loccodecls,"bbrcd","loccode") & " order by pbov_type,billdate "	
					else
						 sql="select m.*,(case when pbov_code='8888' then pbov_name else  (select custnm from webx_custHDR with(NOLOCK) where custcd=m.pbov_code) end ) as pbov_name,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn,A.ACCDESC as oppaccdesc from vw_TDS m left outer join webx_tds_paydet d on  m.docno=d.billno   LEFT OUTER JOIN webx_acctinfo A ON M.TDSACCCODE=A.ACCCODE  where pbov_name like '%" & party_Name & "%'  and  pbov_type='P'  and convert(varchar,billdate,106) between Convert(datetime,'"& FromDt &"',106) and convert(datetime,'"& ToDt &"',106)" & replace(loccodecls,"bbrcd","loccode") & " order by pbov_type,billdate "	
					end if
				end if
			elseif DocumentType="P" then 
				if vendor_code<>""  then
									sql="select 'V' AS pbov_type, (case when isnull(m.docno,'') = '' then d.voucherNo  else m.docno end) AS docno, transdate AS billdate, isnull(billamt,credit) as billamt, 0 AS svctax, 0 AS cess,isnull(m.netamt,credit) as netamt, d.brcd AS loccode, isnull(d.credit, 0) AS tds, d.pbov_code AS pbov_code,d.acccode as tdsacccode,d.oppacccode,d.oppaccount  as oppaccdesc ,d.pbov_name AS pbov_Name,d1.transtype,d1.chqno,d1.chqdt,d1.paidamt,d1.bankname,d1.paydt,d1.brcd,d1.bankbrn " & _
										"from  " & _
										" (vw_acctrans_" & yearSuffix & " d with (NOLOCK)  " & _
										" left outer join  vw_tds_vendor_records m  with (NOLOCK) " & _
										" on d.voucherNo=m.docno or d.docno=m.docNo ) left outer join webx_tds_paydet d1 on   m.docno=d1.billno " & _
										" where  d.acccode='CLA0015' and d.credit > 0 and convert(varchar,d.transdate,106) between  Convert(datetime,'"& FromDt &"',106) and convert(datetime,'"& ToDt &"',106) and (d.voucher_cancel='N' or d.voucher_cancel is null) and d.pbov_code='" & vendor_code & "' order by d.transdate"

									'sql="select m.*,(select VENDORname from webx_VENDOR_HDR with(NOLOCK) where vendorcode=m.pbov_code) as pbov_name,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn,A.ACCDESC from vw_TDS m left outer join webx_tds_paydet d on   m.docno=d.billno  LEFT OUTER JOIN webx_acctinfo A ON M.TDSACCCODE=A.ACCCODE   where pbov_code='" & vendor_code & "'  and convert(varchar,billdate,106) between Convert(datetime,'"& FromDt &"',106) and convert(datetime,'"& ToDt &"',106)" & replace(loccodecls,"bbrcd","loccode") & " order by pbov_type,billdate "	
									',(select VENDORname from webx_VENDOR_HDR with(NOLOCK) where vendorcode=m.pbov_code) as pbov_name
									'sql="select m.*,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn from vw_TDS_new m left outer join webx_tds_paydet d on   m.docno=d.billno  where pbov_type='V'  and pbov_code='" & vendor_code & "'  and convert(varchar,billdate,106) between Convert(datetime,'"& FromDt &"',106) and convert(datetime,'"& ToDt &"',106)" & replace(loccodecls,"bbrcd","loccode") & " order by pbov_type,billdate "
				else 
									',(select VENDORname from webx_VENDOR_HDR with(NOLOCK) where vendorcode=m.pbov_code) as pbov_name
									'sql="select m.*,d.transtype,d.chqno,d.chqdt,d.paidamt,d.bankname,d.paydt,d.brcd,d.bankbrn from vw_TDS_new m left outer join webx_tds_paydet d on   m.docno=d.billno  where   pbov_type='V'  and convert(varchar,billdate,106) between Convert(datetime,'"& FromDt &"',106) and convert(datetime,'"& ToDt &"',106)" & replace(loccodecls,"bbrcd","loccode") & " order by pbov_type,billdate "	
									sql="select 'V' AS pbov_type, (case when isnull(m.docno,'') = '' then d.voucherNo  else m.docno end) AS docno, transdate AS billdate, isnull(billamt,credit) as billamt, 0 AS svctax, 0 AS cess,isnull(m.netamt,credit) as netamt, d.brcd AS loccode, isnull(d.credit, 0) AS tds, d.pbov_code AS pbov_code,d.acccode as tdsacccode,d.oppacccode,d.oppaccount  as oppaccdesc ,d.pbov_name AS pbov_Name,d1.transtype,d1.chqno,d1.chqdt,d1.paidamt,d1.bankname,d1.paydt,d1.brcd,d1.bankbrn " & _
										"from  " & _
										" (vw_acctrans_" & yearSuffix & " d with (NOLOCK)  " & _
										" left outer join  vw_tds_vendor_records m  with (NOLOCK) " & _
										" on d.voucherNo=m.docno or d.docno=m.docNo ) left outer join webx_tds_paydet d1 on   m.docno=d1.billno " & _
										" where  d.acccode='CLA0015' and d.credit > 0 and convert(varchar,d.transdate,106) between  Convert(datetime,'"& FromDt &"',106) and convert(datetime,'"& ToDt &"',106) and (d.voucher_cancel='N' or d.voucher_cancel is null) order by d.transdate"

				end if
			end if
			Response.Write "<br>sql:  " &sql
			'Response.End 
			
			 session("loccode")=loccode
			 session("sql")=sql
			 session("DocumentType")=DocumentType
			 session("FromDt")=FromDt
			 session("ToDt")=ToDt
			 session("PartyDesc")=PartyDesc
			 session("mDateRange")=mDateRange
			 session("branchName")=branchName
			
			
			
			
	'Response.Write("<br> sql : " & sql)		
	myrec.open sql,con
	if not myrec.EOF then
	  RecFlag="Y"
	  myrec.AbsolutePage = cint(currentPage)
	end if
	rowCount=0	
	'myrec.Close
		
			'Set MyRs = con.Execute(Sqlmain)
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<LINK title=stylesheet href="../../images/style.css" type=text/css rel=stylesheet>
</head>
<script language=javascript>
<!--
var months = new Array("","January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December");

function saveCurrentIdx()		
		{	//alert(idx);
			idx = document.frm.cboPgNo.selectedIndex;
		}
	
function goToPage()
		{	
			yesNo = confirm("Do U Want to go to this Page?");
			if(yesNo)
			{	
					document.frm.action = "Result.asp?currentPage=" + document.frm.cboPgNo.options[document.frm.cboPgNo.selectedIndex].value;
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
				document.frm.action = "Result.asp?currentPage=" + pg +",";
				document.frm.target = "_self";
				document.frm.submit();
			}	
			
function CheckUnCheck()
{
		if(document.frm.chkDoc.length>1)
		{
				for(i=1;i<document.frm.chkDoc.length;i++)
				{
						document.frm.chkDoc[i].checked=document.frm.chkDoc[0].checked;
				}
		}
}	
function ClearDockets(){
//alert("hi")
			var eligibleDockets = 0;
			eligibleDockets = document.frm.chkDoc.length;
			if((eligibleDockets < 2 )||(isNaN(eligibleDockets))){	
				alert("No Dockets are eligible,\nwhich can be cleared...");
			}
			else
 {
len = document.frm.chkDoc.length; 	
var i=0;
var cout=0;
if(isNaN(len)) 
{
len=0;
}
if(len==0)
{
 if (document.frm.chkDoc.checked !=true) 
 {
 alert("Please check atleast one checkbox");
 }  
 else
 {
}
}
else
{
for(i=0; i<len; i++)
{
  if (document.frm.chkDoc[i].checked ==true) 
    {
     cout = cout + 1 
    }  
}

if (cout >0 )
{
				var server_dt=new Date("<%=date()%>")
	   

				if(document.frm.bgndt.value=="")
				{
				  alert("Please enter the Bill Date")
				  document.frm.bgndt.focus();
				  return ;
				}
				if (ValidateForm(document.frm.bgndt)==false)
				{
					document.frm.bgndt.focus();
					return ;
				}
				var dt =document.frm.bgndt.value
				var dt_dd=dt.substring(0,2)
				var dt_mm=dt.substring(3,5)
				var dt_yy=dt.substring(6,10)
		
				dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
		
				//alert("server_dt : " + server_dt)
				//alert("dt : " + dt)
				if (dt>server_dt)
				{
						alert( "Bill date should not be greater than today's date !!!")
						document.frm.bgndt.focus();
						return ;
				}
		
				if(document.frm.bduedt.value=="")
				{
						alert("Please enter the Bill Due Date")
						document.frm.bduedt.focus();
						return ;
				}
				if (ValidateForm(document.frm.bduedt)==false)
				{
						document.frm.bduedt.focus();
						return ;
				}
				var bduedt1 =document.frm.bduedt.value
				var dt_dd=bduedt1.substring(0,2)
				var dt_mm=bduedt1.substring(3,5)
				var dt_yy=bduedt1.substring(6,10)
		
				bduedt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
				//alert(dt)
				//alert(bduedt)
				if (dt>bduedt)
				{
						alert( "Bill Due date should be greater than Bill date !!!")
						document.frm.bduedt.focus();
						return ;
				}	
				billcolbrcd=document.frm.txtbillcolbrcd.value;
				billsubbrcd=document.frm.txtbillsubbrcd.value;
				csgnname=document.frm.txtcsgnname.value 
				if(csgnname=="")
				{
						alert("Please enter Party")
						document.frm.txtcsgnname.focus();
						return;
				}
				<%
				sql="Select * from Webx_location where activeFlag='Y'"
				set rs=con.execute(sql)
				do while not rs.eof
					if str1="" then
					  str1=rs("loccode")
					else 
					  str1=str1 + "," + rs("loccode")
					end if 
				rs.movenext
				loop
				%>	
				var loccodes= "<%=str1%>"
				if(billsubbrcd=="")
				{
					alert("Please enter Submission Branch")
					document.frm.txtbillsubbrcd.focus();
					return;
				} 
				else if(loccodes.indexOf(billsubbrcd)==-1)
				{
					alert("Invalid Branch !!!")
					document.frm.txtbillsubbrcd.focus();
					return;
				}
				if(billcolbrcd=="")
				{
					alert("Please enter Collection Branch")
					document.frm.txtbillcolbrcd.focus();
					return;
				} 
				else if(loccodes.indexOf(billcolbrcd)==-1)
				{
					alert("Invalid Branch !!!")
					document.frm.txtbillcolbrcd.focus();
					return;
				}
				
				//return;
				document.frm.action = "genBillDone_submit.asp"  
				document.frm.method = "post"
				document.frm.submit()   
}
else 
{
 alert("Please check atleast one checkbox");
}
}
}
}

function fdocket()
{
	document.frm.method="post";
	document.frm.action="AreaBillGenerate_confirm.asp";
    document.frm.submit();
}
function fsubmit(str,str1)
	{
		 //alert("Hi")
		 var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400;
		 confirmWin=window.open("../../../operations/dockets/docket_popup.asp?0," + str + "," + str1,"",winOpts);
	
	}

	
function editdocket(str1)
{
		document.frm.target="myform"
		//document.frm.action="../../../operations/dockets/docket.asp?"+ str1
		document.frm.action="../../../operations/dockets/Financial_Dockets/docket_financial_info.asp?"+ str1
		var choice="../../../operations/dockets/docket.asp?"+ str1
		var winOpts="scrollbars=yes,resizable=yes,left=25,top=100,width="+730+",height="+400+"";
		confirmWin=window.open(choice,document.frm.target,winOpts);
		document.frm.submit();
     
}
function ValidateForm(obj){
	if (isdate(obj.value)==false){
		obj.focus()
		return false
	}
    return true
 }
 
 function fprint(str)
 { 
  var winOpts="scrollbars=yes,resizable=yes,width="+730+",height="+400+",left="+25+",top="+100+"";
  confirmWin=window.open("tds_xls.asp?" + str,"",winOpts);
 }
//-->
</script>
<body bgcolor="#FFFFFF">
<form name="frm" method="post">

<input type=hidden name=currentpage1 value="<%=currentPage%>">
<input type=hidden name=currentpage value="<%=Request.Form("currentpage")%>">

<input type=hidden name=party_Name value="<%=party_Name%>">
<input type=hidden name=party_code value="<%=party_code%>">
<input type=hidden name=vendor_code value="<%=vendor_code%>">
<input type=hidden name=txttodt value="<%=ToDt1%>">
<input type=hidden name=txtfromdt value="<%=FromDt1%>">
<input name=cbolocation type=hidden value="<%=Request.Form("cbolocation")%>">
<input name=cboDocumentType type=hidden value="<%=Request.Form("cboDocumentType")%>">
<input type=hidden name=Selection value="<%=Request.Form("Selection")%>">

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
         <tr> 
          <td height="30"><a href="../../../welcome.asp"><font class=blklnkund><strong><%=session("Level_Type")%> Module</strong></font></a><strong> &gt; </strong>
            <a href="../../../MIS_new/reportmenu.asp"><font class=blklnkund><strong>Reports</strong></font></a>
            <strong> &gt; </strong>

			<a href="../../../MIS_new/rpt_finance.asp"><font class=blklnkund><strong>Finance & Accounts</strong></font></a>
            <strong> &gt; </strong>
			<font class=bluefnt><strong>TDS Statement</strong> </font></td>
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
					  
  <p align="center"><font class=blackfnt><b>You Selected<br>
    </b></font></p>
                      <table border=0 cellpadding=3  width="565" bgcolor="#808080" cellspacing="1"  align="center" class=boxbg>
                         <tr bgcolor="#FFFFFF"> 
                          <td   valign="top"> <font class=blackfnt>Party</font> </td>
                          <td  > <table border=0 width=100% cellspacing=0 cellpadding=0>
                              <tr bgcolor="#FFFFFF"> 
                                <td   colspan="2"> <font class=blackfnt><%=PartyDesc%> </font> </td>
                              </tr>
                            </table></td>
                        </tr>
                        <tr bgcolor="#FFFFFF"> 
                          <td  > <font class=blackfnt>Date 
                            Range</font> </td>
                          <td   valign="middle"> <font class=blackfnt><%=mDateRange%></font> 
                          </td>
                        </tr>
                        <tr> 
                          <td vAlign="middle" bgcolor="#FFFFFF" > 
                            <p align="left"><font class=blackfnt>Branch Name</font>
                          </td>
                          <td vAlign="middle" bgcolor="#FFFFFF" align="left"><font class=blackfnt><%=branchName%></font></td>
                        </tr>
                      </table>
                 	<%if RecFlag="Y" then%>     
					  <br>
                      <p align="center"><font class=blackfnt><b> </b></font></p>
<div align="center"> 
    </div>
                      <div align="center"> 

                        <center>
                          <p><font class=blackfnt><b><!--TDS on Contract for the Month of Oct 2005 - Non Corporate-->TDS Statement 													
</b></font> 
                            <br>
                          </p>
                          <table border=0 cellpadding=3  width="80%" bgcolor="#808080" cellspacing="1"  align="center" class=boxbg>
                           
                            <tr> 
                              <td  align="center"  bgcolor="#FFFFFF" width=10%> 
                                <p align="left"><font class=blackfnt>Party Name 
                                  
                                  </font> </td>
                              <td   bgcolor="#FFFFFF" width=30%><font class=blackfnt><%=PartyDesc%></font></td>
                             <%if vendor_code <> "" then%>
                              <td   bgcolor="#FFFFFF" width=15%><font class=blackfnt> 
                                Pan No  </font> </td>
                              <td  vAlign="top" bgcolor="#FFFFFF" width=15%><font class=blackfnt><%=PANNO%>
                                </font></td>
                             <%end if%>   
                              <!--<td width="203" align="center" vAlign="top" bgcolor="#FFFFFF"><font class=blackfnt>TDS 
                                Rate:
                                </font></td>
                              <td width="340" height="44" align="center" vAlign="top" bgcolor="#FFFFFF"><font class=blackfnt>2.00%
                                </font></td>-->
                            </tr>
                          </table>
                          <p>
                           
                          </p>
                          
                        <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" bgcolor="#808080" class=boxbg>
                          <tr class="bgbluegrey"> 
                            <td    > <font class=blackfnt>Sr No </font> </center></td>
                            <td  > <font class=blackfnt>Entry No </font> </center></td>
                            <td    > <font class=blackfnt>Entry Date Date </font> </center> 
                            </td>
                            <td   > <font class=blackfnt> Amount </font> </center></td>
                            <td   > <font class=blackfnt> Account Head </font> </td>
                            <td   > <font class=blackfnt>Party</font> </td>
                            <!--<td  width="52"  > 
            
              <font class=blackfnt></font> 
            </center>
          </td>-->
                            <td   > <font class=blackfnt>Tds 
                            <%if DocumentType="P" then%>
                            Payable
                            <%else%>
                            Receivable 
                            <%end if%> </font> </center></td>
                            <td > <font class=blackfnt>Surcharge</font> </center> 
                            </td>
                            <td   > <font class=blackfnt>Education Cess </font> </center> 
                            </td>
                            <td   > <font class=blackfnt>Total <%if DocumentType="P" then%>
                            Payable
                            <%else%>
                            Receivable 
                            <%end if%> </font> </center> 
                            </td>
                            <td   > <font class=blackfnt>Mode of Payment </font> </center> 
                            </td>
                            <td  > <font class=blackfnt>Cheque No </font> </center></td>
                            <td  > <font class=blackfnt>Cheque Date </font> </center></td>
                            <td  > <font class=blackfnt>Amount Paid </font> </center></td>
                            <td  > <font class=blackfnt>TDS paid Bank Name </font> </center> 
                            </td>
                            <td  > <font class=blackfnt>Bank Branch </font> </center></td>
                            <td  ><font class=blackfnt>Payment Date </font> </center></td>
                          </tr>
                          <%if RecFlag="Y" then
							
					
			 ctr=1
			totTDS=0
			totNetpayable=0
			totpaidamt=0
						ctr=(pgsize*(currentpage-1))+1
						Do while not myrec.eof  and rowcount < myrec.pageSize
									    ' cnt = cnt + 1
										billno=myrec("docno")
										 BGNDT=mydate(myrec("billdate"))
										' BGNDT=myrec("docno")
										 BILLAMT=myrec("billamt")
										
										 svrcamt=myrec("svctax")
										 cessamt=myrec("cess")
										 Netpayable =myrec("netamt")
										  if isnull(Netpayable) then
											Netpayable=0
										 end if
										 loccode =myrec("docno")
										 TDS =myrec("tds")
										 
										 transtype=myrec("transtype")
										 chqno=myrec("chqno")
										 chqdt=mydate(myrec("chqdt"))
										 paidamt=myrec("paidamt")
										 pbov_code=myrec("pbov_code")
										 pbov_name=myrec("pbov_name")
										' Acc_head=myrec("Acc_head")
										 Acc_head=myrec("Oppaccdesc")
										 if isnull(paidamt) then
											paidamt=0
										 end if
										 paidamt=formatnumber(paidamt,2,,,false)
										 bankname=myrec("bankname")
										 paydt=myrec("paydt")
										 brcd=myrec("brcd")
										 bankbranch=myrec("bankbrn")
										 
										 if isnull(svrcamt) then
											svrcamt=0
										 end if 
										 
										 if isnull(BILLAMT) then
											BILLAMT=0
										 end if 
										 
										 if isnull(cessamt) then
											cessamt=0
										 end if 
										 
										 if isnull(TDS) then
											TDS=0
										 end if
										 
										 
										 Netpayable =cdbl(BILLAMT)+cdbl(cessamt)+cdbl(svrcamt)-cdbl(TDS)
										 totpaidamt=cdbl(totpaidamt)+cdbl(paidamt)
										 totsvrcamt=totsvrcamt+cdbl(svrcamt)
										 totcessamt=totcessamt+cdbl(cessamt)
										 totNetpayable=totNetpayable+cdbl(Netpayable)
										 totbillamt=totbillamt+cdbl(BILLAMT)
										 totTDS=totTDS+cdbl(TDS)
										 %>
                          <tr  bgcolor="#FFFFFF"> 
                            <td  align="center" valign="middle" > <font class=blackfnt><%=ctr%></font> </center> 
                            </td>
                            <td  align="center" > <font class=blackfnt><%=billno%> 
                              </font> </center></td>
                            <td  align="center" nowrap> <font class=blackfnt><%=mydate(BGNDT)%> 
                              </font> </center></td>
                            <td  align="right" nowrap > <font class=blackfnt> <%=formatnumber(BILLAMT,2,,,false)%> 
                              </font> </center></td>
                            <td  align="right" nowrap > <div align="center"><font class=blackfnt> 
                                <%=Acc_head%> </font> </div></td>
                            <td  align="right"  nowrap> <div align="center"><font class=blackfnt><%=pbov_code%> 
                                : <%=pbov_name%> </font> </div></td>
                            <td  align="right" > <font class=blackfnt> <%=formatnumber(TDS,2,,,false)%> 
                              </font> </center></td>
                            <td  align="right" > <font class=blackfnt><%=formatnumber(svrcamt,2,,,false)%> 
                              </font> </center></td>
                            <td  align="right" > <font class=blackfnt><%=formatnumber(cessamt,2,,,false)%> 
                              </font> </center></td>
                            <td  align="right"  > <font class=blackfnt><%=formatnumber(Netpayable,2,,,false)%> 
                              </font> </center></td>
                            <td  > <font class=blackfnt><%=transtype%></font> </center> 
                            </td>
                            <td  ><font class=blackfnt><%=chqno%></font> </center></td>
                            <td nowrap><font class=blackfnt><%=chqDt%></font> </center> 
                            </td>
                            <td > <font class=blackfnt><%=paidAmt%> </font> </center></td>
                            <td ><font class=blackfnt><%=bankname%></font> </center></td>
                            <td > <font class=blackfnt><%=bankbranch%> </font> </center> 
                            </td>
                            <td nowrap><font class=blackfnt><%=paydt%></font> </center> 
                            </td>
                          </tr>
                          <% 
							
						
							ctr=ctr+1
							response.Flush()
							myrec.MoveNext						
							rowcount=rowcount+1%>
                          <%loop
						 end if%>
                          <tr  bgcolor="#FFFFFF"> 
                            <td  colspan="6" ><font class=blackfnt><b>Total </font></td>
                            <td align=right> <font class=blackfnt><b><%=formatnumber(totTDS,2,,,false)%> 
                              </font></center></td>
                            <td > </center></td>
                            <td > </center></td>
                            <td align=right> <font class=blackfnt><b><%=formatnumber(totNetpayable,2,,,false)%> 
                              </font> </center></td>
                            <td >&nbsp;</td>
                            <td >&nbsp;</td>
                            <td >&nbsp;</td>
                            <td ><font class=blackfnt><b><%=formatnumber(totpaidamt,2,,,false)%></font> </center> 
                            </td>
                            <td >&nbsp;</td>
                            <td >&nbsp;</td>
                            <td >&nbsp;</td>
                          </tr>
                        </table>
	      
                          <p><font class=blackfnt color="#0000FF"><b></b></font></p>
      
    </center>
</div>

<%else%>
						<br><br><br>
						<Table border=1 cellspacing=0 cellpadding=2 width=70% align=center class=bglightblue>
   					       <TR><TD align=center class="bgbluegrey"><font class=blackfnt color=red><b>Result</b></font></TD></TR>
						  <TR><TD><br>
						   <p align=center><font class=blackfnt >NO Record Found</font><br>
						   <br><font class=blackfnt><a href="javascript:history.go(-1)"><u>Back</u></a></br></p>
						   </TD>
						  </TR>
						 </TABLE>
<%end if%>
<%if RecFlag="Y" then%>
<center>
		<table border=0 cellspacing=4 cellpadding=0 >					
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
		<table BORDER=0 CELLSPACING=2 CELLPADDING=6>
			<tr>
			<td></td>
			<td ><INPUT tabindex=<%=tabind+1%> type=button name="Print" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Print&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" onclick="return fprint(1)" class=btncolor></td>
			<td><INPUT tabindex=<%=tabind+1%> type=button name="Download" value="Download" onclick="return fprint(2)" class=btncolor></td>
			</tr>
		</table>
<%end if%>
					  <!--END-->
					</center>	  </td>
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