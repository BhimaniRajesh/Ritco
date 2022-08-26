<!-- #include file="../../Scargoconn.asp" -->
<!-- #include file="../../functions.asp"-->
<%
qstring=trim(Request.QueryString)
if qstring="" then
	qstring="-"
end if

set myrec=server.CreateObject("ADODB.recordset")

if qstring<>"-" then
	custcode=qstring
	currentpage=1
else
	custcode="-"
	currentpage=trim(Request.form("currentpage"))
end if

if custcode="-" then
	sql="select GRPCD,GRPNM FROM webx_GRPMST ORDER BY GRPNM"
elseif custcode<>"-" then
	response.redirect "groupmast.asp?" + custcode
end if

dim  currentPage, rowCount, ctr
'currentpage = TRIM(Request.QueryString("currentPage"))
If currentPage = "" then 
	currentPage=1
END IF 
	
myrec.CursorType =3
myrec.PageSize =25'3
pgsize=25
myrec.CursorLocation = 3

myrec.open sql,con
if not myrec.EOF then
  RecFlag="Y"
  myrec.AbsolutePage = cint(currentPage)
  Reccntr=myrec.recordcount
end if
rowCount=0	
%>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<script language=javascript>
function saveCurrentIdx()		
		{	//alert(idx);
			idx = document.cargo.cboPgNo.selectedIndex;
		}
function goToPage()
{	
	yesNo = confirm("Do U Want to go to this Page?");
	if(yesNo)
	{	
	document.cargo.currentpage.value=document.cargo.cboPgNo.options[document.cargo.cboPgNo.selectedIndex].value;
	document.cargo.action = "grouplisting.asp";
	document.cargo.target = "_self";
	document.cargo.submit();	
	}
	else
	{
		document.cargo.cboPgNo.selectedIndex = idx; 
	}
}	

function goPage(pg)
	{	
		document.cargo.currentpage.value=pg
		document.cargo.action = "grouplisting.asp";
		document.cargo.target = "_self";
		document.cargo.submit();
	}	
function Add()
{
document.cargo.method="post"
document.cargo.action="GROUPMAST.asp"
document.cargo.submit()
}
function DelRec(cnt)
{
alert("Sorry, deletion of group is not allowed !!!")
return false;
 /*flag=false
 if(cnt>1)
   {
 var totlen = document.cargo.chk.length;
 for (i=0;i<totlen;i++)
	{
	  if(document.cargo.chk[i].checked==true)
	  flag=true
 }
 }
  else if(cnt==1)
   {
   flag=true
   }
 if(flag==true)
 {
   i=window.confirm("Do you want to Delete This Records???")
   if(i)
   {
      document.cargo.method="post"
      document.cargo.action="GROUPDEL.asp"
      document.cargo.submit()
   }
   else{
   return false;
   }
 }
 else
 {
 alert("Please select The Record(s) to Delete...")
 return false
 }  */
}
function fedit(str)
{
document.cargo.method="post"
document.cargo.action="GROUPMAST.asp?"+str
document.cargo.submit()
}
function fcheckall(str)
{
	var totlen = document.cargo.chk.length;
	var flg=""
	if(str=='true')
	{
	for (i=0;i<totlen;i++)
	{
	  document.cargo.chk[i].checked=true;
	}
	}
	if(str=='false')
	{
	for (i=0;i<totlen;i++)
	{
	  document.cargo.chk[i].checked=false;
	}
	}
}
function funcheckall()
{

}
</script>
<LINK title=stylesheet href="../../images/style.css" type=text/css rel=stylesheet>
</HEAD>
<BODY>
<form name=cargo method=post>
<input name=currentpage type=hidden value="<%=currentpage%>">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    	<tr> 
          <td height="30"><a href="../../welcome.asp"><font class=blklnkund><strong><%=session("Level_Type")%> Module</strong></font></a>
		  
	&gt; <a href="../menu.asp"><font class=blklnkund><strong>Administrator </strong></font></a>

&gt; <a href="../menu_lists.asp?BP"><font class=blklnkund><strong>Business Partners</strong></font></a>

		  <font class=bluefnt><strong> &gt; 
		  Customer Group Listing</strong> </font></td>
        </tr>
        <tr> 
          <td class="horzblue"><img src="../../images/clear.gif" width="2" height="1"></td>
        </tr>
        <tr> 
          <td><img src="../../images/clear.gif" width="15" height="10"></td>
        </tr>

        <tr> 
          <td align=right><a href="groupinter.asp" Title="back"><img src="../../images/back.gif" border=0></a></td>
        </tr>
        
        <tr> 
          <td><br><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="39%" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td height="300" valign="top">
					  <!--START--> 

