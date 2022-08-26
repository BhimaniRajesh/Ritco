<%
dim ControlAccCode,ControlAccDesc 'Ramashish's variable
dim mControlAcccode_str,mControlAccdesc_str
dim operTitle
Dim ServiceTaxRate
dim mHeadOfficeCode
brcd=session("brcd")
set rsDiv=server.CreateObject("adodb.recordset") 


Currmonth=Month(Date)
CurrYear=Year(Date)
select case CurrMonth
case 1,2,3
	YearString=mid(cstr(CurrYear-1),3,2)
	currfinyear=cstr(CurrYear-1)
	finyearstart="01 APR " & YearString
	finyearend="31 MAR " & mid(CurrYear,3,2)
case 4,5,6,7,8,9,10,11,12
	YearString=mid(CurrYear,3,2)
	currfinyear=cstr(CurrYear)
	finyearstart="01 APR " & YearString
	finyearend="31 MAR " & mid(CurrYear+1,3,2)
end select

mHeadOfficeCode="HQTR"
lastfinyearstart=dateadd("yyyy",-6,finyearstart)
yearsuffix=YearString & "_" & string(2-len(clng(YearString)+1),"0") & clng(YearString)+1
ServiceTaxRate = 8
'Response.Write "<br> finyearstart :" & finyearstart
'Response.Write "<br> finyearend :" & finyearend
'Response.Write "<br> currfinyear :" & currfinyear
'Response.Write "<br> fnretYearString :" & fnretYearString
'Response.End 

function getFinyearEnd(strdate)
	Currmonth=Month(strdate)
	CurrYear=Year(strdate)
	select case CurrMonth
	case 1,2,3
		YearString=mid(cstr(CurrYear-1),3,2)
		currfinyear=cstr(CurrYear-1)
		finyearstart="01 APR " & YearString
		finyearend="31 MAR " & mid(CurrYear,3,2)
	case 4,5,6,7,8,9,10,11,12
		YearString=mid(CurrYear,3,2)
		currfinyear=cstr(CurrYear)
		finyearstart="01 APR " & YearString
		finyearend="31 MAR " & mid(CurrYear+1,3,2)
	end select
	getFinyearEnd=finyearend
end function

function getaccount(code)
set rsacc=server.CreateObject("adodb.recordset")
ATableName="webx_ASSETMASTER"
sql = "select assetname from " & ATableName & " where ASSETCD='" & Code & "'"
Set rsacc = con.Execute(sql)
if not rsacc.eof then
     assetname=rsacc.Fields("assetname")
end if 
	rsacc.close()
	getaccount=assetname
End function


Function getAccountDesc(Code)
    set rsGroup=server.CreateObject("adodb.recordset")
    ATableName="webx_acctinfo"
    
    sql = "select accdesc from " & ATableName & " where acccode='" & Code & "'"
    Set rsGroup = con.Execute(sql)
    if not rsGroup.eof then
		accdesc=rsgroup.Fields("accdesc")
	end if 
	rsGroup.close()
	getAccountDesc=accdesc
End function

Function getBankLoc(Code)
    set rsGroup=server.CreateObject("adodb.recordset")
    ATableName="webx_acctinfo"
    
    sql = "select bkloccode from " & ATableName & " where acccode='" & Code & "'"
    Set rsGroup = con.Execute(sql)
    if not rsGroup.eof then
		bkloccode=rsgroup.Fields("bkloccode")
	end if 
	rsGroup.close()
	getBankLoc=bkloccode
End function


function IsNullCheck(checkval)
		if isnull(checkval) then
		   IsNullCheck=""
		else
		   IsNullCheck=checkval
		end if   	   
end function

function getVoucherType(para)
	select case para
	case 1
		getVoucherType="Debit Voucher"'"Payment Voucher"'"Receipt Voucher"'"Receive Money From Company"
	case 2
		getVoucherType="Credit Voucher"'"Receipt Voucher"'Return/Pay Money to Company"
	case 3
		getVoucherType="Asset Related"
	case 4
		getVoucherType="Liability Related"
	case 5
		getVoucherType="Journal Voucher"'"Adjustments(JV)"
	case 6
		getVoucherType="Cash Withdrawals/Deposits"	
	case 7
		getVoucherType="Expense Register"		
   end select 	

end function
'checking for valid numeric value 
function IsNumericCheck(checkval)
		if isnull(checkval) then
			checkval=0
		end if
		if isNumeric(trim(checkval)) then
		   IsNumericCheck = cdbl(checkval)
		else
		   IsNumericCheck = 0
		end if	
end	function


'Response.Write yearsuffix
'Generating group code
function getParentGroup(groupCode)
	getParentGroup=""
	exit function
	TableName="webx_groups"
	set rsGroup=server.CreateObject("adodb.recordset") 
	sql = "select Parentcode from " & TableName & " where groupcode ='" & groupCode & "'" 
    Set rsGroup = con.Execute(sql)
    If Not rsGroup.EOF Then
			'Response.Write "value :" & isnull(rsGroup.Fields(0)) + "<br>"
             ParentCode = rsGroup.Fields(0)
    Else
			 ParentCode = ""
    End If
    rsGroup.close()
    getParentGroup=getGroupName(ParentCode)
end function

function getGroupName(parentGcode)
	TableName="webx_groups"
	set rsGroup=server.CreateObject("adodb.recordset") 
	sql = "select Groupdesc from " & TableName & " where groupcode ='" & parentGcode & "'" 
    Set rsGroup = con.Execute(sql)
    If Not rsGroup.EOF Then
		     getGroupName = rsGroup.Fields(0) & " - "
    Else
			 getGroupName = ""
    End If
    rsGroup.close()    
end function

function genGroupCode(parentGcode,groupDesc) 
	select case ucase(groupdesc)
	
	case "INCOME"
			parentGroup="INC"
	case "EXPENSES","EXPENSE"
			parentGroup="EXP"
	case "ASSET","ASSETS"
			parentGroup="ASS"
	case "LIABILITIES" 
			parentGroup="LIA"
	case else
			parentGroup=mid(parentGcode,1,3)     		
	end select			
	TableName="webx_groups"
	
	set rsGroup=server.CreateObject("adodb.recordset") 
	sql = "select max(right(groupcode,len(groupcode)-3))+1 from " & TableName & " where groupcode like '" & parentGroup & "%'" 
    Set rsGroup = con.Execute(sql)
    
    If IsNull(rsGroup.Fields(0)) Then
        genGroupCode = parentGroup & "001"
    Else
        genGroupCode = parentGroup & string(3-len(rsGroup.Fields(0)),"0") & rsGroup.Fields(0)
    End If
	'Response.Write genGroupCode
end function

'generating account code
Public Function genAccountCode(groupcode)
	GTableName="webx_groups"
	ATableName="webx_acctInfo"
    set rsAccount=server.CreateObject("adodb.recordset") 
    set rsGroup=server.CreateObject("adodb.recordset") 
   
    sql = "select acct_prefix from "& GTableName  & " where groupcode='" & groupcode & "'"
    'Response.Write sql + "<br>"
    Set rsGroup = con.Execute(sql)
    Acctprefix="A"
    If Not rsGroup.EOF Then
		'Response.Write "value :" & isnull(rsGroup.Fields(0)) + "<br>"
        If  IsNull(rsGroup.Fields(0)) or  trim(rsGroup.Fields(0))= ""  Then
            Acctprefix = "A"
        Else
            Acctprefix = trim(rsGroup.Fields(0))
        End If
    Else
			Acctprefix = "A"
    End If
    'Response.Write 
    
    '====ERROR(NEEDS MODIFICATION)
    whrcls= " substring(acccode,1," & len(Acctprefix) &")='" & Acctprefix &"'"
    'whrcls = " groupcode='" & groupcode  & "' and acccode like '" & Acctprefix & "%'"
    
    
    selcls = "Max(Right(acccode, Len(acccode) -" & Len(Acctprefix) & ") + 1)"
    sql = "select " & selcls & " from " & ATableName & " where " & whrcls
    'Response.Write sql
    'Response.End 
    Set rsAccount= Conn_2.Execute(sql)
    If IsNull(rsAccount.Fields(0)) Then
        genAccountCode = Acctprefix & string(7-(len(Acctprefix)+1),"0") & CStr(1) 'Acctprefix + "1"
    Else
        genAccountCode = Acctprefix & string(7-(len(Acctprefix)+len(rsAccount.Fields(0))),"0") & CStr(rsAccount.Fields(0)) 'Acctprefix + CStr(rsAccount.Fields(0))
    End If
    rsAccount.Close 
End Function

'this function is used for getting root group code for a group
function getrootGroup(Code)
    GTableName="webx_groups"
    ATableName="webx_acctinfo"
    set rsGroup=server.CreateObject("adodb.recordset")
    
    sql = "select groupCode,parentCode,Groupdesc from " & GTableName & " where groupcode='" & Code & "'"
    Set rsgroup = Con.Execute(sql)
    if not rsGroup.eof  then
		groupcode=rsgroup.Fields("parentcode")
		groupdesc=rsgroup.Fields("groupdesc")
		if isnull(groupcode) or groupcode="" then
			rootGroupCode=rsgroup.Fields("groupCode")
			rootGroupName=groupdesc
		else
			getrootGroup(groupcode)
		end if
    end if
End function

'this function is used for getting group code for a account
Function getGroup(Code)
    set rsGroup=server.CreateObject("adodb.recordset")
    GTableName="webx_groups"
    ATableName="webx_acctinfo"
    
    sql = "select groupcode from " & ATableName & " where acccode='" & Code & "'"
    Set rsGroup = con.Execute(sql)
    if not rsGroup.eof then
							 groupcode=rsgroup.Fields("groupCode")
							 getrootGroup(groupcode)
    end if 
End function

sub getmonthsBetween(datefrom,dateto)
	datefrom=cdate(datefrom)
	dateto=cdate(dateto)
	lastmonth1=""
	do until datefrom >= dateto
		monthname1=cstr(month(datefrom)) + cstr(year(datefrom))
		if lastmonth1 <> monthname1 or lastmonth1="" then
				Response.Write monthname1 + "<br>"
		end if
		lastmonth1=monthname1
		datefrom=dateadd("d",10,datefrom)
	loop
end sub


'******************************************
''Used for checking account trans for HO to insert & update data
Function IntTrans (brcd,acccode,oppbrcd,oppacccode,transdate,transtyp)
   set rsInt=server.CreateObject("adodb.recordset")
   sqlIntDel="delete  from tbl_inttrans_" & divsuffix & " where  convert(varchar,transdate,106)<convert(datetime,'" & transdate & "',106)"   
   conn_2.execute(sqlIntDel)
   
   sqlInt="select * from tbl_inttrans_" & divsuffix & " where brcd='" & brcd & "' and acccode='" & acccode & "' and oppbrcd='" & oppbrcd &"' and oppacccode='" & oppacccode & "' and  transtyp='" & transtyp & "' and convert(varchar,transdate,106)=convert(datetime,'" & transdate & "',106)"
   set rsInt=conn_2.execute(sqlInt)
   if not rsInt.EOF then
	  rtnval="U"
   else
      rtnval="I"
      sqlIns="Insert into tbl_inttrans_" & divsuffix & " (brcd,acccode,oppbrcd,oppacccode,transdate,transtyp) values ('" & brcd & "','" & acccode & "','" & oppbrcd &"','" & oppacccode & "','" & transdate & "','" & transtyp & "')"
      'Response.Write("<br>sqlIns : " & sqlIns)
      conn_2.execute(sqlIns)
   end if
   IntTrans=rtnval
end function



'******************************************
''Used for adding account for a vendor
Sub AddVendAccount(brcd,vendorcode,mode)
	set rsVendor=server.CreateObject("adodb.recordset")
	set rsAccount=server.CreateObject("adodb.recordset")
	set rsGroup=server.CreateObject("adodb.recordset")
	
	sql="select * from vendmas where vendorcode='" & vendorcode & "' and vendorbrcd='" & brcd & "'"	
    set rsvendor=con.execute(sql)
    
    if not rsvendor.EOF then
		GTableName="tbl_groups_" & divsuffix
		sql="select groupcode from " & GTableName & " where upper(groupdesc) like '%VENDORS%'"
		set rsGroup=con.execute(sql)
		
		if not rsgroup.EOF then
			groupcode=rsgroup.Fields("groupcode")
		else
		    groupCode="LIA001"
		end if	
		
		ContPerson=replace(IsNullCheck(rsvendor.fields("VENDORNAME")),"'","''")
		Address=replace(IsNullCheck(rsvendor.fields("VENDORADDRESS")),"'","''")
		State=""
		City=replace(IsNullCheck(rsvendor.fields("VENDORCITY")),"'","''")
		Pin=IsNullCheck(rsvendor.fields("VENDORPIN"))
		Tel=IsNullCheck(rsvendor.fields("VENDORPHONE"))
		Fax=""
		Email=replace(IsNullCheck(rsvendor.fields("VENDOREMAIL")),"'","''")
		AccCategory="Creditor"
		acccode=rsvendor.fields("acccode")
		if trim(AccCode) = "" or isnull(AccCode) then
		    AccCode=genAccountCode(GroupCode)
		end if 
		AccDesc=replace(IsNullCheck(rsvendor.fields("VENDORNAME")),"'","''")
		secId="null"
		SecDetailId="null"
		PanNo="null"
		'transaction starts here
		conn_2.BeginTrans
		ATableName="tbl_acctinfo_" & divsuffix 
		' Insertion into acctinfo
		if mode=0 then
		sql="Insert into " & ATableName & "(groupcode,acccode,accdesc,acccategory,secid,secdetailid,panno,contperson,address,tel,pin,fax,email,city,state,entryby,brcd) values ('" & groupcode & "','" & acccode & "','" & accdesc & "','" & acccategory & "'," & secid & "," & secdetailid & "," & panno & ",'" & contperson & "','" & address & "','" & tel & "','" & pin & "','" & fax & "','" & email & "','" & city & "','" & state & "','" & session("empcd") & "','" & brcd & "')"
        conn_2.execute(sql)
        
        sql="update vendmas set acccode='" & acccode & "' where vendorcode='" & vendorcode & "' and vendorbrcd='" & brcd & "'"	
        conn_2.execute(sql)
        
        x=getrootGroup(groupcode)
		'Response.Write currbrcd
        if ucase(rootGroupName)=ucase("Income") or ucase(rootGroupName)=ucase("Expenses") then
		else
								'brcd=session("brcd")
								sql="select brcd,BRRGCD,BR_ATTR from brms where brcd='" & brcd & "'"
								set rsBranch=con.execute(sql)
								if not rsBranch.EOF then
												brcd1=trim(rsbranch.Fields("brcd"))
												BRRGCD=rsbranch.Fields("BRRGCD")
												BR_ATTR=rsbranch.Fields("BR_ATTR")
												if BR_Attr = "AO" then
																sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
																sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
												elseif BR_Attr="HO" then
															    sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
															    conn_2.execute(sql)
												else
																sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode  &"',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
																sql="select brcd,BRRGCD,BR_ATTR from brms where BRRGCD='" & BRRGCD & "' and BR_ATTR='AO'"
																set rsBranch1=con.execute(sql)
																if not rsbranch1.eof then
																		brcd1=trim(rsbranch1.fields("brcd"))
																		sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode  &"',0,0,"& currfinyear &",'" & brcd & "')"
																		conn_2.execute(sql)																						
																		sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																		conn_2.execute(sql)
																end if
												end if
								end if
			end if			
		else	
				sql="update " & ATableName & " set groupcode='" & groupcode & "',acccode='" & acccode & "',accdesc='" & accdesc & "',acccategory='" & acccategory & "',secid=" & secid &",secdetailid=" & secdetailid & ",panno=" & panno & ",contperson='" & contperson &"',address='" & address & "',tel='" & tel & "',pin='" & pin & "',fax='" & fax & "',email='" & email & "',city='" & city & "',state='" & state & "',entryby='" & session("empcd") &"',brcd='" & brcd & "' where acccode='" & acccode & "'" 
				'Response.Write sql
				'Response.End 
				conn_2.execute(sql)
		end if
		if Err.number<>0 then
			    conn_2.RollbackTrans
		else
				conn_2.CommitTrans 
		end if 
		conn_2.close
	end if
  
end sub
'******************************************************
'used for adding BA Account in on control and normal
Sub AddBAAccount(brcd,bacd,mode)
		set rsBA=server.CreateObject("adodb.recordset")
		set rsAccount=server.CreateObject("adodb.recordset")
		set rsGroup=server.CreateObject("adodb.recordset")
		set rsGroupOnAc=server.CreateObject("adodb.recordset")
	 sql="select * from bams where bacd='" & bacd & "' and babrcd='" & brcd & "'"	
  set rsBA=con.execute(sql)
    
  if not rsBA.EOF then
  'opening account in Business Associates in sundry creditor
		GTableName="tbl_groups_" & divsuffix
		sql="select groupcode from " & GTableName & " where upper(groupdesc) like '%BUSINESS ASSOCIATES%'"
		set rsGroup=con.execute(sql)
		
		if not rsgroup.EOF then
						groupcode=rsgroup.Fields("groupcode")
		else
		    groupCode="LIA0001"
		end if	
		
		ContPerson=replace(IsNullCheck(rsBA.fields("banm")),"'","''")
		Address=replace(IsNullCheck(rsBA.fields("baaddress")),"'","''")
		State=""
		City=replace(IsNullCheck(rsBA.fields("bacity")),"'","''")
		Pin=IsNullCheck(rsBA.fields("bapin"))
		Tel=IsNullCheck(rsBA.fields("batels"))
		Fax=""
		Email=replace(IsNullCheck(rsBA.fields("baemail")),"'","''")
		AccCategory="Creditor"
		acccode=rsBA.fields("acccode")
		if trim(AccCode) = "" or isnull(AccCode) then
		    AccCode=genAccountCode(GroupCode)
		end if 
		acccodeOnAc=rsBA.fields("acccodeOnAc")
		
		AccDesc=replace(IsNullCheck(rsBA.fields("banm")),"'","''")
		secId="null"
		SecDetailId="null"
		PanNo="null"
		'transaction starts here
		conn_2.BeginTrans
		ATableName="tbl_acctinfo_" & divsuffix 
		' Insertion into acctinfo
	if mode=0 then
								sql="Insert into " & ATableName & "(groupcode,acccode,accdesc,acccategory,secid,secdetailid,panno,contperson,address,tel,pin,fax,email,city,state,entryby,brcd) values ('" & groupcode & "','" & acccode & "','" & accdesc & "','" & acccategory & "'," & secid & "," & secdetailid & "," & panno & ",'" & contperson & "','" & address & "','" & tel & "','" & pin & "','" & fax & "','" & email & "','" & city & "','" & state & "','" & session("empcd") & "','" & brcd & "')"
        conn_2.execute(sql)
        
        sql="update bams set acccode='" & acccode & "' where bacd='" & bacd & "' and babrcd='" & brcd & "'"	
        conn_2.execute(sql)
               
        x=getrootGroup(groupcode)
		'Response.Write currbrcd
     if ucase(rootGroupName)=ucase("Income") or ucase(rootGroupName)=ucase("Expenses") then
					else
								'brcd=session("brcd")
								sql="select brcd,BRRGCD,BR_ATTR from brms where brcd='" & brcd & "'"
								set rsBranch=con.execute(sql)
								if not rsBranch.EOF then
												brcd1=trim(rsbranch.Fields("brcd"))
												BRRGCD=rsbranch.Fields("BRRGCD")
												BR_ATTR=rsbranch.Fields("BR_ATTR")
												if BR_Attr = "AO" then
																sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
																sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
												elseif BR_Attr="HO" then
															    sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
															    conn_2.execute(sql)
												else
																sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode  &"',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
																sql="select brcd,BRRGCD,BR_ATTR from brms where BRRGCD='" & BRRGCD & "' and BR_ATTR='AO'"
																set rsBranch1=con.execute(sql)
																if not rsbranch1.eof then
																		brcd1=trim(rsbranch1.fields("brcd"))
																		sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode  &"',0,0,"& currfinyear &",'" & brcd & "')"
																		conn_2.execute(sql)																						
																		sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																		conn_2.execute(sql)
																end if
												end if
								end if
					end if 			
								'for business on ac creation
								sql="select groupcode from " & GTableName & " where upper(groupdesc) like '%BUSINESS ASSOCIATE ON A/C%'"
								set rsGroup=con.execute(sql)
								if not rsgroup.EOF then
												groupcode=rsgroup.Fields("groupcode")
								else
												groupCode="ASS0001"
								end if
								acccode=rsBA.fields("acccodeOnAc")
								if trim(AccCode) = "" or isnull(AccCode) then
								    AccCode=genAccountCode(GroupCode)
								end if
								
								sql="Insert into " & ATableName & "(groupcode,acccode,accdesc,acccategory,secid,secdetailid,panno,contperson,address,tel,pin,fax,email,city,state,entryby,brcd) values ('" & groupcode & "','" & acccode & "','" & accdesc & "','" & acccategory & "'," & secid & "," & secdetailid & "," & panno & ",'" & contperson & "','" & address & "','" & tel & "','" & pin & "','" & fax & "','" & email & "','" & city & "','" & state & "','" & session("empcd") & "','" & brcd & "')"
        conn_2.execute(sql)
        
        sql="update bams set acccodeOnAc='" & acccode & "' where bacd='" & bacd & "' and babrcd='" & brcd & "'"	
        conn_2.execute(sql)
               
        x=getrootGroup(groupcode)
		'Response.Write currbrcd
  if ucase(rootGroupName)=ucase("Income") or ucase(rootGroupName)=ucase("Expenses") then
		else
								'brcd=session("brcd")
								sql="select brcd,BRRGCD,BR_ATTR from brms where brcd='" & brcd & "'"
								set rsBranch=con.execute(sql)
								if not rsBranch.EOF then
												brcd1=trim(rsbranch.Fields("brcd"))
												BRRGCD=rsbranch.Fields("BRRGCD")
												BR_ATTR=rsbranch.Fields("BR_ATTR")
												if BR_Attr = "AO" then
																sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
																sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
												elseif BR_Attr="HO" then
															    sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
															    conn_2.execute(sql)
												else
																sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode  &"',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
																sql="select brcd,BRRGCD,BR_ATTR from brms where BRRGCD='" & BRRGCD & "' and BR_ATTR='AO'"
																set rsBranch1=con.execute(sql)
																if not rsbranch1.eof then
																		brcd1=trim(rsbranch1.fields("brcd"))
																		sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode  &"',0,0,"& currfinyear &",'" & brcd & "')"
																		conn_2.execute(sql)																						
																		sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																		conn_2.execute(sql)
																end if
												end if
								end if
			end if	
	else	
								sql="update " & ATableName & " set groupcode='" & groupcode & "',acccode='" & acccode & "',accdesc='" & accdesc & "',acccategory='" & acccategory & "',secid=" & secid &",secdetailid=" & secdetailid & ",panno=" & panno & ",contperson='" & contperson &"',address='" & address & "',tel='" & tel & "',pin='" & pin & "',fax='" & fax & "',email='" & email & "',city='" & city & "',state='" & state & "',entryby='" & session("empcd") &"',brcd='" & brcd & "' where acccode='" & acccode & "'" 
								conn_2.execute(sql)
								'On Ac Updation
								sql="select groupcode from " & GTableName & " where upper(groupdesc) like '%BUSINESS ASSOCIATE ON A/C%'"
								set rsGroup=con.execute(sql)
								if not rsgroup.EOF then
												groupcode=rsgroup.Fields("groupcode")
								else
												groupCode="ASS0001"
								end if
								acccode=rsBA.fields("acccodeOnAc")
								if trim(AccCode) = "" or isnull(AccCode) then
								    AccCode=genAccountCode(GroupCode)
								end if
								sql="update " & ATableName & " set groupcode='" & groupcode & "',acccode='" & acccode & "',accdesc='" & accdesc & "',acccategory='" & acccategory & "',secid=" & secid &",secdetailid=" & secdetailid & ",panno=" & panno & ",contperson='" & contperson &"',address='" & address & "',tel='" & tel & "',pin='" & pin & "',fax='" & fax & "',email='" & email & "',city='" & city & "',state='" & state & "',entryby='" & session("empcd") &"',brcd='" & brcd & "' where acccode='" & acccode & "'" 
								conn_2.execute(sql)						
		end if
			
		if Err.number<>0 then
			    conn_2.RollbackTrans
		else
				conn_2.CommitTrans 
		end if 
		conn_2.close
	end if