<Table width=95% border=0 cellpadding=2 cellspacing=1 align=center class=boxbg>
		 <tr bgcolor="#FFFFFF"><!-- bgcolor =#304cbc-->
    <%cnt=Reccntr%>
	     <%if Reccntr=0 then%>
	  <td colspan=4><font class=blackfnt><input name=submit3 type=submit value="Delete" onclick="return DelRec('<%=cnt%>')">&nbsp;&nbsp;&nbsp;&nbsp;<font class=blackfnt>Check All&nbsp;&nbsp;&nbsp;&nbsp;UnCheck All</font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
	  <%else%>
  <td colspan=4><font class=blackfnt><input name=submit3 type=submit value="Delete" onclick="return DelRec('<%=cnt%>')">&nbsp;&nbsp;&nbsp;&nbsp;<font class=blackfnt><a href="javascript:fcheckall('true')">Check All</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:fcheckall('false')" >UnCheck All</a></font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
   <%end if%>
   <td colspan=1 align=right><font class=blackfnt><input name=submit4 type=button value="Add" onclick="return Add()"></font></td>	     
	  </tr>
		 <TR class="bgbluegrey">
		 <td width=3%>&nbsp;</td>
			<TD width=5><font class=blackfnt><b>S.NO.</TD>
			<TD width=10% nowrap><font class=blackfnt><b>Group Code</font></TD>
			<TD width=75%><font class=blackfnt><b>Group Name</font></TD>
		 <TD width=7%>&nbsp;</TD>
		 
		 </TR>
	  <% bgcol= "#FFFFFF"%>
			<%ctr=(pgsize*(currentpage-1))+1
		do while not myrec.EOF  and rowcount < myrec.pageSize
	     if bgcol="#FFFFFF" then
			      bgcol="#FFFFFF"
			   else
			      bgcol="#FFFFFF"
			   end if
						code=trim(myrec.Fields("GRPCD"))
						name=trim(myrec.Fields("GRPNM"))
						'subreg=trim(myrec.Fields("SUBRGCD"))
												
						if isnull(name) then
						name="-"
						end if
						
						if isnull(subreg) then
						subreg="-"
						end if
						'cnt=cnt+1
	  %>
	  <tr bgcolor=<%=bgcol%>>
	  <td valign=top><input name=chk type=checkbox value="<%=code%>"></td>
	  <td valign=top colspan=1><font class=blackfnt><%=ctr%></font></td>
	  <td valign=top><font class=blackfnt><%=code%></font></td>
	  <td valign=top><font class=blackfnt><%=Pcase(name)%></font></td>
	  <td valign=top><a href="javascript:fedit('<%=code%>')"><font class=blackfnt>Edit</font></a></td>
	  <%
 	  myrec.MoveNext 
	  rowcount=rowcount+1
	  ctr=ctr+1
	  loop
	  %>
	  <tr bgcolor="#FFFFFF"><!-- bgcolor =#304cbc-->
	  <%if Reccntr=0 then%>
	  <td colspan=4><font class=blackfnt><input name=submit3 type=submit value="Delete" onclick="return DelRec('<%=cnt%>')">&nbsp;&nbsp;&nbsp;&nbsp;<font class=blackfnt>Check All&nbsp;&nbsp;&nbsp;&nbsp;UnCheck All</font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font> <font face=verdana size=4 color="#000000"><b></b></font></td>
	  <%else%>
  <td colspan=4><font class=blackfnt><input name=submit3 type=submit value="Delete" onclick="return DelRec('<%=cnt%>')">&nbsp;&nbsp;&nbsp;&nbsp;<font class=blackfnt><a href="javascript:fcheckall('true')">Check All</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:fcheckall('false')" >UnCheck All</a></font> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font> <font face=verdana size=4 color="#000000"><b></b></font></td>
   <%end if%>
	  
	 
   <td colspan=1 align=right><font class=blackfnt><input name=submit4 type=button value="Add" onclick="return Add()"></font></td>	     	     
	  </tr>
	  </table>

     <br>							 
	<center>
		<table border=0 cellspacing=4 cellpadding=0 %>					
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
   </form>
</BODY>
</HTML>