end sub

'used for adding BA Account 

Sub AddBAAccount_old(brcd,bacd,mode)
	set rsBA=server.CreateObject("adodb.recordset")
	set rsAccount=server.CreateObject("adodb.recordset")
	set rsGroup=server.CreateObject("adodb.recordset")
	
	 sql="select * from bams where bacd='" & bacd & "' and babrcd='" & brcd & "'"	
  set rsBA=con.execute(sql)
    
  if not rsBA.EOF then
  'opening account in Business Associates in sundry creditor
		GTableName="tbl_groups_" & divsuffix
		sql="select groupcode from " & GTableName & " where upper(groupdesc) like '%BUSINESS ASSOCIATES%'"
		set rsGroup=con.execute(sql)
		
		if not rsgroup.EOF then
						groupcode=rsgroup.Fields("groupcode")
		else
		    groupCode="LIA001"
		end if	
		
		ContPerson=replace(IsNullCheck(rsBA.fields("banm")),"'","''")
		Address=replace(IsNullCheck(rsBA.fields("baaddress")),"'","''")
		State=""
		City=replace(IsNullCheck(rsBA.fields("bacity")),"'","''")
		Pin=IsNullCheck(rsBA.fields("bapin"))
		Tel=IsNullCheck(rsBA.fields("batels"))
		Fax=""
		Email=replace(IsNullCheck(rsBA.fields("baemail")),"'","''")
		AccCategory="Creditor"
		acccode=rsBA.fields("acccode")
		if trim(AccCode) = "" or isnull(AccCode) then
		    AccCode=genAccountCode(GroupCode)
		end if 
		AccDesc=replace(IsNullCheck(rsBA.fields("banm")),"'","''")
		secId="null"
		SecDetailId="null"
		PanNo="null"
		'transaction starts here
		conn_2.BeginTrans
		ATableName="tbl_acctinfo_" & divsuffix 
		' Insertion into acctinfo
	if mode=0 then
		sql="Insert into " & ATableName & "(groupcode,acccode,accdesc,acccategory,secid,secdetailid,panno,contperson,address,tel,pin,fax,email,city,state,entryby,brcd) values ('" & groupcode & "','" & acccode & "','" & accdesc & "','" & acccategory & "'," & secid & "," & secdetailid & "," & panno & ",'" & contperson & "','" & address & "','" & tel & "','" & pin & "','" & fax & "','" & email & "','" & city & "','" & state & "','" & session("empcd") & "','" & brcd & "')"
        conn_2.execute(sql)
        
        sql="update bams set acccode='" & acccode & "' where bacd='" & bacd & "' and babrcd='" & brcd & "'"	
        conn_2.execute(sql)
        
        x=getrootGroup(groupcode)
		'Response.Write currbrcd
        if ucase(rootGroupName)=ucase("Income") or ucase(rootGroupName)=ucase("Expenses") then
		else
								'brcd=session("brcd")
								sql="select brcd,BRRGCD,BR_ATTR from brms where brcd='" & brcd & "'"
								set rsBranch=con.execute(sql)
								if not rsBranch.EOF then
												brcd1=trim(rsbranch.Fields("brcd"))
												BRRGCD=rsbranch.Fields("BRRGCD")
												BR_ATTR=rsbranch.Fields("BR_ATTR")
												if BR_Attr = "AO" then
																sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
																sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
												elseif BR_Attr="HO" then
															    sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
															    conn_2.execute(sql)
												else
																sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode  &"',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
																sql="select brcd,BRRGCD,BR_ATTR from brms where BRRGCD='" & BRRGCD & "' and BR_ATTR='AO'"
																set rsBranch1=con.execute(sql)
																if not rsbranch1.eof then
																		brcd1=trim(rsbranch1.fields("brcd"))
																		sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode  &"',0,0,"& currfinyear &",'" & brcd & "')"
																		conn_2.execute(sql)																						
																		sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																		conn_2.execute(sql)
																end if
												end if
								end if
		end if	
	else	
		sql="update " & ATableName & " set groupcode='" & groupcode & "',acccode='" & acccode & "',accdesc='" & accdesc & "',acccategory='" & acccategory & "',secid=" & secid &",secdetailid=" & secdetailid & ",panno=" & panno & ",contperson='" & contperson &"',address='" & address & "',tel='" & tel & "',pin='" & pin & "',fax='" & fax & "',email='" & email & "',city='" & city & "',state='" & state & "',entryby='" & session("empcd") &"',brcd='" & brcd & "' where acccode='" & acccode & "'" 
		conn_2.execute(sql)
	end if
			
		if Err.number<>0 then
			    conn_2.RollbackTrans
		else
				conn_2.CommitTrans 
		end if 
		conn_2.close
	end if
    
    
end sub

'(**************************
'used for adding party Account
Sub AddPartyAccount(brcd,ptmsptcd,mode)
	set rsParty=server.CreateObject("adodb.recordset")
	set rsAccount=server.CreateObject("adodb.recordset")
	set rsGroup=server.CreateObject("adodb.recordset")
	
	sql="select * from ptms where ptmsptcd='" & ptmsptcd & "' and ptmsbrcd='" & brcd & "'"	
    set rsParty=con.execute(sql)
    
    if not rsParty.EOF then
		GTableName="tbl_groups_" & divsuffix
		sql="select groupcode from " & GTableName & " where upper(groupdesc) like '%SUNDRY DEBTOR%'"
		set rsGroup=con.execute(sql)
		
		if not rsgroup.EOF then
			groupcode=rsgroup.Fields("groupcode")
		else
		    groupCode="ASS001"
		end if	
		
		ContPerson=replace(IsNullCheck(rsParty.fields("PTMSCONTPERSON")),"'","''")
		Address=replace(IsNullCheck(rsParty.fields("PTMSADDRESS")),"'","''")
		State=""
		City=replace(IsNullCheck(rsParty.fields("PTMSCITY")),"'","''")
		Pin=IsNullCheck(rsParty.fields("PTMSPIN"))
		Tel=IsNullCheck(rsParty.fields("PTMSPTEL"))
		Fax=IsNullCheck(rsParty.fields("PTMSFAX"))
		Email=replace(IsNullCheck(rsParty.fields("PTMSEMAIL")),"'","''")
		AccCategory="Debtor"
		acccode=rsParty.fields("acccode")
		if trim(AccCode) = "" or isnull(AccCode) then
		    AccCode=genAccountCode(GroupCode)
		end if 
		AccDesc=replace(IsNullCheck(rsParty.fields("PTMSPTNM")),"'","''")
		secId="null"
		SecDetailId="null"
		PanNo="null"
		'transaction starts here
		conn_2.BeginTrans
		ATableName="tbl_acctinfo_" & divsuffix 
		' Insertion into acctinfo
		if mode=0 then
		sql="Insert into " & ATableName & "(groupcode,acccode,accdesc,acccategory,secid,secdetailid,panno,contperson,address,tel,pin,fax,email,city,state,entryby,brcd) values ('" & groupcode & "','" & acccode & "','" & accdesc & "','" & acccategory & "'," & secid & "," & secdetailid & "," & panno & ",'" & contperson & "','" & address & "','" & tel & "','" & pin & "','" & fax & "','" & email & "','" & city & "','" & state & "','" & session("empcd") & "','" & brcd & "')"
        conn_2.execute(sql)
        
        sql="update ptms set acccode='" & acccode & "' where ptmsptcd='" & ptmsptcd & "' and ptmsbrcd='" & brcd & "'"	
        conn_2.execute(sql)
        
        x=getrootGroup(groupcode)
		'Response.Write currbrcd
        if ucase(rootGroupName)=ucase("Income") or ucase(rootGroupName)=ucase("Expenses") then
		else
								'brcd=session("brcd")
								sql="select brcd,BRRGCD,BR_ATTR from brms where brcd='" & brcd & "'"
								set rsBranch=con.execute(sql)
								if not rsBranch.EOF then
												brcd1=trim(rsbranch.Fields("brcd"))
												BRRGCD=rsbranch.Fields("BRRGCD")
												BR_ATTR=rsbranch.Fields("BR_ATTR")
												if BR_Attr = "AO" then
																sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
																sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
												elseif BR_Attr="HO" then
															 sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
															 conn_2.execute(sql)
												else
																sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode  &"',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
																sql="select brcd,BRRGCD,BR_ATTR from brms where BRRGCD='" & BRRGCD & "' and BR_ATTR='AO'"
																set rsBranch1=con.execute(sql)
																if not rsbranch1.eof then
																		brcd1=trim(rsbranch1.fields("brcd"))
																		sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode  &"',0,0,"& currfinyear &",'" & brcd & "')"
																		conn_2.execute(sql)																						
																		sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																		conn_2.execute(sql)
																end if
												end if
								end if
			end if			
		else	
				sql="update " & ATableName & " set groupcode='" & groupcode & "',acccode='" & acccode & "',accdesc='" & accdesc & "',acccategory='" & acccategory & "',secid=" & secid &",secdetailid=" & secdetailid & ",panno=" & panno & ",contperson='" & contperson &"',address='" & address & "',tel='" & tel & "',pin='" & pin & "',fax='" & fax & "',email='" & email & "',city='" & city & "',state='" & state & "',entryby='" & session("empcd") &"',brcd='" & brcd & "' where acccode='" & acccode & "'" 
				'Response.Write sql
				'Response.End 
				conn_2.execute(sql)
		end if
		if Err.number<>0 then
			    conn_2.RollbackTrans
		else
				conn_2.CommitTrans 
		end if 
		conn_2.close
	end if
  
end sub

'*********************************************
'used for adding Octroi Agent Account 
Sub AddOctroiAGAccount(brcd,OCAGCD,mode)
	set rsOctAg=server.CreateObject("adodb.recordset")
	set rsAccount=server.CreateObject("adodb.recordset")
	set rsGroup=server.CreateObject("adodb.recordset")
	
	sql="select * from octagmst where OCAGCD='" & OCAGCD & "' and OCAGBR='" & brcd & "'"	
	set rsOctAg=con.execute(sql)
    
 if not rsOctAg.EOF then
				GTableName="tbl_groups_" & divsuffix
				sql="select groupcode from " & GTableName & " where upper(groupdesc) like '%OCTROI AGENT%'"
				set rsGroup=con.execute(sql)
		
				if not rsgroup.EOF then
						  groupcode=rsgroup.Fields("groupcode")
				else
						  groupCode="LIA001"
				end if	
		
				ContPerson=replace(IsNullCheck(rsOctAg.fields("OCAGNM")),"'","''")
				Address=replace(IsNullCheck(rsOctAg.fields("OCAGADDRESS")),"'","''")
				State=""
				City=replace(IsNullCheck(rsOctAg.fields("OCAGCITY")),"'","''")
				Pin=IsNullCheck(rsOctAg.fields("OCAGPIN"))
				Tel=IsNullCheck(rsOctAg.fields("OCAGTEL"))
				Fax=""
				Email=""
				AccCategory="Creditor"
				acccode=rsOctAg.fields("acccode")
				if trim(AccCode) = "" or isnull(AccCode) then
						AccCode=genAccountCode(GroupCode)
				end if 
				AccDesc=replace(IsNullCheck(rsOctAg.fields("OCAGNM")),"'","''")
				secId="null"
				SecDetailId="null"
				PanNo="null"
				'transaction starts here
				conn_2.BeginTrans
				ATableName="tbl_acctinfo_" & divsuffix 
		' Insertion into acctinfo
	if mode=0 then
		sql="Insert into " & ATableName & "(groupcode,acccode,accdesc,acccategory,secid,secdetailid,panno,contperson,address,tel,pin,fax,email,city,state,entryby,brcd) values ('" & groupcode & "','" & acccode & "','" & accdesc & "','" & acccategory & "'," & secid & "," & secdetailid & "," & panno & ",'" & contperson & "','" & address & "','" & tel & "','" & pin & "','" & fax & "','" & email & "','" & city & "','" & state & "','" & session("empcd") & "','" & brcd & "')"
        conn_2.execute(sql)
        
        sql="update octagmst set acccode='" & acccode & "' where OCAGCD='" & OCAGCD & "' and OCAGBR='" & brcd & "'"	
        conn_2.execute(sql)
        
        x=getrootGroup(groupcode)
		'Response.Write currbrcd
        if ucase(rootGroupName)=ucase("Income") or ucase(rootGroupName)=ucase("Expenses") then
								else
								'brcd=session("brcd")
								sql="select brcd,BRRGCD,BR_ATTR from brms where brcd='" & brcd & "'"
								set rsBranch=con.execute(sql)
						 
								if not rsBranch.EOF then
												brcd1=trim(rsbranch.Fields("brcd"))
												BRRGCD=rsbranch.Fields("BRRGCD")
												BR_ATTR=rsbranch.Fields("BR_ATTR")
											
												if BR_Attr = "AO" then
																sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
																sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
												elseif BR_Attr="HO" then
															    sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
															    conn_2.execute(sql)
												else
																
																sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode  &"',0,0,"& currfinyear &",'" & brcd & "')"
																conn_2.execute(sql)
																sql="select brcd,BRRGCD,BR_ATTR from brms where BRRGCD='" & BRRGCD & "' and BR_ATTR='AO'"
																set rsBranch1=con.execute(sql)
																
																if not rsbranch1.eof then
																		brcd1=trim(rsbranch1.fields("brcd"))
																		sql="insert into tbl_acctopening_" & divSuffix & "_" & brcd1 & "_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode  &"',0,0,"& currfinyear &",'" & brcd & "')"
																		conn_2.execute(sql)																						
																		'Response.Write sql 
																		sql="insert into tbl_acctopening_" & divSuffix & "_SBBY_" & yearSuffix & "(acccode,opencredit,opendebit,finyear,brcd)values('" & acccode & "',0,0,"& currfinyear &",'" & brcd & "')"
																		conn_2.execute(sql)
																		'Response.Write sql 
																  'Response.End
																end if
												end if
								end if
		end if	
	else	
		sql="update " & ATableName & " set groupcode='" & groupcode & "',acccode='" & acccode & "',accdesc='" & accdesc & "',acccategory='" & acccategory & "',secid=" & secid &",secdetailid=" & secdetailid & ",panno=" & panno & ",contperson='" & contperson &"',address='" & address & "',tel='" & tel & "',pin='" & pin & "',fax='" & fax & "',email='" & email & "',city='" & city & "',state='" & state & "',entryby='" & session("empcd") &"',brcd='" & brcd & "' where acccode='" & acccode & "'" 
		conn_2.execute(sql)
	end if
		'	Response.End
		if Err.number<>0 then
			    conn_2.RollbackTrans
		else
				conn_2.CommitTrans 
		end if 
		conn_2.close
	end if
end sub






'****** Ramashish's Code starts here (01 Jul 2003)***********************************

'--- To generate voucherno.
Function vcodegene(tablesuffix,transtyp)
 set rs1=server.CreateObject("adodb.recordset")
    sql="select max(voucherno)+1 from tbl_acctrans_" & tablesuffix & " where transtype='" & transtyp & "' "'where ccode in ( " & gsccodeRep & ") and transtype='Journal'"
    set rs1 =conn_2.execute(sql)     
    If IsNull(rs1.Fields(0)) Then
        voucherno = "1"
    Else
        voucherno = CStr(rs1.Fields(0))
    End If
    rs1.Close
    vcodegene=voucherno
End function
'-----------
'Generating voucher no 
Function vcodegeneNew(tablesuffix,transtysp,brcd)
	set rsVoucher=server.CreateObject("adodb.recordset")
	VReg="VR"
	'Response.Write "<br> Vreg : " & Vreg
	'Response.end
	rsVoucher.CursorType=3
	rsVoucher.LockType=3
	sql="select lastno from webx_voucherno_ctrl where brcd ='"& brcd & "'"
	set rsVoucher=conn_2.execute(sql)
	if not rsVoucher.eof then
		V1=Cdbl(rsVoucher("lastno"))+1
		if cdbl(V1)=0 then
			vcodegeneNew = VReg & brcd & "-" & mid(currfinyear,3,2) & "00001"
		else
		    vcodegeneNew = VReg & brcd & "-" & mid(currfinyear,3,2) & string(5-len(V1),"0") & cstr(V1)    
		end if
		sqlupdt="Update webx_voucherno_ctrl set lastno= " & V1 & " where brcd ='" & brcd & "'"
    	conn_2.execute(sqlupdt)
	else
		vcodegeneNew = VReg & ucase(brcd) & "-" & mid(currfinyear,3,2) & "00001"
		sql="insert into webx_voucherno_ctrl(brcd,lastno) values('" & brcd & "',1)"
		conn_2.execute(sql)
	end if
	rsVoucher.Close() 
End function

Function vcodegeneNew_old(tablesuffix,transtyp)
 set rs1=server.CreateObject("adodb.recordset")
    sql="select max(voucherno)+1 from " & tablesuffix & " where transtype='" & transtyp & "'" 
    
    'Response.Write sql
    set rs1 =conn_2.execute(sql)     
    If IsNull(rs1.Fields(0)) Then
        voucherno = "1"
    Else
        voucherno = CStr(rs1.Fields(0))
    End If
    rs1.Close
    vcodegeneNew=voucherno
End function

'--- To generate voucherno.
Function srnocodegene(tablesuffix)
 set rs1=server.CreateObject("adodb.recordset")
    sql="select max(Srno)+1 from tbl_acctrans_" & tablesuffix & ""'where ccode in ( " & gsccodeRep & ") and transtype='Journal'"
    set rs1 =conn_2.execute(sql)     
    If IsNull(rs1.Fields(0)) Then
        srno = "1"
    Else
        srno = CStr(rs1.Fields(0))
    End If
    rs1.Close
    srnocodegene=srno
End function

Function srnocodegeneNew(tablesuffix)
	'***** Remmoved on 30 Dec 03 3:05pm

	'set rs1=server.CreateObject("adodb.recordset")
	'tableName="tbl_acctrans_" & divsuffix & "_SBBY_" & yearsuffix
    'sql="select max(Srno)+1 from " & tableName & ""

	'*****Added on 30 Dec 03 2pm
	'rs1.CursorType=3
	'rs1.LockType=3
	'sql = "exec sp_srnogen @TransTable='" & tableName & "'"
    'set rs1 =conn_2.execute(sql)     
    'If IsNull(rs1.Fields(0)) Then
    '    srno = "1"
    'Else
    '    srno = CStr(rs1.Fields(0))
    'End If
    'rs1.Close
    'srnocodegeneNew=srno
	'*******************************
	srnocodegeneNew="0"
End function


'-----------


function GetControlAccCode(pay)

	'response.write("<br>accdesc_str : " & accdesc_str)
	acccode_str_ARR=split(mControlAcccode_str,"~")
	accdesc_str_ARR=split(mControlAccdesc_str,"~")
	dim i
for i= 0 to UBOUND(accdesc_str_ARR)	
	if Ucase(trim(acccode_str_ARR(i)))=Ucase(trim(pay)) then
	  ControlAccCode=trim(acccode_str_ARR(i))
	  ControlAccDesc=trim(accdesc_str_ARR(i))
	  exit for
	end if
next
if i > UBOUND(accdesc_str_ARR)	 then
	  ControlAccCode="0000000000"%>
		<HTML>
		<title>Webxpress</title>
		<head>
		<script language="javascript">
		<!-- hide from old browsers
		ie4 = (document.all)? true:false

		function showit() {
		if (ie4) {blinking.style.visibility = "visible"}
		setTimeout("hideit()",1000)
		}

		function hideit() {
		if (ie4) {blinking.style.visibility = "hidden"}
		setTimeout("showit()",1000)
		}

		//-->
		</script>
		</head>

		<style type="text/css">
		<!--
		#blinking{text-decoration:blink;font-family:tahoma,verdana,font-size:12px;color:#400000;
		}
		-->
		</style>
	  <BODY onload="showit()" background="" bgcolor="" >
	  <%Response.Write ("<br><br><br><br><br><DIV id='blinking'><p align=center><b><font face=verdana size=3 color=red>Transactions halted !!!</font></p></DIV><center><font face=verdana szie=1 color=red>This account '" + pay + "' does not exists.</font></center>")
		Response.Write ("<br><center><font face=verdana size=2><a href='javascript:history.go(-1)'>Back</a></font></center>")%>	  
	  </BODY>
  	  </HTML>
	  <%
	  '<br>This account '" + pay + "' does not exists.</font></b>
	  Response.End
end if	
	GetControlAccCode=ControlAccCode
	'Response.Write ("<br><br>**ControlAccCode : " & ControlAccCode) 
'   next

end function

function GetControlAccCodeNew(pay)

	'response.write("<br>accdesc_str : " & accdesc_str)
	acccode_str_ARR=split(mControlAcccode_str,"~")
	accdesc_str_ARR=split(mControlAccdesc_str,"~")
	dim i
for i= 0 to UBOUND(accdesc_str_ARR)	
	if Ucase(trim(acccode_str_ARR(i)))=Ucase(trim(pay)) then
	  ControlAccCode=trim(acccode_str_ARR(i))
	  ControlAccDesc=trim(accdesc_str_ARR(i))
	  exit for
	end if
next
if i > UBOUND(acccode_str_ARR)	 then
	  ControlAccCode="0000000000"%>
		<HTML>
		<title>WebXpress</title>
		<head>
		<script language="javascript">
		<!-- hide from old browsers
		ie4 = (document.all)? true:false

		function showit() {
		if (ie4) {blinking.style.visibility = "visible"}
		setTimeout("hideit()",1000)
		}

		function hideit() {
		if (ie4) {blinking.style.visibility = "hidden"}
		setTimeout("showit()",1000)
		}

		//-->
		</script>
		</head>

		<style type="text/css">
		<!--
		#blinking{text-decoration:blink;font-family:tahoma,verdana,font-size:12px;color:#400000;
		}
		-->
		</style>
	  <BODY onload="showit()" background="" bgcolor="" >
	  <%Response.Write ("<br><br><br><br><br><DIV id='blinking'><p align=center><b><font face=verdana size=3 color=red>Transactions halted !!!</font></p></DIV><center><font face=verdana szie=1 color=red>This account '" + pay + "' does not exists.</font></center>")
		Response.Write ("<br><center><font face=verdana size=2><a href='javascript:history.go(-1)'>Back</a></font></center>")%>	  
	  </BODY>
  	  </HTML>
	  <%
	  '<br>This account '" + pay + "' does not exists.</font></b>
	  Response.End
end if	
	GetControlAccCodeNew=ControlAccCode
	'Response.Write ("<br><br>**ControlAccCode : " & ControlAccCode) 
'   next

end function

function GetControlAccCode_old(pay)
    'pay="XX"
    set myrd=server.CreateObject("adodb.recordset")
	tblstr= "tbl_accsettings_" + divsuffix
	'sql="Select * from " & tblstr & " a ,tbl_acctinfo_" & divsuffix & " b where a.acccode=b.acccode and  caption = '" & pay & "'"
	'changed on 24 July 03 by ramashish
	sql="Select * from tbl_acctinfo_" & divsuffix & " b where b.accdesc = '" & pay & "'"

	'Response.Write sql
	set myrd =con.execute(sql)
	if not myrd.eof then
	  ControlAccCode=myrd("Acccode")
	  ControlAccDesc=myrd("accdesc")
	else
	  ControlAccCode="0000000000"%>
		<HTML>
		<title>E-Speedage</title>
		<head>
		<script language="javascript">
		<!-- hide from old browsers
		ie4 = (document.all)? true:false

		function showit() {
		if (ie4) {blinking.style.visibility = "visible"}
		setTimeout("hideit()",1000)
		}

		function hideit() {
		if (ie4) {blinking.style.visibility = "hidden"}
		setTimeout("showit()",1000)
		}

		//-->
		</script>
		</head>

		<style type="text/css">
		<!--
		#blinking{text-decoration:blink;font-family:tahoma,verdana,font-size:12px;color:#400000;
		}
		-->
		</style>
	  <BODY onload="showit()" background="" bgcolor="" >
	  <%Response.Write ("<br><br><br><br><br><DIV id='blinking'><p align=center><b><font face=verdana size=3 color=red>Transactions halted !!!</font></p></DIV><center><font face=verdana szie=1 color=red>This account '" + pay + "' does not exists.</font></center>")
		Response.Write ("<br><center><font face=verdana size=2><a href='javascript:history.go(-1)'>Back</a></font></center>")%>	  
	  </BODY>
  	  </HTML>
	  <%
	  '<br>This account '" + pay + "' does not exists.</font></b>
	  Response.End
	end if
	GetControlAccCode=ControlAccCode
	myrd.Close
	'Response.Write ("<br><br>**ControlAccCode : " & ControlAccCode) 
end function




Function IntTransNew (brcd,acccode,Oppacccode,oppbrcd,transdate,transtyp,opertitle,transno,amtFlag)
   rtnval="I"
   IntTransNew=rtnval
end function


Function IntTransNew_old_03Jan04 (brcd,acccode,Oppacccode,oppbrcd,transdate,transtyp,opertitle,transno,amtFlag)
   set rsInt=server.CreateObject("adodb.recordset")
   dim rtnval
   sqlIntDel="delete  from tbl_inttrans_" & divsuffix & " where  convert(varchar,transdate,106)<convert(datetime,'" & transdate & "',106)"   
   conn_2.execute(sqlIntDel)
   sqlInt="select * from tbl_inttrans_" & divsuffix & " where brcd='" & brcd & "' and acccode='" & acccode & "' and oppacccode='" & oppacccode & "' and oppbrcd='" & oppbrcd &"' and  transtyp='" & transtyp & "' and convert(varchar,transdate,106)=convert(datetime,'" & transdate & "',106) and opertitle='" & opertitle & "' and transno=" & transno & " and amtFlag='" & amtFlag & "'" 
   'Response.Write "<br>" + sqlInt + "<br>"
   set rsInt=conn_2.execute(sqlInt)
   if not rsInt.EOF then
	  rtnval="U"
   else
      rtnval="I"
      sqlIns="Insert into tbl_inttrans_" & divsuffix & " (brcd,acccode,oppbrcd,oppacccode,transdate,transtyp,opertitle,transno,amtFlag) values ('" & brcd & "','" & acccode & "','" & oppbrcd &"','" & oppacccode & "','" & transdate & "','" & transtyp & "','" & opertitle & "',"& transno & ",'" & amtFlag & "')"
      'Response.Write("<br>sqlIns : " & sqlIns)
      conn_2.execute(sqlIns)
   end if
   'Response.Write rtnval + "<br>"
   IntTransNew=rtnval
   rsInt.close
end function

'Return date in dd mmm yy format
function MyDateDDMMMYY(dt)
			MyDateDDMMMYY = "-"
			if Not isnull(dt) then
						MyDateDDMMMYY = day(dt) & " " & mid(monthname(month(dt),true),1,3) & " " &  mid(cstr(year(dt)),3,2)
			end if
end function

Function getOpenBal_MIS(acccode, enddate,AcctOpenTable,AcctTransTable,AccBrcd,mindividual) 

		cbs_brcd=AccBrcd

		'sql="Select * from webx_location where loccode='" & AccBrcd & "'"
		'set myrd=con.execute(sql)
		'if not myrd.eof then
	    '		Loc_level=myrd("BR_ATTR")
		'end if
		

        dim currcredit,currdebit,opendebit,opencredit,closedebit,closecredit
        set rsopenbal=server.CreateObject("adodb.recordset")
        set rscurrtrans=server.CreateObject("adodb.recordset")
        currcredit=0
        currdebit=0
        opendebit=0
        opencredit=0
        closedebit=0
        closecredit=0  
        if mindividual= "N" then
        	sql = "select opendebit + opendebit_i as opendebit,opencredit + opencredit_i as opencredit from " & AcctOpenTable & " where acccode='" & acccode & "' and brcd='" & AccBrcd & "'"
		else	
			sql = "select opendebit_i as opendebit,opencredit_i as opencredit from " & AcctOpenTable & " where acccode='" & acccode & "' and brcd='" & AccBrcd & "'"
		end if	
        'Response.write sql
        Set rsopenbal = con.Execute(sql)
		opendebit = 0
        opencredit = 0
        If Not rsopenbal.EOF Then
            if not isnull(rsopenbal.Fields("opendebit")) then
				opendebit = rsopenbal.Fields("opendebit")
			end if
			if not isnull(rsopenbal.Fields("opencredit")) then
				opencredit = rsopenbal.Fields("opencredit")
			end if
        End If
        rsopenbal.Close
                                        
        mdatefrom = mydateddmmmyy(finyearstart)
        mdateto = mydateddmmmyy(enddate)
        
        If DateValue(mdatefrom) <= DateValue(mdateto) Then
           	
           	sql="exec webx_cbs_mis " & AcctTransTable  & ",'" & acccode & "','" & mydateDDMMMYY(mdatefrom) & "','" & mydateDDMMMYY(mdateto) & "', '" & cbs_brcd & "','" & mindividual & "'"
            'response.Write sql
            'esponse.end 
            Set rscurrtrans = conn_2.Execute(sql)
                                    
            If Not rscurrtrans.EOF Then
               If IsNull(rscurrtrans.Fields(0)) Then
                  currcredit = 0
               Else
                  currcredit = Abs(cdbl(rscurrtrans.Fields(0)))
               End If
               If IsNull(rscurrtrans.Fields(1)) Then
                  currdebit = 0
               Else
                  currdebit = Abs(cdbl(rscurrtrans.Fields(1)))
               End If
            End If
            closedebit = cdbl(opendebit) + cdbl(currdebit)
            closecredit = cdbl(opencredit) + cdbl(currcredit)
            rscurrtrans.Close 
        Else

            closedebit = opendebit
            closecredit = opencredit
        End If
        If cdbl(closedebit) >= cdbl(closecredit) Then
           closedebit = CDbl(closedebit) - cdbl(closecredit)
           closecredit = 0
           If Formatnumber(closedebit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closedebit,2)) + " DR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        Else
           closecredit = cdbl(closecredit) - cdbl(closedebit)
           closedebit = 0
           If Formatnumber(closecredit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closecredit,2)) + " CR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        End If
        'Response.WRITE "bALANCE iS " & ReturnCurrBalBC
        getOpenBal_MIS=ReturnCurrBalBC
end function

Function getOpenBal_Trans(acccode, enddate,AcctOpenTable,AcctTransTable,AccBrcd) 

		cbs_brcd=AccBrcd

		'sql="Select * from webx_location where loccode='" & AccBrcd & "'"
		'set myrd=con.execute(sql)
		'if not myrd.eof then
	    '		Loc_level=myrd("BR_ATTR")
		'end if
		

        dim currcredit,currdebit,opendebit,opencredit,closedebit,closecredit
        set rsopenbal=server.CreateObject("adodb.recordset")
        set rscurrtrans=server.CreateObject("adodb.recordset")
        currcredit=0
        currdebit=0
        opendebit=0
        opencredit=0
        closedebit=0
        closecredit=0  
        
		sql = "select opendebit_i as opendebit,opencredit_i as opencredit from " & AcctOpenTable & " where acccode='" & acccode & "' and brcd='" & AccBrcd & "'"
        'Response.write sql
        Set rsopenbal = con.Execute(sql)
		opendebit = 0
        opencredit = 0
        If Not rsopenbal.EOF Then
            if not isnull(rsopenbal.Fields("opendebit")) then
				opendebit = rsopenbal.Fields("opendebit")
			end if
			if not isnull(rsopenbal.Fields("opencredit")) then
				opencredit = rsopenbal.Fields("opencredit")
			end if
        End If
        rsopenbal.Close
                                        
        mdatefrom = mydateddmmmyy(finyearstart)
        mdateto = mydateddmmmyy(enddate)
        
        If DateValue(mdatefrom) <= DateValue(mdateto) Then
           	sql="exec webx_cbs " & AcctTransTable  & ",'" & acccode & "','" & mydateDDMMMYY(mdatefrom) & "','" & mydateDDMMMYY(mdateto) & "', '" & cbs_brcd & "'"
            'response.Write sql
            'esponse.end 
            Set rscurrtrans = conn_2.Execute(sql)
                                    
            If Not rscurrtrans.EOF Then
               If IsNull(rscurrtrans.Fields(0)) Then
                  currcredit = 0
               Else
                  currcredit = Abs(cdbl(rscurrtrans.Fields(0)))
               End If
               If IsNull(rscurrtrans.Fields(1)) Then
                  currdebit = 0
               Else
                  currdebit = Abs(cdbl(rscurrtrans.Fields(1)))
               End If
            End If
            closedebit = cdbl(opendebit) + cdbl(currdebit)
            closecredit = cdbl(opencredit) + cdbl(currcredit)
            rscurrtrans.Close 
        Else

            closedebit = opendebit
            closecredit = opencredit
        End If
        If cdbl(closedebit) >= cdbl(closecredit) Then
           closedebit = CDbl(closedebit) - cdbl(closecredit)
           closecredit = 0
           If Formatnumber(closedebit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closedebit,2)) + " DR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        Else
           closecredit = cdbl(closecredit) - cdbl(closedebit)
           closedebit = 0
           If Formatnumber(closecredit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closecredit,2)) + " CR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        End If
        'Response.WRITE "bALANCE iS " & ReturnCurrBalBC
        getOpenBal_Trans=ReturnCurrBalBC
end function

Function getOpenBal_Trans_Agent(acccode, enddate,AcctOpenTable,AcctTransTable,AccBrcd,mAgentcode) 

		cbs_brcd=AccBrcd
        
        dim currcredit,currdebit,opendebit,opencredit,closedebit,closecredit
        set rsopenbal=server.CreateObject("adodb.recordset")
        set rscurrtrans=server.CreateObject("adodb.recordset")
        currcredit=0
        currdebit=0
        opendebit=0
        opencredit=0
        closedebit=0
        closecredit=0  
        
		'sql = "select opendebit_i as opendebit,opencredit_i as opencredit from " & AcctOpenTable & " where acccode='" & acccode & "' and brcd='" & AccBrcd & "'"
        'Response.write sql
        'Set rsopenbal = con.Execute(sql)
		opendebit = 0
        opencredit = 0
        'If Not rsopenbal.EOF Then
        '   if not isnull(rsopenbal.Fields("opendebit")) then
		'		opendebit = rsopenbal.Fields("opendebit")
		'	end if
		'	if not isnull(rsopenbal.Fields("opencredit")) then
		'		opencredit = rsopenbal.Fields("opencredit")
		'	end if
        'End If
        'rsopenbal.Close
                                    
        'mdatefrom = mydateddmmmyy(finyearstart)
        mdatefrom = mydate(lastfinyearstart) 'mydateddmmmyy(finyearstart)
        mdateto = mydateddmmmyy(enddate)
        
        If DateValue(mdatefrom) <= DateValue(mdateto) Then
			
           	sql="exec webx_cbs_Agent " & AcctTransTable  & ",'" & acccode & "','" & mydateDDMMMYY(mdatefrom) & "','" & mydateDDMMMYY(mdateto) & "', '" & cbs_brcd & "','" & mAgentCode & "'"
            'response.Write sql
            'esponse.end 
            Set rscurrtrans = conn_2.Execute(sql)
                                    
            If Not rscurrtrans.EOF Then
               If IsNull(rscurrtrans.Fields(0)) Then
                  currcredit = 0
               Else
                  currcredit = Abs(cdbl(rscurrtrans.Fields(0)))
               End If
               If IsNull(rscurrtrans.Fields(1)) Then
                  currdebit = 0
               Else
                  currdebit = Abs(cdbl(rscurrtrans.Fields(1)))
               End If
            End If
            closedebit = cdbl(opendebit) + cdbl(currdebit)
            closecredit = cdbl(opencredit) + cdbl(currcredit)
            rscurrtrans.Close 
        Else

            closedebit = opendebit
            closecredit = opencredit
        End If
        If cdbl(closedebit) >= cdbl(closecredit) Then
           closedebit = CDbl(closedebit) - cdbl(closecredit)
           closecredit = 0
           If Formatnumber(closedebit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closedebit,2)) + " DR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        Else
           closecredit = cdbl(closecredit) - cdbl(closedebit)
           closedebit = 0
           If Formatnumber(closecredit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closecredit,2)) + " CR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        End If
        'Response.WRITE "bALANCE iS " & ReturnCurrBalBC
        getOpenBal_Trans_Agent=ReturnCurrBalBC
end function

Function getOpenBal_Trans_old(acccode, enddate,AcctOpenTable,AcctTransTable,AccBrcd) 

		cbs_brcd=AccBrcd

		sql="Select * from brms where brcd='" & AccBrcd & "'"
		set myrd=con.execute(sql)
		if not myrd.eof then
			BR_ATTR=myrd("BR_ATTR")
		end if
		

        dim currcredit,currdebit,opendebit,opencredit,closedebit,closecredit
        set rsopenbal=server.CreateObject("adodb.recordset")
        set rscurrtrans=server.CreateObject("adodb.recordset")
        currcredit=0
        currdebit=0
        opendebit=0
        opencredit=0
        closedebit=0
        closecredit=0  
        if BR_ATTR="AO" or BR_ATTR="HO" then
			sql = "select opendebit_i as opendebit,opencredit_i as opencredit from " & AcctOpenTable & " where acccode='" & acccode & "'"
        else
            sql = "select opendebit,opencredit from " & AcctOpenTable & " where acccode='" & acccode & "'"
        end if
        'Response.write sql
        Set rsopenbal = con.Execute(sql)
		opendebit = 0
        opencredit = 0
        If Not rsopenbal.EOF Then
            if not isnull(rsopenbal.Fields("opendebit")) then
			opendebit = rsopenbal.Fields("opendebit")
			end if
			if not isnull(rsopenbal.Fields("opencredit")) then
			opencredit = rsopenbal.Fields("opencredit")
			end if
        End If
        rsopenbal.Close
                                        
        mdatefrom = mydateddmmmyy(finyearstart)
        mdateto = mydateddmmmyy(enddate)
        'Response.Write " mdatefrom :" & mdatefrom + "<br>"
		'Response.Write " mdateto :" & mdateto + "<br>"

        If DateValue(mdatefrom) <= DateValue(mdateto) Then
            'Response.Write("<br>1")
            'sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106)) and brcd='" & curr_brcd & "'"
            
            'Changed on 29 Nov 03 at 7:00 pm
            ''''''**********sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106)) and brcd in (select brcd from brms where cbs_brcd='" & cbs_brcd & "')"
   			sql="exec v_cbs " & AcctTransTable  & ",'" & acccode & "','" & mydateDDMMMYY(mdatefrom) & "','" & mydateDDMMMYY(mdateto) & "', '" & cbs_brcd & "'"

            'sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106)) and brcd ='" & cbs_brcd & "'"
		'Response.Write sql
            Set rscurrtrans = conn_2.Execute(sql)
                                    
            If Not rscurrtrans.EOF Then
            'Response.Write("<br>1a")
               If IsNull(rscurrtrans.Fields(0)) Then
                  currcredit = 0
               Else
                  currcredit = Abs(cdbl(rscurrtrans.Fields(0)))
               End If
               If IsNull(rscurrtrans.Fields(1)) Then
                  currdebit = 0
               Else
                  currdebit = Abs(cdbl(rscurrtrans.Fields(1)))
               End If
            End If
            closedebit = cdbl(opendebit) + cdbl(currdebit)
            closecredit = cdbl(opencredit) + cdbl(currcredit)
            rscurrtrans.Close 
        Else
            'Response.Write("<br>2")
            closedebit = opendebit
            closecredit = opencredit
        End If
        If cdbl(closedebit) >= cdbl(closecredit) Then
           closedebit = CDbl(closedebit) - cdbl(closecredit)
           closecredit = 0
           If Formatnumber(closedebit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closedebit,2)) + " DR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        Else
           closecredit = cdbl(closecredit) - cdbl(closedebit)
           closedebit = 0
           If Formatnumber(closecredit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closecredit,2)) + " CR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        End If
        getOpenBal_Trans=ReturnCurrBalBC
end function


'***** USED TO CHECK CASH IN HAND BALANCE FOR THE TRANSACTIONS
'used for returning current balance of an account
'please set following values before using this function
'AcctTransTable
'AcctOpenTable
Function getOpenBal_Trans_DELETE(acccode, enddate,AcctOpenTable,AcctTransTable,AccBrcd) 
        dim currcredit,currdebit,opendebit,opencredit,closedebit,closecredit
        set rsopenbal=server.CreateObject("adodb.recordset")
        set rscurrtrans=server.CreateObject("adodb.recordset")
        currcredit=0
        currdebit=0
        opendebit=0
        opencredit=0
        closedebit=0
        closecredit=0  
                                      
		sql="Select br_attr,hubcenter from BRMS where brcd ='" & AccBrcd & "'"
		Set rsbrattr = con.Execute(sql)
		if not rsbrattr.eof then
		  br_attr=ucase(rsbrattr("BR_ATTR"))
		  hubcenter=ucase(rsbrattr("HUBCENTER"))
		end if

		sql="Select * from BRMS where brrgcd in (Select brrgcd from brms where brcd='" & AccBrcd & "') and br_attr='AO'"
		Set rsbrattr = con.Execute(sql)
		if not rsbrattr.eof then
		 AccBrcd_AO=rsbrattr("BRCD")
		 brrgcd=rsbrattr("BRRGCD")
		end if

        if hubcenter="N" then
          if br_attr="HO" then
		    sql = "select opendebit_i as opendebit,opencredit_i as opencredit from " & AcctOpenTable & " where acccode='" & acccode & "'"
		  else
			sql = "select opendebit,opencredit from " & AcctOpenTable & " where acccode='" & acccode & "'"
		  end if		
        else
			AcctOpenTable=replace(AcctOpenTable,AccBrcd,AccBrcd_AO)
		    sql = "select opendebit_i as opendebit,opencredit_i as opencredit from " & AcctOpenTable & " where acccode='" & acccode & "'"
        end if
        
        'Response.write sql
        'Response.Write ("<br>sqlOB : " & sql)
        'Set rsopenbal = conn_2.Execute(sql)
        Set rsopenbal = conn_2.Execute(sql)
		opendebit = 0
        opencredit = 0
        If Not rsopenbal.EOF Then
			   If IsNull(rsopenbal.Fields("opencredit")) Then
                  opencredit = 0
               Else
                  opencredit = Abs(cdbl(rsopenbal.Fields("opencredit")))
               End If
               If IsNull(rsopenbal.Fields("opendebit")) Then
                  opendebit = 0
               Else
                  opendebit = Abs(cdbl(rsopenbal.Fields("opendebit")))
               End If
            'opendebit = rsopenbal.Fields("opendebit")
            'opencredit = rsopenbal.Fields("opencredit")
        Else
            opendebit = 0
            opencredit = 0
        End If
        rsopenbal.Close
                                        
        finyearstart =Cstr(Day(finyearstart)) + " " + Mid(Cstr(Monthname(month(finyearstart))) ,1,3) + " " + Cstr(year(finyearstart))
        mdatefrom = finyearstart
        mdateto = enddate
        
        If DateValue(mdatefrom) < DateValue(mdateto) Then
            if hubcenter="N" then
			  if br_attr="HO" then
                sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where BRCD ='" & AccBrcd & "' and  acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106))"
			  else
                sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106))"
              end if
            else
                'AcctTransTable=replace(AcctTransTable,AccBrcd,"SBBY")
                sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where BRCD in (select brcd from brms where brrgcd ='" & brrgcd & "' and hubcenter='Y') and  acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106))"
            end if  
			'Response.Write ("<br>sqlAT : " & sql)
            Set rscurrtrans = conn_2.Execute(sql)
            currdebit = 0
            currcredit = 0                        
            If Not rscurrtrans.EOF Then
               If IsNull(rscurrtrans.Fields(0)) Then
                  currcredit = 0
               Else
                  currcredit = Abs(cdbl(rscurrtrans.Fields(0)))
               End If
               If IsNull(rscurrtrans.Fields(1)) Then
                  currdebit = 0
               Else
                  currdebit = Abs(cdbl(rscurrtrans.Fields(1)))
               End If
            End If
            closedebit = cdbl(opendebit) + cdbl(currdebit)
            closecredit = cdbl(opencredit) + cdbl(currcredit)
        Else
            closedebit = opendebit
            closecredit = opencredit
        End If
        If cdbl(closedebit) >= cdbl(closecredit) Then
           closedebit = CDbl(closedebit) - cdbl(closecredit)
           closecredit = 0
           If Formatnumber(closedebit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closedebit,2)) + " DR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        Else
           closecredit = cdbl(closecredit) - cdbl(closedebit)
           closedebit = 0
           If Formatnumber(closecredit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closecredit,2)) + " CR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        End If
        getOpenBal_Trans=ReturnCurrBalBC
End Function

'****** USED FOR CBS STATEMENT REPORT
'used for returning current balance of an account
'please set following values before using this function
'AcctTransTable
'AcctOpenTable
Function getOpenBal(acccode, enddate,AcctOpenTable,AcctTransTable) 
        dim currcredit,currdebit,opendebit,opencredit,closedebit,closecredit
        set rsopenbal=server.CreateObject("adodb.recordset")
        set rscurrtrans=server.CreateObject("adodb.recordset")
        currcredit=0
        currdebit=0
        opendebit=0
        opencredit=0
        closedebit=0
        closecredit=0  
                                      
        sql = "select opendebit,opencredit from " & AcctOpenTable & " where acccode='" & acccode & "'"
        'Response.write sql
        Set rsopenbal = conn_2.Execute(sql)
        If Not rsopenbal.EOF Then
            opendebit = rsopenbal.Fields("opendebit")
            opencredit = rsopenbal.Fields("opencredit")
        Else
            opendebit = 0
            opencredit = 0
        End If
        rsopenbal.Close
                                        
        datefrom = finyearstart
        dateto = enddate
        
        If DateValue(datefrom) < DateValue(dateto) Then
            sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106))" & branchcls
		   ' Response.Write sql
		   ' Response.end 
            Set rscurrtrans = conn_2.Execute(sql)
                                    
            If Not rscurrtrans.EOF Then
               If IsNull(rscurrtrans.Fields(0)) Then
                  currcredit = 0
               Else
                  currcredit = Abs(cdbl(rscurrtrans.Fields(0)))
               End If
               If IsNull(rscurrtrans.Fields(1)) Then
                  currdebit = 0
               Else
                  currdebit = Abs(cdbl(rscurrtrans.Fields(1)))
               End If
            End If
            closedebit = cdbl(opendebit) + cdbl(currdebit)
            closecredit = cdbl(opencredit) + cdbl(currcredit)
        Else
            closedebit = opendebit
            closecredit = opencredit
        End If
        If cdbl(closedebit) >= cdbl(closecredit) Then
           closedebit = CDbl(closedebit) - cdbl(closecredit)
           closecredit = 0
           If Formatnumber(closedebit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closedebit,2)) + " DR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        Else
           closecredit = cdbl(closecredit) - cdbl(closedebit)
           closedebit = 0
           If Formatnumber(closecredit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closecredit,2)) + " CR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        End If
        getOpenBal=ReturnCurrBalBC
End Function
'used for checking whether the table exist in database 
function ChkTable(tableName)
	set rsfind=server.CreateObject("adodb.recordset")
	sqlfind="select name from dbo.sysobjects where name like '%" & tableName & "%' and OBJECTPROPERTY(id, N'IsUserTable') = 1"
	'Response.Write(sqlfind)
	set rsfind=conn_2.execute(sqlfind)
	if rsfind.EOF then
		ChkTable=false
	else
		ChkTable=True 
	end if
end function

Function getOpenBal_Ind(acccode, enddate,AcctOpenTable,AcctTransTable,curr_brcd,CBS_BRCD,BR_ATTR) 
        dim currcredit,currdebit,opendebit,opencredit,closedebit,closecredit
        set rsopenbal=server.CreateObject("adodb.recordset")
        set rscurrtrans=server.CreateObject("adodb.recordset")
        currcredit=0
        currdebit=0
        opendebit=0
        opencredit=0
        closedebit=0
        closecredit=0  
        if BR_ATTR="AO" or BR_ATTR="HO" then
			sql = "select opendebit_i as opendebit,opencredit_i as opencredit from " & AcctOpenTable & " where acccode='" & acccode & "'"
        else
            sql = "select opendebit,opencredit from " & AcctOpenTable & " where acccode='" & acccode & "'"
        end if
        'Response.write sql
        Set rsopenbal = con.Execute(sql)
		opendebit = 0
        opencredit = 0
        If Not rsopenbal.EOF Then
            if not isnull(rsopenbal.Fields("opendebit")) then
			opendebit = rsopenbal.Fields("opendebit")
			end if
			if not isnull(rsopenbal.Fields("opencredit")) then
			opencredit = rsopenbal.Fields("opencredit")
			end if
        End If
        rsopenbal.Close
                                        
        mdatefrom = mydateddmmmyy(finyearstart)
        mdateto = mydateddmmmyy(enddate)
        'Response.Write " mdatefrom :" & mdatefrom + "<br>"
		'Response.Write " mdateto :" & mdateto + "<br>"

        If DateValue(mdatefrom) <= DateValue(mdateto) Then
            'Response.Write("<br>1")
            'sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106)) and brcd='" & curr_brcd & "'"
            
            'Changed on 29 Nov 03 at 7:00 pm
            ''''''**********sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106)) and brcd in (select brcd from brms where cbs_brcd='" & cbs_brcd & "')"
   			sql="exec v_cbs " & AcctTransTable  & ",'" & acccode & "','" & mydateDDMMMYY(mdatefrom) & "','" & mydateDDMMMYY(mdateto) & "', '" & cbs_brcd & "'"

            'sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106)) and brcd ='" & cbs_brcd & "'"
			'Response.Write sql
            Set rscurrtrans = conn_2.Execute(sql)
                                    
            If Not rscurrtrans.EOF Then
            'Response.Write("<br>1a")
               If IsNull(rscurrtrans.Fields(0)) Then
                  currcredit = 0
               Else
                  currcredit = Abs(cdbl(rscurrtrans.Fields(0)))
               End If
               If IsNull(rscurrtrans.Fields(1)) Then
                  currdebit = 0
               Else
                  currdebit = Abs(cdbl(rscurrtrans.Fields(1)))
               End If
            End If
            closedebit = cdbl(opendebit) + cdbl(currdebit)
            closecredit = cdbl(opencredit) + cdbl(currcredit)
            rscurrtrans.Close 
        Else
            'Response.Write("<br>2")
            closedebit = opendebit
            closecredit = opencredit
        End If
        If cdbl(closedebit) >= cdbl(closecredit) Then
           closedebit = CDbl(closedebit) - cdbl(closecredit)
           closecredit = 0
           If Formatnumber(closedebit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closedebit,2)) + " DR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        Else
           closecredit = cdbl(closecredit) - cdbl(closedebit)
           closedebit = 0
           If Formatnumber(closecredit,2) <> 0 Then
                ReturnCurrBalBC = CStr(Formatnumber(closecredit,2)) + " CR"
           Else
                ReturnCurrBalBC = "0.00"
           End If
        End If
        getOpenBal_Ind=ReturnCurrBalBC
End Function

Function getOpenBal_CBS(acccode, enddate,AcctOpenTable,AcctTransTable,curr_brcd,CBS_BRCD,BR_ATTR) 
        dim currcredit,currdebit,opendebit,opencredit,closedebit,closecredit
        set rsopenbal=server.CreateObject("adodb.recordset")
        set rsClosebal=server.CreateObject("adodb.recordset")
        set rscurrtrans=server.CreateObject("adodb.recordset")
        currcredit=0
        currdebit=0
        opendebit=0
        opencredit=0
        closedebit=0
        closecredit=0  
		sql="select top 1 closedebit,closecredit,transdate from tbl_closingbalance_" & yearsuffix & " where brcd='" &  CBS_BRCD & "' and acccode='" & acccode  &"' and convert(varchar,transdate,106)<= convert(datetime,'"& enddate & "',106) order by transdate desc "
		'response.write sql + "<br>"

		set rsCloseBal=con.Execute(sql)
		if rscloseBal.eof then
				if BR_ATTR="AO" or BR_ATTR="HO" then
					sql = "select opendebit_i as opendebit,opencredit_i as opencredit from " & AcctOpenTable & " where acccode='" & acccode & "'"
				else
					sql = "select opendebit,opencredit from " & AcctOpenTable & " where acccode='" & acccode & "'"
				end if
				'Response.write sql
				Set rsopenbal = con.Execute(sql)
				opendebit = 0
				opencredit = 0
				If Not rsopenbal.EOF Then
					if not isnull(rsopenbal.Fields("opendebit")) then
					opendebit = rsopenbal.Fields("opendebit")
					end if
					if not isnull(rsopenbal.Fields("opencredit")) then
					opencredit = rsopenbal.Fields("opencredit")
					end if
				End If
				rsopenbal.Close
												
				mdatefrom = mydateddmmmyy(finyearstart)
				mdateto = mydateddmmmyy(enddate)
				'Response.Write " mdatefrom :" & mdatefrom + "<br>"
				'Response.Write " mdateto :" & mdateto + "<br>"

				If DateValue(mdatefrom) <= DateValue(mdateto) Then
					'Response.Write("<br>1")
					'sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106)) and brcd='" & curr_brcd & "'"
					
					'Changed on 29 Nov 03 at 7:00 pm
					''''''**********sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106)) and brcd in (select brcd from brms where cbs_brcd='" & cbs_brcd & "')"
					sql="exec v_cbs " & AcctTransTable  & ",'" & acccode & "','" & mydateDDMMMYY(mdatefrom) & "','" & mydateDDMMMYY(mdateto) & "', '" & cbs_brcd & "'"

					'sql = "select sum(credit),sum(debit) from " &  AcctTransTable & " where acccode='" & acccode & "' and (convert(varchar,transdate,106) between  convert(datetime,'" & mdatefrom & "',106) and convert(datetime,'" & mdateto & "',106)) and brcd ='" & cbs_brcd & "'"
					'Response.Write sql
					Set rscurrtrans = conn_2.Execute(sql)
											
					If Not rscurrtrans.EOF Then
					'Response.Write("<br>1a")
					   If IsNull(rscurrtrans.Fields(0)) Then
						  currcredit = 0
					   Else
						  currcredit = Abs(cdbl(rscurrtrans.Fields(0)))
					   End If
					   If IsNull(rscurrtrans.Fields(1)) Then
						  currdebit = 0
					   Else
						  currdebit = Abs(cdbl(rscurrtrans.Fields(1)))
					   End If
					End If
					closedebit = cdbl(opendebit) + cdbl(currdebit)
					closecredit = cdbl(opencredit) + cdbl(currcredit)
					rscurrtrans.Close 
				Else
					'Response.Write("<br>2")
					closedebit = opendebit
					closecredit = opencredit
				End If
				If cdbl(closedebit) >= cdbl(closecredit) Then
				   closedebit = CDbl(closedebit) - cdbl(closecredit)
				   closecredit = 0
				   If Formatnumber(closedebit,2) <> 0 Then
						ReturnCurrBalBC = CStr(Formatnumber(closedebit,2)) + " DR"
				   Else
						ReturnCurrBalBC = "0.00"
				   End If
				Else
				   closecredit = cdbl(closecredit) - cdbl(closedebit)
				   closedebit = 0
				   If Formatnumber(closecredit,2) <> 0 Then
						ReturnCurrBalBC = CStr(Formatnumber(closecredit,2)) + " CR"
				   Else
						ReturnCurrBalBC = "0.00"
				   End If
				End If
				getOpenBal_CBS=ReturnCurrBalBC
		else
				opendebit = rsCloseBal.fields("closedebit")
				opencredit = rsCloseBal.fields("closecredit")
				transdate = rsCloseBal.fields("transdate")

				transdate = dateadd("d",1,rsCloseBal.fields("transdate"))
				'mdatefrom = mydateddmmmyy(transdate)'mydateddmmmyy(finyearstart)
				mdateto = mydateddmmmyy(enddate)
				'Response.Write " mdatefrom :" & mdatefrom + "<br>"
				'Response.Write " mdateto :" & mdateto + "<br>"

				If DateValue(mdatefrom) <= DateValue(mdateto) Then
					sql="exec v_cbs " & AcctTransTable  & ",'" & acccode & "','" & mydateDDMMMYY(mdatefrom) & "','" & mydateDDMMMYY(mdateto) & "', '" & cbs_brcd & "'"

					'Response.Write sql
					Set rscurrtrans = conn_2.Execute(sql)
											
					If Not rscurrtrans.EOF Then
					'Response.Write("<br>1a")
					   If IsNull(rscurrtrans.Fields(0)) Then
						  currcredit = 0
					   Else
						  currcredit = Abs(cdbl(rscurrtrans.Fields(0)))
					   End If
					   If IsNull(rscurrtrans.Fields(1)) Then
						  currdebit = 0
					   Else
						  currdebit = Abs(cdbl(rscurrtrans.Fields(1)))
					   End If
					End If
					closedebit = cdbl(opendebit) + cdbl(currdebit)
					closecredit = cdbl(opencredit) + cdbl(currcredit)
					rscurrtrans.Close 
				Else
					'Response.Write("<br>2")
					closedebit = opendebit
					closecredit = opencredit
				End If
				If cdbl(closedebit) >= cdbl(closecredit) Then
				   closedebit = CDbl(closedebit) - cdbl(closecredit)
				   closecredit = 0
				   If Formatnumber(closedebit,2) <> 0 Then
						ReturnCurrBalBC = CStr(Formatnumber(closedebit,2)) + " DR"
				   Else
						ReturnCurrBalBC = "0.00"
				   End If
				Else
				   closecredit = cdbl(closecredit) - cdbl(closedebit)
				   closedebit = 0
				   If Formatnumber(closecredit,2) <> 0 Then
						ReturnCurrBalBC = CStr(Formatnumber(closecredit,2)) + " CR"
				   Else
						ReturnCurrBalBC = "0.00"
				   End If
				End If
				getOpenBal_CBS=ReturnCurrBalBC
		end if
End Function

%>


